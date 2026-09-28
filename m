Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73633CF047
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621776; cv=none; b=kGrkxRtWFLYMChLOci57K9KJJVLO+5JIMCGe1eTBfgRSns86j8cFSr2MSTP9XkMpRTXMCZUJKrno0vEwWTeApQjgsQee04d7s5KJ4fZ/CWrsOkcGhqLPzl3cvvkKpT+U9XmXkNm5NiNX+8kdyaSww/6jGpjTMgRy/EDi1RKgd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621776; c=relaxed/simple;
	bh=Qccovs/JHjrUj6X9D29StdqBwrSVhy67J3vVJ8cmPiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbkZH8qjlJ1ixjY4v15TU/6g//xLdPoOMrfaJtBu75Q37Hws3+kWyVeWro6KAD+A1GRRTWLFSIHWMvzJY0/cvSyTXYtkxj37vmAH21eGeZwflDwcBArOf/apjGGccJcsC64elOOXN8YqFueeM0Huk/tZNL16BKe6sXZ+VLBaT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMF7k8pr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMF7k8pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8fRBGN11Op90SISfTOzdOXSqUeOmYIX7dW62wstKoY=;
	b=JMF7k8prQd3tl+zYUyFN/e1b7vXdBMp0NsjnP2vub6vKGtLz9xhaITxO5MZIic7a1IG5ff
	oA2JD8ZBSSd//a0QuJBqeYzTzlC1gzkX74KeltN7/6iFTndvCDklb7Gf+1r6v+AoWrlsEK
	FFTGSaoWBDWAM+x9cT6CQ2k+N80Ddb4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-cSwZiwskMguvIO6w0co96Q-1; Mon,
 28 Sep 2026 14:56:06 -0400
X-MC-Unique: cSwZiwskMguvIO6w0co96Q-1
X-Mimecast-MFC-AGG-ID: cSwZiwskMguvIO6w0co96Q_1790621764
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB7B18A2CCB;
	Mon, 28 Sep 2026 18:56:04 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70C2A1956041;
	Mon, 28 Sep 2026 18:56:01 +0000 (UTC)
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
Subject: [PATCH net-next 2/6] dpll: zl3073x: add GPO support for output pins
Date: Mon, 28 Sep 2026 20:55:48 +0200
Message-ID: <20260928185552.1103515-3-ivecera@redhat.com>
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

Add the GPO override registers for CMOS output pins: the per-output
output_gpo_en and output_gpo_config_out_p/out_n mailbox fields and the
direct gpo_out_x bitmask registers selecting the static value of an
overridden pin. zl3073x_dev_gpo_set() sets that value for a given GPO
channel and zl3073x_out_pin_func_get()/_set() report and configure the
function (clock or GPO mode) of an individual output pin.

Add the output_ctrl_x stop bits and zl3073x_out_stop()/_start() to
request a clean, edge-aligned stop or restart of an output. Move ctrl
into the cfg struct_group and let zl3073x_out_state_set() write it
directly, since it is no longer invariant and is not part of the
output mailbox.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c |  39 ++++++++++
 drivers/dpll/zl3073x/core.h |   1 +
 drivers/dpll/zl3073x/out.c  |  50 ++++++++++---
 drivers/dpll/zl3073x/out.h  | 138 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/regs.h |  20 ++++++
 5 files changed, 236 insertions(+), 12 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 230df08e27cd19..7386932df0327f 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -628,6 +628,45 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 				    ZL_POLL_PHASE_ERR_TIMEOUT_US);
 }
 
+/**
+ * zl3073x_dev_gpo_set - set the static value driven by a GPO channel
+ * @zldev: pointer to zl3073x_dev structure
+ * @gpo: GPO channel index (2 * output index for the P-pin, +1 for the
+ *	 N-pin)
+ * @value: value to drive when the channel is GPO-overridden
+ *
+ * The gpo_out_x registers are direct, multi-channel bitmask registers
+ * shared by all outputs, so the read-modify-write is serialized against
+ * concurrent updates to other channels via multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_dev_gpo_set(struct zl3073x_dev *zldev, u8 gpo, bool value)
+{
+	unsigned int reg;
+	u8 bit, val;
+	int rc;
+
+	if (gpo >= ZL3073X_NUM_OUTPUT_PINS)
+		return -EINVAL;
+
+	reg = ZL_REG_GPO_OUT(gpo / 8);
+	bit = gpo % 8;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	rc = zl3073x_read_u8(zldev, reg, &val);
+	if (rc)
+		return rc;
+
+	if (value)
+		val |= BIT(bit);
+	else
+		val &= ~BIT(bit);
+
+	return zl3073x_write_u8(zldev, reg, val);
+}
+
 /**
  * zl3073x_ref_freq_meas_latch - latch reference frequency measurements
  * @zldev: pointer to zl3073x_dev structure
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 67c10e2595118c..e7064f2958fa5f 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -167,6 +167,7 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
  *****************/
 
 int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
+int zl3073x_dev_gpo_set(struct zl3073x_dev *zldev, u8 gpo, bool value);
 
 /**
  * zl3073x_dev_is_ref_phase_comp_32bit - check ref phase comp register size
diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
index 410d15b96d0bf0..82564045890db0 100644
--- a/drivers/dpll/zl3073x/out.c
+++ b/drivers/dpll/zl3073x/out.c
@@ -85,8 +85,22 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	return zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
-				&out->phase_comp);
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+			      &out->phase_comp);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_GPO_EN, &out->gpo_en);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_GPO_CONFIG_OUT_P,
+			     &out->gpo_config_p);
+	if (rc)
+		return rc;
+
+	return zl3073x_read_u8(zldev, ZL_REG_OUTPUT_GPO_CONFIG_OUT_N,
+			       &out->gpo_config_n);
 }
 
 /**
@@ -108,11 +122,12 @@ const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
  * @index: output index to set state for
  * @out: desired output state
  *
- * Validates that invariant fields have not been modified, skips the HW
- * write if the mutable configuration is unchanged, and otherwise writes
- * only the changed cfg fields to hardware via the mailbox interface.
+ * Skips the HW write if the configuration is unchanged, writes ctrl
+ * directly to the output_ctrl_x register if it differs (it is not part
+ * of the output mailbox), and otherwise writes only the changed cfg
+ * fields to hardware via the mailbox interface.
  *
- * Return: 0 on success, -EINVAL if invariants changed, <0 on HW error
+ * Return: 0 on success, <0 on HW error
  */
 int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 			  const struct zl3073x_out *out)
@@ -120,11 +135,17 @@ int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 	struct zl3073x_out *dout = &zldev->out[index];
 	int rc;
 
-	/* Reject attempts to change invariant fields (set at fetch only) */
-	if (WARN_ON(memcmp(&dout->inv, &out->inv, sizeof(out->inv))))
-		return -EINVAL;
+	/* ctrl is a direct register, independent of the output mailbox */
+	if (dout->ctrl != out->ctrl) {
+		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_CTRL(index),
+				      out->ctrl);
+		if (rc)
+			return rc;
+
+		dout->ctrl = out->ctrl;
+	}
 
-	/* Skip HW write if configuration hasn't changed */
+	/* Skip the mailbox commit if nothing else has changed */
 	if (!memcmp(&dout->cfg, &out->cfg, sizeof(out->cfg)))
 		return 0;
 
@@ -152,6 +173,15 @@ int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 	if (!rc && dout->phase_comp != out->phase_comp)
 		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
 				       out->phase_comp);
+	if (!rc && dout->gpo_en != out->gpo_en)
+		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_GPO_EN,
+				      out->gpo_en);
+	if (!rc && dout->gpo_config_p != out->gpo_config_p)
+		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_GPO_CONFIG_OUT_P,
+				      out->gpo_config_p);
+	if (!rc && dout->gpo_config_n != out->gpo_config_n)
+		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_GPO_CONFIG_OUT_N,
+				      out->gpo_config_n);
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index 660889c57bffab..66a8432c00dfd0 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -19,6 +19,9 @@ struct zl3073x_dev;
  * @esync_n_width: embedded sync or n-pin pulse width
  * @phase_comp: phase compensation
  * @mode: output mode
+ * @gpo_en: GPO override enable for the P-pin and N-pin
+ * @gpo_config_p: GPO mode configuration for the P-pin
+ * @gpo_config_n: GPO mode configuration for the N-pin
  * @ctrl: output control
  */
 struct zl3073x_out {
@@ -29,8 +32,9 @@ struct zl3073x_out {
 		u32	esync_n_width;
 		s32	phase_comp;
 		u8	mode;
-	);
-	struct_group(inv, /* Invariants */
+		u8	gpo_en;
+		u8	gpo_config_p;
+		u8	gpo_config_n;
 		u8	ctrl;
 	);
 };
@@ -106,6 +110,136 @@ static inline bool zl3073x_out_is_enabled(const struct zl3073x_out *out)
 	return !!FIELD_GET(ZL_OUTPUT_CTRL_EN, out->ctrl);
 }
 
+/**
+ * zl3073x_out_is_stopped - check if the given output is stopped
+ * @out: pointer to out state
+ *
+ * Return: true if output clock is stopped, false if it is running
+ */
+static inline bool zl3073x_out_is_stopped(const struct zl3073x_out *out)
+{
+	return !!FIELD_GET(ZL_OUTPUT_CTRL_STOP, out->ctrl);
+}
+
+/**
+ * zl3073x_out_stop - request a clean stop of an output
+ * @out: pointer to out state to update
+ *
+ * Sets the stop and stop_hz bits together, so the output goes high-Z
+ * rather than holding a fixed level once stopped. The stop is
+ * edge-aligned (the device waits for the proper edge before actually
+ * stopping).
+ */
+static inline void zl3073x_out_stop(struct zl3073x_out *out)
+{
+	FIELD_MODIFY(ZL_OUTPUT_CTRL_STOP, &out->ctrl, 1);
+	FIELD_MODIFY(ZL_OUTPUT_CTRL_STOP_HZ, &out->ctrl, 1);
+}
+
+/**
+ * zl3073x_out_start - request a clean restart of a stopped output
+ * @out: pointer to out state to update
+ *
+ * Clears the stop and stop_hz bits together. See zl3073x_out_stop().
+ */
+static inline void zl3073x_out_start(struct zl3073x_out *out)
+{
+	FIELD_MODIFY(ZL_OUTPUT_CTRL_STOP, &out->ctrl, 0);
+	FIELD_MODIFY(ZL_OUTPUT_CTRL_STOP_HZ, &out->ctrl, 0);
+}
+
+#define ZL3073X_OUT_PIN_F_CLOCK		0
+#define ZL3073X_OUT_PIN_F_GPO_CONST	1
+#define ZL3073X_OUT_PIN_F_GPO_STATUS	2
+#define ZL3073X_OUT_PIN_F_GPO_IRQ	3
+#define ZL3073X_OUT_PIN_F_GPO_UNKNOWN	4
+
+/**
+ * zl3073x_out_pin_func_get - get the function of an output pin
+ * @out: pointer to out state
+ * @id: output pin ID (even for P pin, odd for N pin)
+ *
+ * Report the current function of the given output pin. If GPO override is
+ * disabled the pin acts as a clock, otherwise it acts as a GPO with the
+ * mode selected by its GPO config control field.
+ *
+ * Return: one of the ZL3073X_OUT_PIN_F_* function codes
+ */
+static inline u8
+zl3073x_out_pin_func_get(const struct zl3073x_out *out, u8 id)
+{
+	u8 gpo_config;
+	bool gpo_en;
+
+	if (id & 1) {
+		gpo_en = FIELD_GET(ZL_OUTPUT_GPO_EN_OUT_N, out->gpo_en);
+		gpo_config = out->gpo_config_n;
+	} else {
+		gpo_en = FIELD_GET(ZL_OUTPUT_GPO_EN_OUT_P, out->gpo_en);
+		gpo_config = out->gpo_config_p;
+	}
+
+	if (!gpo_en)
+		return ZL3073X_OUT_PIN_F_CLOCK;
+
+	switch (FIELD_GET(ZL_OUTPUT_GPO_CONFIG_CTRL, gpo_config)) {
+	case ZL_OUTPUT_GPO_CONFIG_CTRL_OUTPUT:
+		return ZL3073X_OUT_PIN_F_GPO_CONST;
+	case ZL_OUTPUT_GPO_CONFIG_CTRL_STATUS:
+		return ZL3073X_OUT_PIN_F_GPO_STATUS;
+	case ZL_OUTPUT_GPO_CONFIG_CTRL_IRQ:
+		return ZL3073X_OUT_PIN_F_GPO_IRQ;
+	}
+
+	return ZL3073X_OUT_PIN_F_GPO_UNKNOWN;
+}
+
+/**
+ * zl3073x_out_pin_func_set - set the function of an output pin
+ * @out: pointer to out state to update
+ * @id: output pin ID (even for P pin, odd for N pin)
+ * @func: requested function, one of the ZL3073X_OUT_PIN_F_* codes
+ *
+ * Configure the given output pin as a clock or as a GPO in the requested
+ * mode by updating its GPO enable and GPO config control fields. Unknown
+ * function codes are ignored.
+ */
+static inline void
+zl3073x_out_pin_func_set(struct zl3073x_out *out, u8 id, u8 func)
+{
+	bool gpo_en = true;
+	u8 *gpo_config;
+	int ctrl = -1;
+
+	switch (func) {
+	case ZL3073X_OUT_PIN_F_CLOCK:
+		gpo_en = false;
+		break;
+	case ZL3073X_OUT_PIN_F_GPO_CONST:
+		ctrl = ZL_OUTPUT_GPO_CONFIG_CTRL_OUTPUT;
+		break;
+	case ZL3073X_OUT_PIN_F_GPO_STATUS:
+		ctrl = ZL_OUTPUT_GPO_CONFIG_CTRL_STATUS;
+		break;
+	case ZL3073X_OUT_PIN_F_GPO_IRQ:
+		ctrl = ZL_OUTPUT_GPO_CONFIG_CTRL_IRQ;
+		break;
+	default:
+		return;
+	}
+
+	if (id & 1) {
+		FIELD_MODIFY(ZL_OUTPUT_GPO_EN_OUT_N, &out->gpo_en, gpo_en);
+		gpo_config = &out->gpo_config_n;
+	} else {
+		FIELD_MODIFY(ZL_OUTPUT_GPO_EN_OUT_P, &out->gpo_en, gpo_en);
+		gpo_config = &out->gpo_config_p;
+	}
+
+	if (ctrl != -1)
+		FIELD_MODIFY(ZL_OUTPUT_GPO_CONFIG_CTRL, gpo_config, ctrl);
+}
+
 /**
  * zl3073x_out_is_ndiv - check if the given output is in N-div mode
  * @out: pointer to out state
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index f3a5e1215aa36b..f17a2c78611827 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -94,6 +94,13 @@
 
 #define ZL_REG_DIE_TEMP_STATUS			ZL_REG(0, 0x44, 2)
 
+/*************************
+ * Register Page 1, GPIOs
+ *************************/
+
+#define ZL_REG_GPO_OUT(_idx)						\
+	ZL_REG_IDX(_idx, 1, 0x70, 1, 3, 1)
+
 /*************************
  * Register Page 2, Status
  *************************/
@@ -254,6 +261,8 @@
 #define ZL_REG_OUTPUT_CTRL(_idx)					\
 	ZL_REG_IDX(_idx, 9, 0x28, 1, ZL3073X_NUM_OUTS, 1)
 #define ZL_OUTPUT_CTRL_EN			BIT(0)
+#define ZL_OUTPUT_CTRL_STOP			BIT(1)
+#define ZL_OUTPUT_CTRL_STOP_HZ			BIT(3)
 #define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
 
 #define ZL_REG_OUTPUT_STEP_TIME_MASK		ZL_REG(9, 0x36, 2)
@@ -368,6 +377,17 @@
 #define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
 #define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
 
+#define ZL_REG_OUTPUT_GPO_EN			ZL_REG(14, 0x24, 1)
+#define ZL_OUTPUT_GPO_EN_OUT_P			BIT(0)
+#define ZL_OUTPUT_GPO_EN_OUT_N			BIT(1)
+
+#define ZL_REG_OUTPUT_GPO_CONFIG_OUT_P		ZL_REG(14, 0x27, 1)
+#define ZL_REG_OUTPUT_GPO_CONFIG_OUT_N		ZL_REG(14, 0x2a, 1)
+#define ZL_OUTPUT_GPO_CONFIG_CTRL		GENMASK(2, 0)
+#define ZL_OUTPUT_GPO_CONFIG_CTRL_OUTPUT	1
+#define ZL_OUTPUT_GPO_CONFIG_CTRL_STATUS	3
+#define ZL_OUTPUT_GPO_CONFIG_CTRL_IRQ		4
+
 /*
  * Register Page 255 - HW registers access
  */
-- 
2.55.0

