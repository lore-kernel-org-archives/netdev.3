Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42725349B0D;
	Thu, 30 Jul 2026 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450930; cv=none; b=nIdIQwkXr0di+RcR0vZPnXjayn/UXzBts6oYJgxH2747YHrEwd++4b9NXfAMmOK1puC3rJ7opGwUGSodnt3T517+CJGo4MRX+FMLayWw2u4L4aml3LpdNr5hWJM4FUwvviJtVoO7R2o1XhxR6pEhzBjU96SZRcUJ9M45F2H+NH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450930; c=relaxed/simple;
	bh=tjOK9zrBCmS8Hk04FWtAUCTnBA0ywR46D9BkD4MnWRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=staG0qdqRKQ0qbMpIzLAXQSI0V3YZG0grWokKuNwkQDnS+oQ9DXR6xJDNJvQsIxjXkwlIRSNng4l2MYwIGIt+bHV2QrepuWK2H8dlsQVA9Xu5mqYdgYFswB5LxTNhgmDHfcvme9wWiPkByv6lNd4B2FaN/yGNvvCJZtm4N9VebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1SQF3I/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1SQF3I/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732311F000E9;
	Thu, 30 Jul 2026 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450928;
	bh=o0wWqnNxLHl40UlsSb0fWbHIl5D/+95UFcbx9M4Q8fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h1SQF3I/A/8ANy3d4jF3B67I172G7ZWD7E26WPhPf6/mb6pvpbhTwIB3Kn3lS6dKe
	 HJrkiiGO1LP6utvms96otb0FMY4qEhUrCkB4Bggt7UH35j8R6A7crNw+jxG1kNh56Y
	 YqdbjPsjyRW19gupzxf4BCI8rWmvvgCDgvXEsYQE4/UrkOroJcUUWDkEgFJlx/gI/q
	 +eNI57yzccM1XTl2QDrnUzdjpSfKqO52LuR0oSMVde/0G932EnGBYFcCDRMNz3CAXA
	 z33Ii967tzRVtxU8iOWxM9ADsVa/Ls1+zyDOSDJkmrdatnGsHTanGyRXyXMTnP3ycv
	 Q13EJOMsNsBHw==
Date: Thu, 30 Jul 2026 15:35:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v7] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <20260730153527.34135188@kernel.org>
In-Reply-To: <20260728112105.2668014-1-kyle.switch@motor-comm.com>
References: <20260728112105.2668014-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 19:21:05 +0800 Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed

Missing some kdoc returns:

Warning: drivers/net/phy/phy-c45.c:1293 No description found for return value of 'genphy_c45_template_testmode'
Warning: drivers/net/phy/phy-c45.c:1293 No description found for return value of 'genphy_c45_template_testmode'

Plus at a glance you also added stray semicolons after functions?

Last but not least, Sashiko/Gemini has 10 complaints, please check
these before working on v8:

https://sashiko.dev/#/patchset/20260728112105.2668014-1-kyle.switch@motor-comm.com
-- 
pw-bot: cr
