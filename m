Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FED3D952F
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307511; cv=none; b=hxtUok+NSmr6YqmHls0uyvNDALtatb2Uuyi2pb+hBgOgLqa/0ZJBsCnnpmLYGZWXm+YfGzqpTgXlpirF/ABXliRnD3QkKQ/tSrcdqcFwx94LEhxJe+z+b5ptz6XG4nCVRIu7YKgYoNVuYb+vSdy/naFZrAdzNR9iKpn3h40UpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307511; c=relaxed/simple;
	bh=qr1ayfYw/TaUJNlhsz7JazjlE9h+RLODo9YzpXaYNW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2wyhJH+m2wJZuEU/aemU5P1xFFT5uPFtRZ4rqNYPLPdzAvga+bpKmoKA8lJIZ3wvwUwaWInX7UBR7MOgw1shGhJPpvxeTs50Mzc2vBdBPrsq4IlROWM0Wsea/CuTHOhcn0JO6iBiwI8folkLOnlmIddOacg7bkFRMhWyB6u0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8Ll39+a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Ll39+a"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso7453945e9.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307506; x=1786912306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=G8Ll39+aT2kywXwAiaY82Zrn+31nvCdldV+FZdDRSxTRHDtBixqDNMDWJNpK3FyVyq
         HzKom7uScZBLR8HjXdBvjAdl3GptMlwAcaytEZ1lH1TGj9bZT09HH1GN8FzHaDt+Q9ip
         /wz5Hx3MrmFJMQyeT8mUskSy+7IMsoqjrFQQs1wEOVbj8t7T+wvGgTw1dR1BDgq69req
         howDy2nCl+VD9/ZJF/0nuZNTvtimkSxVC9GsL7AlOX1QrO7PDdn0GMBMC1oQzTr3KcFW
         noMh8kOrccXihCHwEP6TEdwUw+489t9CUmiB8LjnG9uiGfEL2L8Q7HwOeQgYKzCCMNAX
         opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307506; x=1786912306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=PSzh4B1yDa9qnaUhlMwJBOL8Vv3L7s8RkDWVuiDCXNdmisekTxxxUkFuwc7nhgexAP
         togvQXZMhlxPn9usrKmENd1YzWgi+MTMczoqStq5ni11q9bqzFPnSimb+R+3ITIZI+I8
         7thFk+MgVl93GHWk9RrLD9231jdiiasT2WC+JSKqCwNUMdwxT2KRgTotR+qMO1KLF4NM
         o891ZNnOMkPYxVW9KbmF5dAGPqbvMhe7BgfHjMr0lZQtk6qLaAZorUMM0RDOjlE2dgnW
         MYXm8/nrBseuXaKad3onJv3YmKu8wcoD5Ipg6bCvrmhc1gBuj1f4fGi0P5QtSSEl/LVW
         nRKw==
X-Forwarded-Encrypted: i=1; AHgh+RoSuD0+i3MheAl7iqRPxcESH7aBb9afu6X/bgewEBxENsal8Zosp3dojx3VFA95uc+S/6/IT/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxePB72c8M+zFpkQsj2hw3HjouVoiybDg2WMfI7YwtsPFeyyxI
	1D81lZKL9roclIHhoqHVEa3HUO21tEgOsLtq6WFssnd6MFqn4Lky71x4
X-Gm-Gg: AR+sD12CR2Dt3I40VfLy/lS86gsqvz1rc74iKjJPx+glfQe1Isfex+BaJ5GN+vkxLVv
	ufnAwFX0iSwLkSXEABtuBKtVuUlTOsJaNRO+0i3ax4EkwkktsU4FAX77N+GUpwzIr1GqVsRKoOz
	lUqje0LZK/tn3gBC523A99QVyVU2dlovQR3tmc55V6CfqeDOVMB4ruKSPbulEfHr2a/CwNe8ki8
	Fk6k28BlepfYnn+Q76ZAt97/PihUm1KrHlpvnzKk4QG/LOuBqd0wpHxj750A+9ekbpxZtu1NioM
	HutVBQLhL+SK2CK31FCFDyQZEkzK3RVKbm3xLUTO8vKCUl9V0QVJuqXzqQKBwNSLwAS15jmIs8O
	ULDlNdbqd1jAbElrEkKF3PIvc9boSw+qtRUIyEr4Jrwr++faVhmxWCGfBX/SPuUl50ln0QZUp8b
	aogR+b0mzj8DXSsvZNNsgO/MzbkNExWeW5gmzQ6EdDi8TT12TexKlNVHr3D6GxQzcWaw8irJqMo
	B5zIoLuhmhuvLCDR4u8gYwikAYwzPmUNAIkm9PllOfyaFdT+IpNY8h83P0V
X-Received: by 2002:a05:600c:5251:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-4995b04695bmr259698705e9.16.1786307506550;
        Sun, 09 Aug 2026 13:31:46 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995e9ea92csm229357065e9.4.2026.08.09.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:31:46 -0700 (PDT)
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
Subject: [PATCH net-next v12 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Sun,  9 Aug 2026 22:31:05 +0200
Message-ID: <20260809203116.640271-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809203116.640271-1-ansuelsmth@gmail.com>
References: <20260809203116.640271-1-ansuelsmth@gmail.com>
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

