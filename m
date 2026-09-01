Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33044AB98
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298792; cv=none; b=MUSBWj3r7GTdxHqbRwTVZjtydqZpcgmSw4GSID8MghAjCn1WWmuIg9B7dfSLNHxfIfHVsc2TBuaTJg9FNHISohVEMPLNbQFqxUyAIznslseMm5Hz1jDoJolZWy9HMnFGqQ1uXd1ntZBLg4FGqJEstN4COcYWKvA7pMoF3uMhZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298792; c=relaxed/simple;
	bh=/0zqk8DY5QgcTol9vG+KXFSFt100FBlNYtvPBCsmlD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdYmVQhxkP0RiQGxKqLDN7vwb13gWxu2smnUQeYC52LojdFNpWBk7PSVh7o6t+nDT5NtvmX4FlVneEBx32Ze52K7+siJJF3ey8BQnA3Booyii1F86+mqwC7pa3Y5kWHsqRLumt26mmizg4KEWbjaWDFiaodGf61xRE2yZ7+Ho1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=uF0R4qC9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="uF0R4qC9"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90ccb6102a1so2989386d6.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298790; x=1788903590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2Ph+2F4XnBsZC7RVtAjPh751ig1yynrAPtSoAph6mw=;
        b=uF0R4qC9UhxAS8CvMq6fliKsyRQltJVobvXnxPPUVIoxB84UUOHVXGgCF8N8XR+fgu
         Uc0LGcmaacQ6oIP3YCYaW5urVG3kBptHnD2M27ppA447zPrUvMb5pAMr9uaxmO58o7iG
         9angjlVvSNSc7HDN8gyjjSnksId5wvDKo+0FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298790; x=1788903590;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2Ph+2F4XnBsZC7RVtAjPh751ig1yynrAPtSoAph6mw=;
        b=sWDgOKBuywtKM0F6942cYSbfriQaZ06xtoVh7BHJfAlXfq/M/q6E8L4tA3Q9TZIW2+
         nZy7iWg79HzSmdZVTXqHZdXhD2pQ5VShAR0pelwPPvqu4ZeQIY8dXw9eN8dz5m9/8VpB
         4ipOt2QGZUt39fQkg3R9TzQUGDuZZSPvSHIaldXSTALtPt4eQY16qUvrPdsuGWsisOcx
         0xGD81TKpgQI/+LhmxBfQNabNIuTEQKfL3P4yQ2aWx64lQAsdw0lcFXU7YuwBixnQBb5
         OylLEdk/ORJKWwWEe0Fcp5G+tKoA04K9Yt44Sku1vQdu5UOaJNtQdVmp2XSv0qpQkRJB
         vVRw==
X-Gm-Message-State: AFuF++nW1UbmDwWCV2xSDk4rroCr7LdL7mfrei5G5Ic3fi0IrVlQfFLp
	PWWlqm/cW9FSqdGb4dUPIKPkYre6PqSQqA+hD2emRNxr41dpvSbliA6ZLuZCI4waDOzdBCcAX0b
	fPypTJQ==
X-Gm-Gg: AYBFou0LVaP3FkTF67ro3W4saqLwX3HL1RBPCLPH1/cxQQx2IbitSU22UA1obHCVoUL
	gpLDhbNXLqnx7YAznvauoqLSrISEzGgSuhDE6MSJdsLX303HXm5f9t3siJ6UTy4Op8e6lMQf17G
	b2S8PKuFIV6a5PRFusBU83SsgjpXgY3AQXWHY1jxRmkXdy9W3fpEsoFaTnUPGOyxqnMnKpaYOcL
	JWGwRL55j2G1Mny4lt/15riZCw8YOQIglV2YXCDyIF21VgN3yeeLAi9Us/rqnLIdf+Skr3euIbr
	J7qd7cNZI1oJCtrlCXkrr0vs+ApWgWRINdGKnze+PKf0gNy98O9hJfIaNi6ycTcdmrA2My4dwFW
	IE/2Ww/HcZ1oU5ShQtj1VKtvJrW9mHRTzuzAPYEo4A4yR2cJOwlGK896hbvh49v66fOIbep4AJR
	9ILSV2wsOTRKIB7qCRWjgl4l7LcBGUI1hfsipIVIaN9AJKIcvTOUYMFMBMUPmGne+XKaNyiX5xB
	h1RJ6UUETpMa5iZ+Ziy9mMasZ1+EDWMERvb6w==
X-Received: by 2002:a05:6214:ac5:b0:90c:c4fe:8d9c with SMTP id 6a1803df08f44-90ebafc002emr9783416d6.27.1788298790242;
        Tue, 01 Sep 2026 14:39:50 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:48 -0700 (PDT)
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
Subject: [PATCH net v3 3/9] net/sched: sfq: clamp quantum in change path
Date: Tue,  1 Sep 2026 17:39:24 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.4>
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

sfq_change() accepts any non-negative quantum (only rejects
(int)ctl->quantum < 0). With a crafted size table qdisc_pkt_len reaches
~2 GiB, so quantum=1 makes the deficit-refill loop spin ~2^31 times
under the qdisc lock (a soft lockup / denial of service).

Add max(256U, ...) matching fq_codel_change(). Reject quantum > 1<<20
with -EINVAL, matching fq_codel_change() and the init clamp.

Conditions to recreate the bug:
  CONFIG_NET_SCH_SFQ=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root sfq
  tc qdisc change dev dummy0 root sfq quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: e4650d7ae425 ("net_sched: sch_sfq: handle bigger packets")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_sfq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 187d3ed578f2..8bbcfc9e85d9 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -660,6 +660,11 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
+	if (ctl->quantum > 1 << 20) {
+		NL_SET_ERR_MSG_MOD(extack, "quantum too large");
+		return -EINVAL;
+	}
+
 	if (ctl->perturb_period < 0 ||
 	    ctl->perturb_period > INT_MAX / HZ) {
 		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
@@ -688,7 +693,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* update and validate configuration */
 	if (ctl->quantum)
-		quantum = ctl->quantum;
+		quantum = max(256U, ctl->quantum);
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.43.0

