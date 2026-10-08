Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B37492E58
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454040; cv=none; b=qxvhP0iyxsOK/DInqtY7bycqrrr81AP2+ErDnqBAnp4UuhyXxxAmY9IY7UVVsjhQ7OEqUH/ECKQQ3LKonaQswvZMAggb1766wdIW9oWpBSE9MnJtqoeTya+hLWRpP3uS7FCtHo2hG9posUq+sd0eUfnANY5gyHjDiZin1aWJ/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454040; c=relaxed/simple;
	bh=qr2M40/OeZPg3gAxgI5DBpwgxzqgKjUIykAcMaxKae0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz/H8t5HXPlGMwSvA9RsR55Kp6tvCjYvwaXN4HOWdHCLfXBtQH5n6SeztyZg1QPGoy5TZ+DOTCvdbvo9HyZTRFx2Vsc45qHKKCKPDJdoQOKFVxyT1qesCOeJV43JsPScFsWd/Ax0fSQFbLkbf2Xrh28ZO26Yfrnb0rT8LZBWNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=KF01HxXX; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="KF01HxXX"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-150f88d22aeso2318622c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454035; x=1792058835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyJKZLaxC3eGn9JH9B6bCUPX7yTQOVPR0YYPpEWeufM=;
        b=KF01HxXXc5RSYHNN3maXWrdUfac7Rv324YnhhZs64nOPnyIQisIiPskQTI4xrTbASW
         t0sGWm2Qb/YEYiSRBIxCxYXDvWXQgPH70GcGI0yIBksMz6S9ddhHuwlz3P76I9CVS6+o
         FruKsEaahJ11/Q73u6jxHXtxxUMz0opf/UBRIPrbrsbjtVVifUPSaKStxRHWqxNGzM0t
         hQl04wETZEqeINbHm5mWqSqzvQVEREwBeAbgmXjiKP/upIQfOzhvT9Nx4U4k9VAB/6cN
         D9RnSakh9CJM3lwZ3u8Yeys5U0FnESbKzJdsR4PGzdZHBA8Uq8IOL5jCT6hka83U21ce
         SsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454035; x=1792058835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EyJKZLaxC3eGn9JH9B6bCUPX7yTQOVPR0YYPpEWeufM=;
        b=PyC1JykNYtnEaGi0BHFtlsZgdycMbOlRuL3NZn+93MCS1SgUxBHo78vkW/F6yGrm+N
         KzMJ1MAgmp3LO8IxPh2ilYEiG6wrS2BUnDvFN9aiD0N3LMHiyBjy0N2DL16sti5VMFLD
         ERmo/rLyRmzcniw9CQLqOcO0D7QlswzsrvYgguegIMTFxKg1mSOVXM4GtsZWvpR1fvRU
         ZzgPCe3GW+OPhvzcJUw4L8A7YaaxQwqodQ7chQZ0gkPPNBXseLX74G04EBhrZQMruogn
         KODsae0iMbtXgw90dGrw9KsP1Ii/dNjBaEL+UJ0LFiD6oXMjJ5dA/zyhN7GaNSNUjFrg
         UO1A==
X-Gm-Message-State: AFuF++lOv8SDpD3Y3WDOr5BT/SZedDDi9aQ0IMdkn+kXxrOO+Gs3HFHg
	Xe78Ib6zDxM9VdKyZkwlZFDAOk2nioAP6XpBh9TdLoBUSRhnpEf0YSaimHAcbZVuYBJMyIDzHHQ
	RlMzNGTJbSxltuSg6hj/vXnmLwWSWdkwmcwVXNeNcK+aV1uuO3mTfvWizUycQ/v3JnUQtAuLQ
X-Gm-Gg: AYBFou0UIzgOo15f8W5HkdNG1TyjIQnTz8c2kUYfQkbr2pCh8EZls3kxYNVRVx3X0ui
	pjuHcnVRT78RkBaz0nwc2m8S/6Exdyc2u4cxErYfUrQVKZreTAjNjkbHE6AMrA8RETDmdXtTnVu
	bo70Ep9vF8zqLrRlB5VGUU9204NJ/R7pgDJJFpPbglOEaBS1EIOesoCiUz5DmSY9H6Lhqd3jEmZ
	hsNXOLrTHlBkWPp9axLcExqu90cv38vJQRdgwdT+kNnBLWPA5YWTOfBe1kCyllxA0fVb7FZnmij
	eY2lbN7sZUfeIgEVcr6u9vGUaoLAXnNHRWbzGS3Ym/BaC73R5/uePCdbowoNLipR5Gx4o1llgjJ
	nna1jfQ+CEInGrhyGKeN4ZL0hF7racO8p7XLq8ZgMi1n89HxEkrwCgFcyY6UJVMJ5f17uehLuai
	SqNY8XlGnVJ2QL1t5btBkEH84Aix6J7ZXXBU1Ei+oFRdTsCDjolZHSDSGmAifRmLQdeWiSzaZzj
	m+MaHid228=
X-Received: by 2002:a05:701b:2204:b0:166:4b44:66e9 with SMTP id a92af1059eb24-1664b4467b2mr1939234c88.32.1791454034939;
        Thu, 08 Oct 2026 03:07:14 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:14 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 2/6] net: core: factor out the GSO device limit check
Date: Thu,  8 Oct 2026 18:06:47 +0800
Message-ID: <20261008100651.2534957-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gso_features_check() decides whether an egress device can offload a GSO
skb as a single TSO frame by comparing the segment count and the frame
length against the device limits.  The resegmentation path added by a
later patch caps the MSS segments per output skb and needs the same
features computed without those limits, so put the two tests in a helper
and gate them with one flag.

__netif_skb_features() takes that flag and takes the place of
netif_skb_features(), which becomes an inline wrapper in netdevice.h and
passes the flag set.  Existing callers keep their call, and the
resegmentation path asks for the features without the limit checks.

No functional changes.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4: https://lore.kernel.org/20260930111526.2183107-3-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-3-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-2-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-2-wang.zhan@smartx.com/
---
 include/linux/netdevice.h |  9 ++++++++-
 net/core/dev.c            | 30 ++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4819acbc06ead9..feb5fa99c2c629 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5498,7 +5498,14 @@ void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
 					  netdev_features_t features);
-netdev_features_t netif_skb_features(struct sk_buff *skb);
+netdev_features_t __netif_skb_features(struct sk_buff *skb,
+				       bool check_gso_limits);
+
+static inline netdev_features_t netif_skb_features(struct sk_buff *skb)
+{
+	return __netif_skb_features(skb, true);
+}
+
 void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0aedea7c9ffb79..d6e39df55cd8cf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3897,16 +3897,24 @@ netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
 	       READ_ONCE(dev->gso_ipv4_max_size);
 }
 
+static bool
+gso_within_dev_limits(const struct sk_buff *skb, const struct net_device *dev)
+{
+	if (skb_shinfo(skb)->gso_segs > READ_ONCE(dev->gso_max_segs))
+		return false;
+
+	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+		return false;
+
+	return true;
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
-					    netdev_features_t features)
+					    netdev_features_t features,
+					    bool check_limits)
 {
-	u16 gso_segs = skb_shinfo(skb)->gso_segs;
-
-	if (gso_segs > READ_ONCE(dev->gso_max_segs))
-		return features & ~NETIF_F_GSO_MASK;
-
-	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+	if (check_limits && !gso_within_dev_limits(skb, dev))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
@@ -3955,13 +3963,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	return features;
 }
 
-netdev_features_t netif_skb_features(struct sk_buff *skb)
+netdev_features_t
+__netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
 {
 	struct net_device *dev = skb->dev;
 	netdev_features_t features = dev->features;
 
 	if (skb_is_gso(skb))
-		features = gso_features_check(skb, dev, features);
+		features = gso_features_check(skb, dev, features,
+					      check_gso_limits);
 
 	/* If encapsulation offload request, verify we are testing
 	 * hardware encapsulation features instead of standard
@@ -3984,7 +3994,7 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
 
 	return harmonize_features(skb, features);
 }
-EXPORT_SYMBOL(netif_skb_features);
+EXPORT_SYMBOL(__netif_skb_features);
 
 static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    struct netdev_queue *txq, bool more)
-- 
2.47.3

