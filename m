Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E9389116
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991167; cv=none; b=PhWt0bzt9L8mSuYo39dB70bq/k8sqbuCEj8uqRoah/UJ5oQemwJqY7/J7AbXKQY55zf8LHzZE5giyWhfg7qCHFXiHNLSyKQe0aSVTS3dVwlRkQy5cokS/sYFkzMKthenqvB5PrwfrYWgiMxzjCLCc+vrkEFfJuVqajlQ/7ZyJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991167; c=relaxed/simple;
	bh=quY2v/bxKM12diO99BUeH4YNwCXkhOs+d0lDHqZyEAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns4WuFtFUEWAXw/YIBrXwiKSIQ4fdnXQSht3byMwtQyCHVmqiCMOvactOJ6R7TnrphK2gXbllJFLhW2QME0T/ZJwFVNnNnvh8JkaQHjF7I+9CPD/kxTxC1XMglLXwmJ0Fz1378+IJQ5Gq41w2bB2BhFm9iq44exXq846fiudHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xD3axaAZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xD3axaAZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93900ed2925so143140085a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991165; x=1788595965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8mUybPresjzuEz0a7d65wBNDKIGpxh5TFrub1P9rfiQ=;
        b=xD3axaAZYuhVRXsKI1U+A8azo59tHPPS6sWX1ssFCfjsR4NsO28UPpr+fKr1zJF8+e
         gYnePJhODexJcKIevPwFwxsiWUOSzJQL3LxhY8KvzlgiOggVxLbnqLZES+aXTrsI/fXB
         43RQ20iiKkgMFqN08Vv702nVz6SnDC7rJdNxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991165; x=1788595965;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mUybPresjzuEz0a7d65wBNDKIGpxh5TFrub1P9rfiQ=;
        b=Hcw504Il+PvuuUHxZJIokdJAJzd+vzrxzEii+jFt6iXKhNjvgm6XCqZYfaCSVdq5RO
         J9zd6r6Aoe14Hs7BhDXpkZzAPKgXf4u3X7+phZ6PkicYum22S3H0GeqXEcEdqRgkjl7a
         VffJIxoJtbFizABpknP3Uz4VYZwnVoWl4LHbdApiYho08LRAFP23cGCsOA3AUzOO6YJF
         Nd73BJQg/ju/L4zKIWpdZ7c30c9kp9lrLp1MHXUi9c5c0HCKAmLNQHvSgwfo/62iC2a3
         YehwLYixNjf9e9ANeTTatb3RlF607JGSDD0Y7/x3aharrENCvMx9dKclrP/0eYAgMnZb
         f2vA==
X-Gm-Message-State: AFuF++l0VFJPlq0a/GntwJmegG0xoNsMEJ8o2M++34hjLNPOgngWY+s7
	0NCaHPTjPtbQTeK84rEzzjjLGj6XEue5q2/AMOd0pL/nee6J8DlWctQfjy1kK1meZGkAZa2Nyvr
	k2e9I2g==
X-Gm-Gg: AR+sD129v9qD90X4QY6Ali+/+CVUVDGbMNkOOmC8dPq4noC1V2sybzZcmxU/wIuwpOA
	Zk5CpgVKvkcGtX54goL+knUjG8cOwVMnhTtkJ+kdiNecBZmOIM7lg8oV7lvp3ezDjUj8jNxUI9i
	MuF8oX/atDKTPOMQN4s6wA0c50n8TRlgA/k3F38erlMyZ+kdCKN+mHHZkLT73inKS9ptZOtisKI
	HHj+lJsNcRIDum5FbBTxacL3XO+XfnFjc5d9pjyJ7P+NBgnxPYWckJUE+q9bt8tjFs29mxiCu83
	90NH27ZbGjLaN5uGLaWblxWqJM921QJQwEFzXqruCdlGOT6YhZNRPcAkDEJRzKZ6I0Af5gVNial
	F8XVarHCoGpNGOydBcNuU7VkjtdBUuCeAc8XsOuJLtaHp687qc22rLmIBg590UpOORfnWLDFxsC
	khzSsxjHqRT1exowKHzDBv5AeqIUtsZeZVKTnR2/nxOr1iQtDIz0SdwcCkMY/Dxwj2azpnd1X1i
	91j4MNjMPuOhpPtqj8xGUqwmrtMRKVg/fzE413MDY7oXWTOt3M+KrVU/VllF2d8i2WTOo1W8yvN
	G4EJ9mxpqzusgTvcqWHiZlcnHTk=
X-Received: by 2002:a05:620a:379e:b0:939:9b9:c121 with SMTP id af79cd13be357-9391385e9camr1004133485a.28.1787991164986;
        Sat, 29 Aug 2026 01:12:44 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:44 -0700 (PDT)
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
Subject: [PATCH net v2 2/8] net/sched: fq_pie: clamp quantum in change path
Date: Sat, 29 Aug 2026 04:12:23 -0400
Message-Id: <20260829081229.81708-3-jhs@mojatatu.com>
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

fq_pie_change() accepts any quantum value from userspace, including 1.
With a crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1
makes the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) matching fq_codel_change().

Conditions to recreate the bug:
  CONFIG_NET_SCH_FQ_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root fq_pie
  tc qdisc change dev dummy0 root fq_pie quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_fq_pie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b27d95418707..5982847df8f8 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -341,7 +341,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+		WRITE_ONCE(q->quantum,
+			   max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM])));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
-- 
2.43.0

