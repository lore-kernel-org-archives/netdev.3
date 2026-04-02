Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7D38A28F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161264; cv=none; b=IppJhzIC1LcAKyKfjNlU6EHm345Cm6Ohx81pZxGTUxGFIkt1j/DLmNIU1mrI3LpNcNki7y8ZXzTvj73rNNPaQco0ut3CUZ8tnFR8bR5Iir0vsxFyUCOJrxK/0dMRx1aBH5L8jQtSNRmJI2i3CED6E2e5Uo1DOaXbq/7D/RqiMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161264; c=relaxed/simple;
	bh=QEc83gOcHEYQydd7I6uVggZjNO4Lkb66/e/DNtQZGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIcyPtVDto+Inz9rxWTe88EZvC3lJWIllxP/+oeiHG3rHxbpjPUvn/lYjoFovsPqZY1uRHs83bY65mKc7cHh5Ybd04FNG0I64A6dzqItkCXDGxIaULxfPTG6iexOrpyeOX5sBMnw0E70w3PfSfOfG7y3e1P/nRQv6ibpBxk7GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oXV56H3U; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oXV56H3U"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so816658a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161263; x=1775766063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJCIzIhUYAY+FwghoNlKo9w3r/39Qk2OPMc1dIVyiPw=;
        b=oXV56H3UnWOC675glssMDgJPlOOZWf4/aNRgFd9zc0HkyGdMXxviRUolw4Wxr25Ovz
         /vhVjsmmpcEl5k80ddMstcEiA2bt83onNMDjfJjJ8yHMwu/ZgN8FqNbXNn2wpEVk1qjF
         orJDbR2XKGGdso0xcEktauWh/YEAPnWOnuDZYVHa40e/zkxI/WaVHWc3un3wnEeP1pFh
         d4nlhr++q84lg/M0TKlb6RrA9OXUjIzVqO2wRFOYjRpTZ4ma+Ih1dmrTt3Zl2bJEhw7s
         I8KIJReAVC+8fAznl9F9zb2L2QtchP9vD8+xyvg7BtOaIQSzVKh+PwoP7pDerpTJI3M6
         s6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161263; x=1775766063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJCIzIhUYAY+FwghoNlKo9w3r/39Qk2OPMc1dIVyiPw=;
        b=Co+SH3+aaoMjZlLahSH9fulFfDJUu0aZpiMkiECPy7feYDqgMQgP9EqEpIEAaTN4W2
         0aS5Sz/QOWwhrdM/BDBmthPY2EKDKyqiYamDqBPeTj4/DWDlzLZzQDugvBlgf+7+EH6G
         K4G0xbClvNhLqp/mESJTQBMlwXNe2bsW7Lj5KrYDI4M876s95vw5fTdzu7KZTSSYXhzY
         8yrQMw8KRCl5OmcamjK25PrxosXCjqdHZUVS4iqLbbQBNL7SYAte0FebU0BSE+uQK3Qt
         I5fQLtpjKswNJpbvAVRowXjstgXr2zfYjiX3mJoi2Vsw4sviGTNQ346ezh3rk3MWYzVg
         KYxg==
X-Gm-Message-State: AOJu0YyY9Ugp+ZltQI5J+Oae0QWuwKLzCfUoS+sqFBekA3laVP0dgjhW
	Lw2vKiR3MdHXc4SGBa7qdbgHbGfUiRZj7TphAlQhbKCyEhm0WbqQYLhkDb6pd44s9aHV3Ngtdxv
	TYO8C
X-Gm-Gg: ATEYQzxj1qRTpXHtrqakZf1jaVML/lsZ5Z0nz3y+IdCRhPZeNlWXXf4THucSro3ppCA
	VykpFgtoKxf+Wc+Z8Po8X4YFnr5BUd79YYgjhzZUJab7H7BOVJW3k9EV1X42SX+w23oXAEoZn33
	4kf2/6dkjRK2aTw8fbd+LnYTzxvaatWtJ49XWRLvW3ThOZbZxoeUmTIjcbsaboiaShm6zQ1AJUV
	/GOlAhbaPXNIn9C/fMaL8Hjwkx1+7ymRZhZXGLOaREYXga6GJwjATkDxC1A31xSozYabdyTIlKX
	GGMJoSeCabZNhTHeVf4LYOGk6Q7LLKQ8sbSrwJ3pF6rIgcgjx8W98XZm5rbEYU910IZYeHtQFkm
	I+m8Kn0f8Dh7qr/VaTdzathS3lOhfeWyAFVViubZHQ9HY10KvPr3EfUGvbgx6T95v5w5Y4hq3Sa
	uzAnCECksb5YRXfG+FjsxGvt3zLH3LA1TH
X-Received: by 2002:a05:6a20:12c5:b0:39b:d9f1:6d00 with SMTP id adf61e73a8af0-39f2f0bb4fcmr286147637.43.1775161262814;
        Thu, 02 Apr 2026 13:21:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 3/7] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Thu,  2 Apr 2026 13:19:31 -0700
Message-ID: <20260402202037.176299-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netem_change() unconditionally reseeds the PRNG on every tc change
command. If TCA_NETEM_PRNG_SEED is not specified, a new random seed
is generated, destroying reproducibility for users who set a
deterministic seed on a previous change.

Move the initial random seed generation to netem_init() and only
reseed in netem_change() when TCA_NETEM_PRNG_SEED is explicitly
provided by the user.

Fixes: 4072d97ddc44 ("netem: add prng attribute to netem_sched_data")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d400a730eadd..556f9747f0e7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1112,11 +1112,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
-	if (tb[TCA_NETEM_PRNG_SEED])
+	if (tb[TCA_NETEM_PRNG_SEED]) {
 		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
-	else
-		q->prng.seed = get_random_u64();
-	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+		prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+	}
 
 unlock:
 	sch_tree_unlock(sch);
@@ -1139,6 +1138,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.53.0

