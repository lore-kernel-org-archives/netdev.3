Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73B4CEE78
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350144; cv=none; b=ThTgDGdk3Z/gnMw4sJcbbIfuFYP1UiQahVxfHv1cUfIpUu2TrSdR/rci+u3K5Eyp7K0Habxm3ai3bNV16PXuNFjTUiaORbOLyNL6F1OJKxbZfh0R6JPadzCYVz2isCZmY4S4lGXLJC+isdNkRSb6/Tkwn6vpdb0OibFD4jV9Z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350144; c=relaxed/simple;
	bh=gvJtq8ZUiquv8Ua4fzzgdoLFYRoUa6vOwmahIJ1yUp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4g5eRcwbq1fUI+uRbwobpY+cxlGKeoEb/FusIDGOlY3a+S0BVK23tTI97md9ZApTORzPIVSsZqw/nXFnqYEpiMquTmqfFFNgjPI2emW4q2lBXbGIWup0DRFX4RrsKdrGgFF8/tDmfRuE/BAj8UM56UGiyAWp93MwOjzL7dcLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=EV4BX1i3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="EV4BX1i3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso5084785e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790350141; x=1790954941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvJtq8ZUiquv8Ua4fzzgdoLFYRoUa6vOwmahIJ1yUp4=;
        b=EV4BX1i3DeMd+uSb1Qk19FiI1Es1HcyNTLITcuPhCoyJLzMMOlFyEejI8LHcxn8tQd
         OzYBueatsE6I3kc9jUvkgKGy1s9pX1DOqO62dLpz3cXL1840g3g4CsVEPhtftLB6Xo3C
         533FE+mf3KS7l1T7QgmWYGl5e51qPwG4BXCmTfVmi6CYPl23VuI/1qlvUboMiiAfd+Os
         ATwqO7mgN/7vCX3O41gEeiK9OB2drTrwlpps4gKDwxp/GRxin+WVw1euRgYljmi1/pJo
         7LQfY4Ffm6GAJQKAE1VaPd75eVqqOEWEa/G3h82pPtVZbNdsfs7u+69oZLdViEb1QAMJ
         clVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350141; x=1790954941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvJtq8ZUiquv8Ua4fzzgdoLFYRoUa6vOwmahIJ1yUp4=;
        b=ndz5bZGEkDVFixSvhi0KLlE/1vJluGBVLq23uA7veHYy8YczaBu0NDifb6eU7otj4w
         aN8SFTqQoZvxKuDCwOCn0/v3sRLzBW0SQ2UVo8uBX0wnt8qmvBxlzyjVXRiuvgdIgcBQ
         eYLzS4blgrRZS5JDIaCSOJP/0+uzG0GctzYtpqNSutz8Rzz/JsExNPhurKCWp21ZSdK+
         o5oBqhDQZicHZQN/lfBjXGBahZObKNwdtYxPY5KpH5k/GdflZE+NOjUwZJIJTZSALmvt
         EZPK0R+SjfprckWPPgw0bk6LOfJI6nkOVjGVwHwAsCjxCNth0/JRDbq4gY+GeIAstFeR
         vo6g==
X-Forwarded-Encrypted: i=1; AKwUvBxWLcy5gJVoc0bgtCj7BgR+Y3UXcgE3WG03qYorDFYv7tXdg9BT8VcMzeQ7REjGsBolr4dt9l0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjcZ6xHR9/BAityjXkYtdeW6k9v5qG06cH3bZ2XzvZffqOmswr
	/aGwPnWzB/W3QCG/lnxaVQZDPOCW/7QptXarbADpMNzkVoPQiXF9Am2wVBNgKTxjCyc=
X-Gm-Gg: AYBFou0zwmXzhm1mQGPNJ0OU+daXHRDesHJgB0gddohpH4fy/u6CuAefOleUdc1aiG+
	Z++iZ+q2pj4euZsUwBr+eUprF0hAVB13SHcLWtA3BjDGBH6M2pSQHEs1zRUOoRQbYYtfEwwLR2v
	bzkdl3Pn3DywS6RY2BmBXsV5p3lM5x+MimZcWraPS3+UI6xH2DClqAv4xhEWqFqVUkt1RMsew0s
	0Kwo4eD0r1HWT1uQLJOdUACbaH5qYnBDcaL+uL4gypwUuPZBzbK3AIgvHm3Zou7wZGX22Fl+h4L
	meWFhVBfJXxMt7k1MntyEuRB0Mnd4TD/2x+7VXVnn1GE/vE9vipPVkGAaKnNSj7LEFQ4dfaclki
	hlKjNNvow/li+mObELXTkixLo2zoDHMZYMYDqZDH/ACeaWvwUCDvs/8EqeSltq4TsCot5K7FOv1
	cRwj2sHc2AYFAm56d/rm52CvlshoSOLg4c1cm5xMD5xnJQVZBVA+AJOAwr+6xxXw==
X-Received: by 2002:a05:600c:a15:b0:49f:e444:cc4c with SMTP id 5b1f17b1804b1-49ff06bdb00mr44911765e9.12.1790350140709;
        Fri, 25 Sep 2026 08:29:00 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm67540955e9.1.2026.09.25.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:29:00 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH RESEND net-next v17 09/10] net: ethtool: Introduce ethtool command to list ports
Date: Fri, 25 Sep 2026 18:28:54 +0300
Message-ID: <20260925152854.1559947-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e95bb870-11fe-4402-ade2-994b54fbf404@bootlin.com>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com> <20260910170103.1029108-10-maxime.chevallier@bootlin.com> <20260924220124.2129700-1-f@lex.la> <e95bb870-11fe-4402-ade2-994b54fbf404@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My mistake, that mode only exists in an NXP vendor patch OpenWrt carries for layerscape. Thanks for pointing it out. With the patch author's agreement it is going away there:
https://github.com/openwrt/openwrt/pull/25399

Aleksei
