Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC46376BCC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485661; cv=none; b=gjZ1LQKNRIThMf324oxOa1Mw0lAvn7mx66LcYUFtahchqbV9qY2in1bmbl1epUvQAL2vRh86Q0buKyFgeYbRnnwZyHXTaEZI/pUxhJ5pySp3vBNOn6KT+dt/5h42uwFhVB1mNFQWdfrK+TLXOQxA7ve+6TQ0zTjy7PVPSIuFRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485661; c=relaxed/simple;
	bh=mp+W/NanRi6LcS0jIyEjAdqNQV6N3tjeFQnIyxmGDfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ir4h/rG+9gn+MbpRzkes8Hu6l3GDDx1or2O4W9IGJnbcvZVDwzUs4w62shvBirJIeanqCe2v2vYZANCNnV1StHSOV3YGhkNBziU6PAkOsQEL7CNNXpI9PSM0g5ti9EFd+OUHppZsWhdcXE6KeRcB7fR3mfcpVpIn8rqaTTzCJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqkZ6vA+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqkZ6vA+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso252432a34.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485659; x=1789090459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnSRfmxyuoGSVIEIapT3+f2N+j9Dyvafdc53a5iR7kI=;
        b=gqkZ6vA+bxBYWvZXv5QDaxrG+jr6Uj3iDEU0d7h3LLScyxpyG+FtRg60BqZ+G+wdQ9
         j7PL9IsGXeBoWlQfZ4b+I7gJ9AbGFg6XVRf6NyJbg/H3ZYuwLLrBnvhf5HZIgLNPWO2e
         iwXfeGrkGR6Da1FaCacMKtUk4zxwTtHDeyaqMzwN0JCg5XX4EC2z5DxHfF1Y+bnDcWTo
         19yNJSqELtsmr89POnKIipq/WnqGFnnCXe8hRnZIbtAsQzprPDOHwUpjT4iMK0P2pB4o
         HjWJQKAApjOgd1iIwciv7adGzVnBP5sLe34ysDaNoCaClk02KVoLjihF58htQZJivcwk
         Ue9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485659; x=1789090459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnSRfmxyuoGSVIEIapT3+f2N+j9Dyvafdc53a5iR7kI=;
        b=VsyDOji2ufBwQzchxf6hN+u+db+sFfqb4gelhfdTJRYhad1HY2QlklhHq4hpUCM3Mp
         ThMFHICatpfzvrrplvSVBB/dZZ3okm/eYV0iw90fBNnJ9VOd+Bar5mW6qvJVD5q0HVJ9
         WtUcIJKRaEhK/IJUlc7oKm+ORzp1fGwntpWi1sM5p8jkL/ZuZb5F/Pg1xWV560YhJrOU
         rcf9LQTnZNCfK8IJdIV4R0T281kYo41H1yxyaiNWiIHNjmbjrt+N4LYl7blVuQXwSWBg
         gSZiu8Nc1ccE/ZiZ+rkAUWINLJPrf7sFSiC6Ou7HUjcAy/kvDDWgVZoTunvqR1ko2hs2
         d75A==
X-Gm-Message-State: AFuF++nY8cdFhlnmJxyOOgfF33atBZc9VVMg+KBUthr6zXLNxtsdOAw7
	b8rBP3tfuw+7D2xK16fhmSDkaX2LBKP6zv6T85APPdJ1BH6TFvQxq+V3upkpZ83v
X-Gm-Gg: AYBFou3AIKORODZrsgLM0C6FF5pNH0Z/IENnKrw+9jkT4xNYlGT4iyc5WPzby1AYsrZ
	htn9T5c2snYcWoehXQx+mGw8pu3IgGe7b/lsXHCVu7B7JpGMyCAk8LxJ44uZYjs1OIy2ibVxN5w
	85h4x51440uuiDJvGwW7+780SWZkAZ0lmQvitznex3PJ4Zt7ePYJqh8SX8a0t9uTvI3slrEu8qH
	Yl9eiLxKstHLmKQUnTm89v1n/h+kHAOLB9HtfZlztQZdfsWZ3ck+g/dIKuZzuITdaUAKqJTG94p
	XRheUJ1fhww7wWJ3HVyNhSXSPRY5z3JJUWf5DO3QHhI0txXNAcKo641KoPvnb209Q7DX+LtI1XM
	nq6zE6u6uagg6joZAtQMeWNEw55VVfcgaPetIOnCKeYIYrm47PIgZIuENENgCmXy4M03QH0orQR
	CnMEA0Jz24oBM/W7ZugVV6GpchiQOhc3JuZxRj7pSubEjKq2klCKY6MP2OoA==
X-Received: by 2002:a05:6830:838d:b0:7d7:4fc7:21a with SMTP id 46e09a7af769-7fa1ff66b12mr2869051a34.13.1788485658946;
        Thu, 03 Sep 2026 18:34:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f470a34fsm1740895a34.3.2026.09.03.18.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:34:18 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 03 Sep 2026 18:33:59 -0700
Subject: [PATCH net-next 1/4] psp: refactor psp_dev_tx_key_del()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-psp-prep-v1-1-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

No functional changes.

Lift the list deletion and tx spi validation code into
callers. Deferred key deletion code paths will need similar checks
that a tx key needs removal from the underlying device, but will
diverge when it comes to list handling and when to call
psp_dev_ops::tx_key_del().

Also, move the predicate for tx key deletion into a helper for
readability and reuse in later patches.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp.h      |  6 ++++++
 net/psp/psp_main.c |  7 +++++--
 net/psp/psp_sock.c | 11 ++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/psp/psp.h b/net/psp/psp.h
index 86eeba823ced..8acf9ca84b55 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -53,4 +53,10 @@ static inline bool psp_dev_is_registered(struct psp_dev *psd)
 	return !!psd->ops;
 }
 
+static inline bool psp_assoc_needs_tx_key_del(struct psp_assoc *pas)
+{
+	lockdep_assert_held(&pas->psd->lock);
+	return pas->tx.spi;
+}
+
 #endif /* __PSP_PSP_H */
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index c9c1a8826b7f..2556f0d46ef4 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -147,8 +147,11 @@ void psp_dev_unregister(struct psp_dev *psd)
 
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
-	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
-		psp_dev_tx_key_del(psd, pas);
+	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list) {
+		if (psp_assoc_needs_tx_key_del(pas))
+			psp_dev_tx_key_del(psd, pas);
+		list_del(&pas->assocs_list);
+	}
 
 	list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
 				 dev_list) {
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 1a2a6b7516b0..045389671d7f 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -85,9 +85,7 @@ static int psp_dev_tx_key_add(struct psp_dev *psd, struct psp_assoc *pas,
 
 void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
-	if (pas->tx.spi)
-		psd->ops->tx_key_del(psd, pas);
-	list_del(&pas->assocs_list);
+	psd->ops->tx_key_del(psd, pas);
 }
 
 static void psp_assoc_free(struct work_struct *work)
@@ -96,8 +94,11 @@ static void psp_assoc_free(struct work_struct *work)
 	struct psp_dev *psd = pas->psd;
 
 	mutex_lock(&psd->lock);
-	if (psp_dev_is_registered(psd))
-		psp_dev_tx_key_del(psd, pas);
+	if (psp_dev_is_registered(psd)) {
+		if (psp_assoc_needs_tx_key_del(pas))
+			psp_dev_tx_key_del(psd, pas);
+		list_del(&pas->assocs_list);
+	}
 	mutex_unlock(&psd->lock);
 	psp_dev_put(psd);
 	kfree(pas);

-- 
2.52.0

