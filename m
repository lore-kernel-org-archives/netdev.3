Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58B36F8E8
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822579; cv=none; b=K0KquDRuoypZDNmg8KO269G+sMgy5AkPARy6VFLry+bd22vv0W04UL80L7n3t5dySnql0pp73dT1LiehalPb7Gzqmu0+1zOOGbfdj130TTWlxNkbEl2vobb5+une2nPhalmDofMArjo9hl0Lo8IK3jtE4jKo930b4fJ/4yKktXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822579; c=relaxed/simple;
	bh=t0fg5Ga2iVP46XTFD4juBrFM8Wsfpv51VseqZJs6Z0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcqlM7oFL0UUFPm08pAkj0QoSlPXpUzpmbhm/aJapWeGzTDRUvO8f9BFNdwy62rp8Ou7BIf8g6cZbukg9cIP4ZgYGRB/GIDzRxc8GR0A119YFaqfC4YxuTXOnuz/Ut0eAvMF6706OTwA2frut2SNTbxl+S6TGdlBrhhvvRBAVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Un1SnAiV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Un1SnAiV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so1832071a91.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780822575; x=1781427375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVIXMbGNyrNAyab5Muz+13wztmDi6kndK6voE18yIxc=;
        b=Un1SnAiV7VMtmPd+Z/vJnGWYJlx24X4vzOR37/6v4SOSqiPwfXmSJGLEk//RKeCIZe
         lZ1W0sh10LDC5thO3NqMpTAwauh4TAajQfRIQgLAwEEB3GutXIJSTx0HVVEhBFGOU+aj
         NsCDLhmtJAfP2QW2Hu0mvqTDNYteBLftAGWPn1+HxjQ8VTN6ft81nXcGh02QQY35qS0n
         Mefp469/GOxOCw4sSzTMlgvrqaEcB4Fu6juGaoOcyyJdvDxd3PeTSMIy9vZpqwc661Ie
         MubTxM5SAxx6e4Iv/Ev4ENPOS4QjQbGNKDU2hKufrxmrgIXPBZwuUs6W0cp/kPwNO7E9
         h54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822575; x=1781427375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVIXMbGNyrNAyab5Muz+13wztmDi6kndK6voE18yIxc=;
        b=NUvp5+HOdPZUo+c3iNnOobARr5LAFa3yHR0KVbeyezejo9tpbXaCQSeXxAb4VBUvtB
         2QaZRasb/UHaeNiPiUyG2em+Q/UC/nzDGWB8vhiuvAiyrJvmh1uBxwlbGaaEXkmyJCYh
         iSLyolcQEzdJZxoONYrG20mNjYxx2QdFHJ7+sEaG5mHtt1EkttjRi/yb8XkVzlk6A2r6
         IEBxcWB34xFS0u+v8zlGieAKtbjaTe/a/P0Bp2XddeVqyUzNFRCEJ0Y/erKXswi6vMAG
         AbgJxH01dqY0Smhl2X2yWR+i9EzQieIh9Gn5jwKp/rYBt+dlW+EJ4F/muvQq7VjUZtIR
         ozGQ==
X-Gm-Message-State: AOJu0YxKFdaraRpAwwlvKgWtavZJMdS3tMq9MyJtfWfDKczA/G2Yogz4
	6u0cLWjriW9fJlvl4CFUtJl0vLEgS3uDWC8oYnHAlb4t2UZJ5d8J7VETG6MRurSNk+tlunTWG/G
	9dI6/0g==
X-Gm-Gg: Acq92OFrtLFavFoSj5eRubvaI9tV0roopfpPI3Wh7cj9ClRGvlD6o69yosYHOr1pnA/
	U0Hbdlg57MLNniVN2hTHdRe4LduLtmvbgeb07AQUMP7zQoYr/KVWeH/chEPi3yO1lsFkJX4xUwV
	C++fkLd04nHp9qT5OFVRX+04BH74R2GUYZHyDSgCxW5p1aZonsRA75ixQIYHNRtluvexAj0jzKY
	zXRkqZs03DSkukUuPoRkxT14iIWZAyZ0Avf51DoU3OCHN5MMP6BG+uG1+QiV7Q7yGZtN7zhMmiA
	AQH/Hg9q8OMlcksJm8v16a7xJO61cv/HBrjtDchHpMXanAmaYqV5WzQGLTh8auuDL7QuOsOQ+8t
	otRjBZAPeMJMlxYaD/f6afOKFBkq1j9m0uJwp+Wz9YioAbTqAdXH9hdTBQYmAGHxuM1hkIlZkL2
	YKUL42/Igo+NjSQvw=
X-Received: by 2002:a17:90b:2742:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-370f0b55e45mr12057861a91.23.1780822575168;
        Sun, 07 Jun 2026 01:56:15 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85deeb2bdesm12198471a12.0.2026.06.07.01.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:56:14 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
Date: Sun,  7 Jun 2026 01:56:11 -0700
Message-ID: <20260607085611.3359742-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO hint handling must be symmetric between the receive and the complete
paths, but it is not. geneve_gro_receive() reads the hint through
geneve_sk_gro_hint_off(), which honours it only when the socket was
configured with IFLA_GENEVE_GRO_HINT (gs->gro_hint); geneve_gro_complete()
calls the low-level geneve_opt_gro_hint_off() directly and acts on the
hint regardless.

On a tunnel without the hint (gs->gro_hint == false, the default), receive
therefore ignores any hint option a remote peer puts in the frames and
aggregates them as plain ETH_P_TEB, while complete still honours it: it
inflates gh_len by the attacker-controlled gro_hint->nested_hdr_len (u8)
and redirects the dispatch type to ETH_P_IP / ETH_P_IPV6. The inner
gro_complete handler then runs at nhoff + gh_len, an offset receive never
validated nor pulled, and reads the inner L3 header out of bounds of the
aggregated skb head:

  BUG: KASAN: slab-out-of-bounds in ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
  Read of size 1 at addr ffff88800fe91980 by task exploit/153
   ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
   geneve_gro_complete (drivers/net/geneve.c:965)
   udp_gro_complete (net/ipv4/udp_offload.c:940)
   inet_gro_complete (net/ipv4/af_inet.c:1621)
   __gro_flush (net/core/gro.c:306)
   napi_complete_done (include/net/gro.h:530)
   veth_poll (drivers/net/veth.c:987)
   __napi_poll (net/core/dev.c:7733)
   net_rx_action (net/core/dev.c:7953)
   handle_softirqs (kernel/softirq.c:622)
   ...
  The buggy address belongs to the cache skbuff_small_head of size 704
  The buggy address is located 0 bytes to the right of
   allocated 704-byte region [ffff88800fe916c0, ffff88800fe91980)

Restore the symmetry by having geneve_gro_complete() go through
geneve_sk_gro_hint_off() as well, so both paths gate on gs->gro_hint.
Tunnels that enable the hint are unaffected.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 715180c3a1b3..97b203fdb753 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -954,7 +954,7 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	gh = (struct genevehdr *)(skb->data + nhoff);
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
-	geneve_opt_gro_hint_off(gh, &type, &gh_len);
+	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-- 
2.43.0

