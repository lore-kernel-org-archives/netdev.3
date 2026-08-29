Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E3389116
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991179; cv=none; b=iRUStNRyvF5qV0OZ0FDnfSUTUjwj4Q6vNJ9vMUG8Pf/QA27D6Bi5Te5VDZQNHoHaEkbtkeLYB9qpNeSC36j6yLswlwxPHFYdQ95hvtWM4Hqm2pQYWRte5CIJKyiVkqMNlesfz9nmGm+A9yocjRUmtOJIGsw7pZ1rWpTGOOCqtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991179; c=relaxed/simple;
	bh=VSHjPxoENWOJZWUuZrWj6+G7emdgMSeBRUNJdinfg+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdB//H6s+lW0Kn2c6/E9JGr3fCBMplIVKlM3Cf5vl3vSJTRnceq8PywYovqhjrB12eukGsQKbXx6x8U7+bOGURHrofQI7I9B5cITZAOd241q0sFL76o5hKTTu5+dvV1ONrcaL6afrcPkTvxj63+eWH22RT2Ao2tBPiToTtR0Ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KSXAdVrw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="KSXAdVrw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9391e3b21fbso62334385a.2
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991177; x=1788595977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKR4iq+vEzsRiCk1YHyUdk6oLwqB/fP3JglRMOEMGK4=;
        b=KSXAdVrwlHxX1EVoHa2mAoDBXOQKf7GIsevsDeDoMZeDybjCv/zptyO8HLGk7rOR/U
         JsLkOin+kUxNl51SSBgoioZ2rmgBFJ46pBpdID+4+sWGnpT1cSbQB+Xtl5DHbdAmmXUY
         rrGevO3izboZ+gJaMI9nuWUL+F91hkfki1E0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991177; x=1788595977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKR4iq+vEzsRiCk1YHyUdk6oLwqB/fP3JglRMOEMGK4=;
        b=n6A7H4U3bT7yH7KoXHTSmh9WcMsLi5wkNIqQlbXpeHibu+1eO/ZzFNk1CJYs0Lf2ld
         BGB93qWel5mh0kw9Fk+YvgpgCfbhytnIDtsoIbDi4y3d4DDjtNQT3IWGf7FID2rscaOq
         Fv/TB9klQSqra+CnLWQR08XDLnCZtBgP0B3e9eniAkyMH5z7TZh97SgdwyqqnXLXmti6
         EO3hdnAC8oW2cLLgb7CoIsMGx1ccbexkvhlcEWtrEXq/kDUyNXZH4fieTa5cteq9c2+9
         uIeMZ6ICyqLkOWGNDY9RL2pWcB6ThjGa1KysSpMImF1/6OdAOhO5p24Vt4EWKwV0Qo9Z
         BlOw==
X-Gm-Message-State: AFuF++ld7e8aGugKxg6jv1CV3YbT9RhQKBE26cta9pXafVAfYlUsFXw3
	j9vWdb98Xd2eUKa9CreRZ9jut+QlduCRCsMOZMkzkIVEw4/oSsdwvlNVJNQcwUaAZHU67CYEbDP
	iVLlx3A==
X-Gm-Gg: AR+sD13hFIeaE+Zewi+lTrL5vySi6GY7Pt/SVKDd2VoAcv1eBoa1QiPeDhF8VoEx/NA
	mUMr9t/09F1XwRseF8cPLpvxpec5NRA3RgiCUbJNm+QXIW5aND0vEgkZIY+Ge7MI2NAOUP0nFOe
	dGDuX5dRhYnff//MTLFASBU816/MmzgxJVhduzCyY4R1LHkn9U9IqmmmOyXOljSIIoCz//Z0PXx
	lygzVqpZKrKdh8Slq8IkU0+63cLcErZySIWrGrsMjJJTI45mJbHGToLuzipBy3J6CaSa/8Fbrai
	yYLkXFAV7HO9CUpI9sKwnNYgh5rnghzMiH5NGmaXCqmkGRJXxmV8oyZy7/NLtOBQO3SuMUbRE2G
	m5X8SIq3Tt3NKUAvl17NCLhydvMP2wvWQ/Qevnz3v1WeSk0tNF719AKo0UgRJVsvr+5MyuaUMBo
	Rjnu0s1hhpQgl6oJTbMZS/JMmveuC+M3Iin60+0yu+nF+7kHmA+CyFrDxgau2nP83ciIrb62p97
	5jmJnTH2x2TMKOH3pcj2kK2Meb06RU7mjmor7DasScZAsOCKfPPiuMT0XE8kxmgBnLhc/O4edQp
	Qq8b+XnDcaFzV6TsD+rcsQ51IDU=
X-Received: by 2002:a05:620a:448c:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93913749723mr1297309385a.4.1787991172020;
        Sat, 29 Aug 2026 01:12:52 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 5/8] net/sched: dualpi2: clamp psched_mtu at all call sites
Date: Sat, 29 Aug 2026 04:12:26 -0400
Message-Id: <20260829081229.81708-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dualpi2_calculate_c_protection(), must_drop(), and get_memory_limit()
call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
overflow in the signed multiply for c_protection_init, and 2 *
psched_mtu() wraps in get_memory_limit(). With a crafted size table
qdisc_pkt_len reaches ~2 GiB, causing a soft lockup / denial of service.

Clamp psched_mtu() to [1, 1<<20] at all three call sites.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DUALPI2=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root dualpi2
  tc qdisc change dev dummy0 root dualpi2 stab data 32768 size_log 15 cell_log 0

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_dualpi2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4f678d4ff10e..4947def7c49e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -208,9 +208,11 @@ static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 					   struct dualpi2_sched_data *q, u32 wc)
 {
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+
 	q->c_protection_wc = wc;
 	q->c_protection_wl = MAX_WC - wc;
-	q->c_protection_init = (s32)psched_mtu(qdisc_dev(sch)) *
+	q->c_protection_init = (s32)mtu *
 		((int)q->c_protection_wc - (int)q->c_protection_wl);
 	dualpi2_reset_c_protection(q);
 }
@@ -285,8 +287,9 @@ static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
 	u64 local_l_prob;
 	bool overload;
 	u32 prob;
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
-	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+	if (sch->qstats.backlog < 2 * mtu)
 		return false;
 
 	prob = READ_ONCE(q->pi2_prob);
@@ -712,7 +715,8 @@ static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
 	/* Apply rule of thumb, i.e., doubling the packet length,
 	 * to further include per packet overhead in memory_limit.
 	 */
-	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+	u64 memlim = mul_u32_u32(limit, 2 * clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+						     1, 1 << 20));
 
 	if (upper_32_bits(memlim))
 		return U32_MAX;
-- 
2.43.0

