Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132363B3BFE
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286428; cv=none; b=PIq/NZy511M1BYw9wThfQaw4tsJbHdFa+JjRNEFao6KqSqMOAu7hrN+/kCtkLAHNKIpridUtVi4x8YnIMDIx7jStgkRrU+ktC9FMJt/XoWX90IgHeurvBKLXZA3KAp1sxAZkyUgTTBEWfZ4xIWkSMcT9JGqin70kz5J3hHYGJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286428; c=relaxed/simple;
	bh=E4QWvvZXHvFDmx8ZpSflWoppDuRLramrcGjjt9WKUQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1yOptHIUv2eOinz1mHOPnMMWjumCEZR4x9Cobyt19hq5quxFsUIzB0EVXvHtC3v0KaK87RSiNSWVWFpeKV7OK6+GZin8tEASDburjdMJvq+73WHmUhKyxlh2iISjw8CwwdTMTi/k23vX43P7gS9CgO93NtXS2FYxNF4CGJ1DYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hix2ITNO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hix2ITNO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so936166a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286425; x=1791891225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhQF/itJJniogTBZpKWP2vo46Q0NDWJJIYl2MQzhtGc=;
        b=Hix2ITNO55h2MyqfApXztNX2GjwSP1CRf/uDFWpmLb1w9bvG7742TrkY1cS/dVIz6f
         3PezJehGz0gYf4ysrHqnfk3FuShc46aOoa5zDpNBsyB3uf2cfNtrj0/iKbFKb0P0byBW
         k107g2ErG6AcXj7q15y++vu+R4zRHDxQ/tDQINZ7AUGc622uY9nmHmrzvzXrpP5TiZgB
         Vu4YhFTUjWw3WyXFR0VW6M9l3Olq5wJnxgEfmBXdlwKX0uqAOkp0Us2J10EjQsjDyyQb
         NanJJ8Mror9GRwKgp9Vb2Ytt7AK7DBc+HJfb9Y3IaUkVYNCOkauMFrPOhDgiG+R6e9bX
         BGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286425; x=1791891225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhQF/itJJniogTBZpKWP2vo46Q0NDWJJIYl2MQzhtGc=;
        b=FpTSz7LTv2lhO/T/s/TeT0RLyu2PjxMb0MVZjDMVl572x8jUAaxumVdHE+vN7ZBomP
         clFcWPn4+QePemhuHXGUJpEMKbcozIuHk2PRD8n3xzFhnb0zHTi2M7zdTpXDQ2AY5wkv
         7pTJXq0Kc+nr7nCVafpVHs3TzkgZbd6L90L1DM8aJV//OHE/CNhXUvEMzLZGk5A0F67M
         puk4zznWeb/LVOWGDatheV0mY7cY/xRV43oRpTlUdd/CeSSNH0RIvIUn15ksIvsIanYs
         u/yoKfXHMCxB7fJIPoEpLb8pEiLGsJFKBmPCzz73Bk27iCBokog6IEIiIu+pWiGmSTk7
         yW9w==
X-Forwarded-Encrypted: i=1; AKwUvBy1NO2vJ7ieJRc11MF34g9PLgHnBnvsUZOXD+zWvjbpTFraKt7xm/CY6u196Gn9e96P78Waux4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb0doEoDSZUAXcLVT+Va4n9TaKySZ2wXzJyvECJEwBhPKzmEJe
	L0v2WCih8fTXqAOfKywxf/Z/ohdys5U9SiGNCOpdlzFYelCKz9xBj7rO
X-Gm-Gg: AYBFou38z6aU9Tf5PzipV2E+2kq2E+FB4OESNUzjm+zQUA5BL+/A4rv36qLSEjCPP1/
	fNYq7xTRtiYq8v6DWayL80xPNDPI56dj4bG6cciUrtBGha4CHNc9WIKVjlFZ81zL0yDpsrRaUkY
	EiZGDGAAAoGjCDueuqeypuTXBdpvuM4pnZi9RwiQVGPw0ZEz2NdneHee1mJHcghwDPxSsp47hcf
	LrSm4LqN0vEKFPPozQa49A12fd4D1NoIeMOjafosBaVxF+W3s3q1QeEt+adKUW5bRC6TRTwwzXW
	SvGIiAqMAcreiW5lhOGYMiVUJiPhDvp38enGRuYbBP3xcNIhe20P3qbUQB7AY3iPU+0VWbgIqgY
	NcwuBsvg2xgrMLTwB945UGEbnoNDd7cLQ/W+IglWG3rEZFA0EZlp8CAotYsHfzyxzP+EZBH8uYY
	QOBNLFlK4kR40fj15cGlIIuqgzV9HWaawoqtQbbuxZzvoHPtMjq0MXhtau4kPee+mP63vaaslBz
	3qFe/saUt9RipW7YDTFzL9I1AkVTDZCj8is5/jhwy3I/w1SQTwveahP5ISuLruj9e59dUsPiT8l
	onCiTtRzg3IJ0O5SeT9ngkbHdxxMa33EINGOQRYhRhgukb0X70Qm4k+mP6FjkldxlH6BBFRqDp0
	O+f/78+rKMOIZzrdj2b6IyhC+Q0PS
X-Received: by 2002:a05:6402:3787:b0:6a5:fbc6:cad1 with SMTP id 4fb4d7f45d1cf-6afe2978761mr1144059a12.7.1791286424972;
        Tue, 06 Oct 2026 04:33:44 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5937sm4465468a12.11.2026.10.06.04.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:33:44 -0700 (PDT)
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
Subject: [PATCH net 1/2] net/sched: taprio: reject software schedules that overflow their timestamps
Date: Tue,  6 Oct 2026 13:33:34 +0200
Message-ID: <20261006113335.241564-2-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
References: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
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

