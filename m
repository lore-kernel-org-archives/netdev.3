Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896090;
	b=fpyudh+wTtyyucfG39biD3QPH38Gt481ODPRsrcSmfl9Oq229nqcev6SsBy51RnCfYlZ
	 puYB+PvmCmMLjnkX23ccY9rMftavPZnyRFQulSnHjhQ6e+zHqVC8amVKkH8H6bM2k1UUB
	 l3KNPoXIMhKoJ4W0u5DPXXcaxUA49VjXJwMS4b4XJr3VsGA2iIwPP1AvTr+Xxgiwv/yy8
	 TVJVU1UxQqdQtjyDDPuWJA7p0EweTEPYqkQN2TjIfeJ59Svbrxx7PeEgKlQyxOzZCjH6Z
	 QX2gknBkgKceN1O5S9SLFhaq7g0iTr0esv3GZ2NZ9BNUlUepX/RNrqATcyWxWkvo8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Wtl6lbTH0Q+TZCmlk3+PvHR0Fpha4owEPE/GZNCfL4Q=;
	b=eUrYbW85L6qT26qiwFG2+92O0R/p6e3GGOTKzuUqkEJREVXbmhFBmMucD1D/lthZYOoe
	 yB+yY8lqUS01ghcSQS//tgo8pR9QVV0AsEprl0ZrsBQz47iLopZe9nABpZlJXqVSDeDi/
	 wwu35ZHozYoLoTiEUOXV3WxZ5XM2fXvVxkY0dVVV3S6xeWirDjY2aec/9aKJCYZCsqluF
	 e+WUFegJaIQJt8XgS36PeU0LhdZevarUBxoAo3Xoh5bw0PRwZc/NVVW1osWZWNdRcfg84
	 9f2WLQu/BhDu/T/GPKZBq2KrhFvFFMQ0cQ8zc5Tvbh/DJigPPzseuieD/jpzvf/1UyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gktkBJJw;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F43F606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F43F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gktkBJJw
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e60f9af6e6so17436355ad.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896089; x=1793500889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wtl6lbTH0Q+TZCmlk3+PvHR0Fpha4owEPE/GZNCfL4Q=;
        b=gktkBJJwrpqITZajFEOqQv9b9gNtarwyG5rFvBTBypZ2QT89cNLlqtejdGSrEv7nVw
         RE74hcBozgIC3ctrvR40LOlz7Z4T6QqdgU6d6ENXBF7KOaIkA3dfcWxar4AuxUsWsXQm
         4vwY3eFbc0q8iocoK7IAzQpWmV2qBqW2iHy4KHNaHqQl8oZdQpvFqSUQ4a2zV84SU0V4
         +RTMlZo9sFFwfyhPoGMkwNsNC6Fn+1gM4BeaQ0RPO5GCGDbeQOLP1z9pHGAeBYlVmmsQ
         cN6kKjnGbPIhTVTtLAU3LHy3YxnBuAFA8In4rOstQNQvp9x7n3uR5ab+G4ieo9O1fGHa
         yjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896089; x=1793500889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wtl6lbTH0Q+TZCmlk3+PvHR0Fpha4owEPE/GZNCfL4Q=;
        b=znlQHa/i0kBZyHGqHSKPC7EycQT16rMMOAIlsIHk1a0HzVgyFeQde2uJodlzbCPSlq
         P3TQ0gPy2EhKkbmw+wC/545Z5VuArTc/w7/i//Jlflb1r7pnLI0z06zLRm2Ccut04zJA
         l8IyTZJPQ72GkRfBfYao95svu1lSu3Ni8ZEetEDcHhpQLi1nApCjzR48nMvp8pdfuwiC
         V+Ns9kjAiik8brgov3c2EeUCohIxfvkxSSi9zx/GdlHaa4ar3qjszwaGAhmw2xVu4mOY
         0YiLJKbuWckoLuWXSVP2BhRipf5d2Xq4rBON+IzhEmDk/rY4BhM3IQ6l6zs6IUm4YkFi
         x6Bg==
X-Gm-Message-State: AFq9FYIEIrALeUSq0EyiIncU1MbNPJGL7Sy+9A+6A06o9CqDtLRGYBR1
	jeS8tSBYCQhjP5YO+WBzUXggHE/TlaPDkwbffF+2bfMtwhKgO4XjCjK4wHNSiiFoJUo=
X-Gm-Gg: AYBFou1CMm6S7+ENHiYFtbnVQdhYwY0F803gqoR0E7b0b7vvDRMDoWeFb0VuMv2wHMO
	CduS1kv3me9GgiFfoGgCWpTBbVZN/GSEBbus7Hcz6omLHGjx3JjQHvViDOzPjiIa+NhqQIQAU1f
	kX9zx2AoRXRJl69lrogJCXkWKezzspLFU8fgAR8fmnbpBQDXZ0JjeLytvq97TsPndLmIkJI3vI4
	dkaOuORkhP3zCYZswkmkj3q3LnXHL6LYfUcqMU1HZzmhMYOVMZkbXnHV7Xvvu4yxZ8lR4AhZM2P
	tj+Yyq/dOKqvMX4aAhiT1/vOPhrX+OWnmYM1xVKq9kFKq0//BOAS+XqFG/XVAKcqUa0iWx7GbrQ
	EbZAS+9STqu07AT/pNyCjr2c+hRoV7Zispv4aVcfND8xF3/8181fI3vuCRacEQAHI0fkzOPv+LI
	d5vQWsZ+DIriGdZkoPGlvb89VdcuK41eaeeWAFY35o7whIkzfFytMtaMUG5vHGT3msjM7ARfr7j
	Qe6Rt/QyjDAGyHFmpRZXKVHPNfyyvnfhwTD0mlVvZqdwVys8/R8Ifir97XGuZHZh5NAAauub51/
	7ho9f6cjGLzbXSM7XrPrMgHAxwn7
X-Received: by 2002:a17:902:ecc2:b0:2e9:9f14:c40 with SMTP id d9443c01a7336-2ea9c130a8emr28640505ad.6.1792896089289;
        Sat, 24 Oct 2026 19:41:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6216:1250::1d3:c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a35c4sm7653995ad.49.2026.10.24.19.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:41:28 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Report error when FDB fails to add
Date: Sun, 25 Oct 2026 10:41:11 +0800
Message-ID: <20261025024114.1955782-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

fdb_add() ignored any errors returned by the hardware (for example,
table is full). Return error for that case.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d4fc20c52a58..422b45085e7b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (res)
 		return res;
 
-	return yt921x_fdb_wait(priv, &val);
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if (val & YT921X_FDB_RESULT_NOTFOUND)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static int
-- 
2.53.0

