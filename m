Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE77385D7F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825387; cv=none; b=jHKUvJPnmWRloqZjWkNxpaut10mbVd4KCzCq93ICGSQq2y+4ZocbzFzN1hv0t+p2myfdgAJbyY7qFNh4Rj92AJRhEQ5ZJ4NWJ9rjBcdoDNaoIJjHtFwoOIBbJ9xdbpc4O9AQAUo6fPkpDiY2NSzCsTbV+HPRhI4n+iRDWvnN5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825387; c=relaxed/simple;
	bh=23zhtYuefAo7j5hUMEQrthPX9DGAfkpmBrwANRlYLMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCvJURbH062LqkVz/SMcHAkSyixWucDfGHOCK36pd4cdy35xPYtg7FtmOvY5OrfV/5O8ns6qwIqMKbZTUUmOw2a8YCtj0LgL6hN2pMZBNJ0l5ZImgH0sjpg3wapan4cY3UpEo99EWlKibjTmbfA/o5AzRMxoss7IVtO4MEajw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVOd3Kkn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVOd3Kkn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so11079575ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825385; x=1785430185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZG4reGgP8P0tHq2LHkHlzPckguQ757kzlwfqLOcAAY=;
        b=bVOd3Kkny/QcL4E3F4cRE8PVEaKpNRKP4QQN48FYJQkr98NhAASFbs9Miv2zAclLDk
         IauMJszSIhTHWz3XU5SAnxqkdr9UBEK16Bp2jPrN3aixI7Zziy0tHrtRQoTQdOCO+AHF
         xS9M925NKsOSfnPiwHyrdMeKpk6zbMhH3Y4LkLDjm/p/uzI0Gw04w7kZ+2t+jTtPWh+B
         viIet2CeT5NRyMN6osCWCCxAESGBOeLS3iDKIwqhsPm4xxBl3vgNCuH1oA+mowJabfnA
         +IUlC5hzZXIiKpGjUs52+DxPp0BizTCKsxK4bspCYjGUXHay/RZLxXOxp6OatvdN3Pjc
         ifOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825385; x=1785430185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZG4reGgP8P0tHq2LHkHlzPckguQ757kzlwfqLOcAAY=;
        b=k8nHwacByLog1/gl783T5lOmxNztqsb+2q1HHub/gXf6hxZXcbsxgy9By8qvG1GUWI
         UiUJ6PHNY5PQ7erLCVR4RrQO0NiU5eKrA7gcp46jLtl234jqQ1gNQTHZFMBW040GjuT8
         NgFIZ0SfigOzosUXfbSOmCL9p85f4gq95N7rAfR/U/jvGEaUgxJPGrmdbIbH+DD+LDmO
         7T+vnU1z6C+kP2L4nBAPtcdqsTSLesDLP7SgKvyiskkBCWHXTBo57ZmTgCus0kx2/0PY
         dQ4OVH/8s/u/4IZK/2dXF5h4tXRyW4BZzYNFvRZf2ohRpOwoqaIWNWQJIZ4hT98rcGy/
         YKAw==
X-Gm-Message-State: AOJu0YyplMsHcC5WVPNvGibLA06Q6dyzCHLfkw9+C3kj3hpUKKaSWh1t
	ySnM60XIYjtw1o0SDn6R/cD60kNM0oEuU3m1TP9fwmPGZiPtBKedtHzpjWHLH42o8xw=
X-Gm-Gg: AR+sD13iPMhNprnZTXTw+r7UAxCLtOylexE94VOZoJzxkTwp0EINSALxZQe/n0JD7ws
	CX0gNC7NRKZqMk8NEIx6+o6Zb5it5alAIWgn5aHkMWP8WzdNBqvFn+0lGsR+xN5PDvYLIda4wLj
	GT/pP9u5vY6rb97VKzNxRes8IJ07Ul8mNFAFSoPcGBMIgRWk681MwS8xiPugdTu2TShEA0KR6Pf
	GQgsqdu8oOO6yyA5Wix+CFh8SelEX+2KutJ1dFL4mDymiag3ZqVAxm+nLsGhfAdPF7FIfcdkMjd
	iIAOHGAu/4jN83gxdkRHWRoCG4xbdTwX5GeVPtSEDgfM0YqGxJbNsAJCbADQKjqPt7pOdQhgC0V
	b/U5teVCXlzAyPlxt86o0DR91rGEDpBvhxIPQ4xM/H9Jp+x2MjWUuNAwAESVTPMBUZquflysIVm
	q4Ov+pc4YGZ+RsFJuBuec=
X-Received: by 2002:a17:902:f68c:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2cfa6f963c6mr43542105ad.42.1784825385087;
        Thu, 23 Jul 2026 09:49:45 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm22241096eec.25.2026.07.23.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:49:44 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Jason@zx2c4.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: ipv6: clear suppressed fib6 rule result
Date: Fri, 24 Jul 2026 00:48:52 +0800
Message-ID: <4b8acb7787d54e440155585dd32ebdf0bef7d122.1784710966.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784710966.git.zhilinz@nebusec.ai>
References: <cover.1784710966.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

fib6_rule_suppress() drops a suppressed route with ip6_rt_put_flags(),
but leaves res->rt6 pointing at the released rt6_info.

If no later rule supplies a replacement, fib6_rule_lookup() still sees
res.rt6 and returns that stale dst to its caller. A suppressing rule can
therefore leak a released route back to rt6_lookup(), and the next put
hits rcuref_put_slowpath() from dst_release().

Clear res->rt6 when suppressing the route so suppressed lookups fall
through to the null dst instead of reusing the released one.

Fixes: cdef485217d3 ("ipv6: fix memory leak in fib6_rule_suppress")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv6/fib6_rules.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index e1b2b4fa6e18..89ee3c969ca7 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -308,6 +308,7 @@ INDIRECT_CALLABLE_SCOPE bool fib6_rule_suppress(struct fib_rule *rule,
 
 suppress_route:
 	ip6_rt_put_flags(rt, flags);
+	res->rt6 = NULL;
 	return true;
 }
 
-- 
2.43.0

