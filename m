Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFB481649
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630112; cv=none; b=XcWhjr3MvTJTj2k5ayx3HTiM+g50C9caP1PzOMjz8/iTgf3rY/RoS47a+Ej3n8R/PJKPslFk5IX7BcHwxZYuiMqZ/jOpvYpxL1fD8O4YkR+wVD9NLPrwLGML+s8qeRzrHryMpXljv36cwJQ47Dwd3XMeVrlDl5qtCYRAY4AkEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630112; c=relaxed/simple;
	bh=/En5DnD0EZLtkwD/aoUkFEzvIJw01h38eZ2AXdEo9gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz8/elUnEqDTyHyZ8CDRa336RN1rxJxQGaEWMMuDYKv0CADDKI8cGlit7AQvnTKQXRrbZ9f3mQZtC2rubUspzdcct4FZ5yLTdW4+91Yz98KuaAAPqPilLJxAZxcj6drtzbND0i8C9buB38vKkhccSwWuF/gUnl3JfFqO2tcp0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pionrc5F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pionrc5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786630108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VB8Lkwww6eX8JAvyMUZscYUTf+Xs+Xuwd153uzSvLHw=;
	b=Pionrc5Fcln7IQlmY0hbEa1nqkPpdFH4uE/OpCGA27wWPf/4uckT9Q6kGaG/Nym7T7jhMS
	OsR+Wp+URrBCMvnK9I+LdMooRbFTZpAypz0k82qBxl+rA/Fj829i4Up8WeKgooK0pBh7Et
	Dgm/ZTblfbG0d47dKjd9M+5ZcyzGIng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-QGL56DOpNOe5jtS5N-yeJA-1; Thu,
 13 Aug 2026 10:08:25 -0400
X-MC-Unique: QGL56DOpNOe5jtS5N-yeJA-1
X-Mimecast-MFC-AGG-ID: QGL56DOpNOe5jtS5N-yeJA_1786630104
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6910B195608A;
	Thu, 13 Aug 2026 14:08:23 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E6F530001A2;
	Thu, 13 Aug 2026 14:08:20 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	linux-kernel@vger.kernel.org,
	ivecera@redhat.com
Subject: [PATCH net v2] dpll: fix NULL deref in dpll_device_ops() during teardown race
Date: Thu, 13 Aug 2026 16:08:17 +0200
Message-ID: <20260813140817.1051388-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When the last owner of a dpll device unregisters while a foreign driver
still holds a pin on it via dpll_pin_on_pin_register(), the dpll object
stays alive with an empty registration list. A pin notification queued
before the unregister (e.g. ice reacting to zl3073x_i2c removal) then
walks pin->dpll_refs into dpll_device_ops(), which trips the WARN_ON and
dereferences the missing registration. dpll_lock cannot help because the
notification work was queued before the unregistering driver took the
lock.

Treat the empty registration list as a legitimate transient state. Make
dpll_priv() and dpll_device_ops() return NULL in that case and make
every pin netlink path that resolves a device from a pin skip such
dplls. dpll_cmd_pin_get_one() picks a ref with a live registration and
returns -ENODEV when there is none, the pin dumpit skips such a pin
instead of aborting the dump, dpll_msg_add_pin_dplls() and the
frequency, esync, reference sync and phase adjust set paths skip dead
refs, and dpll_pin_parent_device_set() validates the parent with
dpll_device_get_by_id(). dpll_pin_register() is the last caller that
dereferenced the device ops without a check, so move its frequency
monitor validation under dpll_lock and tolerate a missing registration
there as well.

The empty registration list is equivalent to a cleared DPLL_REGISTERED
mark, both transitions happen under dpll_lock in dpll_device_register()
and dpll_device_unregister(). A pin notification for a pin whose dplls
are all gone is now dropped with -ENODEV instead of crashing, all
callers in the core ignore that return value.

 WARNING: drivers/dpll/dpll_core.c:1092 at dpll_device_ops+0x24/0x40,
 CPU#83: kworker/u576:3/23471
 Modules linked in: ... ice ... zl3073x_i2c(-) ... zl3073x ...
 Workqueue: ice_dpll_wq ice_dpll_pin_notify_work [ice]
 RIP: 0010:dpll_device_ops+0x24/0x40
 Call Trace:
  <TASK>
  dpll_cmd_pin_get_one+0x336/0x520
  dpll_pin_event_send+0x82/0x140
  dpll_pin_on_pin_unregister+0xbb/0x160
  ice_dpll_pin_notify_work+0x1bc/0x1f0 [ice]
  process_one_work+0x19e/0x370
  worker_thread+0x1a6/0x310
  kthread+0xe4/0x120
  ret_from_fork+0x1a1/0x270
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---
 BUG: kernel NULL pointer dereference, address: 0000000000000010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- guard every path that resolves a device from a pin, not only the
  first ref in dpll_cmd_pin_get_one(); skip half-dead refs in
  dpll_msg_add_pin_dplls() and the set paths, select a live
  representative ref and turn the pin dumpit -ENODEV into a per pin
  skip (Jakub)
- validate the parent device in dpll_pin_parent_device_set() via
  dpll_device_get_by_id()
- guard the frequency monitor validation in dpll_pin_register() and
  perform it under dpll_lock, it was the only remaining unchecked
  dereference of the device ops
- drop patch 2/2, superseded by commit 32239d600236 ("dpll: fix stale
  iteration in dpll_pin_on_pin_unregister()")

v1: https://lore.kernel.org/all/20260516191317.1005612-2-poros@redhat.com/
---
 drivers/dpll/dpll_core.c    | 24 +++++++++------
 drivers/dpll/dpll_netlink.c | 59 ++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 43d51d942eadd3..a320eeb829ad28 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -876,19 +876,25 @@ int
 dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		  const struct dpll_pin_ops *ops, void *priv)
 {
+	const struct dpll_device_ops *dev_ops;
 	int ret;
 
 	if (WARN_ON(!ops) ||
 	    WARN_ON(!ops->state_on_dpll_get) ||
 	    WARN_ON(!ops->direction_get) ||
-	    WARN_ON(ops->measured_freq_get &&
-		    (!dpll_device_ops(dpll)->freq_monitor_get ||
-		     !dpll_device_ops(dpll)->freq_monitor_set)) ||
 	    WARN_ON(ops->supported_ffo && !ops->ffo_get))
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 
+	dev_ops = dpll_device_ops(dpll);
+	if (WARN_ON(ops->measured_freq_get &&
+		    (!dev_ops || !dev_ops->freq_monitor_get ||
+		     !dev_ops->freq_monitor_set))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/*
 	 * For pins identified via firmware (pin->fwnode), allow registration
 	 * even if the pin's (module, clock_id) differs from the target DPLL.
@@ -1081,12 +1087,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);
 static struct dpll_device_registration *
 dpll_device_registration_first(struct dpll_device *dpll)
 {
-	struct dpll_device_registration *reg;
-
-	reg = list_first_entry_or_null((struct list_head *)&dpll->registration_list,
-				       struct dpll_device_registration, list);
-	WARN_ON(!reg);
-	return reg;
+	return list_first_entry_or_null((struct list_head *)&dpll->registration_list,
+					struct dpll_device_registration, list);
 }
 
 void *dpll_priv(struct dpll_device *dpll)
@@ -1094,6 +1096,8 @@ void *dpll_priv(struct dpll_device *dpll)
 	struct dpll_device_registration *reg;
 
 	reg = dpll_device_registration_first(dpll);
+	if (!reg)
+		return NULL;
 	return reg->priv;
 }
 
@@ -1102,6 +1106,8 @@ const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll)
 	struct dpll_device_registration *reg;
 
 	reg = dpll_device_registration_first(dpll);
+	if (!reg)
+		return NULL;
 	return reg->ops;
 }
 
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index afb31c0040382c..9e55745e33e4fa 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -66,6 +66,22 @@ static bool dpll_pin_available(struct dpll_pin *pin)
 	return false;
 }
 
+static bool dpll_device_registered(struct dpll_device *dpll)
+{
+	return dpll_device_ops(dpll);
+}
+
+static struct dpll_pin_ref *dpll_pin_first_registered_ref(struct dpll_pin *pin)
+{
+	struct dpll_pin_ref *ref;
+	unsigned long i;
+
+	xa_for_each(&pin->dpll_refs, i, ref)
+		if (dpll_device_registered(ref->dpll))
+			return ref;
+	return NULL;
+}
+
 /**
  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
  * @msg: pointer to sk_buff message to attach a pin handle
@@ -656,6 +672,8 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
 	int ret;
 
 	xa_for_each(&pin->dpll_refs, index, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		attr = nla_nest_start(msg, DPLL_A_PIN_PARENT_DEVICE);
 		if (!attr)
 			return -EMSGSIZE;
@@ -700,9 +718,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	int ret;
 
 	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref || !dpll_device_registered(ref->dpll))
+		ref = dpll_pin_first_registered_ref(pin);
 	if (!ref)
-		ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
-	ASSERT_NOT_NULL(ref);
+		return -ENODEV;
 
 	ret = dpll_msg_add_pin_handle(msg, pin);
 	if (ret)
@@ -1091,6 +1110,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	}
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if ((!ops->frequency_set || !ops->frequency_get) &&
 		    ref->dpll->module == pin->module &&
@@ -1101,7 +1122,7 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		}
 	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref) {
+	if (!ref || !dpll_device_registered(ref->dpll)) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1117,6 +1138,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		return 0;
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->frequency_set)
 			continue;
@@ -1138,6 +1161,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		if (ref == failed)
 			break;
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->frequency_set)
 			continue;
@@ -1163,6 +1188,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 	int ret;
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if ((!ops->esync_set || !ops->esync_get) &&
 		    ref->dpll->module == pin->module &&
@@ -1173,7 +1200,7 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 		}
 	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref) {
+	if (!ref || !dpll_device_registered(ref->dpll)) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1199,6 +1226,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		void *pin_dpll_priv;
 
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->esync_set)
 			continue;
@@ -1224,6 +1253,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 
 		if (ref == failed)
 			break;
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->esync_set)
 			continue;
@@ -1262,7 +1293,7 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 		return -EINVAL;
 	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref) {
+	if (!ref || !dpll_device_registered(ref->dpll)) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1283,6 +1314,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 	if (state == old_state)
 		return 0;
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->ref_sync_set)
 			continue;
@@ -1307,6 +1340,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		if (ref == failed)
 			break;
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->ref_sync_set)
 			continue;
@@ -1500,6 +1535,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	}
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
 		    ref->dpll->module == pin->module &&
@@ -1509,7 +1546,7 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		}
 	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref) {
+	if (!ref || !dpll_device_registered(ref->dpll)) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1526,6 +1563,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		return 0;
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->phase_adjust_set)
 			continue;
@@ -1550,6 +1589,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		if (ref == failed)
 			break;
+		if (!dpll_device_registered(ref->dpll))
+			continue;
 		ops = dpll_pin_ops(ref);
 		if (!ops->phase_adjust_set)
 			continue;
@@ -1581,7 +1622,7 @@ dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr *parent_nest,
 		return -EINVAL;
 	}
 	pdpll_idx = nla_get_u32(tb[DPLL_A_PIN_PARENT_ID]);
-	dpll = xa_load(&dpll_device_xa, pdpll_idx);
+	dpll = dpll_device_get_by_id(pdpll_idx);
 	if (!dpll) {
 		NL_SET_ERR_MSG(extack, "parent device not found");
 		return -EINVAL;
@@ -1873,6 +1914,10 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		ret = dpll_cmd_pin_get_one(skb, pin, cb->extack);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
+			if (ret == -ENODEV) {
+				ret = 0;
+				continue;
+			}
 			break;
 		}
 		genlmsg_end(skb, hdr);
-- 
2.54.0

