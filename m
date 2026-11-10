Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302716;
	b=xcCPJTksLJ8hv5cIqpsr6CShfYZ6tSrXP/MlVRi5CdH19xpgTqsVSt9h5ZuLCvpPddk9
	 3gZjeXBdBgD4xO+GluFvf9bB7b668fGBX5pFMlUOLtHZXu0pel4IG32DJsWYTpJtocJkI
	 V8cOiu+L0nTAbF6uPdg4hnslhSRFLsx/xTDP7IK1Aqd7vNwuGkIH9kFJ7wsxDcbYjv5bL
	 m+HCNAIcOtP2GFFPCUaCQxjwHPVHoaODCWYPNe8kT1sbT5QPWbuPMDo8fbHDz7TX+pfkT
	 ZKPUoxKrk8o3ufR2ehVeno2ECT3dQRwqfVRtLtZeWTIUceRyiDyjmvQHaxW4V4XMsYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Iw96EVLy3uo7NO5SdGl826YFCr+7nw016vGeTrGSnIY=;
	b=zqOs9CZQ5FsV92k1YQSclQ4PgQK4f05jCaRrzZXeiVizPXITwmSHId0Gz6dFhDhB6heu
	 W410H3+V5dFbixunppK4ApJurPEPHQGfG4HPA6n1ZpcDK9YDywNcJoEYBHV6/eCFw5Fl0
	 zNK5U2NMScDDNjX1c3XMVR6WDD2gXAPzeTfjYjBjebyE6lRmZR6owFDKGIGyDVNq67aqN
	 pA5PS3otsrKIv0zISBoasRN/ccfdxLrMXhCeqzd2WU6OL7+DA2ureM5ilYW+zFpPbNQh2
	 1CmC5wL1vQ91dMJyAX4lD2Y4mVHGp/TsD0JJB84lxWf97l+pNhvMrYUrYlyupsyrQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sewookseo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XY1Rck9u;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E0606B141
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1E0606B141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sewookseo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XY1Rck9u
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0f667a666so2707458a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794302716; x=1794907516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Iw96EVLy3uo7NO5SdGl826YFCr+7nw016vGeTrGSnIY=;
        b=XY1Rck9ucIY5y4i1J22jkm2YLbQip4P3wN/c7gTbA6FcOikGK48j9hDEcGuyG2rA8x
         dJ2U8yt8TdnUv0p744gxoGf8js5JAXBEY8W3XAE4+42h/Vog2Gwe1r54gP0oUvcU4PRU
         Xvo9ja+7TTrtCDFnL96fhmNFlBEFBtAhMAcdHi2H9fSKLCe+qfWL3D739t35sTcfMBgu
         S7hHkWuov1cG2e84DJIAdZa5YYBUKcT+UnO7+JAymQVEB//t7uKVq/sLckbqb2UQecPT
         RgO2fffJf48CsmorM1PdlHvbwaOR0PXIfUP3RNebwDwtd4y575Wc+d944+SnET1wMEif
         W4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302716; x=1794907516;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iw96EVLy3uo7NO5SdGl826YFCr+7nw016vGeTrGSnIY=;
        b=I6EAoCTJR8JbcGZilrWMFJlkYY4pa/+sRmam1FPAaELOBmnEbuAZNKpmoPTISXx0E2
         hBlv2f005aNl6MYclPSS78cLxVDAZ1zoO2hEYluGysqQLNZGuLTTeTdhYK/IXrahOaIh
         sclZmskJzY0Ha8ID8RIXoo1sW0QS94jmUM9uBjZOpn+2AkM20H4GDJtku/1iA5jsjWdJ
         jhMTuYuDmf+ZhgfJyiayf66+DQwEFGOgf9KhTbNpC+sRKd4KjeJzN4jYAe7zh1ezrTJf
         2A2HWgeOqGqz4nlHVTu/YZAnmVry/6onQmfXOwxAbC8dIMRLO9iIwNCLKPeiVkh+6oH5
         wHqg==
X-Forwarded-Encrypted: i=1; AL+hErFm2L3dEZTPzd92Xv7Y+j0IChK0rLbQ6qwMaWVNswok8d9yDNJrX3s1OpOAggtw/TLz13sq+sQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WNGEU2tKfjZONbke2tYDEt0XQJvW14ZL3V+9YXllKkqLS6DXW
	hA93i8xalSJ2NG5JzOnNvOELm+N8DKJgUT87E+BAA0gfh2tWKb/Kt74XX6xvh0JC55mUF5bIhS4
	FHqra+RBjkptuVMU6Zw==
X-Received: from pjbsv6.prod.google.com ([2002:a17:90b:5386:b0:3b0:a489:6e84])
 (user=sewookseo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:224c:b0:3ac:7f4c:a68c with SMTP id 98e67ed59e1d1-3b166fbd19dmr2275693a91.49.1794302715465;
 Tue, 10 Nov 2026 01:25:15 -0800 (PST)
Date: Tue, 10 Nov 2026 09:25:12 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261110092513.2375648-1-sewookseo@google.com>
Subject: [PATCH ipsec] xfrm: check inner family via skb_dst for small_ipv6 DF clearing
From: Sewook Seo <sewookseo@google.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Sewook Seo <sewookseo@google.com>, stable@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 6821ad877034 ("xfrm: do not set IPv4 DF flag when encapsulating
IPv6 frames <=3D 1280 bytes.") intended to clear the outer IPv4 DF bit in
xfrm4_tunnel_encap_add() when encapsulating inner IPv6 frames of at most
IPV6_MIN_MTU (1280) bytes, by checking skb->protocol =3D=3D htons(ETH_P_IPV=
6).

However, its caller xfrm4_prepare_output() overwrites skb->protocol with
htons(ETH_P_IP) before invoking xfrm4_tunnel_encap_add(), since
commit 0c620e97b349 ("xfrm: remove output indirection from xfrm_mode").
As a result, small_ipv6 always evaluates to false, leaving IP_DF set on
outer IPv4 tunnel packets even when encapsulating <=3D 1280-byte IPv6
frames.

This issue was observed on devices in production use over IPv6-in-IPv4
ESP-in-UDP tunnels where an intermediate IPv4 link has an MTU smaller
than the encapsulated packet size (e.g. < 1362 bytes) and ICMPv4
Fragmentation Needed errors are either filtered or not actionable below
IPV6_MIN_MTU, causing encapsulated <=3D 1280-byte IPv6 packets to be
dropped instead of fragmented by the outer IPv4 router.

At the time xfrm4_tunnel_encap_add() runs, skb_dst(skb) has not been
popped yet and still represents the inner packet destination entry, as
already used a few lines below to set top_iph->protocol via
xfrm_af2proto(skb_dst(skb)->ops->family), while skb->len still holds the
unencapsulated inner packet length. Check dst->ops->family =3D=3D AF_INET6
instead of skb->protocol so small_ipv6 works as intended.

Tested on User-Mode Linux (ARCH=3Dum) with a four-namespace IPv6-over-IPv4
XFRM ESP tunnel reproducer across a 1300-byte MTU router link with ICMPv4
Fragmentation Needed filtered (verifying 1280-byte inner IPv6 frames fail
before the fix and pass via outer IPv4 fragmentation with the fix, while
larger frames still preserve outer IP_DF), and verified all tests pass in
tools/testing/selftests/net/xfrm_state.sh.

Fixes: 6821ad877034 ("xfrm: do not set IPv4 DF flag when encapsulating IPv6=
 frames <=3D 1280 bytes.")
Cc: stable@vger.kernel.org
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Assisted-by: LLM
Signed-off-by: Sewook Seo <sewookseo@google.com>
---
 net/xfrm/xfrm_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f1f612cd7b43..60ffe9549c09 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -275,11 +275,14 @@ static int xfrm4_beet_encap_add(struct xfrm_state *x,=
 struct sk_buff *skb)
  */
 static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *sk=
b)
 {
-	bool small_ipv6 =3D (skb->protocol =3D=3D htons(ETH_P_IPV6)) && (skb->len=
 <=3D IPV6_MIN_MTU);
 	struct dst_entry *dst =3D skb_dst(skb);
 	struct iphdr *top_iph;
+	bool small_ipv6;
 	int flags;
=20
+	small_ipv6 =3D (dst->ops->family =3D=3D AF_INET6) &&
+		     (skb->len <=3D IPV6_MIN_MTU);
+
 	if (!skb->inner_protocol) {
 		skb_set_inner_network_header(skb, skb_network_offset(skb));
 		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
--=20
2.56.0.542.g3ef89b7020-goog

