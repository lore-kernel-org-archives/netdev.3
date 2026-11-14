Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632999;
	b=BwmTKn/J/o+TEd9LYeu8ittAzJyTSZa8I8NnMWvAeUM8TzkSBmbxrm3wGXBfIC/8yRKH
	 y9WYzOGieHpBDbr98qiE733pxJM6BMNmq42V8BJ6v3knU9u6jkXAE3WHhtBbpg4BS1gK9
	 FoWd2E0ExSQDsBFtn6ofPJGjRK7jyhImRPjXOitavLpnIRrb5cTi+YMdQWjbolvuj3obh
	 Dmtph3U9zKLr6bkdiHV5GFQpvK4vm2bavXKHAopgSOIvzPhOE9B8r82VBAh0fN0ZpdVhd
	 ZMyrdw+yzq4NNbbjGM8qPAsnTsCIThKyYt1wTGcVV8+VAvvEMLxp5oj4564TUyQYcfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rlOJXbpkXDswPdI3nKOzR4eyv+X9y3ctMZnxMuEbz9s=;
	b=234woY1GEaCM9clCAAhAgaWpSTzWgneEUEFM7FWa9VeF67Qw81oSi4OGBksZEmEyyFQn
	 soazyGjdI27rUeua4xOQz1IQRlkwNBV1Cmdeeo8Lzmv7/Mxu9zP6JBxd0L6MqZXfwR8Hg
	 9mp5vD1z9GhE1FvD0NfziDtteOHNPIGQZAbGsJQZv1E5jBcc0h5JgKUeg1wxUZQEwTu9n
	 2XVaM4GlLMW1XlXnjD6jv5iSm3k8e8cPf/I2lZgEwxzXZV1HUbw0ONdItRt5DmEpu51CX
	 nhuuf8rJ7vS4nOakeq/MGrEgb0BH6kzjH18ybWNnIoX4K/7KaFmncq5aVUSD+btfQKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP2r083K;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70603606A889
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 05:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70603606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP2r083K
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1209584a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794632998; x=1795237798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlOJXbpkXDswPdI3nKOzR4eyv+X9y3ctMZnxMuEbz9s=;
        b=yP2r083KsnreIwGwo6Sdv5GYQ3soYXjX/EyGkNxmuBuS2IciIQPWJUbOLj81xVdsJR
         5b12dtRreqzmon2OhKe48HSa75theHQSLDe6NUBKmBy5PQZATzJTQCpD3BcLpkGNkUE7
         RxF+7gvuYoTKVPsVFDjjw4Qgm7NWbUz+2u/rt2RmblYBJqBHuYZiftaTQl6ZOyvYTTxu
         UjoM6U6omgoUl6rZO7ah4Hv2VB0XkoPKxZqzHdsZxyyLwU2Tsy9pZTYz3BWlrOtgVpFy
         lq07C4PU4lidYzNfZ/ZJN/zzfEa22yap7/Ri78RIsZB2XY7jD+b63ZBrmWRBNOG8AfSW
         MQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794632998; x=1795237798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlOJXbpkXDswPdI3nKOzR4eyv+X9y3ctMZnxMuEbz9s=;
        b=GX3dGSTTEpu1PGbYgEomreo/JbpjfxuhABQVCMrssd9OMQetvzFmtqywfG4F+EYnL4
         bVLEH1diaNG3DMfyrsFBTsm7IbuzFUsyf2zqrfGkeZJndB+XnAEMTQanXGju9TE13LFx
         /tFNMx6LrEuK5b66dzWGK2+zTPvBiVZ4QmagcBlT3Gk/J4TpC5Wqnb7ZM2K5OJCORKh7
         V+DEx6ffKf5/Ty7JOqyUHVWcT4hv7EY5wIjlXNzEsCMYuOoGYSdyrfhMP/GewpjS0vy0
         KvvTpGDRYWQySv9NcgZj8N/op0rdjt2uxcvUk/UJF34btsPsWIDGYUDbMr/8yn/i5F8w
         juYg==
X-Forwarded-Encrypted: i=1; AL+hErHWTuNnlbgn4OXDt+upJ4ADj5SETxwXrSYKO37VVgny9HX8LqtB4/A2gyBKYqqOCh+RM88wyEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/coxY7dg3QMrm9dnhK6ZWWL4n1zCv5o2rlGmrZX+Wx7fLCLFEV
	KAHq4qPPEA+MMypdivT4SR7QJG6nrBpPUJXFI/bTUxPpwmPbKokAIh41
X-Gm-Gg: AYBFou2bBa5PwFajx/bEYzWEZMBHWH5n2kjH+6YZZWPK3IlmG5Uwr3fwNiMplNChNTz
	LnrGHmwOoDO2s+7ur3m6yE2Z2bCC8tXh9tfCtFjIP6rE4S3scePqjcrZ2ffAyhSG6WB7zgAaYEv
	I6/ALjxKxZDinul/QIgnqPbrGAtoNqs3VveBIpBrToXlEc5M4H9YIUtZjG2YtHEmywmnf+JgmN/
	TVUZhhe28lC4Q2WmoZ4S19N8ZT/QF6DtvNdf30kt5Py6vIzUYmQW+Fj/QlW1DGUibnZt6xNIGFd
	WkupK+FlctYan+p2suSwSi/3fmdzQhfKXZ+fPCf0tX4cZiIv3wghz8e87663PgXCdy7JT0fm2Yf
	f8NVmOxtO7lpRCoN/JLLu6GOnVeghs92R2rndLEsQWb6NgOlsByEPX8RieefSTPeN7la0XFZ+qd
	4WrkifSoG+H7RZJLgT/QiMa+znvgGObj/qIsU67OQ4bQQ4Hphp2zfTdVNPowp4VIO7t3BZs5Ot2
	Lf4VDDPs8kDrhAu09TgazDxavzJ7VHETOqma6YsqDD3rVKk8SRyEaCbxmfK59h+EMFHUq2yD5dV
	fT6kACW5TXqjWgha/OW9MSHAHilL4G8=
X-Received: by 2002:a17:90b:254e:b0:3b0:cc3e:68b5 with SMTP id 98e67ed59e1d1-3b1b09f5d74mr4482115a91.21.1794632997703;
        Fri, 13 Nov 2026 21:09:57 -0800 (PST)
Received: from fedora.lan ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm12776577a91.11.2026.11.13.21.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:09:56 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Andre Edich <andre.edich@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH net 0/2] net: usb: smsc95xx: propagate MDIO errors
Date: Fri, 13 Nov 2026 23:09:52 -0600
Message-ID: <20261114050954.275495-1-artem122novak@gmail.com>
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

This series fixes error handling in the SMSC95xx MDIO operations.

The MDIO bus reset callback currently reports success even when accessing
the PHY reset control register fails. The MDIO write helper also
discards register access errors, causing the MDIO bus callback
to report success when a write fails.

The patches address these two issues:

Return register access errors from the external PHY reset callback.

&

Propagate MDIO write errors through the MDIO bus callback,
while preserving the existing handling of -ENODEV during disconnect.

Both changes improve error reporting to the MDIO/PHYLIB layer.

Artem Novak (2):
  net: usb: smsc95xx: propagate MDIO reset errors
  net: usb: smsc95xx: propagate MDIO write errors

 drivers/net/usb/smsc95xx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.56.0

