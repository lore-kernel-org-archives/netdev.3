Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C483E835F
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699155; cv=none; b=kPrMSKAmWpz86vgWX5Tqac36yXEp/PtflbXxOxaWWbxuKgxW1zEaKGMV6YhAePtOw5vg4t8r6mGdymJIt/8BYaWXgH1hSAmg7fYoK6iIL8IMguCf8hsIIIKcqHF1Gxw8pmuzFIdbyMfagAA6dhVrfRLxPpfT3J8liUNA9L38D9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699155; c=relaxed/simple;
	bh=o3QQPZMc5vfusBmpin2Gda088oy8/Se9QlgYBLNjYTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMEyNuCrSvH6kPSFqdHP3j0Z/gyyjTOW6s0762M5nbCmsN4YyJyJBZhmXQ7uB9uoGSOUuk7es+pIPwr+TUXttaVYm77OenJnrtyyy51KtokoQmfVxdxxHFKo4MP3lptGYYb0b+u5j/+n2aRj2zen617JQT0hzZiI7qMSruM7tsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNHBTRie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHBTRie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791699151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7aIrBcB/YEGGY0KeXJjfzZZsSgj3SSyLMKEbtd+otw=;
	b=LNHBTRiepgK8WnkxCforxhTu092anTa1W09yldgioc1ebgHgwOgGEvBRdgf9sOEW2BrWvB
	caJazIRIlLkIgmT8ALVU3qixS91mZkbED1m64PxFd9DSdNTqk4I0dZf1+9OWXCRful1Y50
	YEGccYHklVLDYHtFAtFfEb1huWczh4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-_SNA63s0PMeUZBca0At6-Q-1; Sun,
 11 Oct 2026 06:12:29 +0000
X-MC-Unique: _SNA63s0PMeUZBca0At6-Q-1
X-Mimecast-MFC-AGG-ID: _SNA63s0PMeUZBca0At6-Q_1791699148
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2EFE18009CC;
	Sun, 11 Oct 2026 06:12:27 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3504A1956095;
	Sun, 11 Oct 2026 06:12:25 +0000 (UTC)
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
Subject: [PATCH net v5 4/5] dpll: zl3073x: make embedded sync follow the output carrier frequency
Date: Sun, 11 Oct 2026 08:12:10 +0200
Message-ID: <20261011061211.448373-5-ivecera@redhat.com>
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

The eSync period and width are relative to the output carrier, but
changing the output frequency did not update them, so eSync ran at
a wrong frequency and duty cycle. For a 1 Hz carrier esync_get()
returns -EOPNOTSUPP, so eSync left enabled could not be disabled.

Factor out zl3073x_out_esync_{is_enabled,enable,disable}() helpers
and use them in frequency_set() to recompute the eSync period and
width for the new carrier, or to disable eSync for a 1 Hz carrier.

Also compute the reported pulse width in 64 bits, as
50 * esync_n_width overflows u32 for low carrier frequencies.

Hit during development, confirmed on an oscilloscope.

Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 46 +++++++++++++++++++------------------
 drivers/dpll/zl3073x/out.h  | 36 +++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 7a617d9bd671..6d9a6d21d30b 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -878,7 +878,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+	if (!zl3073x_out_esync_is_enabled(out)) {
 		/* No need to read esync data if it is not enabled */
 		esync->freq = 0;
 		esync->pulse = 0;
@@ -894,7 +894,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	 * Note that half pulse width is in units of half synth cycles, which
 	 * is why it reduces down to be output_div.
 	 */
-	esync->pulse = (50 * out->esync_n_width) / out->div;
+	esync->pulse = div_u64(mul_u32_u32(50, out->esync_n_width), out->div);
 
 	return 0;
 }
@@ -926,32 +926,17 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
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
@@ -1010,6 +995,23 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		/* For 50/50 duty cycle the divisor is equal to width */
 		out.width = new_div;
 
+		/* The embedded sync period and width are computed relative to
+		 * the output carrier so they have to be adjusted to follow the
+		 * new frequency.
+		 */
+		if (zl3073x_out_esync_is_enabled(&out)) {
+			if (frequency == 1) {
+				/* eSync cannot work on a 1 Hz carrier */
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
2.56.0

