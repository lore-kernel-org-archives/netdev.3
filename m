Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793168207;
	b=WjOPR/69G7OskoPR6J1IIcXFmSv+rFUAKyTrRWm+PESyTxw8kv1hZA68kZuP4/xUTtcZ
	 U6NEYx51ZAj6aN9YpJy+8JPfNUd4D7XQOTXQvBfxSP4y2tjhlooGTivZ7EDnOY/PijV6O
	 atObBCjU30f1/v++010K32r3haX6YMvtrGNVSu+lOGGfwLkr982UVpCF5vNpOhyerjOvF
	 RsWadEXSoWgBcmzMzcZxJwVXhix67yapD4Q6B5uWyFqxgxA5PL40ENzVxu+2xYfWKYl1u
	 5Z/fIqlIih1gzqIpxDVvSWoQzdAHlwAkt+CIypXrwpZbdCAc/rwQR4hLaolFOxIzQDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=acUYVG0DRJMibOObg2mQC73a9/WqeX3fCrgMIEZ8lJg=;
	b=dm9LAa+YSHt0RK1mx1M3t5ytE6Y2O8qe5pO7nAbL1+iNNVCb/mUbD+WzYvv6pynyjLs2
	 Z1DKtlyFsjLYOYmpnVbu0dR28g1C+tmtDnSPJAKfuBJrc8IIfsKAPJFrCN9jBlARqoR1m
	 o+id8NuyOGQ7LEII2ZZrzDW6/NHfgRK+pu7cGfHZCw0ajEi3Zl/6SqB66Jz+DAk65v3XS
	 tyoKLJV6zFedm2BqIDhaOFCXsCOdYbGLA+JUJUsvciHrxgKgmiMTsKLWQz5RVWI180ygN
	 uwFjOndil0QxeBnvJmoXH8ptVy1cmFuBinJ/7N1K2mGBqgFo/yDCtE1P+1EomuKUQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cp+bV1ll;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC793606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 06:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC793606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cp+bV1ll
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso940780b3a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793168206; x=1793773006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=acUYVG0DRJMibOObg2mQC73a9/WqeX3fCrgMIEZ8lJg=;
        b=cp+bV1llTdNS8j7xG5g/rFZGbuMifnkWqGiBGuNuDK/SURDQB9+EMMaR4yKpgkb0BQ
         qMljNVvDu0ega716P5NYIwc7oaCtnjFQzmB96Q6/cFGeqGCrfKqEQjc/dHxFD75GemlZ
         bSFrPVvKm969uSua77lDzJ4I74KIswEs/Z/amM9AJh+OI/VANRTvD3eUzxazRoHp/ORH
         HC3AWwLE5GlQlQq/tjLV4p7M0r9CSeaZQv2JfEDRA/xPSlD25AtTBcN/G86dhCVeCkvE
         WEi7whhSl0r04QZR4hOIV7VYCTbEXof+/oOOJqG25c7UNmIVxPjRWZi7pbbcSuRZ7Zda
         cbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168206; x=1793773006;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acUYVG0DRJMibOObg2mQC73a9/WqeX3fCrgMIEZ8lJg=;
        b=gvVHWZHxcfKeOztH6HZ3GfMjHaLTLGRdeNKLxeFLmTR4uVsEvH6K4Bf7GYGDXKgTAG
         z41xhdRynnlrI1jNTOItnJz4lxDIrOfGQ+2Xn7yMHDggQUurR02nidVi7DtP33NN2Esh
         qYkN7+rbr1c8YhGtSsOzKiJrO9NmMYZ/b5ZgRm7+WZ3Rk4nhik8/cKzrSviYUMEFXuKo
         41Z6JGIh09DqiUiW7e8TxocOSZwipRzROdikULml/UFAF+/iyCOuUw5X7r773je74XhC
         Sv/L6cShHVivm5Gru2VWZCLuu7Xe299nLTKJ5Kl5JKfXi82yishUIenujhabO+5hEOEO
         HQfA==
X-Gm-Message-State: AFq9FYKP1t+VMl24X4fhGzJUoM3wawArx/gA6eyi0XR0FN9e61wqD6BD
	Ac6ZIH04yP1uu8esfsxUKlUch1HueYw/NpjO/+Db3xSg+mG8tMZxhiScLoOHce/E7BjkBcoGXr8
	6/47CcnsPscYeymL7/w==
X-Received: from pfdn12.prod.google.com ([2002:a05:6a00:a66c:b0:88e:c0e0:7ea6])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd04:b0:89f:6989:cb9b with SMTP id d2e1a72fcca58-8a6e74da8f5mr1084767b3a.27.1793168205950;
 Tue, 27 Oct 2026 23:16:45 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:16:44 +0000
In-Reply-To: <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
 <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261028061644.2997812-1-starchang@google.com>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: ja@ssi.bg
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, wangroger@google.com, starchang@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian,

Thank you very much for the insightful review and for pointing out the RFC =
826 and RFC 2002 references.

You are completely right on both points:
1. Per RFC 826, the Target Hardware Address (tha) in an ARP Request has no =
protocol meaning, and Linux updates neighbor entries using (sip, sha), neve=
r tha. Inspecting tha on ARP Requests was a fundamental mistake and would b=
reak legitimate devices that leave arbitrary/unicast addresses in tha.
2. In RFC 2002 (section 4.6), many real-world GARP reply implementations le=
gitimately set tha to the broadcast address (ff:ff:ff:ff:ff:ff) since the a=
nnouncement is broadcast to all hosts. Requiring tha =3D=3D sha in our chec=
k was overly restrictive and would cause false-positive drops for legitimat=
e GARP replies.

Regarding your question about arp_accept:
In our testing, arp_accept =3D 0 successfully prevents creating *new* neigh=
bor entries from unsolicited broadcasts. However, in typical client scenari=
os, the victim station almost always already has an existing neighbor entry=
 for its default gateway (i.e. n is not NULL in arp_process).

When n already exists, arp_accept is bypassed, and once the 1-second LOCKTI=
ME window has passed, arp_process() calls:
    neigh_update(n, sha, state, NEIGH_UPDATE_F_OVERRIDE, 0);
which executes memcpy(&neigh->ha, lladdr, dev->addr_len) in __neigh_update(=
), overwriting the gateway's cached MAC address with the attacker's MAC.

In a Wi-Fi (Hole-196) scenario where clients share the GTK, an attacker can=
not forge unicast frames directly to the victim, so they broadcast an unsol=
icited unicast ARP Reply (sip =3D gateway_ip, sha =3D attacker_mac, tip =3D=
 victim_ip) over L2 broadcast (PACKET_BROADCAST).

Under standard networking behavior, a non-GARP ARP Reply is strictly meant =
to be delivered as an L2 unicast frame (PACKET_HOST) to the requester. The =
only legitimate reason an ARP Reply is ever sent over L2 broadcast is for G=
ratuitous ARP (sip =3D=3D tip).

Based on your feedback, we plan to completely drop all checks on tha, leave=
 ARP Requests entirely untouched, and strictly narrow the ARP defense to dr=
op ARP Replies received over L2 BMC *only* if they are not Gratuitous ARP (=
sip !=3D tip):

--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -791,32 +791,18 @@ static int arp_process(struct net *net, struct sock *=
sk, struct sk_buff *skb)
 	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
 		goto out_free_skb;
=20
 	if ((skb->pkt_type =3D=3D PACKET_BROADCAST ||
 	     skb->pkt_type =3D=3D PACKET_MULTICAST) &&
 	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
-		bool is_valid_garp =3D (sip =3D=3D tip) && tha &&
-				     !memcmp(tha, sha, dev->addr_len);
-
-		if (arp->ar_op =3D=3D htons(ARPOP_REPLY) && !is_valid_garp) {
-			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
+		/*
+		 * Standard ARP Replies are strictly unicast (PACKET_HOST).
+		 * An ARP Reply in an L2 broadcast frame with (sip !=3D tip)
+		 * is an injected unicast reply. Legitimate GARP (sip =3D=3D tip)
+		 * is preserved and defers to DROP_GRATUITOUS_ARP.
+		 * ARP Requests are left untouched per RFC 826.
+		 */
+		if (arp->ar_op =3D=3D htons(ARPOP_REPLY) && sip !=3D tip) {
+			net_warn_ratelimited("Drop non-GARP ARP Reply in L2 BMC on %s\n",
 					     dev->name);
 			goto out_free_skb;
 		}
-		if (dev->addr_len =3D=3D ETH_ALEN && tha &&
-		    is_valid_ether_addr(tha) && !is_valid_garp) {
-			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
-					     dev->name);
-			goto out_free_skb;
-		}
 	}

With this approach:
1. ARP Requests are completely untouched (fully adhering to RFC 826).
2. Legitimate GARP announcements (sip =3D=3D tip) for VRRP/HSRP router fail=
overs are preserved regardless of what value they put in tha (respecting RF=
C 2002).
3. Injected unicast ARP Replies in L2 BMC (sip !=3D tip) that poison existi=
ng gateway entries are dropped.

Does this sound like the right direction to you for v5?

Thanks again for your time, guidance, and expertise!

Best regards,
Star Chang
