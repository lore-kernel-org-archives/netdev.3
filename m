Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D917352030;
	Fri, 29 May 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018886; cv=none; b=JXHrNTO4821HVQmM48B9Nkt1kTgqSZUFEmReQ2ZDPrhWBnKH51kejKZjKIx9k5S+2iZUdWFSpoaCJ5MCyVmZeB6I+qiywdUcdbH/Gv6EWukuKZcrTVdYKs31+zmoNypdBX3Eiet7T0G97uZLri8YlH8Dkq7fzA7d5oeSP/P5Ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018886; c=relaxed/simple;
	bh=l3+/GwyXzi+v1tm1jRxV7wFdoWkpGW8Fm1hp6/jlbhU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=D3VJPwt2Wc3JRWTf/p4FFQ3My4RuP8/9idIhP6Aa8up57mVSvwo540L5/60xD03iIlXLyBslIhSONtrnPNwHVaH5X+kXIXyiB5gUtoAuceAYUWsBoPpA8fxjzLJsI7svXrOo/xwGoy3lZ/5YUTFdCrKCByOmgn4wrKNMjujAcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=agNs5LXg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="agNs5LXg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780018880; h=Message-ID:Subject:Date:From:To;
	bh=FA4cOytTwwL6Znar0iXU2ZZbEQ4KKMxgHKUcmJ5WVEI=;
	b=agNs5LXgFrhPt/OOneLwTxNheoiapdI8PIwVVQE+xRuTWGsollaxxVcKnJhPWopbRk2a4/DNQIzFIk/tPNUQQ8nb7x08o+oUKyz9ccu9eNvyJGJ0aEaHjzij6fgtk7MUuHirGJW/Aq1ihEHTG5NGHCsJI0befWpwMXes6OZnNJw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3nYIR3_1780018878;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X3nYIR3_1780018878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 May 2026 09:41:19 +0800
Message-ID: <1780018791.8076131-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for ethtool pause validation
Date: Fri, 29 May 2026 09:39:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <f9d0b5bf-e285-4694-8147-e7b59164da00@bootlin.com>
 <81777bc8-b046-4c76-9f53-e33563b6ad62@lunn.ch>
In-Reply-To: <81777bc8-b046-4c76-9f53-e33563b6ad62@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 27 May 2026 14:08:30 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > As for the kAPI testing, I agree that the end goal is to get driver
> > authors to get their flow control implementation right running this
> > suite.
> >
> > But I don't really see how we can validate kAPI itself, as we're down at
> > the ethnl level.
>
> All we can do is invoke the kAPI in different ways, and test we get
> the expected results. When it fails, it is down to the developer to
> figure out why, which layer. But they have a description of what the
> test is doing, and why? In most reviews, all i need to explain is the
> expected behaviour, and the second version is correct. So a test with
> explanation text should sort cut that process. I don't think we need
> any more.
>
> To some extent, we have an iterative process here. We have never done
> testing of this, we don't know exactly what we need. If we get
> feedback that a test is failing, but they cannot figure out why, we
> might need to help out, and then extend either the text, or add finer
> grain testing to narrow down the problem space. If we get a submission
> which passes all the tests but review turns up problems, we might want
> to ask the developers to extend the tests to catch the failure.
>

So I've been thinking lately: should we let AI generate and maintain these tests,
including kselftest? This would give us a much richer and more comprehensive
set of tests. Plus, each test could come with a complete explanation of its
purpose and methodology. In short, much of the work we used to do manually
can be offloaded to AI. This way, we can build a massive test suite and
achieve much broader coverage.

I'm actually trying this out right now.

Thanks.


>     Andrew
>
