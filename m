Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4334C042B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766949; cv=none; b=UIr7dWdUPvAnSGNmHF2BmKLpx5cSkIjkTYfIPMg7P+jCOqjADC30XrJKF/h/oE92Fq6CQRcEoJSZpAU3fzkRLlHpRGzORrE7mlQf4cEy4FgcjMepE5mHrF+22lvNbRct/KbIkYc31bvYcVFUnvraAoTXyFESY40j7PEU5U/qOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766949; c=relaxed/simple;
	bh=0FE6KPICMdlWQSjdUTOm2peJ49+f2tims/bjkf7H5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjeEXRxeGxe03XfbqegmKAQk7t2eR4W4Prf8Cvfhcqn7/4Ycx/8nwgJ0G+XgtB5CUkCRsH84zl0tDwMbmIR0uJ+yb637O9+PX7G+39SPOL79ZlrR5OoLFNHb9D7Gx7qrNqUhHC+yuldtmzi4WnLLbdclSrIkCDbmaJIqeCUAAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=ACxpnuCL; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="ACxpnuCL"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso1253933eec.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766946; x=1791371746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFRnQApo7Wa0FBVr4vzAKAmd7OVAgmjVJTuSiPga13E=;
        b=ACxpnuCLeaQaGnrxIWApQdj5sHpnuGgOiEHcHaTqasHAc8EpRiafaHwbd5AdmaF28b
         dcVMinN9nPzK5FJ0OB3sIGJrBCnN2ZED3LTQOmwlLz58eWGZPmJYzqfU5UFbzoVrwKhQ
         aomG+pwFUwVjrqfdRMKxwYcg7EvpkcT0ffEfHVGh9bWyJRq7pi2mco6Lq99H0iLUI65q
         VKbOhY7gQmg8dHevfRjPpvIKthUXyb+R+HO0cjkQL85NbHRgvsd3NYs2QAzQKkMzdT6A
         z/+MehBI2GzOpGaYhLoYozeqkoObbRLV1pwijVCklWQX/8RPfwaMU/CKDbCBS/a20DeZ
         rKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766946; x=1791371746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFRnQApo7Wa0FBVr4vzAKAmd7OVAgmjVJTuSiPga13E=;
        b=ESkSm+0IBn/s/cV+Rcii+Ofts/BzjQNOmL48Tt5jKAHWd2lOM2RJZtii5+qSih3Jgd
         5a+Yp4+NkAO3b98IG5wbn3zCtjP/rYVaXj/daC/4Cd2jPO0aBPBL0fD+UTOHKeRtCRpy
         H4d8JUVhcXht+cOVi7IulnWXdCkH7FziObC4ytIXzOeyEunWpRklBDiAsjgSnlCqZE5/
         +KrDNXtAyI24nWhIFdLA9+9HR/3FNxP20A/pxiVzxlSRMyBGrtQPTlVWJ1RmWlBKUuv7
         a37baGAAs6bLWFkUSrDukdLh5p7X949ngR17deieT1HvtK9jXjGgKrnmz8cVLItUDlRB
         VvfQ==
X-Gm-Message-State: AFuF++mpwYaxV2D91GZfwyPEC/c1Ww9ok7BDr1ejlrBg7T/LVDrPAM5l
	XW5a7cOnA5EBJzc7cMb1z7gGa0QvncnNmac/Z1D5Bnqp1zmG2BYuwSVQIKjK0uRdcGC8L4FHdDZ
	nu2q17q1Yq7bWE0zw/Y1zq8UdOJ/qookRn4vn60ypb6AskwoxKIvvJitKhUuEkmgt9HSMvrre
X-Gm-Gg: AYBFou3xxQ4eA5TaRPOxLk2agIwB+aUC0/kXmoqdUjpx3/lamTw6dV0eqGstID/d6dj
	tdiXPoQnnyoc0afISFEOdtKLWdfMtYGZeIOf9y9fuhXJSRHydDIDTWAU8t/rEKSZ+JpztIfXMOV
	FFaP5fzhkPDUNkIXv2XeCzqzdLIGslEXv+PrLI8hmnIRypQ6QUNC7AztMsxKgl0g/VvVG7Flr/8
	LiQ8YSQUR1RFLyDziwBlHn+pX79o4tPccEBcs0VeTr2f8O3bSFo4GiSa6WQ9iCYQ/62LeJ2Gy8O
	JK/KDdfH1o8EE5bX4XOC7r9+EwR1fWOOeu6hHMNRncvwpSF7fzgD/Y2Fv8GB+YxTOEmNbQwOy5R
	vnVogWgD9bb7VUzcLKcRYwdlE+69jWO0PnvLGN72z1d+QV202eFJDsAzzGDK67pkcuq3x2oPGqY
	CPmcKfp0W787/jw1rO28MmmN17VRcFlQFD6gdCukwaUiScX5rcHASO4Rioc/Dq9jiP9rc6Ib+sp
	fKGYf3ZGN9+YMpT7qWy6g==
X-Received: by 2002:a05:693c:6394:20b0:33c:1bd2:1d96 with SMTP id 5a478bee46e88-34cd9c59670mr1440833eec.0.1790766945330;
        Wed, 30 Sep 2026 04:15:45 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:15:44 -0700 (PDT)
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
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v4 1/5] net: core: use the packet's L3 protocol for the GSO size limit
Date: Wed, 30 Sep 2026 19:15:22 +0800
Message-ID: <20260930111526.2183107-2-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930111526.2183107-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gso_features_check() compares the frame length against
netif_get_gso_max_size(), which picks the IPv4 or the IPv6 limit from
skb->protocol.  A tag which is already inside the frame replaces that field
with the VLAN ethertype, as skb_vlan_push() does, and an IPv6 packet is
then measured against the IPv4 limit and segmented although the device
could send it as one TSO frame.

The lookup moves from netdevice.h into dev.c: vlan_get_protocol() reads the
L3 protocol from behind an in-frame tag, while if_vlan.h includes
netdevice.h, so an inline in that header cannot call it.  dev.c is the only
file which calls the lookup, so it becomes a static helper there.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4:
- drop the Fixes tag: not stable material
- move the limit lookup into dev.c, so it can use vlan_get_protocol()
v3: https://lore.kernel.org/20260928044102.1004310-2-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
---
 include/linux/netdevice.h | 9 ---------
 net/core/dev.c            | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d037faff7c44b6..421c0f5952463e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5561,15 +5561,6 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
 	       READ_ONCE(dev->gro_ipv4_max_size);
 }
 
-static inline unsigned int
-netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
-{
-	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	return skb->protocol == htons(ETH_P_IPV6) ?
-	       READ_ONCE(dev->gso_max_size) :
-	       READ_ONCE(dev->gso_ipv4_max_size);
-}
-
 static inline bool netif_is_macsec(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_MACSEC;
diff --git a/net/core/dev.c b/net/core/dev.c
index a8eb382f40caf3..8475d5da64fdf0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3869,6 +3869,15 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
 			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
 }
 
+static unsigned int
+netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
+{
+	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6) ?
+	       READ_ONCE(dev->gso_max_size) :
+	       READ_ONCE(dev->gso_ipv4_max_size);
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
-- 
2.47.3

