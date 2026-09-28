Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B03CCA13
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621772; cv=none; b=c1n+Wdui10KMUMX/29l4EXNbPOU7kjNJLACk91LXeOqFXsn1hM38Cf+vbKa4JNiHldzbIsHOPUOUf3agv5G8WR2VFeHhoDtLfbAh9DXCAKRjOCPvnqElVeV3vPg4qm7v/s6GZhZS21UMCrjBQDWHtMN/xgLjXNGvaVXOfRht1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621772; c=relaxed/simple;
	bh=MdvJSwaa4tcjZxPUZYdGdfsPpJ8nZuCm5+lNZj9NjSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwcJPiJbcapk3DWpC5GFwTlWG9HPRvQHv1h93lPnSUo70scRWJ9lozFg0tUQa78nvZbIGrDEbkRWF9VdgLby4a94xcBHHvFst4SvpzMVKFsrmEtuPmSx9cXR7MIRIgR7Q7ccMwdV1WPmmv3OD060rN213IJWxF7Z1EM6eWKZXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qosy9/6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qosy9/6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MG4u4MwhTBTqy31IrG0PZeNdsRDRG8l6xT4Z7DIu+1Y=;
	b=Qosy9/6ybZsjhctadNI+DJguIpQbtDYQgOvSSmLK7W/NYDGZjxcZrrJZKKgd+7Y06dqQaF
	WdAiUc82QeCMnRokjzkZw5eQuhNS+4fWm3iYo6V4mtc1rCnQvqtmYZAhqZm74At4ZUqU7z
	YRKiQ7HhyinfUeGjyTsNgqS4WXUU3YA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-fRQeKoF2MJiLzY_AbkvQ3g-1; Mon,
 28 Sep 2026 14:56:02 -0400
X-MC-Unique: fRQeKoF2MJiLzY_AbkvQ3g-1
X-Mimecast-MFC-AGG-ID: fRQeKoF2MJiLzY_AbkvQ3g_1790621761
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10CFE195FCF3;
	Mon, 28 Sep 2026 18:56:01 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 708F91956049;
	Mon, 28 Sep 2026 18:55:57 +0000 (UTC)
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
Subject: [PATCH net-next 1/6] dpll: zl3073x: notify sibling pin when shared output config changes
Date: Mon, 28 Sep 2026 20:55:47 +0200
Message-ID: <20260928185552.1103515-2-ivecera@redhat.com>
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

Each zl3073x output has a P-pin and an N-pin that share a single HW
output and, outside N-pin divide mode, share the output's divisor,
clock type, esync period/width and phase compensation registers.
Changing one of these settings through one pin's dpll_pin therefore
also changes the other (sibling) pin's effective configuration, but
only the pin the change was requested on gets a dpll_pin_change_ntf()
notification - userspace listening on the sibling pin is never told
its frequency, esync configuration or phase adjustment changed.

Add zl3073x_dpll_output_pin_sibling_get() to look up the other pin of
an output pair, and use it in frequency_set() (for the non-N-divided
signal formats, where the output divisor is shared), esync_set() and
phase_adjust_set() to notify the sibling pin, if it is registered,
whenever the shared HW state actually changes.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 144 ++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 29 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index f2e137475b40ff..2c6de4dab8b4ad 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -132,6 +132,30 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
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
@@ -910,11 +934,13 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
+	struct zl3073x_dpll_pin *sibling;
 	struct zl3073x_out out;
 	u32 synth_freq;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -923,8 +949,10 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	if (zl3073x_out_is_ndiv(&out))
-		return -EOPNOTSUPP;
+	if (zl3073x_out_is_ndiv(&out)) {
+		rc = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	/* Update clock type in output mode */
 	if (freq)
@@ -934,27 +962,44 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 		zl3073x_out_clock_type_set(&out,
 					   ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);
 
-	/* If esync is being disabled just write mailbox and finish */
-	if (!freq)
-		return zl3073x_out_state_set(zldev, out_id, &out);
+	if (freq) {
+		/* Get attached synth frequency */
+		synth = zl3073x_synth_state_get(zldev,
+						zl3073x_out_synth_get(&out));
+		synth_freq = zl3073x_synth_freq_get(synth);
 
-	/* Get attached synth frequency */
-	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
-	synth_freq = zl3073x_synth_freq_get(synth);
+		/* Compute and update esync period */
+		out.esync_n_period = synth_freq / (u32)freq / out.div;
 
-	/* Compute and update esync period */
-	out.esync_n_period = synth_freq / (u32)freq / out.div;
+		/* Half of the period in units of 1/2 synth cycle can be
+		 * represented by the output_div. To get the supported esync
+		 * pulse width of 25% of the period the output_div can just
+		 * be divided by 2. Note that this assumes that output_div
+		 * is even, otherwise some resolution will be lost.
+		 */
+		out.esync_n_width = out.div / 2;
+	}
 
-	/* Half of the period in units of 1/2 synth cycle can be represented by
-	 * the output_div. To get the supported esync pulse width of 25% of the
-	 * period the output_div can just be divided by 2. Note that this
-	 * assumes that output_div is even, otherwise some resolution will be
-	 * lost.
+	/* Commit output configuration */
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		goto unlock;
+
+	/* The clock type, esync period and esync width are all shared by
+	 * both pins of the output pair, so the sibling pin's esync
+	 * configuration changes too and userspace has to be notified.
 	 */
-	out.esync_n_width = out.div / 2;
+	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
 
-	/* Commit output configuration */
-	return zl3073x_out_state_set(zldev, out_id, &out);
+	mutex_unlock(&zldpll->lock);
+
+	if (sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return 0;
+unlock:
+	mutex_unlock(&zldpll->lock);
+	return rc;
 }
 
 static int
@@ -984,12 +1029,14 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
@@ -1002,7 +1049,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	/* Check signal format */
 	if (!zl3073x_out_is_ndiv(&out)) {
 		/* For non N-divided signal formats the frequency is computed
-		 * as division of synth frequency and output divisor.
+		 * as division of synth frequency and output divisor, which
+		 * is shared by both pins of the output pair.
 		 */
 		out.div = new_div;
 
@@ -1010,7 +1058,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		out.width = new_div;
 
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
@@ -1022,8 +1079,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
@@ -1039,15 +1098,24 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
+	if (sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return rc;
 }
 
 static int
@@ -1086,10 +1154,12 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *sibling;
 	struct zl3073x_out out;
 	u8 out_id;
+	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -1098,7 +1168,23 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	out.phase_comp = phase_adjust / pin->phase_gran;
 
 	/* Update output configuration from mailbox */
-	return zl3073x_out_state_set(zldev, out_id, &out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc) {
+		mutex_unlock(&zldpll->lock);
+		return rc;
+	}
+
+	/* The phase compensation register is shared by both pins of the
+	 * output pair, so the sibling pin's phase adjustment changes too.
+	 */
+	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+
+	mutex_unlock(&zldpll->lock);
+
+	if (sibling)
+		__dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return 0;
 }
 
 static int
-- 
2.55.0

