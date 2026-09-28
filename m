Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BC3F105F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621788; cv=none; b=UOng1JM1lQ3gq87AV5Hw1U/qNZT6CKYoDQcEmSXU7rhKctvjzgpoeKhw8D+2L3OPKNVp3He9xG7LIav1p5zgssJwFjqnNx+jHnpTEDK0OdbF2SuxCyLEfra4xsSsMog+PDVCzI5oFMCN26pF6+0f3tTT69VgTtFDS+mN2OAaBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621788; c=relaxed/simple;
	bh=WALJ9NS2Tupgz+P/L5FBqo1g1Gc4cCZilfAfoMW1RQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNMMj5Edqq5nct58BIqH3w+x3tmcQXcT8dCIINvdi5Io3VR7vbZ6THs+mfjVvRHunp7gqAywZGM6ZoKcMtogQJkz4h9Sz+pCjBDPDNVXyBx3NfbzfA98bBVD5T394jk4dNuUG+7F1BkJxOzqyVHnjsOOt9gvuavOukUGRGZ14H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUwiYNNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUwiYNNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3ij0hhTyBz1pjyCoa1+rkJCJLu41Q31O6IeCl5S13I=;
	b=ZUwiYNNwGNv2dRBUH/baG4oEJ+7pkgEa7Xn1j/LIh3OBmxKsUQx82/2geyivZLPl4C00SF
	TIpq+ll57m8fE2m1GDHkqUq92DK1jMWxdcIlAJAa6GkaEyVaLixlzugD6kR4JFBdRD1v6S
	IfE+d6OeifEY7bCLVepBhkfIMb/mFkc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-e4x-70zYMzWpean8-piwew-1; Mon,
 28 Sep 2026 14:56:19 -0400
X-MC-Unique: e4x-70zYMzWpean8-piwew-1
X-Mimecast-MFC-AGG-ID: e4x-70zYMzWpean8-piwew_1790621778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D651944F0E;
	Mon, 28 Sep 2026 18:56:18 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E1FF1956041;
	Mon, 28 Sep 2026 18:56:15 +0000 (UTC)
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
Subject: [PATCH net-next 6/6] dpll: zl3073x: add PTP periodic output support
Date: Mon, 28 Sep 2026 20:55:52 +0200
Message-ID: <20260928185552.1103515-7-ivecera@redhat.com>
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

Register a PTP periodic output pin for each DPLL output pin that
supports step-time and declares 1 PPS (1 Hz) support in firmware.
The pins are named after the output pin (e.g. OUT5, OUT5P, OUT5N) and
any perout channel can be assigned to any of them.

Only 1 PPS is supported. Enabling a channel programs the pin assigned
to it for 1 Hz and connects it; disabling disconnects it, reusing the
output pin frequency helper and the per-pin connect/disconnect
primitive. A 1PPS bit is added to the per-pin capabilities.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 211 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.h |   4 +
 drivers/dpll/zl3073x/prop.h |  21 ++++
 3 files changed, 236 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 0a36a2acf15b9f..f406d1e72530ff 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -68,11 +68,13 @@ struct zl3073x_dpll_pin {
  */
 enum zl3073x_dpll_pin_caps {
 	ZL3073X_DPLL_PIN_CAP_ESYNC_BIT,
+	ZL3073X_DPLL_PIN_CAP_1PPS_BIT,
 	ZL3073X_DPLL_PIN_CAPS_NBITS /* must be last */
 };
 
 #define __ZL3073X_DPLL_PIN_CAP(name)	BIT(ZL3073X_DPLL_PIN_CAP_##name##_BIT)
 #define ZL3073X_DPLL_PIN_CAP_ESYNC	__ZL3073X_DPLL_PIN_CAP(ESYNC)
+#define ZL3073X_DPLL_PIN_CAP_1PPS	__ZL3073X_DPLL_PIN_CAP(1PPS)
 
 /*
  * Supported esync ranges for input and for output per output pair type
@@ -144,6 +146,19 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
 	return NULL;
 }
 
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_output_pin_get_by_id(struct zl3073x_dpll *zldpll, u8 id)
+{
+	struct zl3073x_dpll_pin *pin;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (!zl3073x_dpll_is_input_pin(pin) && pin->id == id)
+			return pin;
+	}
+
+	return NULL;
+}
+
 /**
  * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
  * @pin: output pin whose sibling is sought
@@ -1872,6 +1887,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	pin->caps = 0;
 	if (props->esync_control)
 		pin->caps |= ZL3073X_DPLL_PIN_CAP_ESYNC;
+	if (zl3073x_props_is_freq_supported(props, 1))
+		pin->caps |= ZL3073X_DPLL_PIN_CAP_1PPS;
 
 	if (zl3073x_dpll_is_input_pin(pin)) {
 		const struct zl3073x_chan *chan;
@@ -2823,6 +2840,159 @@ zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)
 	return NSEC_PER_SEC - 1;
 }
 
+/**
+ * zl3073x_dpll_pin_is_perout_capable - check output pin perout eligibility
+ * @pin: output pin to check
+ *
+ * A registered output pin can be used for periodic output if its output
+ * supports step-time and the pin declares 1 PPS (1 Hz) support in firmware.
+ *
+ * Return: true if the pin can be used for periodic output.
+ */
+static bool
+zl3073x_dpll_pin_is_perout_capable(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dev *zldev = pin->dpll->dev;
+	u8 out_id;
+
+	/* Periodic output is only available on output pins */
+	if (zl3073x_dpll_is_input_pin(pin) || zl3073x_dpll_is_nco_pin(pin))
+		return false;
+
+	out_id = zl3073x_output_pin_out_get(pin->id);
+
+	return zl3073x_dev_out_is_stepped(zldev, out_id) &&
+	       (pin->caps & ZL3073X_DPLL_PIN_CAP_1PPS);
+}
+
+/**
+ * zl3073x_dpll_perout_enable - enable 1 PPS periodic output on a pin
+ * @pin: output pin to enable periodic output on
+ * @perout: periodic output request
+ *
+ * Programs the pin for 1 PPS (1 Hz) output and connects it.
+ *
+ * Context: Caller must hold pin->dpll->lock.
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_perout_enable(struct zl3073x_dpll_pin *pin,
+			   struct ptp_perout_request *perout)
+{
+	u8 out_id = zl3073x_output_pin_out_get(pin->id);
+	struct zl3073x_dev *zldev = pin->dpll->dev;
+	struct zl3073x_out out;
+	int rc;
+
+	/* Only 1 PPS (1 Hz) periodic output is supported */
+	if (perout->period.sec != 1 || perout->period.nsec)
+		return -EINVAL;
+
+	out = *zl3073x_out_state_get(zldev, out_id);
+
+	rc = zl3073x_dpll_output_pin_freq_set(pin, &out, 1);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		return rc;
+
+	if (zl3073x_dev_output_pin_state_get(zldev, pin->id))
+		return 0;
+
+	return zl3073x_dev_output_pin_state_set(zldev, pin->id, true);
+}
+
+/**
+ * zl3073x_dpll_perout_disable - disable periodic output on a pin
+ * @pin: output pin to disable periodic output on
+ *
+ * Context: Caller must hold pin->dpll->lock.
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_perout_disable(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dev *zldev = pin->dpll->dev;
+
+	if (!zl3073x_dev_output_pin_state_get(zldev, pin->id))
+		return 0;
+
+	return zl3073x_dev_output_pin_state_set(zldev, pin->id, false);
+}
+
+static int zl3073x_dpll_ptp_verify(struct ptp_clock_info *info,
+				   unsigned int pin_idx,
+				   enum ptp_pin_function func,
+				   unsigned int chan)
+{
+	/* Any perout pin can serve any perout channel, the channel range is
+	 * validated by the PTP core. The requested pin is resolved from the
+	 * channel via ptp_find_pin() in the enable callback.
+	 */
+	switch (func) {
+	case PTP_PF_NONE:
+	case PTP_PF_PEROUT:
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int zl3073x_dpll_ptp_enable(struct ptp_clock_info *info,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dpll_pin *pin = NULL;
+	struct zl3073x_dpll_pin *sibling;
+	int n, pin_idx, rc;
+	u8 id;
+
+	if (rq->type != PTP_CLK_REQ_PEROUT)
+		return -EOPNOTSUPP;
+
+	if (rq->perout.flags)
+		return -EOPNOTSUPP;
+
+	pin_idx = ptp_find_pin(zldpll->ptp_clock, PTP_PF_PEROUT,
+			       rq->perout.index);
+	if (pin_idx < 0)
+		return -EINVAL;
+
+	n = pin_idx;
+	for_each_set_bit(id, zldpll->perout_map, ZL3073X_NUM_OUTPUT_PINS) {
+		if (!n) {
+			pin = zl3073x_dpll_output_pin_get_by_id(zldpll, id);
+			break;
+		}
+		n--;
+	}
+	if (!pin)
+		return -EINVAL;
+
+	mutex_lock(&zldpll->lock);
+	if (on)
+		rc = zl3073x_dpll_perout_enable(pin, &rq->perout);
+	else
+		rc = zl3073x_dpll_perout_disable(pin);
+	mutex_unlock(&zldpll->lock);
+
+	if (rc)
+		return rc;
+
+	/* Notify the affected output pin and, for shared-divisor formats,
+	 * its sibling sharing the same HW output.
+	 */
+	dpll_pin_change_ntf(pin->dpll_pin);
+	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
+	if (sibling)
+		dpll_pin_change_ntf(sibling->dpll_pin);
+
+	return 0;
+}
+
 static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
 	.owner		= THIS_MODULE,
 	.max_adj	= ZL3073X_DPLL_PTP_MAX_ADJ,
@@ -2832,6 +3002,8 @@ static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
 	.adjfine	= zl3073x_dpll_ptp_adjfine,
 	.adjphase	= zl3073x_dpll_ptp_adjphase,
 	.getmaxphase	= zl3073x_dpll_ptp_getmaxphase,
+	.enable		= zl3073x_dpll_ptp_enable,
+	.verify		= zl3073x_dpll_ptp_verify,
 };
 
 /**
@@ -2843,16 +3015,53 @@ static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
 static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
+	struct ptp_pin_desc *pin_config;
+	struct zl3073x_dpll_pin *pin;
 	struct ptp_clock *ptp_clock;
+	unsigned int i;
+	u8 id;
 
 	zldpll->ptp_info = zl3073x_dpll_ptp_clock_info;
 	snprintf(zldpll->ptp_info.name, sizeof(zldpll->ptp_info.name),
 		 "%s-dpll%u", dev_name(zldev->dev), zldpll->id);
 
+	/* Count output pins eligible for periodic output */
+	bitmap_zero(zldpll->perout_map, ZL3073X_NUM_OUTPUT_PINS);
+	list_for_each_entry(pin, &zldpll->pins, list)
+		if (zl3073x_dpll_pin_is_perout_capable(pin))
+			set_bit(pin->id, zldpll->perout_map);
+
+	zldpll->ptp_info.n_pins = bitmap_weight(zldpll->perout_map,
+						ZL3073X_NUM_OUTPUT_PINS);
+	zldpll->ptp_info.n_per_out = zldpll->ptp_info.n_pins;
+	if (!zldpll->ptp_info.n_pins)
+		goto no_pins;
+
+	pin_config = kzalloc_objs(*pin_config, zldpll->ptp_info.n_pins);
+	if (!pin_config)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_set_bit(id, zldpll->perout_map, ZL3073X_NUM_OUTPUT_PINS) {
+		pin = zl3073x_dpll_output_pin_get_by_id(zldpll, id);
+		strscpy(pin_config[i].name, pin->label);
+		pin_config[i].index = i;
+		if (zl3073x_dev_output_pin_state_get(zldev, id)) {
+			pin_config[i].func = PTP_PF_PEROUT;
+			pin_config[i].chan = i;
+		}
+		i++;
+	}
+
+	zldpll->ptp_info.pin_config = pin_config;
+
+no_pins:
 	ptp_clock = ptp_clock_register(&zldpll->ptp_info, zldev->dev);
 	if (IS_ERR(ptp_clock)) {
 		dev_err(zldev->dev, "Failed to register PTP clock for DPLL%u\n",
 			zldpll->id);
+		kfree(zldpll->ptp_info.pin_config);
+		zldpll->ptp_info.pin_config = NULL;
 		return PTR_ERR(ptp_clock);
 	}
 
@@ -2871,6 +3080,8 @@ static void zl3073x_dpll_ptp_unregister(struct zl3073x_dpll *zldpll)
 		ptp_clock_unregister(zldpll->ptp_clock);
 		zldpll->ptp_clock = NULL;
 	}
+	kfree(zldpll->ptp_info.pin_config);
+	zldpll->ptp_info.pin_config = NULL;
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 993221dc63249d..b9ae6d8301031a 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -9,6 +9,8 @@
 
 #include "core.h"
 
+struct zl3073x_dpll_pin;
+
 /**
  * struct zl3073x_dpll - ZL3073x DPLL sub-device structure
  * @list: this DPLL list entry
@@ -25,6 +27,7 @@
  * @pins: list of pins
  * @ptp_info: PTP clock info
  * @ptp_clock: registered PTP clock (or NULL)
+ * @perout_map: bitmap of output pins eligible for periodic output
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -41,6 +44,7 @@ struct zl3073x_dpll {
 	struct list_head		pins;
 	struct ptp_clock_info		ptp_info;
 	struct ptp_clock		*ptp_clock;
+	DECLARE_BITMAP(perout_map, ZL3073X_NUM_OUTPUT_PINS);
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
diff --git a/drivers/dpll/zl3073x/prop.h b/drivers/dpll/zl3073x/prop.h
index 721a18f05938b8..c5f477b56d4ab1 100644
--- a/drivers/dpll/zl3073x/prop.h
+++ b/drivers/dpll/zl3073x/prop.h
@@ -31,4 +31,25 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 
 void zl3073x_pin_props_put(struct zl3073x_pin_props *props);
 
+/**
+ * zl3073x_props_is_freq_supported - check if pin supports given frequency
+ * @props: pin properties
+ * @freq: frequency to check in Hz
+ *
+ * Return: true if the frequency is within the pin supported frequency ranges.
+ */
+static inline bool
+zl3073x_props_is_freq_supported(const struct zl3073x_pin_props *props, u64 freq)
+{
+	const struct dpll_pin_frequency *freqs;
+	int i;
+
+	freqs = props->dpll_props.freq_supported;
+	for (i = 0; i < props->dpll_props.freq_supported_num; i++)
+		if (freq >= freqs[i].min && freq <= freqs[i].max)
+			return true;
+
+	return false;
+}
+
 #endif /* _ZL3073X_PROP_H */
-- 
2.55.0

