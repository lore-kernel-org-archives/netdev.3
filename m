Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD14E378F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354487; cv=none; b=pigSUkAcs85C+l5a+6a3hH2yBvQKey3Spz88FQizxRVcp28BE3/muTWpuURM8B3nhPv/k4CJIucTYo4EXWnWeHvM8zKSljYo8x27E4OvRdPQvPFsByG56AsZ28Qxxjc9v2iocwvbKusP4XHAtZIkJ+NqAT5YpebayioFohE+HsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354487; c=relaxed/simple;
	bh=aiiAMM7q5MLTYo8qS36/DVYsedOT4jp7jzKwvW+mo7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYQ76RqrXxU1zoa/rD9Z8O7icqqoO9exbVaheEcl1cpU67tEE2oMEWlVBcam70Uk0+6z+/gh+KBf846Moh/xrmuqhaIyeGNB/Iq/+PPilCMwbQnfzNc6B7xYUqy4WHHaAG+fk3Gq8kgBdkFy+52sdBfrO3D7d9OWMm+hg434hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MM3uzwyp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MM3uzwyp"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91c22d27dso3586945ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790354476; x=1790959276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WuQhzby2JSywKWh1CnkOk3cDkQdkF9fledatDmb6qw4=;
        b=MM3uzwyplrgYldJXBd5AlgDnIcjIU1mRo3F6cDS+2h8GXk1QURvw6PzR0vPQVjBT6b
         CsZkBQgqaQVadYM5Bqnu2n3xSjrks568JtHes9l2oeeixiwt6iEzb5dOQ/QtY5bY+boa
         19+nQpLvfc3o5t6x+JLLdi6K41KicRMY+FdR44vVVWco8WbWSKPxZcoeK1bEqdBTiqnL
         G0l/VgOJf0Ycc2s0xD6p1mRHlp6uCXIWlkmDywVK7aqO2KmppGrRjl/NBx2ROxclYMDy
         caAW7n5qZVZX9ohKggzc2KtfLW1OvhyTQ8HImrM5Pk+N9DKGuQ7oYPqlT3jJCbzX0vnp
         8DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354476; x=1790959276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WuQhzby2JSywKWh1CnkOk3cDkQdkF9fledatDmb6qw4=;
        b=n98/TAZ1u70fMZ0rxIXMIy7DedzYrruuuQm2s19Yx4LY4ZexarLQZQRXLX67hXuVJV
         WNMstZojbjpeJhFQIPFROu+/+88Fi2YaDAhBHPJMVe18gaKrguXp9qTQtmbPhcuQFPCJ
         R6Tdh7XUZmRrnyG9tkv5+RIp1KW3D9gvclAGsE+yIVa7Rwjr4BhKw/PtOPb7EPghhUpU
         Aih+w/XSm+zqqsBWcCbAw7hKZ4HA1UH99afuNTzcEUjvpT5Yg0Fg0dkpz7k8wDkgwRDY
         r7IC72JVoK+xg/BzZ5FB8rhyy9cnQy4EeFixcDyWxgXYcFN4dJGFWzezPKDAb6qGY8X0
         xX+g==
X-Gm-Message-State: AFuF++mdo+IFkAStQVyZI1ZzjSQzFCCaDO86zzkQR9WyEXv6ap88Mexp
	gFi6x8s23rp+/HAp8K+8+CC3tP3RSCCPl/ZOYWmu45Mc6664qKSyVUzCHoqgnqLyKIvUXlX+zvM
	LMfqIbIrL
X-Gm-Gg: AYBFou2R5saRDn5irxP8UtRMfG/TxQqisxN+E2BOf88EbbQMWHvcmBkaccgJ4YCkah9
	4ZIzd6tSjooFE6Uqx6f0tkTjPwTvbxllKVER83N/oynlTHgfnVeagd0daHyxQvgJ/rPiS/vA/CX
	5pG59fvK56LbNTA54EPP73wdlrP5ccrw6GZdk7cVRKA2pX8RTkAjy7h8j0BpJpGCMX9A/TXT1Zv
	oDS1b6mKZP8mbkJZECuU3a8GksSoFOyNZWcryhXszKOyTAiNT+vB+WMdxYLDAADIlyFK39kt9WS
	hw6J3/qAfuLs62EIZLR6bErck2PVHcMhtIPu+xa0iJITEsCP0iv3vPTAB1Tx77SI1RgAFPAkn52
	hdnboqmIYrc21QjWKMWiNjrwLRo/DpUzX3wEIAEULP15VdtCloT5OIhuzwRKRxi0vutKBmNExz7
	tccPS1BnOejL6CGmokCuE8mY3sBWBCasnGyarygmxUdajudGPfipsQXfThUbfET1VqMmZ6t9f6L
	x8tjT1VSp8E0WzC5E+icN3AqjGHig==
X-Received: by 2002:a17:903:37cd:b0:2dd:ad74:6d21 with SMTP id d9443c01a7336-2df7dc3828cmr48822565ad.30.1790354476307;
        Fri, 25 Sep 2026 09:41:16 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9146edb4sm13855275ad.81.2026.09.25.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:41:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH nf v5 2/3] ipvs: avoid stack overflow from recursive connection expiration
Date: Fri, 25 Sep 2026 16:40:47 +0000
Message-ID: <6fddc010376e9670c59d2c2319c88d3529f42a2a.1790266803.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790266803.git.zihanx@nebusec.ai>
References: <cover.1790266803.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a controlled IPVS connection expires, its controller may be expired
synchronously if it has no remaining controlled connections. A chain of
controlled connections can then recurse through ip_vs_conn_expire() and
exhaust the kernel stack during namespace cleanup.

Continue expiration with the controller after the current connection has
been fully cleaned up instead of calling ip_vs_conn_del() recursively. Keep
the expiration walk under RCU, preserve the immediate-drop timeout for a
controller with its own controller, and switch to deletion mode before the
next iteration.

This keeps controlled-connection cleanup synchronous while using one stack
frame for the whole chain. The timer callback race during connection
deletion is handled by the preceding refcount fix.

Fixes: f9200a52eedf ("ipvs: avoid expiring many connections from timer")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v5:
  - Rebase this patch on Julian Anastasov's v3 timer-callback fix.
  - v4 Link: https://lore.kernel.org/all/cover.1790146910.git.zihanx@nebusec.ai/
changes in v4:
  - Rebase the iterative controller cleanup on the timer-callback fix.
  - Keep the controller walk synchronous and switch to deletion mode for
    the next iteration.
  - v3 Link:
    https://lore.kernel.org/all/cover.1789877273.git.zihanx@nebusec.ai/
changes in v3:
  - Handle the timer-callback race while keeping controller cleanup
    iterative and synchronous.
  - v2 Link:
    https://lore.kernel.org/all/cover.1789435989.git.zihanx@nebusec.ai/
changes in v2:
  - Replace recursive controller expiration with an iterative repeat path.
  - v1 Link:
    https://lore.kernel.org/all/cover.1789110326.git.zihanx@nebusec.ai/

 net/netfilter/ipvs/ip_vs_conn.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index eac185496a8a6..ec5c0c8ecde74 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1357,6 +1357,9 @@ static void ip_vs_conn_expire(struct timer_list *t)
 	struct ip_vs_conn *cp = timer_container_of(cp, t2, timer);
 	struct netns_ipvs *ipvs = cp->ipvs;
 
+	rcu_read_lock();
+
+repeat:
 	/*
 	 *	do I control anybody?
 	 */
@@ -1366,19 +1369,20 @@ static void ip_vs_conn_expire(struct timer_list *t)
 	/* Unlink conn if not referenced anymore */
 	if (likely(ip_vs_conn_unlink(cp, my_cb))) {
 		struct ip_vs_conn *ct = cp->control;
+		bool next = false;
 
 		/* does anybody control me? */
 		if (ct) {
-			rcu_read_lock();
 			ip_vs_control_del(cp);
 			/* Drop CTL or non-assured TPL if not used anymore */
 			if (!cp->timeout && !atomic_read(&ct->n_control) &&
 			    (!(ct->flags & IP_VS_CONN_F_TEMPLATE) ||
 			     !(ct->state & IP_VS_CTPL_S_ASSURED))) {
 				IP_VS_DBG(4, "drop controlling connection\n");
-				ip_vs_conn_del(ct);
+				if (ct->control)
+					ct->timeout = 0;
+				next = true;
 			}
-			rcu_read_unlock();
 		}
 
 		if ((cp->flags & IP_VS_CONN_F_NFCT) &&
@@ -1405,7 +1409,12 @@ static void ip_vs_conn_expire(struct timer_list *t)
 		else
 			call_rcu(&cp->rcu_head, ip_vs_conn_rcu_free);
 		atomic_dec(&ipvs->conn_count);
-		return;
+		if (next) {
+			cp = ct;
+			my_cb = false;
+			goto repeat;
+		}
+		goto out;
 	}
 
   expire_later:
@@ -1422,6 +1431,9 @@ static void ip_vs_conn_expire(struct timer_list *t)
 
 		__ip_vs_conn_put_timer(cp);
 	}
+
+out:
+	rcu_read_unlock();
 }
 
 /* Modify timer, so that it expires as soon as possible.
-- 
2.43.0

