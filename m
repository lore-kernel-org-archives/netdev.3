Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB97384CEA
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729738; cv=none; b=M0g/wWtQrENvF4PcokBclobe0no1Njiq1NCa6UjsChGoJI5AWTYxTt9+s+5B8aNPg8KIscJJWPCu++D2X3ukvCDCn+1goXnSSUGplKdVodsnIzkPxzgxZyc3dxyvDs72lr/1d2F95oj6vOaY1w1GcB8sJMg4A3hl2qSbqAj6fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729738; c=relaxed/simple;
	bh=JUBeffKoSLYh6pymOpycF+IXhAZYMupJRA0vzC9HDhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8mHdob91TdJ7hrONnyeoarcFdXOhmH7d7GiNB9UFYSx/90DLQH3KO6gIOtX6oxiOFTXs49wgv8Gv1bcFz+nByR3B/f0Mw9y1rBgfEo0Ipn6DTRc8FZL6gvni9xJBtotHDjg6HfImUF+VHCC8AAItiAgCgeOd74NPdXzMpTPmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSjq7XB0; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSjq7XB0"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eca9b7114so1450166a91.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 21:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785729734; x=1786334534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jiRGIoR545kfnxFKjhFstQtMtybFdgRo2V2TxbC42M=;
        b=kSjq7XB0VigcVU7jBKVGonfBPmsYwvOe8oG/2NgHPEGVqkZ0Z0iutx4mLhjgase8zc
         icpRZ3YWVjbakeRkaydaQPNTAJnFEQCVOqw/wLnKawsVJa6Ziva4IqULyngM8VswYRLD
         K46m6G0dk23O0HcAZssf+l4PFVzgAi5Mwez9MeKd/+GXxZBLrkdgY3gsNcw29pgi0yiw
         7Dgy8xcXI0phRk5aKKq1JhJ+Rg1ZP3gzS6pP9XVfMlcoad9+8W6t2L0ljplXqQUg0evK
         Ia1g8rcPM94VS0ZqFvRTmBjUA04Mo0Q8qATGY4n3xJYfpKa/T8r2qAGG3MWXlE5Mkm3E
         5YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785729734; x=1786334534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jiRGIoR545kfnxFKjhFstQtMtybFdgRo2V2TxbC42M=;
        b=VarB0xTN9nGSmeAIwLX6Dgh1TjaYkNLU4BRgIUIduSzEXJuBAGdjjGpSLBywALEsO6
         ZBIRppx/W9r9yWCEcnW59ARc46XkoWKcRstJTKKpw8/DQj2dJ+4B7YaPzJP/WzJDOSzI
         PWwKOs0xh/uEP/Y1hBuREQ6JfHn3D7HDZgosney7DBt77smrv1wNli8Kpky6h3P/lFSm
         L4m79dx8dr6I/CfPI4xc4OML2u9mQSrW5MJTQ6xJvJIr0Vyk7mrHYbbC+OzKM6koS+iK
         j4545oPykmcuC1k6+1/NfwCJbO13Qiy2FrR2Ha/ZFPeOrp/qHNpU4YOM5BidYlrBi3Qb
         xlbQ==
X-Gm-Message-State: AOJu0YzaZD1hZ5hErdQ/xp4CoG7Bs8CZBR+PZAD2LpOJ1tCPC7iNkNQl
	M5UbRP6oan1d4Y/cRTzOMO0sYgcFcLj/yBPUJAbD3jicQXW2KkYG1tBy3YrsWvEjeyLowRSM
X-Gm-Gg: AR+sD11+8NHzDPx2Act+9DVK3wt4ZewB693I5NyRFaGjQhYQpK+CyIPSRmvFeFTR8VD
	T4H2xQM00MQP4uqLMvpzKc7wsOoufq8Hp/cNUM3Yl8jBXT32V9o2iR51viFpmqWyS7xiVcDQ3KV
	2U666ylqJtThGTGfpWoQ14sCHNj2nxEORpeK+dWOP/kFrSJYIpFz5xWarbacBFiApTM02+QDVj/
	RJLxf3zD9ITw9RX7A3/3MLx11CfX4M9FSCMEqNcTZPKU78a1xyyPqYNevMl/y+8/aia4l2uBAXW
	S5Nf8Bg4PXzeykzoVjc3rvPIJJxj5K1rZUEATDV/aMRgSOBBFmukW6CR/ZZGfvg29iQPRlysOsG
	cvuwrzWll/lOdPalLESuHf1oRdjAb/tQh2M+Ldn5IF37hGOM2FsSVJrmfV9I+3HaHoGRlLBdAwm
	X88vJVjk22k2XpMOuudGaGCTEzfLHMpVQ792LHF8FXS6kcMVTA+fJwLp4K4diVdYgzKZxH8BWiy
	r7Z1a1DiZW5sXc2EU5+r0PXx1o=
X-Received: by 2002:a17:90a:ec8e:b0:38e:7297:a931 with SMTP id 98e67ed59e1d1-38fbc595d3bmr6870195a91.43.1785729733936;
        Sun, 02 Aug 2026 21:02:13 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a47b7sm3317983a91.11.2026.08.02.21.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:02:13 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	chopps@labn.net,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] xfrm: iptfs: fix runt reassembly panic from short inner tot_len
Date: Mon,  3 Aug 2026 12:01:54 +0800
Message-ID: <20260803040154.3024160-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the start of an inner packet is split across two outer packets
such that fewer than 4 bytes land at the end of the first one,
__input_process_payload() saves those bytes as a runt and skips the
iplen/iphlen validation performed for in-place packets. When the
continuation packet arrives, iptfs_reassem_cont() only requires the
declared inner length to be >= sizeof(ra_runt) (6) before allocating
the reassembly skb with that attacker-controlled length.

However, __iptfs_iphlen() always returns the fixed minimum IP header
size (20 for IPv4, 40 for IPv6), so for an inner IPv4 tot_len in
[6, 19] the header-completion copy writes past the declared packet
length, and the subsequent "ipremain -= copylen" underflows to ~4GB,
leaving the payload copy length bounded only by blkoff (up to 64KB).
At runtime the skb_put() tailroom check turns this into
skb_over_panic(), i.e. an unprivileged kernel panic (DoS), reachable
locally via userns+netns IPTFS SAs and remotely against IPTFS VPN
gateways when the decrypted outer skb is linear (e.g. AF_PACKET taps,
tun/tap delivery).

Align the runt path with the normal path by requiring the declared
inner length to cover at least the IP header size. This also subsumes
the previous >= sizeof(ra_runt) check, since the minimum IP header
is always larger than the runt buffer.

This issue was found by the autokbug dynamic kernel fuzzer at
Tencent Yunding Lab.

Fixes: 075694765446 ("xfrm: iptfs: handle received fragmented inner packets")
Reported-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac26eb..f543ae3b49b3c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -820,8 +820,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 		 * allocate an in progress skb
 		 */
 		ipremain = __iptfs_iplen(xtfs->ra_runt);
-		if (ipremain < sizeof(xtfs->ra_runt)) {
-			/* length has to be at least runtsize large */
+		if (ipremain < __iptfs_iphlen(xtfs->ra_runt)) {
+			/* length has to be at least the IP header size */
 			XFRM_INC_STATS(xs_net(xtfs->x),
 				       LINUX_MIB_XFRMINIPTFSERROR);
 			goto abandon;
-- 
2.43.0
