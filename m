Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70801343D63
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031600; cv=none; b=Y8Cb9V07nz9nPGxneiKzO4bj7DNOYneyHXtwiz6VjtSRSSgawv9TNOpqIPZarirkytCPRZM4pn2o7VCUNnOYKODu/weMiHCghuTtaXmnUtZuOOFfhFNBDVEx4Y1dVuk7nz48DorysbKJ2HbWZxEi9l3JEBCIiHxZPmHe1Tv7SMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031600; c=relaxed/simple;
	bh=IlPNO6h64dzde9sEoFfmqcy7n3fnw181CGg5aWGNA6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clmq9cNJnvzbDnN6AJzzjNdJii8HnC2xv67S5Oe76ML0nd1q/vzou+pDv0cHgHjmqY34QeJ5At8CQNDCE6ynjNoVRzoFWjP//MxzOxElgnyEFb8mJjaoRdSRxvhfIpIojZQR7HM3UEeut8ltck5diLnfgzMNcbfcSVbNBx5VU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBYj4c1w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBYj4c1w"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2754883a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786031590; x=1786636390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bepp6zA/Am+6rt+WJfUodekIObVIHKI590Mp5eLrSYg=;
        b=rBYj4c1wowF6jyrNjJx1QyGT+Qwq2PftBlxq+ori+MRfH/rDmjDus1Nkii9ApZALZi
         3sic/B5H4rg+1/9taLq+KeComKdKgZLg/NDrAoqWCgIG77rLgll/36lNBvMFb1R3omdE
         DzrV0iivHUELC7cYdzW4eHjQqrjlrnqWV52Bci7xEHoJA6ZUUdjtD+0PxQBCnkoVRF/A
         WRUCK4DenNlqeKf2Xk6XoVdjkW3Om/ijH5UufeiDsFIgzGTYIsqxBOgBU6lUeSqVjSAL
         t+H1gxCSpDvAhibnLT0iMwOmsU+lPSXpklK6gT3nmnGziPCcb2AuvZPrQT8A1Cv2KSkI
         WGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031590; x=1786636390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bepp6zA/Am+6rt+WJfUodekIObVIHKI590Mp5eLrSYg=;
        b=rkX0CK+QicQ2hlGTQaRHi5/g/W4/npARGUscX/J9ECKv3wR77Peh31TWUS85JGEQMZ
         KDq0ygQWhS8Ge5K5EZJ6rAYEICLZIY5QaYDbCRdVd5PaxmFDashRTCM2tUtmfBc9Nw9H
         XsvHjFy+Wt2VcUi9fma9eywr4WxOrqupEMjvlxhCyzruBy2LZCXOMHW9abgU2N0PiuZh
         pFjsfehdlkEQWTWip14PZ2KBYAXlBPTqdkM2sk7BcLkjdAQFtDzjBse5hrY1tZZnHwOx
         JHRjcBwDTRspuYBte78EaV1+JO5t6zn+OC3ZA7P+tNh6pBllzjt5iM7XghptpSFYY2iZ
         r3wA==
X-Forwarded-Encrypted: i=1; AHgh+RrMMH4oXtizZ+twde46rFpyOtFjpmz0t19bSLFGYGo7JM6FwsUxDMd0CmZCoCRFF6dhJoQJY/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSWosWdW/x8hg/lQqol6YpU292FSamhkL4qXpbLvwa7Yy8Lo9
	ACr0UT5EmrqoxeuNPalQqQMZWgBibl3MpENCo5SM+SZhBXisc94hwojM
X-Gm-Gg: AR+sD10lrH0mdvTUGceZOu/yGGXq9myk4DdsEpzIjwc0RiYKia3iVTNAC+W8u3o01al
	IBxvPp2uaIPX3UfI65++eLWQ+BZzOCt9kdWVz9bRuMEX1kqBzCwZg2mr7kyQlL5BPbzSSL57xx4
	wap1nfAIMpmaA9xFsNUegKPGPNHHfZjCrDN6Bxw4xpuWBbvWoPa8Cl+J7+CiT7GbFTrL3Xy/Pbh
	3v3nIvl8UlKIRchzPmVHUD0mqTFb0YRe1Q75RUc86as3iLsG7VBohezI1ncTVD39Zaok5BAgz3p
	Qgky+CZTpzopikKbFDLv3JQ6YRJfVqhpnNqTqkNapHLuHCr9n5jaybvmRyJq5dt1aO+RIw8PLE3
	aanLNcO56OFFhUJk19znVXzqQFSk2IqB7vZC229yOGSJTKGucL/vQ0+vTj7GqWVnY3L95HhOooQ
	nrY9VSHBdU906d1Gic3/r0uiHow1yrJLYC38TWkB6t8nNtcFvqZc8aRdQafXbSoGmCLFbhmZGdD
	ysf
X-Received: by 2002:a17:90a:dfcf:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-3903c5589ecmr17084685a91.7.1786031589807;
        Thu, 06 Aug 2026 08:53:09 -0700 (PDT)
Received: from localhost.localdomain ([212.135.212.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5b98csm1774377a91.13.2026.08.06.08.53.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 08:53:09 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Jack Wang <163wangjack@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: cbs: perform rate conversions in signed 64-bit arithmetic
Date: Thu,  6 Aug 2026 23:49:05 +0800
Message-ID: <20260806155253.50252-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cbs_set_port_rate() and cbs_change() multiply link rates and slope values
by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
the multiplications therefore take place in 32-bit unsigned arithmetic
before the results are assigned to s64 fields.

For port rates above approximately 34.36 Gbit/s this wraps port_rate.
The same conversion turns a negative sendslope into a large positive
value, reversing the CBS credit adjustment.  This affects software CBS;
port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.

Cast the first operand of each multiplication to s64 so all intermediate
operations use signed 64-bit arithmetic and preserve the value's sign on
every architecture.

Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 net/sched/sch_cbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 1c93469c56e3..9ef31ecdaa05 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -335,7 +335,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 		speed = ecmd.base.speed;
 
 skip:
-	port_rate = speed * 1000 * BYTES_PER_KBIT;
+	port_rate = (s64)speed * 1000 * BYTES_PER_KBIT;
 
 	atomic64_set(&q->port_rate, port_rate);
 	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",
@@ -405,8 +405,8 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Everything went OK, save the parameters used. */
 	WRITE_ONCE(q->hicredit, qopt->hicredit);
 	WRITE_ONCE(q->locredit, qopt->locredit);
-	WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
-	WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->idleslope, (s64)qopt->idleslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->sendslope, (s64)qopt->sendslope * BYTES_PER_KBIT);
 	WRITE_ONCE(q->offload, qopt->offload);
 
 	return 0;
-- 
2.53.0

