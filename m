Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801843;
	b=b8BG8PO7q2fFylzOD3AmVffOqQFWTyDky+vXXJe7KbyjsioreXEGK4ELhYLj14DhiKjC
	 xJmIR1h4MDkf9pNaKECzrfSI1qxSEMKU+aAVZf7f99ui+aycEI4o7pgigEe17FQeju4gw
	 JeVN3mf/jB7qbctrh/06t/a8mFCXHmwQsmp1H5T+3wmEixPudzWBEj1UychOCpqxgK21N
	 FGYRFD8lBkSsZrZmK5wjYENYp5uzBw2Zak3DT96Tr/6d9yk7UipJy19roLTCDjjH9X2Or
	 2IBFTCeJ1WUOmpDEqQL6gDeIDPAzFq5p+svkG35I9q700+GHiJ/Tfff+o1iKmiL1Wdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dVHG44+BDIBCBwDY+96Lk7oESZ3fyFBd8Aec92tJSYg=;
	b=CSgBrVcbnJ2P5U97L5YJ5MsdGvx0d0jB02eSTcfFv/YwjNnTzjbU4EU8URKKb2ZxXVPi
	 GY93S2OfKtmYaipBOocVMmr3tKbkQETgle3Ih1GjFYEEjh0rZFiuDZSl7onpvyIzhHTxZ
	 uxuZZlg0VPAF0jL7tyd2Y5EJLWTEuqTeka6bqG7t6yq9ZlTwMyMUE4ir2DWRLkYr82NrJ
	 ebFSubarvqUrwbw/voVBDgIlvrbDt9knlD1GTQzvOYLGhRf3sAIb2YwBSZsZGtG8IssGH
	 mGkVAuzfTZISy17IgMiKF0Kuv/pTqnHD41VYDn16vSrtnJvdGhIGCyBs3MaoMrQsb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToATedU9;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2358606A333
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2358606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToATedU9
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c445c95d553so105550866b.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801841; x=1794406641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVHG44+BDIBCBwDY+96Lk7oESZ3fyFBd8Aec92tJSYg=;
        b=ToATedU9d4AKlw1TrrcSx/rpQqZJKU5ptfLvpNhrtrjFQdMtoINZFG4rPpIrjIXCV+
         IVe/cNotw+557JLtvVZbTeDduv/m5TUx29giIs68Hexdp8hKmIVZFzAkG6cnnXmMGKnf
         08bGt3gEH4AjURa26dm+mGQBohqrWiBHpetP6sNc/DNzeNCypHOPFzKIUyrisurCCHPl
         vHjH/WtGiJ1Ool+HIWLHn3o4WkeGgDTdc64IPQSy8Au7+1HQuWXFKNxns2KxF43YsO58
         lKv725PdTYPVd8HM2W38F4u372nPQh9J3ZI2JnHpTFXvtH9zcaSluEYc8MpQJzzHBkW5
         Burw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801841; x=1794406641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dVHG44+BDIBCBwDY+96Lk7oESZ3fyFBd8Aec92tJSYg=;
        b=tEd6KE2+/RIw0UT8xCcVJBgrRRC0lgDSP4jOyag0JSKL8otLYAozKMhBQwort9GKM/
         f3QOOgW6Sg48G1Z3x6uyUrEms6v4UwTic5PWmRoDOro8x2W0h7oRdCDJJfBCBOEzF7Pv
         VTlNyo8LW7CagfaHXR7Qzdz5a4yBXN1Z3HKZzrg56DxCCQ6gtsqh3eBkU0ufU5uWS+gi
         q4b4KZRhQZcvCvx94LrBJsNuxQRpRCRSiEKNPKV7B8PEP2+7+o1Lkg+uI6prEsMWdD6g
         RnCeTvVjrrgQyrd5QxiNC1bGIjhEIdIdm86lALDn1MUATDiceUdaQKh0mTKYnHhHc3Xv
         IW1A==
X-Forwarded-Encrypted: i=1; AKwUvBzmkPcz6xt5mdtwRC4Yk+2yUGmCTl0tqJ1zKoSoRaqHGD5v6kfvlMExUiOfN7QeA9+3jqJljHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hs9lz5RYB4sxxgwKLyzjiE0pJPqavF2EPEcP3nQlxEXtfwwJ5
	zDjwpUF0G29bv7YuUNgcw8Aaape9RjRT+At7bnNguGByosG+dZZlgBJ5
X-Gm-Gg: AYBFou2rWrndTmOM4wCxRPkZQ1usLpQymVFZwJG7CDfi4E/Dnr0biFMRQobQUJqjrBr
	Po86x6a3E7vBqa8KMRLiTzqaGJP2sK6VxjKJt9VoVKdpoSSzWneVzlomMgaTxueQas6WgjrREkS
	s8D17Mk1m/qF3GPkEXPKF7WaWyHJy5D0ynCgVGsiIM9atApIJhg7A37S+zCT7fIvFprC72z5STM
	mIu5Fas5aMCoZKyzZHpA9QVPpsusVJWmi2eSEHEm72BiF158+lQ8YmRc0u4Zuz2qIOGzzm8I3iS
	UmiiiG9knRyVnjfNhYDREUNyX6yVxLTeT/9rF9n4i8cs0lX4KVQ+7U1TR2ntKhXg42Aa7Xy339n
	dKkOCEy0gkheMPiLRygWuEv/7xkzcmrlOhCjjWXxvyTgMbL4ctS2udsxOVcHL6VPPh5LnLfdBH4
	/lSlwJWUp0yiN43ctl5mG3tfE0hgr09xOc6n9TmbdHsn3Chs9dijmPKQHVvgjRiyZ6mqmyEJl3o
	S287H+HAlEDZCLQMxpd4U7y3m/V91z47xvC5OSglrrYNCOHmqJoGSdVijJju9ew5Km7T0KcWz0d
	py8sFl01xXbUgm4spIwcWNAy9gN9y3zLrS+TV2S7tRwkpm68yszj883Rc8ezKaPmM8a9VQb51Jv
	m4WxfkXswdgfz8bJFS538Y9s2DyEoNZu93HIr3EPWm2nZGsplgY97Cs2Z3D6z4bIepGjD3hGCDc
	d6TvMwpyLVoyQwdVCtKvNe10K6dCheLjI/L7CumFqSOhzHxW6aDqmZYL0fpK/YBdV7Fvj1rNfX7
	Q==
X-Received: by 2002:a17:906:604c:b0:c3f:55e6:83e6 with SMTP id a640c23a62f3a-c4cc399b6f7mr687400066b.15.1793801841000;
        Wed, 04 Nov 2026 06:17:21 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e43e2eesm77311566b.31.2026.11.04.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:17:20 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vedang Patel <vedang.patel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/3] net/sched: taprio: prevent cycle time extension overflow
Date: Wed,  4 Nov 2026 15:17:12 +0100
Message-ID: <20261104141713.355958-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
References: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
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

cycle_time_extension is an unrestricted signed 64-bit netlink value.
should_change_schedules() and get_interval_end_time() add it to an
absolute time without checking for overflow. A positive extension can
therefore wrap the result negative. The schedule handover test then
ignores an extension that should cover the admin base time. The
txtime-assist path can use the same wrapped value as its extended cycle
boundary.

Add one helper that saturates positive overflow at KTIME_MAX and use it
for both sums. Values that do not overflow, including negative
extensions, keep their existing behavior.

Fixes: c25031e99344 ("taprio: Add support for cycle-time-extension")
Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
 - split the overflow handling from the advance_sched() change (Vinicius)
 - use the same helper for the sum in get_interval_end_time()
 - add Acked-by from Vinicius
 - drop the obsolete Assisted-by trailers
 - rebase onto current net/main
v2: https://lore.kernel.org/all/20261009123309.284193-3-krystianmkaniewski@gmail.com/

 net/sched/sch_taprio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2a31b189d654e2..e4c937cf74c10f 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -239,6 +239,18 @@ static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 	return time_elapsed;
 }
 
+/*
+ * Netlink accepts any s64 cycle_time_extension. Saturate positive overflow
+ * so comparisons remain monotonic in end_time.
+ */
+static ktime_t taprio_cycle_ext_end(ktime_t end_time, s64 extension)
+{
+	if (extension > 0 && end_time > KTIME_MAX - extension)
+		return KTIME_MAX;
+
+	return ktime_add_ns(end_time, extension);
+}
+
 static ktime_t get_interval_end_time(struct sched_gate_list *sched,
 				     struct sched_gate_list *admin,
 				     struct sched_entry *entry,
@@ -249,7 +261,8 @@ static ktime_t get_interval_end_time(struct sched_gate_list *sched,
 
 	cycle_end = ktime_add_ns(intv_start, sched->cycle_time - cycle_elapsed);
 	intv_end = ktime_add_ns(intv_start, entry->interval);
-	cycle_ext_end = ktime_add(cycle_end, sched->cycle_time_extension);
+	cycle_ext_end =
+		taprio_cycle_ext_end(cycle_end, sched->cycle_time_extension);
 
 	if (ktime_before(intv_end, cycle_end))
 		return intv_end;
@@ -916,7 +929,8 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
 	 * next schedule base_time, we can extend the current schedule
 	 * for that amount.
 	 */
-	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
+	extension_time = taprio_cycle_ext_end(end_time,
+					      oper->cycle_time_extension);
 
 	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
 	 * how precisely the extension should be made. So after
-- 
2.53.0

