Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4919332EC5;
	Sun, 30 Aug 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128602; cv=none; b=uXF0cAbsu7BkFLpmKlZbcmrXmo8Mt7xmXIlqsNXqeirAui+rlKA3B0bXX4B3Epw2jeDa2hjJpwfpzN/dGMrIaw7ui5p0YORyP0Xb7cPTNcQs33Hs/EuKnwe99LfyLhEbLgxmlih1/uLyqX6pKQ2WAWpX1Vr8NRBS6ulHZDp/8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128602; c=relaxed/simple;
	bh=i1WyAqKHuChmVuJSbSIFOGEDI+aWhCSjqWve5OCJ2Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTmSznKR79ueLGNGVxg8ppDXEPk3KPwnWCZxPssuSxgDiX5cVa1sJYTsBQcSsa9ivO9bvvKt/Ikes7LUso04UmwIaMJ8Ia4tfjdAk4OnHq+fETUdVg4v+QNW1+KS2/rxSpIHBGlgJBES+iHlAjBJ/jQZD0LIfN82a0ZMImRqM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=O6OPs13V; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="O6OPs13V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7459; q=dns/txt;
  s=iport01; t=1788128596; x=1789338196;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MqRHV3nTFK8S3MZK4loTZ+r73N0xwIu+cC0DrJqQVSU=;
  b=O6OPs13VWvk8pnjzqdlhs/WASWfOuec7+2zMX3XwJYbwqCUa2h1xPa1h
   ugBE4EHd4XcvJBHVsTsbKayH+feHJJNzw8shrm4QO2+kZC8zM5qX6mOpj
   XZwtmtJqmEUQ4W06C8U9MiGh3sfSh2Y87/0eDbVXgGbIxfLBHQmHdPy4u
   fRrT1RfnwGbUo+K47jfxzhnbEouJ7TdL5vNPhfu8NAJ4JWeqN5PjHkhGV
   pyVk87cAcQ9tXIArO1O84bG3nmtxelVzHucx85dNoZjLQXYapWQBn2wDF
   FdHkkIg4Sk3l9aamuzAsekcWa9yyg/bb443DKRe1l1hmSKb73rIWkLLPK
   A==;
X-CSE-ConnectionGUID: YRrpvF2YQQmHgBMaPJUxMg==
X-CSE-MsgGUID: tk+CQD6KTPibTUV6j0WDCA==
X-IPAS-Result: =?us-ascii?q?A0D+AgB0rJRq/5IQJK1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhnh4UgWoPAQEBD1EEAQGFBQKNcwImNgcOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBAsBNBIQJQImAgJGEAYBEoMCgnUDwiV6f?=
 =?us-ascii?q?zOBAYR92UqBZgELFAGBCi6FcYJtAYFwhAg7hEEnG4FJRIEVgnpvhCqDdIJqB?=
 =?us-ascii?q?IMcEos5iEAJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJ?=
 =?us-ascii?q?xIsFzVYGwYFgR19FAQThA8jGTZ6gQlegSspYAESF4EJgggCglqCBQIBSUMOB?=
 =?us-ascii?q?0dTCQQLGA1IESw3Bg8ZBD0BbgeOeh+BWmoHPVJ7MQEPD2snHCmSY4N+jkqBN?=
 =?us-ascii?q?Z9ahCiBZqAQM5dnkW6BF5kII6NPDwlQhGmBbwE0gVkzGggbFYMiUxkPjiwBF?=
 =?us-ascii?q?tAZJzI9AgcCBw4DC5MGYAEB?=
IronPort-Data: A9a23:Kp7gKKpYSZwHFszHrssTrql74fteBmLZZBIvgKrLsJaIsI4StFCzt
 garIBmPafyLMGH9etpzO9iwpB8AsJLcm94wSVBupX81FHkW9OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrT80s35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0tdNG3lQ2
 6YpEQkITh+pouuO4o+rb+Y506zPLOGzVG8eknhkyTecCbMtRorOBv2bo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtJYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUozQGJ8LzxbG+
 goq+UzlAVIxDfDB6ga983iQu9GRn3vEdKk7QejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRbYqhYcmsrFPc9/sFdNffRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzyta1UwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:7YhOMaON+ofyP8BcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: 9a23:j9ssVm+TJTGZiVJKxZWVv38uANg7XCfs9U7VA0CSLG9RaoCFbFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AvL5EXwxS6ydJWD/qpYimjNNN8TWaqLitS2s0vcs?=
 =?us-ascii?q?lh/GFPxBNBWmf1AubaaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,252,1779148800"; 
   d="scan'208";a="825269864"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Aug 2026 22:23:06 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 711F718000479;
	Sun, 30 Aug 2026 22:23:04 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 30 Aug 2026 15:22:52 -0700
Subject: [PATCH net 1/2] enic: preserve V2 VF carrier across netdev reopen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260830-b4-enic-v2-mbox-fixes-net-v1-1-23adf9bfd426@cisco.com>
References: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
In-Reply-To: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>, 
 linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788128581; l=7623;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=i1WyAqKHuChmVuJSbSIFOGEDI+aWhCSjqWve5OCJ2Vk=;
 b=s76LEAvJ9/BAEdJyDbsw4p4l69AhQgbxcWVo/bumrmAxKzbLPMq5unztuzh2CsP76MWbJ1wPD
 HOm1D3wrF05D6y1l4z3PZKSSmxwgw9E//GGReciV371D+DMc6UAhWlA
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-09.cisco.com

A V2 VF receives carrier state only from PF MBOX notifications.
enic_stop() forces carrier off, but enic_open() does not request a fresh
notification or restore the previous one.  An ordinary down/up cycle
therefore leaves the VF in NO-CARRIER and unable to pass traffic until the
PF repeats the link-state command, even when the physical link remained
up.

Cache each valid PF link-state notification.  Serialize updates with the V2
VF datapath running state.  Keep carrier off while the netdev is stopped.
Restore the cached state after an ordinary open.  Before either internal
reset reopens the datapath, invalidate the cache.  Carrier then remains off
until re-registration receives a fresh PF link-state notification.

Fixes: 72b65c94058e ("enic: add MBOX VF handlers for capability, register and link state")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      | 13 ++++++++++
 drivers/net/ethernet/cisco/enic/enic_main.c | 12 +++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 37 +++++++++++++++++++++++++----
 drivers/net/ethernet/cisco/enic/enic_mbox.h |  2 ++
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 4a67947cfb9f..2822fbfb6474 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -137,6 +137,12 @@ struct enic_port_profile {
 	u8 mac_addr[ETH_ALEN];
 };
 
+enum enic_vf_link_state {
+	ENIC_VF_LINK_STATE_UNKNOWN,
+	ENIC_VF_LINK_STATE_DOWN,
+	ENIC_VF_LINK_STATE_UP,
+};
+
 /* enic_rfs_fltr_node - rfs filter node in hash table
  *	@@keys: IPv4 5 tuple
  *	@flow_id: flow_id of clsf filter provided by kernel
@@ -312,6 +318,13 @@ struct enic {
 	unsigned int admin_msg_count;	/* current depth of admin_msg_list */
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
+	/* The PF is authoritative for a V2 VF's carrier.  Keep the last
+	 * notification across an ordinary netdev close/open and serialize it
+	 * against the open/stop carrier transition.
+	 */
+	spinlock_t vf_link_state_lock;
+	enum enic_vf_link_state vf_link_state;
+	bool vf_link_running;
 
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 0baef7a120ec..48d16ef18c49 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1800,6 +1800,8 @@ static int enic_open(struct net_device *netdev)
 
 	enic_notify_timer_start(enic);
 	enic_rfs_timer_start(enic);
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_link_state_set_running(enic, true);
 
 	return 0;
 
@@ -1853,7 +1855,10 @@ static int enic_stop(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++)
 		napi_disable(&enic->napi[i]);
 
-	netif_carrier_off(netdev);
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_link_state_set_running(enic, false);
+	else
+		netif_carrier_off(netdev);
 	if (vnic_dev_get_intr_mode(enic->vdev) == VNIC_DEV_INTR_MODE_MSIX)
 		for (i = 0; i < enic->wq_count; i++)
 			napi_disable(&enic->napi[enic_cq_wq(enic, i)]);
@@ -2271,6 +2276,8 @@ static void enic_reset(struct work_struct *work)
 		enic_admin_channel_close(enic);
 
 	enic_stop(enic->netdev);
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_link_state_reset(enic);
 
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
@@ -2315,6 +2322,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 	enic_dev_hang_notify(enic);
 	enic_stop(enic->netdev);
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_link_state_reset(enic);
 
 	enic_dev_hang_reset(enic);
 	enic_reset_addr_lists(enic);
@@ -3015,6 +3024,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	enic = netdev_priv(netdev);
 	enic->netdev = netdev;
 	enic->pdev = pdev;
+	spin_lock_init(&enic->vf_link_state_lock);
 
 	/* Setup PCI resources
 	 */
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 2fb0f1e2ff50..ad79d3951f3d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -396,25 +396,32 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
 {
 	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
 	struct enic_mbox_pf_link_state_ack_msg ack = {};
+	u32 link_state = le32_to_cpu(notif->link_state);
 	int err;
 
-	switch (le32_to_cpu(notif->link_state)) {
+	spin_lock_bh(&enic->vf_link_state_lock);
+	switch (link_state) {
 	case ENIC_MBOX_LINK_STATE_ENABLE:
-		if (!netif_carrier_ok(enic->netdev))
+		enic->vf_link_state = ENIC_VF_LINK_STATE_UP;
+		if (enic->vf_link_running &&
+		    !netif_carrier_ok(enic->netdev))
 			netif_carrier_on(enic->netdev);
 		netdev_dbg(enic->netdev, "MBOX: link state -> UP\n");
 		break;
 	case ENIC_MBOX_LINK_STATE_DISABLE:
-		if (netif_carrier_ok(enic->netdev))
+		enic->vf_link_state = ENIC_VF_LINK_STATE_DOWN;
+		if (enic->vf_link_running &&
+		    netif_carrier_ok(enic->netdev))
 			netif_carrier_off(enic->netdev);
 		netdev_dbg(enic->netdev, "MBOX: link state -> DOWN\n");
 		break;
 	default:
 		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
-			    le32_to_cpu(notif->link_state));
+			    link_state);
 		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
 		break;
 	}
+	spin_unlock_bh(&enic->vf_link_state_lock);
 
 	err = enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
 				 ENIC_MBOX_DST_PF, &ack, sizeof(ack));
@@ -423,6 +430,28 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
 			    "MBOX: failed to send link state ACK: %d\n", err);
 }
 
+void enic_mbox_vf_link_state_reset(struct enic *enic)
+{
+	spin_lock_bh(&enic->vf_link_state_lock);
+	enic->vf_link_state = ENIC_VF_LINK_STATE_UNKNOWN;
+	if (enic->vf_link_running && netif_carrier_ok(enic->netdev))
+		netif_carrier_off(enic->netdev);
+	spin_unlock_bh(&enic->vf_link_state_lock);
+}
+
+void enic_mbox_vf_link_state_set_running(struct enic *enic, bool running)
+{
+	spin_lock_bh(&enic->vf_link_state_lock);
+	enic->vf_link_running = running;
+	if (running && enic->vf_link_state == ENIC_VF_LINK_STATE_UP) {
+		if (!netif_carrier_ok(enic->netdev))
+			netif_carrier_on(enic->netdev);
+	} else if (netif_carrier_ok(enic->netdev)) {
+		netif_carrier_off(enic->netdev);
+	}
+	spin_unlock_bh(&enic->vf_link_state_lock);
+}
+
 static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
 				    u16 payload_len, size_t min_len)
 {
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 15e30ee2b0ed..60409bad2f28 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -88,6 +88,8 @@ void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
+void enic_mbox_vf_link_state_reset(struct enic *enic);
+void enic_mbox_vf_link_state_set_running(struct enic *enic, bool running);
 int enic_mbox_vf_capability_check(struct enic *enic);
 int enic_mbox_vf_register(struct enic *enic);
 int enic_mbox_vf_unregister(struct enic *enic);

-- 
2.43.0

