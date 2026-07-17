Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D7382F1C
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313062; cv=none; b=MkPFNBozr7lTMtOdXansPExqYXJic8DBXP48jNnJ8U7XkAb0D1ojCWS9sOvdG4AIszBv7myDu00idqsAAPSpFj13GXot7SNgSeV69GKWGuOqekpPcxbEhsozdujvO9Vc/JUxQx9lh7wjW2DWybQs/YwE1PpG91ZzpPQjwsZD9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313062; c=relaxed/simple;
	bh=1F1SE1lLP/oS3nzGeTd/9IBL0aREwzGS+Bo3bJtQMdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjO2j+0a2Ua/eiWZOdBNcHbgMOyc6dfmovXlYwj2mYfH01ZUKeS04dZsMIlvxL4JMWEjOuZu2NX8uSCBJLUhcB+GeatHhnUxiH3OoYu+mf0bHN1lj0kR0mb/NLzojJgxqgMFa9PrK25Gq3lYxA84JmQrMJY3UJXAFm1t6M6vHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWgHjMRI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWgHjMRI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487b7b4066so8511929b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313060; x=1784917860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=joB5XdEMkRYTFOe6oQxV2wUDblqkRFAT1rpZftZWDv8=;
        b=iWgHjMRIPkaIn4MXMafrXPVtrV0PJ9oxpFzbeYQP69MD7ZTZhiWr9UHtGVvIFKkxtp
         2rfFcuoUEmgftCRUj72UMOmUoLKrCTKS4t/hyax9Uc7MEkcznn3lZdKgyYYpTvWSJvUf
         7FQsHep0n5WOsph2AyyaA6tV29yWhsxfDLaHjPPeIlELH6Vi5NM+zf/ZbEpbuwDV1Mf4
         0tZGZEsKJB+wEcs6kMnkEOgsWm5F9H+RR3i37fDrscwhsm1yalZYdWkgyn1plksLaFK5
         oeN1kwoT06E21PUYrUFaAeGfKjqcngQJdKQ+QT0/TVrCWPhvcqP16dC+AJ4ZVZgZyOj3
         vvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313060; x=1784917860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=joB5XdEMkRYTFOe6oQxV2wUDblqkRFAT1rpZftZWDv8=;
        b=BoCPHsjg+Pe3Rk4KY16lGGzOI1f4LvZsaQjdq/nv/nVrz9JZP4z0wDvXiKtM0xKzQE
         fevo+beJ1YER1kbd1Bu7zFr0H2qGEI58CXa1OrlWOLWzXKiFzUyX/F23rlaZC9VPki9E
         +uVgrl/RSRlH53gncSMW4hH5yPrQxBqBGd4+YvyKlB8Hw+xwGuPe62F/r4HIXuC4UvNM
         L2lpKxhvyThIg4JCsb5aYXJ2di30efcYEyLyzURQV5h3gYdVxwD3M3S7zYeDSsUEpeGS
         578i9heM6yymwfyC0y7HW/7ZJc8LiBOk0EOz0ijUEAPP6CG4FDLm0VuLSLlJwWDIq7mT
         yoSA==
X-Forwarded-Encrypted: i=1; AHgh+Rqj0Vbah9AFtMVaLo7mJ9sJtNbdZL9XOBVdT+2rsPVsOyC7O7SGvk3l+agNN4oy6sOLGpugZtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jfuQH/0fY0IXmPFNKQJufFmm1dhZ7ykBjN2Kv5U4nlfPGo/g
	SCeHwVYP+XqjuZstAgDOKFH8FPuORRPdp0t+c5ILiDH9tazG7z3jR6n8
X-Gm-Gg: AfdE7cn7c2STdjwr2yv8/HjtPQD/8B47h+g3wK/jObIxktDgaS7o1JcKLsCXxf1eXCU
	O1ULb9iP2CjX6JUwVvDimr+CX7Jny8LVyIVD99fpTBtmM6KlHRENeWywA9+x8/Bjtd53ukc+oUz
	LWQLtPe1s5rxiYb5XEQOoa56F7gciQ1s8EGY0JK7EkpMmi2da3wzhVPvs6VRmqQZt3+mZo2ni07
	4/kmNcasq7oQqSa+VvjAyamPo6RsNf4enfJ5fNJDjyqVwHfk607PEJNb/SWYqie2EDoekRyXYuA
	TraHEQW/EkPodQiR9i9at9FnOmDNPFx9QF1su+7W38OHLqBalpctxBLrVt3qfdJYKltm8NkBQCd
	9D+WE4Lwb8s59qCypO/QidJcviclD7uI1HQgkMGPdlTMRiOH2V9CalNc3fs+65QDOvNChEDFnlv
	xDGxeIzNwXMzHOpW9m+lDvhGhTjvE9us6pC6McEQ==
X-Received: by 2002:a05:6a00:17a0:b0:842:706e:ad43 with SMTP id d2e1a72fcca58-84c292ef527mr4052683b3a.33.1784313060471;
        Fri, 17 Jul 2026 11:31:00 -0700 (PDT)
Received: from kimi-bug-hunter.. ([8.219.140.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afd07e2sm1565255b3a.61.2026.07.17.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:30:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/2] tipc: fix node reference leak when defer work is already pending
Date: Sat, 18 Jul 2026 02:30:46 +0800
Message-ID: <20260717183047.2725959-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717183047.2725959-1-bestswngs@gmail.com>
References: <20260717183047.2725959-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tipc_node_write_unlock(), TIPC_NOTIFY_NODE_UP with an empty
cluster_scope takes a node reference and schedules n->work. If the
link flaps down and up while that work is still pending, the next
NODE_UP takes another reference, but schedule_work() returns false
and the extra reference is never dropped. The tipc_node structure
leaks.

Verified by flapping the bearer while the work is pending: one
reference is leaked per repeated NODE_UP, while the work is put only
once when it finally runs.

Drop the reference when the work was already queued.

Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index b545a47d6ccb..428c4eacd02f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -447,7 +447,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		/* Defer bulk distribution to work queue */
 		if (rc > 0) {
 			tipc_node_get(n);
-			schedule_work(&n->work);
+			if (!schedule_work(&n->work))
+				tipc_node_put(n);
 		} else if (rc < 0) {
 			/* Bring the link down to start over bulk distribution
 			 * when the link is up again.
-- 
2.43.0

