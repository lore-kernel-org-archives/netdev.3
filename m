Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622104;
	b=mlnLkN8CeWzHMcWxWdSbXlwmymO2WooVK3LyfJ/V76F2lD37m8q6gKSToaMGW2qaUueH
	 rYQ8nMZH7ScmbbDK1goUD7l1LskzdKH9FnzF+tiWKMJ5ZVOsgwJbWgNYrReowkPREmC6s
	 nY2VZ7vkLNycuMIUY0afHOdbpgmoVSoWU2n/6h1anaNBojzavCtkaEjUlyv1mceDgJEnc
	 8EWX58HOvCYlVSdu5osVDk9ovSda9uMPJVJLuQ4Clu5tE0V3gW4XTbNHQpGJ/vMctfDj7
	 OLFnylN9mWOoCEFeAxrmmGG4xD0R8cRSN7hgcESswZzQ3F9/iGYG3BnpusCe9jtrP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622104;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=J0rANoRyuKSy0ZjIVrTiCMH86C3H43yiAnxVDLnS47Q=;
	b=JmuaEbuX2Uwaie02CDC89izEcUqo1l85NfAuzx2Iui8calxpufkPsyZQmwXErZmteKb7
	 d7VLT9qon+1uxYIzMErCw9Ac+lPnAdP489Yau7KKyi2WZC4NzlJOXVvNbjphbs7e20C/M
	 SwUKpGWL0JcoQTzZEMkHp3A+EwBDBVlRClKLgU5XP3AW8A9gJXXV+ZYzHsGiNfi5UlQ/5
	 NEO4WMwH4O3jsMjTBS68cCrhUxYEhcMQA6/sjbdK/RRF2O8TULMvNMsrDD8+UE5mr8HuB
	 JSTimWzPIbc7fBwtY93tRFoDCqoOAzbXhKCGz4EqQ+Z5TBaNsKtb2QgJKDl5PD3ReqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=uKtgmZVe;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC660A3815;
	Mon,  2 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADC660A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=uKtgmZVe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793622103; x=1825158103;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DzR/WcG18Lzs3fVFkqOEe50jzYkekyiez1z5HnVwevY=;
  b=uKtgmZVe9FtkDN2LxA3xgdEH2hK+ZRUihJJoGqKuQcrLvwdgvNrcepEc
   sDD+LH2R4PGJjaq+JjxCAG5jMGHdvtXAu996WDoKg3oW6hopzLByHutHB
   Myvs3u5lZC4ng02/Qe4MfeTDLB6KHE+aW5V3Up5f5fJaPZ9Na6mPmIOeI
   b4JC7a25PpOCUIZRYILb+HmKazzlt/gtoryABK0eBQDHObvcBOZlSXY0l
   ZdZflxGlP2Ur12voqW7NTn9tTIfVNolhVg/R0fnGNtt4jBnGnGpwcqZld
   bWQP42gk1/1PMnA4ooOlGFIa5tYQn8+7ycLs+5FZrlDYVe9VkF5EAts7y
   g==;
X-CSE-ConnectionGUID: E8AEfcniTAmGfcC9z3xeZw==
X-CSE-MsgGUID: qY1peQcPRt2HUtMCUEvYSA==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="232950957"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:21:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 2 Nov 2026 05:21:42 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 05:21:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Nov 2026 13:21:28 +0100
Subject: [PATCH net-next v2 5/5] net: sparx5: Offload tc port policers via
 matchall
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-5-3bd47ec1b227@microchip.com>
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
In-Reply-To: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

Offload a tc matchall filter with a police action to the port policer:

  tc qdisc add dev <eth> clsact
  tc filter add dev <eth> ingress matchall skip_sw \
      action police rate <bps> burst <bytes> conform-exceed drop

The port policer meters all ingress frames on the port, so offload the
filter only on ingress, on chain 0, with protocol all, and on a block
that is not shared. Only drop is supported as the exceed action, and
only one policer per port. A police action shared between ports is a
single bucket in software, which the per-port policers cannot express,
so reject a police action that is already offloaded as a port policer on
another port. Report the pass and drop counts through the matchall
stats.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  3 ++
 .../net/ethernet/microchip/sparx5/sparx5_police.c  | 27 +++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 39 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 93df90a62a9c8..ad29db91ce91e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -218,6 +218,8 @@ struct sparx5_port_policer {
 	struct flow_stats prev;
 	/* Port policers hold the client reference (cookie) */
 	unsigned long policer;
+	/* tc police action, the same for every filter bound to it */
+	unsigned long act_cookie;
 };
 
 struct sparx5_port_tc {
@@ -304,6 +306,7 @@ struct sparx5_mall_mirror_entry {
 
 struct sparx5_mall_port_policer_entry {
 	struct flow_action_police police;
+	unsigned long act_cookie;
 };
 
 struct sparx5_mall_entry {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
index 0fb1003e1b189..a635b95a7bd73 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
@@ -301,6 +301,25 @@ int sparx5_update_port_policer_stats(struct net_device *ndev,
 	return 0;
 }
 
+static bool sparx5_port_policer_act_in_use(struct sparx5_port *port,
+					   unsigned long act_cookie)
+{
+	struct sparx5 *sparx5 = port->sparx5;
+	struct sparx5_port *other;
+	int i;
+
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
+		other = sparx5->ports[i];
+		if (!other || other == port)
+			continue;
+		if (other->tc.port_policer[0].policer &&
+		    other->tc.port_policer[0].act_cookie == act_cookie)
+			return true;
+	}
+
+	return false;
+}
+
 int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
 			    struct netlink_ext_ack *extack)
 {
@@ -322,6 +341,13 @@ int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
 		return -EOPNOTSUPP;
 	}
 
+	if (sparx5_port_policer_act_in_use(port,
+					   entry->port_policer.act_cookie)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Police action shared between ports is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (police->exceed.act_id != FLOW_ACTION_DROP) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Policer parameters are not supported");
@@ -388,6 +414,7 @@ int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
 		return err;
 
 	port->tc.port_policer[idx].policer = entry->cookie;
+	port->tc.port_policer[idx].act_cookie = entry->port_policer.act_cookie;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 146d7f28e8f3d..4961b49fe1831 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -43,6 +43,14 @@ sparx5_tc_matchall_parse_mirror_action(struct sparx5_mall_entry *entry,
 	entry->mirror.port = netdev_priv(action->dev);
 }
 
+static void
+sparx5_tc_matchall_parse_port_policer_action(struct sparx5_mall_entry *entry,
+					     struct flow_action_entry *action)
+{
+	entry->port_policer.police = action->police;
+	entry->port_policer.act_cookie = action->cookie;
+}
+
 static int sparx5_tc_matchall_replace(struct net_device *ndev,
 				      struct tc_cls_matchall_offload *tmo,
 				      bool ingress)
@@ -98,6 +106,30 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
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
@@ -151,6 +183,11 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 
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
@@ -180,6 +217,8 @@ static int sparx5_tc_matchall_stats(struct net_device *ndev,
 
 	if (entry->type == FLOW_ACTION_MIRRED) {
 		sparx5_mirror_stats(entry, &tmo->stats);
+	} else if (entry->type == FLOW_ACTION_POLICE) {
+		sparx5_update_port_policer_stats(ndev, tmo);
 	} else {
 		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
 		return -EOPNOTSUPP;

-- 
2.34.1

