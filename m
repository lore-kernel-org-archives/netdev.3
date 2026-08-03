Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A640BCBC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766020; cv=none; b=DU62SWBgcsqHOF810JWvOh3ZHrU2D1CMM1kPkH+Zq7ZYNV288XDOyVZIzmAgU7qA0/ppEGTC8wMBiwgmXy1lji/HexGxaMHtrDDDT5smuQF9ctNxJfUMtBXKlOlMYksx5hq18i9TnrbDNpsUujG5GHUVHLIwMc6B/xBK/1+H1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766020; c=relaxed/simple;
	bh=b4/90jOIpXbhGsujJPnk62/iZYkV7ZraG8BLGcBJock=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paWrvE4HcKo5KRET8ooJCAXfQ271NwE4EOyx1UDPYxdtfrX/x9IijRBWeVTAMBqGgKXMgok8cQbLcdYbxHLkYL6FRP3nn7Anb80gvBkSLvZ4WP2GWTgTsOY6yCfXxIUSID/lqigr91FYUW/vdK/dOLpY1JrLpSO0DHd9a2mt0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHvQM4m2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHvQM4m2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785766017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgRY73BzHAEpTGrOJ/sZboZTpnHNiysZbwmrDAaf6CQ=;
	b=XHvQM4m2bL/t/lHOI1mQ9gS1NCESi6yZcdSVxsspvamnO1SQs3ARs8e0iKsqCYnrU9NeTB
	bvHmAPF0Sf9Bbpq11MEv8Pt3hXTH8Ojsklr2fIbTRRYmIuqcLxPwQKAVihV1UHPahU8L52
	luaEQgdKIga96Xk6C8qHSVQhgKeL1d4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-ow__LNqlMSmwsL57Q7RNvQ-1; Mon,
 03 Aug 2026 10:06:47 -0400
X-MC-Unique: ow__LNqlMSmwsL57Q7RNvQ-1
X-Mimecast-MFC-AGG-ID: ow__LNqlMSmwsL57Q7RNvQ_1785766005
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 696331954B0C;
	Mon,  3 Aug 2026 14:06:45 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.235])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06270423;
	Mon,  3 Aug 2026 14:06:41 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] dpll: zl3073x: add channel ToD, phase step and TIE operations
Date: Mon,  3 Aug 2026 16:06:36 +0200
Message-ID: <20260803140637.102339-2-ivecera@redhat.com>
In-Reply-To: <20260803140637.102339-1-ivecera@redhat.com>
References: <20260803140637.102339-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add low-level DPLL channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE (Time
Interval Error) write. These serve as building blocks for the PTP
clock callbacks added in the next patch.

ToD operations use a wait-before-write pattern to avoid blocking
after each operation.

The tod_ready_wait helper selects the poll timeout based on the
current ToD command - write operations use a longer timeout (1000 ms)
than reads (30 ms).

The ToD read captures system timestamps (ptp_system_timestamp) around
the HW command and completion poll to support cross-timestamping.

The TIE write operation provides sub-picosecond resolution phase
adjustment for modes where the DPLL is tracking a reference
(AUTO and REFLOCK).

Add output step-time mask to struct zl3073x_dev and
zl3073x_dev_out_is_stepped() helper to check if an output
participates in step-time operations.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 310 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/chan.h |  32 ++++
 drivers/dpll/zl3073x/core.c |  13 ++
 drivers/dpll/zl3073x/core.h |  23 +++
 drivers/dpll/zl3073x/regs.h |  52 ++++++
 5 files changed, 428 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 4ec2cf53dad468..79874a9fdb4962 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -3,6 +3,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -162,8 +163,8 @@ int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index)
  * @zldev: pointer to zl3073x_dev structure
  * @index: DPLL channel index to fetch state for
  *
- * Reads the mode_refsel register and reference priority registers for
- * the given DPLL channel and stores the raw values for later use.
+ * Reads the mode_refsel, status and reference priority registers for
+ * the given DPLL channel and stores the values for later use.
  *
  * Return: 0 on success, <0 on error
  */
@@ -234,6 +235,311 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
 	return &zldev->chan[index];
 }
 
+/**
+ * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ *
+ * Polls the ToD control register until the semaphore bit is cleared,
+ * indicating the device has completed the previous ToD operation.
+ *
+ * Return: 0 on success, -EBUSY if semaphore not cleared, <0 on error
+ */
+int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
+{
+	unsigned int timeout;
+	u8 tod_ctrl;
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
+	if (rc)
+		return rc;
+
+	switch (FIELD_GET(ZL_DPLL_TOD_CTRL_CMD, tod_ctrl)) {
+	case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
+		timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
+		break;
+	default:
+		timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
+		break;
+	}
+
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
+				  ZL_DPLL_TOD_CTRL_SEM, timeout);
+
+	return rc == -ETIMEDOUT ? -EBUSY : rc;
+}
+
+/**
+ * zl3073x_chan_tod_ctrl - issue ToD command
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @cmd: ToD command to execute
+ *
+ * Writes the semaphore and command to dpll_tod_ctrl. The caller must
+ * ensure the device is ready (semaphore clear) before calling and
+ * must wait for completion if needed.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_chan_tod_ctrl(struct zl3073x_dev *zldev, u8 ch, u8 cmd)
+{
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
+				ZL_DPLL_TOD_CTRL_SEM | cmd);
+}
+
+/**
+ * zl3073x_chan_tod_read - read ToD registers after issuing a command
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @next_hz: if true, read predicted ToD at next 1 Hz; otherwise read current
+ * @ts: timespec to store the result
+ * @sts: optional system timestamp pair for cross-timestamping
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
+			  bool next_hz, struct timespec64 *ts,
+			  struct ptp_system_timestamp *sts)
+{
+	u32 nsec;
+	u64 sec;
+	u8 cmd;
+	int rc;
+
+	if (next_hz)
+		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ;
+	else
+		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT;
+
+	/* Wait for any previous ToD operation to complete */
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+
+	ptp_read_system_prets(sts);
+	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+	ptp_read_system_postts(sts);
+
+	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), &sec);
+	if (rc)
+		return rc;
+
+	/* HW nanoseconds are always in [0, NSEC_PER_SEC) range */
+	rc = zl3073x_read_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), &nsec);
+	if (rc)
+		return rc;
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
+/**
+ * zl3073x_chan_tod_write - write ToD registers and trigger 1 Hz update
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @ts: time to set
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
+			   struct timespec64 ts)
+{
+	int rc;
+
+	/* Wait for any previous ToD operation to complete */
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), ts.tv_sec);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), ts.tv_nsec);
+	if (rc)
+		return rc;
+
+	return zl3073x_chan_tod_ctrl(zldev, ch,
+				     ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ);
+}
+
+/**
+ * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with rollover guard
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @delta: time adjustment to apply
+ *
+ * Reads the next-Hz ToD and current ToD, then checks whether enough time
+ * remains before the next 1 Hz rollover to safely complete the write.
+ * If less than 20 ms remains, waits for the rollover and increments the
+ * next-Hz seconds by one. If the tick crossed between the two reads,
+ * normalizes by the number of elapsed ticks. Applies @delta and writes
+ * the result back.
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
+			    struct timespec64 delta)
+{
+	static const long threshold_ns = 20 * NSEC_PER_MSEC;
+	struct timespec64 ts_next, ts_cur, diff;
+	int rc;
+
+	/* Read predicted ToD at next 1 Hz tick */
+	rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
+	if (rc)
+		return rc;
+
+	/* Read current ToD to determine remaining margin */
+	rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
+	if (rc)
+		return rc;
+
+	/* If too close to the next rollover, wait it out. If the 1 Hz tick
+	 * crossed between the two reads, normalize by the elapsed ticks.
+	 */
+	diff = timespec64_sub(ts_next, ts_cur);
+	if (!diff.tv_sec && diff.tv_nsec < threshold_ns) {
+		fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
+		ts_next.tv_sec++;
+	} else if (diff.tv_sec < 0) {
+		ts_next.tv_sec -= diff.tv_sec;
+	}
+
+	/* Apply delta to the next-Hz ToD */
+	ts_next = timespec64_add(ts_next, delta);
+	if (!timespec64_valid(&ts_next))
+		return -EINVAL;
+
+	return zl3073x_chan_tod_write(zldev, ch, ts_next);
+}
+
+/**
+ * zl3073x_chan_df_offset_set - write delta frequency offset to hardware
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @offset: frequency offset in 2^-48 steps
+ *
+ * Context: Caller must hold the per-DPLL lock.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
+{
+	int rc;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_DF_OFFSET(ch), offset);
+	if (!rc)
+		zldev->chan[ch].df_offset = offset;
+
+	return rc;
+}
+
+/**
+ * zl3073x_chan_tie_write - adjust DPLL phase using TIE write
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @delta_ns: phase adjustment in nanoseconds (must be within +-1s)
+ *
+ * Converts nanoseconds to TIE units (0.01 ps) and writes TIE data
+ * to the specified channel.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns)
+{
+	s64 tie_data;
+	int rc;
+
+	if (WARN_ON(delta_ns <= -NSEC_PER_SEC || delta_ns >= NSEC_PER_SEC))
+		return -ERANGE;
+
+	guard(mutex)(&zldev->tie_lock);
+
+	/* Wait for any previous TIE operation to complete */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
+				  ZL_DPLL_TIE_CTRL_OP,
+				  ZL_POLL_TIE_WR_TIMEOUT_US);
+	if (rc)
+		return rc;
+
+	/* Convert ns to TIE units (0.01 ps = 10^-14 s) */
+	tie_data = delta_ns * 100000LL;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TIE_DATA(ch), tie_data);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL_MASK, BIT(ch));
+	if (rc)
+		return rc;
+
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
+				ZL_DPLL_TIE_CTRL_OP_WR);
+}
+
+/**
+ * zl3073x_chan_phase_step - execute one output phase step operation
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @out_mask: bitmask of outputs to step
+ * @step_cycles: phase step in synthesizer clock cycles
+ * @tod_step: also step the ToD counter
+ *
+ * All masked outputs must use synthesizers of the same frequency since
+ * the step value is in synthesizer clock cycles.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
+			    u16 out_mask, s32 step_cycles,
+			    bool tod_step)
+{
+	u8 ctrl;
+	int rc;
+
+	guard(mutex)(&zldev->phase_step_lock);
+
+	/* Wait for any previous phase step operation to complete */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL,
+				  ZL_OUTPUT_PHASE_STEP_CTRL_OP,
+				  ZL_POLL_PHASE_STEP_TIMEOUT_US);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_STEP_DATA,
+			       step_cycles);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u16(zldev, ZL_REG_OUTPUT_PHASE_STEP_MASK, out_mask);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_NUMBER, 1);
+	if (rc)
+		return rc;
+
+	ctrl = FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_DPLL, ch) |
+	       FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_OP,
+			  ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE);
+	if (tod_step)
+		ctrl |= ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP;
+
+	return zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL, ctrl);
+}
+
 /**
  * zl3073x_chan_state_set - commit DPLL channel state changes to hardware
  * @zldev: pointer to zl3073x_dev structure
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index dc9c6d95bdee75..99c3b7088f678f 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -5,10 +5,12 @@
 
 #include <linux/bitfield.h>
 #include <linux/stddef.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "regs.h"
 
+struct ptp_system_timestamp;
 struct zl3073x_dev;
 
 /**
@@ -42,6 +44,21 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
 int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index);
 
+int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch);
+int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
+			  bool next_hz, struct timespec64 *ts,
+			  struct ptp_system_timestamp *sts);
+int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
+			   struct timespec64 ts);
+int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
+			    struct timespec64 delta);
+int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
+			    u16 out_mask, s32 step_cycles, bool tod_step);
+
+int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset);
+
+int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns);
+
 /**
  * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
  * @chan: pointer to channel state
@@ -200,6 +217,21 @@ static inline bool zl3073x_chan_mode_is_reflock(const struct zl3073x_chan *chan)
 	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
 }
 
+/**
+ * zl3073x_chan_mode_supports_tie - check if channel mode supports TIE write
+ * @chan: pointer to channel state
+ *
+ * TIE write is supported in AUTO and REFLOCK modes regardless of lock state.
+ *
+ * Return: true if TIE write is supported, false otherwise
+ */
+static inline bool
+zl3073x_chan_mode_supports_tie(const struct zl3073x_chan *chan)
+{
+	return zl3073x_chan_mode_is_auto(chan) ||
+		zl3073x_chan_mode_is_reflock(chan);
+}
+
 /**
  * zl3073x_chan_is_ho_ready - check if holdover is ready
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7f5afaaae6342f..8a8c27a06ac9de 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -510,6 +510,11 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	int rc;
 	u8 i;
 
+	rc = zl3073x_read_u16(zldev, ZL_REG_OUTPUT_STEP_TIME_MASK,
+			      &zldev->out_step_time_mask);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
 		rc = zl3073x_ref_state_fetch(zldev, i);
 		if (rc) {
@@ -1033,6 +1038,14 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 	 * and/or polls are required to be done atomically.
 	 */
 	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->phase_step_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->tie_lock);
 	if (rc)
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 78dc208f3eea2a..67c10e2595118c 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -26,6 +26,10 @@ struct zl3073x_dpll;
 #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
 #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
 #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
+#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
@@ -55,6 +59,8 @@ struct zl3073x_chip_info {
  * @regmap: regmap to access device registers
  * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
+ * @tie_lock: to serialize TIE write operations
+ * @phase_step_lock: to serialize output phase step operations
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -63,6 +69,7 @@ struct zl3073x_chip_info {
  * @kworker: thread for periodic work
  * @work: periodic work
  * @clock_id: clock id of the device
+ * @out_step_time_mask: output step-time mask (device-global)
  * @phase_avg_factor: phase offset measurement averaging factor
  * @freq_monitor: is frequency monitor enabled
  */
@@ -71,6 +78,8 @@ struct zl3073x_dev {
 	struct regmap			*regmap;
 	const struct zl3073x_chip_info	*info;
 	struct mutex			multiop_lock;
+	struct mutex			tie_lock;
+	struct mutex			phase_step_lock;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -87,6 +96,7 @@ struct zl3073x_dev {
 
 	/* Per-chip parameters */
 	u64			clock_id;
+	u16			out_step_time_mask;
 	u8			phase_avg_factor;
 	bool			freq_monitor;
 };
@@ -308,6 +318,19 @@ zl3073x_dev_out_is_enabled(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_synth_is_enabled(synth) && zl3073x_out_is_enabled(out);
 }
 
+/**
+ * zl3073x_dev_out_is_stepped - check if output is in step-time mask
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if output is affected by step-time operations
+ */
+static inline bool
+zl3073x_dev_out_is_stepped(struct zl3073x_dev *zldev, u8 index)
+{
+	return !!(zldev->out_step_time_mask & BIT(index));
+}
+
 /**
  * zl3073x_dev_out_dpll_get - get DPLL ID the output is driven by
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index b70ead7d4495b2..f3a5e1215aa36b 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -179,6 +179,20 @@
 #define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
 #define ZL_DPLL_DF_READ_CMD_ACC_I		4
 
+#define ZL_REG_DPLL_TIE_CTRL			ZL_REG(5, 0x30, 1)
+#define ZL_DPLL_TIE_CTRL_OP			GENMASK(2, 0)
+#define ZL_DPLL_TIE_CTRL_OP_WR			4
+
+#define ZL_REG_DPLL_TIE_CTRL_MASK		ZL_REG(5, 0x31, 1)
+
+#define ZL_REG_DPLL_TOD_CTRL(_idx)					\
+	ZL_REG_IDX(_idx, 5, 0x38, 1, ZL3073X_MAX_CHANNELS, 1)
+#define ZL_DPLL_TOD_CTRL_SEM			BIT(4)
+#define ZL_DPLL_TOD_CTRL_CMD			GENMASK(3, 0)
+#define ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ	1
+#define ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT		8
+#define ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ	9
+
 #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
 #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
 #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
@@ -193,6 +207,9 @@
 
 /*******************************
  * Register Pages 6-7, DPLL Data
+ *
+ * Per-channel registers with stride 0x20. Channels 0-3 reside on page 6,
+ * channel 4 on page 7.
  *******************************/
 
 #define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
@@ -202,6 +219,24 @@
 	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
 #define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
 
+#define ZL_REG_DPLL_TIE_DATA_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x0C, 6, 4, 0x20)
+#define ZL_REG_DPLL_TIE_DATA_4			ZL_REG(7, 0x0C, 6)
+#define ZL_REG_DPLL_TIE_DATA(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TIE_DATA_03(_idx) : ZL_REG_DPLL_TIE_DATA_4)
+
+#define ZL_REG_DPLL_TOD_SEC_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x12, 6, 4, 0x20)
+#define ZL_REG_DPLL_TOD_SEC_4			ZL_REG(7, 0x12, 6)
+#define ZL_REG_DPLL_TOD_SEC(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TOD_SEC_03(_idx) : ZL_REG_DPLL_TOD_SEC_4)
+
+#define ZL_REG_DPLL_TOD_NS_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x18, 4, 4, 0x20)
+#define ZL_REG_DPLL_TOD_NS_4			ZL_REG(7, 0x18, 4)
+#define ZL_REG_DPLL_TOD_NS(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TOD_NS_03(_idx) : ZL_REG_DPLL_TOD_NS_4)
+
 /***********************************
  * Register Page 9, Synth and Output
  ***********************************/
@@ -221,6 +256,23 @@
 #define ZL_OUTPUT_CTRL_EN			BIT(0)
 #define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
 
+#define ZL_REG_OUTPUT_STEP_TIME_MASK		ZL_REG(9, 0x36, 2)
+
+#define ZL_REG_OUTPUT_PHASE_STEP_CTRL		ZL_REG(9, 0x38, 1)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_DPLL		GENMASK(6, 4)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP	BIT(3)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP		GENMASK(1, 0)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_NONE	0
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_RESET	1
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_READ	2
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE	3
+
+#define ZL_REG_OUTPUT_PHASE_STEP_NUMBER		ZL_REG(9, 0x39, 1)
+
+#define ZL_REG_OUTPUT_PHASE_STEP_MASK		ZL_REG(9, 0x3a, 2)
+
+#define ZL_REG_OUTPUT_PHASE_STEP_DATA		ZL_REG(9, 0x3c, 4)
+
 /*******************************
  * Register Page 10, Ref Mailbox
  *******************************/
-- 
2.54.0

