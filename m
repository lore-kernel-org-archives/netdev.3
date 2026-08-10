Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEED426EB8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380473; cv=none; b=kSp5EEOSXpZpWPtac986Wfwq3aRkN3co8PjpWimcg20BttdZjNXQBQiA4ds0tkGFXKtTsmBU3SsRmKNi4n8QMk24uR7pywa2qp2ENI/aju0BOmuKfvqEpNb99jQ2KIt1yZlDkl4SYsxtPqFXqR8+oXLasUqBvh+NPccyOqHQDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380473; c=relaxed/simple;
	bh=1Ix4cH5WpoP0sr0eZNs4ONQeMfV1yLSYSj7etDIUkHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJncGcmi36IeFGMNFjwAgPud29QZ/wHg23P8C/GLgR4smpOl9r0Q+3HEFYAUytYPgzz9Hkq0rYXaeo8iaAzJYaRYt5CA7vsXKfeNqV3An78EmQ+p96R9n6H95D99wdDBD5z1bW5BUdIL/WyOkFyC4muhU/0EXhxtHMsehOz59yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzF/6isy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzF/6isy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956d1d9fb2so2303955e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380468; x=1786985268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOT5/upoFX5/j7dRMQa+9jiolueDHmK+W74PXWUhiTk=;
        b=YzF/6isy202q2hhWrKsaDALbZM41MVRKGfbHxxNXpJ/ePCSDJ68yHZN7cGQoo79hgk
         cvmpc1AG6fIqnYzzJ5KmaGIl7qw92dAhScDj3WsGBJTnhFDV6mWn0CrZ2DFzQa7pIx1W
         XYb17Du33sskDTb0ObPbtrzzxD5lIrybRhOsifP5BKcEa0ELSO2ND2VqOalEpQta2nV6
         QBXi5WysYTy9QMGlB+fIqW2RV7FvVfCRjkly8w4DgRGMbfiC24NP45+Cx8mVqDitubMk
         uPYlfxwOusL5bQSXzCkWAuMx/yDNSGs55OSYuLgXAYQRQdJMBv7dQ5TcnDr2JILsLKI/
         QSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380468; x=1786985268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOT5/upoFX5/j7dRMQa+9jiolueDHmK+W74PXWUhiTk=;
        b=LZWY41vq7BHzjf1b0+eIKF31wjnN5IaRHkuGOcUZusmfC4lLQEsZlZ9x+t0c4M5c8L
         uM9yWNTrGDssFsDKC6XZzaIu0knd6Q9hpILOVNCy3xNXT8co3Z6f9gVSZ3CYGImx0zjC
         gdIApfWi65d85q50SF1F1d6roKnYFn/VtXNA+YBC8UxevVBeXVR6sMa8L9nLzOOq4Yo3
         yCpR4XZbtAlrekfqgZ4s9zzknjhSIXeoQ/tWz32bdMGtom0D0a6pEfJyyrqajpA0tQj9
         Ghly85n3uBjpujzmxhU6NFyL+uW4kRQc8IS9+4Av00oY4HwWF/fj8PIvwr6rwSkADdSL
         pqvQ==
X-Gm-Message-State: AOJu0YyyrL2wQCtVatdwpAwz93GttBv2lC5/PJ7lpaRuY/N3rD5EgL82
	mJVOZkQY2epaviH0o23NGKwjwKFVpYQl33pJP3Nw0d+ZyMLwFpxf6Vkr
X-Gm-Gg: AR+sD10OtKCWk7yYgGTwLE/1gXTU5y8bbhcH0OukuzJgFt82jIl+IRhMRnzTRb4rZ+S
	vHaL8zuByDx5O5BKG541OExM9I3L4Vmsbya4x2CHJghmdgNuqpJ8dWnMYUFn0An6FUmGjGvNi//
	v6t0wRWdiPyhAj7QVgmrnCTNPNWD5eKP1FSU/CZ7Ke6bK6LCI2Eyvo25qzrAzLBIHoyyWQYJxYP
	r6o8JCWjN1z3Db9IiCyFxs56xvpFOv/HH1TU/6UllYuZoYGxpn32b48YqkXSU7NgM+yLUOnmpBf
	zlmvC4YPZZOuZk7M2pIC4ScIf1QqpzGlOn0Y+McIhDFx86NCmJ8XVKcerBg0DCda3nCy/kgtUEN
	oXCmgp+BW/JBVk6o/aR+0LpaSfki+Bgwct0xbiAQ1Fy9U8Jw5GS0eYXrMmsgvMSE5cR7ZJM1v8T
	MFob8rKzcltNRZREi9yUoopUk+dSq8CTNL2NfrCx/ti8Q=
X-Received: by 2002:a5d:5c82:0:b0:481:3db3:8eb with SMTP id ffacd0b85a97d-4813db3093fmr9641910f8f.1.1786380468431;
        Mon, 10 Aug 2026 09:47:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f90f8sm32487116f8f.26.2026.08.10.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:47 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 10 Aug 2026 17:47:27 +0100
Subject: [PATCH net-next v2 3/6] netconsole: reject enabling a target with
 no remote IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-netcons_ipv6-v2-3-3d4fc987a90f@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
In-Reply-To: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

The command-line path already requires a remote address, but if a user
creates a dynamic target and enables it without setting a remote
address, we currently try sending netconsole traffic to "0.0.0.0".

Refuse to enable a target if the remote address is unset.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 070bae7b4fd7..7fcdff53b3a4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -470,6 +470,11 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 	bool ip_overwritten = false;
 	int err;
 
+	if (nt->remote_ip.family == AF_UNSPEC) {
+		np_err(np, "remote IP address not configured, aborting\n");
+		return -EDESTADDRREQ;
+	}
+
 	rtnl_lock();
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);

-- 
2.55.0

