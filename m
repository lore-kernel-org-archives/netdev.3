Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776138236E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486278; cv=none; b=DOL0iLpUtFVXQuI+kNqP4awEpEnsC3Lsdx7XDEx2ULhL7Bo5QukgA08Q8dsx6Hvh48UOdAKqRigrUlg/F6Iw6CR7N2NPlcoS8RwF3kEckyzkN+C36fjIFAAwHAu84hh78YAXRRlJPO2e872dijATJcEVc9qOhXBPNc//NMzK13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486278; c=relaxed/simple;
	bh=MbI2CAipFQlkcCXtD8/pXznz9amsVPkQ4vG76YYrVuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdUhqZ9wxltnQxlQAqC0+cIocl5IfkyP7gVtSzUyjWHQbgsqv7+OdPpbKN5YF0cli5pyMeOlUBZvORGLNFt5hZttBQ5iNYkql5fNd1D+zUoTKT2Hm+NK87YqweJpyB3bqvPo9+tdMkjlmAhE/6o3BCYpnyhl3JJStahSXGO9GN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3UJxVuF; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3UJxVuF"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso2521675eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 22:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486276; x=1791091076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYPvDSVXM3c2xr1UquxO/x9RKs46Xl+77uYFO9CJ7SI=;
        b=G3UJxVuFVx24fgI1L0dk4eZXNIXiHMRal4tSMZrhzUkW3zPV+Wrlt4Q0+XXWdd3BfB
         h1/0AKHDnfFC5pg8OyQZMRgeR1g+IrK0Del2SKMdDEJFwuaPSVj8ITzSVU0Qsj8n7BU5
         xe9zGjwdIxfXBRVY8cunGBJ1BkT5droXAe/nEEX3KYZoKCLS1mczgTB0csrIhyQytpnp
         y+EiA2ZqHy4i0VYtxsHRY1xvtRHWKFo7H4IWJhPosknCSD8DHCbdO0UyX/zzFRb+B4rG
         yztUSgPWcZ3pVMahW/Wox1ajKLyGDu3XzjFLTL2C7LuAWRPW88cupuvPaMWyElNHj28n
         Dbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486276; x=1791091076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYPvDSVXM3c2xr1UquxO/x9RKs46Xl+77uYFO9CJ7SI=;
        b=XyPqZfiG8/0W/jUvv3j7jTgQYzzdplvm/QoaUYyUHtjVv2knSr0dkJ6xodcGTPyAUu
         OO+MLjG0oR2uwuVbDu83hZpgYg77MjULMQS7npZj4XCc5cqussC5+ncEQFxxGX4TWtEz
         AmcaZUUczDI7Jt5gJPTy5mxEVkzSU7APG61IF6MggVuS1BNkhEXgcDY5an/g2WSf4GCz
         k/O5tuU55/tfR7Z1H1Gk8MfhAVLltbmKzEGR/BUYk+O4TRG76/znqNmzQJ2RrZsfrbwb
         YzhR02W/23ErtDUC+ZhGNg0OK6PvDDqSsm/M7szp6NsJ21kc83RM+Z9rdqn4+9UcjfBk
         NeKw==
X-Gm-Message-State: AFuF++lBrnQyQk8DesW7sOJGtrVXhCxjFXlq+obOeOoEm1o5XdOrWm1G
	R3PM2HjNjzX9mrVA9HKDQQWHigbXd5QO0HGuwA1KqFtBjp/K6rNkyHVP
X-Gm-Gg: AYBFou0cMOVq3l9NT5RaCHaP4BSOW/sxS6S/J5lKTJO2869dVu7kep3KytNdXdUY/+k
	NUy9sbiTdoJzqXQz3R23sf4QaUgwU3l4pG3HyDBvwNNmE2CSkQxeQhyWQ2TLBes3SWuJPvAc19l
	uPxd5QaybFC930CZkMoWKbxEVkVXBSHipp/qE74stdzppqTWCWwSgGv610qufozIh+5uv+kWbQm
	Oj/lI3meUnFLI/Qd6k2vSYeDmNKTm/KLU+S88CW9DcgmvuT1jqbRPNlE/zx+GUKbsJNyDKCF4St
	RZGdGGL3m7O3/cdBSZfjNA2eS/evVaHiZpx6Iv/mebVX3YpnRGMrtByhUzbydncnj7Y6ZGOzXt8
	ePOElUw5yRai9l1KYi/PpPfasl6QC38/U001lla+B++BHH63AaWfUqwg6RrBCuBimzwIzlbXOtU
	Bvr4IoLDobF4v5H5RmFntr4BRIiAT0rPvShM7FMcPBelHnUUeO0j1RvudFE6u9jxm4qPn7IHleh
	j7cjiN4AJWlBRyRHhATFzYC3LL0EaJCLHLo0aEF10HJAOBbmgAp3nUeIcYCkFJE+IrVLIFnDPtH
	XBkLlMZC2rSI3emwIxC3nFTUmkxq4IEMgxlFNiAGnhb6VKAzLzCRgTBrrZHIeVpjbxi3GWiNrA=
	=
X-Received: by 2002:a05:7300:cf87:b0:343:cde7:15e7 with SMTP id 5a478bee46e88-343cde71e6fmr2118832eec.0.1790486274760;
        Sat, 26 Sep 2026 22:17:54 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm18602721eec.19.2026.09.26.22.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:54 -0700 (PDT)
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
Subject: [PATCH net 1/2] lib/dim: fix 32-bit overflow in dim_calc_stats() rates
Date: Sun, 27 Sep 2026 10:47:42 +0530
Message-ID: <20260927051743.71460-2-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927051743.71460-1-jain.sm@gmail.com>
References: <20260927051743.71460-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dim_calc_stats() computes the per-millisecond rates as

	DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us)

where nbytes is a u32 and USEC_PER_MSEC is 1000L. On 64-bit the product
is done in 64-bit long arithmetic, but on 32-bit architectures long is
32 bits wide and the product wraps as soon as a measurement window
carries more than 4294967 bytes (about 4.3 MB). The same applies to the
packet and completion counts, although those need more than 4.29
million packets or completions per window.

A DIM window spans DIM_NEVENTS (64) events. Drivers count events per
interrupt or per NAPI poll, so under sustained load a window can easily
carry more than 4.3 MB: 64 full NAPI polls of 64 MTU-sized frames are
already 6.2 MB, and drivers such as mtk_eth_soc count one event per
interrupt while NAPI keeps polling with the interrupt masked. On 32-bit
users of the library (for example mtk_eth_soc on MT7621, bcmgenet and
bcmsysport on 32-bit ARM, or virtio_net in a 32-bit guest) bpms then
becomes the product modulo 2^32 divided by the window length, and
net_dim_stats_compare() makes its BETTER/WORSE decisions on a value
that has little to do with the real throughput.

For example, a 1 Gbit/s link at line rate that moves 5 MB in a 40 ms
window gives bpms = 125000 on 64-bit but 17626 on 32-bit, and 5 million
packets in 2 s gives ppms = 353 instead of 2500.

Widen the products to 64 bits and divide with DIV_ROUND_UP_ULL(). The
results are unchanged on 64-bit.

Fixes: cb3c7fd4f839 ("net/mlx5e: Support adaptive RX coalescing")
Fixes: 4c4dbb4a7363 ("net/mlx5e: Move dynamic interrupt coalescing code to include/linux")
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Found by reading lib/dim with an LLM assistant (Claude Code, Claude
Opus 5.5), which also drafted the fix, the KUnit test and the
changelogs.

Tested: the new KUnit suite (patch 2), on mainline and on net, on UML
i386 (fails 4 of 7 dim_calc_stats cases without this patch, passes
with it) and UML x86_64 (passes with and without it); W=1 builds of
lib/dim/ for UML x86_64 and i386, and a native i386 vmlinux+modules
build, with no 64-bit division helper references.
Not tested: 32-bit ARM or MIPS builds (no cross compiler available),
and no run on a 32-bit NIC; the traffic levels at which drivers hit
the overflow are derived from how they count DIM events, not measured.

 lib/dim/dim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 97c3d084ebf0..7f3eebae73cb 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -69,11 +69,15 @@ bool dim_calc_stats(const struct dim_sample *start,
 	if (!delta_us)
 		return false;
 
-	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
-	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
+	/* u32 * USEC_PER_MSEC overflows a 32-bit long */
+	curr_stats->ppms = DIV_ROUND_UP_ULL((u64)npkts * USEC_PER_MSEC,
+					    delta_us);
+	curr_stats->bpms = DIV_ROUND_UP_ULL((u64)nbytes * USEC_PER_MSEC,
+					    delta_us);
 	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
 					delta_us);
-	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
+	curr_stats->cpms = DIV_ROUND_UP_ULL((u64)ncomps * USEC_PER_MSEC,
+					    delta_us);
 	if (curr_stats->epms != 0)
 		curr_stats->cpe_ratio = DIV_ROUND_DOWN_ULL(
 			curr_stats->cpms * 100, curr_stats->epms);
-- 
2.43.0

