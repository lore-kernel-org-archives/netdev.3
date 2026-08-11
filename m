Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1542CAF0
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440567; cv=none; b=eaUt7eKbrJQs954spNxmJVBxnnyPq6d2QfDbP9hKT/iUSV1BbyMmMDcZtpizvT3EFBpm34NEbMj6mGYKfSuUNsUEIDDU8F2jJmccsS6gBKxRlQLBBO0GeKFP/2XmV/MvjtXEn+bJ77pJ7oh+N4l8jPv6MY+Ds1on/58gA4nzgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440567; c=relaxed/simple;
	bh=qr1ayfYw/TaUJNlhsz7JazjlE9h+RLODo9YzpXaYNW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RurG++UwR7OEmuGT7fWwF4U/uGzzwKjct3FapWKRX+6ziNTB1AvDPFmq3N5r7Jq+6qFLkUwoPduM55PluVtxaO0kFfulK2J7Uq+WqxfVq5aNZgXfVUkHvpDeBRa8fZdO2aSrV1OHIgrSvP2Xns1VMtlABqsWLy5uyyhEULS5Yn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX/q0JH+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX/q0JH+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso2900855e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440559; x=1787045359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=RX/q0JH+UbQBDd/25nAaK1+TykO9Ft5ruotgBSd6tGm5YnRcnlfwPhhxku4gMAZokF
         A1cnzUod8E4e3f9pGAD31YI3VloSdfc82zFJCez3RgUm0bIxvu/F5aJwh2pEX9lTm+yx
         I+0l+V8ckj3opmr66mjav9VMGemzA20Vhb89+Uw+oxyBbU7qFlnFwkOuq0p3mjJlnpQk
         6pxD55IjQKQ/Iutx2CK9Sl4N3bMS6TisSiFYhrKkvM3hxnJyF//TI1uHTnFwD2PrGwx4
         XPOAsHFH8wiOKA5Gjq5l2YxVCeJ7bbN9F4jycNkERkw6Sodt9VMDtbfZE+6hT64HEjc1
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440559; x=1787045359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=gJxInf4lW3pgxwMVTwruSK1eEHYQ3uvOojTYkIfFbPDIl7RtFUu8rGtu6g+3POP+Do
         Dl3e3T967Zp8fcGL9b3wrGotg5xosA8nH9z45GOPrrWlJBmuW6GFRjGcrLbpBgo7CmwK
         PosFPVUloLETr1IMoOmGkEiTeGvyLX/VWVCntRuEGd0yOkVFhFlPD3T5nRtA+h6R3Vec
         tVIC+1ScJi6W2ShSUbcp5fJPEeHX7yZbkm1rBZzwz/65/+CIH8w5ugllcATYxXDe+63O
         zoMqyBVMsTIisW6JUE3SOx7F86/Yjp2n0huQSfb2bp+4vHyp214V4sf+ErorJLYtZNdz
         EW4A==
X-Forwarded-Encrypted: i=1; AHgh+RqO/ZYvqYm7wfAGN9klY8UTDDLlr1BZGkhXUaV+NwSvSxbQuLyxEdjHIUG1nOir1lQGf3qh6F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWnwJ+4r5kIqnvt/VervKHWjeIa5vTgbX0SbWlX/c+y51KB27
	inrXwiKXgLuxd3Pkd53bAHJdRdPfItERntaPCCqQ8etFlhRTnQlZAkhX
X-Gm-Gg: AR+sD10I144C6omwEuCqLdAN8WuGtXqpNBhL0NQDXC3Gy9SjmpFF1jseJmIQ1yVOE2I
	GgxS5BqMcXIwktKPl38+gOnoZxKnXtVYoYcHRzOP0z+1+QbKMBCXKlAMXaDfABTEBGzW/oICAvc
	d7Fg4w0P3NxAJfn+f5gVZgtdzAr7wgJ+r8G2kEmXtDonmmBwrA+sA8x3HvNA1AYYvUw8dim9NfM
	B1fCu/OVIBMgjWYBaKcyREELU1Kf4UbwDsAooMqCRO44GyPlAStHjpiUoWMwvp5cBh7tosGQGzB
	WYLbjwS9dhxIx3h9D+Njg1WVKteCKjGeNiClhn9HYxYBf+N5NePobR100TcAIHsJOI6pQwTvZ/A
	ErvoURjWcC/Sn/LR8BPl0faAiIvQBorPG+kBn9wM1Up/aBUiDkyEjn5OMB7CB1Vr27aQlrls572
	7iBIUwJrHtxrCd6z9W6R76bNytH4yzayHdNGaRXAvjnT1My4NpQoffXeZb2zT7Q/H/uPwSSMOIT
	SMY56qfiR3I4y9w4XjOdfC0SCSS8JOx3ScqRK+yMIS76sJR
X-Received: by 2002:a05:600c:1385:b0:499:6faf:336e with SMTP id 5b1f17b1804b1-4997846c8f8mr35438295e9.13.1786440558763;
        Tue, 11 Aug 2026 02:29:18 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm56135735e9.0.2026.08.11.02.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
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
	llvm@lists.linux.dev
Subject: [PATCH net-next v13 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Tue, 11 Aug 2026 11:28:33 +0200
Message-ID: <20260811092843.673837-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811092843.673837-1-ansuelsmth@gmail.com>
References: <20260811092843.673837-1-ansuelsmth@gmail.com>
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
index 08e43bc09735..e3ded0e4a115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9688,6 +9688,15 @@ F:	include/uapi/linux/if_bridge.h
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
2.53.0

