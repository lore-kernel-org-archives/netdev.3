Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C31CD2C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282442; cv=none; b=WOWGscG5OSADbrYDGoOWA0O9HfkzUybR32ToFmBCZB/eneaFXmBl93IUQGZIVEGxj/4YXXGMJHZNfUVmD+Q5IDsJEhBmEeHGVYwfKurYBfWRVV9ZfU/eFnB6HjzPBxe3P5yIJI9bLkB6FEWVUL/5D6EFN1S4lAfsA/4H91/YRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282442; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mB0LM+jCT0WOOm9YrTHXRbfO5QuVkb6vJKGE8QniQhyfmtxt+f1Shu8xTezWmHIHmGmL+rjnO6Rx5GwYZTuAWjucEB7GipCI5fRbtQnEwBIOc9uW46oLl/8plWtQv6yuNFJ2vnSQ8V+NPNb4tUlytshC8/LvGOQdBWekU1gOZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsg2lFWs; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsg2lFWs"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc67a5e102so35427737b3.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282440; x=1780887240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=bsg2lFWsAUz94DcYfQfEbFNkaH0FbwDi0SnwszAnBznhqGpu/ENx6Cg0YPL3gi9udH
         BRRxKG4mTPUeawIgP3q20gAeIMxGa/p/54coZ3G0kJrdu5zSJhwTXE7hMZWnqBEy4vFh
         4cNqEZFo8FLb2nLu2z1N5MN4ID5yRVIChOnvYjV3a+5LC/gfspqBFBq04F6RitNT2ykH
         R0uxbXlSm8ckyczhFqQksy2BnJocS88TF8nQHWNBF1qKICZPEhrrFLHTxZRLqy5GCoAG
         OrsCv3qbws9JbeWFFiwwZ0sKfVAcyZMP6YzVhivAiK6IqauwtO4tbmVfDoYx0JCOVJEY
         l7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282440; x=1780887240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=HbVDaKquShSUnjcH99I6Di3Oz7emUx4KcmrGBA038XHYJ3H9Cb7fm/h9OcifxCkuqY
         N6G65mJZOpuH577yMX+1JrBun50FZ6eFmNFl3VAugYl54S6/A2i+S6oLLJ/LjAoPfm4Y
         5LcgH3/FzrUX7AlpZI/pRcB8w9RFep37TYndGGuGNkOGThsOk/JGOeYKaUxMl1UAZNFM
         jLYriQE81kk9JKdG0DLkGVGvDAi5v1ly0Ox+KRw8UmpAQuHlqsMM8DfgtjVQtU5Z8kjn
         YvCP0i6w1dWLalhU37BtOrB5GONsUFmxFlfD+vXNDFq0haqKqcyD02F3bAuEDkgW6lzB
         /XJA==
X-Gm-Message-State: AOJu0Yxx51emhowH/C/6oKUIo1n6zixBTmqN22WQWFH3WcCVwKg6vVY6
	JEdbQmG8fX6oYwPQM+WR20AEakQFjzgczhFZ5K6AqBU8sRkMd8u1C0DK
X-Gm-Gg: Acq92OE6JY3LV+PxlBHU6agwjR0NZihn4Xpcyy4Moij13iKI1TKlnEV2jeBYItuX1JB
	98E13AfttEoHiMHN3SjmfXPkG+05VvookJiGb987G2ymtNwQMFFrF041WFQsuhJ73dyOuS0ywuV
	MJPXB4x+Y0dGJhnlv0bx8flerVn7lkyIADQpgEDnLzbN2wCM/0ybP+e0qJSRruUoRtV6VMHw1vA
	SQ1d1KcOFAN183eFDElfrXFUWUbHSFnC9sw6oVHSVRc0IaZNa0Vj0LdiQxAbdHM1ngAZViMyS4A
	ZCYmm0o3HAozxY6JoMSXjiD5cMJsMdg+Zg4iFGu/Pki8PpRpxZNzcO4OcA3+ZjOx/EB8h5NcgLB
	YGSNWE2vpjUAsBbW+5m4VnbAoeFNtFuOrSjfJEPoo4HbXOD74l5cN1qX4z65kfQ6JSmLrA36UVY
	BtK+bjvdgU1O4KoUzqQnU/j/SyTBSJ6wOUOyoe+PRwFimQQMDkRA==
X-Received: by 2002:a05:690e:4390:b0:660:321c:46af with SMTP id 956f58d0204a3-6605fc4821dmr5318061d50.59.1780282440360;
        Sun, 31 May 2026 19:54:00 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:53:58 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:19 -0300
Subject: [net-next PATCH v11 4/9] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260531-realtek_forward-v11-4-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile                          | 1 +
 drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} | 0
 2 files changed, 1 insertion(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 17367bcba496..3f986e04912f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -16,3 +16,4 @@ ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
 rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
+rtl8365mb-objs := rtl8365mb_main.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
similarity index 100%
rename from drivers/net/dsa/realtek/rtl8365mb.c
rename to drivers/net/dsa/realtek/rtl8365mb_main.c

-- 
2.54.0

