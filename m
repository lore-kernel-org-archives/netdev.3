Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21513BE642
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621777; cv=none; b=PvDUt0DiNU659frKWtsL5sWZHU0+ocwf/MdhjmJPSt/QJGW02J+4hYvY2AE/niRln6lucRJz9f3sn3L/OK4xrBGAnv0v1Iw2xp6fxPAO/eZ8fh7k+0FpI/gKoPrN8ne2H0K/5uHdfPAFmbgHnFZQ6Yw8LNzyzWI+wCmier7pkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621777; c=relaxed/simple;
	bh=8gYk56A2wT8KeHFZtcyTRO/qYagCuQTBZLL/VlnrmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlb61YxqkEqEf75whaiO9pF6aWAfA/4kG5Ki9JLFG2AO6aZQRWeRs3tHsb+dkYTrcbbDA1Tsey5cqMIU+VxKoTABbekJKCPOedBE3ooE/nysMygMhGQJWvG6+A+E8C2h5YMGVlbEb1UDBuJJL3sti251ZOLNlE1HKfjEp1MMXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6s7QEgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6s7QEgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbzCZcxJ04oVZULtyx4E7ADPG7w/Bps+Wm2QAvNz+M0=;
	b=Q6s7QEgBY8jqm3PQcWNnvfeixZgal6KPwmAMqwnBk9pIqSmbWJ2sPEBY7Hsb5t/kUMY2/p
	GQYikqkNslK7Gu5/EoeLH1s7KzLwzqFNisUCEOhGtJQhhf6X/a+f57fVcv8Xz0NQdzRy8K
	/knkZ0QU9kYbvfN6YDiB+d8pkSnfxbA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-_2mYC7toPvOWmYljCHi0Nw-1; Mon,
 28 Sep 2026 14:56:09 -0400
X-MC-Unique: _2mYC7toPvOWmYljCHi0Nw-1
X-Mimecast-MFC-AGG-ID: _2mYC7toPvOWmYljCHi0Nw_1790621768
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E02EF1944F0E;
	Mon, 28 Sep 2026 18:56:07 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0828D1956047;
	Mon, 28 Sep 2026 18:56:04 +0000 (UTC)
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
Subject: [PATCH net-next 3/6] dpll: zl3073x: allow enabling/disabling output pins
Date: Mon, 28 Sep 2026 20:55:49 +0200
Message-ID: <20260928185552.1103515-4-ivecera@redhat.com>
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

Add support for enabling and disabling individual output pins through
the DPLL subsystem's state_on_dpll_get/set callbacks, at the
granularity of a single P-pin or N-pin rather than the whole output.
zl3073x_dev_output_pin_state_get() reports the pin connection state and
zl3073x_dev_output_pin_state_set() applies the requested one.

Differential pins are toggled directly through the output_ctrl_x::stop
condition. CMOS pins are muted/unmuted via the GPO override, bracketed
by a clean stop/restart of the whole output since the GPO toggle is not
glitch-free. Output pins advertise DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE
to allow this from userspace.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 78 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.h | 29 ++++++++++++++
 drivers/dpll/zl3073x/dpll.c | 68 +++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/prop.c |  2 +
 4 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7386932df0327f..89cf46111dcb13 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -3,6 +3,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -12,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/sprintf.h>
 #include <linux/string_choices.h>
+#include <linux/time64.h>
 #include <linux/unaligned.h>
 #include <net/devlink.h>
 
@@ -667,6 +669,82 @@ int zl3073x_dev_gpo_set(struct zl3073x_dev *zldev, u8 gpo, bool value)
 	return zl3073x_write_u8(zldev, reg, val);
 }
 
+/**
+ * zl3073x_dev_output_pin_state_set - enable or disable the given output pin
+ * @zldev: pointer to zl3073x_dev structure
+ * @id: output pin id
+ * @enable: true to enable the pin, false to disable it
+ *
+ * Differential output pins are enabled/disabled through the clean
+ * output_ctrl_x::stop condition, since they expose only a single logical
+ * pin.
+ *
+ * CMOS output pins are enabled/disabled by muting/unmuting the pin's
+ * driver via a GPO override. The GPO toggle is not glitch-free, so it is
+ * bracketed by a clean stop/restart of the whole output.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_dev_output_pin_state_set(struct zl3073x_dev *zldev, u8 id,
+				     bool enable)
+{
+	u8 out_id = zl3073x_output_pin_out_get(id);
+	struct zl3073x_out out;
+	u32 delay, freq;
+	int rc;
+
+	out = *zl3073x_out_state_get(zldev, out_id);
+
+	if (zl3073x_out_is_diff(&out)) {
+		if (enable)
+			zl3073x_out_start(&out);
+		else
+			zl3073x_out_stop(&out);
+
+		return zl3073x_out_state_set(zldev, out_id, &out);
+	}
+
+	/* Bracket the GPO override toggle below with a clean stop/restart,
+	 * since the toggle itself is not glitch-free.
+	 */
+	zl3073x_out_stop(&out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+	if (rc)
+		return rc;
+
+	/* output_ctrl_x::stop is edge-aligned, so the device can take up
+	 * to half a period to actually reach the stopped state. Wait for
+	 * that long plus 25 ms, to make sure it is really stopped before
+	 * touching the GPO override below.
+	 */
+	delay = 25 * USEC_PER_MSEC;
+	freq = zl3073x_dev_output_pin_freq_get(zldev, id);
+	if (freq)
+		delay += USEC_PER_SEC / 2 / freq;
+	fsleep(delay);
+
+	if (enable) {
+		zl3073x_out_pin_func_set(&out, id, ZL3073X_OUT_PIN_F_CLOCK);
+	} else {
+		rc = zl3073x_dev_gpo_set(zldev, id, false);
+		if (rc)
+			goto restart_output;
+		zl3073x_out_pin_func_set(&out, id, ZL3073X_OUT_PIN_F_GPO_CONST);
+	}
+
+	/* Restart the output regardless of the result below: on failure,
+	 * don't leave the whole output, including the unrelated sibling
+	 * pin, stopped indefinitely.
+	 */
+	rc = zl3073x_out_state_set(zldev, out_id, &out);
+
+restart_output:
+	zl3073x_out_start(&out);
+	rc = zl3073x_out_state_set(zldev, out_id, &out) ? : rc;
+
+	return rc;
+}
+
 /**
  * zl3073x_ref_freq_meas_latch - latch reference frequency measurements
  * @zldev: pointer to zl3073x_dev structure
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index e7064f2958fa5f..2b4785ba18b237 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -168,6 +168,8 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
 
 int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
 int zl3073x_dev_gpo_set(struct zl3073x_dev *zldev, u8 gpo, bool value);
+int zl3073x_dev_output_pin_state_set(struct zl3073x_dev *zldev, u8 id,
+				     bool enable);
 
 /**
  * zl3073x_dev_is_ref_phase_comp_32bit - check ref phase comp register size
@@ -447,4 +449,31 @@ zl3073x_dev_output_pin_is_enabled(struct zl3073x_dev *zldev, u8 id)
 	return true;
 }
 
+/**
+ * zl3073x_dev_output_pin_state_get - get the given output pin connection state
+ * @zldev: pointer to zl3073x device
+ * @id: output pin id
+ *
+ * Differential outputs are connected when their clock is not stopped.
+ * CMOS ones are connected when they are not GPO-overridden - the pin would
+ * not have been registered at all if its P/N side was not enabled by the
+ * signal format in the first place.
+ *
+ * Return: true if the output pin is connected, false if disconnected
+ */
+static inline bool
+zl3073x_dev_output_pin_state_get(struct zl3073x_dev *zldev, u8 id)
+{
+	u8 out_id = zl3073x_output_pin_out_get(id);
+	const struct zl3073x_out *out;
+
+	out = zl3073x_out_state_get(zldev, out_id);
+
+	if (zl3073x_out_is_stopped(out))
+		return false;
+
+	return zl3073x_out_is_diff(out) ||
+	       zl3073x_out_pin_func_get(out, id) == ZL3073X_OUT_PIN_F_CLOCK;
+}
+
 #endif /* _ZL3073X_CORE_H */
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 2c6de4dab8b4ad..426974b0b5dc5c 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -17,6 +17,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
+#include <linux/time64.h>
 
 #include "core.h"
 #include "dpll.h"
@@ -1195,12 +1196,74 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  enum dpll_pin_state *state,
 					  struct netlink_ext_ack *extack)
 {
-	/* If the output pin is registered then it is always connected */
-	*state = DPLL_PIN_STATE_CONNECTED;
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	guard(mutex)(&zldpll->lock);
+
+	if (zl3073x_dev_output_pin_state_get(zldev, pin->id))
+		*state = DPLL_PIN_STATE_CONNECTED;
+	else
+		*state = DPLL_PIN_STATE_DISCONNECTED;
 
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_output_pin_state_on_dpll_set - enable or disable an output pin
+ * @dpll_pin: registered dpll_pin
+ * @pin_priv: pointer to zl3073x_dpll_pin structure
+ * @dpll: registered dpll_device
+ * @dpll_priv: pointer to zl3073x_dpll structure
+ * @state: requested pin state
+ * @extack: netlink extack pointer
+ *
+ * Differential output pins are enabled/disabled through the clean
+ * output_ctrl_x::stop condition, since they expose only a single
+ * logical pin.
+ *
+ * CMOS output pins are enabled/disabled by muting/unmuting the pin's
+ * driver via a GPO override rather than by changing the output's
+ * signal_format, since a signal_format change is not glitch-free on
+ * this hardware. The GPO toggle itself is not glitch-free either, so
+ * it is bracketed by a clean stop/restart of the whole output.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv,
+					  enum dpll_pin_state state,
+					  struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	bool enable;
+	int rc = 0;
+
+	if (state != DPLL_PIN_STATE_CONNECTED &&
+	    state != DPLL_PIN_STATE_DISCONNECTED) {
+		NL_SET_ERR_MSG(extack, "Invalid pin state for output pin");
+		return -EINVAL;
+	}
+
+	guard(mutex)(&zldpll->lock);
+
+	enable = state == DPLL_PIN_STATE_CONNECTED;
+	if (zl3073x_dev_output_pin_state_get(zldev, pin->id) != enable) {
+		rc = zl3073x_dev_output_pin_state_set(zldev, pin->id, enable);
+		if (rc)
+			NL_SET_ERR_MSG(extack,
+				       "Failed to change output pin state");
+	}
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_nco_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
 					   void *pin_priv,
@@ -1685,6 +1748,7 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.phase_adjust_get = zl3073x_dpll_output_pin_phase_adjust_get,
 	.phase_adjust_set = zl3073x_dpll_output_pin_phase_adjust_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
+	.state_on_dpll_set = zl3073x_dpll_output_pin_state_on_dpll_set,
 };
 
 static const struct dpll_pin_ops zl3073x_dpll_nco_pin_ops = {
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978ef..806d1e6622da5a 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -214,6 +214,8 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 		u32 f;
 
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+		props->dpll_props.capabilities =
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 
 		/* The output pin phase adjustment granularity equals half of
 		 * the synth frequency count.
-- 
2.55.0

