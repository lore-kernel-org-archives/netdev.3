Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234123914E1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298794; cv=none; b=hvPbjFDRK5Zw3UvGMp+OY2TjFHvGzoK2E43ETIuPwDscAIU0NFvWFxwWLAIITwq93DOVdKtwtvebau46QjAEvETcVBRzVzvk/VjoQFaF4JiFZF/08T0aYlMLA9UluykTBb4/wX9wGnTiMuXdtO/9NBEef0sba7HHxkaE1T7wzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298794; c=relaxed/simple;
	bh=nsyS1KF/Yx0efGlf5bGWpUB8R3X5l3PTrQ+Vv5oCp6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkWKI3zy2dE6e3xTIPi9Fdbe4UaivWLm6h0+ucqRTON8dOH2nseIgdOXzqdu9d4OZpn2jSjqLXPNANKMnZz2D8RD8KeqTXEcjvuiXGaVt4Fp6/FYpHQd5G0kTg89tvAvC2fdMtSVTme609sbeLeZksxbM07fFb0MtCh+hGV6k+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JcZndjuN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JcZndjuN"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cdebdfe63so2401456d6.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298792; x=1788903592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGuYJDHW5gzTbgrufbU1+/mKrx+hmR/Us1xsgN+1wt4=;
        b=JcZndjuNCJkWTFpunwHLlApLqJmf1J8QTXN6i/njvHRYpFZyuDcNgzjW4U2dVMWktl
         hvayOzuczbd/xeDtK7lRpZWtyjHfK/MoP1cKbbf9Acd1a4F6fcurCataTY2waygAz50S
         CkbvKrciUMjpiFo3aE+AHSkY2LDDrE29T7Lmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298792; x=1788903592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGuYJDHW5gzTbgrufbU1+/mKrx+hmR/Us1xsgN+1wt4=;
        b=McsANLdI/3j3DVemCarWk4fDiMMC7dBXNcRu2DXGBdvIhOg24yafm/kxHFT5rBeRNt
         x9V1xu/WNM8aruz77mPb+L5zuYCRHBn0Y75o7DQ42mlTCczP4AaDODuPPqY05B8emBgh
         huxCej+EoB00okG3PcAWVp7Toev84XQLKYDmhgPijOWalRc1VzVyaMFEh/+SRGQ4PJul
         svBTaDrh+hietwtsEJZTd9WIpEL6uw8FcpiDd2sbpSLjUp8JYQlvI5nDxuWPpF3XTkr5
         f8G/QN9JVurxuv2oO65e+/RApMzVB2jIoYar7Txmm/p7aRyXAXI4Vc8xx4a/m5BPs5Gp
         M+oA==
X-Gm-Message-State: AFuF++kLDKiyjFW5dvimi46FQksh0ll0eUfuZp2HE8u4PTR7sqZ5JMPF
	GkGAZubM3pbd9q5nNGw4ud8ToY3KBefoUnlY+Ip+k/FYb+Fw/lLMjhs5Ikf+NaIpycBVwL5oaoH
	QzrmC/Q==
X-Gm-Gg: AYBFou3jb5dT3o4AGDvBfiCEfI7RaszxJBg7MBhW47DJpg5veMbhq99YRAw3DkWLAm0
	zY9OUIBJ/l5hkn0gZFz6NPtnW6+FEMv+gQyQ8WEOwgP0Evg2GcEMCRjlZdkUk+pHQaak3anDOnM
	kXLzc/TxzKMUxccRxp5TQga7fX8iAYNsOOgiWPNhSktBm5XFK5viKTTcs4ndGynObn3R8ixOiEs
	lWqm36F+7s2WH1EU2/II5eJ1bAAQ++S9aaNqcGkwWkj7I70FD39D8IKhD2CWCPlZ4ggo20bBJEw
	hEm02Dwl5Cr491BWRPOPQouAxU61//oiRPRRDYWMTa9wFmuX6ke5ud40I1OCW3BR6Hp10atqWox
	G2OuOpCgXCpc1yjGlrO72ewNuYIl89Z8S6yH4S91PNi5LX2c/TY2RtYR5nkC+X/Z9XKO/NmJttR
	ETtq+hr78z2SP+hFwC5tWzs2/eXvQHG37b1DXsdsEbFd8nS6AUx1IZVu7CysMyO0DDKH0G0irJf
	0zlS5Kiewk0krw3y+wp+Za/kGLnTBgpddJBKA==
X-Received: by 2002:a05:6214:21c8:b0:90e:996d:b6c3 with SMTP id 6a1803df08f44-90e9f24be39mr8398246d6.11.1788298791895;
        Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
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
Subject: [PATCH net v3 4/9] net/sched: hhf: clamp quantum in change and init paths
Date: Tue,  1 Sep 2026 17:39:25 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.5>
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

hhf_change() accepts any quantum from userspace, including 1. With a
crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1 makes
the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) in hhf_change() matching fq_codel_change(). Clamp
hhf_init() to [256, 1<<20] matching the siblings, and remove the old
fallback that only set quantum=256 on overflow.

Conditions to recreate the bug:
  CONFIG_NET_SCH_HHF=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root hhf
  tc qdisc change dev dummy0 root hhf quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96acab6a8da0..fc72f825fbd9 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	if (tb[TCA_HHF_QUANTUM])
-		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
+		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));
 
 	if (tb[TCA_HHF_NON_HH_WEIGHT])
 		new_hhf_non_hh_weight = nla_get_u32(tb[TCA_HHF_NON_HH_WEIGHT]);
@@ -613,7 +613,7 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	int i;
 
 	sch->limit = 1000;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 	INIT_LIST_HEAD(&q->new_buckets);
 	INIT_LIST_HEAD(&q->old_buckets);
@@ -624,10 +624,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
-	if ((int)q->quantum <= 0 ||
-	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
-		q->quantum = 256;
-
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
-- 
2.43.0

