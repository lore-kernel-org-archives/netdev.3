Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BF49B1F0
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300702; cv=none; b=K+a80e7W4dpm6/1HxI5a6XVfyMJBUxGsTnHAF79mIvHRrCwGGOFQb2audEQBYAaTW65jWIXKU+iMqxsfG1g7rES95gBDzaP8PD8FDk8K32ZC5VcAcDQrwE0wrr58SQvasMHoO/o8AdOIo4W8E5H9+NhAudhChOM48O19EwAEk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300702; c=relaxed/simple;
	bh=fEj+bakI6msOunQ7oTzPxkiP9wB28NSYbBXn7xIQyYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWetm6I9zabjAFDNLbQgdwOgOCxZc3zAJZ8XzE0t9plYmrxCJKIA/aBGR1kRgMNhsDMXCHf6n9VrU06sfj7qTrKVyHzRPuXtZDO13S+pQ5IfCwfPsCU349koogDVP4wJdnxnMy1x6LlohwdqUt5seqMy7N6/YyIVQKguYYErjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPJhcxg6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPJhcxg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791300699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkH1gvwhu9s4Gt4v8rkSgzP7sjITLH5Ge6IprD9iQuM=;
	b=HPJhcxg6iZscEhzxx1jirlHUz/uVnqgE4UxSWkEe7p8EtG7EM+xbXsUZk0O55IzaV7rXKB
	CWrF5scB/fttATgPLrYXMtN+Ou3ztmo8bijnEFuZ2efSKjFSiV8VpmoBTArW0G/MK6ZeAB
	b/mSGHh3nYjSJB55hU+gja2BuJEbLU4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-F2xOq2PsPVa8UiyApFMO6A-1; Tue,
 06 Oct 2026 11:31:36 -0400
X-MC-Unique: F2xOq2PsPVa8UiyApFMO6A-1
X-Mimecast-MFC-AGG-ID: F2xOq2PsPVa8UiyApFMO6A_1791300692
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D4C1869DB0;
	Tue,  6 Oct 2026 15:31:32 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D442180059A;
	Tue,  6 Oct 2026 15:31:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/4] dpll: zl3073x: notify sibling pin when shared output config changes
Date: Tue,  6 Oct 2026 17:31:16 +0200
Message-ID: <20261006153116.347497-5-ivecera@redhat.com>
In-Reply-To: <20261006153116.347497-1-ivecera@redhat.com>
References: <20261006153116.347497-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Each zl3073x output has a P-pin and an N-pin that share a single HW
output and, outside N-pin divide mode, share the output's divisor,
clock type, esync period/width and phase compensation registers.
Changing one of these settings through one pin's dpll_pin therefore
also changes the other (sibling) pin's effective configuration, but
only the pin the change was requested on gets a dpll_pin_change_ntf()
notification - userspace listening on the sibling pin is never told
its frequency, esync configuration or phase adjustment changed.

This was found by code inspection rather than triggered at runtime: a
dpll pin-get on the sibling pin returns the correct current values, but
because no change notification is emitted for it, userspace is never
told that its configuration changed asynchronously through the other
pin.

Add zl3073x_dpll_output_pin_sibling_get() to look up the other pin of
an output pair, and use it in frequency_set() (for the non-N-divided
signal formats, where the output divisor is shared), esync_set() and
phase_adjust_set() to notify the sibling pin, if it is registered,
whenever the shared HW state actually changes.

The three callbacks are switched from guard(mutex) to explicit
mutex_lock()/mutex_unlock() with goto-based unwinding, because the
notification must run after zldpll->lock is released: the notification
re-enters the pin get callbacks, which take zldpll->lock again, so
calling it under the lock would deadlock. The DPLL subsystem's own
dpll_lock is still held across the callback, so the __ (lock-held)
notification variant is used.

The sibling lookup walks the zldpll->pins list, so the list membership
has to match the DPLL registration state. dpll_pin_register() publishes
a pin (and P is registered before N) before it used to be added to the
list, and teardown detached the whole list before unregistering any
pin, so a sibling that is registered - and thus reachable by a PIN_SET
on the other pin - could be missing from the list and never notified.
Add the pin to the list before dpll_pin_register() and remove it only
after dpll_pin_unregister(), both under zldpll->lock, and assert the
lock in the lookup helper. A pin that is transiently on the list while
not registered is harmless: __dpll_pin_change_ntf() is a no-op for a
pin that is not available, and the sibling cannot be freed under the
lookup because the freeing goes through dpll_pin_unregister(), which
takes dpll_lock that the notification path holds.

Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 187 ++++++++++++++++++++++++++++--------
 1 file changed, 146 insertions(+), 41 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 65107b4cc4f8..9c678acc3e77 100644
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
@@ -132,11 +134,39 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
 	return NULL;
 }
 
+/**
+ * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
+ * @pin: output pin whose sibling is sought
+ *
+ * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
+ * single HW output. Looks up the other pin of the pair, if it is
+ * registered as a dpll_pin on this DPLL.
+ *
+ * Return: pointer to sibling pin, or NULL if it is not registered
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
@@ -899,12 +929,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
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
@@ -913,12 +945,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
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
@@ -927,9 +961,24 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 
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
@@ -959,12 +1008,14 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling = NULL;
 	const struct zl3073x_synth *synth;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -977,7 +1028,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	/* Check signal format */
 	if (!zl3073x_out_is_ndiv(&out)) {
 		/* For non N-divided signal formats the frequency is computed
-		 * as division of synth frequency and output divisor.
+		 * as division of synth frequency and output divisor, which
+		 * is shared by both pins of the output pair.
 		 */
 		out.div = new_div;
 
@@ -1002,7 +1054,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
@@ -1017,18 +1078,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		u32 rem;
 
 		out.esync_n_period = div_u64_rem(prod, new_div, &rem);
-		if (rem != 0) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "OUT%uN freq must divide OUT%uP freq",
-					   out_id, out_id);
-			return -EINVAL;
-		}
-		if (out.esync_n_period < 2) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "OUT%uN freq must be less than OUT%uP freq",
-					   out_id, out_id);
-			return -EINVAL;
-		}
+		if (rem != 0)
+			goto err_n_nondiv;
+		if (out.esync_n_period < 2)
+			goto err_n_toohigh;
 
 		/* Update the output divisor */
 		out.div = new_div;
@@ -1046,25 +1099,36 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		u64 rem, prod = frequency * out.div;
 
 		out.esync_n_period = div64_u64_rem(synth_freq, prod, &rem);
-		if (rem != 0) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "OUT%uN freq must divide OUT%uP freq",
-					   out_id, out_id);
-			return -EINVAL;
-		}
-		if (out.esync_n_period < 2) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "OUT%uN freq must be less than OUT%uP freq",
-					   out_id, out_id);
-			return -EINVAL;
-		}
+		if (rem != 0)
+			goto err_n_nondiv;
+		if (out.esync_n_period < 2)
+			goto err_n_toohigh;
 	}
 
 	/* For 50/50 duty cycle the divisor is equal to width */
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
+err_n_nondiv:
+	NL_SET_ERR_MSG_FMT(extack,
+			   "OUT%uN freq must divide OUT%uP freq",
+			   out_id, out_id);
+	rc = -EINVAL;
+	goto unlock;
+err_n_toohigh:
+	NL_SET_ERR_MSG_FMT(extack,
+			   "OUT%uN freq must be less than OUT%uP freq",
+			   out_id, out_id);
+	rc = -EINVAL;
+	goto unlock;
 }
 
 static int
@@ -1103,10 +1167,12 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
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
@@ -1115,7 +1181,21 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
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
@@ -1739,6 +1819,13 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
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
@@ -1750,6 +1837,9 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	return 0;
 
 err_register:
+	mutex_lock(&zldpll->lock);
+	list_del(&pin->list);
+	mutex_unlock(&zldpll->lock);
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 err_pin_get:
 	pin->dpll_pin = NULL;
@@ -1784,6 +1874,13 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
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
 
@@ -1803,9 +1900,11 @@ zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
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
@@ -1918,16 +2017,24 @@ zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
 		goto err_pin_get;
 	}
 
+	/* Add the pin to the list before registering it with the DPLL core so
+	 * that the list reflects the DPLL registration state.
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
@@ -1979,8 +2086,6 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 			zl3073x_dpll_pin_free(pin);
 			goto error;
 		}
-
-		list_add(&pin->list, &zldpll->pins);
 	}
 
 	/* Register NCO virtual input pin */
-- 
2.55.0

