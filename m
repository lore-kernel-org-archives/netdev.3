Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005A44A72C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456058; cv=none; b=MysEs2fS8xMCZpp5fNhvtGOJcM5e7+FR0Cp43xH2qVnSX9tR5B13YhhEkijYIt93bjlGSHXUjoEQKGEZW92x5L3gxSkC3M3AkOWnYCUrZ/vvQrl2X+CT2ur7+oR1fjQmj0OxZ7uEsLPkl8q5y6jML+rJ+csGXYXINChe+Ap/TiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456058; c=relaxed/simple;
	bh=2SMyY1rQkfSYHT77nXIfKtvcn8OhI7rr/+HLrfu7Kco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpjrjwQr72JgewJ5Tx0eSYRrnC7qEOQKu0JvLiDAG4pjO6VvzigziAyhaNTFskxV+CB5y6ovVzCJGARupZZ1Xiz+h707pjY9ZIwvYiKaPTlpKN2G6tamSvKouwjU47NMFiw9cG24en6BowOTbGoEp2ipdYi2RmzPSFYvd7RZVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVm+prTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVm+prTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786456044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMfXWDhnV4EFY09R/Cb5h4e+Td+2xPkVaJqWfLs+fn8=;
	b=bVm+prTsLIH5sj44L1ctu5iGQ5RvcJ0I0AJ5Tar63iKz6boCIMiEyu4E5u4LUw23uKzQ0e
	Bc9jG9miApoSFvfHAL1PifvfJa9tzqSYrOHKtx/W2CNG9ugGfYQNcopLbl7gH3TpIlo7Us
	udlt56rzxlA2NgicmZ3pEEubilyV2S0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-c94T1TjAOPS4TdpyfixPWQ-1; Tue,
 11 Aug 2026 09:47:21 -0400
X-MC-Unique: c94T1TjAOPS4TdpyfixPWQ-1
X-Mimecast-MFC-AGG-ID: c94T1TjAOPS4TdpyfixPWQ_1786456039
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B52B195608B;
	Tue, 11 Aug 2026 13:47:19 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 380F2195DF91;
	Tue, 11 Aug 2026 13:47:14 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 3/3] dpll: zl3073x: add PTP clock support
Date: Tue, 11 Aug 2026 15:47:00 +0200
Message-ID: <20260811134700.1211010-4-ivecera@redhat.com>
In-Reply-To: <20260811134700.1211010-1-ivecera@redhat.com>
References: <20260811134700.1211010-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
is registered for each DPLL channel regardless of the initial channel
state, providing gettimex64, settime64, adjtime, adjfine, adjphase
and getmaxphase callbacks.

Callback availability depends on the current channel state:
- adjfine: when NCO pin is connected (returns -EOPNOTSUPP otherwise)
- adjphase: available when tracking a reference, uses TIE write
- adjtime: always available and uses
  * phase step for sub-second deltas when NCO pin is connected
  * TIE write when tracking a reference
  * plain ToD read-modify-write otherwise
- gettime/settime: always available

The adjtime callback splits multi-second adjustments into a ToD
read-modify-write for the seconds part and a sub-second mechanism
(phase step or TIE write) for the remainder. On partial failure
where seconds were already committed, success is returned to
prevent the PTP servo from retrying and applying seconds again.

All PTP callbacks are serialized by the existing per-DPLL zldpll->lock
mutex, which is also used by DPLL pin and device callbacks.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/dpll.c  | 439 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   5 +
 3 files changed, 422 insertions(+), 28 deletions(-)

diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 5bbca140058131..da1731ace15f02 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -2,7 +2,7 @@
 
 config ZL3073X
 	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
-	depends on NET
+	depends on NET && PTP_1588_CLOCK
 	select DPLL
 	select NET_DEVLINK
 	select REGMAP
@@ -16,7 +16,7 @@ config ZL3073X
 
 config ZL3073X_I2C
 	tristate "I2C bus implementation for Microchip Azurite devices"
-	depends on I2C && NET
+	depends on I2C && NET && PTP_1588_CLOCK
 	select REGMAP_I2C
 	select ZL3073X
 	help
@@ -28,7 +28,7 @@ config ZL3073X_I2C
 
 config ZL3073X_SPI
 	tristate "SPI bus implementation for Microchip Azurite devices"
-	depends on NET && SPI
+	depends on NET && SPI && PTP_1588_CLOCK
 	select REGMAP_SPI
 	select ZL3073X
 	help
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 83bd3027dbaa1e..f2e137475b40ff 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -2,6 +2,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/bug.h>
 #include <linux/container_of.h>
 #include <linux/dev_printk.h>
@@ -13,6 +14,7 @@
 #include <linux/netlink.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 
@@ -2313,45 +2315,384 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
 	return zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
 }
 
+/* Maximum frequency adjustment: +-1% of nominal in ppb */
+#define ZL3073X_DPLL_PTP_MAX_ADJ	10000000
+
 /**
- * zl3073x_dpll_alloc - allocate DPLL device
- * @zldev: pointer to zl3073x device
- * @ch: DPLL channel number
+ * zl3073x_dpll_ptp_gettimex64 - read current time from ToD counters
+ * @info: PTP clock info
+ * @ts: timespec to store current time
+ * @sts: optional system timestamp pair for cross-timestamping
  *
- * Allocates DPLL device structure for given DPLL channel.
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_dpll_ptp_gettimex64(struct ptp_clock_info *info,
+				       struct timespec64 *ts,
+				       struct ptp_system_timestamp *sts)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+
+	guard(mutex)(&zldpll->lock);
+
+	return zl3073x_chan_tod_read(zldpll->dev, zldpll->id, false, ts, sts);
+}
+
+/**
+ * zl3073x_dpll_ptp_settime64 - set ToD counters to given time
+ * @info: PTP clock info
+ * @ts: timespec with time to set
  *
- * Return: pointer to DPLL device on success, error pointer on error
+ * Return: 0 on success, <0 on error
  */
-struct zl3073x_dpll *
-zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
+static int zl3073x_dpll_ptp_settime64(struct ptp_clock_info *info,
+				      const struct timespec64 *ts)
 {
-	struct zl3073x_dpll *zldpll;
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
 
-	zldpll = kzalloc_obj(*zldpll);
-	if (!zldpll)
-		return ERR_PTR(-ENOMEM);
+	guard(mutex)(&zldpll->lock);
 
-	zldpll->dev = zldev;
-	zldpll->id = ch;
-	mutex_init(&zldpll->lock);
-	INIT_LIST_HEAD(&zldpll->pins);
+	return zl3073x_chan_tod_write(zldpll->dev, zldpll->id, *ts);
+}
 
-	return zldpll;
+/**
+ * zl3073x_dpll_ptp_adjtime_phase_step - adjust sub-second time via phase step
+ * @zldpll: DPLL channel
+ * @delta: time adjustment in nanoseconds (must be within (-NSEC_PER_SEC,
+ *         NSEC_PER_SEC))
+ *
+ * Uses the output phase step mechanism with tod_step=1 to adjust both
+ * the output clock phase and the ToD counter simultaneously. This keeps
+ * outputs and ToD coherent. Only valid for NCO.
+ *
+ * Outputs are grouped by synthesizer since the phase step value is in
+ * synthesizer clock cycles. The first synth group with enabled outputs
+ * uses tod_step to adjust both outputs and the ToD counter. Remaining
+ * groups step outputs only. If no synth has enabled outputs, the ToD
+ * counter is stepped alone using an empty output mask (the FW uses
+ * the first enabled synth's period for the conversion).
+ *
+ * Return:
+ * * %0			- success (or partial success if a later synth group
+ *			  failed after the first was already stepped)
+ * * %-EOPNOTSUPP	- no synths available
+ * * negative		- error
+ */
+static int zl3073x_dpll_ptp_adjtime_phase_step(struct zl3073x_dpll *zldpll,
+					       s64 delta)
+{
+	u16 synth_mask[ZL3073X_NUM_SYNTHS] = {};
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_synth *synth;
+	struct zl3073x_dpll_pin *pin;
+	u32 first_synth_freq = 0;
+	bool tod_stepped = false;
+	s32 step_cycles;
+	u32 synth_freq;
+	int rc;
+	u8 i;
+
+	/* Build per-synth output masks from registered output pins */
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		u8 out_id, synth_id;
+
+		if (zl3073x_dpll_is_input_pin(pin))
+			continue;
+
+		out_id = zl3073x_output_pin_out_get(pin->id);
+
+		if (!zl3073x_dev_out_is_stepped(zldev, out_id))
+			continue;
+
+		synth_id = zl3073x_dev_out_synth_get(zldev, out_id);
+		if (synth_id >= ZL3073X_NUM_SYNTHS) {
+			dev_warn(zldev->dev, "Unexpected synth id for OUT%u\n",
+				 out_id);
+			continue;
+		}
+		synth_mask[synth_id] |= BIT(out_id);
+	}
+
+	/* Process each synth group */
+	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {
+		synth = zl3073x_synth_state_get(zldev, i);
+		if (!zl3073x_synth_is_enabled(synth) ||
+		    zl3073x_synth_dpll_get(synth) != zldpll->id)
+			continue;
+
+		synth_freq = zl3073x_synth_freq_get(synth);
+
+		/* Remember first enabled synth freq for ToD-only fallback */
+		if (!first_synth_freq)
+			first_synth_freq = synth_freq;
+
+		if (!synth_mask[i])
+			continue;
+
+		/* Safe for s32: max synth freq is 750 MHz */
+		step_cycles = div_s64(delta * synth_freq, NSEC_PER_SEC);
+
+		rc = zl3073x_chan_phase_step(zldev, zldpll->id,
+					     synth_mask[i], step_cycles,
+					     !tod_stepped);
+		if (rc) {
+			if (tod_stepped) {
+				dev_warn(zldev->dev,
+					 "Partial phase step failure\n");
+				return 0;
+			}
+			return rc;
+		}
+		tod_stepped = true;
+	}
+
+	if (!first_synth_freq)
+		return -EOPNOTSUPP;
+
+	/* No enabled outputs found; step ToD counter only using the
+	 * first enabled synth's period (empty output mask).
+	 */
+	if (!tod_stepped) {
+		step_cycles = div_s64(delta * first_synth_freq, NSEC_PER_SEC);
+		return zl3073x_chan_phase_step(zldev, zldpll->id, 0,
+					       step_cycles, true);
+	}
+
+	return 0;
 }
 
 /**
- * zl3073x_dpll_free - free DPLL device
- * @zldpll: pointer to zl3073x_dpll structure
+ * zl3073x_dpll_ptp_adjtime - adjust PTP clock time
+ * @info: PTP clock info
+ * @delta: time adjustment in nanoseconds
  *
- * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
+ * For NCO, large deltas (>= 1 second) are split into a ToD
+ * read-modify-write for the seconds part and an output phase step for
+ * the sub-second remainder. Sub-second deltas use phase step directly,
+ * falling back to ToD read-modify-write if phase step or TIE write
+ * fails. In AUTO/REFLOCK modes, large deltas are split into ToD
+ * read-modify-write for seconds and TIE write for the sub-second
+ * remainder. Sub-second deltas use TIE write directly.
+ *
+ * If the seconds part was already committed when the sub-second
+ * mechanism fails, returns 0 to prevent the PTP servo from retrying
+ * the full delta and applying seconds again.
+ *
+ * Return: 0 on success (or partial success), <0 on error
  */
-void
-zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
+static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 {
-	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
+	bool sec_adjusted = false;
+	struct timespec64 ts;
+	int rc;
 
-	mutex_destroy(&zldpll->lock);
-	kfree(zldpll);
+	if (!delta)
+		return 0;
+
+	guard(mutex)(&zldpll->lock);
+
+	/* Modes without phase step or TIE use plain ToD adjust */
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan) &&
+	    !zl3073x_chan_mode_supports_tie(chan))
+		return zl3073x_chan_tod_adjust(zldev, zldpll->id,
+					       ns_to_timespec64(delta));
+
+	/* Split off seconds via ToD read-modify-write so the sub-second
+	 * remainder can be applied through the output-coherent mechanism
+	 * (phase step or TIE write).
+	 */
+	if (delta >= NSEC_PER_SEC || delta <= -NSEC_PER_SEC) {
+		s32 remainder;
+
+		ts.tv_sec = div_s64_rem(delta, NSEC_PER_SEC, &remainder);
+		ts.tv_nsec = 0;
+		delta = remainder;
+
+		rc = zl3073x_chan_tod_adjust(zldev, zldpll->id, ts);
+		if (rc)
+			return rc;
+
+		/* No sub-second remainder, done */
+		if (!delta)
+			return 0;
+
+		/* Wait for the ToD write to be applied at the 1 Hz edge
+		 * before issuing phase step or TIE write, so the pending
+		 * WR_NEXT_1HZ does not overwrite the sub-second adjustment.
+		 */
+		rc = zl3073x_chan_tod_ready_wait(zldev, zldpll->id);
+		if (rc)
+			return rc;
+
+		sec_adjusted = true;
+	}
+
+	/* Apply sub-second delta via phase step (NCO) or TIE write */
+	if (zl3073x_chan_mode_is_nco(chan)) {
+		rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
+		if (!rc)
+			return 0;
+	} else {
+		rc = zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+		if (!rc)
+			return 0;
+	}
+
+	/* Phase step or TIE write failed, fall back to ToD adjust */
+	rc = zl3073x_chan_tod_adjust(zldev, zldpll->id,
+				     ns_to_timespec64(delta));
+
+	/* In the unlikely event that both phase step/TIE write and fallback
+	 * ToD adjust fail after seconds were already committed, return
+	 * success to prevent the PTP servo from retrying the full delta and
+	 * applying seconds again. The sub-second residual will self-correct
+	 * in the next servo cycle.
+	 */
+	if (rc && sec_adjusted) {
+		dev_warn(zldev->dev,
+			 "Sub-second adjustment failed after seconds applied\n");
+		return 0;
+	}
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_ptp_adjfine - adjust PTP clock frequency
+ * @info: PTP clock info
+ * @scaled_ppm: frequency adjustment in scaled ppm (ppm * 2^16)
+ *
+ * Only supported for NCO. Writes the delta frequency offset register.
+ *
+ * Return:
+ * * %0			- success or @scaled_ppm is zero (no-op)
+ * * %-EOPNOTSUPP	- NCO pin is not connected and @scaled_ppm is non-zero
+ * * negative		- other error
+ */
+static int
+zl3073x_dpll_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	const struct zl3073x_chan *chan;
+	s64 offset;
+
+	/* Convert scaled_ppm to df_offset in 2^-48 steps:
+	 *   df_offset = -(scaled_ppm * 2^32) / 10^6
+	 *
+	 * Simplify to avoid overflow:
+	 *   df_offset = -(scaled_ppm * 2^26) / 5^6
+	 *   df_offset = -(scaled_ppm * 67108864) / 15625
+	 */
+	offset = -div_s64((s64)scaled_ppm * 67108864LL, 15625);
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan))
+		return scaled_ppm ? -EOPNOTSUPP : 0;
+	if (offset == chan->df_offset)
+		return 0;
+
+	return zl3073x_chan_df_offset_set(zldpll->dev, zldpll->id, offset);
+}
+
+/**
+ * zl3073x_dpll_ptp_adjphase - adjust PTP clock phase
+ * @info: PTP clock info
+ * @delta: phase adjustment in nanoseconds
+ *
+ * Only supported in AUTO and REFLOCK modes. Uses TIE write for
+ * nanosecond resolution phase adjustment.
+ *
+ * Return:
+ * * %0			- success or @delta is zero (no-op)
+ * * %-EOPNOTSUPP	- mode does not support TIE and @delta is non-zero
+ * * negative		- other error
+ */
+static int zl3073x_dpll_ptp_adjphase(struct ptp_clock_info *info, s32 delta)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
+
+	if (!delta)
+		return 0;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	if (!zl3073x_chan_mode_supports_tie(chan))
+		return -EOPNOTSUPP;
+
+	return zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+}
+
+static s32
+zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)
+{
+	/* HW limits TIE write to +-1 second. Return the constant HW
+	 * limit and let adjphase handle mode-specific checks.
+	 */
+	return NSEC_PER_SEC - 1;
+}
+
+static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
+	.owner		= THIS_MODULE,
+	.max_adj	= ZL3073X_DPLL_PTP_MAX_ADJ,
+	.gettimex64	= zl3073x_dpll_ptp_gettimex64,
+	.settime64	= zl3073x_dpll_ptp_settime64,
+	.adjtime	= zl3073x_dpll_ptp_adjtime,
+	.adjfine	= zl3073x_dpll_ptp_adjfine,
+	.adjphase	= zl3073x_dpll_ptp_adjphase,
+	.getmaxphase	= zl3073x_dpll_ptp_getmaxphase,
+};
+
+/**
+ * zl3073x_dpll_ptp_register - register PTP clock for a DPLL channel
+ * @zldpll: DPLL channel to register PTP clock for
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct ptp_clock *ptp_clock;
+
+	zldpll->ptp_info = zl3073x_dpll_ptp_clock_info;
+	snprintf(zldpll->ptp_info.name, sizeof(zldpll->ptp_info.name),
+		 "%s-dpll%u", dev_name(zldev->dev), zldpll->id);
+
+	ptp_clock = ptp_clock_register(&zldpll->ptp_info, zldev->dev);
+	if (IS_ERR(ptp_clock)) {
+		dev_err(zldev->dev, "Failed to register PTP clock for DPLL%u\n",
+			zldpll->id);
+		return PTR_ERR(ptp_clock);
+	}
+
+	zldpll->ptp_clock = ptp_clock;
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_ptp_unregister - unregister PTP clock for a DPLL channel
+ * @zldpll: DPLL channel to unregister PTP clock for
+ */
+static void zl3073x_dpll_ptp_unregister(struct zl3073x_dpll *zldpll)
+{
+	if (!IS_ERR_OR_NULL(zldpll->ptp_clock)) {
+		ptp_clock_unregister(zldpll->ptp_clock);
+		zldpll->ptp_clock = NULL;
+	}
 }
 
 /**
@@ -2436,6 +2777,47 @@ zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_alloc - allocate DPLL device
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel number
+ *
+ * Allocates DPLL device structure for given DPLL channel.
+ *
+ * Return: pointer to DPLL device on success, error pointer on error
+ */
+struct zl3073x_dpll *
+zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
+{
+	struct zl3073x_dpll *zldpll;
+
+	zldpll = kzalloc_obj(*zldpll);
+	if (!zldpll)
+		return ERR_PTR(-ENOMEM);
+
+	zldpll->dev = zldev;
+	zldpll->id = ch;
+	mutex_init(&zldpll->lock);
+	INIT_LIST_HEAD(&zldpll->pins);
+
+	return zldpll;
+}
+
+/**
+ * zl3073x_dpll_free - free DPLL device
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
+ */
+void
+zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
+{
+	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
+
+	mutex_destroy(&zldpll->lock);
+	kfree(zldpll);
+}
+
 /**
  * zl3073x_dpll_register - register DPLL device and all its pins
  * @zldpll: pointer to zl3073x_dpll structure
@@ -2466,6 +2848,13 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 		return rc;
 	}
 
+	rc = zl3073x_dpll_ptp_register(zldpll);
+	if (rc) {
+		zl3073x_dpll_pins_unregister(zldpll);
+		zl3073x_dpll_device_unregister(zldpll);
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -2479,7 +2868,7 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 void
 zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll)
 {
-	/* Unregister all pins and dpll */
+	zl3073x_dpll_ptp_unregister(zldpll);
 	zl3073x_dpll_pins_unregister(zldpll);
 	zl3073x_dpll_device_unregister(zldpll);
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index faebc402ba1b70..993221dc63249d 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -5,6 +5,7 @@
 
 #include <linux/dpll.h>
 #include <linux/list.h>
+#include <linux/ptp_clock_kernel.h>
 
 #include "core.h"
 
@@ -22,6 +23,8 @@
  * @type: DPLL type (PPS or EEC)
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
+ * @ptp_info: PTP clock info
+ * @ptp_clock: registered PTP clock (or NULL)
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -36,6 +39,8 @@ struct zl3073x_dpll {
 	enum dpll_type			type;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
+	struct ptp_clock_info		ptp_info;
+	struct ptp_clock		*ptp_clock;
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
-- 
2.54.0

