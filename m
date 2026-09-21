Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A64E535B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013829; cv=none; b=pIqwv9D1wHgDSje4myy5zFDlf5jheKMvL2WfVbtXn+2QJLojJZJw313KE5DNxdmUUvX2hQxRhx8d43WOpxALlcJ1CJKVri3r8UImO4OtmK/3nM0oSj7oFy2xMiF+ORjZv3/Etl7ZJwt1qqZ0CCY7u1CKugtGs8VS5lwoPQG9krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013829; c=relaxed/simple;
	bh=RGbyyk0qu3tdeoC5PudwhMmU/cEkEb9FKuwrTVQXv7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtWGOG4MdBbM02BwW4GNInutkI33K4TbjiVgvx0lK0PjbO34Op52L35C/tPm3AsxpUpRPWl+ZaTyJjpsrAMIFMpH3T7HjyRBkDjS6HH6eIrwVnLRl8xrtEDrTyPnEBsbErEPECT64qn0zZLKTLrGWJwp0EcpQZgaXZ/d8Xi7mjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPtgGqQE; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPtgGqQE"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910c9fe21so130600785a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790013827; x=1790618627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OU7Mf64VfjI+2J2xC8nOVzgC82LYLlyjr/Z4y5CGoH4=;
        b=PPtgGqQEyPw8Ci5QLokgHh1/dejgZcAoij4mRn6Xeautxsh8MwX93L+QfkUyzwQmbm
         /BnF+csHR+tULUD2rl748pLamEOik7lh6b4kVR0JRz1k4NeOz5osHwWHSxDZON/UfnE+
         47PzIoaJzMRfL44/O9Mq9r3uSxUW+TFnBmiAgQ5i/g9DbzEL34rTlJUsSIR9Ib5FGbIo
         V479scd0d2zFsDXyXY3pLpuqDdGaNxPuYvajJGdlUKuN0A/Cvpq7Xt/bO8qyr31CfvVg
         +JRQIkJsF3IxQ41GITJq3VnylsFLc+8pUnC3FjmlNzQwNMyqH1QyTKqz9YTgamF0Yjho
         PwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013827; x=1790618627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OU7Mf64VfjI+2J2xC8nOVzgC82LYLlyjr/Z4y5CGoH4=;
        b=n4hIZQWfg07oXxaTd6Gn+9XKAIyuUR57qgqFo2ho63NqjV8AJT/HCpIFrFWLyz9DaW
         weuCTy3AYM6bQQ+M1/1NkX7ypRKEMU8QLrWMevfRq4KYuJYjNFTa1FdULIj49O9dfQ8H
         Dojrdp+gVnM4nOCn8r9CQjt3tgb0dpRCj4ZhtsKiZZAZCzdOoZuF1C7J5tsQJK7w8kc5
         P/2dz3Ps7EgZ+Is9RcQdd6dgL41zjPa79deYnVyHL1WgfTdB2QZsqEl/4RGi7fCIY7Yd
         ZNMTcNjV7NN7SjB223aqlr+OnBLOSGB074dt1sWQY0p8tKG7ePIXbicdHUNFhVZLIftI
         b2/w==
X-Gm-Message-State: AFuF++lEaOEsO+PRl6TMvm7/Dnb+nHJwLcsyLhR+qbea18PpdLsrSIBA
	hACuaUm4ZkHXGV1R4v9VO4fMNp2tefdgiciBrr39TOqBY6+K7RBMxVi9/UAi3A==
X-Gm-Gg: AYBFou1VvMsV5BSmGOizhqNOO43jH5yDTTXLHeByBrcw8lxNS4/o763XSONfGFmCYKT
	qHbPjGgmQrvnjYWI7wfiu5syzyxnqo30ZOy4ZUdZJMaLs+pKpdQVkZL8kxlvpQEHDDY9QgYvzJ5
	w86roZsEbXLJZ0yYqg4rIPH2i1O/RG+Sh+xm0n0wg9h/CPDOESlDaF6uWDf8BIPu4UKeHjd8UMs
	IHElX1AsssEFMZF5NmQtfjZ0u7UFcd0bUgGuKsGl+rjLL66tyWlEyk+9vnJblkrznYaGurcqI/R
	iLbDukCYDjLnEEKUSkPT4jdLB2A6Vb8WTrbU/3EZLad1DhfnIA7u9fN+YJcIgHzlRQtkTnfeC1K
	QpBv8xbDsHn4mOfHZO58l+09j2FOaGZLUus6/mosk0lCoWnDMbWVut3v2GAwwz7X3WTK8FkQc6/
	6Y9hlGKYlcs2tffozsyqwCOtyyR9/l19M8glIGezu+m/sV5UGLUf5sf7SamaOc8Wu/Nmgm14rIi
	SARg1FCk/TJZv7YvzOkJlHf/pISZzooDdRSqU1p57WSih/Xq+vCsUDSUsl9LeLa3KurcLNEckw6
	j7iLMpyKce1Y0d4e0zmM3+AN0RDbQOwyWRcCRJuK9JY80vk=
X-Received: by 2002:a05:620a:1a0f:b0:93b:d7a4:9d49 with SMTP id af79cd13be357-93c17ecf267mr61226285a.28.1790013826924;
        Mon, 21 Sep 2026 11:03:46 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda707c2sm714351185a.16.2026.09.21.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:03:46 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Tangxin Xie <xietangxin@h-partners.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net] sctp: hold asoc or transport before mod_timer() in timer handlers
Date: Mon, 21 Sep 2026 14:03:45 -0400
Message-ID: <c31b5e3ee2b7274e804f5eba2f21e2412e7eef7a.1790013825.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take the association or transport reference before rearming a timer in the
timer handlers.

The existing code calls mod_timer() before taking the reference needed by
the rearmed timer without holding the sock lock. This creates a race with
timer cleanup: if the timer is deleted after mod_timer() returns but before
the reference is taken, the cleanup path can drop the timer's reference and
destroy the transport or association. The timer handler then takes a
reference on the already freed object and eventually drops it, causing a
refcount underflow.

Hold the object before mod_timer() and drop the reference if mod_timer()
reports that the timer was already pending in timer handlers. Apply the
same ordering to the proto-unreachable path, which can rearm a transport
timer outside the timer handlers without holding the sock lock.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/input.c         |  7 ++++---
 net/sctp/sm_sideeffect.c | 37 ++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 864741fae418..9494cfa51106 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -436,9 +436,10 @@ void sctp_icmp_proto_unreachable(struct sock *sk,
 		if (timer_pending(&t->proto_unreach_timer))
 			return;
 		else {
-			if (!mod_timer(&t->proto_unreach_timer,
-						jiffies + (HZ/20)))
-				sctp_transport_hold(t);
+			sctp_transport_hold(t);
+			if (mod_timer(&t->proto_unreach_timer,
+				      jiffies + (HZ / 20)))
+				sctp_transport_put(t);
 		}
 	} else {
 		struct net *net = sock_net(sk);
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 0d99b7e8c082..35f540fb15fc 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -244,8 +244,9 @@ void sctp_generate_t3_rtx_event(struct timer_list *t)
 		pr_debug("%s: sock is busy\n", __func__);
 
 		/* Try again later.  */
-		if (!mod_timer(&transport->T3_rtx_timer, jiffies + (HZ/20)))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->T3_rtx_timer, jiffies + (HZ / 20)))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
@@ -280,8 +281,9 @@ static void sctp_generate_timeout_event(struct sctp_association *asoc,
 			 timeout_type);
 
 		/* Try again later.  */
-		if (!mod_timer(&asoc->timers[timeout_type], jiffies + (HZ/20)))
-			sctp_association_hold(asoc);
+		sctp_association_hold(asoc);
+		if (mod_timer(&asoc->timers[timeout_type], jiffies + (HZ / 20)))
+			sctp_association_put(asoc);
 		goto out_unlock;
 	}
 
@@ -378,8 +380,9 @@ void sctp_generate_heartbeat_event(struct timer_list *t)
 		pr_debug("%s: sock is busy\n", __func__);
 
 		/* Try again later.  */
-		if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->hb_timer, jiffies + (HZ / 20)))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
@@ -388,8 +391,9 @@ void sctp_generate_heartbeat_event(struct timer_list *t)
 	timeout = sctp_transport_timeout(transport);
 	if (elapsed < timeout) {
 		elapsed = timeout - elapsed;
-		if (!mod_timer(&transport->hb_timer, jiffies + elapsed))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->hb_timer, jiffies + elapsed))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
@@ -422,9 +426,10 @@ void sctp_generate_proto_unreach_event(struct timer_list *t)
 		pr_debug("%s: sock is busy\n", __func__);
 
 		/* Try again later.  */
-		if (!mod_timer(&transport->proto_unreach_timer,
-				jiffies + (HZ/20)))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->proto_unreach_timer,
+			      jiffies + (HZ / 20)))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
@@ -458,8 +463,9 @@ void sctp_generate_reconf_event(struct timer_list *t)
 		pr_debug("%s: sock is busy\n", __func__);
 
 		/* Try again later.  */
-		if (!mod_timer(&transport->reconf_timer, jiffies + (HZ / 20)))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->reconf_timer, jiffies + (HZ / 20)))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
@@ -495,8 +501,9 @@ void sctp_generate_probe_event(struct timer_list *t)
 		pr_debug("%s: sock is busy\n", __func__);
 
 		/* Try again later.  */
-		if (!mod_timer(&transport->probe_timer, jiffies + (HZ / 20)))
-			sctp_transport_hold(transport);
+		sctp_transport_hold(transport);
+		if (mod_timer(&transport->probe_timer, jiffies + (HZ / 20)))
+			sctp_transport_put(transport);
 		goto out_unlock;
 	}
 
-- 
2.47.1

