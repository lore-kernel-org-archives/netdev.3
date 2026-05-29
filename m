Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB33603C0;
	Fri, 29 May 2026 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078023; cv=none; b=neXCuxwvzkDVXiJrlehfemU7a4LhPJVqyk6Oei6DT0lc27XpbPvzqE8MqcLrRqQfUQ6sJEbyvPOsztIfHYCDafoyoJPETI/tsWXpRnPZ+7e9OAVg+XNWzKhIm26xiZDroInzYefQekUPZUXd54Iw4TiD2VFnQNsbSO1NKxzuhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078023; c=relaxed/simple;
	bh=h3q2IL3PXumO9/JvbBEX/SMuTCApuFPUCdWS8EF/JFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9i9D0BWClBuwKqrCep09rN+XLQx0FSt5tSmPZI6BqpKIcbbkIyi2DeezixCj8+3cnVfTCEQkX1WpkzyhNm7jZZdig9uMpqIU77hSQdThswD4jzr4sziWtk3jF2hfU2dgMaVjX0/wYjks/6lrMusVn0+x1Ic0ibPTFblLst+KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJhNyGxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJhNyGxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0FF1F00893;
	Fri, 29 May 2026 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078022;
	bh=97ojEt1rZdfEz6DESGM5vEbigCIu/Q6LxBoe0cL00sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cJhNyGxCFcAWDDCrHMagdbI7OtS8Y08/fLym0A14eTdqt8ykBtiM1RhvAhttA4T0F
	 Gc6s7JopSqw9XSLWKaJiACJy9WQtzB138FwVNbdW+yMb+osx7zFz+h7gHpS31i7KJs
	 prFkphZHQpuqDBRk/RHr+wcYa6E6Jk1mgPc1z6nkHfVxbMpiUR4S4AOjMMkYqGcgs/
	 1Rz0mD+S9vBDaB2yVwUxupEQK28Fb7ZBiq6ih9J4lpM594uSsKQJSkU0n5TCGKa77b
	 8tJC3PQkxVeNA7OPZEMzkMS8adq5S5KguGmU+t+EJ4A97DULKvFzIZh/8J546U39/E
	 ZAj4qnA4lUncw==
Date: Fri, 29 May 2026 11:07:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
 <nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v6 1/7] r8169: add support for multi irqs
Message-ID: <20260529110700.5805ea70@kernel.org>
In-Reply-To: <6f55096511784f66ae46a217014def79@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-2-javen_xu@realsil.com.cn>
	<20260528180004.58991104@kernel.org>
	<6f55096511784f66ae46a217014def79@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 05:43:52 +0000 Javen wrote:
> >devm_add_action_or_reset() can fail (as the AI bots point out) but this whole
> >devm_ dance is entirely unnecessary networking stack will automatically
> >delete NAPI instances when device is unregistered.  
> 
> Thanks for your review.
> 
> In patch v3, link: https://lore.kernel.org/netdev/20260513115543.1730-2-javen_xu@realsil.com.cn/
> I tried to alloc struct rtl8169_napi dynamically for saving memory according to Heiner's suggestion. I agree with his suggestion because only 8127 rss are enabled.
> And in this ai review, link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260520031603.700-1-javen_xu%40realsil.com.cn
> AI suggested that the lifetime of this devm_kcalloc'd napi array may be compatible with the netdev's napi list. So I add devm_add_action_or_reset in patch v6.
> I checked the code and agree that the stack auto-deletes NAPI instances in free_netdev() -> netdev_napi_exit(). However, because devres releases resources in LIFO order:
> 1. kfree for the NAPI array (allocated via devm_kcalloc) will be called first.
> 2. free_netdev() (registered via devm_alloc_etherdev) will be called second
> When free_netdev() calls netdev_napi_exit() to iterate over dev->napi_list, the NAPI memory has already been freed by devm, which will cause a Use-After-Free. That's why I added the devm action to explicitly remove it before the memory is freed.
> 
> So I wanna know what should I do? Whether keep the action in this
> patch(dynamically allocate napi array) or patch v2(fix the array
> size), or any other suggestion will be apperaciated.

Personal preference I guess. IMO it's pretty clear here that the devm_
help relatively little and they introduce a lot of complexity. You can
stop using them, or just handle the error on devm_add_action_or_reset().
