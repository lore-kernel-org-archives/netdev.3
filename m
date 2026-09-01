Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F547013F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298803; cv=none; b=YsYWZJTr6gLAXMjPfiYE9eWsVpD5jZORzotk2VCDbwyfImv5LDqdaZRIcjR73KPOET6Q5mNI2NMm5/8kcCfEJkfNk268FY4ED86Ye8COClPa4dkz5K1Lz8O6lTOFsD6eIjMNkQN88lNnRVZwAZsVM6BJvHY2suRXsjWQFFL5zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298803; c=relaxed/simple;
	bh=TpQNl9DbT737cmBgBP6QZeX0edXbQA8wj1Wl5gCqB00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bq6B5NNYxyI44JbNp2IoHyEPGHP34RIIi+rPPgrTlBUelImaKD6VNPuDH5iPQ9oRWvZNXr9Zn6knSbAmmzbYwknOw9fFSnLh8Q378LlqSpDShQHtsErTb1N4w8nm9F0TlqRezpRI1H2YtdBq5AjTqWOivHRezlGNSNe0NO3R38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W2EDEpmM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W2EDEpmM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90ccb6102a1so2990596d6.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298800; x=1788903600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvsUEmfZ2TKaJs5KGDPg2m5xcrkKd2d3jmYqxtr6okk=;
        b=W2EDEpmM+/NBqx4HuujJJH5JV+ZnHGMYM56kmVh8BhLEx5Q1JTLsZyr/Ouf2VCU8x4
         U7PLv3aaEaL6yhDfC1oUe6SF3c/YraUN4qKFuVSOd4wpi16gwQva7KM5vaz1YkJn1gQf
         Y1l7vE+sIEi0oL2EeRY8y1QoGMpLEL4UyJZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298800; x=1788903600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvsUEmfZ2TKaJs5KGDPg2m5xcrkKd2d3jmYqxtr6okk=;
        b=fyikJAKYZC0ldX9vsb/MQhFX+irc69UEngdcycghiYxtmJBaZKsMHZtSmiAjqW1iiN
         GKnETkQg98wz8SKUbzSrLI3rvMm6nK11Wfh/ySH2uH8V6oPFZVh+9KEbinilmDasfiXO
         bSsi+nT1Z6Wvi+3HQa/taalM750XsMFfoDPCHs6a05i0yS9PV3tmFwOIa+xcugXwcB3F
         83fHpKTV8Mbue0pOx5GqTD66rf9/JenCgKqHu3yFIAL2HrVKJzKi8cto2wcaMm+DpkVD
         a00Hyt5dLFm8CPGbpxDBkW1Pl0RuokSetgTxUdje72Ojm09RDqOI3x78Nl4OXtu1zAD8
         Nh7Q==
X-Gm-Message-State: AFuF++nVpVhiNZ02um3NTvWj51OR5gMIuAccz5WJJ0S+zC7x4XW4bzoR
	dasMikItys1Mgp3yMWJ/h6EwmNFG5GPvRGGGIZinj9II7hr+HGYCU7sIlaSdXbvQ9DAqfZdJ0jD
	GxCm6eA==
X-Gm-Gg: AYBFou1q9eEIRnrrnj1reW9RZ4RK46vFMhk1uqxAaHSvqaih7uFaImfS+9LnnqU145y
	7YynYHWhcZBe5XODCRAd4ZANTQXLUm+kAsOgJUgOyOo4XsgPz+GzirnoI1UrL1AVcDsMvx4nEpA
	9jMo8jau4ERH0WzLLVCbMj9REvK8P8dQfM78wh8bzsjOjdCIkrn8Row+Abu9iqimvObgm7VFbS8
	yCgcOMmqcbCi0ZoQomUgihi40AnktWiJqkROAUKuzP1twcP3RnTdHtdDJFBfGJcWdaiiJcbU6sK
	4TpuFJqZncJDP9pvcP+ixl0h4CWLrwnh08DKuYZSu6kUXEixFOWdqmSZS8Uot4umGrUXBFm8EUg
	Pm8UZ2ZMo9jsPM0+nLf71gh8AenZFiurxKI2kl8jg4Oq1t62x5JITiyFlcf1P0Z3xCcNOfcnR0s
	CfmXRliR/96LzvbMlZ/JyNZWixBo+n0wswZfM0Bhv1yXD+ygWgVg7KscLeQ+L5eZmH272yK89gO
	3D75bwK9SWLlyutEiwg5tHLJRmec2cHRUtFrA==
X-Received: by 2002:a05:6214:4a89:b0:90e:7fdb:8583 with SMTP id 6a1803df08f44-90e9f248577mr11782106d6.8.1788298799909;
        Tue, 01 Sep 2026 14:39:59 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:58 -0700 (PDT)
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
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 8/9] net/sched: ets: clamp quantum in parse and fallback paths
Date: Tue,  1 Sep 2026 17:39:29 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.9>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ets_qdisc_change() falls back to psched_mtu() with no floor for bands
without an explicit quantum. With a crafted size table qdisc_pkt_len
reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
deficit-refill loop spin under the qdisc lock.

Move the floor into ets_quantum_parse() so explicitly configured quanta
are also clamped to [256, 1<<20], not just the fallback path.

Conditions to recreate the bug:
  CONFIG_NET_SCH_ETS=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1

Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_ets.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 25fcf4079fec..6cc902a03838 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
 {
-	*quantum = nla_get_u32(attr);
-	if (!*quantum) {
-		NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
-		return -EINVAL;
-	}
+	*quantum = clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
 	return 0;
 }
 
@@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			return err;
 	}
 	/* If there are more bands than strict + quanta provided, the remaining
-	 * ones are ETS with quantum of MTU. Initialize the missing values here.
+	 * ones are ETS with quantum of max(MTU, 256). Initialize the missing
+	 * values here.
 	 */
 	for (i = nstrict; i < nbands; i++) {
 		if (!quanta[i])
-			quanta[i] = psched_mtu(qdisc_dev(sch));
+			quanta[i] = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)),
+					    256, 1 << 20);
 	}
 
 	/* Before commit, make sure we can allocate all new qdiscs */
-- 
2.43.0

