Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F150AC18
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570562; cv=none; b=DzJy+vSUR1lnsz2H0HTZBSo6GmKaROtMp90knbH8ldnqJ/YmvYmnCoyGKM+N5TYLHuufk+Cd1epW8180Vq/GSq2Q1YGh1MapvPslvyAgzenPN8OiWzYVK+uGhcQzwbh4MpipOZ4VPkE8jB6C/z2LBlpv+Kec3BxC6uf8QBygz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570562; c=relaxed/simple;
	bh=neO9PGuZ4G7cB5JON6/8adxHlnPNKK85h9GRwbYWdEE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn9jC7tYvh1HQyOtbNJDnaX+9rD9Z09OgrKsTx17NzFTgotxl1yhVsb/QLvXmxvfklZ+sjM5lUtbR98fuKgk7wSe5hbYvDNok1PIaFT2MlUhBBowXzLPKZjFVaXceMpDS7qCKwV/Y8LxeX3wqXnLHw3BDaqfbvs76AAuqgdm000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBQDedSl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBQDedSl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-487048857f6so85141f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570555; x=1792175355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sOA4c9z5sUn9VN7fOpKn/7mWxETsDjWhelJneUehGWw=;
        b=SBQDedSljyyFjBypV+KiiiyFha1SeMeW1ZEKN7qzeEt9/PCb3VCf0ayjzZBuDt2lHE
         oktb4t8v76x2XCLG4rDMPGYPKVBfGiPRSJdFGPC4YF27EXMwk7vU4MXxafDug5gxhj3K
         ivmt6yXaL/eb0YfAzraPkP1P1saO3vbXPJnpNwEAe86ZJX2vjnboIRzUboki+2JW5nIJ
         vWBhaIDfSFcPJSWWkpjBz/CeyNZ8BAX9Tdb+wvWcVwiYYLpTTESPPyWCyxkaESWG7BPa
         j3oLqapHDXqRI5OnWRTUyXPZ9WrllJ0BOpzWwA+kEYCbpUfPWPU8u1x2MERAegPQ7J3N
         PRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570555; x=1792175355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sOA4c9z5sUn9VN7fOpKn/7mWxETsDjWhelJneUehGWw=;
        b=LUhE93mne0XEj858vXp3/r4bJTaXDj+Q9lMXz0QQkjjdt4xjJ9HgVFgQpoPvPDGQJf
         GzPON8OTOkLZ8ghsrYTOiKJJ7AeCgHhGG7dHIDDFQIo3kENw+C7eKXhof3pXCNY+krTU
         L1FVQXLdrxqParosOVtTE0UrjmvhH9NR18t9f5Aye9OfrAiQOS48E6BJPv30kaAyUKfS
         nQzpcXvwF7HDXpP9TThFY2D2zb/uIzJESMXwxnrwJpgpMw9jMzPKYDysjzapKuo1q+rD
         p3lzwHd+nVliUVQu7gb31ZKzAqNa9vivCF7zhzY2bxrSdqMbOD4AhnFy/GYNCjTtpLjE
         7t5A==
X-Forwarded-Encrypted: i=1; AKwUvBz3eYp7ls7txrXN8bHoyM5NpZSxQHx8YEWDfrUQoF/tDBEr+LBiB3eRXVLJ5ZjZ/jkbeCl6tME=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9BeYYzppOFN/15kNEmAURRyryIUHkPrakKF3iDxsQMdQonRPm
	p26PkqcoVqws5WKSufYGadLLXSmq7HdEm7Ajtk81amelWtSfewxb2Wp4
X-Gm-Gg: AYBFou3SCtjVOza9VxoGkiurp5yvex4CMcS1M04/lSdWXhkt56i/B1t7YcWjwTxZOoy
	aYyPA6eJNmPNpdV/FXSaERvpQ1GbFWFk1ZqX6UME568khKrDGEOJRSfW5aCk17Tb01+J3FVCL2n
	6SFmfsYIB+kY2QwKqJbQUxOjidzZCB/ex4+5Qugal6cfXqiLFYLRAAoWyWOUFuhaY73SjpZltca
	AD1JW+MubQcEz4oo9HDuTSMLR8Dqg4axQYp2TFszT/OT27vno6Lqivp3pHYIsP1k8hO+yeotYCU
	1EaOJxB7+ErvtIXx9MnZsSBYWjQbUgwrNQjMtX/oD0DI3N5ZP9Q5o177f5PPyB7pLHheFO1mSFk
	Eup0ttHodBdRx9vkOrv7hSiOUco5We940NsVtWXTk8ZZxMPzCK05T4V4fgTUU/BNic7T0MNBYuv
	3mx6TOy/zQAakxS//Wtcg59Sa65rTFQgJ139IIoeRV1RpSoflq5qFsSXZs0PnSs/RElMzT96KJa
	nKQ5WDj0cHVdyVYn0E1qVDUhvz6L4FICD0tcHxjGfEIBaiv5DQ7C7+gcFqP1m0Djj169WUiHW+X
	q4uNkCV7ivt0rBVwTQ==
X-Received: by 2002:a05:6000:46db:b0:48b:e50:7152 with SMTP id ffacd0b85a97d-48dbaae21dcmr3669370f8f.28.1791570555000;
        Fri, 09 Oct 2026 11:29:15 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm5037794f8f.56.2026.10.09.11.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:29:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v18 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Fri,  9 Oct 2026 20:28:04 +0200
Message-ID: <20261009182836.50631-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009182836.50631-1-ansuelsmth@gmail.com>
References: <20261009182836.50631-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b5a0e7..d8533e36941c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9759,6 +9759,15 @@ F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
+ETHERNET PCS SUBSYSTEM
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/pcs.rst
+F:	drivers/net/pcs/pcs.c
+F:	include/linux/pcs/pcs-provider.h
+F:	include/linux/pcs/pcs.h
+
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.55.0

