Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA04AAC78;
	Thu,  8 Oct 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470002; cv=none; b=gEqIbpivR6/Fn71GZSdH6uy0aNZsXdbbMCe5Hyn7Flp6qzQujyfH9ZU1ElCTOhY61j2II6rQfhfxe8JeSpZoKluBiPA6hRQIqjt+/lQGKtsNE0JEGMkoNBB/Ih50CUrojV0QsSfyli9IjdDBSR84yzehB3jHi1vidxW6pPRw+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470002; c=relaxed/simple;
	bh=5UmvWoCtS8s6jibDEOF9jHIn7WzBpqpWL7V6BTuXKuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwXGrARAXpE43swPyWEyr95Y0wtHpFVIDpoluKKoAmAuUNchU5S/rFPePxryiMm4HcGFNZpYliUhRmu5mieCTWuyUNOvaP3A2iW/dRumgDjwqwid492SRleSZRCwbCZoE7yJlk3KqIpKwcr1jdz4xU3JCmfdbYskSjpLS6tTS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBB-000l4X-2m;
	Thu, 08 Oct 2026 16:33:05 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 02/12] net: add a PON device pointer to struct net_device
Date: Thu,  8 Oct 2026 16:32:39 +0200
Message-Id: <20261008143249.3439762-3-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PON device attaches to three kinds of network device: the ethernet
device whose rings carry its frames (the conduit), its data network
device and the GEM network devices that stack on the data network
device. Give struct net_device the pointer, beside the other subsystem
pointers, as an RCU pointer under CONFIG_PON.

Nothing sets the pointer yet. The PON core and its accessor,
netdev_uses_pon(), follow.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8cae9b00211e..1b4ed6ae7e87 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -72,6 +72,7 @@ struct wireless_dev;
 /* 802.15.4 specific */
 struct wpan_dev;
 struct mpls_dev;
+struct pon_dev;
 /* UDP Tunnel offloads */
 struct udp_tunnel_info;
 struct udp_tunnel_nic_info;
@@ -1974,6 +1975,8 @@ enum netdev_reg_state {
  *	@mpls_ptr:	mpls_dev struct pointer
  *	@mctp_ptr:	MCTP specific data
  *	@psp_dev:	PSP crypto device registered for this netdev
+ *	@pon_dev:	PON device that uses this netdev as conduit, data
+ *			interface or GEM network device
  *
  *	@dev_addr:	Hw address (before bcast,
  *			because most packets are unicast)
@@ -2390,6 +2393,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	struct psp_dev __rcu	*psp_dev;
 #endif
+#if IS_ENABLED(CONFIG_PON)
+	struct pon_dev __rcu	*pon_dev;
+#endif
 
 /*
  * Cache lines mostly used on receive path (including eth_type_trans())
-- 
2.34.1

