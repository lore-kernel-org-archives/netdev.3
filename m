Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2E4E433E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556536; cv=none; b=m9nZFPEjwyhxKZhNpszRvT36de8vrr2HnKk8QEI4W+yRkvGnZsx8EAgA9bcEv8xvRzvPDZisUBPNwXYNZ+Roo586VXtxlzefA93PkQ5H2nju0kjcA9o4ami193glqXxcA7pGAF+9MRuOy22Z3HfjKjH4j7I5fM2aNXWkTahhzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556536; c=relaxed/simple;
	bh=J2f0V/EClIlA2WPD8b6oppOrlSzeIDKH7aeM7FWVeOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIFomIcSNJkhiK9BAwKdP1Q+sav6rh2/MXxPxvpN1b0Efmcu9vXIoJd/5CAOKVmKvChL8rslCnWbe61TvaRyWuxzC4xYXdb/q5cszmfMiIy2ROljXXfqvq4Oq/K7wNBnVmbJXSz3SOdozCf1/0LnGQkWGHBVn0pbrSlO/665pe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=IN/6/uqB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="IN/6/uqB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-535853983f0so23078581cf.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556533; x=1792161333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGO0sAofaphg39YrktW71GdT2lnvXlH+hJNivXpF8AA=;
        b=IN/6/uqBDZ21rPSNcC0Ix2/4Lm+ee94Y2m/BSeeZnGiAi3YptWzJyrRPuROpBMaMkm
         QED1KBe+I9I1ub6foKtxtr3XHXM9NqBfQfulfsxXNUX2x8qw90bo9s9YfW81JVMPHwvd
         joI0PTAwdA2O9KZ0hgCY1bDSm5Tl2hLEajuP6p0lswavgjJwfqSvs9jbCuOvZYSVBTfe
         YgL5eg4STzYmZvCCj3BEg520VI+qlFTaMYsRSBC8eVSjk7o0Xsj1rqQGjTud+dmLUFk4
         KOJvAnc5Cl2dYPP7XzSMUU1kjj6LU5HGRalLTtpFpzBa+Dpaao5+4tOkcagL1da9KOrb
         5u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556533; x=1792161333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGO0sAofaphg39YrktW71GdT2lnvXlH+hJNivXpF8AA=;
        b=j084ep96KLbcLfW4hvc4wkaCV0kJIQzk/rkK2Np1SRIeWgdUQgqcm3aFgIGlmrLE18
         5dg90JiqyeGbgN1Dmr/5KhiOQ/0KpTO/2nTMWsVMIfvZflC+3FQb5uTrN3dRGNxhxw9f
         DR3v/sOTX+JdcuJDPvbqLPKu69Iru71KcoXZdg6eS789zTXrADsZ1AuL0m5XfQ8w3Qzu
         R/6m2XdJm4VacDSrjTzr8ouZfzS6iOpG3iqUpmrbdZU3wVpvrDOEVxBniUgNq63qxuXj
         WVIfYQEAI3USx0ULhThqdBi8kCyZ+C4eEHRha8le0coWbd6V2gn1cs9wv6brYWfj4OtJ
         ReKw==
X-Forwarded-Encrypted: i=1; AKwUvBzLS+iCQEb6gzYX47cN3IRIxz0PzKaIM0FbdvrkDjKDJJ7Ueq1FOU2eUES1fSGox3+cGOyU1Q4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4FW9JNgyzHesEFYDRJFk8JVCRq0vUg8UagMrBEY8ripmwB+D3
	CECZv44qzY4HzxqGyFR1YW+PrSEj83a8MFhaley1ZrtB7jjyam+xKLcK8r7SOyCwMg==
X-Gm-Gg: AYBFou1nJ0tYHgR5rlYj4iZikKP+HSs7clanA495asE9CRvNfRy1fEnprRmstJ/3uLV
	cO0V5wD1JrJS1jLmiJHkKgxEDKkT2Arhk7mLZWQCaipQR/5uk8U/bLxXRilI8cjScBIggXf2Cjm
	J1H4Un+VhNaoXpn9tovrYi60zOOCCDhIGMal/cFbi2LfXyppWbWTXQWQwhUxyPGF9H973a0wF0k
	6pXysOWX+rKeAC0jpsxbCt8L4QxDTjB4JxvhboNmnCWqtVIh8oOcCNwuYZCGlKzZnDRNvscbCnz
	JvJU9XCm6QXScQGie2pii/tlStDDs2oPYq5Za4lvolmlRX/JTqxYuL1B0RubZIfgGWsYA8/rLut
	JC6pNpkAaB/1KAML7VGRjhT3cNmGHK9jZOO9/kO2ajOZHmXU6NAhI8n5/dtj+Z9Yzh17rOPyxlv
	LKVfVT6wPBbTiMPiSPn6kR7nXJErUA5GaYce9ac8lIXaj1xHVtBzi8g43R43tV
X-Received: by 2002:ac8:5f85:0:b0:535:80b:9900 with SMTP id d75a77b69052e-5359fb8687emr27949971cf.44.1791556532778;
        Fri, 09 Oct 2026 07:35:32 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:32 -0700 (PDT)
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
Cc: Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] ptp: add functions to adjust system timestamps
Date: Fri,  9 Oct 2026 21:35:04 +0700
Message-ID: <20261009143506.2507607-4-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009143506.2507607-1-jjc@jclark.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ptp_adjust_system_prets() and ptp_adjust_system_postts(), which
shift the pre or post system timestamp by a given duration.

An MDIO bus driver can take system timestamps around the command that
starts a write, and knows how long after that command the write
completes, so it can shift the timestamps to bound the completion of
the write.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
The time of the selected clock is moved by the CLOCK_MONOTONIC_RAW
duration without scaling it for that clock's frequency correction,
because timekeeping has no interface for that. While the clock is
synchronized the error is negligible: under 2 ns for a 50 ppm
correction over the 30 us MDIO write time in this series. It is larger
only while the clock is being slewed. An interface along these lines
would allow it to be done properly:

	/* Scale a CLOCK_MONOTONIC_RAW duration to the rate of @clock_id */
	u64 ktime_scale_raw_ns(clockid_t clock_id, u64 ns);

 include/linux/ptp_clock_kernel.h | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a91059..b4ac64228f1 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -520,4 +520,52 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_snapshot_id(sts->clockid, &sts->post_sts);
 }
 
+static inline void __ptp_adjust_snapshot(struct system_time_snapshot *snap,
+					 s64 ns)
+{
+	if (!snap->valid)
+		return;
+	snap->systime = ktime_add_ns(snap->systime, ns);
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
+ * Add @ns to the selected clock's time and to the CLOCK_MONOTONIC_RAW
+ * time of the lower bound, and clear its clocksource counter values.
+ * @ns is not scaled for the selected clock's frequency correction, so
+ * the bound is off by @ns times that correction.
+ */
+static inline void ptp_adjust_system_prets(struct ptp_system_timestamp *sts,
+					   s64 ns)
+{
+	if (sts)
+		__ptp_adjust_snapshot(&sts->pre_sts, ns);
+}
+
+/**
+ * ptp_adjust_system_postts - Shift the upper system timestamp bound
+ * @sts: system timestamps, or NULL
+ * @ns: CLOCK_MONOTONIC_RAW nanoseconds to add
+ *
+ * Add @ns to the selected clock's time and to the CLOCK_MONOTONIC_RAW
+ * time of the upper bound, and clear its clocksource counter values.
+ * @ns is not scaled for the selected clock's frequency correction, so
+ * the bound is off by @ns times that correction.
+ */
+static inline void ptp_adjust_system_postts(struct ptp_system_timestamp *sts,
+					    s64 ns)
+{
+	if (sts)
+		__ptp_adjust_snapshot(&sts->post_sts, ns);
+}
+
 #endif
-- 
2.56.0

