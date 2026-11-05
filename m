Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857736;
	b=wHqCC14asTmnE6CEyCIiHvPpZkm9omzT5MYhhBrzb5ajqLHwELp8ZUGWG+8PH4P7wf5L
	 CtHECNAfJxkDwI2GOxW6p6SIYgTU5jO7oicJQQiJoBHDzUlcV0HD+gxo+S0B5b0Wm7XXZ
	 FT2Ku8EBizdxnxhOqfSn1Y0tXGhJNYPzXuy+f1eSPTNqbcFEKl2Y5dKEw3UDoeb0lOoZM
	 bHos6sU+ldkoByGM0ltHf8f/djQHED7yQVH1OCvx0GLpZK64VQdgRnTHBWqsYEhcC3vda
	 MGihusxhdK4TtaQ17zxdBJZudR5OZygmJQdRFckLBWwtqL4roeqOc0xfXW8G11YsTFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/tLj2CYL+xeFoB/kDteydYBzhpIqHWBZsG7xgIdv21w=;
	b=3WkM7pW2rnB4UGF4uJE/3g0HCV3QbCOcapJg/wrSPQYu29425WMQYsJpScVC75hiXAhF
	 pC9SkB3G9BlV5nehfNcShOqlMG9LNceEd6xUrn6cnnqpMj7lpgD2T9sB/5R7dFhKF1Qs1
	 6yCCoPnrIc+1FUVYNoczSzKoaTH9egTcavjw4hzwqVXGZbsC41b4IrtrVhQzbUvvY2zrV
	 hpvOnLe9eyqzvasuh4eeSSZvfb3M1LzauVFanMH01EDAoyIOfKEXCHo05fxK9yprFaKaY
	 kZ58kb5+pluUlg8Nyj+/hYkCklNBVegnaQ3DKzTpPlFWeyAjFZacsys7kv84Errw40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hwQcSTB1;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF9606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FF9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hwQcSTB1
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so966318a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857734; x=1794462534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/tLj2CYL+xeFoB/kDteydYBzhpIqHWBZsG7xgIdv21w=;
        b=hwQcSTB1rtvVSsJLuT5CEar20rpGeR11znLLq/8YGPN+em4gayJ5i8tJGd+z3PzTaT
         VJwbrWgZRcFsGpYhTN1I5ZcN3Xnlv7DLr9/qnboc7riIvUyvtKGIfsqLlbly85galEJy
         N8aW3KLi5qbMK4baEwzLU+hCIyj4fPPfXmD0NF6Fj+7K6fsv2+5J71rm8lDFIo3iAtJ9
         LzFBdTi9DX51vs9FJ0IpLuriTPCo68E30aE4JUo3c+JYgpMLRzRTN4hY07gk1IFYSS7p
         z2OS8uVrIRx2xZI2iYqFWcvQgGZJU2hJIQ/TsllEi+Dehg8/QL55Ja58ivX6FBTeOOAO
         AZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857734; x=1794462534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/tLj2CYL+xeFoB/kDteydYBzhpIqHWBZsG7xgIdv21w=;
        b=B+M1NGF8OUQsHl+yBz53KvVCfB3PxBWu5n6a0diNHVYovPfOB18EB1lnl7pSuLwLFE
         NFUIvGVD4ZNZ+NFijaa6FyUr8KQ8JTvdtbApaBnVFbPzdBad34VKQDgE5XnkbUB4tVNA
         cFJ+ovXYoBqbToyDnkQKPBSqjlHIcxhtdsgr4gC4UF8K7wcQoqNB0Lh9CiVkbqTiocc3
         qJxnY89q1e2JZDSiJYx3JauT40NZ7NYEgR97wuTcnEWZrJ7Mk40SZrmTMyVtJC/wnmS0
         Q04hlYhK3f+ktAcAqyXPolgy18t6rroo/EVzOaYvVEbR/JRdzktMcJmc5bR3AAfufcHf
         fUAg==
X-Forwarded-Encrypted: i=1; AKwUvBytYRd+nQfCwnIpxcGdcdPeDYuui7KZ72d3Wz56t6W3K3WqFPgNpKg+sgVLaEDGfUYnCjXM8Fw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xqYWJyt+7tmrO4SDWnjFQrOAPIM9FzzAWbjKkgmN7wy68sby8
	kxXa/89WESYCBHiS1JQ+SYzKGmooD2VFOX7ypwFKD1V3qvwK4lVCH2Yp1ssVXA//aQ==
X-Gm-Gg: AYBFou1cVcronHu/vjut+IbS9Ga8gU6hC5Mi4O9UDuyG+R64UbHNmxcuvU2JI2iXdTX
	HRaVe68PqxuAvjvz4WTGuyl2qIxxD4n7Sefhg3Sy71q9oursUJA3ExBtxfBFDAzImLWtc6K4la1
	n9yC5DYhaIYunQCAQIg2PeLKuz6wVU1GilVaOeMLosXeVaKUr7L+8jMjqAAQncjVNqthV05KLKP
	VCCQtV0DOesdEy87GOLNvLwywVQOKmDuQBAv8LTCSz5P27PSRa7AjFvFQv82NhxTOdgN+Td3XFL
	owuQkPSorbeO3+z9qfbsgZUFikKQobsh+5N5ZTqWW37cRutt79MKJ+AdGJNTNbZ1eTm0cGsMImX
	7mqc8XjJsNvYMC96GOh0fMoVo7mZeklHZuHISZeiLPlJIj+THZ7mk7yTaPXJgQB+6jYW01euBHW
	nc9I6LivRPNeD7wjD0t6L5OuaTaUoW+SklB2EEyd29/KjptFv3zdZrE3GwUjLMJVEOmU6Zl2wQW
	1Isu5yyI1IJt+GEsmOsna16Xfu7SNoTFEnFBu15eST7XvxeWfinC/LmV3ulAzlB6RmmOAjYzUjP
	NDw83Czznn4RaJLGsMF1FhRsufg0/jB6F2su23YCPNZQyshNzTztWQ0hkvELLVizRomFk2QWrWS
	a9XSYOb7Xmxn1YaLeW1PcBSRgskLpVJVqUufRDH4=
X-Received: by 2002:a17:90b:57cb:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3ae897f6192mr15189506a91.26.1793857734239;
        Wed, 04 Nov 2026 21:48:54 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:48:53 -0800 (PST)
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
Subject: [PATCH net-next v3 1/6] timekeeping: add ktime_scale_raw_ns()
Date: Thu,  5 Nov 2026 12:48:34 +0700
Message-ID: <20261105054839.2248046-2-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105054839.2248046-1-jjc@jclark.com>
References: <20261105054839.2248046-1-jjc@jclark.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
---
Changes in v2:
- New patch, used by the ptp helpers in the next patch

 include/linux/timekeeping.h |  6 +++++
 kernel/time/timekeeping.c   | 54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index efa9442aaeef..c3737aa844f8 100644
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
index dcf47f1ffdcf..a6e2d2b8642a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1335,6 +1335,60 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
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

