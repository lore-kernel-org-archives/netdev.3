Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B418C02E
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791780212; cv=none; b=Bvt8YP33mWJDNLD71QS318urWzLLjO6eoCn4t82+aSGitquDjAqi6tzmuXcjZ36KIle3oqVYDCNsA+FypdFEEcdn0ecJwJrmeE7Hrk2rDQS6Qr+eSzdp+OXxsSpFt4tyYXHQ4oK2F9zpNrzrADV13KXyG0wRSFiiZBmO1z7Y4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791780212; c=relaxed/simple;
	bh=LKXcja2ET4DhIT4TQNzA+oCPrkfivus8jlcxBSiY9n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmWdUJofJ1vquN4zbDFdQr4KZWmL/N87XSrTMKLRoB/QN2qe2UXj4jJnuwAC6/ML/GTQgCaOUD4fJovMVPaWJXcVXczke3Qj4U8qYzwSv6tHDuIWhaFD+AmRbVpK5Mh7YEIWBWbH8SNz2vhQHlYszKnfNdrv2aCAmORN8jLJX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m63CuqrA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m63CuqrA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8935f42e8f0so419360b3a.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791780210; x=1792385010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=812oZShsKglP17d2qpRNJ3RXJ3mN2CCzFxSPZnEDsD8=;
        b=m63CuqrAlMKF1Opna25vSx83gmA6AG+gNN6Y8m0VhCXYR4uAdq/VMbNHAhVdfkOyzR
         1atE6qnvenTcvcdmHotP3AjdZTQzkaFtSKSVRiPo2Uv7w3rD4NrMTsCFa8X63DQD49xV
         tzQSGkGkK0PU28RVeDlno6O0FDaVxQcJOLX1wsQn9zREkuNoroiIHezs/8lwnKi40e5Q
         k9u7UgkBe8871tYvRWfFEJ1/nkEUZxO1Ak4EfnCnEdEAn1VVgdkR3DOpnk4fLj6xOtf5
         FI6udHumdkyp+lmE0imw41E/64T8MUvXhzp1odsLGWkzKXLtuf6nMAR8ldrl0fb1Mm/D
         QTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791780210; x=1792385010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=812oZShsKglP17d2qpRNJ3RXJ3mN2CCzFxSPZnEDsD8=;
        b=HClVHI1V83+01KTfcSAwTAZGlKdN05z3jdrKon+UTxB6Ff7G4F9sLM28muxlU3VIXF
         TvGqozY3U/sep8biSlAoNkewqX7rF1Rp8S1lC3yY9GrhYZSTncTXaTYvVyYOSpYUgrSa
         nU9Noxa4TFuRyqFmzjXhiTHsCPHqaM5E9wZM4TPtCaZzbjHUlUkzLbbGVQyZtKeiZVLO
         19EZhW+bGgq7whA5chztzWGfAQDbSqhDC2rDrJ1ZqZK/nLj5NBQ9R0N6Rj+9VT+3xdc/
         5RusjiXtrD9HVPlfZQr+OlIWvLdbjNuVWslnBMHtJn9Bcv5W26k4Ixeh5ZSPz4b40OIu
         netA==
X-Forwarded-Encrypted: i=1; AKwUvBzxXiHw90/DRfYMJq+WpI2njIn/B9aJiI92LLRQGtfBWUI9fDpGLP7dP1PwbZuPtbcjXJNxj0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzLlsQZobY73TDPHe45QljZQhBu4AeQtf/XeQ7e1Tg4TWd7ZCV
	bdOZ/wf0M6WZcFe3naTeBysuKe8Z7l5la5yeDxExYEYpM98N+iPReQMM
X-Gm-Gg: AYBFou3OmgM/pAJJiXQw0uSSvKhlE2vSIOufoqI3sdEwst7Yu4D5cVwKZZiiw97II5n
	Y5MVdR2cWhs+aypmNneXzhP46eyZQxPGs8LTRL8FTjO0fmnKwrjkVZnPvrOIGHiK9Hau2mwCcAm
	UHBt0mhcctLByecQib8N8VOqALHuI94php/dFiN72l1tXa+UCX6BnNOpvEEvaGqNl2ZwnJR/PfV
	eqoJn9zcNa3SKsU2/0JlmFu0+7/ISXZf5uKY9mwpACe6MkYNpjwb8ggZ3URoCR+5h7WaT4SuC8F
	wu/4rbyBhMqf7Z486U+pOTEAFpUe7PfQ0s0ENAOwUJOjc6M59WNU5hkdzEvcNYNQCXcalEHGYTz
	zKDLiYNoNiG7ynsWUlF/Qlia4GmOsTJ80h6mwP2zcYXfYRiCi12B1tEfOctRFPc6zX441E4dFOM
	VbRbuOq5Ij2Amp33m8e0PEo2FjUofeiqrvj/PVM719L1W3r915MT0FYAXYOo6DpRoZSM8=
X-Received: by 2002:a05:6a00:348f:b0:880:a842:baff with SMTP id d2e1a72fcca58-897c79d2d5amr7100175b3a.43.1791780210286;
        Sun, 11 Oct 2026 21:43:30 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3107373sm3326143b3a.9.2026.10.11.21.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:43:28 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH net v2] net/sched: sch_netem: prevent packet length underflow with negative overhead
Date: Mon, 12 Oct 2026 11:43:22 +0700
Message-ID: <20261012044322.503949-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_time_ns() calculates transmission time for netem rate shaping.
It adds q->packet_overhead (signed 32-bit integer) to len (unsigned
64-bit integer).

When userspace configures a negative packet overhead (via
TCA_NETEM_RATE packet_overhead attribute) and an enqueued packet's
length is smaller than the absolute overhead, (s64)len +
q->packet_overhead is non-positive. Because len is u64, the addition
wraps into an astronomical value (~2^64 - 1). When multiplied by
NSEC_PER_SEC and divided by q->rate, the calculated delay spans days,
causing enqueued packets to be frozen in the qdisc indefinitely and
stalling transmission.

A similar underflow can occur in cell length calculation when
(q->cell_size + q->cell_overhead) is non-positive.

Furthermore, computing cell_len in s64 prevents sign corruption if
cell_size >= 0x80000000 or if cell_size + cell_overhead exceeds INT_MAX.
Computing the final transmission time with mul_u64_u64_div_u64() and
clamping to S64_MAX avoids 64-bit multiplication overflow and prevents
the resulting delay from turning negative in s64 delay arithmetic.

Return 0 delay if effective packet length or cell length is non-positive
so that non-positive effective packet lengths experience no rate
throttling rather than freezing transmission.

The issue was discovered via manual code audit of sch_netem.c and
verified on a test VM using 'tc qdisc add dev lo root netem rate 100Mbit
overhead -100', which caused immediate backlog stalls on small packets.

Fixes: 7bc0f28c7a0c ("netem: rate extension")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
Link to v1: https://lore.kernel.org/netdev/20261008035656.330667-1-dungvn2345@gmail.com/

v1 -> v2:
- Calculate cell_len as s64 to avoid sign corruption when cell_size >= 0x80000000 or upon s32 overflow (Sashiko AI review).
- Use mul_u64_u64_div_u64() to prevent u64 multiplication overflow with large cell configurations, and clamp result to S64_MAX to prevent negative s64 delays (Sashiko AI review).
- Reword commit message: remove inaccurate comparisons to sch_cake and sch_tbf; clarify the clamping policy for non-positive effective length (Sashiko AI review).
- Include <linux/math64.h>.

 net/sched/sch_netem.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8a1b89a289d8..3eccdc93c0b6 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -21,6 +21,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
+#include <linux/math64.h>
 
 #include <net/gso.h>
 #include <net/netlink.h>
@@ -366,17 +367,26 @@ static s64 tabledist(s64 mu, s32 sigma,
 
 static u64 packet_time_ns(u64 len, const struct netem_sched_data *q)
 {
+	u64 d;
+
+	if ((s64)len + q->packet_overhead <= 0)
+		return 0;
+
 	len += q->packet_overhead;
 
 	if (q->cell_size) {
 		u32 cells = reciprocal_divide(len, q->cell_size_reciprocal);
+		s64 cell_len = (s64)q->cell_size + q->cell_overhead;
 
 		if (len > cells * q->cell_size)	/* extra cell needed for remainder */
 			cells++;
-		len = cells * (q->cell_size + q->cell_overhead);
+		if (cell_len <= 0)
+			return 0;
+		len = (u64)cells * cell_len;
 	}
 
-	return div64_u64(len * NSEC_PER_SEC, q->rate);
+	d = mul_u64_u64_div_u64(len, NSEC_PER_SEC, q->rate);
+	return min_t(u64, d, S64_MAX);
 }
 
 static void tfifo_reset(struct Qdisc *sch)
-- 
2.43.0

