Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295537C921
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728101; cv=none; b=AOthosZMsLiCHWZWKkQEie5uB8dM097Ud/49ZfthzrlpLJoAkY2wBKBTVdsyZZaFp72lF1XpQDAGuKa4dNARHisJwqMEVarJjB0Sc28jz1JkGk/3XZGGY6065Wx/2r3PrMkGUl7quRXH6A/cEk2GxS7tk1QbRqUe3FsVsEBXIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728101; c=relaxed/simple;
	bh=rNMQauPWAk7SzSMQCtB3by9HDja44AYJRiJjtzFqt7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUPweewfe8FuZj4aRVCRdCngtac4XPfyvOBKMmce2l4vw8zhf8s7kxQl5ObWOrkvRAHJxkrI5/M5VL4yvuYU6QrobmtWO5+3DzJqOsd0nQhSOO1YpstNcMlzM3W5VlCdM7InaWCH/8HoNkT8ShMVAJ26mukMvfgr7tlGnYjsrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx53JfTa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx53JfTa"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3386044fac.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773728099; x=1774332899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ6hk3PsIz4TmyUInrYP9VrK7Uxzm9ZqrHL0rQYAi2Y=;
        b=Nx53JfTaXdhSBF8Vs0sC8OmYJF6Zraq26YYTJ02apePxn44TonXNnD+nO/xtYHbOP7
         VeHK7rxnyBcSmbIJOIw48TYcA6zZEqaHAzaEG34+JFDUN9wFitckEwxQOpaGwYhTZ/E7
         x5Uy2h6NfFCvx3S0QqraXVAEB7Bo8AXe2akrdpNDeT5o1xLUgYs2kjeI8HCVINTsGLQB
         ASYsaCQqM/2ZyVdD2kpouyIeU2tIOfWe9ePXbLImdkqlLfajL1sg9+BYraT5X28zCE0S
         xbCNXKJkL9QPgPgYbsKEck1t+c1i8wNj7Bp458DDGwLSrJjhrvntUB5VvVYt7hdUWUuG
         dHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728099; x=1774332899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ6hk3PsIz4TmyUInrYP9VrK7Uxzm9ZqrHL0rQYAi2Y=;
        b=pVDIhbWWR0MNM16CoycrZCryuv/M5DGimnA5+76ljSLYRlpUGQ0GHZDnU4d6zc5TT6
         Chv+cWERWrjN3IDFAC1P+rZeJuA01UKY0BiZHeIWaSgXnU2hLpNPQ13MBWvi3jq9tMzA
         R+PXfj03eFyYzF+d/lK7dGF2//068lNTYIPbLjZX2JY2FxzpcykhG3BYf7dI+SYX4l9i
         YpArKzToftRxzMEfzzYVWqPNMtPjtMIiYnpW9QaxiAdJsGpsqxLFkcshBSW/FZCt+GvB
         Kf7DvknQ8iPBStTEjTnzw7eixKR5kYIam7ROeC1MCn94JjXKUqFEFIqlrMwWSFnuZQKF
         SYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUGZBeNk4haQbGZbKHYgqfBVBGX+IvnqV/KbcuvdQeA1DXRvnwJPLRG6U0i/5bz+qftY9bl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XbBzc/oAuIO4bC419KtnGcKj46jftubbMmdXc7OaN8KNUS/Y
	V6bOh0wmFKcxVAx7XiRzApRQSsyNNTGq48dj2B8UZ4Kfp8vvNs152g85
X-Gm-Gg: ATEYQzxEipGbhkFatAle86d1z3uEMx31dahNZMlimOBHsJJD4UYfhb6k2IR+5y9ceEZ
	nI/kqB5AWOLnAmYu9FgePqGcJZI1pPducV+plX8HibYTZHNlnkRkKSVBYDXEQTNqlWUJtljlGn9
	BCdMi+t1nJCvAYejB6i9HtUuCmy/6aiFuWm5np/1k7SZMhMbrnr76DaNEtd0sVR5IdMS8YbpFBJ
	aaHv5/lnOEKNq1NkR7ECNRATCPmpuz2imMkauKjfc4xrNn9Kuh2KJCC8N9u2YkuCvnv8AfdIf19
	PWEG+ghmyaTbtHlSwOiCAkC1i+TkCXaLcy7iO0W7NXDQbb6QPsrylK9RJFpOyc9b9Qo8vduZl4S
	jBjgLbUZqpE1P6MiSXF8coLBfC+DtZcj9EYGeN5UwRoqksCoiL2C/6FrODsLhA1lv6SXwsAjyv9
	yXj8FnpFLug4y6sSdow0Em9uFBnw3fxLwitk2jQcTPQG9uY6GDF8/aj5a5k1NGChnSD3c5NV8lm
	A2IXNp3lkaykDSDLWgXFQ46JUgHpOVzFsAwNFBbFQ==
X-Received: by 2002:a05:6870:6109:b0:417:6b32:f50 with SMTP id 586e51a60fabf-417b945b989mr9372892fac.50.1773728098865;
        Mon, 16 Mar 2026 23:14:58 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e69c79dsm16985756fac.15.2026.03.16.23.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:14:58 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: willemb@google.com,
	daniel.zahka@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net] netdevsim: drop PSP ext ref on forward failure
Date: Tue, 17 Mar 2026 00:14:31 -0600
Message-ID: <20260317061431.1482716-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsim_do_psp() takes an extra reference to the PSP skb extension so the
extension survives __dev_forward_skb(). That forward path scrubs the skb
and drops attached skb extensions before nsim_psp_handle_ext() can
reattach the PSP metadata.

If __dev_forward_skb() fails in nsim_forward_skb(), the function returns
before nsim_psp_handle_ext() can attach that extension to the skb, leaving
the extra reference leaked.

Drop the saved PSP extension reference before returning from the
forward-failure path. Guard the put because plain or non-decapsulated
traffic can also fail forwarding without ever taking the extra PSP
reference.

Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c6200ee6de2e931a2040d56f9523006..3645ebde049a0245febbd454151745675ef80b23 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -109,8 +109,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		if (psp_ext)
+			__skb_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
