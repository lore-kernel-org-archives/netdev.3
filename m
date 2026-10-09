Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1124D4876
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548701; cv=none; b=JBWMieaYwxG0iwUzE6LchOwHwd4vd29ic4AB/MmxPvAlfa6fTGPJTFx23sQALyigYlo07veZg7UwPS4U2sM/4pcK5d2U3W3uKFYQ3XVtk2JAi+DDikXCPuunQXeX/27iLyakGxbhCIu+xwAs4T0SzYLxMebQop4n1NEOhjB30CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548701; c=relaxed/simple;
	bh=8RWnBIY88AM13j6DvqP1Xg+77UY/JVZIRlFkQYtyW5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4poDSSkRtNtbjwP+mTI0+JkfZklJtoqbQGj1U5Px9luzctinq9627e+jA+jx/lBHmX+5W6S9hNYwcJuOdaIYZJWRf0wnYFsOYRw1QA+7OR/ssRMUHxcMrBVnaZbWdnJmNRljfSuEKz7D4w0PO5BBtNK2kXDhIUxLgrvTeGsfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=oBzBwAai; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="oBzBwAai"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab33730821so412760a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548692; x=1792153492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjXf3zywhfYnG5TRw5ezXLQRr19gQLXq9BEDfkjxJeY=;
        b=oBzBwAaiMSdwpE29e9S84nELrAAWn1z4l6GooekDtuQX3y1Uu6La1fzvYwqvZ5HY2O
         DTbCLbqg2nZuKb50vwaOXAUlkqTdvITK61yd1eUEtcYc2VuGLjRnqG1ocObE+U1gXNCT
         OpN4AfCf+B3mkegCgunA0ZTrI3CXR9GcL2w3ESxWvnr7iR6P6LbSjncuwwrELWt8zb83
         fm/ZafD77x5SP931vPvGZXRV0wb3q+7cW679/3AWIIp+otbARYEIjlrGnXJeUYHLxTk5
         H00nkel/ufRN/8do9KVjYOAsDJJZj+1tqlBIPdP8gnhdfGq7QZVq2+41xrzfq7QdAjfr
         7yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548692; x=1792153492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjXf3zywhfYnG5TRw5ezXLQRr19gQLXq9BEDfkjxJeY=;
        b=mWcFl6+cwWHIVvoDn2FjauSf8xg1I+W53qtBbUycbuJHLAsZubpBOovQ6SCdkH3FTS
         D1Fwr7Dv/nhhNt9JgPVrzIWa0fTlG1cYAcrLoW4iDlIpDjUjSlbkMpURF8RB87tesd2W
         lMpWjfvOFPtXGDRPWpNmFeeEYbg1aEHDVd6XCvxbNOwahxrwb9I2cSoMuNghzZrtEpqN
         rI9N+Qv2gY2pVBTK++ECCaM1Oi/91eUfxr8hZtNSNh+LTGNtLQQS2qfwtsCHARaV5xCs
         eY+qQlv+aOePHXlJcPQW1xKxN/ai8pyrf1jyvaqqrrs0PEhxfkzUFJ4ntQNpeMDxeq3p
         KpAg==
X-Forwarded-Encrypted: i=1; AKwUvBxxLGEnrsCRqWSSR86Q8FkmHYUgrg1nysRRCi5WuuApQd2iPjMGwSDSGFzbGqj7ze8el+8zDkU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzxwBir+EGqzdhY0JJbiOunoF6SciFANhZPsde+Kh9UXNyPVLs
	Ggs07a2/ITGmX0FICFa10g45WYlJC5XXGOFhDMDdTQVvKtCNstzhBMiYi7lXe6BFDbQ0ByqOVm8
	OUVr0bOs=
X-Gm-Gg: AYBFou0dAGE63OTGVtEJPTR1ntJBlclYwrqMeseJHgiIZEwgLWrDoUM1/11jhPBi3Ys
	QF9Aym1FYLU1ipQKOAzyWBkjyGEvcainparWAV0Pl+y7sytGDcTjrc9CxFElw9jjaauYmVGjg/X
	aSRQmXvouVVe+Lt4xJi2OIfXNQ/u69xRIDc3Pvn0OEl2mQSvN6hGWfHyNmYox5PjMnL6b8yKOl9
	ZoHrbqLAUKX+cLrSooXbZAoMWpi8AzJRP0kpm4dDI9OwyC3ltZ/4JnhICz8EJbNlBSDP0IsD0Yn
	CUbrzdDS64HaehGkNZn5TjBjkmNhjsPvL2+8EquHiJnaYAyC9AJ0lEbs2+TdHvq1YUht/NZ/0DI
	rva3Ucv/4Gk2QT7Dtf2FIhxBOBw8tEQvrbnJ1JJFVsG+OP+g3GW90VIaWz0CmtoLL35CkdaB0cM
	SwisJnmgkfgP84jaoQWl91EB7fUbMfSMR8FephY3I6hfx52SLXBKK0DEehhTTspWK5iewAtdNqY
	YcBeoirP1CF2qLbDfXYGnh2mtL18hfoTrkzE1Rn
X-Received: by 2002:a17:90b:2687:b0:3ab:22fe:b13a with SMTP id 98e67ed59e1d1-3ab3a79a2efmr1620761a91.40.1791548692476;
        Fri, 09 Oct 2026 05:24:52 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:51 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/13] MAINTAINERS: amt: cover the amt headers and selftests
Date: Fri,  9 Oct 2026 12:24:24 +0000
Message-ID: <20261009122426.551178-12-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009122426.551178-1-omar@blockcast.net>
References: <20261009122426.551178-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMT entry lists only drivers/net/amt.c, so get_maintainer.pl does
not find the AMT maintainer for changes to include/net/amt.h,
include/uapi/linux/amt.h or tools/testing/selftests/net/amt.sh, and this
series touches the first two and adds selftests next to the third. Add
the two headers, and a glob that covers amt.sh and the new amt_*.sh
scripts.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b..51799f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1461,6 +1461,9 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
+F:	include/net/amt.h
+F:	include/uapi/linux/amt.h
+F:	tools/testing/selftests/net/amt*.sh
 
 ANALOG DEVICES INC AD3530R DRIVER
 M:	Kim Seer Paller <kimseer.paller@analog.com>
-- 
2.43.0

