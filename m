Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801843;
	b=lQ1QhcFLKNldHAQhk6qQPK0YUaFIw/6kkMrHIexRG3hGgJlvFfs6GECELV/mFSvMrOQH
	 ugbufb6cTCx/UpWWYfVxi5VNI237BgHOryWCLq6sIeGBOkBclKAm9BzydgYsqr4XQFd6t
	 N5vz0XV2DMwbh8J08v2r0qEYNCMcJNOFBFtjYW2jAP/FE8lpmqFxPPrAjhJqVQBO6ZiPO
	 ZMjT9Ym0AcJfGLpNighGWot9ZLK6m0s+Q3Y9j+kQ3hKNv7ygRw89ogQKFHL0QGw+yV4ej
	 ZBIE3IMkx171g9p04IgouXjnhqaiIcpL/mzv8JuEq5bWEY3fL9l2qwje+qc9YEXGDjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gFimt1rkvDCCjT4BzWgXH68/6Kziwpyu6m2kyzBiw1s=;
	b=eOcK61P14uni0nnv1e4LLEwAdfU+HxZCnnpwkAM1I5WF1Y4x4gOEFtPA8/LOMSuW0m5K
	 IdXHLwbr8cotqYUjA16TZvSN6U3mVskkna9XsKJZbrlVDvKGYn1o8celWa1MqKEPbDdPB
	 VQHPZnAri6ulj4PsZUiv5JRsunyR1h55syb8V20AQskooe3AMHp1QDUVUroaVWYBVMl7Z
	 t98DAi5aKU58yunCKFIljj/nzNk3coltSzQ7+RxZC/vxQmbh+xNw0LL67HgFrlrT9UOUU
	 NNltJln91t3MimyPzvQBZZbPTdHmxXGa8gm4PH/zC4qbIHBs/HhPHc/IqZ0vmUosLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mR9b1zcc;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D59606A332
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D59606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mR9b1zcc
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c315869241fso118215666b.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801840; x=1794406640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFimt1rkvDCCjT4BzWgXH68/6Kziwpyu6m2kyzBiw1s=;
        b=mR9b1zccPhZiroZ6jHhY+R1mcQtJ4EBotJVvk7yIjXuM/psBiMRAPoXyHC1PmbkJuO
         cNpn3bqa2c3VNWMTdtI+E0usCnL4uZGdrUkRxop6Vexni6jE4/jJcchHQy73VUYnxExx
         cYy1RgrUr+yxtfi3yy5L/g5fiekYR0aPqv/gIVn8GBMmRJp7eRE/+iFPWZNHOxvLSsBV
         JtppO1NRAbux6PkpUjSqYFeT1P2jTFvTZvz9993L8K5VLP7Ww7kkVV0QWKfQWrL8IF/h
         CM+lTWLPqy3+nKJ06efr3YOitFsO2ODFDhWGBOSF1bNSBUiyNALnFROTN5ivrjH+G6+U
         aHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801840; x=1794406640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFimt1rkvDCCjT4BzWgXH68/6Kziwpyu6m2kyzBiw1s=;
        b=LxW8ZBwd/3craxnDORhhWG4gAgk7iotQVbtDxV5fsC3876v+5Vojc11uwuDwg4OrKM
         gUb40QLevFLvnn0tQx4dlLJ3vbfE7j1suZmne460h6xgMXfeC8M3ClEpncIaPEsuXkKs
         3HwZEGXy9MWB+pj/BFLc+/cChmQ1NcXJ1nfaP1ISOiH2snjcOEe1IrafmS4wkPeUY+12
         uwB48iKsIYPSuCRumBuoHYRuUg/s70B3eaIK26rHsMwirsvk/nVwsfRDU5XlndRwqCLT
         Ix8xUfm22tB5OkMSV8rK118Bbekl7dVmwq3vN1Frw3TQ26EwggpyO6xTzW3IZz9A5ZF2
         OYjQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2YkchieuB/VCCUsIC0iJPt1BOTcuzz5z7RcFcG2n4MF4aat3KpbdIzpv6GpIk3dm41I6wAxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hEXvvzDxFTdPpVRaK0D35Wx14gDH7uTEV2Ud0EneNbz9lwRYL
	rRFr/oQ21ZKao4k2tMpJ0b9hyiHqtBJKVNPpFgKrfRtrfNT2OA+rZq1c
X-Gm-Gg: AYBFou3qlPs+iMu1PpVoxbGyKiTHNECNMFRnFHK+QzG9cDfmj+orKuxXerWnOe2vTtC
	kWtGMysb1cTxASTZa+xWFxEv3xM65StNPwYLehtuGRMVCuym83QO4mi4idbh3ir8QERbb8IOSU3
	86hwVo9pFT9JhetkhLmI678rhkgoTyBvUF84xoIH3LuPWZfGPobwjVIXRNDf0e+Ey2V4jaoBisJ
	Vls3eJvozxQjQXDwFAQAtequYlfx9DWGlVsuDmLKjW6knzKKdefLDGtAW4nOzHawnmSnOmC1Sta
	VDw6g85ZjjMs0Q45+ddzUoQkihMcxlRaVAbWtXeCiYucF7O6rGtrThRZ89zUe5cnZr7EOk6fxPY
	jlv2Iq8r6CP/BdDiuXUi0v+Rq6Dfhvmjx6ot7Q5FVbHP8OHaJbeWgR5+A68rZK9Z4aIF0mSqOTY
	qc/zWwnqJIevJuG8xZzq8J6Nfwp+rYgxK6TkhOFbRpD2OWT0ZpNt306CEzETbmrOqZcJCDsrGCs
	gEYJUm0mLUCGVJD2MbGNW8M/2CQJlZzYIK++y4KaeomO3DvWKBZ6Mg8iGABUh38L80H7H3/o5yz
	fAWgsaHWU6S8aoDqDwape4sA/SVyvBnf0ClOMtLOrkaP1LSSOlQjs9380yZN2jOEJOwHIsXAtYK
	mCY3cHeumC703cL+M5jYNxPJ0Lk4vh3jkOnoUif0d0dvEZzTMuVhjrAGir6hfNHdQphyFYvY7yl
	vRMWa5xszw1W89UdmfCSRUJTa+mHW+e8xWPd+76Xk1h2LF8cwND2PEEWI+NJx0pBhO6525MI6fg
	Q==
X-Received: by 2002:a17:907:1c8e:b0:c49:c76f:dad4 with SMTP id a640c23a62f3a-c4ca7a6e69fmr1463979066b.31.1793801840118;
        Wed, 04 Nov 2026 06:17:20 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e43e2eesm77311566b.31.2026.11.04.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:17:19 -0800 (PST)
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
Subject: [PATCH net v3 1/3] net/sched: taprio: reject software schedules that overflow their timestamps
Date: Wed,  4 Nov 2026 15:17:11 +0100
Message-ID: <20261104141713.355958-2-krystianmkaniewski@gmail.com>
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
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
 - reword the range-check comment to describe only software timer
   timestamps (Vinicius)
 - add Acked-by from Vinicius
 - drop the obsolete Assisted-by trailers
 - rebase onto current net/main
v2: https://lore.kernel.org/all/20261009123309.284193-2-krystianmkaniewski@gmail.com/
 - no change
v1: https://lore.kernel.org/all/20261006113335.241564-2-krystianmkaniewski@gmail.com/

 net/sched/sch_taprio.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 4f69ef3d847a6b..2a31b189d654e2 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1258,6 +1258,48 @@ static int taprio_get_start_time(struct Qdisc *sch,
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
+	/* The software timer adds the cycle time, the first interval and
+	 * the finite gate durations of the first entry to the start. Entry
+	 * offsets are also calculated from that start. None of these sums
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
@@ -1982,6 +2024,10 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
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

