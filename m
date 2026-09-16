Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98C5335B6
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569722; cv=none; b=RKWXYgpkUF0xF8/XuiV5PVtPhTGW6OxvSL3jUQ3+xAwTJE8sQSZ9JcLZCXt6d+sko86ukeVDo34CmsxGq6fKjn0jdF/IQZY1K2vN6WFkn10j2UaHV99di48IYp5aPhro1/PQ7hqPa/IZNqo9jlsg5uoQZL8xC8ZBY8vF60JtyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569722; c=relaxed/simple;
	bh=52rXgfSwOmNkHEhGGn4mORhG1PBw3zjG5kUSL+pPOyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsbeUJlHghfCrxb/NgpPM9TkOgIi/0IauYTFCJhuy31pEk+u1T9VjHK7zFQtkTGqzol9Gu5Zbq+rp6jSW+RbRmtlIOLrFh8IHN2yvoC2/NOU9yu0QsPCO80gbIfFJM7hhwAp3iX0h4JnVl0LztYYq847WxifnX/rUp+OzHYhiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O82JyR4J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O82JyR4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789569718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwkxAtMc4/t7l1lYwlmK7CBbkBVAogXL7h4sRQPbgdk=;
	b=O82JyR4JRrNII6ELAzhRRpTmDxiW0X1NxgvJ4j4smFJyDRq9WoVNmXzLTlD4NfCFtKMey8
	8k89gqJqtJytXhIEUTBEWeceQU6K7IzhCDGCrd9/fN6YeQhJzEZb9DgOR5okDSprjxgIVi
	xykxStgYXxFqam5iL4Oc3KI28RBb5cM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-gsA5rMVwNRq6SGVP5swV1A-1; Wed,
 16 Sep 2026 10:41:56 -0400
X-MC-Unique: gsA5rMVwNRq6SGVP5swV1A-1
X-Mimecast-MFC-AGG-ID: gsA5rMVwNRq6SGVP5swV1A_1789569714
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22FD51800655;
	Wed, 16 Sep 2026 14:41:54 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D4A519560AB;
	Wed, 16 Sep 2026 14:41:49 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 2/2] ice: don't offload drop filters that bypass higher priority filters
Date: Wed, 16 Sep 2026 16:41:30 +0200
Message-ID: <20260916144130.2699902-3-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>
References: <20260916144130.2699902-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The E810 switch gives drop rules absolute precedence over forwarding
rules regardless of recipe priority (verified on E810 in every
combination of installation order and match specificity). TC however
requires filters to be evaluated in priority order, so when a higher
priority filter stays software-only because its match or action cannot
be offloaded while a lower priority drop filter is offloaded, the
hardware drops packets the higher priority filter should have seen:

  tc filter add dev $pf ingress prio 1 protocol ip flower \
      ip_proto l2tp action pass
  tc filter add dev $pf ingress prio 2 protocol ip flower action drop

The pass filter is rejected (unsupported action), the drop filter is
offloaded and the hardware drops all IPv4 traffic including the L2TP
packets the prio 1 filter should accept.

Track filters that were presented to the driver but not offloaded and
refuse to offload a drop filter when a higher priority filter on the
same device block and direction is software-only or is offloaded with a
forwarding action, which the hardware drop would equally override. The
refused drop filter keeps working in software. Filters are compared
only within one device block since TC priorities are not ordered across
blocks, and a shared block bound to multiple devices is tracked once
per binding. Filters with skip_sw bypass the check because the user
explicitly requested hardware-only operation and refusing would fail
the filter add entirely, and the tracking applies to the legacy switch
mode only, switchdev pipelines manage rule priorities themselves.

The check does not analyze match overlap, so it is conservative, and it
runs only at drop offload time. A conflicting filter installed after a
drop filter was already offloaded cannot un-offload it, and filters the
driver never saw (added while hw-tc-offload was off) are invisible to
it. Installing filters in priority order with offload enabled avoids
both.

Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- track one entry per cookie and filter_dev pair instead of one per
  cookie, so a shared block bound to multiple devices of one PF is
  protected on every binding and each DESTROY invocation removes its
  own entry instead of returning -EINVAL for the later bindings
  (sashiko review via Simon Horman)
- pass the filter device to ice_del_cls_flower() for the lookup above

v1: https://lore.kernel.org/all/20260910154824.3603687-3-poros@redhat.com/
 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 159 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  23 ++-
 5 files changed, 177 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c43..6c596e5a315175 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -643,6 +643,7 @@ struct ice_pf {
 	 */
 	u16 num_dmac_chnl_fltrs;
 	struct hlist_head tc_flower_fltr_list;
+	struct hlist_head tc_sw_fltr_list;
 
 	u64 supported_rxdids;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3b76eb58666c07..3e6976cbb45c22 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8392,7 +8392,7 @@ ice_setup_tc_cls_flower(struct ice_netdev_priv *np,
 	case FLOW_CLS_REPLACE:
 		return ice_add_cls_flower(filter_dev, vsi, cls_flower, ingress);
 	case FLOW_CLS_DESTROY:
-		return ice_del_cls_flower(vsi, cls_flower);
+		return ice_del_cls_flower(filter_dev, vsi, cls_flower);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 096566c697f444..312a1bda460035 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -223,7 +223,7 @@ ice_repr_setup_tc_cls_flower(struct ice_repr *repr,
 		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower,
 					  true);
 	case FLOW_CLS_DESTROY:
-		return ice_del_cls_flower(repr->src_vsi, flower);
+		return ice_del_cls_flower(repr->netdev, repr->src_vsi, flower);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index fbd8cbad150a98..fec6970a74cfbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -2269,6 +2269,117 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
 	return NULL;
 }
 
+/**
+ * ice_tc_fltr_is_drop - check if a filter carries a drop action
+ * @cls_flower: offload request describing the filter
+ *
+ * Return: true if any action of the filter is a drop, false otherwise.
+ */
+static bool ice_tc_fltr_is_drop(struct flow_cls_offload *cls_flower)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(cls_flower);
+	struct flow_action_entry *act;
+	int i;
+
+	if (cls_flower->classid)
+		return false;
+
+	flow_action_for_each(i, act, &rule->action)
+		if (act->id == FLOW_ACTION_DROP)
+			return true;
+
+	return false;
+}
+
+/**
+ * ice_tc_untrack_sw_fltr - forget a tracked software-only filter
+ * @pf: pointer to PF structure
+ * @filter_dev: device the filter was requested on
+ * @cookie: unique filter identifier from the offload request
+ *
+ * Return: true if the filter was tracked, false otherwise.
+ */
+static bool ice_tc_untrack_sw_fltr(struct ice_pf *pf,
+				   struct net_device *filter_dev,
+				   unsigned long cookie)
+{
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node) {
+		if (sw_fltr->cookie != cookie ||
+		    sw_fltr->filter_dev != filter_dev)
+			continue;
+
+		hlist_del(&sw_fltr->node);
+		kfree(sw_fltr);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * ice_tc_track_sw_fltr - remember a filter that was not offloaded
+ * @pf: pointer to PF structure
+ * @filter_dev: device the filter was requested on
+ * @cls_flower: offload request describing the filter
+ * @direction: block direction the filter was requested for
+ */
+static void ice_tc_track_sw_fltr(struct ice_pf *pf,
+				 struct net_device *filter_dev,
+				 struct flow_cls_offload *cls_flower,
+				 enum ice_eswitch_fltr_direction direction)
+{
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
+		if (sw_fltr->cookie == cls_flower->cookie &&
+		    sw_fltr->filter_dev == filter_dev)
+			return;
+
+	sw_fltr = kzalloc_obj(*sw_fltr);
+	if (!sw_fltr)
+		return;
+
+	sw_fltr->cookie = cls_flower->cookie;
+	sw_fltr->filter_dev = filter_dev;
+	sw_fltr->prio = cls_flower->common.prio;
+	sw_fltr->direction = direction;
+	sw_fltr->is_drop = ice_tc_fltr_is_drop(cls_flower);
+	hlist_add_head(&sw_fltr->node, &pf->tc_sw_fltr_list);
+}
+
+/**
+ * ice_tc_drop_bypasses_fltr - check if a drop rule would bypass a filter
+ * @pf: pointer to PF structure
+ * @filter_dev: device the drop filter is requested on
+ * @prio: TC priority of the drop filter
+ * @direction: block direction of the drop filter
+ *
+ * Return: true if such a filter exists, false otherwise.
+ */
+static bool
+ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
+			  u32 prio, enum ice_eswitch_fltr_direction direction)
+{
+	struct ice_tc_flower_fltr *fltr;
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
+		if (sw_fltr->filter_dev == filter_dev &&
+		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
+		    !sw_fltr->is_drop)
+			return true;
+
+	hlist_for_each_entry(fltr, &pf->tc_flower_fltr_list, tc_flower_node)
+		if (fltr->filter_dev == filter_dev &&
+		    fltr->direction == direction && fltr->prio < prio &&
+		    fltr->action.fltr_act != ICE_DROP_PACKET)
+			return true;
+
+	return false;
+}
+
 /**
  * ice_add_cls_flower - add TC flower filters
  * @netdev: Pointer to filter device
@@ -2284,14 +2395,24 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 {
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct net_device *vsi_netdev = vsi->netdev;
+	enum ice_eswitch_fltr_direction direction;
 	struct ice_tc_flower_fltr *fltr;
 	struct ice_pf *pf = vsi->back;
+	bool track_sw_fltrs;
 	int err;
 
-	if (ice_is_reset_in_progress(pf->state))
-		return -EBUSY;
-	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-		return -EINVAL;
+	direction = ingress ? ICE_ESWITCH_FLTR_INGRESS :
+			      ICE_ESWITCH_FLTR_EGRESS;
+	track_sw_fltrs = !ice_is_eswitch_mode_switchdev(pf);
+
+	if (ice_is_reset_in_progress(pf->state)) {
+		err = -EBUSY;
+		goto track_sw;
+	}
+	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
+		err = -EINVAL;
+		goto track_sw;
+	}
 
 	if (ice_is_port_repr_netdev(netdev))
 		vsi_netdev = netdev;
@@ -2304,7 +2425,8 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		 */
 		if (netdev == vsi_netdev)
 			NL_SET_ERR_MSG_MOD(extack, "can't apply TC flower filters, turn ON hw-tc-offload and try again");
-		return -EINVAL;
+		err = -EINVAL;
+		goto track_sw;
 	}
 
 	/* avoid duplicate entries, if exists - return error */
@@ -2314,28 +2436,51 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		return -EEXIST;
 	}
 
+	if (track_sw_fltrs && !cls_flower->common.skip_sw &&
+	    ice_tc_fltr_is_drop(cls_flower) &&
+	    ice_tc_drop_bypasses_fltr(pf, netdev, cls_flower->common.prio,
+				      direction)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Drop filter not offloaded because it would bypass a higher priority filter");
+		err = -EOPNOTSUPP;
+		goto track_sw;
+	}
+
 	/* prep and add TC-flower filter in HW */
 	err = ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr, ingress);
 	if (err)
-		return err;
+		goto track_sw;
+
+	fltr->filter_dev = netdev;
+	fltr->prio = cls_flower->common.prio;
 
 	/* add filter into an ordered list */
 	hlist_add_head(&fltr->tc_flower_node, &pf->tc_flower_fltr_list);
 	return 0;
+
+track_sw:
+	if (track_sw_fltrs && !cls_flower->common.skip_sw)
+		ice_tc_track_sw_fltr(pf, netdev, cls_flower, direction);
+	return err;
 }
 
 /**
  * ice_del_cls_flower - delete TC flower filters
+ * @netdev: Pointer to filter device
  * @vsi: Pointer to VSI
  * @cls_flower: Pointer to struct flow_cls_offload
  */
 int
-ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
+ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
+		   struct flow_cls_offload *cls_flower)
 {
 	struct ice_tc_flower_fltr *fltr;
 	struct ice_pf *pf = vsi->back;
 	int err;
 
+	if (ice_tc_untrack_sw_fltr(pf, netdev, cls_flower->cookie))
+		return 0;
+
 	/* find filter */
 	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
 	if (!fltr) {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 752af65e70b7bf..47444b7dadd257 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -139,12 +139,33 @@ enum ice_eswitch_fltr_direction {
 	ICE_ESWITCH_FLTR_EGRESS,
 };
 
+/**
+ * struct ice_tc_sw_fltr - filter presented to the driver but not offloaded
+ * @node: node in the pf->tc_sw_fltr_list
+ * @cookie: unique filter identifier from the offload request
+ * @filter_dev: device the filter was requested on
+ * @prio: TC priority, lower value is evaluated first
+ * @direction: block direction the filter was requested for
+ * @is_drop: the filter carries a drop action
+ */
+struct ice_tc_sw_fltr {
+	struct hlist_node node;
+	unsigned long cookie;
+	struct net_device *filter_dev;
+	u32 prio;
+	enum ice_eswitch_fltr_direction direction;
+	bool is_drop;
+};
+
 struct ice_tc_flower_fltr {
 	struct hlist_node tc_flower_node;
 
 	/* cookie becomes filter_rule_id if rule is added successfully */
 	unsigned long cookie;
 
+	struct net_device *filter_dev;
+	u32 prio;
+
 	/* add_adv_rule returns information like recipe ID, rule_id. Store
 	 * those values since they are needed to remove advanced rule
 	 */
@@ -214,7 +235,7 @@ static inline int ice_chnl_dmac_fltr_cnt(struct ice_pf *pf)
 struct ice_vsi *ice_locate_vsi_using_queue(struct ice_vsi *vsi, int queue);
 int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		       struct flow_cls_offload *cls_flower, bool ingress);
-int ice_del_cls_flower(struct ice_vsi *vsi,
+int ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		       struct flow_cls_offload *cls_flower);
 void ice_replay_tc_fltrs(struct ice_pf *pf);
 bool ice_is_tunnel_supported(struct net_device *dev);
-- 
2.55.0

