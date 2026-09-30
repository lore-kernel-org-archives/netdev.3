Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48053C3450;
	Wed, 30 Sep 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801489; cv=none; b=jfI+8dF3bTjOoT78Ce4sWDIaYt9J/+gd3vZYqnUiVT1zZc1h1ZzkYYVQ12rYqvyn9LLR1PEvuRWID6A7HYGfZdJO4HbgRERxl4y4vFSx7i6yIvX3Y7X1DT8BeTIK0hNtEgC0/arEaaGeEfoEkv97RA3tIiJHu0LBh56CaihbvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801489; c=relaxed/simple;
	bh=F7BNPTzA7PSKWN2FZz7t+OEbxLrR1TWY6FmIu3wZS74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rndk97nogkfjZdpl7N4Jgh+byW59ZmUT3Yk2mb6W1IM06fCFZEOnm48Gd40hAbYUnUT0tvg1m99H+1htfpHUv1JHJk0Sk24/XL98L15wmbDdjyoQnzoBFkKMGA2SyiCPf2EUklSaSJMAuv+t34VKgK80HeqMO4u0458Q1dbT7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTPu7D0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTPu7D0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB481F000FF;
	Wed, 30 Sep 2026 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790801488;
	bh=uC+6UVM2GPZ96eFu0TIu8Pwk+9kSq3jFTix3iTNizKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TTPu7D0diU1gmZIMhmkp2JN5ifSiExdXefd5GUcLmbtJfhI60179El7kiTNSOLOQu
	 QVuvc5zxIS7pKqGZxgbWjdxfCyGneSefiyp2CWsTjqRwqQYf0/4Q3SlZuDgD6DW7v6
	 SQUjqUgpfTgSm3SH4yIWe8L5f+7vH1601zJZ/mUgDII4pOjtuqsHpUL/JE9zTE3HMF
	 WhwTaD9ymK9kQ5hM4lhpxGOy6yUEzSrE7LwM52aviyTHi1A0iJtM3eEQVK4b6RvjmA
	 F9kiWA7g8MF4R3HzZ1G7nz/2J3CdLCZPKLpnePvxAwk9ZEN7HH+e81iONpN//OAktw
	 rsyoVt389j/sw==
Date: Wed, 30 Sep 2026 13:51:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
 claudiu.manoil@nxp.com, netdev@vger.kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Message-ID: <20260930135127.28f95804@kernel.org>
In-Reply-To: <c3b7e841-5eea-4431-b231-44659e1605c3@nabladev.com>
References: <20260924180607.60932-1-marex@nabladev.com>
	<179073420852.1211220.2021094445984738152.git-patchwork-notify@kernel.org>
	<c3b7e841-5eea-4431-b231-44659e1605c3@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 04:21:19 +0200 Marek Vasut wrote:
> On 9/30/26 4:10 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This patch was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Thu, 24 Sep 2026 20:05:19 +0200 you wrote:  
> >> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
> >> but also very compatible. However, for example NXP TJA1120 PHY needs
> >> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
> >>
> >> As a minimum change, increase the MDC clock to 2.5 MHz which matches
> >> the 802.3 specification. Also, even old PHYs like LAN8210Ai, KSZ8794,
> >> DP83822 support up to 2.5 MHz MDC clock frequency, and it covers the
> >> NXP TJA1120 as well. There is no known rationale for why the 558 kHz
> >> was picked when the eMDIO driver was added.
> >>
> > Here is the summary with links:
> >    - [net-next,v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
> >      https://git.kernel.org/netdev/net-next/c/587acb86d646  
> This should have likely been applied only after someone from NXP looked 
> at it.

Maybe say that in the commit message next time.
