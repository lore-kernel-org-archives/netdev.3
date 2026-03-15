Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9D1DC9B5
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533843; cv=none; b=St6sYY71l7hMghInC5OA6fd6kJtVoJ60dxNi+gfqWvnD1dioIE7rLy0hQbiZEBYZ5LG/oFca0ioedgMIGjtnWRTSHAGbyi/DVmsFmfHTyLn3aU161auwPBZ6FBBSiriAnX2fV2YGF5yPIUaakrJBWQf2RggBOOZvN/hM3STMTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533843; c=relaxed/simple;
	bh=eHbYPcDzZQ6CqzDUkdUz5v9lLY7JBd5pA4aOktWORX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfosy0a4X6qy5V4zs0X8iUhyiWDGoRsfDppelfZSTaBjG3iZjrd5T11fXdWPCgYpLoCGNpkUlzJgxiotKFAImRmGW69C789v5V6dSiZxpHmGO8OjnVvFLGoD3rFcJu3Bi2gyZoqk2TIfGIoqKRYMypXz7g2M+FE25Q+wzb6p9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HZjKD3wl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HZjKD3wl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab46931cf1so32334045ad.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533842; x=1774138642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73xAbuxG/uII9sfTtBiEpE7DCBkz1KEUICpSXRtxYnM=;
        b=HZjKD3wlcwE3S1Ij88+51P2rOJ9+sDlThqU1ioHBH8ddHxzikyEthoQKsA1n5KzZse
         l8N8XQaVTjUXVEG19pBn5pnNHJk7oXpo0AUF0dn0Y2TBMOTFzjHc8sl6f54EjO4Uhlwk
         HfvktG573/4TtrNH+9e195l3RrctROafU/bhgLt8ZI+MPaGe28BjOpXhiN9TraNgzmZt
         8JmmhpKiWYCU2/N+FMhjQTGhXTCKySwAlmtkahDt79F656HBnth+bcYRqYuLFuFY8MBe
         lLOcagbVPDFUdQ0G7BX9OozcSu/h55K3fdEjcXAuBTIW+LbNWtcORJfzyUuEc7mXxLtl
         wKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533842; x=1774138642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73xAbuxG/uII9sfTtBiEpE7DCBkz1KEUICpSXRtxYnM=;
        b=ko54QKlui+RY3ygdvhie2orHEFbAAaazfb6E9yhzgYvy7G67CGG46vAlxLgiYQcaVX
         lwqyHwO7iMKBh/TgHBKjFQI0xWbyMYp2EXUNhVmCnqT6rjVPNrHWaYxV1BJdTl9oG2EZ
         lT1xdEZS40Mzt999W1x9F23ZlmWEExXKniE1/mvrYnN/SRk7mi3mazMRzs243Vf2xO8y
         6o8e1Ir+3ei+Eh+KHqzvmHpO1bKIBa4hoEGlHNRvkllBuJ+ORPkkSGbK6SJqEYnxHv6U
         cyl9ecsxnsyiYuwrq3nwXVGmTTkO/OltQeaZB+74QHkGvMVbyLNn0kJDcDiQYOK7Y7O5
         HZYg==
X-Gm-Message-State: AOJu0YwS+ALzW9ZOdAwKT3NqY9pLPdLY3xeGoNIFLcKmNU9AC8U/F9CZ
	jPhD25Y8MFbaN7pSR8nqXRJZyN5AflXJTglh+7iuf4huE72bRb8xUuk2eF2+azxmUa26/9IwzXg
	RjHkf
X-Gm-Gg: ATEYQzwkmcSwNMG9Ufy40re45cVtLcOHo8APAbO+yhj8SrtNbAIpfXtC93QhmrM7lOc
	fTNJPYLFzgHpy2v2swaZsp0su1O/xDr3yJvlIHNOzAi50c2HilgZZcIFhkZFlQxKBVPlt+M9FOE
	J0qe4sjJVdOAf6AlNVkPx14sjUyUGObBTrOAUGUoRs3YvjqjCk9HViuwxmxwtTodvrbSEzTvNQu
	nqUMSGWf5Erj6+breJBk2smdtIFbaKBNCNWtsCU8hUGNN/JphWtSexmS4QHgBAFDu/fEs+u1Lmj
	IcThxZxn97XWYkLseotNBlSQ6kD6aM2X4LbvkSptmExGzpvSTrrQT6fxe+z+qFFwdJdfPJuNj1q
	Jm+D8UHRxL2f3Ib0QTqdMjnW1msJ0MDYd17Jqw4Ls1g45ehg3iunkGT3R4NpJ2stpMKWPcpca0t
	pQxu98HBL8i8PASfnUynxkokrZcpcqclpL
X-Received: by 2002:a17:902:da81:b0:2b0:4c68:283a with SMTP id d9443c01a7336-2b04c6829b2mr15025575ad.6.1773533841942;
        Sat, 14 Mar 2026 17:17:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 09/10] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Sat, 14 Mar 2026 17:14:13 -0700
Message-ID: <20260315001649.23931-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
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
index 3bed25f494d3..46f57828ee1c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1123,11 +1123,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1150,6 +1149,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.51.0

