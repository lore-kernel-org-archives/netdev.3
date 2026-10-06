Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214249E5CF
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300698; cv=none; b=VhIxxVbvY96PUGv2qG4katkKSBr3Y7RJS7fQv2wN0usLK6TDJ1nOE+mZo6qlSB7pCi4+oBqEiyMZOU3lI+7FIZV3B5KSLUCr/3XQUONEa9gSSSTdgNIBpEQv3uzz8YD0c/DsKLJRDqKrUsu8jaR6DuiZIZJUvYiWtcE1DSPyZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300698; c=relaxed/simple;
	bh=GuVMyYzSS31plY741TdF9roVEzB7jM4lIOG4sm26PZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiM0s+1wBW9gYFIqEGz4G9YieAa66Z7LADV/cWz1IS5cA5xoP4G+nko+rWoU2WHPpFBrc32ahRYJaTNA9ov8rvMYq03iA5znkJiVk9JWEMBbGArnlpDoNenswqb680wFRm8gDVPuv62bj5rzBTIl5n69cEIDPQc66gHdvYlYe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ypuk8zes; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ypuk8zes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791300695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVUn+HsNOvqZBezeEvZyPntwEGsa2uwRtmcfe3A7S70=;
	b=Ypuk8zespUMnwDxm/5Ruj/i+MXTPBfzAChdvX8QW3cfltXcHRIaGIa78aX8QabeZQ8UXG+
	T5ALPh+OOaHlAS1Q5+4GoicOn0NrM2GzPGkglohkwr+MwtytEYO2nyuWN2iEZzshyjCrM/
	N8k8znMcDOyun1q4DAKaMh4iLfuNtZ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-eT_6kHSjOJW1gGOhi1SLqA-1; Tue,
 06 Oct 2026 11:31:28 -0400
X-MC-Unique: eT_6kHSjOJW1gGOhi1SLqA-1
X-Mimecast-MFC-AGG-ID: eT_6kHSjOJW1gGOhi1SLqA_1791300687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6C76195E93A;
	Tue,  6 Oct 2026 15:31:26 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AABA180059A;
	Tue,  6 Oct 2026 15:31:24 +0000 (UTC)
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
Subject: [PATCH net v3 2/4] dpll: zl3073x: make embedded sync follow the output carrier frequency
Date: Tue,  6 Oct 2026 17:31:14 +0200
Message-ID: <20261006153116.347497-3-ivecera@redhat.com>
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

Changing an output pin's frequency did not update its embedded sync
(eSync) configuration. The eSync period and width are computed relative
to the carrier:

    esync_n_period = out_freq / esync_freq
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

As a side effect of reusing the helpers, esync_get() now reports the
driver's eSync model - a 1 Hz frequency and a 25% pulse - from the clock
type when eSync is enabled, instead of deriving the values from the
cached esync_n_period/esync_n_width registers. The driver only ever
programs a 1 Hz / 25% eSync, so this matches what esync_set() configures
and keeps get and set symmetric. A configuration the driver did not
establish - a non-1 Hz eSync left in flash or by an older kernel, or the
truncated duty cycle of an odd divider - is therefore reported as the
nominal 1 Hz / 25% rather than its exact register values.

N-divided outputs are left untouched: there esync_n_period is the N
divider and eSync is not supported anyway.

Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 68 ++++++++++++++++---------------------
 drivers/dpll/zl3073x/out.h  | 36 ++++++++++++++++++++
 2 files changed, 66 insertions(+), 38 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index f2e137475b40..7c997966c3c3 100644
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
@@ -1009,6 +984,23 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
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
+				zl3073x_out_esync_enable(&out,
+							 synth_freq / out.div);
+			}
+		}
+
 		/* Commit output configuration */
 		return zl3073x_out_state_set(zldev, out_id, &out);
 	}
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index 660889c57bff..d2b8b4eb5a76 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -134,4 +134,40 @@ static inline u8 zl3073x_out_synth_get(const struct zl3073x_out *out)
 	return FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, out->ctrl);
 }
 
+static inline bool zl3073x_out_esync_is_enabled(const struct zl3073x_out *out)
+{
+	u8 clock_type = zl3073x_out_clock_type_get(out);
+
+	return clock_type == ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
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

