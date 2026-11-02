Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606690;
	b=DmsXe+0HBql5BYVAFWjdXuiM7bSdMb69jhBVuc0NxUDc3SQpXyyPi1T1aKZIydoXjhJB
	 /gzexHUyRXVZpl8d93kGWcwo1M+sYgeTu4Swv/x+3FIHsvojDGqji8bvrYrSJ6UEgG4qe
	 ngEM6ilnrciBXm9pEaTjP1x0jjxwbtQyVCEEdz43COybRzpb2OrDFo23/Axc+QaSrNLW6
	 zgobrL3bE9OiD88yC64DkeJH9MEjqSqCAQJcDhxFVvIxL2pVNfYg479kpuBlkQubCwUIk
	 vOpxmEhinxjnt6YQuVoVvO7YALg0cb+iU/1fhHj+K1ihSbJN6ACZ+xqjz1Uk8b/UW4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606690;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=thBVD6OEHrAcgPMGcHGCuTpwhbDxLXvR0Dj8bMZ3KCM=;
	b=T2FR8syaC1iO2PG2TFVMmE8lk/b683kzgomaTLknMUsatoOBm8VyUajjxVblRsFCXHkH
	 FOs6RyEEBGqCqjaU1dsWa4nuJTUsvP/63H6Ers5WSoZB/KVxwFVPgMqujF+cjP0AEbfDY
	 J+MeZVos3rIULhc3Uf1wD3k1WVAOuiDqTKvRCzKsosp48i0ZTXmsSDohZNgk0zJ6gssAF
	 YimTTLjpMLDwc/9AH0NNYZQe/Mw4+9jsnGAohUzuWaMSoJ4D3D1iM/u5pMwitLipDFMUA
	 2tBR1M5Mox50AjbXWDSqE9n1fQUUxj3yXAhJAPdi5Efsy40H1Q7E2OgS94+xnGC5GfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=uoMAiMyr;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D59606A335
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D59606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=uoMAiMyr
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 691F8207C1;
	Mon,  2 Nov 2026 09:04:42 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wmmy2YTnOvJ; Mon,  2 Nov 2026 09:04:40 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 80D01207A4;
	Mon,  2 Nov 2026 09:04:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 80D01207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606680;
	bh=thBVD6OEHrAcgPMGcHGCuTpwhbDxLXvR0Dj8bMZ3KCM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=uoMAiMyrMnoueFcHt7jKQ94TnOO6qc9lv+WGoiRuebx0CRhZ77dJFk4IvbIRO6nHF
	 9klrfkx+ACkqiPBXBDHSEtAZaog6xIw46CaCmPWNwstauu883eZ23TPTml+RlWPemm
	 lInjp+lsOYzSsPMXlH0Oqp3qHgrK5NqETgsRceBbpR2x3QjMyjPp3pynK3/mgNhOEr
	 IUpWNMOpJO28AAsmqwS/I4WVyGKeGTRtK388AziWn31hJ6154WWcBAl8ijmLJZrCHt
	 x1YC/O0zs/4GSY2Ndvq0fbnHNkQvwoqdDm96okVXjt4zpLnX0ODk+ptr2om/MSrs0S
	 3pGJFfpzqnK3Q==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:39 +0100
Received: (nullmailer pid 2505930 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 14/14] xfrm4: use a full socket for local errors
Date: Mon, 2 Nov 2026 10:04:12 +0000
Message-ID: <20261102100451.2505200-15-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Fourie Zhang <fouriezhang@tencent.com>

xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
by TCP_NEW_SYN_RECV request sockets.

xfrm4_tunnel_check_size() already checks sk_fullsock() since commit
1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so iptfs_is_too_big() is
the only remaining IPv4 caller passing a request socket here: the sk it
tests is the listener, while skb->sk is the request socket.

When IP-TFS rejects such an skb because it exceeds its payload MTU, the
local error path treats the request socket as a struct inet_sock. KASAN
reports a slab-out-of-bounds read in ip_local_error() beyond the
request_sock_TCP allocation.

Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
state or reporting the error. This maps a request socket to its listener
and rejects sockets that cannot be used as full sockets, matching what
commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
did for xfrm6_local_error().

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/xfrm4_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..fffa3c4f456e 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -38,9 +38,12 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
 {
+	struct sock *sk = skb_to_full_sk(skb);
 	struct iphdr *hdr;
 
+	if (!sk)
+		return;
+
 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
-		       inet_sk(skb->sk)->inet_dport, mtu);
+	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
 }
-- 
2.53.0

