Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8222E383C9F
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365805; cv=none; b=L31paYHQR8FnpcRZ/42RVgIOlU5hsY/YWSVeBmHB/yXpUQHxP9J3XVaqe19NgBvKL28CqNf/ERrP4K8OhikL94bQzezd6ljM+WVVNYK6uWVCGp75rTw5oSrAPjgaw6bIwAjqbQu50q1K1R/gVZFTbFhpqX09WOKzQPReYoD9zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365805; c=relaxed/simple;
	bh=U1dSyGmpO4jyK0gdMbi0zGrAKcDsiwvzn2p+5O8OCHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsLHJb+rP2w7EuygUxeMHWiQS0G1izm25nb7ybLOn9VoaYljNmP6Ih7hOXmifiV0x+ByNZZtYgfbO1Oc1DGaXwTx88bqPrJtix+AHHEFZUkMsVeb+YKsX6EYQrwRFZzMijEI+scx06DMXIZMcN1qZSFNpzUa9a+cmeQ0rDGsRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuFOL5U1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuFOL5U1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso103353095ad.1
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365804; x=1784970604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz7xYB5+RsFyTrGLAYiyXPfONarJ2CKVSQ+VTT23UHc=;
        b=AuFOL5U1mxCZ59jR+EMv5/o1zm+dHJthrWnw9JE0ubQVyjnFGeKfN54OGsSDi0vKLb
         oU49SZ6fIuPshIOsL/sLH5j9EtX62Cv+5y+ctlg2whVGV+l+OpCXwB/y3Tap5J8tlbWS
         ZLQvTotA+pfQR8QmLOeCibA5fFAJs4T/qkNEWPohaEzq8Z1f8OLBMkhk1I8YOZ9ThxL6
         AGagkWUC76Q40osagBmHy1lEH9UPHyLRdNuGmgksZ1933NhkeSJWghqg9agnxp+S3TKH
         Kn6PZLVpyovGLEG5DIGbjwcWqCGq3mUKVSTzJ6GPmfI/KMgr9iANsWLrNaoRHWXxsGML
         08Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365804; x=1784970604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nz7xYB5+RsFyTrGLAYiyXPfONarJ2CKVSQ+VTT23UHc=;
        b=CEsAHVY1CDI65E0JlknS3QWCkisKvXQStFy2yog4n/RRJxXwDcZYQh5Dwym4Gm3K1G
         YF1pXwbvTS82IPZurUhYfs7lVlvo5mJvFdTmGxXo7A5wFtF8kUMoRRSG7Yu6laUpDbD3
         TPxekYiWm4BcosHk57jL+1jjf90YQd6ThCXIXH9LVXMGHqvaKK23642j+gzAAxRBaOmy
         TukNBh1ELKDAhyERsVsCwpHXhWRhPyjJXwUCGtLPEkzTG8t3vyaDW+QT0ltu3tSVoa+8
         mg9LyZ+ehj65r7PfKIRN+3rk8EpPlHrbnPr432RdF5E607VCH8ZV5lF3H5foNCZyjJPv
         IP4g==
X-Forwarded-Encrypted: i=1; AHgh+Rpyc2nlpY0RQnOh9sH+M0rjjPBUSIA8sG4zdILnQhY6UeH/BfHUpR2cLIERkDMArh1D0VN3UeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80oij2fsVQQdsHBYGB5LrmD5wA/L6ZDFRtDM+PJ7R13BoS0rP
	Lo1WlsEJlOf+olD007tSAWqWFGlnK+a+wcqFO6+ygqi9teHNnMVf2N/h
X-Gm-Gg: AfdE7cmYkTz1dD+dBPRj27xk1VUjYw+idqEPPlnOydeI72aw47K5w4H8cIhJq/joqR9
	vz4PxlAPHdPSBAwqP2Pos6PIzBQ9DhHQ+RzgM7lxTXi0CefHhQR3VdJLcoaCY23YUs4OjZHUxwG
	LPJsDCKEKKI+9tKCuCvCZc7wus/UpJPdk9um1i+rRwj7OhB988YCQSW2Dpmo/tJGRh7x8+k73+m
	/IywDkWpe/N2inI5aPF6TUlWTWYObXL7sXSEimqpuYbcH+8awzrDzFEldOEmnrvUkY+JwaUZSmr
	a6tetbB7X00CaOkASJnP4hmdMAVoKpvvkq8q+L5etPUPyTH5Vxjz4qTYptRjG47boXCC8Htxf0q
	I3g8BcodnyZHoXKc29DeECP59HHIWunEhxtyjW1+cjaNduzA4it24IhqwKl74x7vZpghZDwF9o6
	25HOE7iqtzwp8uZw5zUCkUd24MfLO6pUeRUuLSIDk=
X-Received: by 2002:a17:902:e54b:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2cf348547d0mr69884695ad.12.1784365803969;
        Sat, 18 Jul 2026 02:10:03 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm24285495ad.80.2026.07.18.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:10:03 -0700 (PDT)
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
Subject: [PATCH net v7 3/3] tipc: fix node reference leak when defer work is already pending
Date: Sat, 18 Jul 2026 17:09:30 +0800
Message-ID: <20260718090931.724303-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718090931.724303-1-bestswngs@gmail.com>
References: <20260718090931.724303-1-bestswngs@gmail.com>
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
index f757722d15be..f826347b5870 100644
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

