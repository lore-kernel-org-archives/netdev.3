Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CC3DB994
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621785; cv=none; b=jw4WRytpZbvTAjhnv+5jp5/HJ35k31xmqB4Wa9GF/ZSB8sirElYHCBDd/YxbPQHwDDa8pbozAkzcHxXfDgOq5gZOle1XewqwzYwwIwJR8U7rdJHEuD5LWvB+VXgijdhLhnYGqu2wa4K9YLtjM3w8qP2Gms7I8uyM94jSVQ7RlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621785; c=relaxed/simple;
	bh=QHYhmIsC4fLE5A5ohoYdO+pX+EOf3rlkAyMGo8E+U5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWCILXI2Cvt/zEW8N1PINHda9DfY8hs/yJSUKMRkTHX9DiEkqrfUgAYmbYVm3JRuN19FzQFj58SacRDoptCoEUASRB7Yzz5wuP2+1jrmHjmGaa8QdDUtgQ0vKOqSWOPWK+SLkmbz79NqD7VqKNI70Lrj8ZNlOrO0gsck0GcYyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kr//F0kB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr//F0kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3NOemaTZ4/HpjlagWwpnXXCe3DReGaDR1XaHa8RNys=;
	b=Kr//F0kBEfCxCqFaeYx0ae34XwWlpP8UNsYhTrtHVmPZQP+44DClwvWIqLGxO1WO1lxThN
	VONfjsSbJS7MViGQVu0Fp9cdXWRjrG8926a1hEDKEasDxHEiAIc5xH8+w/bbObH4NN9oEt
	5BFZ4HHKMoYICavziSFELLkF3H4drSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-6cO4M8gOMBOjs1dGZM-rfw-1; Mon,
 28 Sep 2026 14:56:16 -0400
X-MC-Unique: 6cO4M8gOMBOjs1dGZM-rfw-1
X-Mimecast-MFC-AGG-ID: 6cO4M8gOMBOjs1dGZM-rfw_1790621775
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F21B31921EC5;
	Mon, 28 Sep 2026 18:56:14 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32F241956041;
	Mon, 28 Sep 2026 18:56:12 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] dpll: zl3073x: factor out output pin frequency helper
Date: Mon, 28 Sep 2026 20:55:51 +0200
Message-ID: <20260928185552.1103515-6-ivecera@redhat.com>
In-Reply-To: <20260928185552.1103515-1-ivecera@redhat.com>
References: <20260928185552.1103515-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Extract the divisor and N-division computation from the output pin
frequency_set callback into zl3073x_dpll_output_pin_freq_set(), which
updates a struct zl3073x_out without committing it to hardware. This
lets the upcoming PTP periodic output support reuse the same P-pin,
N-pin and N-divided frequency handling.

No functional change intended.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 135 ++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 61 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index fcf91aba2988af..0a36a2acf15b9f 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1032,96 +1032,109 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_output_pin_freq_set - compute output config for pin frequency
+ * @pin: output pin to set the frequency for
+ * @out: output state to update, not committed to hardware
+ * @frequency: requested pin frequency in Hz
+ *
+ * Updates the divisor and N-division fields of @out so the given output
+ * pin runs at the requested frequency. For non N-divided formats the
+ * divisor is shared by both pins of the output pair. The caller is
+ * responsible for committing @out with zl3073x_out_state_set().
+ *
+ * Return: 0 on success, -EINVAL if the frequency cannot be represented
+ */
 static int
-zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
-				      void *pin_priv,
-				      const struct dpll_device *dpll,
-				      void *dpll_priv, u64 frequency,
-				      struct netlink_ext_ack *extack)
+zl3073x_dpll_output_pin_freq_set(struct zl3073x_dpll_pin *pin,
+				 struct zl3073x_out *out, u64 frequency)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
-	struct zl3073x_dev *zldev = zldpll->dev;
-	struct zl3073x_dpll_pin *pin = pin_priv;
-	struct zl3073x_dpll_pin *sibling = NULL;
-	const struct zl3073x_synth *synth;
+	struct zl3073x_dev *zldev = pin->dpll->dev;
 	u32 new_div, synth_freq;
-	struct zl3073x_out out;
-	u8 out_id;
-	int rc;
+	u8 synth;
 
-	mutex_lock(&zldpll->lock);
-
-	out_id = zl3073x_output_pin_out_get(pin->id);
-	out = *zl3073x_out_state_get(zldev, out_id);
-
-	/* Get attached synth frequency and compute new divisor */
-	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
-	synth_freq = zl3073x_synth_freq_get(synth);
+	synth = zl3073x_out_synth_get(out);
+	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
 	new_div = synth_freq / (u32)frequency;
 
-	/* Check signal format */
-	if (!zl3073x_out_is_ndiv(&out)) {
+	if (!zl3073x_out_is_ndiv(out)) {
 		/* For non N-divided signal formats the frequency is computed
 		 * as division of synth frequency and output divisor, which
 		 * is shared by both pins of the output pair.
 		 */
-		out.div = new_div;
+		out->div = new_div;
 
 		/* For 50/50 duty cycle the divisor is equal to width */
-		out.width = new_div;
-
-		/* Commit output configuration */
-		rc = zl3073x_out_state_set(zldev, out_id, &out);
-		if (rc)
-			goto unlock;
+		out->width = new_div;
 
-		/* The other pin's frequency changed too - it has to be
-		 * notified about the change.
-		 */
-		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
-
-		goto unlock;
+		return 0;
 	}
 
 	if (zl3073x_dpll_is_p_pin(pin)) {
-		/* We are going to change output frequency for P-pin but
-		 * if the requested frequency is less than current N-pin
-		 * frequency then indicate a failure as we are not able
-		 * to compute N-pin divisor to keep its frequency unchanged.
-		 *
-		 * Update divisor for N-pin to keep N-pin frequency.
+		/* Changing the P-pin frequency, rescale the N-pin divisor to
+		 * keep the N-pin frequency unchanged. Fail if the requested
+		 * frequency is too low to represent the current N-pin one.
 		 */
-		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
-		if (!out.esync_n_period) {
-			rc = -EINVAL;
-			goto unlock;
-		}
+		out->esync_n_period = out->esync_n_period * out->div / new_div;
+		if (!out->esync_n_period)
+			return -EINVAL;
 
 		/* Update the output divisor */
-		out.div = new_div;
+		out->div = new_div;
 
 		/* For 50/50 duty cycle the divisor is equal to width */
-		out.width = out.div;
+		out->width = new_div;
 	} else {
-		/* We are going to change frequency of N-pin but if
-		 * the requested freq is greater or equal than freq of P-pin
-		 * in the output pair we cannot compute divisor for the N-pin.
-		 * In this case indicate a failure.
-		 *
-		 * Update divisor for N-pin
+		/* Changing the N-pin frequency. Fail if the requested
+		 * frequency is higher than or does not divide the P-pin one.
 		 */
-		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
-		if (!out.esync_n_period) {
-			rc = -EINVAL;
-			goto unlock;
-		}
+		out->esync_n_period = div64_u64(synth_freq,
+						frequency * out->div);
+		if (!out->esync_n_period)
+			return -EINVAL;
 	}
 
 	/* For 50/50 duty cycle the divisor is equal to width */
-	out.esync_n_width = out.esync_n_period;
+	out->esync_n_width = out->esync_n_period;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling = NULL;
+	struct zl3073x_out out;
+	u8 out_id;
+	int rc;
+
+	mutex_lock(&zldpll->lock);
+
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = *zl3073x_out_state_get(zldev, out_id);
+
+	rc = zl3073x_dpll_output_pin_freq_set(pin, &out, frequency);
+	if (rc)
+		goto unlock;
 
 	/* Commit output configuration */
 	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		goto unlock;
+
+	/* For non N-divided formats the divisor is shared, so the other
+	 * pin's frequency changed too and has to be notified.
+	 */
+	if (!zl3073x_out_is_ndiv(&out))
+		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+
 unlock:
 	mutex_unlock(&zldpll->lock);
 
-- 
2.55.0

