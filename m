Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9434472790
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055225; cv=none; b=FW1NIxK38gJvCyyR1pnRbN9WBfmbieVM5uV2mRHorMEYiW+HUo9cptNjDhT/h43r7Dk1Oja9nmyNWsrLdER0+/yDghcszO4XmZgps4dloauE47lkW+solL7rUcP5/SUFqI4fAIonQWsTidgbwkQrG53PwJO+rg8anuferqUD1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055225; c=relaxed/simple;
	bh=Ii9lwem9EkDjv0cYDynTTum9s0aLqYGbp2I2BsJdr8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYKDm/gu4JM0jPg66bIRFDEVmiDUVtqSWNRm702Pj+aecBZv4NMA/6jGQ3dj8sa7x8D5+JhDJwVU6S+FjLIwZpnvSu2fM9YARGatIaMtzPlOTz/XVPDoi5pnLivbYrgRjcxicmJJi1MFU/jMUr3HNc/xMNDqi3bJecZoFzo4mwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=cJkR8Y2k; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cJkR8Y2k"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5719517eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055223; x=1775660023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWc/mxYDNsSJe4lWukDMa+V4HYOH42kQJgvqj3DxJqA=;
        b=cJkR8Y2k4XzqCrwOwC0J4e7xRyA+yJpcMLJjhTYd3ydcEnwxBlBK913Z0iawUxJ7iB
         m1gmrWWIFF1JKqwVjiSNkHbJdx0Gte3eCPsFXfQfZPCyKaTUle2iolxHHMSY8zQmYo9E
         0M8k58JVFDwmShvH+AO43LM4oiPYxtdUuuWoekh5v4NTEy7CTfF8gagGbxR1qZgy3gZr
         vurMtBhY5gui1qHBcS5IWp4UUcyJQBqgjWZBS+d2C9Sqq2GVbsD5aN9h3dHt4cMiMU8o
         THjr314jFQIhEnXF2pv3kDJ5M1t/dz7cKAFCC71jlN4vyWsU6x6B7H2H1lTp/xIB+VKN
         rMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055223; x=1775660023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWc/mxYDNsSJe4lWukDMa+V4HYOH42kQJgvqj3DxJqA=;
        b=g+mXGOVae9V3fB9ms5VPdnjlrW9ZKaWnOofmnlS23iZlSqi0tAlJmXd1etdSTHgnDw
         JurGKzMdGF44+QLl5/tb8s/4ZDKTu6jrgEpempDSqa6Mv0jcnU4Xut72bHTSJRUSxG27
         hsFCF6kV/XjwuxVkro6APXLgeQWc0i2OLBHNtW3f8byn9FI/W7SKM4nKZBdifhVpYtB6
         0kUkqx9Uv4oTnSMv9pj3FyDRK3UBEwnH/HENVkkvGJX6vFi8opclzBXeKvHIyZ0GfNtH
         SIzpVKd+4r4AlJWnohoY2WgUX8AgIVlmBMDlRqr3NkhLnpFMt5h/wbDt76US8TRiwTgr
         RahQ==
X-Gm-Message-State: AOJu0YzS6pPP7ZM6I05qFsLwQ2a47N47zzozqwGNsss0er/QT4WrqEJs
	sVKLBkTmhLrEVBhD/U8ffrbYXehT9n2Kkc9zRHWznu6N/Dle1ykASzcc/Na/nzuwol+JXYF3nCL
	Hbmng
X-Gm-Gg: ATEYQzz62XOj1PkUpDf0kjJltrh400P665BGKj/+bF06scEtdhDz5wacZ0X5LB/MeaA
	cc6RP0LfEJIfQX7ibWP9wrzRQHJT4lgIHme0LF6LNFJCfQUIwOIZu6+YTzkurDPZxIgwK0WAhPB
	r/HzST/Vn3CncPzpX/pjaz/0cQg2T+tome1yCHbEhgoo6koUkvjFKpW3u2Pgqzet9L6M+K0LU8S
	KN416cryG1VF6rwprCBexfrwAaI7VtniwJ4xoQF9Sk4fcehZLUohwxDyvwRSj6LvrYFflA+WdbS
	Of7A3ndcbvTQN0W0VQ5ZEEt3Lds4goDoRGnNTvhcOwKO/+deR2stUFkuklpU2Er64fcn4MjP72k
	P6wN6HEEGevNtUSCdnnsVAEX6B3BcBNxuyoAKMgU07dIao8b3/2TisLJlEVA6LyhQ0HfycjRmBe
	qTCi6LtuUh8FOkhDgR5JI/tnkzKx4M12Rg07uBCEqtd04=
X-Received: by 2002:a05:7301:1017:b0:2c1:67e1:61c7 with SMTP id 5a478bee46e88-2c93116404emr1855528eec.11.1775055223112;
        Wed, 01 Apr 2026 07:53:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 6/7] net/sched: netem: check for invalid slot range
Date: Wed,  1 Apr 2026 07:51:58 -0700
Message-ID: <20260401145332.78285-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 4b27fab72fef..ca4de7ae6f2f 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -882,6 +882,17 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG(extack, "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1095,6 +1106,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_SLOT]) {
+		ret = validate_slot(tb[TCA_NETEM_SLOT], extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0

