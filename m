Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E045D90F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792384010; cv=none; b=CXqxLfZzCHXPCg5NY0UuUHfKjbyVA8SP+mdBhJWRqBO7k9o+u0zZ0KS1LmgJRybBVVAtqGemsPqDxcSRRKyRbHgkpFZ37bJhdR8C4mXZ3V6aiRtKpiI2qMOH/I0zmFHT4DfhsuJBNXFu/pqEpXheCQK+ui5oF6iGubx7lYWWoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792384010; c=relaxed/simple;
	bh=wWxNX5aBIk1DzM7QX6OS0Fz4jWbzbM41ORw6D9EFpUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUEUPcDxN+zdPzug8RJzgqEbqsjAi9GTqIthhzJAlrc8MLHd8LG7gZ8rsEsHK9FCAJpCaCQudUJ397i6s91l1JKlrqDjKQ8PhJ59fd+Vbe2rx3ik9odGAYT62kNeDzhCiFWliJw260LyTL09FAkmt3x3CsjunONlmPPniYa7Pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpKxxBes; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpKxxBes"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so2251159eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792383999; x=1792988799; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=roSFG50KdVzZVyQ42TsjlKxifeyCNK7WeP72SJwZy4w=;
        b=EpKxxBes1/VF3EyutQem9bfFzyNmQXljxAr0f5BJ41nbN/IDkAw9UZDoRdjgSgk++E
         a4KGGf0ikTPJS5AkMH3TrgW6hnkr1sFbLGv0ym3YKUM1HXVVoRFPwl7OWuLgqBPRpZGG
         9y0tAHtljaugeVmHL/kdv5JDeCP/rP0OZ4/oPVozr86zub4c1Yuwf3xno9SMGCY28BSi
         6cSDhvxlFI0LHH9uQQVl8Pzl4RbpjJSJzF2Q1aqCinwtra0EgFWWzSEK8yGYHsW7jneZ
         5diYYQ/PjD1WAZuz4HmxV/153EgMZGvAGnxCnJp3k1+LfL84EBu7+1x3rUaMM9qSLB6c
         5Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383999; x=1792988799;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=roSFG50KdVzZVyQ42TsjlKxifeyCNK7WeP72SJwZy4w=;
        b=naqVyzxf+LbFQAv9+PTv8I5WEw+GPE1vAwzefzMvhIqwRXNaegQo868RHgefymaW/e
         GJfFk+kBoWLjoUKsuneCuDrLHneRFX55/OVVgdiYowAXUZAZltTfe6xBLzkL7gfjnSmR
         N0AoCZxnKWwwYDjKTlNFHNeug/fTqm/rCKXzUkoD0ivTarKmXDA+v77V+DWoMFXsJ3MH
         UJc1S0j4RMcX7NdR9ihwQsMNHfHpCFXtGbpiwtYQFDoCu7mflsEy8gIwdjMIUVY3LT3w
         hqN3mU/y4gcydOQ+DOmldTltP3eVjxy+gDqEuvoooFJNR2Lpgl0GgqWN2/vbEFyIeUdq
         hfNQ==
X-Gm-Message-State: AFq9FYJ3MM+aDpUxBu3Sl2ZOL6HRA6HzFO9Kh94hh6yaaaJ2lPLrr0Eb
	GHHlCYyCxVEZfutxHa4FzyrSJsFo8WIY6RE9lfl0L/fm+EmL2LzIFXxZ
X-Gm-Gg: AYBFou2YQYpASmZTuYynZJt3WNHC5X9NMlWqGXoSntOwvNI66pSIKihdoEyrBIeEPoR
	NkCnuxXgIIUxxrVnPPztK+sMYemGYvH6KoELCrxnIqqifwpJKM33+e7WC3FlJdhXdoLR2mXYrjQ
	AOHdud5MZRmbJeyGHzcGqmkHBLAujjaq1tHK4dKfmgjj2qk7cBeXXDNxi4P3QTHYreJ8TPD45dQ
	lI1vWMOAZ3ToI6Df6PpQgoQsZYsiJkruCvKTUO/WD913XMKkBDM5rtKovt1kyDN3JPXvdz69yzJ
	FjresqrdYH1Ipplw6X1t5TYVqvV8jkKrnZwvgJT3Kddz8UpydWQwDgeGU3mF4XB2akuwKN+eS/d
	VZU+Rlqv30RvZJ7URyQiyf7bcrJRBP3gLXQTjRAsi91AJMbsMFKmmUg9Yw51QbzpdNe5k3ywib4
	9AJGju4IA+adwTt4jqzIap3cNubf8oCxdfU8kirkFgB+8PUWlGhkWhP+MkefOHe1yf0+pJYqo6s
	L7AH1rCXa6C3tM=
X-Received: by 2002:a05:7300:7a9e:b0:361:1dd6:531b with SMTP id 5a478bee46e88-361a2052bebmr8842130eec.26.1792383999414;
        Sun, 18 Oct 2026 21:26:39 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36083283478sm27203851eec.29.2026.10.18.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:26:38 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 01:26:27 -0300
Subject: [PATCH net-next] net: dsa: realtek: use <module>-y in Makefile
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-realtek_mkf-v1-1-3246a77d5782@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPKb1WoC/yWM0QqCMBhGX0W+6wabglqvEiHqPu3PWrLNEMR3b
 +Xl4XDOhkAvDLhkGzw/EuTtEphThv7eupFKbGLkOi+NNmfl2T4jp+Y1DaqotS2rqqg7Y5GK2XO
 Q9X+7wjEqxzXidpiwdA/28TfDvn8BXZ3PrHkAAAA=
X-Change-ID: 20261019-realtek_mkf-380d67738b1d
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.16.0

Switch from <module>-objs to <module>-y to eliminate ifdefs and simplify
conditional object list construction. Drop the obsolete trailing
comment.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 72bb42e80c95..0a94a619b2c1 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,23 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek_dsa.o
-realtek_dsa-objs			:= rtl83xx.o
-
-ifdef CONFIG_NET_DSA_REALTEK_MDIO
-realtek_dsa-objs += realtek-mdio.o
-endif
-
-ifdef CONFIG_NET_DSA_REALTEK_SMI
-realtek_dsa-objs += realtek-smi.o
-endif
+realtek_dsa-y				:= rtl83xx.o
+realtek_dsa-$(CONFIG_NET_DSA_REALTEK_MDIO)	+= realtek-mdio.o
+realtek_dsa-$(CONFIG_NET_DSA_REALTEK_SMI)	+= realtek-smi.o
 
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
-rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
-ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
-rtl8366-objs 				+= rtl8366rb-leds.o
-endif
+rtl8366-y				:= rtl8366-core.o rtl8366rb.o
+rtl8366-$(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS) += rtl8366rb-leds.o
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
-rtl8365mb-objs := rtl8365mb_main.o \
-		  rtl8365mb_table.o \
-		  rtl8365mb_vlan.o \
-		  rtl8365mb_l2.o \
-# end of rtl8365mb-objs
+rtl8365mb-y				:= rtl8365mb_main.o \
+					   rtl8365mb_table.o \
+					   rtl8365mb_vlan.o \
+					   rtl8365mb_l2.o

---
base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
change-id: 20261019-realtek_mkf-380d67738b1d

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

