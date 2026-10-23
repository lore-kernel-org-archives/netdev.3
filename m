Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756786;
	b=VgJB93nh1X28p/xwe8Vt4D7cmEEDAvxeguD0hOmm8EZNRXgGblXaTgWotTsTC9H6rZy6
	 LjLHavCSCpd9zlAUYxQeuxCiJRzRcTZZSJlVSx5fd6M0YqTu5i38czLlRKY7uIFTU/SDy
	 lj7IoBx8SiBn1BSh/ATFgPdN4FwG3u8FSsjJI2iLGG8EtZ8XRsxT/1bTgoTFqyTWwv5aP
	 nRMwpNgHw3+ruvciDRJEK+u6JV3kj42vN6zzN425d/g3vJR7Zwp0XX2R0qSRvgJX48z19
	 ii6hUajsQFLm7RD3qtVuguRDuZuZQReZd2f7pGKZjAFRJ2u6vgBoWwUqFhSze4Rupfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
	b=lc+jX9F8fIXcVBtdvNSpJemXO7PPLZxG8LzkDdpDdo+BLFj9MgXx+nUckRBRzO+JySqY
	 lvuUPy7vm22znPwQ11yDHpA9uL8vKEEu6lTQaOdSvMuPvElEPcJBhpLAWgrGPXE/qSTBo
	 klqRlw4F6dD7DsYT5G3hLdR1EbEkYSf78xLuqs95uSlSB/xStccUlcCoTcCX0laOmWEqk
	 VjJDD7imY73r3FUb5PkrE+LokdCstIE47YGdZO3BuoPwb7OxPw3mvPXYnLpGsHCxNZ0A2
	 nzeF0mfIZukizd+hgroMSYXgtJ7flyHyUogi7jaz8zqZRAlHcti/aw7xDeWhb+8eQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=nBgUe0mT;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E334606A32C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E334606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=nBgUe0mT
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b83459526so10118676d6.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756773; x=1793361573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
        b=nBgUe0mTADJl4ddyHy6UPd5rx6Iqavbz+zHKePt2nBRcXCipAzgq7s0KUA9aKlnPDG
         uGT1KX/YwEp/JCK7W1+PqoS2gswSwQjDsqgkC36gQMVdhWQnW9US6ZPyW9gyVwfKn9Yf
         8t7zgDnmRYxzuCmGa/s00BnvT/+jH6NiN7vgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756773; x=1793361573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
        b=mTFQB4PM6OH2Skep3oC/xcG8saj4wPmankXjsIlRgjSvBxDNcMMs/s7rvcRObW9zrX
         8bHmcz0BiuYj89C3I1mjOIE9e4U5KxoBaRqasRnOQNdav5w5tgma0Tuw9JvfJXgJzcM2
         Y371ECZUSTcJwHZ7gvYlbLhBi/Cp67rN2Ii/TtA4f4BenD/7vgZZNP2sXuGgeXbxKkn2
         Sp5x4GlubmLQ7CVqLGBk27wC2YtjBT8l8+bsxJ3A8ImJDNjMNq9a2Zzv1o+7okqpROpT
         54CM0LVq2taTZhueBiTzIZuefb7Q+uCq1npqQ37TQMOzt6FXpl/Ks0bwTpjYFM/sf6pH
         kV7Q==
X-Gm-Message-State: AFq9FYKPP0Swg0ANmTRufD4a8+a5suM+Ysv0bgULIy5oMdqw06yiUZsF
	E94MTeGintPpV0Dm+QnjyF0RQJW1H4c7XpYwm9+nvgYUjrcXScbWfs/Tw7Gkh+dZi9ZaTm2puqY
	SD44=
X-Gm-Gg: AYBFou38ISDxzzpDIdmYk9WmJkXYnGViFQf7+fcS8TCaq6pNdyyK7ga929VH65j5NW/
	uyH87mI4i4beTIbyr5fCGU622inZvxp5HEx780DCXO0uc80WAZ+GtCPcI2fkKozEx/rrVlwVl+J
	OBr+9rIYyK/J8GVRFah6nXfr8uZTGq60pZAE+NJYmBtT4q1lOpqe2gbpdmbEGu2aFwmQ2aNKKNh
	E1TFOCkoq4Z2Am0u9KEfSb7NznDupO0ljT0LKQEWXSr7P22XafqE7Y8rKEg56VrGy9AyxUgmUEX
	lO6GgC7eTp4V8HK+uI56WABOCUO5Z/8mG3l5pPWq+t3WKqPDp5qTLHO8+ANOwxEqkT/woPOG3e5
	EVDNSiLgjomT56/1pdPE1KUyAAJA7IFIB3sGqJLim3A2FPv57WSfls3qUwF1VJOiFWjFdqRYcSe
	2h3FyliGlvbfEXLHXJDK60nILTSpnZArgPqCu9q3Ni+TlRc+UwH8jpaWMZC38ztBfZCvshWqlkx
	MpJf28EpuKmsabCrbd0zQFrkMW1LxzjBpnYZ8G5EWTFUMBiUpuwzdQ6f+mtpthdGIMViU8Onc6/
	wIjD+7WESCGBFKtvE/HW0gnUzJluePw/vtvAI5pPlb0=
X-Received: by 2002:ad4:5fcf:0:b0:914:5769:dcee with SMTP id 6a1803df08f44-91c3a82d162mr24656846d6.17.1792756773198;
        Fri, 23 Oct 2026 04:59:33 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/6] net/sched: act_ife: do not consume the inner header on egress
Date: Fri, 23 Oct 2026 07:59:19 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
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

The issue:
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
can BUG in __skb_pull() when the remaining linear area is short.

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Decode is a receive-side operation; the egress branch keeps the frame
intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
Ethernet and loopback devices generally.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet and an 8192-byte payload;
- the egress pipe re-enters eth_type_trans() via loopback_xmit() after the
  action consumed the inner header.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..3946a9589bb8 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -769,6 +769,10 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
+	if (!skb_at_tc_ingress(skb)) {
+		skb_push(skb, ETH_HLEN);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 }
-- 
2.43.0


