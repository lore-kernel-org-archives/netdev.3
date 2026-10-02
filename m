Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A5443312
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927143; cv=none; b=jbhznAnoO9e7dIL8kxFEjjN6KP6AKMmKTEh41NcllS6LV9FCovrimU4bHrEU9CoD0H9Of7Z0j2MIQDRerMZo3/zlnZw5Bm0D6cU+eZbUY8NXhPFRrqEWDoyRpNWJAIFtyw0e2p5VsYMpiK3XfU+jyWo6/t4hgJPgeAqXcb9k0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927143; c=relaxed/simple;
	bh=RQJkBQNV82p9V/Kvtcn884bmC4HzkfOXS0rdEN72Im0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzDUPCLkvZqPEHHd/Q2R4ZR8+3p6sFXKKRqeXsbRopqBiRdgNoKlRgihN2vVxou3MVORdbUbZrSYiDRnN9Ynv62MkPwa/OHUdis+93+lcrlgU03FH0FxXUVhGlPkWWLVsn0gn2el2flhl+oT3ICM/WsamUCfiBTS/pdB9TA9c1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpOLRuoU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpOLRuoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790927138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERXvvmqUcGgMiKIFC6s7EaOOftHeSv3rqdJ+nvFQbZE=;
	b=VpOLRuoUO8nGxH+Un8scF5tfO6CQ1xs53lErIUgZhM68zwwkNqwaVN0Lagby0h15EcobUq
	HIzGzWjLBMA77/uVujiR2OmHJtVRJ+cijRvcYtAjY4NT0GcQd5cYSKjwM+rEWHsz6hcHk7
	k/PwktoUYYu52ixacRgDeJ+lV2GXyOU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-0sD3SKiyMkmooDEAoy-lbw-1; Fri,
 02 Oct 2026 03:45:32 -0400
X-MC-Unique: 0sD3SKiyMkmooDEAoy-lbw-1
X-Mimecast-MFC-AGG-ID: 0sD3SKiyMkmooDEAoy-lbw_1790927131
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D76EF1955DAC;
	Fri,  2 Oct 2026 07:45:30 +0000 (UTC)
Received: from p16v.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D4BE180035F;
	Fri,  2 Oct 2026 07:45:28 +0000 (UTC)
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
Subject: [PATCH net v2 2/2] dpll: zl3073x: notify sibling pin when shared output config changes
Date: Fri,  2 Oct 2026 09:45:20 +0200
Message-ID: <20261002074520.30048-3-ivecera@redhat.com>
In-Reply-To: <20261002074520.30048-1-ivecera@redhat.com>
References: <20261002074520.30048-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

The sibling lookup walks the zldpll->pins list, so serialize all
accesses to that list with zldpll->lock: take it around the list_add()
in the pin registration paths and around the list_splice_init() that
detaches the list on teardown, and assert it is held in the list
walkers. Without this the walk could race with concurrent pin
registration or teardown, and the sibling pin could be freed between
the lookup and the notification.

Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 133 +++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 18 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 19456fbeeea8..b60d3280574a 100644
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
 
@@ -1001,7 +1053,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
@@ -1013,8 +1074,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		 * Update divisor for N-pin to keep N-pin frequency.
 		 */
 		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
-		if (!out.esync_n_period)
-			return -EINVAL;
+		if (!out.esync_n_period) {
+			rc = -EINVAL;
+			goto unlock;
+		}
 
 		/* Update the output divisor */
 		out.div = new_div;
@@ -1030,15 +1093,24 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		 * Update divisor for N-pin
 		 */
 		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
-		if (!out.esync_n_period)
-			return -EINVAL;
+		if (!out.esync_n_period) {
+			rc = -EINVAL;
+			goto unlock;
+		}
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
 }
 
 static int
@@ -1077,10 +1149,12 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
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
@@ -1089,7 +1163,21 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
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
@@ -1776,10 +1864,15 @@ static void
 zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dpll_pin *pin, *next;
+	LIST_HEAD(pin_list);
 
-	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
-		zl3073x_dpll_pin_unregister(pin);
+	mutex_lock(&zldpll->lock);
+	list_splice_init(&zldpll->pins, &pin_list);
+	mutex_unlock(&zldpll->lock);
+
+	list_for_each_entry_safe(pin, next, &pin_list, list) {
 		list_del(&pin->list);
+		zl3073x_dpll_pin_unregister(pin);
 		zl3073x_dpll_pin_free(pin);
 	}
 }
@@ -1897,7 +1990,9 @@ zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
 	if (rc)
 		goto err_register;
 
+	mutex_lock(&zldpll->lock);
 	list_add(&pin->list, &zldpll->pins);
+	mutex_unlock(&zldpll->lock);
 
 	return 0;
 
@@ -1954,7 +2049,9 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 			goto error;
 		}
 
+		mutex_lock(&zldpll->lock);
 		list_add(&pin->list, &zldpll->pins);
+		mutex_unlock(&zldpll->lock);
 	}
 
 	/* Register NCO virtual input pin */
-- 
2.55.0

