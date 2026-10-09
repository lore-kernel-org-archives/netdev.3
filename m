Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A64CDA0A
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549207; cv=none; b=rytbtxF87VolCR9hrlzPF53gpgmmPGn0L1qj0wkmo7IAmHnTyhtPqGPu1yDpNoFt0yhLPkUUzBId5PsiONwyxDci8X/bkQIh0KGSLgyRaxIWnFEOTSan26xhaYEAMct/luaD7bPw1dNsNOl/npvxov49fOy6cN1Rk1dlbhuxAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549207; c=relaxed/simple;
	bh=imN2tRDP72kfhavZsAwRqcjiIus6mD80BgKVeWkT58c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm4viYrL/iRxTPDmj7b22Df70QlCK0MQVD5tlKqap+yeSrjcYFogXXKbXP9via7MNn5yNVKPQdTwfIzzKmYL/W7l/Wa4bAc+5VsSNELEjYDZed066XkNgZzfPhA18PnEFkSQuDPo+u0W/OFeGUd0tkS4+dEKggBJ+moyS5S1yXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be2540N9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be2540N9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso31636525e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549196; x=1792153996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWh6pn0d6opteTbiTE7cwCfiA2l6VLifnQ39AyZyQfM=;
        b=be2540N9yq/tJFlvA2EgqG3Kvhil+s0RkJZkWhkPKQiPdhn4hAzjmLgO5IiY9iSYMU
         kQkDA/VWgW2P+d4OT+JPjQ0XMcrJ9eq5na7MEduNghcIX6sBkVRKeb74srIoHnn8Fart
         ShJeWWySO23ZkU9D6XiPaDuUyWrV40QKLz/71F26R1VmQNm11QfJJgfhiaWxBXMnM5aL
         QeuLDm8GA5JX1e0NEx/6YVGjOhM5Gnl56GMUsutY9PO9v5cU34r+Bae5/tA4lR2Nkcgz
         Y99H+mJ5hQ/bJPMkJb/TjAftHVKi/Fmjw57FrdJ4MbilpK0yTQ1HkkyExhNpAhi74tFi
         iAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549196; x=1792153996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oWh6pn0d6opteTbiTE7cwCfiA2l6VLifnQ39AyZyQfM=;
        b=IyJuZcg/BRTRiQqdbb0urS4Q5ua1KAI38VNlrf15H0xu8EaYlaTTqyeuNHZwbptU32
         L6nAeSpf0hDYJTQe3gny5SsRVfK4clClOb9UY7CWOD66qdxLZRDtpgefrm1sM1xKPAP5
         42w3HGeZdq3iqJpMsI8fnUlS7u2jw3Qd14fMKe0MgJ9Geezc3UIoWEJv9GtorQwT2JA0
         uzujUkUVoEun6xG37EAZnKIojhHVx2mM/BPvknBu3lNn3rDv4Si7LG7wUZteTNr15GPf
         Uc0POjDrspI+BvVBg8nl7zZXD8GQFlqaIXt4h1B67ND/OANojYJ6uMatI4/JUAdGScpl
         H3cg==
X-Forwarded-Encrypted: i=1; AKwUvBwEHD7JfQr5bC+UzSd3UGoupX3ik+298ymtazjyfZkDqYM6L8dm/Yg2R8vF/l9hMug8KA1GIeo=@vger.kernel.org
X-Gm-Message-State: AFuF++mPEz+7TEiDLgHCVlZWpjcLhdIwGWCUFMTn2pK2nwm5WqU3w2OD
	HmfMnyV+dnzusll15M6erpu0V9KFhG/PGhMJRqPbjWTqzZPUZ/4W8Vs/
X-Gm-Gg: AYBFou3Z9rK/ksAJ8oZZu5/y4eAaY4zLmWNeC3GR32eFwnKJ36ul1hmO/yNdOsMl8O7
	g208+QI1gIr57ZvAQVIaXtEd/mr7Dq5sB8idIgTlHysrIpouUo6t6H0XH2aUbREWWqVn3WdQOQa
	xqKTViUGirL0P1r6ro0wTHa3m6yqlesh4SWmlbIcomiVLVsh1CNKzNovCnXwbdVsyJtGJCeh1uU
	ZtW5nWIxfGWo6uHMRe5FvaauOhul3plZ2zetdagR/lQsHgdZpL1qiKKRsPGz3S77gByxaFuYqHr
	BOvKySDKmZYcHRw4dMm4W2RMxxmSHLfgaKhsIP3tA73vMmhUt0xFOqsSOY7EGopI776vdOUe3zx
	F26VZTr633+a66knGvfGTmjLSBbeZRZy6bRS+cf3Vqkdvru8t8tQ+E+Nbb9Iazbr+WHUxbvJf+p
	n9eBzvUgZv1Zz171XAuARHC+qvaxkS9iINjo4aH4CaM5KXDThUDksJvh6prE6sBcqKZjzocnDQl
	a9Sfkr5NbCuxl4TVirywJQW6uNl1N8shl/tJ6eshVQKydo9d0jdm3icO7XW2ohFYzH5Dk0pcbkw
	gmAJ73rJlZ7x/E1HZn0h5M5SPj22sFuqI5P/xHs0XrT8O0hiI+pcbZQiugbYlgoMeZEvUAKvxCf
	0p9KNgSfxvBmnymu7isQ=
X-Received: by 2002:a05:600c:4e45:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a18e4d8c30mr35055235e9.28.1791549195686;
        Fri, 09 Oct 2026 05:33:15 -0700 (PDT)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm3650230f8f.49.2026.10.09.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:33:15 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net/sched: taprio: reject software schedules that overflow their timestamps
Date: Fri,  9 Oct 2026 14:33:08 +0200
Message-ID: <20261009123309.284193-2-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

taprio takes base-time as an unbounded signed 64-bit value. A base time
in the future is used as the schedule start unchanged, and
setup_first_end_time() then adds the cycle time, the first interval and
the gate durations of the first entry to it. With a start close to
KTIME_MAX these sums overflow, and the software schedule starts with end
and gate close times that lie far in the past.

If this is the first schedule, the qdisc timer is armed for its future
start. With an operational schedule running, taprio_start_sched() keeps
the earlier operational expiry instead. A large cycle-time-extension
can then trigger an early handover to the pending admin schedule.
advance_sched() uses the invalid entry end as the next expiry and can
keep restarting inside the same timer interrupt.

Before a software schedule is initialized and published, check that the
computed start is not negative and leaves room for every timestamp
initialized from it, and reject the schedule with -ERANGE otherwise. Full
offload and txtime-assist do not use the software timer and are not
affected. Schedules with a reasonable base time behave as before.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Assisted-by: Codex:gpt-6.1-sol
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2: no change
v1: https://lore.kernel.org/all/20261006113335.241564-2-krystianmkaniewski@gmail.com/

 net/sched/sch_taprio.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 299234a5f0fe6..1f753911cdfec 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1238,6 +1238,48 @@ static int taprio_get_start_time(struct Qdisc *sch,
 	return 0;
 }
 
+static int taprio_validate_start_time(struct taprio_sched *q,
+				      const struct sched_gate_list *sched,
+				      ktime_t start,
+				      struct netlink_ext_ack *extack)
+{
+	int num_tc = netdev_get_num_tc(qdisc_dev(q->root));
+	const struct sched_entry *first, *entry;
+	u64 offset = 0, span;
+	int tc;
+
+	if (TXTIME_ASSIST_IS_ENABLED(q->flags) ||
+	    FULL_OFFLOAD_IS_ENABLED(q->flags))
+		return 0;
+
+	first = list_first_entry(&sched->entries, struct sched_entry, list);
+
+	/* setup_first_end_time() adds the cycle time, the first interval and
+	 * the finite gate durations of the first entry to the start, and
+	 * setup_txtime() adds the offset of every entry. None of these sums
+	 * may overflow.
+	 */
+	span = max_t(u64, sched->cycle_time, first->interval);
+	list_for_each_entry(entry, &sched->entries, list) {
+		span = max(span, offset);
+		offset += entry->interval;
+	}
+
+	for (tc = 0; tc < num_tc; tc++) {
+		if (first->gate_duration[tc] == sched->cycle_time)
+			continue;
+		span = max(span, first->gate_duration[tc]);
+	}
+
+	if (start < 0 || span > KTIME_MAX ||
+	    (u64)start > KTIME_MAX - span) {
+		NL_SET_ERR_MSG(extack, "Schedule timing is out of range");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 static void setup_first_end_time(struct taprio_sched *q,
 				 struct sched_gate_list *sched, ktime_t base)
 {
@@ -1958,6 +2000,10 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		goto unlock;
 	}
 
+	err = taprio_validate_start_time(q, new_admin, start, extack);
+	if (err)
+		goto unlock;
+
 	setup_txtime(q, new_admin, start);
 
 	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-- 
2.53.0

