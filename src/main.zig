const std = @import("std");
const nqueen = @import("nqueen.zig");

pub fn main() !void {
    for (1..16) |i| {
        const start = std.time.microTimestamp();
        const result = try nqueen.count_valid_queen_placements(i);
        const end = std.time.microTimestamp();
        const t_micro = end - start;
        const t_ms: u64 = @intFromFloat(@as(f32, @floatFromInt(t_micro)) / 1000.0);
        std.debug.print("{} -> {} ({}ms)\n", .{ i, result, t_ms });
    }
}
