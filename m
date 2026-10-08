Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E11C3F0C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454035; cv=none; b=B3qUjh0G+DBkmanCY+LbBh6mDmAc+zQBoaUYy1ULLUN56XnS2xFW6cLgbJ84O3OuQx4A568bcWuNi1TDvqUBs5pDS+2JxEvTEk3aVtmEGSty0P6M/NRGcD/ps8e3YZVGMdIUXG+OvMW3GdpbhVFfNyOCU7Vir4Ta5cynYa3dS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454035; c=relaxed/simple;
	bh=FKpBR7hQo39BL/dR/mgDOn30cx+5yCGTaAVu5tEL3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsIDGGOBJ2UBt5g9WEztnbDAgKFN4HEDE2O6fqSGuErU3wQ8s5N1MwlyuudRa9z+qRWRbZLFVle9Fi1PzoSwzK9STdpSn5m3tUHpkP+cnbSX3ASU6M4RTXRPFG3s25i4iIJkPhWr0WEjn8kcPeP5KFBkZf9MP0Wy2KKNC8LpXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=V/rk97gc; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="V/rk97gc"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15354aa70e8so1090755c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454030; x=1792058830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXTxP7wPqB8O5jCM9UZCzUB+8OpldS6fGVM+L+IgMUE=;
        b=V/rk97gcH8+cqJEgJiE56YT0PLqzWFpkSvDrLhN+G1Y/FGnjGl3xdqSbLeisJhhBTm
         6yLmMno7GpPe8/XttHuNp6iEmutD0xgLWZTdu5zoNqlHl78K6wEHLT0SzP/T19189SHB
         +pM0T0wA1mvvMARUxTqEtZBRQLZLWx1hzkqbh/u5iNWJIA7r9UzPnVaYZn+JCL7av3nd
         rB/QqClLpiMyvySbXsFRGofPpRljzHBlzRDinjbKXv4UQSFge+RMHe+IsxFhh6ThGOei
         778p1c4BxaxaTuSQBqtKoUsuta2z67vfZWFvvyZTg7kV2Sr6jBMHMGPVt3664EjnTrEK
         XKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454030; x=1792058830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXTxP7wPqB8O5jCM9UZCzUB+8OpldS6fGVM+L+IgMUE=;
        b=BaXm54WVA/6VXYPB/d1SypciHb9HPDyery5TqD3M3FR941aODZup/NESTa72StAzl1
         ZiSlMw1ycrgFvK0iInDavwY/6vjLNi2k8caoEOABa9n/RRh/dEtnB4+rM9aYkcKOQIC9
         48r9cpYqvF56bA4XTpNH1HklRaG7eJQHIaPVWW9CcTV9ObJX8psMslqWy5LHX3IWbMI/
         1Qq4Cn16Ld3l7+yq3LvmvnJkGSH2IYGaqEpmOmaJyq4wySAn6Z1hoEkc5g6ckqDGIeq0
         b0mUKylslej9JE+7wJEuUagfUqqJBhoC1YcKmcqLRER8yuJmxxuIvjIfRCzibhtGZPlL
         woqQ==
X-Gm-Message-State: AFuF++m+Nql/bqdrv6z0vGNd7TJguayg1drseiiQFQgCprxqlKHiPMes
	ZrryAAMWr9dIm/2J+2p3fpCmehew2Cj+8EIOcMyvYe21YUNZkBv23er8Q/tJXhfWfE6Gb80O8sm
	JC80i0rwgqHPRHhhr6bNrrBc9mTYYIxkdOfsQq2Gc4R1mIc1aHn6OKFqrXOMgE41jbO1nNHlK
X-Gm-Gg: AYBFou2BKOxW9T2FeXD9sq2r9YTRzbl53UexBFC/dQRL2+cXl0G8+L7G2tAPUcYYCDV
	wNx0NCjo/IcDwevBkwLLkQBhsftMKZ2sZ3cAJHtF8HpKVU3z4m6rM01JGUQrbG4SHcoHbA5NYza
	4JKyxnGr+D4q1Op37tJAT3EJMgDaC8FxSq9YsWV1ysB2fehSExJZcTWnF54FR73eGZXdlcw99AY
	Mm9OIQNb3DcbZNS16ZIAz3StvNkG05f6lfv82udsWjD1O5CSuyJh9/T8Hu1GsW80HBn/cvrlYPS
	BAcwwzjBK5bqbUVpUqOxiP4QHr5vEonCnfdEAAkdwvg4zIsHtetnmOCqvaN7CcbQEnh4Fh9GBFu
	C1Sz6E4QPrBadu+ZtabU/ujgg0NDEqWiiUc4b0+wO0WEq39NC8/DUd0yY3nrc808Xte0KdF5Ijv
	F/mQd6mkhlRPVXdU2EM1Chswn6v28HRnbMqR0yiM4Fs5IuE12w3Saf27tKFgm7EGlkjDMh3Is2m
	65Z6djOnUE=
X-Received: by 2002:a05:701b:2802:b0:15b:722b:4bfc with SMTP id a92af1059eb24-162088094a4mr5144719c88.31.1791454029089;
        Thu, 08 Oct 2026 03:07:09 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:08 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/6] net: core: use the packet's L3 protocol for the GSO size limit
Date: Thu,  8 Oct 2026 18:06:46 +0800
Message-ID: <20261008100651.2534957-2-wang.zhan@smartx.com>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4: https://lore.kernel.org/20260930111526.2183107-2-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-2-wang.zhan@smartx.com/
---
 include/linux/netdevice.h | 9 ---------
 net/core/dev.c            | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8cae9b00211eee..4819acbc06ead9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5564,15 +5564,6 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
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
index f587645e930a15..0aedea7c9ffb79 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3888,6 +3888,15 @@ static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
 	return false;
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

