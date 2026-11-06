Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934735;
	b=tAb5A8IhQDedovMeL6wiopLBeOqe/tZU/fwZkGgUyaXnn470ns2VN2nsRyjLx04pY/m0
	 6Rd19NXWXUKtP+IkJ7Jq6kNN/d6gUNFh2Q7dPPw48QYj+seeFLqu9VENRm/HVLEM2uAfz
	 BW6wGC7d1vGYT56rWO+6azNDA1IZqEWZkJZuNFai4w69T8/wMXvxn0vMzshy5LZcUdOJy
	 Osm1FmSd4KD3EH0qCI8RnbGfyVOnFKQkN0NexObEY/OhYpygNCtQjHek70GYWzX0G4/Ok
	 d0D0noOUbucvXAWIF37sBtByA4YpyKtRrTQXVto9MHo1gRIDD2tnhars/GOOsNBfZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ff6PTiGrdFGwQ+XfBLwgofKAzGmny9vJs85i5I/222c=;
	b=L+wII/lxReVXPwmyUtKfUIc8OpeDIgenMGCXeY/EwLuMqg9QL94GpuHdLsp/FRpC/wh2
	 R5+AqCVEmmQ7HljqFFCr1T13JqvPnLznrRsqkf9AZwqZHnPvXC1DH8Coyf2lOio6hTd44
	 a0Qu0MyOgzdBporrq4l4hxaiID9RBM9BtzQm5cRuzKWWA2ndiLajNSdC8H9gw2dyVCz20
	 JtQHbusXyK+Y5qh4spVClKUkciGDzRqnREeF1Y1V7j5aUutkxyr0C1Z1CMJQqccF7341w
	 vYNgHxa5ssciiAkeW1MLoox1VT/ZIvonjERXAHs0P5Klg1pszUc+8uvKRS0iHyc2ryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6IWp2JW;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D5606A330
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D9D5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6IWp2JW
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06c60065fso62829b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934734; x=1794539534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ff6PTiGrdFGwQ+XfBLwgofKAzGmny9vJs85i5I/222c=;
        b=c6IWp2JWjxCrdmLv1HzBmo19rvwEu1wp9A/ZlMhE2bvBhWDj61nes1rucRhaCXQjc2
         qvlUmHTteeOj8evY70jZiwjfhwKsjZiOk/zo40LKcFC5MBGi0qkie0rrEPg76ORCnift
         QQVPq8Cq5CP28rcys9XtatQV5dl7mjncTVUMO94PQdr+p8rxwOGhkObbh0tL/QQm7/g+
         ba92tw07SEERv7PTg2J7KBcq2SfwOpCx5OI/42IZ8gIc/x/pcG8vcPs1dkRJfuD/tXue
         HP8aTLcJwxBmhh/ie6r8SmxGJL9OFpuJORKNmj4drj0W6pe1k6EmIcCJ49wN6I3L5SiH
         EFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934734; x=1794539534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ff6PTiGrdFGwQ+XfBLwgofKAzGmny9vJs85i5I/222c=;
        b=WonKyDWWpIDGmc4W5MFFMmIN6BvH4D+il1W0uizdrzAzVAlyI/JTkmbdHoO0cM6Sb3
         5nmZqUPFemjFXDjaYlk4Bp80Cj8pijt6uJjgc1R5s0q/K5oE0rr6YbS9+SGN1QzY0cX5
         C1iqvxdbR2NbpmtpJoGUGin6EL/oa0VaoEKTz0KX7czWvXeXMs6LDpTlr49ibcQIxg3F
         pAQpc06sImQUiudcFvOx5nLs437Am0Q5OdXILV2cCEd7TPA+BBnXacHPI8WsMm6srsi/
         ctpID0s+BKbpeuLOTNDHvtsDBLYjfLJBTz0N2T7NpGla4tZjCM6FE/CAazNE0DER7h+D
         jKDQ==
X-Forwarded-Encrypted: i=1; AL+hErEFjvnSvH+o/wtEU7EWxYjMKt3CGAsZI5UMJ+71/bxno45hiqhOfwdm1VAaa6fFJzcCxnsniRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/nBT3EKSFVBsR62Zr1gr0J8G27zyEI+9VgEDRhehY4d7ZAtZP
	kV5V/aJho4L6jFOsADN8OaZYzX7rEyklU4+D27VzlayhUVDZRJ/w121G
X-Gm-Gg: AYBFou21klZqpFI6EldbpkfvKBShifi7nA73XqUJvnWY3DxyOJXLlopTjR/LsfmCaHv
	Y//2ZJfrA7RTysr/OdJ+DVpGuRc+oYfPvkP6LAhTGA4D4isYHmAGTKd4FdHX4Gyb+dWOIzSXJyz
	RCLXugYWilVhXIbLw4xjKGDaGfbKA71xbHllHdXMaLQSdTxeLGj+O6vkOgYomoSxVpxgw4Jdbou
	B8oFl/f2ODHsNwOm+9e8CmLvRm9YBeGQqOZhlS0ln/E4ZhlFUTfFGh8+BXKDYfnae3oTqxSUDkO
	SESMAWAh8CMPd/hG1AizQzVRncoVu5aRWvMxegUumwZY56tYEpRKf6kFtt30LGLkglOw7Kv/+LX
	qFsCD0ojFR/3jt3CkebcsKS1GTFXitr0UOkMd+xHkbJTYLQPlmS2wngGbwdRlilEpbPu2nU2tpj
	qdT+PlJDbWdGmGNtgKg80FZ4mo/6D121leTQ2IgeWDuKgBTWQr4woJnpbclWk6LbszdYn7SVrJS
	9h1MRJdfcu11QWySKm023hhbm7L4AuU5AaSYWerApAWpl0BPH3VIMLiZmwpTfN1feWqUuKmmFEB
	0m1pCn1TxTIjLm1WQbTg4s1UzkSqOtaoog==
X-Received: by 2002:a17:90b:4ece:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3b0db705fd7mr1061194a91.33.1793934733894;
        Thu, 05 Nov 2026 19:12:13 -0800 (PST)
Received: from localhost ([2a03:2880:7ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42c65sm1357846a91.4.2026.11.05.19.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:12:13 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next 3/3] selftests: drv-net: hds: restore HDS settings in ioctl_set_xdp
Date: Thu,  5 Nov 2026 19:12:08 -0800
Message-ID: <20261106031208.465456-4-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
References: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

ioctl_set_xdp sets tcp-data-split to "unknown" without restoring the
original setting. Defer a reset like set_xdp does.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 tools/testing/selftests/drivers/net/hds.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7f052c319603..a1ea195743b5 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -254,6 +254,7 @@ def ioctl_set_xdp(cfg, netnl) -> None:
     """
     mode = _get_hds_mode(cfg, netnl)
     if mode == 'enabled':
+        _defer_reset_hds(cfg, netnl)
         netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                          'tcp-data-split': 'unknown'})
 
-- 
2.52.0

