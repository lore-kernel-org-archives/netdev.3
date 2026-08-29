Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430523F9281;
	Sat, 29 Aug 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037257; cv=none; b=TjvXZEbgjctScRbXVztWCz8Sk0uRd3Y26aa6WgxVZspcTwJUGQr+9EawdVOaRtUH8WD/YYo23+lTelqkxDvNbIsBgf+dHpqjPGUdmht0Ss6eBuX7fVWSSWoS5AVNBB3bY9dnxXyR4WLJ60N6H7lreeyDj0qXitva760J7xGnXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037257; c=relaxed/simple;
	bh=61i9TUGiMtFGD5L1Jd4TFG0Pn606vX80fSJMHrD3TOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ7uzyCSzkjFjmYVglALFIz7GlzMA89S7cwYh4cGRbuwJt1iiwHXN0OZexYiOdncA8RypG2AoeHeAudAieChm43+fittR5eeNqNB98f6OGuKfxsxzb4KixoZOXhc9RSJGpJTzvBi2Evb+UJos9bc59O9cvV10sDy0WBLeM8jLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e5etv1uw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5etv1uw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jqYYq9Ac56ACEkZrVBV/w0LxW42KRKMnT6vdezFJ190=; b=e5etv1uwZCvT8B7GIva8z0plIq
	iB2OaZ1M27xgOV8RN1KOyxSIwNotQMGliN+D0Mli26NSO9IV4bw/hO1J7NEcA+N1Bw99G39Q446Uc
	KEayHxI0X0m6qmJp3wKR3fzSmCjeqw4cIHyJntqtuHb/wDUFipym8n09p8nBAe+KmlE6r9Vrstiqu
	sYk8lMOivLHQQqcPnqcmk38hsBCwUCS01lyjYE0a/iTmW3HrvS5GZzQ1jyARc+i8dXB5MGqnHX6rl
	JzzPLbpbh8UWa7XLxBSwXrwC/DU27oQr1bjTMuNq1RJS991kvCXzHbcTp6HL10pgsgfPadA0HRYGh
	BBPmlCrg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0QAP-0000000H5tA-0YHN;
	Sat, 29 Aug 2026 21:00:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x0QAO-00000000Abm-406g;
	Sat, 29 Aug 2026 22:00:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 4/4] [DO NOT MERGE] ptp: ptp_vmclock: Add simulated 1PPS support
Date: Sat, 29 Aug 2026 21:57:02 +0100
Message-ID: <20260829210041.40649-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829210041.40649-1-dwmw2@infradead.org>
References: <20260829210041.40649-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Before the timekeeping_set_reference() work, the simplest way to
synchronise the kernel against vmclock was to simulate a 1PPS signal.
Restore that hack here, for testing CONFIG_NTP_PPS in NOHZ mode.

Set up an hrtimer to fire at each vmclock second boundary, and teach
vmclock_get_crosststamp() to return the cycle counter and the
corresponding { systime, monoraw } at the *start* of the current second,
because hardpps() expects the timestamps it is given for phase and
frequency adjustment to be the kernel's clock readings at the moment the
true time is at the top of a second (i.e. when the pulse arrives).

The timer feeds a PTP_CLOCK_PPSUSR event; with PTP_ENABLE_PPS, the PPS
source bound to the in-kernel hardpps() consumer and STA_PPSTIME/PPSFREQ
set, the kernel disciplines CLOCK_REALTIME directly from vmclock. The
second-boundary cycle is recovered from get_device_system_crosststamp()
using a history snapshot for interpolation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 drivers/ptp/ptp_vmclock.c | 196 +++++++++++++++++++++++++++++++++++---
 1 file changed, 185 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index bb0e14bac9f2..44fb82f4054f 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -51,6 +52,10 @@ struct vmclock_state {
 	enum clocksource_ids cs_id, sys_cs_id;
 	int index;
 	char *name;
+	struct hrtimer pps_timer;
+	bool pps_enabled;
+	struct system_time_snapshot history_snap;
+	bool history_valid;
 };
 
 #define VMCLOCK_MAX_WAIT ms_to_ktime(100)
@@ -98,10 +103,13 @@ static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 static int vmclock_get_crosststamp(struct vmclock_state *st,
 				   struct ptp_system_timestamp *sts,
 				   struct system_counterval_t *system_counter,
-				   struct timespec64 *tspec)
+				   struct timespec64 *tspec,
+				   bool on_second)
 {
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
 	uint64_t cycle, delta, seq, frac_sec;
+	uint64_t period_frac_sec;
+	uint8_t period_shift;
 
 #ifdef CONFIG_X86
 	/*
@@ -154,11 +162,46 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 
 		delta = cycle - le64_to_cpu(st->clk->counter_value);
 
+		period_frac_sec = le64_to_cpu(st->clk->counter_period_frac_sec);
+		period_shift = st->clk->counter_period_shift;
+
 		frac_sec = mul_u64_u64_shr_add_u64(&tspec->tv_sec, delta,
-						   le64_to_cpu(st->clk->counter_period_frac_sec),
-						   st->clk->counter_period_shift,
+						   period_frac_sec, period_shift,
 						   le64_to_cpu(st->clk->time_frac_sec));
-		tspec->tv_nsec = mul_u64_u64_shr(frac_sec, NSEC_PER_SEC, 64);
+
+		/* For simulated PPS, adjust to the most recent second boundary */
+		if (on_second) {
+			uint64_t delta_cycles;
+			int frac_shift, shift_remain;
+
+			if (tspec->tv_sec == 0)
+				return -EAGAIN;  /* No second boundary crossed yet */
+
+			/*
+			 * Roll the counter back to the top of the current second.
+			 * frac_sec == 0 means we are already exactly on the
+			 * boundary (and __builtin_clzll(0) is undefined).
+			 */
+			if (frac_sec) {
+				/* Shift frac_sec left until top bit is set */
+				frac_shift = __builtin_clzll(frac_sec);
+				frac_sec <<= frac_shift;
+
+				/* Shift period right by the remaining bits */
+				shift_remain = period_shift - frac_shift;
+				if (shift_remain > 0)
+					period_frac_sec >>= shift_remain;
+				else
+					frac_sec >>= -shift_remain;
+
+				delta_cycles = frac_sec / period_frac_sec;
+				cycle -= delta_cycles;
+			}
+			tspec->tv_nsec = 0;
+		} else {
+			tspec->tv_nsec = mul_u64_u64_shr(frac_sec, NSEC_PER_SEC, 64);
+		}
+
 		tspec->tv_sec += le64_to_cpu(st->clk->time_sec);
 
 		if (!tai_adjust(st->clk, &tspec->tv_sec))
@@ -193,7 +236,8 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 					    struct ptp_system_timestamp *sts,
 					    struct system_counterval_t *system_counter,
-					    struct timespec64 *tspec)
+					    struct timespec64 *tspec,
+					    bool on_second)
 {
 	struct pvclock_vcpu_time_info *pvti = this_cpu_pvti();
 	unsigned int pvti_ver;
@@ -204,7 +248,7 @@ static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 	do {
 		pvti_ver = pvclock_read_begin(pvti);
 
-		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec);
+		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec, on_second);
 		if (ret)
 			break;
 
@@ -240,10 +284,10 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 #ifdef SUPPORT_KVMCLOCK
 	if (READ_ONCE(st->sys_cs_id) == CSID_X86_KVM_CLK)
 		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
-						       &tspec);
+						       &tspec, false);
 	else
 #endif
-		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec);
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec, false);
 
 	if (!ret)
 		*device_time = timespec64_to_ktime(tspec);
@@ -280,6 +324,98 @@ static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
 	return ret;
 }
 
+static int ptp_vmclock_get_time_fn_pps(ktime_t *device_time,
+				       struct system_counterval_t *system_counter,
+				       void *ctx)
+{
+	struct vmclock_state *st = ctx;
+	struct timespec64 tspec;
+	int ret;
+
+#ifdef SUPPORT_KVMCLOCK
+	if (st->history_valid && st->history_snap.cs_id == CSID_X86_KVM_CLK)
+		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
+						       &tspec, true);
+	else
+#endif
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec, true);
+
+	if (!ret)
+		*device_time = timespec64_to_ktime(tspec);
+
+	return ret;
+}
+
+/*
+ * Generate simulated PPS events for feeding __hardpps(), which expects to be
+ * given both CLOCK_REALTIME and CLOCK_MONOTONIC_RAW values for when a 1PPS
+ * signal actually happened (i.e. at the top of a second).
+ *
+ * vmclock_get_crosststamp(..., on_second=true) reads the vmclock and both
+ * system clocks from the same TSC value, then rolls the TSC back to the value
+ * it would have had at the start of the current second so the timestamps line
+ * up with a real pulse. The hrtimer reschedules itself for the top of the next
+ * second according to *vmclock*, not necessarily CLOCK_REALTIME.
+ */
+static enum hrtimer_restart ptp_vmclock_pps_timer(struct hrtimer *timer)
+{
+	struct vmclock_state *st = container_of(timer, struct vmclock_state, pps_timer);
+	struct system_device_crosststamp xtstamp = { .clock_id = CLOCK_REALTIME };
+	struct ptp_clock_event event;
+	ktime_t next, now_rt;
+	s64 delta_ns;
+	int ret;
+
+	if (!st->pps_enabled)
+		return HRTIMER_NORESTART;
+
+	/* Only report PPS if we have a valid history snapshot to interpolate from */
+	ret = -EINVAL;
+	if (st->history_valid) {
+		ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn_pps, st,
+						    &st->history_snap, &xtstamp);
+		if (!ret) {
+			event.type = PTP_CLOCK_PPSUSR;
+			event.pps_times.ts_real = ktime_to_timespec64(xtstamp.sys_systime);
+#ifdef CONFIG_NTP_PPS
+			event.pps_times.ts_raw = ktime_to_timespec64(xtstamp.sys_monoraw);
+#endif
+			ptp_clock_event(st->ptp_clock, &event);
+		}
+	}
+
+	/* Capture a snapshot to bound the next interpolation */
+	ktime_get_snapshot_id(CLOCK_REALTIME, &st->history_snap);
+	st->history_valid = true;
+
+	/*
+	 * Schedule the next timer for the top of the next second according to
+	 * vmclock. If we reported a PPS event, xtstamp.sys_systime is already
+	 * at the second boundary, so just add a second; otherwise read the
+	 * current vmclock time and work out when it next hits a boundary.
+	 */
+	if (!ret) {
+		next = ktime_add_ns(xtstamp.sys_systime, NSEC_PER_SEC);
+	} else {
+		struct timespec64 ts;
+
+		if (vmclock_get_crosststamp(st, NULL, NULL, &ts, false))
+			return HRTIMER_NORESTART;
+
+		delta_ns = NSEC_PER_SEC - ts.tv_nsec;
+		next = ktime_add_ns(st->history_snap.systime, delta_ns);
+	}
+
+	/* Never reschedule in the past, or the timer tight-loops */
+	now_rt = ktime_get_real();
+	if (ktime_compare(next, now_rt) <= 0)
+		next = ktime_add_ns(now_rt, NSEC_PER_SEC);
+
+	hrtimer_set_expires(timer, next);
+
+	return HRTIMER_RESTART;
+}
+
 /*
  * PTP clock operations
  */
@@ -306,12 +442,43 @@ static int ptp_vmclock_gettimex(struct ptp_clock_info *ptp, struct timespec64 *t
 	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
 						ptp_clock_info);
 
-	return vmclock_get_crosststamp(st, sts, NULL, ts);
+	return vmclock_get_crosststamp(st, sts, NULL, ts, false);
 }
 
 static int ptp_vmclock_enable(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on)
 {
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		st->pps_enabled = !!on;
+		if (on) {
+			struct timespec64 ts;
+			s64 delta_ns;
+
+			/* Snapshot to bound the first interpolation */
+			ktime_get_snapshot_id(CLOCK_REALTIME, &st->history_snap);
+			st->history_valid = true;
+
+			if (vmclock_get_crosststamp(st, NULL, NULL, &ts, false))
+				return -EIO;
+
+			/* When will vmclock next reach a second boundary? */
+			delta_ns = NSEC_PER_SEC - ts.tv_nsec;
+
+			hrtimer_start(&st->pps_timer,
+				      ktime_add_ns(st->history_snap.systime, delta_ns),
+				      HRTIMER_MODE_ABS);
+		} else {
+			hrtimer_cancel(&st->pps_timer);
+		}
+		return 0;
+	default:
+		break;
+	}
+
 	return -EOPNOTSUPP;
 }
 
@@ -320,7 +487,7 @@ static const struct ptp_clock_info ptp_vmclock_info = {
 	.max_adj	= 0,
 	.n_ext_ts	= 0,
 	.n_pins		= 0,
-	.pps		= 0,
+	.pps		= 1,
 	.adjfine	= ptp_vmclock_adjfine,
 	.adjtime	= ptp_vmclock_adjtime,
 	.gettimex64	= ptp_vmclock_gettimex,
@@ -356,6 +523,10 @@ static struct ptp_clock *vmclock_ptp_register(struct device *dev,
 	st->ptp_clock_info = ptp_vmclock_info;
 	strscpy(st->ptp_clock_info.name, st->name);
 
+	hrtimer_setup(&st->pps_timer, ptp_vmclock_pps_timer, CLOCK_REALTIME,
+		      HRTIMER_MODE_ABS);
+	st->pps_enabled = false;
+
 	return ptp_clock_register(&st->ptp_clock_info, dev);
 }
 
@@ -643,8 +814,11 @@ static void vmclock_remove(void *data)
 					   vmclock_acpi_notification_handler);
 #endif
 
-	if (st->ptp_clock)
+	if (st->ptp_clock) {
+		st->pps_enabled = false;
+		hrtimer_cancel(&st->pps_timer);
 		ptp_clock_unregister(st->ptp_clock);
+	}
 
 	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
 		misc_deregister(&st->miscdev);
-- 
2.55.0

