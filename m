Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9E4B0483
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786753189; cv=none; b=Jt3bl62ZXB3iXBBxBCgeDjXkT3bXXxTEfRyATJvfR0b0PTFlQjMNWgt60aodx14zZuMxxEh/65p95NIKA2cCbVAEFbf7u631+HQeme5QVN0WtE/7sNarimPQ/x8Yksq+taDXqtFCZJEatipJ5eJLKWaa/15T3hN+pQmWjeOPhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786753189; c=relaxed/simple;
	bh=l5/rNrEDt25wZjSYD0pdYsmPtVIz8KgPZOALlUh8zJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzUJZeQOn9/6MY1H/sX9fr0o07cgKrCqUDwBC6Li9bbMsstibb1iQdYEFvuS1mFh5zlkyJjE6h0lgpUAwVhVOvKUrXkiud/AH6npT9MAL+ifxW4xTDyNIqxBAFFCP9ub70XQh0ble+tPS18tiXnY5iSXRzvR2Bdv9NFwtmDOZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so4229885e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786753186; x=1787357986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7IMe4hja9o/pB0bltn5i8OvJ0zh8ZQVJDZUWcTaB8E=;
        b=cHYvXRngRdfDJJIaptFXkPlyZ1xO6AjEFOPdOCxTL5NBzwsl1hQX7lqkwndTMsq281
         GEj0K1Me4Aa3Ht6XyzLbY8x4R3ULjbSBzktScV/ynhKaEk3SfTSHejl7OTAQS8WfolbP
         f+ipY+++5VJmbpmne5kYsGsbcDzLke8AQU+gToFZ1P1bK6uYtpo/VgYpM4vfnVLmQk2k
         c7bsg7sia2+HI5MNRPZBkEmhNucxqwu//+UhFmtHUqu5++up03HnDpjjw/BP4W8ncF6X
         OeVlqQbd5I1GqCUR2Nsk0AO8xmE4myQNq0TwaSnMIck9mOvi8+oi35mI1Ih+Xll60tXB
         QEsA==
X-Gm-Message-State: AOJu0YyNuSm1Hvw0xS2F+UZZ4F6GqX+58Sq2yNHHyX1bJyLoxmAYrm66
	PwmipYLxgiJa32HPj+4l42ZP7RNeYIdARng2AWfYokVY1h7iFzYeKRPp5IhzYT+J
X-Gm-Gg: AR+sD10u2AjEOVtUvoOypIGls8pdXbq8mHtWQuxI1+4JkTJ77F5FZmWlxYGWsKeRhio
	4nTHuU27XFBKOl+pk8QF4JNFlCU+kE+ux2Ga3wsYcW/rT3nKBBrzbshWcUayvVgevJLDEtIaHZs
	EzWNq8ElnqLZUAkeJraE4aPmA7ut9B6hSnbMY257k5Mkhjv+zl5yLRzSA7mO9oEiBGnWmV4LXIv
	eGcmTuIcIpgQqZazGVpeN+6IpuFej4eMyeEPp7wPPfJjC12+cjcDM9eVebQXfaEZKGm5dE7mfeN
	Ah971v68uaVTqsmKVx9xyBa5opua+O9pMndNB4vTAl99LETHS25U1BE9t07/3XjD5gZA5R2gAgp
	mJu7kg3e20yBgkC6Tev19LJIdYyUPaLeZAt03qhPHU7dE9lH2Slb3xJctmYXZYvZjNN/w1A9tky
	kRDdn+EqhrB1PAv4TUjoagbMK48xmLVZutX4nWJ4lzs18q42lZLCLVkmcr6azuCCNAJ6edBWNwB
	amQnfsAcWsRMfcIeqVP
X-Received: by 2002:a05:600c:628c:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-49987f3a33emr150605915e9.15.1786753185926;
        Fri, 14 Aug 2026 17:19:45 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm12315595f8f.24.2026.08.14.17.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:19:45 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next] net: ip_tunnel: remove unused non-strict __ip_tunnel_change_mtu
Date: Sat, 15 Aug 2026 02:19:32 +0200
Message-ID: <20260815001942.1089545-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user of this function was the recently removed vport-gre
module from openvswitch.  Let's drop the function.  All other modules
use the strict variant.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/ip_tunnels.h |  1 -
 net/ipv4/ip_tunnel.c     | 17 ++---------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d708b66e55cd..a8bbbc5db5cb 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -412,7 +412,6 @@ bool ip_tunnel_parm_from_user(struct ip_tunnel_parm_kern *kp,
 bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp);
 int ip_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			     void __user *data, int cmd);
-int __ip_tunnel_change_mtu(struct net_device *dev, int new_mtu, bool strict);
 int ip_tunnel_change_mtu(struct net_device *dev, int new_mtu);
 
 struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..609aed527dda 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1054,7 +1054,7 @@ int ip_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_siocdevprivate);
 
-int __ip_tunnel_change_mtu(struct net_device *dev, int new_mtu, bool strict)
+int ip_tunnel_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -1063,25 +1063,12 @@ int __ip_tunnel_change_mtu(struct net_device *dev, int new_mtu, bool strict)
 	if (dev->type == ARPHRD_ETHER)
 		max_mtu -= dev->hard_header_len;
 
-	if (new_mtu < ETH_MIN_MTU)
+	if (new_mtu < ETH_MIN_MTU || new_mtu > max_mtu)
 		return -EINVAL;
 
-	if (new_mtu > max_mtu) {
-		if (strict)
-			return -EINVAL;
-
-		new_mtu = max_mtu;
-	}
-
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__ip_tunnel_change_mtu);
-
-int ip_tunnel_change_mtu(struct net_device *dev, int new_mtu)
-{
-	return __ip_tunnel_change_mtu(dev, new_mtu, true);
-}
 EXPORT_SYMBOL_GPL(ip_tunnel_change_mtu);
 
 static void ip_tunnel_dev_free(struct net_device *dev)
-- 
2.55.0

