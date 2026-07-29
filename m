Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACE49251F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333438; cv=none; b=uIsQTaQR79yu28NN3Kk85nbatC2S9ARbNDANITuOABHI5tzRSu2OzxBDYoScU76281mXRy4OePMyytRHuiRR5RYZeb6lpqFAXqChf1TAI7fIlEJjZQ65xunSMnvag4vxvaLDNPUa3FAekiQJLe4JVPrJa91YA/riu/tm4eaId88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333438; c=relaxed/simple;
	bh=xtv6sDi7m6aeBrIE+wYVnUSxWvDrMu4sjvSBvi8vnO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gy4X7Vvax0Jt5FS9IntHnDmNB68yjFpn7ooRnzmrZuw+URl8TVacV3/+ivenFQPanF0JbdAvMM01hh2kl7qetPwQ3018dhxv/elVhDJ2mccp/Z7JYBwwfeMCsuiaqlqkaBgI1I6RDVEcjOH5iFPO03YT6kRXKFs6blyBM20LutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=A+UaiZyV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="A+UaiZyV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so10385245ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785333430; x=1785938230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9m87LSvmyMwoUxnztNDZ0Cv0nd1knfLpg/zZDbXJaQ=;
        b=A+UaiZyVAYlQyz/wZNpouRprSioiTJhFV4KfGYKtLIByE3iWhsLJTs8g96OpfvZzUQ
         YiDJ9mhg7iqmltSc35pnEIUv7gu5onv9yUIorBtlb7I6ga4oWdV3lBitYSougFR/Db7n
         /GcE2a+DA2lZb2TtI+tXZhK917mWYxjWQ9Q8O1KZnkg+LUuZdyLHLV1slxC/ApCdzjlN
         NbDgjj3g7Oko83V5a+tzUNqRZxQUUcl9PZfuykzZAIBNq4AZ7GmCkGposEZNpjUU8aRn
         UqjYT/R2kjfKU+I6RrkhWbZmKAzOIk1o/O0GEiMviqRVOpM0tISYJNL9qFWjpQ7JBkRA
         /xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333430; x=1785938230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9m87LSvmyMwoUxnztNDZ0Cv0nd1knfLpg/zZDbXJaQ=;
        b=LApyzP69CS2nT1/QHuWhkL1J7EdCXQCgSrw9/gnVtQ8f3K83wxR+u6glvwx5icMe06
         2Ly2NDJEc8msx5ZUsN50xrPnADPMnbbcmAO0mXzEzhdVDbKE1siPxjosXtUgGlg6m6Hb
         izelNJbw1gDSW75CgT/Xo2ewow5A+g983sS2R7YdEC1q+vxC7r6w/7jST1T6QZPcghfS
         xhs1zis33oQWOBe9QiYvAZPw/rNCkJj6y+tuVNcQJFbg6PZXpOV5iF6K+Zr6k95yqCVP
         fFZYT6nbhlgaH8GX+DPecHi+DjdLcBsMOpseSIlCsDnCXz/B1bcOcWYWh793ftf18PZP
         QjDA==
X-Forwarded-Encrypted: i=1; AHgh+RoeVhiUhx+h7sfhRhboBMdprMMKxQL/y/7YoI+dkneUrrbb+2TnXcrkUOc+YbTQ9U4cRUehaSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzH2tkZjm6aAWUL90mEsPKu1MVWnOctPRBwbJzVAxbDJmPmiKR
	rNUbgV93tF2yFbyaslUJMPyaF7DpW/Tvw+bDEsr3TA6+ZB7cxomaGdZ9+VsF56+psr2Y
X-Gm-Gg: AR+sD10HFHJc3N+LuuG6qmp2mAoMgZzFljyuwFpJLUodWSzpTnXDVr90askFA+KwTcR
	8MbTprTOKYxZ7u2jJgHYGXx1vA7ThS7CSKnD4EV8UOCbADih5I6mcREfp5HrY7yXw1WfVbEH78U
	bpXU3Ig9naW+B4l/IHqXbZI3RU2P0Epx3QHBkcMuIc/9YczgVRrKX2ynMTSuuqrNoCDp4tOyg/U
	rk/gtUPvuNP64DcKfu+z7muYAA8L+omE0GcfBSygMQrczxRtn25/HzII2sQo514ZRwRpluylzGm
	CkVYSrOW5aWm8LYpa0QvN+zp8ghNDjRzgsftpjVQpEa5OB5hmNfN5SQ2F0+tS1vHsfGwPkJu4uR
	AsMS3q5fYES2eDTj+tzQQwH7jVYXT8ENwVhQSTLZcfPNYiAd9ysdrvH/iLSguZWxXra72HzV2Nh
	ZvkHojw8aujsnpc/BJx1eyERKVFJamnCjgDC+2HWOm6+L4h6xcNyTHyY1hdojljyCUP81GszSIP
	eFx
X-Received: by 2002:a17:902:ce0b:b0:2ca:6d2a:871 with SMTP id d9443c01a7336-2d015d511fdmr79672115ad.37.1785333430367;
        Wed, 29 Jul 2026 06:57:10 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc5afasm11837285ad.46.2026.07.29.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:57:09 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	ja@ssi.bg
Cc: horms@verge.net.au,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jwiesner@suse.de,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf v3 1/1] ipvs: stop estimator after disabled calc phase
Date: Wed, 29 Jul 2026 21:56:59 +0800
Message-ID: <154d1474f8c36c34d9b86c7ca1b33d73f5435241.1785289432.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPVS estimator kthread 0 starts with zeroed chain and tick limits until
its initial calculation phase completes. If network namespace teardown
clears ipvs->enable during that phase, ip_vs_est_calc_phase() can return
without installing positive limits.

The kthread can then continue into its main loop and drain
est_temp_list with zero chain_max, tick_max and est_max_count values.
Each enqueue consumes one available tick row, but est_count never
reaches the zero est_max_count value. After all rows are consumed, the
row lookup returns IPVS_EST_NTICKS and ip_vs_enqueue_estimator() writes
past the ticks and tick_len arrays.

Exit kthread 0 after the calculation phase if the kthread is stopping or
IPVS has been disabled. That keeps temporary estimators from being
drained after the limits failed to initialize.

Estimator kthreads can now self-exit before teardown or reload stops
kd->task. Keep an extra task reference after creation and release it
with kthread_stop_put(), so kd->task remains valid until the stop paths
consume that reference.

Fixes: 705dd3444081 ("ipvs: use kthreads for stats estimation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Keep an extra task_struct reference for estimator kthreads and
  release it with kthread_stop_put(), as suggested by Julian
  Anastasov, so self-exiting kthreads do not leave kd->task dangling.
- v2 Link: https://lore.kernel.org/all/03a7ee4873f9dfc51add97df5b67bf0b0d793dbe.1785211268.git.zhilinz@nebusec.ai

changes in v2:
- Exit the estimator kthread after the calculation phase if IPVS
  has been disabled or the kthread is stopping, as suggested by
  Julian Anastasov.
- Drop the later enqueue and drain guards from v1.
- v1 Link: https://lore.kernel.org/all/6359e0031f0ee7cc969bae3483308de362d3c709.1784878022.git.zhilinz@nebusec.ai

 net/netfilter/ipvs/ip_vs_est.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index ab09f51829512..05a216a47b45e 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -191,8 +191,11 @@ static int ip_vs_estimation_kthread(void *data)
 		}
 
 		/* kthread 0 will handle the calc phase */
-		if (ipvs->est_calc_phase)
+		if (ipvs->est_calc_phase) {
 			ip_vs_est_calc_phase(ipvs);
+			if (kthread_should_stop() || !READ_ONCE(ipvs->enable))
+				return 0;
+		}
 	}
 
 	while (1) {
@@ -270,6 +273,7 @@ int ip_vs_est_kthread_start(struct netns_ipvs *ipvs,
 		kd->task = NULL;
 		goto out;
 	}
+	get_task_struct(kd->task);
 
 	set_user_nice(kd->task, sysctl_est_nice(ipvs));
 	if (sysctl_est_preferred_cpulist(ipvs))
@@ -286,7 +290,7 @@ void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd)
 {
 	if (kd->task) {
 		pr_info("stopping estimator thread %d...\n", kd->id);
-		kthread_stop(kd->task);
+		kthread_stop_put(kd->task);
 		kd->task = NULL;
 	}
 }
@@ -526,7 +530,7 @@ static void ip_vs_est_kthread_destroy(struct ip_vs_est_kt_data *kd)
 	if (kd) {
 		if (kd->task) {
 			pr_info("stop unused estimator thread %d...\n", kd->id);
-			kthread_stop(kd->task);
+			kthread_stop_put(kd->task);
 		}
 		ip_vs_stats_free(kd->calc_stats);
 		kfree(kd);
-- 
2.43.0

