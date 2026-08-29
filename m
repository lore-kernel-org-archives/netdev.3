Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19050391E7C
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991169; cv=none; b=GvBcreyxsfGB3eLzHup+BkyTcMcVmiAhsm4N/Er7UsnRBMjAhIBXUh5x8mDMtnuVLv7t1jZCJQqn4cmAI1vq0ipFjKGqQ5Bdm8UNiOJiNIy88uLBU9I707ZLAWHl5qLIvoS6xT2gs+ZQbd6Pd3fd3mYi7V+KJnpxuuAyPBw6sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991169; c=relaxed/simple;
	bh=BNvdFc28OirNme4nOiVVSm2N77c4+Bdl5E11EpJUi04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6mo1UOVatgmZMHa7mfspr7IAqr5z+lH75EwqYJweskkBGeneAp9d3X1oEKiA55OpPfHOySec5Hm4LwQ3hNA/NDbTTkH1wiFvewYIbgSTK8A0DB84l71JDrfxFsWIOhUzOjyNeyBc85tgQVhHTvkNdHOsZRVoSOZSBsZplpIPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Sbt1qy00; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Sbt1qy00"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9390c3ade1dso88988485a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991167; x=1788595967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgwAcg2QIz2kJViuMyXUOwt7mGNsxAiO6To1hWCAJdQ=;
        b=Sbt1qy00QaANYG63qlkFr0IKMnRoChwc4op7Qp86DxNWwjYc02ris+GjnjWC0Vnlun
         thFlZs7KSaAcH3++E1Sd7fJGsqd0EE5j76V0sL16lrMpjj2VXIzoEtxXf0xXjPBDnQdF
         wbIyA0x+E4B5MDtkF4LD7CUMmTx4cWOKh1u98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991167; x=1788595967;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgwAcg2QIz2kJViuMyXUOwt7mGNsxAiO6To1hWCAJdQ=;
        b=rV6N2dVe7k73+ejqgiX5PiPbg9TGjaJcyq+n9Oxc3srUPhVOE6VD4cBfO1InBE1mn0
         D1fjF3bZvDdWMZAR8zuDMskGoE7vdhc1LemMFIz8MO9T8E7I+6Bg8/5W8xrqNAjrFRuO
         7Ek2n7Fx9GYlRR2JIvF+tu1tc9PQWVO+bZiSMCg9Y8ZHGqev3cj+T1PAPL80SCxNP7Jr
         kDzh9pOtAjFCXvBn5S4e6SN2rfNt35ZsfsVWJn/8EftH4XNF9VqbtmdsmHMuwy8AO+jt
         KKa+RQ/1cYqlCnPptOl7F1lLx5YrlqKfmMwuE29EmkrPmYQWvEgjHsOqEDanxSBhxQAC
         +Viw==
X-Gm-Message-State: AFuF++luRn1HoJcTioqJ1UwS00N4YTCMMdr25wKb0OnYvmftEOMNF2b3
	PTSGxvXAihrd+WlYoKJ49eG0vxtmPt8Irs8PASzO4g806RMySKEQeetL+KW79w6W45hPakGZWly
	IsKk71A==
X-Gm-Gg: AR+sD12SSLplgRqilF9P47CfwMygu0o6n8rpKh7MDrGlc3oBfZdEaybyn4HrHMXefZr
	0u6lUvRLGJQ+xxWwILcFSqOAAz7eoynPVIMX0hqR1COVJyDjnecQWA18j8ZB3xH07TpZ0PNqTCB
	f/0rN3YB0u9zpJEHT7kzXmsGloPLnA7Ny5Kp4a3mLBqxwrGsn+iwKztZjMJUQq0/QnBXncGI+gc
	DdZ9X8sNeLCH5xPFXIhslYs2rO6tM0/XBBB/qTpbgULq+UsAcfSfPrzdYhFTslYI0SoUhcBj0a0
	x86MHnxZXGvhyAAv15rDhsodQeml5a+9YIPuXRSYjF6qVWY3hB9Rx/HmncY+k7QCgIG7ZX/V5S3
	eNjncbKmHoFbWI4TTmV37f3p4WD5UuC9YXLlpDdXeftruTX1A7ZjuSyln3TfIqPby2/wDO96ql2
	uUji0X5n2HDfYAIOeJu/MhbuYL3z7jqQ3xN2v3ete4aPFShf1Ww3labCUc/2kLxcTGyhuToOOV7
	HcWm87eTQQDiGtTVsZgu8XvdNCn8QuMPm6ajAZkuwb2Zc7+3xx4VLc6EGmWSTubi38/MISy29e+
	kAZLy5hssJDCg2leUtVL+DMJA2g=
X-Received: by 2002:a05:620a:371b:b0:939:820:2e71 with SMTP id af79cd13be357-93913904558mr1311203185a.33.1787991166842;
        Sat, 29 Aug 2026 01:12:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:46 -0700 (PDT)
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
Subject: [PATCH net v2 3/8] net/sched: sfq: clamp quantum in change path
Date: Sat, 29 Aug 2026 04:12:24 -0400
Message-Id: <20260829081229.81708-4-jhs@mojatatu.com>
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
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
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

