Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986175;
	b=yYR0F7HNourlPEGCRah+s10ZUshKZ6gcSmw5KR/vPG1VXbXbzNXakNEGP32A8HiAXrJR
	 cVaGbOJzUNiAUjd1azPpWmFWCa6Nx1nsz5ZFvEO09iR743LdXc0eYbGwR06NK0QD07EXF
	 SIXRTaxyjYNwik7A8+a2JVTS4yojvul2ZhF1FmI87SEgaxhtmNtJKIVNCcuCgcYxKOR/m
	 mFxTG58Ym94/S5g8y5qVU1B10IQM4vBUX93swl09rglnVy98rT95j1ftSMYMv5aRIsbb4
	 ZEhqSP/wGHdB7Ifuz3+XhPkONKw9sax3Sefo7f31Q9VhRS+YzOEThxUTBZaQWg0YIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3aUKUqNF4swJLhpf709T2ixhcc7iUggf/u0m5b6RuNQ=;
	b=jPuI/RaTInfSEd2q3V8g6QHPC22Nqoit0wiOrNvWKRPiCfgpAkGcsoKV3qdDZx5Twg/B
	 YqlgurBM8iDg8qVdTXJNIubHzZYWdCVZyZEFTCPeJdFUTOftzM4dD7G8BtyWaicXUZGhp
	 OfzZXR5xbGF5Qh3ArvrgrQfNHDcyDd4oP6Qzwx70R1MYpzy+BLKZfthC8R5vXHi4pGPPH
	 eShI/IgW6h2u4SUz6p95CVRV0AlmEMTvrskLaLXSlIUCFgLezwUQIAwH+8jQFcS7l8y9R
	 KFZi1jk0W16jjNT3X6s5IsLSb2rKmGcLCeDRFiV0DYeQZZR3EeG5jzX3afUVyg7Fejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kiObS91Y;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9E606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB9E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kiObS91Y
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b31ca7e0bcso7881937b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986174; x=1794590974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aUKUqNF4swJLhpf709T2ixhcc7iUggf/u0m5b6RuNQ=;
        b=kiObS91YI/DgL+V8wGUebe/mcu2MTd/AwMP3eqjyyCEPHIHhvcHT/oGlPoS3l1ERXe
         HZpXHQmEgHnW68ARYSvSxUVqeTvskDJjOkxae3w2OGdyx/6juIp9mcL5o/U8GMiEcu9o
         WIpA/x+lj1E06uvpw+PJGjw+TysT9bDsbgChBb1jQzrQDipfcNpEaK7yW4Vajb4diYM3
         3hliB5Pi9g3AURsDAtTh7uJBKODKVQAhvvPaWi9yuo6btTBN5E8rc92WuqFunR2N/0qz
         OUb23aoMjkqH+0MImAgwd/t/H8MKP/NS0RZDfluh3KFR9Bj3PLT7KzkXuvuC25DUwATy
         Axcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986174; x=1794590974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aUKUqNF4swJLhpf709T2ixhcc7iUggf/u0m5b6RuNQ=;
        b=qCPqk3431wqVHFA4BWuO4AVeQGk2RBqG06Mh1eg4K2c7/cRQQV0r+EAc+fISsoDMW5
         opVEXmJGy/0b5XLS3MWeVe2b8Sx95isJ/TxU/bLJfTWbDRcINRub58Akfz0K78fy3cti
         MloXNKnhRIZPeS0hsFnfpZypyawbdJAwJTQqT4YphPxQY2AclbF3ZiNqEFmttb74Um2X
         fa3TKPAZhRnv8v9i/2ghKAJHF0wp9nby3hWxeUgPkUZGKejilZcHKqGq7khcery7rt3Z
         uGNF3mzU3iS8k1f4m1y+ETBIQ27a6rmBrZJCceRRm28TOejzo9xn3vKoa0tug5yoHnPC
         /BSw==
X-Gm-Message-State: APuU4Z+gGa8VF+gmUjEHPCsDKyH4AEaYAlHRZ8k+9XVmbMIYZBn9zhCj
	xq/VkvYZAEc/zGUe4q8Cs07QXJXWSGTW7j/9ZBYcJupbXSwI5EHk9jc8kC76GAcE
X-Gm-Gg: AYBFou3wur2fTwBzbnwYi8hv3/qxbIP1Zg/YbRMVe/nVzxxpQtI4izXYkE1ECawp9wn
	EhFon/UMTDmXzJW6TLmr5O29RfrmfP3xXulO0ninvHYTg4oBaliYVkYUznYO2MJeo2ZnYRQ/WR8
	F4NYqFl3jUMpMLjAbi+4nIin+QFT2jzb7XlMZnlqbPBnziAPZs07/VR0jc9KsEOtOOAyvMuQlU9
	3BNlT63oUER+MXJNVHyzHj8t/rqTCwamRXRbh9lsXFZAwl26zzpeZdPWQBtJA1OBe21mDvUeM0+
	KIblTsJ7mrYUvfQ/PnlKZoicQN0bQYhbevdbF6FbXg8jaZzuQ8cIzKQOuKXE4hBb2XHLa2F4RwP
	2sgehMi1ehUPFvvrfr1NMZleNazI6ZyzT+kwxh+Be5tSxb0Jts3k2Qgyx7se6F5jm1V/8OiNq3C
	a50RpdwQGb6h3GFwmfOIjkIOv4Z5wuASMaJ1iGdDZIqBB1hwYnGPa9NoBLsRuer3yb7yhx4w6GT
	azlf51D9E8d6MPwIvr1yZ3p2P0DKWfQjWdZq6NO//F5adbl4vFKfGQUIhZd1Ttp+eAkZ0N3Tv/p
	SHoLJeOYxVOdrXU4rwpEGo7r30sj2A==
X-Received: by 2002:a05:690c:e3c4:b0:8b3:361f:5d77 with SMTP id 00721157ae682-8b341959533mr21325037b3.26.1793986173712;
        Fri, 06 Nov 2026 09:29:33 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f88389dsm23228537b3.40.2026.11.06.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:29:33 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2] net: reset transport_header for ndo_features_check
Date: Fri,  6 Nov 2026 12:29:25 -0500
Message-ID: <20261106172925.3718103-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

For CHECKSUM_PARTIAL skbs, validate_xmit_skb() resets
transport_header (inner_transport_header for encapsulated skbs)
from csum_start, but only after netif_skb_features() has called
ndo_features_check().

The hook can therefore see a transport_header left elsewhere by
the receive path, while ndo_start_xmit() sees the reset one. For
example, ip6_rcv_core() leaves it after the fixed header of
forwarded IPv6 packets with destination options or a routing
header, and seg6, rpl and ioam6 point it at the header they insert.

i40e_features_check() then bounds IPLEN with a 40 byte
skb_network_header_len(), while i40e_tx_enable_csum() programs the
real length, which can overflow the 7-bit field.

Move the reset before netif_skb_features(). Skbs that are not
segmented in software reach ndo_start_xmit() with the same headers
as before, and software GSO parses the headers itself. The exception
is encapsulated SKB_GSO_DODGY skbs that the device segments: their
inner_transport_header, which bpf_skb_adjust_room() or
bpf_lwt_push_ip_encap() may have copied from a stale
transport_header, now points at csum_start.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
v2:
- Target net-next, drop Fixes and Cc: stable (Eric)
- Shorten the changelog (Eric)

v1: https://lore.kernel.org/all/20261104175517.2395704-1-tactii@gmail.com/
---
 net/core/dev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1aece2fe2429f..6fbd8a8884258 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4209,6 +4209,15 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 	if (unlikely(!skb))
 		goto out_null;
 
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb->encapsulation)
+			skb_set_inner_transport_header(skb,
+						       skb_checksum_start_offset(skb));
+		else
+			skb_set_transport_header(skb,
+						 skb_checksum_start_offset(skb));
+	}
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))
@@ -4241,16 +4250,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 		 * support checksumming for this protocol, complete
 		 * checksumming here.
 		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			if (skb->encapsulation)
-				skb_set_inner_transport_header(skb,
-							       skb_checksum_start_offset(skb));
-			else
-				skb_set_transport_header(skb,
-							 skb_checksum_start_offset(skb));
-			if (skb_csum_hwoffload_help(skb, features))
-				goto out_kfree_skb;
-		}
+		if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		    skb_csum_hwoffload_help(skb, features))
+			goto out_kfree_skb;
 	}
 
 	skb = validate_xmit_xfrm(skb, features, again);

base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.43.0

