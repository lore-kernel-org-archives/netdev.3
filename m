Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377541CB4D;
	Sat, 29 Aug 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037255; cv=none; b=j5kUAE0FOMHfCArEUktQBlIUAg9CYExQrISMDPrH1kNK395SAd+uRwGD3St2o63yd/4N++pLeAi9oxMmer/DZttU2JVVAmdNOfm66cwHCrZekmbq4AI/4dujjjTDiVDGf1BMLnr5QgLTmSx7voPsSY2re1/i/qVXmoo0+59unU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037255; c=relaxed/simple;
	bh=rzLy83Gde+jCVb+UFilIX5Mi3lSsPZZr74UuP3zMDUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7OLzaTV3wFOyTK/j7M2k618OD6FwiLUsttAD8R95bzl2TCCWmCOj/QeykGYrt2AbTwgn73xCyxhNLECWL3P4oua9MwfT/NkcEHHKPF3jHp9VqNZR4ccScUdpoWvq88VqkG2V3xVmr4NB1DIQR61QxQVPoXYg98q0G0lBEvfDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bozgxFUe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bozgxFUe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Aq/TBRR68oABPHWW85xGriW8VExh69+qjG0gLLF3G64=; b=bozgxFUe8nPsZD4FUklfwMN0Wj
	6m6voV6rIYsjAmBfSHE2itUoTEvlyZ4AFoD2EaCCplBdEF5MAB0kcpN94Ji/XvAtsmCPZs8gzIchY
	6ganracYqMGpv4ldBSQZq3y99rU0ejKs25SVxCBX1qOOjE+StHF96ESGoD/cp9n/t0dPDcSttYyGh
	crfVLcOMpTGJCn/hsxsKnVgIV22hs31LnIiiFMdFady7G56jctljhU/pEcpgqe1WLTV+xdiL+9iZ0
	3pMhiVR568O7v5yE9U5OjVFSE+ApI8qudEw64aZ2tkx7f3N49hrstTAEbY/Gw9Ie8r7+uu+I6mdoJ
	fxLg230w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0QAO-0000000H5t8-3vPF;
	Sat, 29 Aug 2026 21:00:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x0QAO-00000000Aba-381I;
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
Subject: [PATCH v4 1/4] timekeeping: Apply extrapolated ntp_error to clock snapshots
Date: Sat, 29 Aug 2026 21:56:59 +0100
Message-ID: <20260829210041.40649-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829210041.40649-1-dwmw2@infradead.org>
References: <20260829210041.40649-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The time reported in ::systime of a system_time_snapshot is known to be
slightly inaccurate because of the way that the reported realtime clock
sawtooths around the *intended* time series, limited by the integer mult
value used to calculate the inter-tick times, and designed to ensure
smoothness and monotonicity for its consumers.

It is particularly inaccurate in a tickless kernel, where ntp_err_mult
is not adjusted on each tick, allowing the reported clock to diverge
from the intended time for a large number of ticks before re-converging.

This appears to be the reason why CONFIG_NTP_PPS is not enabled on
tickless kernels — because at that scale of precision, the realtime
snapshot at the time of the pulse bears little relation to the time the
kernel *actually* believes it to be, thus introducing random errors into
the PPS phase correction.

It would be better for callers of get_device_system_crosststamp() and
ktime_get_snapshot_id() to receive the *accurate* time, not the
sanitized version provided to gettimeofday().

Compute the deviation in snapshot_ntp_error() and add it to the returned
::systime so the snapshot lands on the ideal line. It sums four terms in
ns << NTP_SCALE_SHIFT before converting to signed ns:

  - tk->ntp_error, the deviation as of the last update;
  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued
    since then (cycle_delta is at most a tick on a tickful kernel, but
    many ticks' worth under NO_HZ);
  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
    over the same span;
  - the sub-nanosecond fraction dropped when the read was truncated to
    whole ns (low shift bits, exact despite the multiply overflowing).

The helper uses the timekeeper selected for the requested clock id, so
all NTP-disciplined clocks are corrected, including the AUX clocks (each
has its own NTP instance); only CLOCK_MONOTONIC_RAW is undisciplined and
gets no correction. The residual is then a single clocksource cycle, the
same bound as a tickful kernel.

Note that this *unconditionally* changes the ::systime returned by all
snapshot and cross timestamp consumers (PTP SYS_OFFSET_PRECISE/EXTENDED,
etc.): it is now the ideal NTP-disciplined time rather than the raw
accumulated clock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 include/linux/timekeeper_internal.h |  6 +++
 kernel/time/timekeeping.c           | 70 +++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index fe077d97b5f8..b17f7d54fb4d 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -97,6 +97,11 @@ struct tk_read_base {
  * @ntp_error_shift:		Shift conversion between clock shifted nano seconds and
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @ntp_err_frac:		Fractional part of the per-cycle NTP-ideal mult that the
+ *				integer @mult truncates, as a fraction of 2^32 in
+ *				clock-shifted nanoseconds per cycle. Used to
+ *				extrapolate @ntp_error to an arbitrary cycle count in
+ *				the lockless snapshot readers (ktime_get_snapshot_id).
  * @cs_tick_adj:		Per-second adjustment handed to NTP via ntp_clear()
  *				accounting for the difference between the nominal
  *				NTP interval and the real time taken by the
@@ -187,6 +192,7 @@ struct timekeeper {
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
+	u64			ntp_err_frac;
 	s64			cs_tick_adj;
 	u32			skip_second_overflow;
 	s64			skew_delta;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ea2e6e55f37b..5ef7eb1ab62b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -422,6 +422,7 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 	tk->tkr_mono.mult = clock->mult;
 	tk->tkr_raw.mult = clock->mult;
 	tk->ntp_err_mult = 0;
+	tk->ntp_err_frac = 0;
 	tk->skip_second_overflow = 0;
 	tk->skew_delta = 0;
 
@@ -1230,6 +1231,51 @@ static inline u64 tk_clock_read_snapshot(const struct tk_read_base *tkr,
 	return clock->read(clock);
 }
 
+/*
+ * snapshot_ntp_error - record how far a snapshot's ::systime is from the
+ * ideal NTP-disciplined time at @now, in signed nanoseconds, so a caller
+ * can land exactly on the ideal line by adding it to ::systime.
+ *
+ * The value is summed in ns << NTP_SCALE_SHIFT from four parts:
+ *
+ *  - tk->ntp_error, the deviation accumulated as of the last timekeeping
+ *    update (tkr_mono.cycle_last);
+ *  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued over
+ *    the cycles read since then -- at most a tick on a tickful kernel, but
+ *    potentially many ticks' worth under NO_HZ;
+ *  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
+ *    over the same span;
+ *  - the sub-nanosecond fraction that ::systime dropped when the read was
+ *    truncated to whole ns (the low @shift bits, exact even though the
+ *    multiply overflows).
+ *
+ * CLOCK_MONOTONIC_RAW is not NTP-disciplined and carries no error. Every
+ * other clock id uses its own timekeeper @tk -- including the AUX clocks,
+ * which each have their own NTP instance.
+ */
+static s64 snapshot_ntp_error(const struct timekeeper *tk, clockid_t clock_id,
+			      u64 now)
+{
+	u64 cycle_delta;
+	u32 nes;
+	s64 tmp, err;
+
+	if (clock_id == CLOCK_MONOTONIC_RAW)
+		return 0;
+
+	cycle_delta = (now - tk->tkr_mono.cycle_last) & tk->tkr_mono.mask;
+	nes = tk->ntp_error_shift;
+
+	err = tk->ntp_error;
+	err += ((s64)mul_u64_u64_shr(cycle_delta, tk->ntp_err_frac, 32) -
+		(s64)(cycle_delta * tk->ntp_err_mult)) << nes;
+
+	tmp = (s64)(cycle_delta * tk->tkr_mono.mult + tk->tkr_mono.xtime_nsec);
+	tmp &= (1ULL << tk->tkr_mono.shift) - 1;
+	err += tmp << nes;
+
+	return (err + (1LL << (NTP_SCALE_SHIFT - 1))) >> NTP_SCALE_SHIFT;
+}
 
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
@@ -1253,6 +1299,7 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
 {
 	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
 	u64 nsec_raw, nsec_sys, now;
+	s64 ntp_error;
 	struct timekeeper *tk;
 	struct tk_data *tkd;
 	unsigned int seq;
@@ -1315,10 +1362,12 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
 
 		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
+
+		ntp_error = snapshot_ntp_error(tk, clock_id, now);
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
-	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys);
+	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys) + ntp_error;
 	systime_snapshot->monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*
@@ -1570,6 +1619,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 	ktime_t base_sys, base_raw, *offs;
 	u32 clock_was_set_seq = 0;
 	u64 nsec_sys, nsec_raw;
+	s64 ntp_error;
 	u8 cs_was_changed_seq;
 	unsigned int seq;
 	bool do_interp;
@@ -1636,9 +1686,10 @@ int get_device_system_crosststamp(int (*get_time_fn)
 
 		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
+		ntp_error = snapshot_ntp_error(tk, xtstamp->clock_id, cycles);
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
-	xtstamp->sys_systime = ktime_add_ns(base_sys, nsec_sys);
+	xtstamp->sys_systime = ktime_add_ns(base_sys, nsec_sys) + ntp_error;
 	xtstamp->sys_monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*
@@ -2433,6 +2484,7 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
 	u64 ntp_tl = ntp_tick_length(tk->id);
 	s64 skew = ntp_get_skew_delta(tk->id);
+	u64 dividend;
 	u32 mult;
 
 	/*
@@ -2451,8 +2503,18 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 		 * scale it back up to the full per-tick rate for the mult bias.
 		 */
 		skew *= NTP_INTERVAL_FREQ;
-		mult = div64_u64((tk->ntp_tick + skew) >> tk->ntp_error_shift,
-				 tk->cycle_interval);
+		dividend = (tk->ntp_tick + skew) >> tk->ntp_error_shift;
+		mult = div64_u64(dividend, tk->cycle_interval);
+		/*
+		 * Stash the fractional part of the per-cycle ideal mult that
+		 * the integer @mult discards, scaled by 2^32, in clock-shifted
+		 * ns per cycle. The lockless snapshot readers use it to
+		 * extrapolate @ntp_error forward over the cycles accumulated
+		 * since the last tick (which on a NO_HZ kernel may be many
+		 * ticks' worth).
+		 */
+		dividend -= (u64)mult * tk->cycle_interval;
+		tk->ntp_err_frac = div64_u64(dividend << 32, tk->cycle_interval);
 	}
 
 	/*
-- 
2.55.0

