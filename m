Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857742;
	b=b+d8tBA1VVY40bkk1TMw3L3RlLjeUpqbBXtsdgztUAgDDXlIPspgBBVChyF+KewU4KW6
	 T/WdVPS3muV8rKPx11w3qDJVFdZrTRefXLUC6ZV/q/T5ZI+sSf9KrKVgugnIZ5Ai0m83w
	 O7BpftrteSkg6jFHuKkt30SF9UnEUXb9+s6lqgKZpmUg9vNcOCWWGHzQa+4CaCOcVMA6U
	 Qht7Dx+nC3pVbPnbZGlzA7J3fS6UqityU7ZN9yCptFiqOGKk2KbWFaRZnl4buDap8kXjE
	 C3KOexIGgGOs/hFcfDv/6j9lYSqhbYdfJ4LJf5IpIunkYrnf47TJPYHpJB1yXxAnVjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7vRCSNcyZCs3Byo+z/ZAnwu5XcUvruiiG1cQha9Q2S4=;
	b=10dYEKAuKeUjD5gFHmi/SAVIYJylfAktUO/HfRdP0B3OJ4pOqoguMXlz1ve3sqWIx9s/
	 cIltM/Gw1DH0kP1id/Caah0rpvN6aDkLUDPa/zldkypDT/B/wEBMjrRbSZRXVEODm5mZV
	 Vl0sS9MovIXZ9tmoQAiiBqrWTQ8KJHHeMRx2+S7G8Z5SyL2ZHWmXoRLrGitFm9GGFGNFC
	 wDfKpf1pX2nqHJQhTrXskzo9eVqhWuH0SZgeS7HpHxlhvyMUFdv+AjhVZsBQiyonjCnkC
	 Bl3k1kwGT0zn2M/ZXTYkO4tPYQutgzQ73LhORey4tnR+0n8KKyG3JHCvEE8ExRB2JIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VZvLZAcD;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D3606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4D3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VZvLZAcD
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so141546a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857741; x=1794462541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7vRCSNcyZCs3Byo+z/ZAnwu5XcUvruiiG1cQha9Q2S4=;
        b=VZvLZAcDX/9Zig8n+WP3af6cqSzQ9xFLCzOecmHMvPvnbKelKS6a5KSssA33wAcwKN
         j50Gsh3bUwV1sjj2G+afpF+EDM60oWhRaYs5KbjutXmgsMvk2jhfc1KhsDzksERgp19u
         3NW28rwInhnZH+UvIZF4tJEUtdpw1lPFj8kM8vha7aUQjed0hoVy/xBj240ybYsoAqNo
         Mp83HFdzyU0Apdz3slFknlCMhZOhXXPpEGIdF9G8s3XLHRpIA9dIENA8vtFuiWnaWk+z
         Cx9nKw0tdzy4hzwDa+At7sbQSwkp1Xti+NBUepOyrcvIhlgFvPgODKVIfbTICraghFoj
         69+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857741; x=1794462541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7vRCSNcyZCs3Byo+z/ZAnwu5XcUvruiiG1cQha9Q2S4=;
        b=NfuLlmTfcBdKCl6o3ZsPQkTFZS4mKnj3BaUp+ItmYOlp4UEzKw+iSM0CJ3yEvforI/
         lZM+SynnHRzz6n78T29x+RyR1vMz6oiGDFOF2ojxfyVRdl/jmU055vZyNNf5vxvfhaw8
         l1XjU2IDOz2Z32m8+8CtyKRTpbrPHTbZ/vusj4l1xEUyBd4YHKuw6Rzac/RImgc1S5Fe
         Ql66V/2Ieog/iy78aDbxoDWKYVNccK2yRrV0E3MY2jgAT3HYW6XhEjbmff9C1EubQRze
         p3PAs8ekG3QtQ3m7w9EKqYpieReppUBj7BnK44TXoT9TruUhMKFHFBK+rqXpPwQIt9ix
         ocIg==
X-Forwarded-Encrypted: i=1; AKwUvBxmSddedTd4fRRejnzldm5p3ZqAPgJ8G7hzKBmS6Eh7GCEVgRKbLcblJ/L93dg246L1AHV2Gpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gmvY9Askmi1y6Dye1//vA9zxrZr1EPdJgAvBxbwdauNmk7cDt
	wAoV5TydbbqZJ/BcSIY92TW1fBTY7JdN5AYBtKk/XAA+3Izzg+EKEvkIdhGQYKjXAg==
X-Gm-Gg: AYBFou0Uk+CzRFYdsAI4i6HurYQ+a0hj4dcyKdwG4S5b+uD1J4Z040c/bYTNbc4om/7
	M1mxV8N1padkiswoQs66XJFla0z7nxDdN1o1d0yTn1NahJFMHlufIZVGG6yYEZMUwnNzbSAwOpf
	iKsF/DT0VioakdhGe0aZjEHyUwexM7A0u16TgSaVFctQPMQ5K/WjL6EwKBatcUQfpiBZ3hjKhMI
	+YPePub4ZT5pXqxUue8zuR6I0e/cIFA31OAgTdDzBsSXyL+Q6Z4+Af5IuljEEDRfLRqJ7vYLG+q
	PAJPUk3ufu9pLksIjQajintTNQMUyi1a4tCEZCbSPK9zPwrMF1Fjja5qBMQxEYgSKtC/mxH55cW
	B/0N4gXaBWPw0SNHVYFctuM7HTuDdnnDvth/4fFxcCrLMf9VBLRQhJCLD/z9Fbcb/atVb1N6wfD
	cK2S3SHjxTZeHonmWKqldvIkXC10SHWjXyr2RWPvQmkBGHhgUGtZ0R6PY7KpcALj0m+HljYcYLT
	WRI7/R0Bl8zeRLYvJIFaRi9lON8mCyR04JJ7f/YxyXQEGDU8xNEmf79yAwRavAMoVMCZ5oI307T
	PtmqmWh1PYhViroBzDRmONaBXkKldMqJWgHVYP0OYOJt7AqCVEJMavwUieLkEZLQwkMgOtDrxsB
	SYgIcwMov/SRgqsg4m3qhwT5Fx2Ywbo1PTjaO/rY=
X-Received: by 2002:a17:90b:4486:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b0afbf69a0mr944027a91.8.1793857740594;
        Wed, 04 Nov 2026 21:49:00 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:49:00 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] ptp: add functions to adjust system timestamps
Date: Thu,  5 Nov 2026 12:48:35 +0700
Message-ID: <20261105054839.2248046-3-jjc@jclark.com>
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

Add ptp_adjust_system_prets() and ptp_adjust_system_postts(), which
shift the pre or post system timestamp by a given CLOCK_MONOTONIC_RAW
duration. The selected clock's time is shifted by the duration scaled by
that clock's current frequency relative to CLOCK_MONOTONIC_RAW, with
ktime_scale_raw_ns().

An MDIO bus driver can take system timestamps around the command that
starts a write, and knows how long after that command the write
completes, so it can shift the timestamps to bound the completion of
the write.

Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v2:
- Scale the shift of the selected clock's time by that clock's current
  frequency relative to CLOCK_MONOTONIC_RAW with ktime_scale_raw_ns(),
  in place of adding the CLOCK_MONOTONIC_RAW duration unscaled
- Move before the mdio core patch (was 3/5), which now uses these
  helpers

 include/linux/ptp_clock_kernel.h | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a910595..b952744ff696 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -520,4 +520,59 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_snapshot_id(sts->clockid, &sts->post_sts);
 }
 
+static inline void __ptp_adjust_snapshot(clockid_t clockid,
+					 struct system_time_snapshot *snap,
+					 s64 ns)
+{
+	s64 sys_ns;
+
+	if (!snap->valid)
+		return;
+	if (ns < 0)
+		sys_ns = -(s64)ktime_scale_raw_ns(clockid, -ns);
+	else
+		sys_ns = ktime_scale_raw_ns(clockid, ns);
+	snap->systime = ktime_add_ns(snap->systime, sys_ns);
+	snap->monoraw = ktime_add_ns(snap->monoraw, ns);
+	/* No counter value corresponds to the adjusted times. */
+	snap->cycles = 0;
+	snap->cs_id = CSID_GENERIC;
+	snap->hw_cycles = 0;
+	snap->hw_csid = CSID_GENERIC;
+}
+
+/**
+ * ptp_adjust_system_prets - Shift the lower system timestamp bound
+ * @sts: system timestamps, or NULL
+ * @ns: CLOCK_MONOTONIC_RAW nanoseconds to add
+ *
+ * Add @ns to the CLOCK_MONOTONIC_RAW time of the lower bound, and @ns
+ * scaled by the selected clock's current frequency relative to
+ * CLOCK_MONOTONIC_RAW to its time, and clear its clocksource counter
+ * values.
+ */
+static inline void ptp_adjust_system_prets(struct ptp_system_timestamp *sts,
+					   s64 ns)
+{
+	if (sts)
+		__ptp_adjust_snapshot(sts->clockid, &sts->pre_sts, ns);
+}
+
+/**
+ * ptp_adjust_system_postts - Shift the upper system timestamp bound
+ * @sts: system timestamps, or NULL
+ * @ns: CLOCK_MONOTONIC_RAW nanoseconds to add
+ *
+ * Add @ns to the CLOCK_MONOTONIC_RAW time of the upper bound, and @ns
+ * scaled by the selected clock's current frequency relative to
+ * CLOCK_MONOTONIC_RAW to its time, and clear its clocksource counter
+ * values.
+ */
+static inline void ptp_adjust_system_postts(struct ptp_system_timestamp *sts,
+					    s64 ns)
+{
+	if (sts)
+		__ptp_adjust_snapshot(sts->clockid, &sts->post_sts, ns);
+}
+
 #endif
-- 
2.56.0

