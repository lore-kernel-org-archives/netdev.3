Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D233ADBF
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790386098; cv=none; b=A3SvcEiMwRayxfHEqpa2Ojlj3m0om0xPz4xIHEVObsiZzSxhcv6W5MmboA7WiocYYa8JWRNCRG/jJ0BwMVMsTnvk2l90l+QgYv6a0xwF/7y7BUfAAYF2ylIYKFKWqHBQva7DH94e4HXifyQirBA4ts8fuxLiZgQyhzh0u/I8UEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790386098; c=relaxed/simple;
	bh=TsKEM23vrGNZP59nClNAGbEF4QPHeuq9r9xlzWpsDi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWFvdvSKGqEqA3YUqGJ3nI8ZNI8+YrllEHAPaIaVpcGaLbFv5SsONzkYT+uXVbmR4G6mdDWrsTdHxT4OuRkEATLVqZ8GJnE8r6klPpQYYwODwz92bdNVZ/GeNbrTfVU7/jQGnytrrmEFaqegEGmfEIOi7ZDuEkVq9zwfHcfqG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmRIuzEj; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmRIuzEj"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc8b0dso1178233b6e.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790386096; x=1790990896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKazThAjDvEancv5DllE0t7hYEI/Pi0fz1aTpnksd5Y=;
        b=mmRIuzEjQ4ofmZmP4vOP7quIcZdDsgsU/UezqAP7IRD2UtAx/csfEruLphAHn5bEqc
         UTmfm6akgi1FKnKpoGWbL3su8Jxftbs1jtcaeKkKBudZGzc5faaZoyGXJ3pgOL2coin3
         22E0RJ5IExUlgOJZHW6O4+p+GWGQxkMTVqKnstRGrQcOJVuPzu8NC39xElfMkUMcILb0
         qVli6r7EHZeIjgxhxt9qAC5tBDmU05+G+vqdmz3C12Ms/X47OSh6JgBWd2quIWSO03R5
         PAp7B4OhYNqMisXRt9/VsuLqT8UQ4H1daarAwSHdlsMD1fcqhYco3Yyc9TPzPhvVuUtB
         UuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790386096; x=1790990896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKazThAjDvEancv5DllE0t7hYEI/Pi0fz1aTpnksd5Y=;
        b=Fn2xS3zEtMIQPCHlq1NN88GDVgH5e1XnuZb7s8iGM5M7WJwyJBzYpd4WsOGiVDhlhV
         qyh7yulDuyzGil+07xKgA3xxNPEZdsyPcDntrQT5AU61Co/laQqg7klcQK9EJj+WGAu2
         iaFH9TNAvAP31cQNiuIYFYPhkBY4FN2biPvQ6JYtwEHQt8pwdhSi+X2MWJ/FfBSWLi9K
         bAw8/nvfE031hbj2JFIcPR482+Rr39ih1id6SeUnKtoUMDmL8/rc0kCk/mZceFCDlnbm
         b8nrf5om/eXAn7Ndnz8cXh73WJySjwgnv88Mcxiy9ETYaHVw7FetT+zaQhwQF8lBSq3T
         utEQ==
X-Gm-Message-State: AFuF++kyPJbbfigxphhB53RxPadjo8f4DhQIeiBoajX08z9/dh1WOJZu
	M6YIlsjukGS3zSAUIm/hQqS4CeJvqvgKWc0SS1LRWvwe4O80H0f/NMMD
X-Gm-Gg: AYBFou0dMvrzB2hvOdOqAfeEtC94MtvUlo1+LgM6xCXVGmHUjIXkjbIp3+NxVINIGqL
	aL4pXFHq2c5w4yzNMs4ulP3DleWmizS74rGzvbcNqn6JUiWUlaaPZZp9xCWOlNnsVMAIdaNNeZ/
	Cr9iCvk5QAGkyctZds0FrabPJ2sGU81dCJyAEvkx0pL6M7I7m7YrJwwxg/lPskJeuPCnPy3OAqQ
	2yU1e36YgbQrdKlfXd2pDq1GzYg3JGGrFgrGbmsMR1aG5SdemzkArZXobUBC8doLy/nzKu0buRf
	ae7rGLdl3JtnerZRTBie4LPQIyjCL0AHgBr/Wr2YqJFinkxC5YfFtStCas8D3tO5wdfHTroyi3E
	jL9bU4SlrKGlDQ0HAf2qF3iHFeQIzTSBGMHwjjGG2jIedF9Tnrfc4aQzRQgkF1siftZF1pISOSU
	AV7xO/QwDTJZliy9Tf6lUTUVCuYt5mh5tKRE1T++rqy8AXjZrmYv5YxmSMDbNLZsvm+28j
X-Received: by 2002:a05:6808:13d3:b0:4c0:12f3:6007 with SMTP id 5614622812f47-4d72892496fmr9250533b6e.4.1790386095748;
        Fri, 25 Sep 2026 18:28:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbfc14afcfsm3569233b6e.18.2026.09.25.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:28:14 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 25 Sep 2026 18:27:58 -0700
Subject: [PATCH net-next 3/4] net: psp: drop psp assoc clear in sk_clone()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-psp-defeat-v1-3-9f0b430107aa@gmail.com>
References: <20260925-psp-defeat-v1-0-9f0b430107aa@gmail.com>
In-Reply-To: <20260925-psp-defeat-v1-0-9f0b430107aa@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0

Unwind the change from commit 1d2929d0850f ("net: psp: do not inherit
the Rx association on clone"), now that assoc state cannot exist on
listen sockets.

With commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
ehash and lhash2."), and the change in this series restricting PSP assoc
operations to established sockets, this state should be unreachable.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 2948dffcc3e1..d7ddd365abeb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2496,7 +2496,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
-	RCU_INIT_POINTER(newsk->psp_assoc, NULL);
+	DEBUG_NET_WARN_ON_ONCE(rcu_access_pointer(sk->psp_assoc));
 #endif
 
 	/* SANITY */

-- 
2.52.0

