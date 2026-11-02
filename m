Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649311;
	b=132CAXCBsyG71p6fG1gQS5k9ApO8xJ+LaDRn5e9wjFDVw0BkeWO2H152A3xn5JaE5Yyv
	 qy0Enx20MMyyy6R3RKYgBRaGVyMGzVEIQCoffd8OQgEBGl7iUweXs1cRWfI6LDtoM2WSb
	 D3PQrw0SLmtrtK8OJWybqs9Jths3+Vy2dSfiGhtPOK2iaiglu4bMe+wWUh50ByRTyrO8A
	 yFh4ebf6XSbyQ2/6TaJe4A5swULKES3ehXVlMe4r8nnoX6CqCMDA4Zp8/mppPI3LnOPGR
	 NbJycyzm4PXXXWYGLpWJ3/0xNH7M4fRr9aYqLnFXtkZXQPrCUlvLJnjD7XTHllzMiog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8S1OPXeizVR6aCx7kfE6r3MpJonS/IfzX68XfZXD+y0=;
	b=yrkDx5ZlFBLD89PATncGi+U72yzd6E2pAoctPoq9uGGK80vqNAvDNY5nAWcxmcekyhoN
	 fM8F8k8D+JSrGjxEFji7BjFiO8XHC2Ei/pKkN0qTCR9Waw6RTXguVW9D7+8mwDemGixe3
	 4FBZjBlN5wxZXycSfQhpwMpmqAJNL/DnS8B4ZMBqCcS9KERJ4MWFKyUyBjmNEIpOGm/hS
	 AAj5+K9x970RY6ecYfrQpJ6GSfOQy4mYZtuFOHa3UB3I6u9cEC7JsJ+3jPKN4L2tpxmoK
	 2Fqb/oLv35ojeGzageQTveqGntB1Vdjb+GMuLCxKRsPNRb3iJeOGRwxomAKzqHdeiUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IzzOOCdE;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF36606D829
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF36606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IzzOOCdE
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso14253575e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649310; x=1794254110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S1OPXeizVR6aCx7kfE6r3MpJonS/IfzX68XfZXD+y0=;
        b=IzzOOCdEHsLpF86IkNs9HxVKY9A0so5vOySkAg+Dx6bqY4n2pzS1LE9liuU5FRfITa
         DupkIzl0EBcKuIgKdo5R2mzKeRkf54EyTrxwufdP2Gt6sETEQ9bPiCmA5Hv4x/OWT1Og
         f1NtU4DtSxfuK8veHGKhni4hkQtDKYkrSCjQVNLAdY2HmfJqNbfpLk6fQmeDyu8MW8WS
         tMNKKyipG18Hn/NXEQ3bGP8zhcmK6PV7trYmFTvmjnGe17FRTslE3cuqu3/SPlUVgOlQ
         Ay9/uAXjiYXyOpRZiIaapbayx+X/x9f41iZRji61aRqQyPh7wnJ0aaxevVdpAvOsPQvL
         EJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649310; x=1794254110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S1OPXeizVR6aCx7kfE6r3MpJonS/IfzX68XfZXD+y0=;
        b=yIsS1/mpKGUu8NWAXoED4vSxazvzRoYszfwXjmGfFd47c3xt5slSfPSIoL7j+qBC4X
         SDA9QN1NpRbIyCQH/DFX4s35K8yw0SVyxpq6SN/cT5MLDXhJzj2jyR03r9wgtHN3ht+Z
         MQYwdQ6NtgIKN/LfrlexG1avZkw+vmzziTq+ePlz8O6y+5X6QiKRc2GRu5S2Oe8e/LvB
         eXSEVNCGYcZHdNWkbv41iW8fAIrjOrQx2lK8x/8vNqA9n1sQux/CE2COGI68vXgBDCVr
         giGw9CSf+MCd1wxpkXE4TEZ2gxJjTBDR2WkWo81gbelDHY2KeoLabmRgbDn4xFu3v27a
         cwqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5UmZgMfJmffuGcIIynuszkGr4iaY2rYPDcfE0443cothVPPRQ7IbVlenMbMuJlODLn6sveFc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAb2fDzwuB2np+XwtwFFRK9NfZiMXu4N904usKXxdGY42GB+jx
	9sSm+wiLIC06rPKQOQGhFMyGbp9PYWR5s9wEcB1kJeTt8eRdWqbXmNX/
X-Gm-Gg: AYBFou3r/YY/8+pvIjGA0Br/Qh3tt+ynfkMUw17YPdDLoAHOniEuKfq6ln7L+B9oCl2
	iUtjmX2aGk2XeuqZyx5WCpBx3BtCU1PXss9FTcbnp2zL32szS0EJ7QxxNJgjMxcO5LEf4i0GWNV
	L5IklSijNjqwQX9Onp6BXsWntrKfeI14pzeHxcyZwhp+UvpoAXFPex9Kn/qIPzy7ELlBQDqiAd6
	U/dZB7l8YPeGmj+M17KgBH+eYum0IABJUDovbLixx3n4mEoem9LvBfZjEjU6zPaTsQFtKxFBebe
	uq+f7waYGsmhktBT1SEUyboXrt767cdgKsZfmZtaUZt1A0X0X6Qrwp+EYoqZ6YuRHgo7yWtlXoQ
	+68/W8e1NAFt9fvFyaiSkASfDzRG/BLqUyOMkn60ZpuFZLN/nkz88W7/oG/rMUYECbAHrqT8H7C
	sv+HgsmGwj2NuPWomRU0vjSkrYSBoML3r0xE8s0RYHuFsfoxZfdPivLbmPVdfLirtXca7ZtJhYQ
	ZjHji7jENXLlSPgjANQCFqTrYjY//zefQ96HoRk7NXyUlz1nYGZRV1lsYPZ+vTXqWTHqKVgZ6sH
	KdvRezlrU30=
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr196973475e9.1.1793649309659;
        Mon, 02 Nov 2026 11:55:09 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:f93e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a922c298sm7233965e9.9.2026.11.02.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:09 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 02 Nov 2026 19:54:52 +0000
Subject: [PATCH net v5 4/4] netconsole: stop waiting for carrier once the
 device is unregistered
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-netcons-fixes-v5-4-bdada2f03563@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
In-Reply-To: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

netcons_netpoll_setup() releases RTNL and waits in netcons_wait_carrier()
for up to carrier_timeout seconds for the device to report carrier. If
the device is unregistered in the meantime, the loop keeps polling until
the timeout expires.

Stop waiting as soon as the device is no longer NETREG_REGISTERED.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-netcons-fixes-v4-0-3857120c6340@gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 238acf300d23..895d33b179e7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -383,6 +383,8 @@ static void netcons_wait_carrier(struct netpoll *np, struct net_device *ndev)
 
 	atmost = jiffies + netpoll_get_carrier_timeout() * HZ;
 	while (!netif_carrier_ok(ndev)) {
+		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED)
+			break;
 		if (time_after(jiffies, atmost)) {
 			np_notice(np, "timeout waiting for carrier\n");
 			break;

-- 
2.56.0

