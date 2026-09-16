Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131304B0E58
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587470; cv=none; b=Qq5DtLAdrWhXmFzj15MjhPs1FxsStBBSqZDlJeQHjaM/1coIbFTpoxKNRouO9GtXl82IJNAM+ClvA2cdUyxg3styaWuOq1Tci2nwpFRGIwqFT9LTjD+fqHHJgbglhD/Z22Kp/CYxtAY6N4ZNU5HMa2COpoZwR+qBnz6RPBf6/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587470; c=relaxed/simple;
	bh=B4CPVh+5rWhlU/pXoDIh36pS5SijulILYduOtOart7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6SxstSkPMJKRDHEnR5Cz4Z6XlWKmIPUMZJ4/dGbkPNpltD0BWOn15dZATebSuiIe8iObwq67H1Sh3aTVa+5PVpIpnz+6KrDDpzSAGkezBGTU1K41Zp1XDcP2J8DY4At4XplQ4oR443CHK6wSJFWPSIHuh5KXQXfzSHoTItStTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/2PxljE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/2PxljE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so639855e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587463; x=1790192263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SzyobERMhWoAi0wsAy/lTdmDWo3eJYL4BsZertPOTA=;
        b=n/2PxljEjS/Md4Ser2yRH9lhE9iKMhttyqFaMU3TFqeZl4lcLqR24rkIHkGQtAonVS
         tBqZvRAkAhBYTANhqAb8nlUPwJJHLLSz9cb2ZI/baUJVp3GRXPGOqxbRw4HUTZHO+42T
         vAXZMagjN+qlONZM5TrGKYmgyaBA66e8vSWDjXTeCjDsiUT4UYn7XUrNavNFjI58kD4P
         rio+W/NCTNH0NEYpyjgFqQP/v27UnI78A1dl9GLi/8bl7ppRxas3EAxKgdHWlasQca16
         wAf8uKikRAfb5PMpiXB+E3DelG15WtPKU78G+GUd7dgtWPrdQkw/lKhOjS6SBp2gM5oQ
         71Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587463; x=1790192263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SzyobERMhWoAi0wsAy/lTdmDWo3eJYL4BsZertPOTA=;
        b=TgYsIlP9AQQgU1WMPqKtJK2UIm4vFHwP167xZeQUkgSrARGFmFI2zO51Hmif+P526s
         Ju7WQpWVyEmyMIRV4971wHEiqQaIObaJcLF/tN3KXoK84s8S85gXvr5hQJFGkTFe1cQ3
         hk5XDQwXGHv9aTW7mMyWIroxpQZfVHPEqDmEgJcQyvKKVubeQnlulecJPVnPjoWSjBQi
         rVKBLj+uCG5WXlLQJX+VHDG4tFDUKbKzoiKI2nxQL/UEwEyedWzXymwVnlU6NqeN1SEY
         7wdVxngl8JZOfBZyzlyXzghQQYK6h/BgcjliUPdAl/isXv361bHgDf7BQjViiy5/T4U/
         63EQ==
X-Gm-Message-State: AFuF++nDVemX6Si5x+lG7FLjyJEDrkrrpinORh7199zHbz9J9gS97C4q
	V6/PljoWSybnypI1k2hzPjwJA4MXs/t2pjZDK3xxhJb4jTr+/tHuMWKPuvQzikbyKO0=
X-Gm-Gg: AYBFou3kJzn0JubZSa1LJtSK11nm4r4scEo2wklmx3B0M0P8SxZSeiwi+fEpbVd/lEg
	Brodjlz2/y2oXSiJLTG7GG6RdXqm7Mo8s0zokbsppZu/AyBv1sqjySaBfniZiFXoXV5OWb15vao
	kziMsRNdPLZAk5emNRRCHIOwtZ0yJ5gC59PmltIYrELunuU9sryJspRPI4qvr+TgK4wLoLQ/ZTa
	Uq9CGoTVbBh7KNno+/7Eg26VglaY114AaoQucSpRY6zcV6osrSUCexYqOAuQ0gVUWb7QittcMIX
	fhDUUp9NhO6zBt3y2phmUouhZdQ33JwirJKGKca9UOSvmsZBA2eVir+D3KXIFSMOKFr5j8Gflz7
	LDrey87p5mRhiPPCMhuEAIN+uZJHRxC9dCgN8Xx917Ikers8bSQ/thNhRAEI4B+ojLxTKa+of6Z
	67TELC1aXHL5HM1DevkWfnvceHUP1pyoC74YVk8skHT6efyrhnaXmYqKNJtGEk01c=
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr47340035e9.10.1789587462833;
        Wed, 16 Sep 2026 12:37:42 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm12936105e9.13.2026.09.16.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:37:42 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v2 3/5] net: account per-CPU netdev stats to memcg
Date: Wed, 16 Sep 2026 22:34:47 +0300
Message-ID: <20260916193449.2552039-4-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193449.2552039-1-alishmery18@gmail.com>
References: <20260916193449.2552039-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_alloc_pcpu_stats() allocates a per-CPU stats block with plain
GFP_KERNEL, so it is not charged to the cgroup of the process that
created the object it belongs to. The netdev's own queue arrays, ethtool
state and NAPI config are already allocated with GFP_KERNEL_ACCOUNT in
alloc_netdev_mqs(), which leaves the stats block allocated alongside
them as the unaccounted part of the same device.

Make the macro use GFP_KERNEL_ACCOUNT. This affects 34 call sites in 25
files; all of them already test the return value and propagate -ENOMEM,
so none of them has to be excluded. __GFP_ACCOUNT only charges an
allocation made from a task in a non-root memcg, so callers that run at
boot or from a driver probe are unaffected in practice. The devm_ and
explicit-gfp forms of the macro are left alone.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1f0710eef185..7c659012355d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3171,7 +3171,7 @@ static inline void dev_dstats_tx_dropped(struct net_device *dev)
 })
 
 #define netdev_alloc_pcpu_stats(type)					\
-	__netdev_alloc_pcpu_stats(type, GFP_KERNEL)
+	__netdev_alloc_pcpu_stats(type, GFP_KERNEL_ACCOUNT)
 
 #define devm_netdev_alloc_pcpu_stats(dev, type)				\
 ({									\
-- 
2.53.0

