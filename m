Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C835AC07
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486272; cv=none; b=NPVOayRq9fnpQa4FnsdcGqlkNT0g4UMj4+l+1cJcFzvkhi8dbxdyhD8E5lSVbl1O2XqbkNaDRDqyY50QIUkI6dM+MxxYRr7WTubR8DXGAg+PVWgXBFPvgPYpwgzBI1OND4Xi9SXWjGB6k6iUczaXGnCy6omEIB5Vcl4mj47X4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486272; c=relaxed/simple;
	bh=8C890wb6iVq5DP/8JE563fysfv8fOozfUheNIOh4oDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNxWJbBefICYxNYzFqbYxi+THcUN2NgrpeUYJ8pmDwiPIqIrXNEmR816oy0ZeaB2DofOBGExdlhMYMiEgIoq+L6Zg+wNNOGOS/v8Ut4672J/KFMRX3cVYGnQ8pOeoxrxN2adGLnMt90bnoOLxLM6yRDBWtd6X4vL0TY0yxOeg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL8fFIPm; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL8fFIPm"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec3097dso88454eec.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486270; x=1791091070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9DTwN6BTCjhBQ/V2aTbf0gWJNiCrbevOZI9jXtiy6E=;
        b=iL8fFIPmiWju6tMUKkfjgJ8cm1CjFfZ+bwbXMZVv4qMTudYCCkfH0+Z0kxClpXp7tR
         2EMn1/74CsnrbrDNKQ9vqkbH25J6YcLy86paWUhCxJXfqpqMYIOfS5DRU2F/yAltKNhS
         niTo6G0QWrJKMiuuUESdq1MtlK0qVdNkRLw7UxKCnlBMcHFYz0gYEQp8hvyXNkKLLMC1
         M+8V6Ac0xdIKZe093rwMq/YW+qqilWY2KVbm/OVtZHoBW3WTijZxnC6sXnwEp69yvyGB
         os8U0EKkyBbt6Nv5WlTGXNP7q1zwNWHEaLHNUMGI/gZ9Op/fFdsJcNK9xhkN2PV9HDvr
         R/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486270; x=1791091070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F9DTwN6BTCjhBQ/V2aTbf0gWJNiCrbevOZI9jXtiy6E=;
        b=hiMDuhcM2cxZ59YrJbXjgJTIFNt+sLSzt/G0jjKmOvl7zJxECkBlEGEkxZHjNQCn5N
         plM+AQRKRfmVHlTqRJkgniUlOoSjDT1sAqqZEe2+4wqpHWgZQAIB3dC9hLimFTTDfATN
         QcjEiQXyL2jjgnmXrTykNyEnwXV+X2Lw/C5wSBzaYOF01d2TZWI3MSP3Ok45LvJTXSMR
         VMXxmmsDJiGxAYfkGCCh0U+xEiLSTZVjlNGWGhG0ZASscvZFuKk/epFNQTTjo9Q1j/Q8
         PfIpH8ubCQR2NxiUyT+khbvsmcmI+vS+15GLijPJs3IEtxvx6Cjmz5U3Gr57mFJL/6tg
         CdAA==
X-Gm-Message-State: AFq9FYKJjVO9/YjZ4jEBKwiTUmB5GA/LW9WI2jQyFWOa7hVmhc1/H2tV
	ZjPlG/BLYIhmsVdbtxWsfso/RiFUXuR8DJzOgk4vzubQtm22nqF+gcO0
X-Gm-Gg: AYBFou26hQyTV8vSYEY76rslFDeu2kpxDA28Kx/LQJ4KZC0jU9fOH7babg8GrUIH3Dc
	sVlSY0kOy+Kt9cEUzhMG7TqbMDpyE+Y91m/tjxsN3XQhV0W4bKywcFZCzbZi9gQDdPvEX40GP4E
	MjP/smjgLABf6wd34ueIkh1DqLRpzfJi3egJWv/MM2dfx30pJaJmDHrJnj7qS+ShA2VeNgkG0P9
	ajACXMyjOH284k4s53lVr1PQJItceLJmFOcBEIpZg5pPitbKzXbVx+/wHithWZGLyj4nQlHT24n
	4QLBcE2Rg58aXP6wQVQjePHNx3oZPvKpf1QuEDCRdswsQX37Wd3tW2jd9mYPhZbnyUhpioM2Uez
	SejxXRBQBIGmRKSAebJose5fTooht8a+6RD3+eRkMpJMJpyuqMCcePO1VKsXYPFFlwQGdBBvexA
	+DqguUn0W4z2qhk/L8Pf2I2y+xiFDw/JcYkeGXecYIbUdG5NgXuwAJ5v08ofRLfLkRZZvgY0r1t
	hzniAwFkMsFMd6UCeZZYu2o2Fx8TLNdg2d8ZS1aQvcvQxF1ZYjiIqtGb3A8y5TD65oBNu7ahOG7
	Pzr0qz4QJwtMSAbxIqkXCtbUAfHgs6351i3iPNpposejAJdFSgUhtpTn5c/lU03kc/ISAW//Nw=
	=
X-Received: by 2002:a05:7300:d20c:b0:339:7b3b:236d with SMTP id 5a478bee46e88-34270ebf074mr4728723eec.15.1790486270217;
        Sat, 26 Sep 2026 22:17:50 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm18602721eec.19.2026.09.26.22.17.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:49 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tal Gilboa <talgi@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] lib/dim: fix 32-bit overflow in dim_calc_stats()
Date: Sun, 27 Sep 2026 10:47:41 +0530
Message-ID: <20260927051743.71460-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit kernels dim_calc_stats() multiplies the u32 byte, packet and
completion counts of a DIM window by USEC_PER_MSEC (1000L) in 32-bit
long arithmetic. Once a window carries more than about 4.3 MB, bpms
wraps, and net_dim steers interrupt moderation on a meaningless
throughput value. At 1 Gbit/s line rate a 64-event window passes that
size when there are fewer than about 1,860 DIM events per second,
which is common while NAPI keeps the interrupt masked under load.
32-bit users of the library include mtk_eth_soc (MT7621, MT7623),
bcmgenet and bcmsysport on 32-bit ARM, xilinx_axienet on Zynq-7000 and
MicroBlaze, and virtio_net in 32-bit guests. The overflow goes back to
the mlx5e code the library was moved from.

Patch 1 does the multiplications in 64 bits and divides with
DIV_ROUND_UP_ULL(); the results on 64-bit are unchanged. Patch 2 adds a
KUnit suite for dim_calc_stats() whose large-window cases fail on
32-bit without patch 1. It is part of this series as described under
"Co-posting selftests" in maintainer-netdev.rst.

The series is based on net (a7bfaba4823e) and has no dependencies; both
patches also apply to mainline (fd179f8a05be) and net-next.

The bug was found and the patches were prepared with Claude Code
(Anthropic), model Claude Opus 5.5 (claude-opus-5-5).

Tested:
- KUnit (CONFIG_DIMLIB_KUNIT_TEST=y) on UML i386 (SUBARCH=i386):
  without patch 1, 4 of the 7 dim_calc_stats cases fail (many_bytes,
  bytes_32bit_limit, gigabit, many_packets); with it all pass. On UML
  x86_64 all cases pass with and without patch 1. Both were run on
  mainline and on net.
- W=1 builds of lib/dim/ for UML x86_64 and i386 without warnings;
  dim.o references no libgcc 64-bit division helpers. A native i386
  defconfig build (vmlinux and modules, DIMLIB=y) succeeds.
- checkpatch --strict. Its "does MAINTAINERS need updating?" warning
  on patch 2 does not apply: lib/dim/ is already covered by the
  DYNAMIC INTERRUPT MODERATION entry.

Not tested: 32-bit ARM or MIPS builds (no cross compiler was
available), and no run on a 32-bit NIC. The traffic levels at which
the drivers hit the overflow are derived from how they count DIM
events, not measured.

Shashank Mohan Jain (2):
  lib/dim: fix 32-bit overflow in dim_calc_stats() rates
  lib/dim: add KUnit test for dim_calc_stats()

 lib/Kconfig.debug   |  15 ++++++
 lib/dim/Makefile    |   2 +
 lib/dim/dim.c       |  10 ++--
 lib/dim/dim_kunit.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 3 deletions(-)
 create mode 100644 lib/dim/dim_kunit.c


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.43.0

