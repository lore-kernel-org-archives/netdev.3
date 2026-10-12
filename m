Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CD4C4F48
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827233; cv=none; b=SZQ2mKsZc0Bd6hWloQZQloPSr7ED+rikKm7EdLKC31K4TDKpqUurp44/7aGBxbWQZLoqmdpbSIppgG5wEzwobuh/R5MiPgWoftyyZSq7XPrqn7ItwqIOpHvw57yrENNWTDUiBL3l/B8pvl6mJ2eFFq76a0f2M1QaL8qK9DSt3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827233; c=relaxed/simple;
	bh=6SnTWiDOhKBn1/SfUIOXViz4y86VbHYFc8GbTKs6J4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhsirNqoMruh/2Dx7vZE0b1z0Nfsh/OUwT91GJZSbPMEexsWhCJ6avIswh7UW1vSQfBECMXXD+hngVD1iL+DxvR9A9Lj/KBNJRDdg2VgHtzsHb3mTLIBSvtDvr2kBiqFuWX9akoO0jpsM4hueuGqQWLsbgpEWtYdeq+sk+LhE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=q7HfDMMx; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="q7HfDMMx"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-154e9d2d979so1392425c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791827231; x=1792432031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6SnTWiDOhKBn1/SfUIOXViz4y86VbHYFc8GbTKs6J4A=;
        b=q7HfDMMxE7OlMIzx7f+RByMarTew4ipxdkz10+3nAM8LHBFMO1V+IYtjUJ+/bOsv83
         IJ43MJbvK5wKmiOkU7IkJgec5bGc9hktVsqQ2Ju4TfH9moFnHlglBp85NnqnGgYxroWJ
         SujSIbAxQljmmTqJGfu9z8xbGGXvDrXVDuyiefu0wRZAiFhO/NH4LUr1esgPfPVQDr8D
         hukKsTeSVrChPFTchr5ocvnxjeqpL7RA2l+Zjv2UJy2SuN8A0KQYoSj5vVKXCJS47qVN
         nsjzF3cw6pxE8/JMi4B82BIglnUwLgNlceQyUNgSUmc6nvp+wRdzd5G1qZpSXe6cjqe/
         D4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827231; x=1792432031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6SnTWiDOhKBn1/SfUIOXViz4y86VbHYFc8GbTKs6J4A=;
        b=rGD9svegtH//caenceoXJty4E06h0S4VSXL1kM9X1sC0Nx2vcaU1R9nUDz5It595UX
         bXbu4W+A5bgniAiSLHxuGOyDMo/+kjsW5wDk1pv/SWxWHRMIhKF5SjiI3II2XeqpFRhc
         9lJbPuSAP6XCh55pRzlsyEPtkhYwHr5kHsv8DVzQBBJaAz/mrgilWXDebCJKV8RoRqrb
         T1j3sD94bmItSv674TSIiREeqqek5VfIcz9J8kRnY4gULG/fBMuf+3BWp4o6eq/jk4nB
         7G6QZQPRfKPPSDHaEnKSfJn06Wzra8GSL+07wqvt8g9Scd+nBi0yUNQX8/cUM69GVNja
         Pvag==
X-Gm-Message-State: AFq9FYI/nI2rTDstU70gza+/fyDPpb4rqUpKKv0XXK9ShZtlISKOGT/m
	FYPDxhx72X25wiLdnpEd38wllsIS+dCReryH1YCrbjX33oU5orKLLxiL8XK8e+7No1qkudzWpyg
	78CmDICERoRYatk4=
X-Gm-Gg: AYBFou1pdyns4ocLdYRtm4EUH6iWRzEoJbNizkjwf6/uwDxDiruwIC4a8DWHCUB5S7j
	fSikD+zf2mlHnDYN/UcfrHkKCwPtHR9yKaHq7GjfXgUbxSTq8DJmQCMHwT+evk8DQecrAYL3OC0
	MK6nny2dInuMYwyC/7ShWqPLJfhjruVyWFP2Vbc5NcCy2lZz01AceL28Sbkv1FuVZw69b4ob5h2
	zHH3GJqu7XgId5mcEFj9/50QkxVuAzd5mq5fGReLIRU0lLarF1wJBOIPDFNRgM29KYO6IWwJTWP
	UNaVx8t7x30ef2nGB2FbjVPDJChCoX8w7SF2GV9qLQLLmoaAg62meBJZndapipJQ9xVyXQ7ggbw
	4Os8ON7LA+4K2dz6XM8E1JwLupcP94GX8pKd+29diUEuXhfg2gFE6KlMRYEKHxNpl4cxmK3iPlI
	C2NAbNnOWIcA2VRzavz7oDL61g2CDeCyllBJVFwwHOkFvEjmFqJb3uLlk91OHmhT/gLqde0N9m4
	DlkXzk9koWu+w0GGvyAtvNFs0DSAiuHlxCDmVZX6VU2xU4RdNbbtIlxL7WWzI9F151/qcbXqWc=
X-Received: by 2002:a05:701b:4585:10b0:14f:5870:2e9c with SMTP id a92af1059eb24-16a15460f46mr12616380c88.23.1791827231478;
        Mon, 12 Oct 2026 10:47:11 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1698de65af7sm34305162c88.0.2026.10.12.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:47:10 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 0/3] amt: fix relay tunnel keying and unauthenticated-Request DoS
Date: Mon, 12 Oct 2026 17:47:08 +0000
Message-ID: <20261012174708.3623512-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009201455.1904698-1-omar@blockcast.net>
References: <20261009201455.1904698-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is superseded by v3, which grew to six patches and was
renamed, so patchwork did not link the two:

https://lore.kernel.org/netdev/20261012125943.558629-1-omar@blockcast.net/

pw-bot: cr
