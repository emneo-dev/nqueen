const alloc = @import("std").heap.c_allocator;

// Interpreted as (column, row)
const Queen = @Vector(2, usize);

const Context = struct {
    const Self = @This();

    queen_buf: []Queen,
    n: usize,

    pub fn init(n: usize) !Self {
        return .{
            .queen_buf = try alloc.alloc(Queen, n),
            .n = n,
        };
    }

    pub fn deinit(self: Self) void {
        alloc.free(self.queen_buf);
    }
};

// It doesn't look like this exists in the standard lib
fn distance(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    const m = @min(a, b);
    const M = @max(a, b);
    return M - m;
}

fn is_valid_placement(ctx: *const Context, pos: Queen, idx: usize) bool {
    // We don't check for columns since we already pre-checked it
    for (0..idx) |column| {
        const checked = ctx.queen_buf[column];

        // Check if on the same row
        const row = checked[1];
        if (row == pos[1])
            return false;

        // Check if on the same diagonal
        const c_diff = distance(idx, column);
        const r_diff = distance(pos[1], row);
        if (c_diff == r_diff)
            return false;
    }
    return true;
}

fn nqueen(ctx: *Context, idx: usize) usize {
    var result: usize = 0;
    const column: usize = idx;

    if (idx == ctx.n)
        return 1;

    for (0..ctx.n) |i| {
        const pos: Queen = .{ column, i };
        if (!is_valid_placement(ctx, pos, idx))
            continue;
        ctx.queen_buf[idx] = pos;
        result += nqueen(ctx, idx + 1);
    }

    return result;
}

pub fn count_valid_queen_placements(n: usize) !usize {
    var ctx = try Context.init(n);
    defer ctx.deinit();
    return nqueen(&ctx, 0);
}
