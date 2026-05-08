Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C4372675
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223495; cv=none; b=SBhhZyr+OcezbDC76mXUPV4UtmHEySJ1y1ozHwTSlO7TRJJUsQ8zIeavsAKhtW2KqZYiXApCk2cw3zGkLnWAmvt4CjOYlz4+fzS4a6TjJKb3Azf2Hby1zdrQrkVzhoZVLoYyCk1Uj77aqaLlUQcEy24EqxGlA7C96R5yNHnOFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223495; c=relaxed/simple;
	bh=3STGZFIGp1QI0P9KYESK3j78npCaPdnySXuzfK9UW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWcAZ2S4jiXIHBzry/IhKLmCjzAVmr7WaZmsqAKyP4Y5zMGRul7HSpsx+pW8sygl0kdnqPc3jX1XeLGZdtzAlToTAsGgdn+NxO2yqiJSaus3daOvdEKdZPEVLTXkvFG2nFIYjtnoYwm8zF7Ps3eYkLmEzn+nzbe1YFx/83YXpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXg2q+vJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXg2q+vJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2baca78cfaaso9796375ad.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778223488; x=1778828288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=VXg2q+vJj7ofj3pbGGn9m0Z75t629Mn48TrbmSEn1ZuTIBnPBoYVO6bDBdwJvLKcEn
         8Ju4ON/1zyEveUw3lhme/ZEzETFT4qmXeqGDBYPdp06XHpwQ3htMGQljxuEJmqPSK34M
         nWcwVAoTFHJunsNS91dLoS7+eyyzfo77YbAc61vrBEO6/8HJ331W9qzi9LBtG4U4S2g6
         X32pqYdKwm++AirlgdcG2t7vvTp+vTUoHNpdrjivDeBiXL7KDjrfSYk0ns9Cq3Zfmarv
         nL4sKfjGrzTXf4mB9X0JB6nWrFhXRN5zKx57zR3GHD0duPFhZVc29pXR9a6Goa1t60pM
         t8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223488; x=1778828288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=ReuMQPLN6CvREAxQW1cQLijecbHlydT9WVF6q85VJmMKsiP9xdX9/IoGVoIqkEkd0d
         lb7C0d0trRCyCdapy0VGC6xW9cacEYWeq0YQN+9afmFz6nY0NYd8faRam9TmMMn3JjYx
         Veque1dwxi5Rx1HCWP/K/T9zaMVNsxzfVx4kqR7nEKMe9rXFyWV+oxUR3h9Ff4I4o9tO
         RfBOi35fuH83ToSFpBULsE6bEHAodnlGNHI78Ccm7u8ZA1bY2F0bDYsP8V5ji06uPJDt
         uAqDZb9K1/wbg6L7MZ+CfomgRU/qq+GBthcsLb0+BZ1IRoUs2C4nv+Ucbf5+SME0R9vG
         yWPw==
X-Gm-Message-State: AOJu0YxWJaddJ5qi8XplzQOd4+lTjYW24Dwk0Dl2BmZFixIy4TlDVhIM
	CtSfaaeBjE2PoDN6cP/dX7zvXGkFMthqSchb1L0z5qb8l/iOmvhJPy+cOIsfiT0q
X-Gm-Gg: Acq92OEB3+lH0WHsZ8yCS20u8PCyILTszpuPmm+Kr3OjSOgV7M2pQltEgD3k6ptAcgq
	WUcls4wxqHpqANvQ5/ZY6uSVn5BoZT6NNHcn2JobZXMYAObOxFmFF0gsfApTWxpmNPfiTs27dh+
	TTbRkpTLMktkWiCcLKvm1nq4K9GMQOVYZx/AnkVF3avNPY2gi9ClXPL15U6LT6yS2wfZqyuJ8kg
	YLzhP/p2OuK6rdb9OCelByriXqtIlTX1IcwLT7dlk3tksePc2iIFDzTdJ5SDeUhBuSjiYn0NZfm
	kWL8Grm4xiV2RBAonjPaZteoG1Cdnxa2IgpN84KyUMPW/5OUwMHSdZH6YfpoKyb1Ub5lS0vGVjC
	eHtALWhTFCdEz+bqtdBNdmwlmY4qtMIbDk86OOPAVhZnQRWv02uTZqgb4ZggApSPUH/eA4Wj6Lo
	eZOUqn/nnffnBKxggSsl47XDrNDhh8H1R3ujOfKdcLxElHtvvYyA==
X-Received: by 2002:a17:902:d2c9:b0:2ba:fed:7891 with SMTP id d9443c01a7336-2ba79bfca66mr135479575ad.30.1778223487880;
        Thu, 07 May 2026 23:58:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35bcfsm9488785ad.38.2026.05.07.23.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:58:07 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net/sched: tbf: add extack to offload params
Date: Fri,  8 May 2026 14:57:52 +0800
Message-ID: <20260508065757.2566258-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508065757.2566258-1-mmyangfl@gmail.com>
References: <20260508065757.2566258-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers might have error messages to propagate to user space. Propagate
the netlink extack so that they can inform user space in a verbal way of
their limitations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/pkt_cls.h | 1 +
 net/sched/sch_tbf.c   | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 99ac747b7906..3bd08d7f39c1 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -1046,6 +1046,7 @@ struct tc_tbf_qopt_offload_replace_params {
 };
 
 struct tc_tbf_qopt_offload {
+	struct netlink_ext_ack *extack;
 	enum tc_tbf_command command;
 	u32 handle;
 	u32 parent;
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f2340164f579..4576111fe075 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -139,7 +139,8 @@ static u64 psched_ns_t2l(const struct psched_ratecfg *r,
 	return len;
 }
 
-static void tbf_offload_change(struct Qdisc *sch)
+static void tbf_offload_change(struct Qdisc *sch,
+			       struct netlink_ext_ack *extack)
 {
 	struct tbf_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -148,6 +149,7 @@ static void tbf_offload_change(struct Qdisc *sch)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
+	qopt.extack = extack;
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -166,6 +168,7 @@ static void tbf_offload_destroy(struct Qdisc *sch)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
+	qopt.extack = NULL;
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -176,6 +179,7 @@ static int tbf_offload_dump(struct Qdisc *sch)
 {
 	struct tc_tbf_qopt_offload qopt;
 
+	qopt.extack = NULL;
 	qopt.command = TC_TBF_STATS;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -193,6 +197,7 @@ static void tbf_offload_graft(struct Qdisc *sch, struct Qdisc *new,
 		.parent		= sch->parent,
 		.child_handle	= new->handle,
 		.command	= TC_TBF_GRAFT,
+		.extack		= extack,
 	};
 
 	qdisc_offload_graft_helper(qdisc_dev(sch), sch, new, old,
@@ -477,7 +482,7 @@ static int tbf_change(struct Qdisc *sch, struct nlattr *opt,
 	qdisc_put(old);
 	err = 0;
 
-	tbf_offload_change(sch);
+	tbf_offload_change(sch, extack);
 done:
 	return err;
 }
-- 
2.53.0

