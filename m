Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653915;
	b=GXvfyD2zU2lPJjbJBlQCF2/8parMekGL6WFcRCrkZGXQOOMsiwaXcmCOtyX3zGDUgZTq
	 gW0BpgZ4HfQdIgpBDMS/a/qjNKgTJkWspnqLEEqnQkt4rTaESPw2BqB2hLIOxMAY2p8SG
	 2Dxqf7vfW/EvLkVh3cd2A7fvp+bCS95ARKpDI8iPzH9IuoJiK48MMCcZvqLbVGHFh59tv
	 FHdGhj8Lfc1LoQIwp2ZkSLaRJYbHSyFhrV/Wtq9u4IFBK123Jv2cVdYtfGo+x+Nzippcd
	 xjaIWKpYoNMCuw1hau9raM5Zk1bvOPu1fLz+jZxbnAEpMTz7SX9FaGY/2ttgi35z8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zp0V6uq9cSdHG3OMQtcSrfjn66ui+Jf9Vm1BV0hp92U=;
	b=BNo521yqUYPFnLelIPCsOTCVaNx9KBhvS6Gy4F9WLRO4+BJE9Nvh1yN5lQxFfm/0SnmW
	 XiTxgWS9H3mwcTzo8l4vt2LE/VHwdALZb8zP0j5fp3yMlYhT1MiU4YA9FhbAxQj2qV3ZI
	 StRltTMJGQX1MFIqlEkPr+XIl+uWjEdkpTBXilUqyTl14TtcjZ5E8tHh7aF6uaf03E9QM
	 Y8U2JN8YbMG0d8UoGKxxWbtL3evW4Chq6YK2guOWe2wspuoBpO1Azjg5CrmVpu+jP3/RX
	 3lUNtOHaK5v2ytnDgXID2lcGs/GJqKzhs08QZ+PIq9zW6XdMpft+SfVmI/tccPWHHEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pw7n9TV3;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13664606A333
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13664606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pw7n9TV3
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso33615f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653912; x=1794258712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zp0V6uq9cSdHG3OMQtcSrfjn66ui+Jf9Vm1BV0hp92U=;
        b=pw7n9TV3hXbr93+QK6KCZ4NiaMlSC9VR2NTKxZ2G0KbF5cf0GwPv6+wTsD2HFv5pVF
         41/qrKMfz9jKsmJZ8B6zEoboqIokpkDk4hzu+vBELk2zJJ+itarOLBYTqepkoemmJL6Y
         +s3X6mqVytQDAU3hRx4MntWocJJazcWWDfg1ze9l8hGMJhPRDsb9ghwED4Tqp47s4Yvl
         5q+5uXdv+U2UtaXe5/+l3LWdkvL+on2ieWX92QKKxz0PGib0vx5UxbXbc/kOtIg/2NZf
         r05xepgHxRbEPNpzHdkgCorevDEHFHAZbZlqVZ5Y50/PKFcyBOVIggBydWpyBRWzYQ/c
         lWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653912; x=1794258712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zp0V6uq9cSdHG3OMQtcSrfjn66ui+Jf9Vm1BV0hp92U=;
        b=zvD2qU+yzx2uWMx966e8s8KLM3JRSZlCWG5FE1UW/UDDJWw2FJFlWPS3YaOwfO09uJ
         LatNfqUdZ7FKb6XMcdBWA74A156blFCRcIYbiPuJk71RLklpYSPeoLO5WO+eFGeld7o3
         5wf4aSi+QytAQTeLQCJf1pOvkss+U/WJ9DUJtAJdRvoC39c//J2C5wkldQhAW+zOqsyx
         CoqCRB8I/oKK+fNCo816Oadt+xNgF1LFDyG75XZw7vGEgGGuShfI1Pv50ipj9tpiNxFW
         C84ND214fx5N2Kn+VpWJbOKaX7MI4UMpctkBvLuwQyZmtqt36qzQJUsgH/YPJfNAIXnM
         Pxig==
X-Forwarded-Encrypted: i=1; AKwUvBwtIu6CvM6XgVVDad7IaacXFhHXWbf4yBvZWeffIewFAm4tLGkuInTdsMO5AIqgq+kl8aeQn7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3Ahw0w+0ttl4/uFoiFoykLZ9JXfcRABv1wgey/qNHpGWaoUeh
	E00HmIqdHVw93Ago8Ynj4OD4lAL+ZDL06ni6nGktZ4eTCndYOaEq06Lx
X-Gm-Gg: AYBFou1t1KQzguLDSIHJjyeEHylUgU//RXa0JbB+Yjxnn7EqNkGFVvyCWk6GvAXp1C4
	PHXvxSQCs1vJP71GSibkT8dGbkWRhaMo7PW3DhqtUU0E7wH+ZbeeO0liyP8cAxiu8d271X9pnEl
	mm5ijImzsWh+pZCSSWNCaEkp6BTVEx7bx6Q8oWL6S6ncS9oN5/4CusDBEBdokMlBnXbc/9D9xDh
	/CON/cI2H/9vVb3zOsUZC1qB+KukV01u2T+jqkpVJXfD3CBuFwFdTw4uQniNNvZtU/iI1l42LEE
	xRii2Qj2ZrumoGAXB+XjC6uHaDymJQ8SvM6i+Oc3oyRq4Q4GlAYzmNlBcmIp6WzWy1oNSeAQzII
	YYXbluMZQ9rJ/qjkxrAzR4LaHV1E813Op5vJxWzNEM/YKdfZ2X7XZEz8JlwZ1GSN6WYDu+eqA0R
	pjcBNz95vnOD0dRAAxAILG2UMn6OawCy6OtD8m0ecLkIdpjZWoxiNJYzODc7X0/GxzVXba3umNA
	mWYxI8Wb6+goKiwWKySv56odlR5QNRSGZkheIIp43eBBQD3XlEGTVRrti9rUscIfs1nztWKtJGm
	iTTXPK30yI14pEtuzWIVjeJMjVAHaJ19ZZ6GEt1O+0dMU2DrSkhlA9uhm57LT1efoPjeKeRKJw=
	=
X-Received: by 2002:a5d:584e:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-48e6e2e2369mr26875294f8f.22.1793653912530;
        Mon, 02 Nov 2026 13:11:52 -0800 (PST)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm21535520f8f.9.2026.11.02.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:11:52 -0800 (PST)
From: Stefano Munari <stefanomunari.sm@gmail.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: usb: lan78xx: fix error handling in lan78xx_open()
Date: Mon,  2 Nov 2026 22:11:19 +0100
Message-ID: <20261102211119.8738-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed interrupt URB submission leaves NAPI enabled and EVENT_DEV_OPEN
set. A subsequent open enables NAPI again, triggering BUG_ON() in
napi_enable().

Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.

Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
With the fix, the injected allocation failure returns -ENOMEM and a
subsequent open succeeds. Verified connectivity with ping and SSH.

Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
v3:
- Target net-next and drop the Fixes tag as requested by Andrew.
v2: https://lore.kernel.org/netdev/20261020202614.30277-1-stefanomunari.sm@gmail.com
- Move cleanup code to err_napi unwind label as suggested by Nicolai.
- Add Nicolai's Reviewed-by tag.
v1: https://lore.kernel.org/netdev/20261016000521.92868-1-stefanomunari.sm@gmail.com
---
 drivers/net/usb/lan78xx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 181e8c087..d73002b2c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3497,17 +3497,20 @@ static int lan78xx_open(struct net_device *net)
 		if (ret < 0) {
 			netif_err(dev, ifup, dev->net,
 				  "intr submit %d\n", ret);
-			goto done;
+			goto err_napi;
 		}
 	}
 
 	phylink_start(dev->phylink);
-
-done:
 	mutex_unlock(&dev->dev_mutex);
 
-	if (ret < 0)
-		usb_autopm_put_interface(dev->intf);
+	return 0;
+
+err_napi:
+	clear_bit(EVENT_DEV_OPEN, &dev->flags);
+	napi_disable(&dev->napi);
+	mutex_unlock(&dev->dev_mutex);
+	usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.55.0

