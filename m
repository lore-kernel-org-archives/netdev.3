Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C22EBB9E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039999; cv=none; b=WYIBmEwogUrV6yMH7J1cOPglLURJHlw/7v5FTdxwMx9mnziYXLxFQPaqXtnK3A3rcy+8/1YrNI10zl64+8Beo/QTsQgP4BBT4EqyiaW3JI+II89Z/DIOlIKUWV09VXMAuuyBpI+yYDQUxR/exVpENzDXiOP4gRMLdYRkdjTGgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039999; c=relaxed/simple;
	bh=1a9MQWUXgpn4qKeF0+Ao6YRFhtlsYjwj722CufZ1TuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NyP0/egAtwQHKNHCfIdXZpMe/sHBibf6Zu2DVOdfacqJDNXcmuUfJ90M/ivuw17bYeFqKI+27y2VFZPHClmml6OAgshTvN0ept1sq2gVhsFu7RYJ8KqQ5Kg07vdWfAObLTiI31NqjPOmT5s5I3uXywhMr6zHiW3X7PbfSdeLS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk3T2JaB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk3T2JaB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba86e35aa1so1407965ad.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778039998; x=1778644798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQqgBH7DD5POz03YO9t0uCAy5+ybBUvkq/RwFit1EzE=;
        b=Zk3T2JaBNvdQpyJU2gpFXRAhB79okKMCoK62buazXJYFk2mjZ8YsmjFkMVHBdeES9d
         Z5lhVnDB4vN2KGzX/M1UWs9G2zOPwG4k6aOw2NPpJgCRmFmWCzdbihM0e7EXhfBBltIu
         arqjkaQNpn5pMBY1fpCV9R44EinBzd+Em89mPHqh5AAsrgUiUnJjWDaV+TWz/hwxQjy2
         PMDp188XWEnvSfzOlGh6+DK0ihEwY1vt6if5lZSOZa2a3+6fZ/FUa3w+jAGnYhYo1SwA
         THZmDP1SnFjOURW5XLOiV4+pOVnwNV1Pz0EwHx4wdX2K6rSC9NIDlSdfsQgwyxY3vqPb
         T1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778039998; x=1778644798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQqgBH7DD5POz03YO9t0uCAy5+ybBUvkq/RwFit1EzE=;
        b=HCR2E3xt1AuOAF6+mP7H0GETFBo+SpHkfySjulwazY8Wwgo5ZKQjJcFQ8w8d/ay9tD
         5vYvqqmhCd9xzoP8H5KTHpF1TFLnKtGPDzHSyx0zNwioGopJm5BMgHTfjB32NIutiWi7
         tpeb/CVlTVgVnRQeA11YcUzmrHVPkVVmk0EWK4BygYyOxOw7xHoQvsCVmSqSk4eyrOlm
         RrkUvNi7n61cBMR5HTUWV6dBK0ZByLlsxYwaY1cUz/HgMpQVcnpCYb49VF0PMjgJMhIV
         +yjt91y/dx7J0Jlok1PJX40l4Rv7hQ0uBrFwFZVLkQZo2n2W8ox9lAt6qICld39S3cOB
         yGXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rdAwPo+8gnd+3X/kQS57+OSCZq1mjHnq0s6rRfV1O8dNAPWvgvbvhBdxSIBLCqL7CgIk1U0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlQAv0aICw99kS2gXVm7a/85BiCBxcji6AQKbBgCGCaI/YMVw
	wQ4u1wpKm120VinMPuqVIbqic+7G642AayUzug0lQdkLfu7TmUfVZPMbC9J+6DoXDOqXZgB0uGy
	IZiETbQ==
X-Received: from plot2.prod.google.com ([2002:a17:902:8c82:b0:2b2:50b1:327c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ad0:b0:2b0:6e60:9586
 with SMTP id d9443c01a7336-2ba792a0c08mr17992435ad.17.1778039997635; Tue, 05
 May 2026 20:59:57 -0700 (PDT)
Date: Wed,  6 May 2026 03:59:19 +0000
In-Reply-To: <20260506035954.1563147-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506035954.1563147-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506035954.1563147-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] tcp: Fix imbalanced icsk_accept_queue count.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"

When TCP socket migration happens in reqsk_timer_handler(),
@sk_listener will be updated with the new listener.

When we call __inet_csk_reqsk_queue_drop(), the listener must
be the one stored in req->rsk_listener.

The cited commit accidentally replaced oreq->rsk_listener with
sk_listener, leading to imbalanced icsk_accept_queue count.

Let's pass the correct listener to __inet_csk_reqsk_queue_drop().

Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 971f9db2c586..dbcd37dfdc15 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1134,7 +1134,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	__inet_csk_reqsk_queue_drop(oreq->rsk_listener, oreq, true);
 	reqsk_put(oreq);
 }
 
-- 
2.54.0.545.g6539524ca2-goog

