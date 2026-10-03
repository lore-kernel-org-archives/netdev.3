Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AE356773
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037794; cv=none; b=J2W3G2Le9t8P1teULZ5bPCpv7Cr2We3GM6Ll3r0nsgqtrdwr6ydfsdqwwMr8FAh27x8pAAdnpiADwJfXOl9wP2Ux5lTCmVC6Mvwvxv9SENLPUPi8ka6XPj5IEODaQQOEoxXQbbjGOg1YRIMjiLhfo/yzU36gpjJDD9Z8Jg81C7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037794; c=relaxed/simple;
	bh=0FDlgE8/WtKxquJ1GTctYIuuqUHSqOHXaOawd/W2wAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaNe9khNrVp87VUg8Z8lX0yYcdwTwTFK2q0VREYX6cHLd27Hfq9/ze2XAL1bgAFoM9Aa6/nmbfQPP4PiE0L0KbNUzYeGm51z782zwhJ5gP4WxsZvYxom3uqzGg8CDq7sIDsATtYai3SB5dfz7BniMkshIWOrUYFvUPgmxpnmRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfRVTunU; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfRVTunU"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b0fc598f8so202424f8f.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791037791; x=1791642591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=DfRVTunU9jbFEsqPT9kqur/9LUCxYqIC+cipGl1i2VS8mMiqkJSoQUrdrA4NYvYU1F
         i5yqhKQBaDUnT6qZmuLwxlfrps9z2NNB/Hdl41KPPHWvE2HNvKAW15itrkWMckQtckOg
         ESuy/bZmn9SSge4YdhSFTpilIczq21qJSYMN0VhVdO4sLjx7112gOGUWV1GoyRItZqfn
         FUZnvi9uX5E50UP1/cIXtLqwIxIE5Hs7mGkwjA4UptForWelIRe9wGNegybDXpI6ls+6
         mhgSiNy1FbIthXXp48buPfw1UoEYPlTCsu3OKx9lf2IqqNUN0GYbMXqRQO+TyS7arerY
         6Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037791; x=1791642591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=BPemm0sTPd0Zs5nQhjVcs2Jje7OAXCpFVKPv+Bu3sSy8sjzkGO3oSdrSmFto8HuPwd
         qg9Fl6N9/UXgK0g+vGxdTwM4oKv/l61srYCPW2r0ZiRMcm6L/0LfgpU52NFFP+bjA5ip
         guHVxywnDAcDvhN+0F1KmyTT09KEbg8X/I6rvrY4jELk6HqE7wrNy5N4tGu1ChRle7ae
         PP40ggyKK5fkELEHvipyi4Ih7RAG1EP5GDlQaooY6MF7pPg7zJQP8aDWfy14LvR+JlOQ
         IUt+EDOqq5/fOxPHkYUlWeonrHeNHAS3IOkulgL+n7qovI7PDaoK7ugO5nNINq2JyqPj
         4BUw==
X-Gm-Message-State: AFuF++lMPx/RLqScfBoPcj5C8JI+hN6etdHXImG6zx8iypviCuka64HG
	XNYdHCiiyg4i1Nmi1Nj6XeH7cpFld++44GNOadGlnpby/ULE1HjOb9gf
X-Gm-Gg: AYBFou1v2HBLCldmDFxYqav0kGzofblC5NAO/fMIYMzMawIVgBIXwIoCigu2MfITmCb
	w8hhd7xTWLxeNGKcG/98GOr1T46P/I3zd+SrscpV5nsKQOp7gxIk6Zblq1X2Yc7oZDaAhSFVhcL
	PGz9uW9ICcxnxcQQ2xhilCQTYCddVbyzHlP1gQzmaL/T7959mltsYrHn2fiLR5+ajjWshtYoFW3
	9ib5LCxL3jT2y56lY6YZlSkcnDZ9YnyBchfq9FFBqXU0iFJmDUIwLXUSsKt/ytg+JaBfozHuAJR
	LN8yfgk00vWb7fdyUC2aHq8Nw3NpX32tMG4Y28PvR4io3sfQ0L7qu/JWnRdJUVD4ftRsfxAWr3n
	efwU3bySXbynoii/oTPt46cBUdMPYUuyxXMZojJzXFG+bGOaJQNhfMaqvOhqfx6KsPyuuWkbRJq
	/UkyKi9adFhItJUhQwkpqhfALdfZooWXJvGibC5pYjRdfeT+TBWzF6Szh770HDfdQNLqde9/v6m
	stsC7hHjXd1Wf8rKn5MR2KE5ImQuJRgv9Xkg1CTqq8ENCb2zaIcpYJIylG11oNFaTKyfovx0Hq5
	qS6DVG43I7DyNbB0R52ysPT76MDv55HIu9ZoCWEtDkv/eBgS4CZJAKVWj8v0vnsrvAqS1gEC1SY
	=
X-Received: by 2002:a05:600c:c162:b0:4a0:1b77:db0 with SMTP id 5b1f17b1804b1-4a0276b86b5mr102814875e9.35.1791037791041;
        Sat, 03 Oct 2026 07:29:51 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm146494905e9.0.2026.10.03.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:29:50 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:29:48 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Alexander Sverdlin <alex@sverdlin.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Message-ID: <asEQ9o6etFua8Hof@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
 <179103680648.1402591.2581152276872666183@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179103680648.1402591.2581152276872666183@kernel.org>

On Sat, Oct 03, 2026 at 02:13:26PM +0100, netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

The rx_mode_work lifetime issue was found during an LLM-assisted review
of the 6.12.112-rc1 stable series.

Reviewing the same probe error path in dual-EMAC mode then exposed the
older secondary-netdev cleanup bug.

Thanks,
Karl
