Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B506284662
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613545; cv=none; b=Yfy/h+ZQFZu8asgTYMP/tmqprPWe/VRyl9JA3ZMQb72HaYsYI5to8rDOiAKfBXi4W1aKWV+FcKrhBF7hMbNt7Q3A6sIsFtDanUuZuqaMnIX5dMCABPRl9V4YZ4AQ/FZx+4lcOoOodm80NmgIzAtGXNJ8zZnXv0hkhPfxpUK54Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613545; c=relaxed/simple;
	bh=ukhTjY+tzJ7z8UlycHQonmn8I88AAmwOMyFsDWHYWI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0iNVBiHVlXtoEx8YaQ9K1iKG16zOdVo/wq2Rr+eW8KXqCLb1w1xAiax38DZ08b+Idpp1vBQaW6ND4zTNUZRxrJ5Gw7i/cR45MfrtbNLSu0DodBiG6D7fGqQ4sqV7S5wO8ueeog9z9RVkYn42WumUjuz3hcFBNVcEbL9NbWXOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=RjFjlwny; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="RjFjlwny"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93cc31c18ebso24402585a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791613543; x=1792218343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HOGcAJM0K8BeFbMrcvdMtYmm/3qaO8p9fgso6bpXfU=;
        b=RjFjlwnyFJIvTWueyLZQPt7J2YihG8LDgyMj/lvjJYIKk7Elc/WknssayZgCU6I81x
         ZHNgXXFBNz4fwT7chtrk9HbYR18o90EcRVoOqPpaIXlfU2SYvoDGzircWh0cv14iy27U
         s+1PHfBw+J+pI0N/4VDb0UOHjH4iY32T+uLgYi5uHE6h5VOjfdXc/r8ql1hgLh6L1lP2
         jT+2cJ4WNyhSttHbvqW1BNby2oO3MsHWV2ebLPBtKrj6WDt49qf6mTyMCG7BDixdUAx6
         Dhkr8k3kt+fMyVAK+B1ai7Lz+elvfUep7OjtYl4n131PgyLnH0hMfRbEmOrzb2i686jz
         u5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791613543; x=1792218343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HOGcAJM0K8BeFbMrcvdMtYmm/3qaO8p9fgso6bpXfU=;
        b=nvTFVG4UQikbWaFWGicSvubstMbWGpZCnZmFy+oxgkZY0xfZ3leElrhqjv/VzRFbTw
         92eOlPzAilwsYxhmTtApthow4lHtUf368mbo4YkKBNrB2fixGoY9pCu+4E5LmSPaoiVD
         LBKLVzDZFHrfh8elrAsNO3m22dQj7hYpc4XUcP4CNInSaHvpJbAzLEpDYnDJCsagLybw
         g6Wdtd3SNWXWMnthZodjd4RSsNuOUihe1FTFP2YTMXOlJwtQWz2b3yP3I9lvJ1y12r7T
         L2hvC6CdYk8vdehHNeQD9mlKHTl4jfQGiALtawQvtR5d3WXmVZBPiCIUlaxb3gCti0Hr
         07jg==
X-Gm-Message-State: AFq9FYKo1ubACh54gd0xXqPFO3EXDmgsngZDG0d7irx6q7Q1MSfq+jo8
	xB7is/rrVpDynvIPRUU0SK9DuRJVF7yDqRzkFOGnnWp9cenFTQbGHMHC1+xHhnpm6ovsL39DfFY
	w7oxtqwGn
X-Gm-Gg: AYBFou2V5HCsxyoY2lUl98Lt1Lqwq/1iOn1R179TYrxCYT6w42XKAy3JoYfCPCiskTZ
	YzO6SX1UyzGBSZamrDuFZU35IJ2PVcUmMBNnaYtH7P2non+Wis17RYq9HGtqePHKntQYQZrBcY6
	0rMlhvzp15Uuihf3LTacP5zL0dXgkCOZ0JWiOg3ThOfLYK3fse2onSEycuQ0GUgawHMWDRMpKWp
	cSiCy24O21j+lkmx9luscuuRQcrey0kmAIdLs48Ig7n+1rWbqjoKxMH5779K++yaw9fBBbfWdgr
	LSeeP+rl3CBxzjOLwLXbQmLlpGFeV8kSikAJNvVbBHovoWK4/J0UJtn9Hif8fA9/PrX1F78VFIg
	TD6TCKbXfB8eQgnE87Y2IjDETZUcHo+9lcODWQssJLIageo+cJwgiH1o3oBfnjSdAi8y6g1dYgA
	kinYOUiV2ezTqzu2Mk9vHKJ4iOnr5dDymtTFyWFRQqNmMSiYlSHQuWZoTmuI8k1NKt9/9QRVJae
	0ZsPpTuSo8m1ejvK0Y=
X-Received: by 2002:a05:620a:40d2:b0:93e:4d07:14db with SMTP id af79cd13be357-93ebd1e0133mr669079385a.24.1791613543129;
        Fri, 09 Oct 2026 23:25:43 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e177csm37378836d6.47.2026.10.09.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:25:42 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] devlink: fix reload error on netns teardown
Date: Sat, 10 Oct 2026 14:25:31 +0800
Message-ID: <c43794aa549424b79a0da624e73bbb5215c0e9f5.1791555658.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791555658.git.petalzu987@gmail.com>
References: <cover.1791555658.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

During network namespace teardown, devlink_pernet_pre_exit() reloads
devlink instances into init_net. If reload_down() fails, devlink_reload()
returns before changing the namespace, leaving the registered devlink with
a pointer to the namespace being destroyed.

Move the fallback transition to devlink_pernet_pre_exit(), where the
teardown context is explicit. Do it only when the devlink still belongs to
the exiting namespace, since reload_up() can fail after the regular reload
path has already moved the instance. Keep the original reload error.

Fixes: 070c63f20f6c ("net: devlink: allow to change namespaces during reload")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/11365
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/devlink/core.c          | 2 ++
 net/devlink/dev.c           | 6 +++---
 net/devlink/devl_internal.h | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index bddbbbf000fe..9b844e0c1bd2 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -585,6 +585,8 @@ static void __net_exit devlink_pernet_pre_exit(struct net *net)
 					     DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
 					     DEVLINK_RELOAD_LIMIT_UNSPEC,
 					     &actions_performed, NULL);
+		if (err && net_eq(devlink_net(devlink), net))
+			devlink_reload_netns_change(devlink, net, &init_net);
 		devl_dev_unlock(devlink, true);
 		devlink_put(devlink);
 		if (err && err != -EOPNOTSUPP)
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 55959b0ff5ab..da7bd9015baf 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -412,9 +412,9 @@ static struct net *devlink_netns_get(struct sk_buff *skb,
 	return net;
 }
 
-static void devlink_reload_netns_change(struct devlink *devlink,
-					struct net *curr_net,
-					struct net *dest_net)
+void devlink_reload_netns_change(struct devlink *devlink,
+				 struct net *curr_net,
+				 struct net *dest_net)
 {
 	/* Userspace needs to be notified about devlink objects
 	 * removed from original and entering new network namespace.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index cdf894ba5a9d..798e707002b9 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -324,6 +324,9 @@ struct devlink_port *devlink_port_get_from_attrs(struct devlink *devlink,
 
 /* Reload */
 bool devlink_reload_actions_valid(const struct devlink_ops *ops);
+void devlink_reload_netns_change(struct devlink *devlink,
+				 struct net *curr_net,
+				 struct net *dest_net);
 int devlink_reload(struct devlink *devlink, struct net *dest_net,
 		   enum devlink_reload_action action,
 		   enum devlink_reload_limit limit,
-- 
2.34.1

