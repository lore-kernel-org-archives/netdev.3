Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE439DBD4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627170; cv=none; b=IgOy2ZLm0X9/C1+GD1Y9vHLrG4fxOa2LpzVoxY52+/UbdxX6rwJVgcrSWreBCc8KXMeEkai2eVxKE7aEz/1IK6mj14GKGbUYCyH4H7vy4sQ3oxLIUvrMZhlTkFVFYaAyXZQqJgwsq6ZPiaDRLzT2df6OcbrL6SPrEujkApLbwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627170; c=relaxed/simple;
	bh=abqDqCnRqAyyo4ELedbquiVG1vdYP1OiuZ/nsXanvC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjXRF1qeDn2gRILN/uD9L02h7phYbmwinbj56tOtrs7rXtyROMWdT9Neg7HCauYTsh8d6/Dq+p6I5fTGr7v90OhSQ1/5ZgtsLwxfKhCO5VKCy5gbJIWEi/LFHzj9TGxWW7NKJYDheaS/48Ct3EU4F8VX7hBuVFSyrOgK++F+LBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=BzYy1wnk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="BzYy1wnk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so343627a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789627167; x=1790231967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edZH54A1UVq+JX2TRU8TzE+NFDu+F1qSIV+MpMxqQfA=;
        b=BzYy1wnk6zGfjzcjwMFAYQhre2ptFjd7ShfcS96A83zB5yTLXxgIcIbu424lVhNCDG
         elxQAKkgIrAVcu9TgvIarzKUoDSTQC59aTbMOrZAuYLYT34qPdiXgPB7yNh3yK5cfN9C
         fuQr6A6I4AOn1PFWRw0RTN+aZrvDmgMC6jPVwZX1Bs2MalS0Hk9ZoLCNGAySrS6C3TOI
         G6esl+eqWPTv5HeP9gN0K6JHDEK85zaPBbRwzQO3742arvHAz/xZcvWfZXzAVgPGtpN/
         /TjCLInE81BoJiNycMl7xMyJ/Sle4dQxKN55LFSyUipNDvwiyGeb0tZf/2rKmeLCGn82
         +r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627167; x=1790231967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=edZH54A1UVq+JX2TRU8TzE+NFDu+F1qSIV+MpMxqQfA=;
        b=dzLC7wiRLITYZxr47TWEEiBUF2WwVJtm5L8VqFpkOa7EDP4obKAvpYKUCKNP0qvbwO
         0Plqvvm/Wu2k8DyPXsab9eJ68kHNjSMUAbzG82kDxL+/W2jH8niIepyruR+eVSLy88TC
         XNbKjBINoFpp195XSmPdeQyiNm3u3l4WNUcUtpeVb6UyC/wJ5gdh3+rVWkKeTc/pcE/9
         2OzHKTEP+x5QOqXL70pHkaev2gcIuojvF8Zis0hdKKfyAZLiGAN6yuJH5dKcHNB30xYh
         2kvoIzperViWd8zHfUhYIZr8Z1+vXXjzvaing37KlYWwCggVimeF5ujKoesRlI7NhgID
         JrLg==
X-Gm-Message-State: AFuF++mdNHEg4xT1iJyZolFAr77vTyTT6Q2rjEKu5DwKLhuiN4klhw6o
	vTxDpwTPf2jKZ5zpOVB9rJ2yAOuob/KxhOZiR9wSG6kiZrwd431cPZ46kbv0CuKGPxXRx6LO4Q8
	QKhH/dz2JTyGj1v+u/UvMmIX+UYjJyOMfUx4SQVCbFzKThEYqyNsGTPn9PUJ50Ubs1DTRBjxgnE
	Sp6w==
X-Gm-Gg: AYBFou1MXTdtVEBEdFC3CA1/h8B3grSB9qc1eStAP9GT81943Fsbld36woND7T22RRJ
	TaksEr5X0a/DCvunYQFTsCKMJT8pms+FxzKQYMBBwl1nlVAmB24QJD2M1T90baEW8q0uGCxp7UH
	heGix3O1CFD4eyXSXhbF50z8jFOSQ9cufedLPoRcDT4fp8IK9BWf8xvx2wGqtafJ+M5+C+4hiQv
	y4ljahX8NJbpXQaQVoCP5g5q+RDZyzaI+SXSC44RDh21S5pBsGJrsAar9hi7QfoklPTyWMBm6Dt
	bshJ8Lt+lcT45KhDNskPiBHYm45doO6obNH60IPSRv6mZixqHYXzUFMA2jWUBUFuW0jMfdQbzaM
	ci2o66fDJrrzCnthRv4UkdM9Q+ikKp9nP3nq4OSYPOPRWlMsDR3WhsDOmuEs0TUbiXZGSNuTSJU
	HNUhE5LdWAXixTXAizcG3sDORXgMDcuR5Q/nOdAl5oxASYfXV1J8Eunze/Qs9l2lhGiKTNha2uu
	+6PquYiH8k0Z5KDqBmS4kw=
X-Received: by 2002:a05:6a21:8905:b0:3db:5b7:e9c2 with SMTP id adf61e73a8af0-3dd724bb1f7mr3085911637.4.1789627166753;
        Wed, 16 Sep 2026 23:39:26 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d76834sm10904606c88.14.2026.09.16.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:39:26 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next 1/4] net: core: factor out the GSO device limit check
Date: Thu, 17 Sep 2026 14:38:51 +0800
Message-ID: <20260917063854.2011613-2-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917063854.2011613-1-wang.zhan@smartx.com>
References: <20260917063854.2011613-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gso_features_check() decides whether an egress device can offload a GSO
skb as a single TSO frame by comparing the segment count and the frame
length against the device limits. Move that test into a helper so that
the bounded resegmentation path added by a later patch can ask the same
question without repeating the two expressions. Make the size limit
lookup take the protocol as an argument, because that path has to ask
for the limit of a protocol other than the one in skb->protocol.

No functional changes.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1f0710eef185b..427d0d5b94e49 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5570,10 +5570,10 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
 }
 
 static inline unsigned int
-netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
+netif_get_gso_max_size(const struct net_device *dev, __be16 protocol)
 {
 	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	return skb->protocol == htons(ETH_P_IPV6) ?
+	return protocol == htons(ETH_P_IPV6) ?
 	       READ_ONCE(dev->gso_max_size) :
 	       READ_ONCE(dev->gso_ipv4_max_size);
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a4..428b5d057287c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3834,16 +3834,18 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
 			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
 }
 
+static bool gso_within_device_limits(const struct sk_buff *skb,
+				     const struct net_device *dev)
+{
+	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
+	       skb->len < netif_get_gso_max_size(dev, skb->protocol);
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
 {
-	u16 gso_segs = skb_shinfo(skb)->gso_segs;
-
-	if (gso_segs > READ_ONCE(dev->gso_max_segs))
-		return features & ~NETIF_F_GSO_MASK;
-
-	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+	if (!gso_within_device_limits(skb, dev))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
-- 
2.47.3

