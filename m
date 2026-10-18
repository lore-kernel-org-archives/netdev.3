Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070C375F96
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317797; cv=none; b=izuitchN3nxfYPbIpvprS0cD+VRvq+5etvPAdM1b8ZxPmRNIEvOh9nCzijfxJcUDWB8UWQVTjkn529E6zO390ONMe9RXuAiXO5IyQfTwasNwqKxBkDi3AeFnpIN9u/+O2ROej/8S1BotAhbG+dqPZ0zpl2B0uxjYs6fzsJckoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317797; c=relaxed/simple;
	bh=vgAyd9GaSXl8QbUYbc/a1X7y9DhwXmGdqyGYcx2BTMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8X3NWEgGz/MQa0Z202lNdkX9Xpz1xbc8jXXSJDsL8VRWEJjrb8RZpMDLk8WbSqOZTS6jnX7LtRjXEVGPQ95QTU6bOdt3z7ncqg4FPCaIty85ZRClbGsvIC4WLCcAmCQgHAMOom7WnvA+/N4WkMqybb+56krGlDFYCuHpjo0wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=zhHPHorQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="zhHPHorQ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so495849a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792317794; x=1792922594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+pUD2Xt7aup55uhYgrfN0bj0bISovEsxBN86KGoLUs=;
        b=zhHPHorQfu8QARjQNQzhV1MJHr75yqCMEeT/zbZUN8T9eKz+Nux7e4F0qtpNbIl70a
         0E90gwN33jxn9qEjCPTAyDbwnOQXJ2SQTpeZ9Ai0xL9/FdFlCKUrEVqgmm6aWMY1jo+C
         3C/kKA+fA7nC41FAGr0VDn7vDNAO263y5ZtrFjp4+DOJqUxk+grIQeOt0/6EpipfydiI
         LCsvctZ4RMKEUTj3ymimvedx2vVEgKs06Ho/3BMW6SWlLU/a5WCo9ZlOwkSddg1RJp85
         QzmTw1Wx8GN9NXuE3jrZu0wz8EhkEZJlkjSgsqfkLoRbA14WHopbWtrzGZ6Df6d157og
         jGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792317794; x=1792922594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+pUD2Xt7aup55uhYgrfN0bj0bISovEsxBN86KGoLUs=;
        b=2ilMHzIlUeMSJg+5TSuEufue+1V7ejGENrPiZs31UmImG1IdXpOHwAxvRxxJX3coli
         L549aFALxmKkcT+YVAmRfahOQDCo47X4kEt++ZBPW6OPuXjwmpcjMAFPxWlZFIXllS/2
         T3QhD+zzv26YsQPC7Zh/zO7lfrvP0GyCh8KvMHmajwHBesOVP1xVXc1F6zGcIe8c0DKE
         TpT9Nzse+5jEa+hATCYQNjdcV4O0Qfl/k4Fl3t/BJGZQP+mPwKzY4555xuD5UOG0inbf
         321DOafBPSsABqP0WFZmmEMJIV+4re159iSsIuh0Sdw0HzX7NkaTuKE1QrENDKoi9fA9
         VtTw==
X-Forwarded-Encrypted: i=1; AKwUvBxvKKfgL9p3Tri2OK6ynkXme4TE4RsQ6tmxt7by66KnLsPvPWn4rG7txSbxUt+b40RT6p9xnvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZKEoVJ6KRMUISzHr3jkGTn/HnkzpPyz7zfCuwsApPBoI9IJbn
	OPc2WViA3GgFZv7XVDbi10xMUAj7/Q0eOuuwUEp8Pf2pSj2FlBG6BKQ0JigCR9b3Fg==
X-Gm-Gg: AYBFou19vZggpagRsdGhtuot2pyrLQQtxqAlF9wT1DuTWfT2KAlzPkjJh32g6XuypdE
	sCRKZNCNzdUOdCHbTPGds0DisQgvg3DmQIoIQbXf+0r2onXAcEuYZwgV0Kgq6SJbK56D1LlvNXZ
	3UFU13ATofo76PpbCSSxkDYKZ1AizBVcD6ZZ0GhlqIvGorZu96p1GluM5ZZVCw4rCDg5ifHh47H
	y5qEf5O8TUyUlnrKvQE+9X876B0pqihVHmX2KWr4Xlq6wVv366p/Z3FO9PgcTIuRuQS0awtHeTj
	TfNHRhR/3g+HJP8p30KxZ4V5t1XHqMt/DEx1ZPFOmZxJdF5gOJBKf0Ip0CPwfLUHF1SHqetoRd6
	d5Sp1sWbYLuao3H4Ix7jH1WAbpQ2TK1ZCbmzaDqhSmv5vPkFXUV2pm3oOVGfsGQvVOlS7g+28HF
	LY+aDdBJcrpG16isj06BgM3FZT1spl+vX/nh2SOzy7GHKY/IlUIgUEwiVVkU9VZMzBgURZ4+o1L
	KKBHw4Mk6D6amI3e58Y6BT5ZctXtiOMHYJZ0IrSSPmUvi/vugrg8TN6Pee3q58=
X-Received: by 2002:a17:90b:5610:b0:3ab:189b:6985 with SMTP id 98e67ed59e1d1-3acef4fb852mr3589015a91.35.1792317794454;
        Sun, 18 Oct 2026 03:03:14 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm16101210a91.0.2026.10.18.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:03:13 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Hubert Feurstein <h.feurstein@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/6] timekeeping: add ktime_scale_raw_ns()
Date: Sun, 18 Oct 2026 17:02:52 +0700
Message-ID: <20261018100257.566267-2-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018100257.566267-1-jjc@jclark.com>
References: <20261018100257.566267-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ktime_scale_raw_ns(), which scales a duration in monotonic raw
time by the frequency of a given clock relative to monotonic raw.

A PTP driver that takes a ktime_get_snapshot_id() snapshot around a
hardware access may know how long after the snapshot, in monotonic raw
time, the hardware event happened. To shift the snapshot's time of the
selected clock by the same interval, the duration has to be scaled by
that clock's frequency relative to monotonic raw.

Scale by tkr_mono.mult / tkr_raw.mult of the clock's timekeeper, as
adjust_historical_crosststamp() does. For an AUX clock this is the AUX
clock's own timekeeper.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
Changes in v2:
- New patch, used by the ptp helpers in the next patch

 include/linux/timekeeping.h |  6 +++++
 kernel/time/timekeeping.c   | 54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index efa9442aaee..c3737aa844f 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -366,6 +366,12 @@ extern int get_device_system_crosststamp(
  */
 extern void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot);
 
+/*
+ * Scale a monotonic raw duration by the frequency of a given clock
+ * relative to monotonic raw.
+ */
+extern u64 ktime_scale_raw_ns(clockid_t clock_id, u64 ns);
+
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ea2e6e55f37..3f8592bac96 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1332,6 +1332,60 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
 }
 EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
 
+/**
+ * ktime_scale_raw_ns - Scale a monotonic raw duration by a clock's frequency
+ * @clock_id:	The clock ID whose frequency to scale by
+ * @ns:		Duration in nanoseconds of the monotonic raw clock related
+ *		to @clock_id
+ *
+ * Multiply a duration measured in monotonic raw time by the current
+ * frequency of @clock_id relative to monotonic raw.
+ *
+ * Return: @ns scaled by the frequency of @clock_id relative to monotonic
+ * raw. @ns unchanged for CLOCK_MONOTONIC_RAW, or if @clock_id is an AUX
+ * clock that is not enabled.
+ */
+u64 ktime_scale_raw_ns(clockid_t clock_id, u64 ns)
+{
+	u32 mult_sys, mult_raw;
+	struct timekeeper *tk;
+	struct tk_data *tkd;
+	unsigned int seq;
+
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_BOOTTIME:
+		tkd = &tk_core;
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		return ns;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		tkd = aux_get_tk_data(clock_id);
+		if (!tkd)
+			return ns;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return ns;
+	}
+
+	tk = &tkd->timekeeper;
+
+	do {
+		seq = read_seqcount_begin(&tkd->seq);
+
+		if (!tk->clock_valid)
+			return ns;
+
+		mult_sys = tk->tkr_mono.mult;
+		mult_raw = tk->tkr_raw.mult;
+	} while (read_seqcount_retry(&tkd->seq, seq));
+
+	return mul_u64_u32_div(ns, mult_sys, mult_raw);
+}
+EXPORT_SYMBOL_GPL(ktime_scale_raw_ns);
+
 /* Scale base by mult/div checking for overflow */
 static int scale64_check_overflow(u64 mult, u64 div, u64 *base)
 {
-- 
2.56.0

