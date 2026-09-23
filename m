Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889F37CD2C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133930; cv=none; b=aLGkRRZ1X+e+Mg1ylKrifhzI15Cyl0CjAYzNVt49Zb0S26U+a2AGU+KWBgHtGIhjI64KeQFUWl+McPs5CH7kR/XVftRpxVwrhO7PvlWnfGaoqQULkQf/Z0ENreC9h4a2dGAtdY6EyGmxC091lkRDTjqRA01oNsuakDDTXPuMg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133930; c=relaxed/simple;
	bh=Zt8mLoDNZWawgRiHx8R/i9/D8eeGe9UUEreQiE7BP2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn0+qSqdVSkk1chId2jkuD/CLuHi7VfD4i7v9PfThzHcFDGqv1zMmWCCxqjOLmBlkLoCo6M/Gf008idsWrbhZV9KiAHS7fmZ+XnXr2VadMMPyIXSgqVA1XDzWSA+F6iaMNgwnrif8tf3YQR//Y3yqMBx5OIhWRxr06GKDogbx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq3kkF5/; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq3kkF5/"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-399026951a2so69205a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790133928; x=1790738728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCfOYO2NRyZaR3nhyn2Vwjg5Pm9GGu3IlToVcEbkF0E=;
        b=Oq3kkF5/uwk6wiyADKE59Kvk8FU30j/j66HV5eZpUxgaPMAnFJQkWl/znxhqymFQdy
         7pT0d7Ad4+hhpE9jXSNcmfDiUHdOFTkVDEnjAIuTk+mNiMDv1BJoL3fmLxmOwkTEX31B
         yBtTpQ61bM73YxRg4Md/StkhNQg0WpkNRsu/BNJhsfcSz7l54MMmY04Y7V2M4j24d/tQ
         2riXqebu6ePUIuh9SQbYk7LRmm4TPMKeSU9pu8vxdiUxqM0hnm3z8BUSpcQV6zzqiFBa
         1z0WlzmQyYsYGNzQ0JtYsIRDlhunNHOdwaZ61wOmFCjSqIXeAu8zg288c+32J6YxQIuc
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790133928; x=1790738728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCfOYO2NRyZaR3nhyn2Vwjg5Pm9GGu3IlToVcEbkF0E=;
        b=FGurmwuIvV+3MrzDVHhWTNCOKuFUmaX2DDQdFP0AvezwbeeK0KBgL5A/iE70lg9aDc
         FEed3mhtgupg/cD24qbT4gB/31X0ja+mWYXUXLwMy62wCkOyHoonIzj1SL+8RRBlNv/v
         n3cmVVzOla3VE5hVyxshFOTWXlsKbf+q41s+A5CbLhDAPYEKiqQtGP776bGHYyFOs5WW
         LOmMeFh4kTsdnALnGGb7Sx9TwRUf1+69eXOfMcPzjH3wq/J8xlgFkS2bvkCpCCFqC0Gv
         lvAzXttSuqja2dPc0cdkdeGoWo+8OkIYVjVIXMK1qTdsIoiCSPN5lSM3j6xAXlboq21Z
         KIkQ==
X-Gm-Message-State: AFuF++lL2/elk88k7CBylA2W6doQ539bpX46TJmMqsJzDnXvILnnz+1+
	YMZcx2NWCR1xhgWcqNBPFADzB3e/FFL6Uom92CbKY88BQ/2lR+RTE/04dVXA4VCV
X-Gm-Gg: AYBFou1HP0jacbpfuTDPPIBrFK1LNrk/bBz++XeIdZKSXXQETu8nZi67ZzLc4hrKfh8
	yvXw4rkTTGg5YpOtdSLx4qcD7E5d3Ld5NwKyRsgZa/KJkJ8ZO/eWZdBsbO18Z4J0STI0AMVcZJ6
	ngIUgMVZdauWffNhLlr9lICJdr2z2ca4jaFMDrng41MgdGRr44+e0XMQJCk4pcCIXzLWtDeDmvj
	12l/z6TabuwDu3p/Yn2YFo4a0aw0grVEtgBHkAq+teaFtxg3EeldP131SucRCIpFLIKLEAaqi3G
	WXKBEh92pFTl2s3nXS8ppDwPUIn7UZ2ujfRFY7D2By1KrRsDTeSWEz2zfv/hcLABmW4l33J5fWG
	TET+nBVFEoL59b3d2iFrPTBTZLw8rBuqIPgmN/ha6ijuzaM7xZup+toH4Apgp92kVqDPsFRztwF
	ttHharlayx7k9P7oieNEGMutYsPMEQPva5colFD2g3iC8FEIOIITvwWALn/tQvT1MXJkXTpXDBL
	uNbdxbG+l1Hsuzh1ICC2V8l6JlYoJMXuC50ZkrWbw1iNcGLXKMJbeHUiJZ6wiVtoG7Fb1ct
X-Received: by 2002:a17:90b:4fca:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3a07e773d26mr1868461a91.6.1790133927959;
        Tue, 22 Sep 2026 20:25:27 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc32086sm2261602a91.13.2026.09.22.20.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 20:25:27 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v3] xfrm: interface: validate the IP header on xmit
Date: Wed, 23 Sep 2026 11:24:56 +0800
Message-ID: <20260923032456.45814-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach the xfrm output path without IP header validation, but
xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
and expects the header to be valid.

vti_tunnel_xmit() already calls pskb_inet_may_pull() before handing
packets to the xfrm output path.  Do the same in xfrmi_xmit() and also
reject malformed IPv4 header lengths.

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
Changes since v2: validate at the xfrmi_xmit() entry point instead of
inside xfrm4_transport_output().

 net/xfrm/xfrm_interface_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 688306b..5cc906a 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -531,6 +531,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&fl, 0, sizeof(fl));
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
@@ -548,6 +551,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
+		if (ip_hdr(skb)->ihl < 5 ||
+		    !pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
+			goto tx_err;
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		if (!dst) {
-- 
2.46.0
