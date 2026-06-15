Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543D3ED135
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526658; cv=none; b=ml3cIubj5uJXgGv/Bhi/JON+lyz+PJsKxMAWPt2nvKra09wpWwToTnAJurOC6MwjU7utz/0Ak2lTrPpIUOlvX8Panj+ZvqTrUMbU12Jij7yXTYNQ9eYWxyw3G3fzR36Qch9wpZgK1FiccAdnNVuYE4CgWsHOfNIlRGOmS6044nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526658; c=relaxed/simple;
	bh=AtNohlQ0WYu7yAy0ZDcPtcuY1C2JeuynsMtDfbhK1Oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H970wDQy5jiPfDbz95lDwKhqPXVuh4us3WbNjv1ozgF/jKmCKVj68p3aAMH8FbiBscNCRG7k/OPr9VuGFnmm7c298NLOf7s8ZZH2QxVezpusMltNA0Ma/lX6xhL8ShPmhA43QXtVjAHd3psmpm0/rccAvs9e6j4m5Zb6ID3QW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1r6gmqr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1r6gmqr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so22469065e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526647; x=1782131447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7ibR1uk6j3yRvHUeSG7+Ts5vUBpNZwTn1NirzFE3FA=;
        b=b1r6gmqrfjrAl4VunJk5vfjQlwQzDRrQxiFD6ZjrtNXk9oQdXhYufu2nwL7S2hknPW
         zVqUs6Vp9xCUTd3wzRy4YGDWCh9R1+3pvdlqvZJC8QER9RqvNroGkkldP8sQSx8HuQ3x
         m4wE12LY9iGWK8BAaO3XVAiOsRt7OLrSQ1+L8NS7MNOcVrtCzI4Q7pO2WRsVFoog1Ygc
         NaMCc8eUEvzUkdR+kEgcwks/J+qp/xPEiDXyXfqRo8lkfQOnz87386+8Dt4Qh/DdZQ0v
         B8xpp7cJYaXeVV9YjBfUvGqnsBh/v8370D8rgCFz1fa9PF3KLJFg4cvPxj3gBOLof2wO
         SqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526647; x=1782131447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7ibR1uk6j3yRvHUeSG7+Ts5vUBpNZwTn1NirzFE3FA=;
        b=DIGqNvIsovc1mAcf75omPGFKLHe2BBY1zKDjGniK4QWNMmIpreS8cf5zGJlJBwxdDu
         DOgNbE7JUcFC3mywLnfYCVWYk5FgcjxQoZkzvczDkzgtWFjkUBGpJcxTC9dL/2qP26UQ
         D2WDINRmFDUG8eou2YAsqYg0YPMEa5/B3mgGFJT9q5VxXi4ocAbMvs0H9ZTeH1+MImv6
         M5WMnGkKyfl/R3CZizGOriFE4PIw4Mkt5aZCktgFx7P/jn5kKkzkAijjuZUVVICBz4pv
         ij6BPSWagfxi1cmjfcLgOVSb5udzwNcmr3zys6NrXn8rdF+6BUjMSbe2+bJAgRtGAmEI
         3VMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+thaP8ZXNw4ayMl9AvRxJZX30/THIOxzBGbDqh4cepR3dAn4X9/Gtwh3Vtt7x6EQFJvyPA4Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGKCbir6y+x1sgkpITC26LBAQHLtq113JAUMNOwOcuuHeKNjd
	vhVmplus5kMrEjHhBJ3aGtZk2F8RyoWMDnes8LnK6NF4iTj8SLIwzulp
X-Gm-Gg: Acq92OEMUazr27Xwuk3tJpTCfoanHHePY0zks57IWxaPBC2HKw0h0XOQQI0BHuox/to
	UKqVJSBANGY7cEfJGtOAkGpUoIl7YxVPvdxLQv3tUt+S3jYHwn8C2NlvDaJQSqKN3dZbibWTSCs
	bb5e3+Pr7U2UCXkJRa4XNOzo9tWRP21eW+srhg6+lCUhsBmzb0eiANL1ZScHRbhy6XNffzV/jpj
	LozO0fG+de6vWC+XgCAfO9qk2H9FXUgNArPnKzQQJuiXLAW3DDqeul216IFLxcR4ZTWNOjekXx6
	A9DKZwOazAohwXmH4ag5wcrYRg9TuANCFdlsZldKHVKTRn1khA01EHgW2QCj2J5H6HRRbdAnxmV
	94oBIMjxeMO1clp/T18SNx6Sx4RE3H+/gtDBwnlDz3D8qxzr+oxu97xH+XMGod4f5i9AFJ5JE2q
	yx1MWSpYHHo3+MSxzr4s1G/ylcoxbwlb4NuseKKVkIEwwjYukRpUeqyoo=
X-Received: by 2002:a05:600c:800f:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-492201436f9mr121572525e9.25.1781526646890;
        Mon, 15 Jun 2026 05:30:46 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm191426435e9.2.2026.06.15.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:30:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v7 07/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Mon, 15 Jun 2026 14:29:43 +0200
Message-ID: <20260615122950.22281-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615122950.22281-1-ansuelsmth@gmail.com>
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
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
index cc1dde0c9067..ef3ef5096d08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9593,6 +9593,15 @@ F:	include/uapi/linux/if_bridge.h
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

