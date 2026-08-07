Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C9409624
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096789; cv=none; b=rweEZ5jfBByPvoU2yTMnRn7dQG1ol8rWcIajrJeF6WMsZkrgYc8MDYSaeSctDnt+C8ouRfLAxDdjUWpKzXGwyLIit3q8kE3aA+mzmxvVu1grQHQHrz7AZZ5vgf0z92p4vMtJ6i4Q3vkVmUQ8GTSvCgu2pjwPzlKgxkkNPDH0SA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096789; c=relaxed/simple;
	bh=K0H9fewkIhlXFTqjkM30OaQUwcL139AqnCgFNBomnoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFNHVWblt+K9kHfXlMG2cmVRHh4FIHmCaHP7xVR98CNsk4LcuE4JHIZmeBeYldnofJAh4QDpe3VCzXlXzU2sJtBPbvP0m6fqrf5A4Yth33oCMK/FdSx5z8yvSpbPu6ET09fhV4L68Z9bRKNw4oOIpEkED4E5IIgnRLpgRhm4EKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/93YKya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/93YKya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786096787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBdE0GGKObowf+Tk1zmn9S0i/uvPVbxIgS5ePj0YzYk=;
	b=f/93YKya929FqjHoDi1PUrbkk+pFgcgL0UvRoTgpNkNMbtMpXjunN0aY2ue0o79yrESbE5
	O2xUgLZsqSrktoJ9tq2fWXNIL95ldnpJKI53imk4W1loBKWDFifrs8hZboTcfIIhqDE7N9
	y+JqyxErX1WLaJUxc53KQcDo1pp2Pf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-w4RfsUl4NOmSbPqmubJCKg-1; Fri,
 07 Aug 2026 05:59:41 -0400
X-MC-Unique: w4RfsUl4NOmSbPqmubJCKg-1
X-Mimecast-MFC-AGG-ID: w4RfsUl4NOmSbPqmubJCKg_1786096780
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9311195608F;
	Fri,  7 Aug 2026 09:59:39 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1912930001A2;
	Fri,  7 Aug 2026 09:59:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v3 2/2] dpll: use pin owner's dpll ref for pin-level attribute setting
Date: Fri,  7 Aug 2026 11:59:26 +0200
Message-ID: <20260807095926.386923-3-ivecera@redhat.com>
In-Reply-To: <20260807095926.386923-1-ivecera@redhat.com>
References: <20260807095926.386923-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pin-level attributes (frequency, phase adjust, embedded sync, reference
sync) are properties of the pin itself, not of a particular DPLL device.
The get callbacks already use only the pin owner's DPLL reference
(via dpll_pin_own_dpll_ref_first()), but the set callbacks iterate over
all registered DPLL references and invoke the set operation on each one.

This is redundant because a pin is a single physical entity - setting
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

The -EOPNOTSUPP validation loop, which checked ops support across all
owner-matching references, is replaced with a direct check on the
single owner reference returned by dpll_pin_own_dpll_ref_first().

The documentation in dpll.rst is updated to reflect that pin-level
attributes are set through the pin owner's dpll reference only.

No existing driver is affected:
  - ptp_ocp and mlx5 register each pin with a single DPLL.
  - ice registers input pins with two DPLLs (EEC and PPS) using
    identical ops and pin_priv; the set callbacks address the HW by
    pin index, not by DPLL, so the second call was a no-op.
  - zl3073x registers input pins with every DPLL channel; the set
    callbacks address HW by pin/ref ID regardless of DPLL. The
    ref_sync_set callback was the only one with per-channel behavior,
    addressed by the preceding patch.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst |  11 +-
 drivers/dpll/dpll_netlink.c       | 213 +++++++-----------------------
 2 files changed, 56 insertions(+), 168 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index f83150917814e2..7c117ae37cc1bc 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -116,8 +116,9 @@ Shared pins
 A single pin object can be attached to multiple dpll devices.
 Then there are two groups of configuration knobs:
 
-1) Set on a pin - the configuration affects all dpll devices pin is
-   registered to (i.e., ``DPLL_A_PIN_FREQUENCY``),
+1) Set on a pin - the configuration is a property of the pin itself and
+   applies to all dpll devices the pin is registered with
+   (i.e., ``DPLL_A_PIN_FREQUENCY``),
 2) Set on a pin-dpll tuple - the configuration affects only selected
    dpll device (i.e., ``DPLL_A_PIN_PRIO``, ``DPLL_A_PIN_STATE``,
    ``DPLL_A_PIN_DIRECTION``).
@@ -507,9 +508,9 @@ as well as parameter being configured (``DPLL_A_MODE``).
 ``DPLL_CMD_PIN_SET`` - to target a pin user must provide a
 ``DPLL_A_PIN_ID``, which is unique identifier of a pin in the system.
 Also configured pin parameters must be added.
-If ``DPLL_A_PIN_FREQUENCY`` is configured, this affects all the dpll
-devices that are connected with the pin, that is why frequency attribute
-shall not be enclosed in ``DPLL_A_PIN_PARENT_DEVICE``.
+If ``DPLL_A_PIN_FREQUENCY`` is configured, it is a property of the pin
+itself and applies to all dpll devices the pin is registered with, so the
+frequency attribute shall not be enclosed in ``DPLL_A_PIN_PARENT_DEVICE``.
 Other attributes: ``DPLL_A_PIN_PRIO``, ``DPLL_A_PIN_STATE`` or
 ``DPLL_A_PIN_DIRECTION`` must be enclosed in
 ``DPLL_A_PIN_PARENT_DEVICE`` as their configuration relates to only one
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
-- 
2.54.0

