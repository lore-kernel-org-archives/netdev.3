Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336894D4886;
	Fri,  9 Oct 2026 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546859; cv=none; b=h0iOagMn9aku6pEJtmMTayotU3mauoyvTcYLzcUPzKplmaAnKVCm7MR7iGnKYiFnmXS2vdldbss6mJgfjzhn1O72Fv88rnZxT/f7ilpNWh1wU+SehRLMVYsz6Ir05LQ1aqqf1Kh0l1R8xNdse7zwKqlKYaykoNz53AdUXr4li0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546859; c=relaxed/simple;
	bh=hyKNij5GCovecZ025KXgJewZWnNsVvo4nF2Ue6FaKDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SXt3oTNEv9/SvVGLiKrF8DbaCO3qJ2GbPq4IkZkymtiCByPRiH0ZkW79AyP11kYLBHRCNLQNsUpobLLNk7unqUtc1t0iCGeqk05gG/T9HALv34NkTLkfvGdAvkwoG5y5fnotj5JxWnaHPSUIRAHwi+BUuhqX0x6FlxQUv3+mg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0swTayTj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0swTayTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791546852; x=1823082852;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hyKNij5GCovecZ025KXgJewZWnNsVvo4nF2Ue6FaKDg=;
  b=0swTayTj6o/04IYqmxrJle+lwQdFPROYXp4dBjDCbB+tRTDFveg3niE0
   qEJ2/SP81MfR2GoX62/2zGVvYUWIC7P9mjnIOc2o1uD28xBUN7gj1Fz/l
   vD+GKzl1ZpECg2baHYMAyqbF1VHMNGio3VmUyBzA50FiyHzhci50Rwj0p
   rQMXVpp+c6Gl8/etERIFoWR9w2t89hBSDSefd0aAHBS2UsHtsmPOCodYb
   JXBTNeLdFaA5n+/yFBt6NL1Ap24h+lMIsHUGN6KtVrTeuQfzmnkHpQ7IY
   gga9nRgPRy3L7eLViYyXqz1wpb2XBMbQH9/atUEY601Potn1z5UrGR2cH
   g==;
X-CSE-ConnectionGUID: asbsX0P+QF+sfkwM9CrAKg==
X-CSE-MsgGUID: xIX9leUTRE6gyZv9hyAkVg==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="296224250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:54:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 9 Oct 2026 04:54:10 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 04:54:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 9 Oct 2026 13:52:05 +0200
Subject: [PATCH net-next 5/5] net: sparx5: Offload tc port policers via
 matchall
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-5-4916708a7ea2@microchip.com>
References: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
In-Reply-To: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14.3

Offload a tc matchall filter with a police action to the port policer:

  tc qdisc add dev <eth> clsact
  tc filter add dev <eth> ingress matchall skip_sw \
      action police rate <bps> burst <bytes> conform-exceed drop

The port policer meters all ingress frames on the port, so offload the
filter only on ingress, on chain 0, with protocol all, and on a block
that is not shared. Only drop is supported as the exceed action, and
only one policer per port. Report the pass and drop counts through the
matchall stats.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 146d7f28e8f3..5bf17c52e564 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -43,6 +43,13 @@ sparx5_tc_matchall_parse_mirror_action(struct sparx5_mall_entry *entry,
 	entry->mirror.port = netdev_priv(action->dev);
 }
 
+static void
+sparx5_tc_matchall_parse_port_policer_action(struct sparx5_mall_entry *entry,
+					     struct flow_action_entry *action)
+{
+	entry->port_policer.police = action->police;
+}
+
 static int sparx5_tc_matchall_replace(struct net_device *ndev,
 				      struct tc_cls_matchall_offload *tmo,
 				      bool ingress)
@@ -98,6 +105,30 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
 		}
 		/* Get baseline stats for this port */
 		sparx5_mirror_stats(mall_entry, &tmo->stats);
+		break;
+	case FLOW_ACTION_POLICE:
+		if (tmo->common.protocol != htons(ETH_P_ALL)) {
+			NL_SET_ERR_MSG_MOD(tmo->common.extack,
+					   "Policer is only supported with protocol all");
+			kfree(mall_entry);
+			return -EOPNOTSUPP;
+		}
+
+		if (tmo->common.chain_index) {
+			NL_SET_ERR_MSG_MOD(tmo->common.extack,
+					   "Policer is only supported on chain 0");
+			kfree(mall_entry);
+			return -EOPNOTSUPP;
+		}
+
+		sparx5_tc_matchall_parse_port_policer_action(mall_entry,
+							     action);
+		err = sparx5_add_port_policer(mall_entry, tmo->common.extack);
+		if (err) {
+			kfree(mall_entry);
+			return err;
+		}
+
 		break;
 	case FLOW_ACTION_GOTO:
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
@@ -151,6 +182,11 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 
 	if (entry->type == FLOW_ACTION_MIRRED) {
 		sparx5_mirror_del(entry);
+	} else if (entry->type == FLOW_ACTION_POLICE) {
+		err = sparx5_delete_port_policer(entry);
+		if (err)
+			NL_SET_ERR_MSG_MOD(tmo->common.extack,
+					   "Could not delete port policer");
 	} else if (entry->type == FLOW_ACTION_GOTO) {
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
 					  0, 0, tmo->cookie, false);
@@ -180,6 +216,8 @@ static int sparx5_tc_matchall_stats(struct net_device *ndev,
 
 	if (entry->type == FLOW_ACTION_MIRRED) {
 		sparx5_mirror_stats(entry, &tmo->stats);
+	} else if (entry->type == FLOW_ACTION_POLICE) {
+		sparx5_update_port_policer_stats(ndev, tmo);
 	} else {
 		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
 		return -EOPNOTSUPP;

-- 
2.34.1

