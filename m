Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173342A179
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507126; cv=none; b=la5vRzI2GQBOIkbo45jpW6jWMSNoWHcNvLrhtIYsghHImX5JJjA3xGiicjLYLwfGnpFANtjFHnTuN/wyohs+SedxI4W7u+ZoIf0RAC1AQz38mLcWEk1wy8TYqH6FNzyTjdvmipe4eHyJl0ROqEODEyrj6DuHIt2Lb0h2VigoTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507126; c=relaxed/simple;
	bh=enNRhGJ6LJ6JFHDokHh0ipfDU2jBy4SHll0iyBP9LJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJVBTSx790Xi/ZrgkxckePBgya8NtS1hPNEKORiBvnonYCNwEkedvi50Qo08qV45R/ASax4AXPL/MMNV6TZt+4TsUT1kRTAl91u32h9AhDG0X16XeN8slr56RHCF+jtano9Sb3577pvp20dCNtImr4WS/hfvVvSN0lTRR1M5ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcizGRbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcizGRbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785507119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hNOE7YHp9xdBvibv9lIiDPG0NJUw7pQuuuzdptNlm30=;
	b=fcizGRbg4Qvk3zAtFag3Dld0DZrPyHqS1xuloGhKi0CKFqRu/H/BGliPPdSGHRrlQi3x7R
	3b5qTuIHB/CCcCoySXanZekQqq/uTOsD4d6RTuBRmZkvIJz3DGKj2ZX3fPnj41F5+wQdBc
	Go2N/rfck4YlPQE8WeErmliCxSmYdzs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-CQx-MEL-N4aPoJ-RTJIZ9g-1; Fri,
 31 Jul 2026 10:11:53 -0400
X-MC-Unique: CQx-MEL-N4aPoJ-RTJIZ9g-1
X-Mimecast-MFC-AGG-ID: CQx-MEL-N4aPoJ-RTJIZ9g_1785507112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D995C195608E;
	Fri, 31 Jul 2026 14:11:51 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.33.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EEEC30002E9;
	Fri, 31 Jul 2026 14:11:48 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] dpll: use pin owner's dpll ref for pin-level attribute setting
Date: Fri, 31 Jul 2026 16:11:45 +0200
Message-ID: <20260731141146.1119147-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pin-level attributes (frequency, phase adjust, embedded sync, reference
sync) are properties of the pin itself, not of a particular DPLL device.
The get callbacks already use only the pin owner's DPLL reference
(via dpll_pin_own_dpll_ref_first()), but the set callbacks iterate over
all registered DPLL references and invoke the set operation on each one.

This is redundant because a pin is a single physical entity — setting
its frequency or phase adjust once through the owner's ops is sufficient.
Calling set on every registered DPLL just results in duplicate HW writes
for drivers that share a pin across multiple DPLL devices (e.g. ice
registers each input pin with both the EEC and PPS DPLL, zl3073x
registers input pins with every DPLL channel).

Simplify dpll_pin_freq_set(), dpll_pin_esync_set(),
dpll_pin_ref_sync_state_set() and dpll_pin_phase_adj_set() to call the
set callback only through the owner's DPLL reference, matching the
existing get-side behavior. This removes the xa_for_each iteration
loops, the now-unnecessary rollback logic, and several local variables.

No existing driver is affected:
  - ptp_ocp and mlx5 register each pin with a single DPLL.
  - ice registers input pins with two DPLLs (EEC and PPS) using
    identical ops and pin_priv; the set callbacks address the HW by
    pin index, not by DPLL, so the second call was a no-op.
  - zl3073x registers input pins with every DPLL channel; the set
    callbacks also address HW by pin/ref ID regardless of DPLL.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 213 +++++++++---------------------------
 1 file changed, 50 insertions(+), 163 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index afb31c0040382c..a909cd4451b008 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1079,10 +1079,9 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
 {
 	u64 freq = nla_get_u64(a), old_freq;
-	struct dpll_pin_ref *ref, *failed;
 	const struct dpll_pin_ops *ops;
+	struct dpll_pin_ref *ref;
 	struct dpll_device *dpll;
-	unsigned long i;
 	int ret;
 
 	if (!dpll_pin_is_freq_supported(pin, freq)) {
@@ -1090,22 +1089,17 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		return -EINVAL;
 	}
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if ((!ops->frequency_set || !ops->frequency_get) &&
-		    ref->dpll->module == pin->module &&
-		    ref->dpll->clock_id == pin->clock_id) {
-			NL_SET_ERR_MSG(extack,
-				       "frequency set not supported by the device");
-			return -EOPNOTSUPP;
-		}
-	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
 	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
 	ops = dpll_pin_ops(ref);
+	if (!ops->frequency_set || !ops->frequency_get) {
+		NL_SET_ERR_MSG(extack,
+			       "frequency set not supported by the device");
+		return -EOPNOTSUPP;
+	}
 	dpll = ref->dpll;
 	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
 				 dpll_priv(dpll), &old_freq, extack);
@@ -1116,68 +1110,42 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	if (freq == old_freq)
 		return 0;
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if (!ops->frequency_set)
-			continue;
-		dpll = ref->dpll;
-		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-					 dpll, dpll_priv(dpll), freq, extack);
-		if (ret) {
-			failed = ref;
-			NL_SET_ERR_MSG_FMT(extack, "frequency set failed for dpll_id:%u",
-					   dpll->id);
-			goto rollback;
-		}
+	ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				 dpll, dpll_priv(dpll), freq, extack);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "frequency set failed for dpll_id:%u",
+				   dpll->id);
+		return ret;
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
-
-rollback:
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		if (ref == failed)
-			break;
-		ops = dpll_pin_ops(ref);
-		if (!ops->frequency_set)
-			continue;
-		dpll = ref->dpll;
-		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-				       dpll, dpll_priv(dpll), old_freq, extack))
-			NL_SET_ERR_MSG(extack, "set frequency rollback failed");
-	}
-	return ret;
 }
 
 static int
 dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 		   struct netlink_ext_ack *extack)
 {
-	struct dpll_pin_ref *ref, *failed;
 	const struct dpll_pin_ops *ops;
 	struct dpll_pin_esync esync;
 	u64 freq = nla_get_u64(a);
+	struct dpll_pin_ref *ref;
 	struct dpll_device *dpll;
 	bool supported = false;
-	unsigned long i;
-	int ret;
+	int ret, i;
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if ((!ops->esync_set || !ops->esync_get) &&
-		    ref->dpll->module == pin->module &&
-		    ref->dpll->clock_id == pin->clock_id) {
-			NL_SET_ERR_MSG(extack,
-				       "embedded sync feature is not supported by this device");
-			return -EOPNOTSUPP;
-		}
-	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
 	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
 	ops = dpll_pin_ops(ref);
+	if (!ops->esync_set || !ops->esync_get) {
+		NL_SET_ERR_MSG(extack,
+			       "embedded sync feature is not supported by this device");
+		return -EOPNOTSUPP;
+	}
 	dpll = ref->dpll;
 	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
 			     dpll_priv(dpll), &esync, extack);
@@ -1196,44 +1164,17 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 		return -EINVAL;
 	}
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		void *pin_dpll_priv;
-
-		ops = dpll_pin_ops(ref);
-		if (!ops->esync_set)
-			continue;
-		dpll = ref->dpll;
-		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
-		ret = ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
-				      freq, extack);
-		if (ret) {
-			failed = ref;
-			NL_SET_ERR_MSG_FMT(extack,
-					   "embedded sync frequency set failed for dpll_id: %u",
-					   dpll->id);
-			goto rollback;
-		}
+	ret = ops->esync_set(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			     dpll_priv(dpll), freq, extack);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "embedded sync frequency set failed for dpll_id: %u",
+				   dpll->id);
+		return ret;
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
-
-rollback:
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		void *pin_dpll_priv;
-
-		if (ref == failed)
-			break;
-		ops = dpll_pin_ops(ref);
-		if (!ops->esync_set)
-			continue;
-		dpll = ref->dpll;
-		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
-		if (ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
-				   esync.freq, extack))
-			NL_SET_ERR_MSG(extack, "set embedded sync frequency rollback failed");
-	}
-	return ret;
 }
 
 static int
@@ -1241,14 +1182,12 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 			    unsigned long ref_sync_pin_idx,
 			    const enum dpll_pin_state state,
 			    struct netlink_ext_ack *extack)
-
 {
-	struct dpll_pin_ref *ref, *failed;
 	const struct dpll_pin_ops *ops;
 	enum dpll_pin_state old_state;
 	struct dpll_pin *ref_sync_pin;
+	struct dpll_pin_ref *ref;
 	struct dpll_device *dpll;
-	unsigned long i;
 	int ret;
 
 	ref_sync_pin = xa_find(&pin->ref_sync_pins, &ref_sync_pin_idx,
@@ -1282,42 +1221,20 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 	}
 	if (state == old_state)
 		return 0;
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if (!ops->ref_sync_set)
-			continue;
-		dpll = ref->dpll;
-		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-					ref_sync_pin,
-					dpll_pin_on_dpll_priv(dpll,
-							      ref_sync_pin),
-					state, extack);
-		if (ret) {
-			failed = ref;
-			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for dpll_id:%u",
-					   dpll->id);
-			goto rollback;
-		}
+
+	ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				ref_sync_pin,
+				dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
+				state, extack);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "reference sync set failed for dpll_id:%u",
+				   dpll->id);
+		return ret;
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
-
-rollback:
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		if (ref == failed)
-			break;
-		ops = dpll_pin_ops(ref);
-		if (!ops->ref_sync_set)
-			continue;
-		dpll = ref->dpll;
-		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-				      ref_sync_pin,
-				      dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
-				      old_state, extack))
-			NL_SET_ERR_MSG(extack, "set reference sync rollback failed");
-	}
-	return ret;
 }
 
 static int
@@ -1478,11 +1395,10 @@ static int
 dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		       struct netlink_ext_ack *extack)
 {
-	struct dpll_pin_ref *ref, *failed;
 	const struct dpll_pin_ops *ops;
 	s32 phase_adj, old_phase_adj;
+	struct dpll_pin_ref *ref;
 	struct dpll_device *dpll;
-	unsigned long i;
 	int ret;
 
 	phase_adj = nla_get_s32(phase_adj_attr);
@@ -1499,21 +1415,16 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		return -EINVAL;
 	}
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
-		    ref->dpll->module == pin->module &&
-		    ref->dpll->clock_id == pin->clock_id) {
-			NL_SET_ERR_MSG(extack, "phase adjust not supported");
-			return -EOPNOTSUPP;
-		}
-	}
 	ref = dpll_pin_own_dpll_ref_first(pin);
 	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
 	ops = dpll_pin_ops(ref);
+	if (!ops->phase_adjust_set || !ops->phase_adjust_get) {
+		NL_SET_ERR_MSG(extack, "phase adjust not supported");
+		return -EOPNOTSUPP;
+	}
 	dpll = ref->dpll;
 	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
 				    dpll, dpll_priv(dpll), &old_phase_adj,
@@ -1525,41 +1436,17 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	if (phase_adj == old_phase_adj)
 		return 0;
 
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		ops = dpll_pin_ops(ref);
-		if (!ops->phase_adjust_set)
-			continue;
-		dpll = ref->dpll;
-		ret = ops->phase_adjust_set(pin,
-					    dpll_pin_on_dpll_priv(dpll, pin),
-					    dpll, dpll_priv(dpll), phase_adj,
-					    extack);
-		if (ret) {
-			failed = ref;
-			NL_SET_ERR_MSG_FMT(extack,
-					   "phase adjust set failed for dpll_id:%u",
-					   dpll->id);
-			goto rollback;
-		}
+	ret = ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				    dpll, dpll_priv(dpll), phase_adj, extack);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "phase adjust set failed for dpll_id:%u",
+				   dpll->id);
+		return ret;
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
-
-rollback:
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		if (ref == failed)
-			break;
-		ops = dpll_pin_ops(ref);
-		if (!ops->phase_adjust_set)
-			continue;
-		dpll = ref->dpll;
-		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-					  dpll, dpll_priv(dpll), old_phase_adj,
-					  extack))
-			NL_SET_ERR_MSG(extack, "set phase adjust rollback failed");
-	}
-	return ret;
 }
 
 static int

base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
-- 
2.54.0

