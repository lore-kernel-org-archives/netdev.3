Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6223D7DF
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859084; cv=none; b=ZXQU8myhRo9Irs2jwf/eUNkkjYJ0lD/d5EsGhlYiP8mrRstgXWx34I7LF/O+LFdDs4xeDdnJe4nkwVgTi84D4P8uaRNus5SwdFDgWMRl8IfiyPl/kEHYVb5+Re7w5OJ/DgSHWOja1GqdaehkcLK4Bg/3cdEOEX9HcQsdK9oKf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859084; c=relaxed/simple;
	bh=h93POiGEUTG4KuSQpjrooxytVYbRU7HYxJsZcFsAaas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxq21BEA45PhYnaUUzr6MZAKidWUO8em+XHASyq4N4fI7cCVCHC5R8A9FQlMO6R3YIDtgTLPgFzyk6xwKUGADuP5M1oThnS+cAnHpiqr/S9V80s/TW/du6oyawfYQtJAnmlSG9XylBXgtZ81wm/Dl5WMpUnB0W4Hb5Ed55BXWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yiO0KhaK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yiO0KhaK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd68a16955so27071495ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789859082; x=1790463882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hCChdlp7YP2EEzMX5RTkbvcJ9LqXH00VB0lE3U0rgVE=;
        b=yiO0KhaKn8VshwrVdkMpGilNsHOBVzOjSQLLJHgxl9kA9NIfJwEX/dR323tcSnQjzF
         uU67pP2m1HN7aG9TqzrdjuJPY7yis5ygyF4A+Y3SKqZok8bsWiZsclLugCJD+wctynh/
         tZGk+HbaV3abTcdJmZtD+kaeX3GGVTnH6k4L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859082; x=1790463882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hCChdlp7YP2EEzMX5RTkbvcJ9LqXH00VB0lE3U0rgVE=;
        b=imN+LQaWcu8Ig1ucd9vAl/5uhQS6k46zno/LBgB4w4eQGil4oJUz7J2zEUES9orhkA
         HcKRL7IX5FMquIMIIGdn0eFr13EFizWHnXr3i86+c6Eiw+v7/vt1z6+aatkA/P5BKjzP
         zAqVIphfRo/53KS7slAHXU/+THZ1g7WI8w3EhnFfjZXljZLXmGLvdKOxm02+NLXl/oig
         zJlzHi0sapZo8Mxk77+F5b7gjWqjsm+pUJPYhthlEsq+WYpIF7hqR3ti7+8DFOjcf4+R
         YP64/ZvJPKqHeaOhE+vp1/UTgqcnn2QtXixw4RpycxusjRrBc3vPLMJ/4DQZvMfAzwyA
         TMAg==
X-Forwarded-Encrypted: i=1; AKwUvBwClxsEKLU1piat2kPS77z21QZnjx7jLgTb2ZOdUqDnmUjxB6RXvIp64T537NP10kdkvQkVozM=@vger.kernel.org
X-Gm-Message-State: AFuF++kDuaXeT6Lum1nHKKqJqz9pYVKEVJfYwCfzxE+C1kpiYTb2im3T
	mrNTPDOfFVsmPvN44brCnwTyqxyiO55u4PaGjbtHWRd0dekcKDyDfYQsUjdlMi7r8Q==
X-Gm-Gg: AYBFou0kyP0eTAlLYaBIQ4EhaAZZl1xxazXlaSZm2QtyxTCMQp+EXhg1dvNVZstDvDW
	n8DxcpoegQVDY/mDzjrUmgZOBAZW0mEpAYVzSL2CZBZ3w1lBm9TIc1lVQBvq/rY/GRultbfFOtF
	Yw88Ur7vvMOqXpQffMIOYJN15YEoquYq8WmaO2aOrRz2qlKzqyAIJUIXe8fkvIXBdo+L37UhxSo
	FYTqG6uFGEjAqBXnUVDp5SnKlwBMLjkDpvXZgpiRsGhYYe41776rscJCgYIc4R5dcdGxu78+Ioq
	M3jn085A+9jbJ3XuSWMtPAQaf4JM2r/KqxeImRY/ec55mquqU77r/IlCNTR4PJaPsFc/kTle0eC
	dAZEh7EvTlvh5NoiCwpfx5zAxbFwO/cEqVfbqp1KA51aJrSfehtwlCLNPfGbAitG9dTy4CGnqvv
	CTXZiTEBxvaqPLw3/9sKoiNTSGHwVg054hCSsmOqpwBhgiLx4R0DT5mnj0gZ310V1BndcCbYYnP
	90Z
X-Received: by 2002:a17:90b:384f:b0:39e:455f:36fc with SMTP id 98e67ed59e1d1-39e455f3d97mr11489044a91.28.1789859082464;
        Sat, 19 Sep 2026 16:04:42 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm8804599c88.3.2026.09.19.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:04:42 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	hybris@mojatatu.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 1/3] net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
Date: Sat, 19 Sep 2026 20:04:27 -0300
Message-ID: <QDISC-RYTB.v1.20260918093205@mojatatu.com.1>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
References: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_mirred_get_fill_size budgets only TCA_MIRRED_PARMS, but 
tcf_mirred_dump also emits TCA_MIRRED_BLOCKID whenever the action was 
created with a block instead of a device, so the budget falls 8 bytes
short of what the dump may produce for such actions.

Account for TCA_MIRRED_BLOCKID unconditionally: reading tcfm_blockid to
size it conditionally would race a concurrent replace, which can flip the 
action between device and block between sizing and dumping.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..1c98e4d81ebe 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -607,7 +607,8 @@ tcf_mirred_get_dev(const struct tc_action *a,
 
 static size_t tcf_mirred_get_fill_size(const struct tc_action *act)
 {
-	return nla_total_size(sizeof(struct tc_mirred));
+	return nla_total_size(sizeof(struct tc_mirred)) /* TCA_MIRRED_PARMS */
+		+ nla_total_size(sizeof(u32)); /* TCA_MIRRED_BLOCKID */
 }
 
 static void tcf_offload_mirred_get_dev(struct flow_action_entry *entry,
-- 
2.43.0

