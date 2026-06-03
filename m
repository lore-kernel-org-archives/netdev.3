Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12663D566E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504736; cv=none; b=tLi8M3HOdnnuHKoLyvi4Yb0iGgonjYX53t73fWEOpe9kTn99j4IO+4KtU2BLRd5+xQEnlP+JfJqG0z7nwnXC2zHIUw32rxjHYfXDQG3sxb6uh2VmiIPXU6jH9znShmjCCPy4GwR2DvnzjXNrkEERHi067M9dVvGVi7DHJNPkLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504736; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq/fc8sbqScmR8/DhqjrLdT4jjLl0xJfPK/mPAaU6IEK/jWxOB7CoyxeMNCLkmON/Vz69AX0Qd8PMYTcIZLzxovJ1ohyk670iyezahUaJytpViLKnlz9bT+CW1hSHMXRsirZh8RzLEmodcbRNSdxnV+QBEaVyF247ctQz6cHOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ob+GOF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ob+GOF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso41620395e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504733; x=1781109533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=R1ob+GOFGbA8grfK3rS3WPnissX1XhOAzMRICSepyUSuJdAunS4UUXyFfJwrxaMdxo
         q7x8Rz62nl3ubmIJPrSesQ4BobY0rjmj/JpJriPh5kvAyl9VPt7Xam0dN0SlIwhKApUM
         0/hBuRyfoAL1vWEcEJTvIALrWSOd0ERA+V47GQs+abXl8jkuoOfr0pezZXy2mw79Qi/A
         h0FigVtwIJ4630Bm55J/TWp9YsDEH/cbP9Tm3YPXEQQ7Kr36uceOEc+NK8Vs2BZ/83AV
         /hFPt3RtoMRLvmG2tKn8GwlE/bLACN/5v9OOe74+I/LMjtYQfazKTJXGI3GttcPX7fGf
         qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504733; x=1781109533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=RqD0FuzpG1Z0zsPptPb+eoxwmyfeOf9ZKOy/O6Ya+BjTJve1GM6BR0HYmtaNuaMRWC
         Muii/B9TKZfgSYM6eGFTWi4xlYFUV3WcJi5KDzaqLV/huIr9muPINhaDXgbc2xvggMUb
         MrYyoY24BNHyXpIdA/FwI7UuJxyusLz0i+XkZ/nfqf3+YbDyKKitPT/CAvDJhvPXM1On
         abDcuLe6+p0UkG5hXChXy0WuPqnmDjVe8XH7m326aa+wtAFxuTXogEVkmaIGeE3aQayk
         fz7Q7Zw48cexBoGNmwvoqXwP72W7v80TT2IzbAi8oGtiTbqAtzc7J31eZjZIKyybiKQP
         DC4A==
X-Gm-Message-State: AOJu0YxpL8lA5kMpfrm63c8PsaBhD0eUWPlCpq28gDcSP4jaDQBSBWCY
	P9UcpgSrZBYDsXnxWzFnPZsuyI7ciOz+XqX0RljUfEBQCdSQmRU1xXay4eDdpwOUgrF+CQ==
X-Gm-Gg: Acq92OGRVe0TaqahOeE/c4bZFngtmL8HCyheK1kxrz6sSC29PixBIvmhd7HnDEe0P+e
	JGX37rT/64kAB8ZFNV4/k1+sl26qqUs39ONdPpAldJe5rN643f44zxuEg2phRkiOjN4HW0praMg
	HxADie3U1q7fzzsLdr9PTTMUYVnlnJfVXjR0/zWFaulxh4/w2oDIKWN+hxU7EeJYNfwJ0aZ2qj7
	KLdKEgXKcfj7pfd6rj1jFCDeDy4K/qR3OiG81oG3AixZS1dJrYr8flKwqEByx4jhuEgSRIXMPmd
	bUI9IPxcIVqPKvHvh5GbC3TH/HP65HmQ3w2R9wt59Epf8bzvvYMW7wgT9ND/jC9/9yEnN1QGyNs
	X7LfXL4GD+hZxLyGnCwOs49ryGKPD/o2wKcugmWXpPeD/pyZQE6qraHKed2mLC5e54PVhXDFHg7
	rtVk70mplY959OAgVxxL/cDQ1jKiVKU2oyi/SZ3JIkqIZ5kW+GKBF8FgmcFD1mj2L5Y992V3D3y
	KFApw==
X-Received: by 2002:a05:600c:1c1e:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490b5fe65a6mr69071435e9.28.1780504731298;
        Wed, 03 Jun 2026 09:38:51 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a8632sm7261405e9.8.2026.06.03.09.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 09:38:50 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Wed,  3 Jun 2026 19:38:51 +0300
Message-ID: <20260603163851.18058-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602155210.90987-1-leontyevanton1995@gmail.com>
References: <20260602155210.90987-1-leontyevanton1995@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity. The
physical address is reconstructed first and phys_to_page() is used to
obtain the native struct page, with offset_in_page() added so the
in-page offset stays correct where PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g.
arm64 with 64K pages). The page is then mapped on demand with
kmap_local_page()/kunmap_local(). On !CONFIG_HIGHMEM configs
kmap_local_page() reduces to page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v2:
 - Reconstruct the physical address from the Hyper-V PFN and use
   phys_to_page() + offset_in_page() instead of pfn_to_page() on the
   raw PFN, correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).
   Reported by Haiyang Zhang.
 - Built for i386 (CONFIG_HIGHMEM) and arm64 (64K pages).
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..2038d9f5c9f9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = pb[i].pfn << HV_HYP_PAGE_SHIFT;
+		struct page *page = phys_to_page(paddr);
+		u32 offset = offset_in_page(paddr) + pb[i].offset;
 		u32 len = pb[i].len;
+		char *src = kmap_local_page(page);
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0

