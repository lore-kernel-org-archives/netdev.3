Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAB2D9ECB
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991181; cv=none; b=EXlCuIdxzwAjJ3C+TO3/hmBKLie1TVrwpQfA9+JsoRg5RIUhnoUSdXXLy3e4kB/blGcHHm7r/qarvuwCpZkeh/VKKcnbch01xKtIcelSrxvi9bcRfKt34t5yDAQA7z3zHz3VsVjIzmvaUHQbEUtQzYinZRaQBQswHtutLw1Dk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991181; c=relaxed/simple;
	bh=tgM+/vif4IndBdzYIROMPmudyi+lnEmy6tRTUg0iENk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELDjs1Beqt6DIR/wtvs1pYY065Plca5LhKmvr0Gw1tATskpM2l1J4zNWl62REDVZ+XQWiv0ohptw2uJ3Urrjqg4ehjMt1ePEfVo0vedyDlNLt9Fjv/8uA3WbjeacMzSshcABAFvjZF+aSjOAC/OuMzFNm9PjxFZ/X+mNOHagaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bZGkzHsE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bZGkzHsE"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cc372d6b2so15961026d6.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991177; x=1788595977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2Wk3KDBvf+xhI7Wj9voFZqhuogoicBGWeUleikTbVo=;
        b=bZGkzHsEDU1FjVYAY8G2uO6JzaXXkxIZQ8nYDn74roZEaDVd/hjUcF4DCLWJodUHr5
         /lgU2yFNd0j8yK2bGgzUnHV/VhHs39if02gEXgTFqMZBeBLMOb0wufh1pA18G+uY0oo7
         2lF+amawgqUP/I2CRyh0HL7XJZEn2qID0SfM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991177; x=1788595977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2Wk3KDBvf+xhI7Wj9voFZqhuogoicBGWeUleikTbVo=;
        b=Jn8kPAX4JyXqYlRBY77oif7SAYwS+/Cl/u08dCxac6B5mkGAJuJgaMUpbTetEVEPkq
         +yjNAaMqb3hzgPaf/nfpY9gBUipVtoaKwZH5cCU2uHDpIkV35eFIE6tJni3tVk4oJns+
         afCLqG26puNS6vf9iBLzeq8cF+8Lf7vA8WEdoUcVSZgRXjJ4eQ9EqB4av4alGE/W7wOt
         yQifv5pm0fiugG9guR094LVjCRxL6Jhjc371TsLhAQ9ifVpfndV4XI0YBzvwohy3O/HQ
         9kGm7XDVeBwDFLHko5mTHoWDxYaLHa4PLx4kodIxcsgjATXbTYxln/dgM1+cjEDxkj+6
         ZncA==
X-Gm-Message-State: AFuF++kAlKZdKwavA2eMxq6MUsH9qCIrw472SAqmYsZFDKSh3nWP1i+1
	9VqUiCyG3lYyeODxIpsQt7FAdjWfqgJLYvRniaG3h7cUrxh4iEgt5AYpnddblRs0OiGz2WEjtzb
	0Ckf7lw==
X-Gm-Gg: AR+sD122lh8NluLA+5iaFJIukU/JFaZaghYOexRTJxqp+pYVOFrE2HshJvyeRKEvhiJ
	WvXXM+UwmH1n9DCAsc/Sq6QCe2Bjnboji6X2ndrY9rIxM8Z/z4MMG/SUnFC7U714xIKkBc9g/OY
	Zu5CNnv6hMe+Z6eSQdQ8NR4Zf5Szqm/JK4Zd1rrSMedM0hMwlB0+EvziZsB4d+cYgPqg02ExTMQ
	h75FTgjTYn5QJamoI+iewa1zHp9eIz45Z3XHmfcGpIo27ZPIGc5O4VVya+xYoEmNpN4U+TaQbpT
	l3yae+AgKEimXIznKEYm+BhyyCm5NEI4yBm8hApKdWycjRb6t+R21n8fFDBSQMr64TRUq4LKgVM
	yv4wrgQLVDes1+CPuqMsQ+v0Q1F2qzOMG21FFg8Xjpos4qDq+kPYwLGU+2GVl3soldXktQwuwQP
	0WPTjrK29/v7vcBmYseTSXTXIw+S14MjtpBCVkncqCSkasjpvVzMG/Ge9XVYud5kig1HKFbUoPq
	aBuQbqRp5dceMidQzmskd9nQhdPNrjRwszl9fk9IDAnWS2YNlzk5dBrbdU/gDhoFYw6sizqUai9
	WI2b22GQL0ZYMnMQWfLF4x5nFsw=
X-Received: by 2002:a05:620a:1b91:b0:936:ef9a:deea with SMTP id af79cd13be357-939138cb02bmr1583948685a.28.1787991177464;
        Sat, 29 Aug 2026 01:12:57 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:56 -0700 (PDT)
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
Subject: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and fallback paths
Date: Sat, 29 Aug 2026 04:12:29 -0400
Message-Id: <20260829081229.81708-9-jhs@mojatatu.com>
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
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
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

