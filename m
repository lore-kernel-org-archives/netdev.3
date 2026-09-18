Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167E2E22B5
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721251; cv=none; b=Sx0zgBKWIIy4hlkOoOU62CzX7ksSivEE6jl0qomRxlbuAf1lyK54KK6Zu2vPBkADXivTwiF+mY5Ojepd87kBxK9wPfMlUFtJzPcVgfQJbNrVvIi20PMOQUgrc7paHQNl8lsPpVxmpEC++ua9yp8FLCOVh00jPv+py+GUD60C94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721251; c=relaxed/simple;
	bh=IuVsePh7z8Id5y5Li1KGjaGe1AUklHbKAmwdONOZ4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNsj7KWRYe9iCYaJhkNG0YB1xjIVSOIEpeksfMSC46Uqj6IKEzU2B3TemjbCvnXh7beUBlPwLVD8YY4e5W8ewWjdmeYKn2ifiQgXiSjJvv9+jD0jJrU2CLElytBMOC0Qc3kv98gGfvyPTvp1XgU32tt8PVKno/R5MyvqpIlyeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=LjiPLIJp; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="LjiPLIJp"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so403219a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789721247; x=1790326047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JATPyfURZdDNUWybOCYHt+jkzOyG7dUj/Yjna4N3hd0=;
        b=LjiPLIJpSOnOCS/PoW2EhS+Ilh8T6uOkDAQ3N6zy050ynsJ8JbuQ3VlcYAgHlJ5Bx7
         38PZHnjO7jHTEWdfN2BIwJNvCNOxBltyMK5AkGl8BAlN8JyAtYW6IVYF5FWYxPizBKeW
         0luMPF92EXQw8BFjzaBeCBG7KL7LWYtKx+0+mviSns4y82NcSBNMfCIo03DsO33UHab8
         LzvPx3Z2SIcKAys41LLQpjiSWINJxq6CwOU6ajku7CDHBfgTNb2IsmZ9pMyxB4zEYTGF
         N3O+pBfOiikVZtpKcOacZ4fqpNZZkRlmby7QfJ5yMA1h2m+L1LseudDzBRALk6HWlDdA
         jDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721247; x=1790326047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JATPyfURZdDNUWybOCYHt+jkzOyG7dUj/Yjna4N3hd0=;
        b=v052rUIW6j4GuYhjyiMiWKhkEgMFXGn+ezejoXVvaOmApdmPSkTVq4QwteyWf08KX7
         EKxBIhfOFGvrr/9rl5U7KO8qhJ5gw/FpK8kkcs7dbYaXXu78JU7WaHWVspTkp066ZEVQ
         AYih3TOQ6ts1n9cm8MQQ9kwaL2efaPGC5HEhokrPURiEXzMkR04wMV0DJ8T9GjL7HbDI
         lvH9opXias/OqoP/Cqzr0AvbqJBGi6Hu+grqvuZGDkiK87WSsN6QRgydIT5CDqGdNiQJ
         lfn4wsxb0kCvV1YWb6RZDhJYW+n/bM60X3rkBOIpBwkW6KdjX5f+5a2/oOMIyq3NA6Qt
         w5ew==
X-Gm-Message-State: AFuF++kluVrQZmkHFT+KZIBJBCn5fzKacn7y0aU9feFSTfoBQyTKdftQ
	xm5BGE1YQZjcw0ql05pm8DqGLBhWpgf7Nco404KBPVYOr1iNXKb8HFfOHiwpbvFzhqo1FvR4uG7
	SbTelennReswjYsOcKyGdo4pJ/KzPoWNxZ5OEnA+G1dmdmidqexD+akRxMuWm5eodQivNYY/eZ1
	AcHg==
X-Gm-Gg: AYBFou0fa3FniR1q2mfjj3x82/jOeXpNrB+R1XO8ulBcSb8e5p7yAWy+ghTrWHGXpdw
	yLmPVtmMCcqW2iC6bdQ0gor00sybXAWKWpq1GWmE54nWjpeHxrfmB2p+1I5djEcEYDTkIOqMSLa
	wXoTimDdmFizLFHAeYcPxv9kLsH1Won4ztlh15BkpkLH8rwZHFDu+s858vgribpr5iCkqpkugRO
	Jc07xSYOzuwWMayeursbLo2mRqoCech1Q3q9S30EGRPT75yN+VNbY0mYGtFVmNHIa+z6Vl82lPe
	swU5kAMMd4ZI7RJtAM62gBpOEnTRROWkqDjzcG1JFz19KcsQDvSu7qOS+KHq5IQjvQEYw5YFEL6
	lifaUJ02nKLaa0TRRRNPPmp5wNsHuGQ+VrfyJGsScGroG7xI9hhFy4I1j4O1NdUQFTkbgkxsOP8
	pN85BP1SZt8N1xS2RIAek2gRFzaLGvCtRg/pdkMHroh7mUB65iD6p29d60FUCRNPfEtVmT0eQ7A
	e+RCKrQqTU=
X-Received: by 2002:a17:90b:5287:b0:39e:3285:b776 with SMTP id 98e67ed59e1d1-39e54cb9c71mr4346420a91.7.1789721247228;
        Fri, 18 Sep 2026 01:47:27 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm2578095eec.22.2026.09.18.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:47:26 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 1/4] net: core: factor out the GSO device limit check
Date: Fri, 18 Sep 2026 16:46:48 +0800
Message-ID: <20260918084651.3022878-2-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918084651.3022878-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
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
index c67900354fa64..16685888b2812 100644
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

