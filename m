Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E32367D3
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927139; cv=none; b=AIQFtKxzFeSJ7v3kuA+4L3YvZfefHeZPcj5WEeHEC3tPkNWno022hBrK/AQynN6TiWS2/OJ2hC2wJYCwW+tI21RTASTsXF+UrV+440imjnnXXFq7cYKtPutZkNML4gL1dNnsOzksBbs761DIomBIupOXmEyRXyjx/f2I5ZdMea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927139; c=relaxed/simple;
	bh=y6ZRC6TNQ2pvWv8P82uyfiJvqwBACXRiC3B7pjYqaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2peYtG8QPV6AwmToybl8L8pMK6P8TEKl+ekpLxyb5vrQZjhBQqRd+TZz/SERRfWteuFwIJa+qn6P23TjzdSfWNqsOfCp6+inV8ZUm0D9M2Z7KOIISVs0rI+iq8CJ0SMaJSjBU2otbe0BK82OnpMcOqVX85T4e7mEFb++NeTjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOoEoOpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOoEoOpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790927136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh+fs8sTnPxCnGGVhazmz75z/MsU/EhsBcBKSpyne9U=;
	b=ZOoEoOpVgGgkf/ClYilHIcfbku7mH8+JBySoJsYrBhdTm0jX9wmdbES/4+wzLG/wCJ8IRy
	blIgmliyxeUXhcOduq+BRDTDNQ8OoTxc74E/fnCf9ch2S1RuzeTivB3bY8kE15jSz/VNCh
	SKlN4/vFBNBUSx4d4SIudFM36AsHSI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-YKy6qW8BPp-BIPZE22QeMg-1; Fri,
 02 Oct 2026 03:45:29 -0400
X-MC-Unique: YKy6qW8BPp-BIPZE22QeMg-1
X-Mimecast-MFC-AGG-ID: YKy6qW8BPp-BIPZE22QeMg_1790927128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EB82195604F;
	Fri,  2 Oct 2026 07:45:28 +0000 (UTC)
Received: from p16v.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76B7E180035F;
	Fri,  2 Oct 2026 07:45:25 +0000 (UTC)
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
Subject: [PATCH net v2 1/2] dpll: zl3073x: make embedded sync follow the output carrier frequency
Date: Fri,  2 Oct 2026 09:45:19 +0200
Message-ID: <20261002074520.30048-2-ivecera@redhat.com>
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

Changing an output pin's frequency did not update its embedded sync
(eSync) configuration. The eSync period and width are computed relative
to the carrier:

    esync_n_period = out_freq / esync_freq = (synth_freq / div) / esync_freq
    esync_n_width  = div / 2

Once zl3073x_dpll_output_pin_frequency_set() changes div, both values no
longer match the new carrier, so the embedded sync runs at the wrong
frequency and duty cycle. Worse, if the new carrier is <= 1 Hz then
esync_get() returns -EOPNOTSUPP (out_freq <= 1), hiding the stale ESYNC
mode so the user can no longer turn it off - it is stuck on.

This was hit during development: after changing an output pin's
frequency the embedded sync output stopped working correctly, as
confirmed on an oscilloscope - it ran at the wrong frequency and duty
cycle because the eSync period and width still matched the old carrier.
For a new 1 Hz carrier esync_get() returned -EOPNOTSUPP, leaving eSync
enabled with no way to disable it.

Factor the eSync handling into zl3073x_out_esync_{is_enabled,enable,
disable}() helpers and reuse them from esync_get()/esync_set(), then
adjust the eSync parameters in the output frequency change path for
non-N-divided outputs after updating div/width:

- If the new frequency is 1 Hz, disable eSync. It cannot work at a 1 Hz
  carrier and esync_get() hides it, so it must be cleared rather than
  left stuck on.
- Otherwise, if eSync is active, recompute its period and width for the
  new carrier keeping the 1 Hz eSync frequency.

N-divided outputs are left untouched: there esync_n_period is the N
divider and eSync is not supported anyway.

Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 67 ++++++++++++++++---------------------
 drivers/dpll/zl3073x/out.h  | 34 +++++++++++++++++++
 2 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index f2e137475b40..19456fbeeea8 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -852,7 +852,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	const struct zl3073x_out *out;
-	u32 synth_freq, out_freq;
+	u32 synth_freq;
 	u8 out_id;
 
 	guard(mutex)(&zldpll->lock);
@@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	if (zl3073x_out_is_ndiv(out))
+	if (zl3073x_out_is_ndiv(out) || !pin->esync_control)
 		return -EOPNOTSUPP;
 
 	/* Get attached synth frequency */
 	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
 	synth_freq = zl3073x_synth_freq_get(synth);
-	out_freq = synth_freq / out->div;
 
-	if (!pin->esync_control || out_freq <= 1)
+	/* The esync is not supported for 1 Hz base frequency */
+	if (synth_freq / out->div <= 1)
 		return -EOPNOTSUPP;
 
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
-		/* No need to read esync data if it is not enabled */
+	if (zl3073x_out_esync_is_enabled(out)) {
+		esync->freq = 1;
+		esync->pulse = 25;
+	} else {
 		esync->freq = 0;
 		esync->pulse = 0;
-
-		return 0;
 	}
 
-	/* Compute esync frequency */
-	esync->freq = out_freq / out->esync_n_period;
-
-	/* By comparing the esync_pulse_width to the half of the pulse width
-	 * the esync pulse percentage can be determined.
-	 * Note that half pulse width is in units of half synth cycles, which
-	 * is why it reduces down to be output_div.
-	 */
-	esync->pulse = (50 * out->esync_n_width) / out->div;
-
 	return 0;
 }
 
@@ -926,32 +916,17 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	if (zl3073x_out_is_ndiv(&out))
 		return -EOPNOTSUPP;
 
-	/* Update clock type in output mode */
-	if (freq)
-		zl3073x_out_clock_type_set(&out,
-					   ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC);
-	else
-		zl3073x_out_clock_type_set(&out,
-					   ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);
-
-	/* If esync is being disabled just write mailbox and finish */
-	if (!freq)
+	if (!freq) {
+		zl3073x_out_esync_disable(&out);
 		return zl3073x_out_state_set(zldev, out_id, &out);
+	}
 
 	/* Get attached synth frequency */
 	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
 	synth_freq = zl3073x_synth_freq_get(synth);
 
-	/* Compute and update esync period */
-	out.esync_n_period = synth_freq / (u32)freq / out.div;
-
-	/* Half of the period in units of 1/2 synth cycle can be represented by
-	 * the output_div. To get the supported esync pulse width of 25% of the
-	 * period the output_div can just be divided by 2. Note that this
-	 * assumes that output_div is even, otherwise some resolution will be
-	 * lost.
-	 */
-	out.esync_n_width = out.div / 2;
+	/* Enable 1PPS eSync for this pin frequency */
+	zl3073x_out_esync_enable(&out, synth_freq / out.div);
 
 	/* Commit output configuration */
 	return zl3073x_out_state_set(zldev, out_id, &out);
@@ -1009,6 +984,22 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		/* For 50/50 duty cycle the divisor is equal to width */
 		out.width = new_div;
 
+		/* The embedded sync period and width are computed relative to
+		 * the output carrier so they have to be adjusted to follow the
+		 * new frequency.
+		 */
+		if (zl3073x_out_esync_is_enabled(&out)) {
+			if (frequency == 1) {
+				/* Disable eSync if the new frequency is 1 Hz */
+				zl3073x_out_esync_disable(&out);
+			} else {
+				/* Update esync period and width according to
+				 * the new frequency.
+				 */
+				zl3073x_out_esync_enable(&out, synth_freq / out.div);
+			}
+		}
+
 		/* Commit output configuration */
 		return zl3073x_out_state_set(zldev, out_id, &out);
 	}
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index 660889c57bff..a27f2dbb5738 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -134,4 +134,38 @@ static inline u8 zl3073x_out_synth_get(const struct zl3073x_out *out)
 	return FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, out->ctrl);
 }
 
+static inline bool zl3073x_out_esync_is_enabled(const struct zl3073x_out *out)
+{
+	return zl3073x_out_clock_type_get(out) == ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
+}
+
+static inline
+void zl3073x_out_esync_enable(struct zl3073x_out *out, u32 base_freq)
+{
+	/* Period is expressed as the number of output divider clock cycles.
+	 * So for 1 Hz the period is equal to base frequency.
+	 */
+	out->esync_n_period = base_freq;
+
+	/* Half of the period in units of 1/2 synth cycle can be represented by
+	 * the output_div. To get the supported esync pulse width of 25% of the
+	 * period the output_div can just be divided by 2. Note that this
+	 * assumes that output_div is even, otherwise some resolution will be
+	 * lost.
+	 */
+	out->esync_n_width = out->div / 2;
+
+	/* Update the clock type */
+	zl3073x_out_clock_type_set(out, ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC);
+}
+
+static inline
+void zl3073x_out_esync_disable(struct zl3073x_out *out)
+{
+	/* Just update the clock type. The eSync period and width are
+	 * ignored for this clock type.
+	 */
+	zl3073x_out_clock_type_set(out, ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);
+}
+
 #endif /* _ZL3073X_OUT_H */
-- 
2.55.0

