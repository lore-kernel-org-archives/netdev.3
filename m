Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529978;
	b=ihAb1HscOyhdXvH0TYSkj33ypP15RCf3u09zJUx00Uju200C9E6dDUKr1f5hf0I1M0ZZ
	 pKZFdAMY1edaSszTU3ctRD2cEdhjEuxPrqKgbwOQFHfxn1zbz94D4IUbYzifVh6MvD2hw
	 K0cFSFpg7aANyaJk1wmCu7Ck+qWdQn1gv9xOT41CBQacQj9O+qx9WTUMfeCNRIikpAHSC
	 RJ267wLBdPUONOFgca3hfDox3Q302UXOkjgqplYDVUILBxKFo8/nP1OSOGSxXzG69XYmV
	 d+7xBkUjLQqSU1OXALZFYGvyKSSlVc9856jQHAwAK6akWTLPWrb2rK6J5WT18PvMjOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=geHgxObFWVvRZemosAYU/Jzp3fHhQwXYyeBLmeYyX4s=;
	b=WH/85WlTRyQmOGvliQ7HZ3kXD3YKCtZjNId5j4ydvmrOaKMHKoZY/3uqAU6uTa0gOcJA
	 BJ2lCK0hbvTM44YiSa+1m6WtfkwbLEj4GV80LyLOe0qtbeFllsAXq9BEBtJmcNFD8TtdP
	 MNejdzS8Cdlz/yvhdvsD5cY79couYZtjja8hRp+V/Z2TgVgWd/IUoNBuSVf7N1y0KEW5o
	 rkCa+DqnDyq3w/q55H3mESxgiT2icRteCYsRqT4jDJdTkThatKG4DER1gw3GnhEulAd1u
	 Cst/rh/fnO9luxDZCvqL7JTZMijI/De3MyFqJYy3iU/BMDF99bujL5H6gA9ucHM+cNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrTJnggR;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66102606C259
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66102606C259
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrTJnggR
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-498f5fa5103so133105f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529977; x=1795134777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=geHgxObFWVvRZemosAYU/Jzp3fHhQwXYyeBLmeYyX4s=;
        b=GrTJnggR5/Vra+g9toBGqmFb+8V9HqTPftyxf4x9DTK+FuD6Qtd6EUde4hy4Axt6wq
         oSAQkU7S9Mk333uC3P/wUgGlh+CTntjRG6HBeKq29sCE9p3cL7T0PvHTv1ZS9LXdTdbP
         t3YiBXe8uNPTyaq56cXLNGx6leql0y367hx22hpGcW+Ndh9oAlWOMFXWE+y8tFXAiIp0
         9V5Q0vryh4eqgzk/KkNYMpyeYgnjl+XQ8v+KouXkc6VLI5DIVA7iuWJQlbegO2kSAcVM
         rfMGlolkLOVr0m7vIlQuOOcakfrER+PsoKPowEkf2VbxRjNuCui2JnwPOhXqHkvdaYk+
         vlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529977; x=1795134777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=geHgxObFWVvRZemosAYU/Jzp3fHhQwXYyeBLmeYyX4s=;
        b=Z6M5hzEJdGs/+Pt/dZhQ/w4WKaqOjASQW/aJBb3bcjuhPJxlvdXLUY++TbfILD2PoN
         0uzqWe6oPi/lE/Jr2INw5KTFqcipyPHeeIhqdEmqJv0vcmIrGkbo+A12xUjxrdYUkmKj
         u4T5hua+hCESvNRzTaVaEG7LVyKReufPNZswQTlV/VhLbB60OICFUgnzyZaIQXA6XxtJ
         9G6SJozcKr4gIHUUjTemU/nRA5sFBp3I0s85efgOMnlkvUizKAO8fe7SjX1DAEjlsaOg
         gLKsMLFHNwbxVm+Z3hDzFQXl9oj28dJytLfOU+88fK7XcJGIUkMrlptizBkVY0MzKeAG
         8YZA==
X-Forwarded-Encrypted: i=1; AL+hErG+oXHePz9QcS8rNzNHw+tQc3SBAH0zAR+bxwCKc/tRA62QXf+NCaiXKM5uCdo2QbRC537wsOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/k7M/IjMTvpoOfuAKVm5e8CA8tQ+XsLEXGMpzSMiI0ruE9rw8n
	oLeqB6avITWLxeL6ulgoYAQDo5GroHI3YOEbg/YBEqyUEX04lI6kBOT7
X-Gm-Gg: AYBFou0Ww5ik5PZXOnxSR8oEuGiv9Qo8S8K/hXQl72lGeHg1bsoGFF/SiHg9xJ2n0iv
	d9/licmqf6yHNrH3rf7hFIJbPCBMDflGbcr4ewOPd4RkNGxaW7FCY6W5j5ikJbRqsyPefHiGk1v
	gghudsCc3nUwigh7rgrwbMmjljVquUOKDrHm5R96SgT8b1CcxqEPk0WhkyCRJbiwhxoJurnkeq2
	M5JU3mGJJV5kC79EStHiBuuAy/PA/QY83NVP5m4ha6JTwVBqp15v0t/jGTrLc8w6Gg5JbvlJJbu
	wPFhKnWZaw9jRwVXbBtyOIjtqhkq8Z1P6a4B5Su+QuBetJkfGH1NCPB7L9TNMNucmYgKq1e5heJ
	rDFp+JDOv009TYpLwh0++bm05bORNxxbs7mQhQoulHVXbfQbhg+VgY9gpSrjYSTShbLaYd+B+Y2
	mLI14qlSvkd4rdF4WcXxwjxYBxpbNl8z/2+pOnhEo0NWX6U/Z9YSf6sufNnEqEMk8w2Njztk5Uh
	V6m5b4bmDbmrwk2lTR0XMXDgReOHa3A7vZpKLQvah9lAwzVDCLBzv3AYLK4EYIOLCmZ42ACl734
	b+t1jlaVGP2K/EB46ilDZEMiHkYKEqZWo037dwiqCSHzZdSFM37aBeHjJYob07JDoBwkM06eb2Y
	R9Lvy3GVZfsBxgC1lP2jkbqczBiQzKRIKfNYESYydJ2bjg4r46tcGuw==
X-Received: by 2002:a05:6000:490a:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-49c6dc01394mr2183917f8f.7.1794529976835;
        Thu, 12 Nov 2026 16:32:56 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:56 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 11/15] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Fri, 13 Nov 2026 01:32:01 +0100
Message-ID: <20261113003217.197757-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
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

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 893b0670a7b6..44c116f6cfd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10033,6 +10033,15 @@ F:	include/uapi/linux/if_bridge.h
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

