Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D35217704
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601404; cv=none; b=UYmEgRgqobBhsPucT6p+MZH6ofYn+clHUjJ9G8TccnAknjgNfu4esh29QFwZM2smiqYFgBL1CvtrFj/cad4eSSHpvRRXs5rH0xhYcaYEUNIJJdJ3Net6CwHruXWdXoVJ2SCtUq57YJGvUp4ztNQVb87iOQiAorI6SB2tHGXoDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601404; c=relaxed/simple;
	bh=4B62HqV4UNtFMZ16UMBsR28RngrDSwufJ3Mg/br7vHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJd2PyeVoTCrHhnJKvWMRAEVcPEnfZlxy+QRDPlrlBzAeDm7lDpFmniORtrwjhCLHMCFzcbYxHaBNo0jl2SWaT0uMLAGL7d+UzAmoNWDiru75ox+FqnKzntSJILkfY526ry2/ADr9JzMj0TIwEmuSltoyMPusA6FL4ccamQ1vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ3VPWKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ3VPWKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC701F000E9;
	Thu,  9 Jul 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601403;
	bh=Q3OSFJTu9Wa9ugi7axHB10cfsHsDD9vjibJwdeI1IDU=;
	h=From:To:Cc:Subject:Date;
	b=dJ3VPWKdENCl4YAyYoCqwRVv2y36VKdZSueWatgvKtAYDfDT1dd8zLh6Y8pgZ/JhJ
	 B4b02SMXzHG2Nsco7UcEksgrT/i+Kuu27itF1VOIJ6ljfGYY71ZiJcKdXRCaxZuvQS
	 Jpw0B1MVnuEkcdcaPRBLOlbbMyRFXEUu/GcQ/fuXfGQd0YBCeboN8bPDhuTM/zmrT3
	 sxOzer/ZeFr6XlJ7cqf8g14NSU3far5JPRZ6Hsl3Vj3IXHHhxdJGrbf3cBCcac5hRL
	 sSnEXNnQFpoxcQpPUyjfTeg2NrapLPt3gbFfjF4gfm30zF23eFhbikglSQx1qxWDaw
	 hmiM18Aj2WCRg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] geneve: ensure the skb is writable before fixing its headers
Date: Thu,  9 Jul 2026 14:50:00 +0200
Message-ID: <20260709125000.141092-1-atenart@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the IPv4/6 and UDP headers are writable before fixing them up in
geneve_post_decap_hint. As skb_ensure_writable can reallocate the skb linear
area, reload the GRO hint header pointer and only set the IPv4/6 header ones
after the call.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Cc: Paolo Abeni <pabeni@redhat.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 drivers/net/geneve.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index b25b0c4de4d1..0b0f1e300b68 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -586,6 +586,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	struct iphdr *iph;
 	struct udphdr *uh;
 	__be16 p;
+	int err;
 
 	hint_off = geneve_sk_gro_hint_off(sk, *geneveh, &p, &len);
 	if (!hint_off)
@@ -610,12 +611,20 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 		     !geneve_opt_gro_hint_validate(skb->data, gro_hint)))
 		return -EINVAL;
 
-	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
-	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
 	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
+	err = skb_ensure_writable(skb, gro_hint->nested_tp_offset + sizeof(*uh));
+	if (unlikely(err))
+		return err;
+
+	*geneveh = geneve_hdr(skb);
+	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
+
+	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
+	iph = (struct iphdr *)ipv6h;
+
 	/*
 	 * After stripping the outer encap, the packet still carries a
 	 * tunnel encapsulation: the nested one.
-- 
2.55.0

