Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535246;
	b=n7HVVT3hXMOC5zv7eJC8OKg3v+ZABvmTLKzXvMYeSVMrWF9z7AAdSqmMHb9Go8fyDiN3
	 Ux9aKAE1QANGjdgiU1T4g1LpDABDIlOJI8kG+ZlG1TeuUmhaECry2BKql2FRrhKCFj26n
	 B2E8Z+A0oWFOeXtP3tTGA2w6xUeSmI88CBgXrfSNwtzVyVGiEeie6/zSeudf4zgBq3uqN
	 mGnU3OQv0JWb+nIE6uBsmdgzShBlKLnvMoGRIrsXAwU9o8PYtuJYlpeDtadMPG7jkMTHg
	 BmQEiiv4ZWRPXoXlDINuwHfrRXKeoGLB7Eh3TgmxX4obsBymnkoXKBUSfRqBN0cNG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/8+W0UostAofXOqrRgVY9iT/+XWyOmglnbuiDK4suH8=;
	b=qUPZdz8zRH3juCGEfR96c+0M7KyCjnsUbQzAmhwXD1LFVPBNrDwQJJV5VeBlWqhfj6wY
	 Hx4X38JohW2CPy9qsFI138ROJe1P3m98ngP7cpAirQQO2fXfKeGFX5jSvQSwgJKeNGhj1
	 mxSMLUUtQSdDkJ6kcidI+EXNjwS3QZFVqbIUB2lZNwplE162vXkRO+SxX5m8BsShmtsq/
	 1kaoXpYg7JjcD7AbcqGT2BRgzJDDcFMYi1UBuPTLir1ik6RRteA0Lg1Z06fOC4yrMwRGp
	 8RgRbPKh9OsL5lAsT7FCHbJCqMG7exQ25kZHOlckmz+Nu3WJKrqyk24TFxSvfo7ulFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NwZU2mfI;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C83606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NwZU2mfI
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso490455ad.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792535246; x=1793140046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8+W0UostAofXOqrRgVY9iT/+XWyOmglnbuiDK4suH8=;
        b=NwZU2mfIchf9XjG8WbLGE4BSqGEk8u93SouTWzashManSaFl0JKV+iNLxE/iXcZdbu
         8jk0jUMtxwlySYruszZH/T6MRbcYdbg7zglMWasOKsBJFuNK+xSxTIqE0oAdX3IcIKXU
         c/eelzCNRBZ0KVZ4fxS1N12GvDtsrkjwwQdy8jK2LtnE3KZgdNnrL8Dttab0Fe0y1hLG
         qB2oXMFRWO88wIoEYy1o6Hbl0mz7eBzP6VCSBVel43E5t0aEdQdlqW9Ckh68jDTbmjhA
         GFdkSu2jbTs5sv3DS+oiLUZe8nu6k6sGg9Qj7aTNg7w978jLcc5S/cG34NtXHYVTD3HY
         jfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535246; x=1793140046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8+W0UostAofXOqrRgVY9iT/+XWyOmglnbuiDK4suH8=;
        b=YrZIGWd8soTM5QatkGKs+1zL1WipaC5cDeT6dcnNUHQcCL8e0mvGHVVblEZPz8xGBw
         9df0DFwPCzd6718x+zgywFQVm/9ZtBmRgDQpKKBn/8Em6XOz7j38vbOMcchVqSJejyCt
         yrgTesrcMbj7O+a7aIPvoBfymmGKOFt1u62HgNJsPg0n74oqMnnTlph2j2wiNAwfpswa
         ifQuQdS5/JglTjoHHTeWY8d1zZ4atj4mYPyOqnFm18znz9L+DXQPQmmK1lNbhO8sndL/
         gF4ffrsPgIf0J5WvLmh3J0AJ75OH0+nezfcuv+0ZLDxXGcV8RloD3W5RzNipVJpzXZYZ
         t6fw==
X-Gm-Message-State: AFq9FYJEAGysnz48jjuetgVzJAqIOEW0mh1c1yZPUmqpHPN3vWct67OQ
	rJlHz3lz20mCiRUagsF4rZS4zUCehBumJg4ZDUYPs1qU0vSMirU0hoPGk2M0uw==
X-Gm-Gg: AYBFou3fNZWh60ZMOgw1YUj53hpyasn61hI+3xlwjsrdVamrfbNremeHxAWQ3Zaa2xt
	dVgjUQGznsoGzsI1KQViZpEpG2D8KqcMJE1o928zckU4oOujiPtN0qnZ8C/fnQDxU7wVxjlFb+z
	P/hxQ8Ui0ywF/oyayE1opPZujrh7r9elmwlapna1VDwAT3qtz5LLfosz9rIJsA16ykw9UdUNwim
	PWgFy1BhAZ4IQyqB5V7jfHIuNjyv5gcn4OPC4BK8PFPgSatfs+DcNo56K7W255Cr5lJTw/zBXTI
	5dZUCPSp11foXtVjziElmxmCSz13w+j5XY3lWdovgub7e/qBadxkxiO+ojw8kccMlZWLXrHPYR8
	X0yCtU4eMQw19WAUtiCpq4Jz3NoRsjsw7UQN0T612gtD7sNys2LLEJvnvjsrQNRo+j2y5sPU4DJ
	uRBhdUyIfEur/RxYim2zBUHDPFJ5ei3+JK3hfqfyFXlIEyHA1GiPiTP3NMU8kgt3mWucrDxr1iW
	Hwn6SZyGbJJEZXkf25+yYdXS0kIc7I6WhtK9BF9LAFAp8yFpjTpnYslR77UzItLBwAT7otS78Tk
	/iC38PHXAyjL7MUQRCnjquS/pE70ym3+1IBc0dbpMymiqNmi9upN3iUAMw==
X-Received: by 2002:a17:90b:2d0c:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3ad86d39b6emr265214a91.50.1792535245784;
        Tue, 20 Oct 2026 15:27:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm1320396a91.7.2026.10.20.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:27:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: emac: guard PHY bitmap teardown
Date: Tue, 20 Oct 2026 15:27:23 -0700
Message-ID: <20261020222723.1746201-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

PHY-less and fixed-link configurations retain a negative PHY address.
Avoid shifting by that value while removing the device, and serialize the
bitmap update with PHY discovery.

Fixes: d6f144830bdf ("ibm/emac: fix improper cleanup when device is removed to allow re-bind")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 4124a90b18c4..0f534af2f3de 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3240,8 +3240,11 @@ static void emac_remove(struct platform_device *ofdev)
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
 		zmii_detach(dev->zmii_dev, dev->zmii_port);
 
-	busy_phy_map &= ~(1 << dev->phy.address);
+	mutex_lock(&emac_phy_map_lock);
+	if (dev->phy.address >= 0 && dev->phy.address < 32)
+		busy_phy_map &= ~BIT(dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
+	mutex_unlock(&emac_phy_map_lock);
 
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
-- 
2.56.0

