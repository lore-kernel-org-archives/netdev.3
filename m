Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADF424D58
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773523; cv=none; b=lffvABIKzoJfy4ya7zqf4Z6HtCd18EBce9fH3egpUjVu6zUqDYFuOwEmFbpwvzIYzCD6wcjfSmaUAwAy/1gcPPIT02NkKc6X4pqm4TvkpXKpZbLu5IU8L/3SyCgmrVM4LYLexczPXZTfT5E9Qxr+l9s2+fFxK5/zFhGaXb567wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773523; c=relaxed/simple;
	bh=3aWASqYVLMNH+HcLl4Q33NxoWH3YrdvFvkFHWrmcr40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiHInlCMSzZIFGEB+9lQ1Zj4g+P3cgrm7Ja+PhD0u/1bTnDZmev4kPmQFF7Ui+1uYUVSMqbYU99H4sPjCXHVNcvPzqTm1VaHjKGQGajLRLJhWdAAoJXFOwD3V1A7Sw1VoB0yqwUCLY73VbjKIQUS80s+FUcS4MQcpporsFEH/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FgVkSvP8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FgVkSvP8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 692FB20719;
	Mon,  7 Sep 2026 11:31:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLFGGOPIpjxJ; Mon,  7 Sep 2026 11:31:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C947020704;
	Mon,  7 Sep 2026 11:31:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C947020704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773518;
	bh=i9AeNAGhGR2t8VeH7S/nXGCq8LwypJwwiV0NShmk0vU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FgVkSvP86WksFQJ8+kOLme5obTEefAi5TOz/010zJPchL8reUfR1scnjkTAo5A5WY
	 55Oob2jusnomQzO6NvqFb5OVx6zaOnVq8/o0UY2e2l0FhSAq6D0th7t0gZzl50I0/M
	 tpFRud3njV0ehLekgPcun1SUQMCYmYFpT9uSlBeQiPVxErbw/wfoMEOrLBUOlVJ+c5
	 B2Se5rDjSnVXrlOhlT62TBa0+eSwNWmRg9U022GXSl9x5vhgOsyHdwuwjK8Y/svV6E
	 jx/i2JdXWIkGYrui6FEwbHr2edICkD4BW22SHiIFjbkf/QWGGBd5/QxeNhU10WAhE/
	 a2Q4pLbGqyzrQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:31:58 +0200
Received: (nullmailer pid 2228811 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/12] xfrm: iptfs: fix runt reassembly panic from short inner tot_len
Date: Mon, 7 Sep 2026 11:29:47 +0200
Message-ID: <20260907093020.2228346-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Henry Martin <bsdhenrymartin@gmail.com>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 2ce15c472cc4..6920940a35b4 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -828,8 +828,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
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

