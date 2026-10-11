Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BF33F5BC
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699160; cv=none; b=PkaynkRER4NC35lfwnrnD8IuLTr1+/aCOvmVLEpl1LFHqDtkbPd/UTYCn23Tbosc7caWr5vgYTngNUzyv/3ThpczwpLT8qalcLFZA2wrVXFg2l5tRNI6KZ4XiudFpVg5yzwBewcSqeM5PnO3vIKgBLYIS4O4A0U/nbHn3Yh1hII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699160; c=relaxed/simple;
	bh=7ThhzBvOWHWuYU5Sp1diE1LOfa9vUSCF1XL1VWrwzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INfdfGH0V8fv11o8wyi5rdcrPhf64s+SdH2NK/NYmmOWFqIkEtNGBFZ6VnSMbQ+P4/HhoegmvmZGeRGs9bvfG1S2tc+vPyPNoYrVkwZEVqVQYE+/GJnk5xWKLtsgj0zrM5VjT9a44QvWZ7Gqpynn2jPc7RQqI9F9rGis1zEmofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZx6mEQX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZx6mEQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791699155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BU4+eQIdWGVJ9C2EKz8P+UqRUbc3IXVOq93kMZKF4Pg=;
	b=HZx6mEQXoiL8hRenRzxuQEK/hi539/W690Z0TKlXWXCKdDPi/GZYmuuPJB0XRCdum1pxj9
	K2XowxdVaznbIhzqotY6klu//JRvp6hgwHoSlB/y2q6NR+lXcAPJQpLPq35OYrDwqVUChT
	cnSdREy/O/rReIM0aEWEws4ppjlthAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-AOwQtuM5OG20NnM6VhKnng-1; Sun,
 11 Oct 2026 06:12:33 +0000
X-MC-Unique: AOwQtuM5OG20NnM6VhKnng-1
X-Mimecast-MFC-AGG-ID: AOwQtuM5OG20NnM6VhKnng_1791699150
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDDAB1800607;
	Sun, 11 Oct 2026 06:12:30 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20F291956095;
	Sun, 11 Oct 2026 06:12:27 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 5/5] dpll: zl3073x: notify sibling pin when shared output config changes
Date: Sun, 11 Oct 2026 08:12:11 +0200
Message-ID: <20261011061211.448373-6-ivecera@redhat.com>
In-Reply-To: <20261011061211.448373-1-ivecera@redhat.com>
References: <20261011061211.448373-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The P-pin and N-pin of an output share the divisor, clock type, eSync
and phase compensation registers (outside N-divided mode). Changing
them through one pin changes the other pin too, but only the requested
pin gets a change notification.

Add zl3073x_dpll_output_pin_sibling_get() and notify the sibling from
frequency_set(), esync_set() and phase_adjust_set(). The notification
re-enters the pin get callbacks, so it has to be sent after
zldpll->lock is released and the callbacks switch from guard(mutex)
to explicit unlocking.

To always find a registered sibling, add a pin to zldpll->pins before
dpll_pin_register() and remove it only after dpll_pin_unregister(),
both under zldpll->lock. A pin that is on the list but not registered
gets no netlink notification, as dpll_pin_event_send() skips such
pins, and the only in-tree DPLL notifier ignores DPLL_PIN_CHANGED.

Found by code inspection, not triggered at runtime.

Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 155 +++++++++++++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 20 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 6d9a6d21d30b..1cdadb8e46fb 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -123,6 +123,8 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
 {
 	struct zl3073x_dpll_pin *pin;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		if (zl3073x_dpll_is_input_pin(pin) &&
 		    zl3073x_input_pin_ref_get(pin->id) == ref_id)
@@ -132,11 +134,42 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
 	return NULL;
 }
 
+/**
+ * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
+ * @pin: output pin whose sibling is sought
+ *
+ * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
+ * single HW output. Looks up the other pin of the pair in the pin list
+ * of this DPLL. A pin is on the list from just before its registration
+ * until just after its unregistration, so a registered sibling is always
+ * found, but the returned pin may also be one that is not (yet or any
+ * longer) registered.
+ *
+ * Return: pointer to sibling pin, or NULL if it is not on the pin list
+ */
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_output_pin_sibling_get(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll_pin *sibling;
+
+	lockdep_assert_held(&pin->dpll->lock);
+
+	list_for_each_entry(sibling, &pin->dpll->pins, list) {
+		if (!zl3073x_dpll_is_input_pin(sibling) &&
+		    sibling->id == (pin->id ^ 1))
+			return sibling;
+	}
+
+	return NULL;
+}
+
 static struct zl3073x_dpll_pin *
 zl3073x_dpll_nco_pin_get(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dpll_pin *pin;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		if (zl3073x_dpll_is_nco_pin(pin))
 			return pin;
@@ -909,12 +942,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling = NULL;
 	const struct zl3073x_synth *synth;
 	struct zl3073x_out out;
 	u32 synth_freq;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -923,12 +958,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	if (zl3073x_out_is_ndiv(&out))
-		return -EOPNOTSUPP;
+	if (zl3073x_out_is_ndiv(&out)) {
+		rc = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	if (!freq) {
 		zl3073x_out_esync_disable(&out);
-		return zl3073x_out_state_set(zldev, out_id, &out);
+		goto commit;
 	}
 
 	/* Get attached synth frequency */
@@ -937,9 +974,24 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 
 	/* Enable 1PPS eSync for this pin frequency */
 	zl3073x_out_esync_enable(&out, synth_freq / out.div);
-
+commit:
 	/* Commit output configuration */
-	return zl3073x_out_state_set(zldev, out_id, &out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		goto unlock;
+
+	/* The clock type, esync period and esync width are all shared by
+	 * both pins of the output pair, so the sibling pin's esync
+	 * configuration changes too and userspace has to be notified.
+	 */
+	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+unlock:
+	mutex_unlock(&zldpll->lock);
+
+	if (!rc && sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return rc;
 }
 
 static int
@@ -969,13 +1021,15 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling = NULL;
 	const struct zl3073x_synth *synth;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
 	u64 n_period, rem;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -988,7 +1042,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	/* Check signal format */
 	if (!zl3073x_out_is_ndiv(&out)) {
 		/* For non N-divided signal formats the frequency is computed
-		 * as division of synth frequency and output divisor.
+		 * as division of synth frequency and output divisor, which
+		 * is shared by both pins of the output pair.
 		 */
 		out.div = new_div;
 
@@ -1013,7 +1068,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		}
 
 		/* Commit output configuration */
-		return zl3073x_out_state_set(zldev, out_id, &out);
+		rc = zl3073x_out_state_set(zldev, out_id, &out);
+		if (rc)
+			goto unlock;
+
+		/* The other pin's frequency changed too - it has to be
+		 * notified about the change.
+		 */
+		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+
+		goto unlock;
 	}
 
 	if (zl3073x_dpll_is_p_pin(pin)) {
@@ -1039,19 +1103,22 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		NL_SET_ERR_MSG_FMT(extack,
 				   "OUT%uN freq must be at most half of OUT%uP freq",
 				   out_id, out_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto unlock;
 	}
 	if (n_period > U32_MAX) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "OUT%uN freq is too low for OUT%uP freq",
 				   out_id, out_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto unlock;
 	}
 	if (rem != 0) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "OUT%uN freq must divide OUT%uP freq",
 				   out_id, out_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto unlock;
 	}
 	out.esync_n_period = n_period;
 
@@ -1059,7 +1126,14 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	out.esync_n_width = out.esync_n_period;
 
 	/* Commit output configuration */
-	return zl3073x_out_state_set(zldev, out_id, &out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+unlock:
+	mutex_unlock(&zldpll->lock);
+
+	if (!rc && sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return rc;
 }
 
 static int
@@ -1098,10 +1172,12 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling = NULL;
 	struct zl3073x_out out;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -1110,7 +1186,21 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	out.phase_comp = phase_adjust / pin->phase_gran;
 
 	/* Update output configuration from mailbox */
-	return zl3073x_out_state_set(zldev, out_id, &out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		goto unlock;
+
+	/* The phase compensation register is shared by both pins of the
+	 * output pair, so the sibling pin's phase adjustment changes too.
+	 */
+	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+unlock:
+	mutex_unlock(&zldpll->lock);
+
+	if (!rc && sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return rc;
 }
 
 static int
@@ -1734,6 +1824,13 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	else
 		ops = &zl3073x_dpll_output_pin_ops;
 
+	/* Add the pin to the list before registering it with the DPLL core so
+	 * that it is findable as a sibling as soon as the core publishes it.
+	 */
+	mutex_lock(&zldpll->lock);
+	list_add(&pin->list, &zldpll->pins);
+	mutex_unlock(&zldpll->lock);
+
 	/* Register the pin */
 	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
 	if (rc)
@@ -1745,6 +1842,9 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	return 0;
 
 err_register:
+	mutex_lock(&zldpll->lock);
+	list_del(&pin->list);
+	mutex_unlock(&zldpll->lock);
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 err_pin_get:
 	pin->dpll_pin = NULL;
@@ -1779,6 +1879,13 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 	/* Unregister the pin */
 	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
 
+	/* Remove the pin from the list only after it has been unregistered so
+	 * that a still-registered pin is always findable as a sibling.
+	 */
+	mutex_lock(&zldpll->lock);
+	list_del(&pin->list);
+	mutex_unlock(&zldpll->lock);
+
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 	pin->dpll_pin = NULL;
 
@@ -1798,9 +1905,11 @@ zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dpll_pin *pin, *next;
 
+	/* Unregister each pin before removing it from the list so that a
+	 * still-registered pin is always findable as a sibling.
+	 */
 	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
 		zl3073x_dpll_pin_unregister(pin);
-		list_del(&pin->list);
 		zl3073x_dpll_pin_free(pin);
 	}
 }
@@ -1913,16 +2022,24 @@ zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
 		goto err_pin_get;
 	}
 
+	/* Add the pin to the list before registering it with the DPLL core so
+	 * that a registered pin is always on the list.
+	 */
+	mutex_lock(&zldpll->lock);
+	list_add(&pin->list, &zldpll->pins);
+	mutex_unlock(&zldpll->lock);
+
 	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin,
 			       &zl3073x_dpll_nco_pin_ops, pin);
 	if (rc)
 		goto err_register;
 
-	list_add(&pin->list, &zldpll->pins);
-
 	return 0;
 
 err_register:
+	mutex_lock(&zldpll->lock);
+	list_del(&pin->list);
+	mutex_unlock(&zldpll->lock);
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 err_pin_get:
 	pin->dpll_pin = NULL;
@@ -1974,8 +2091,6 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 			zl3073x_dpll_pin_free(pin);
 			goto error;
 		}
-
-		list_add(&pin->list, &zldpll->pins);
 	}
 
 	/* Register NCO virtual input pin */
-- 
2.56.0

