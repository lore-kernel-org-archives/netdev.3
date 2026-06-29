Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01242314D37;
	Mon, 29 Jun 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774472; cv=none; b=YBNkmMdhyzGo/E1r7CpCwB6qua6n4OyLz2urh28nlW33yi7B+Q1GLxoXZTjWqXoOtkgBdjzhm6A7J4hFHDAPN8xAkvZ8ZVS2CX/WjDaij8rPBrp4n5kAhlpfRPwVwusLsulUeGft/491SSpruhhlJFv4pr8RmMhUloqixIeb6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774472; c=relaxed/simple;
	bh=0b98DQegh8h5rfdnujJR+hjTymj8BBlMOubiJy/+8G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxHfNrltWrb20jtonFfjEYYg/clkbvlEepn1ugKamXwwSkZ8yE7BEtarL5Lo6Z5nsE305dHjew8fvi48J3eZzImMB+sZ9qcdkbDUQHSzm7ojX8sydjMKBiMzAQG+wtYJ32fqKBqQbVPO5BRml50BuRaDYxfiPKba+t5zg+fiMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YERhWV5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YERhWV5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355471F000E9;
	Mon, 29 Jun 2026 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774471;
	bh=mxQBa5sXfIaVTFTHSBvuqdLuv/xmtYKlIj0I76zVS3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YERhWV5YRiFMFBvr6nnFiSiiw2LE+fFOXCh7RvlV5NTbI4g1eqXNC0TUL2fcSbbNF
	 cqABYon7+d0B3ueLlL7oNzteEc8ayH9DHflacO5gXEsKcTjMnzzG4IlwB45gutJYfX
	 HQm0htIin2oJyP0xqtb0NoOjWgBpVamkL9Qtxz3Jma/HG7aCt+cwzdMLY3Ov7zw9pn
	 veMezZyifLkRUTMM2MjQTit7cXhv2tfcd/JDUO7z+wx9a0vcPiE9/2ME3Pgp3qwy9f
	 Ps1JGFnyCrDl1m19QnY8gLwcDyC9XzOe92xEz0RP92nfF1jwjEztDMvDngmh2imv2F
	 YRG2CnNfJzxIw==
Date: Mon, 29 Jun 2026 16:07:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/7] r8169: add support for phylink
Message-ID: <20260629160750.0a84e5e8@kernel.org>
In-Reply-To: <20260629060931.1006-1-javen_xu@realsil.com.cn>
References: <20260629060931.1006-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 14:09:24 +0800 javen wrote:
> This series patch adds support for phylink. RTL8116af is a fiber mode
> card, link status and speed can not be read from standard phy reg. So
> we read link status and speed from serdes reg by pcs. So as RTL8127atf.

Sorry, but net-next was still closed when you posted.
It'd be unfair towards those who follow the announcements to consider
this posting, you'll have to resend.
-- 
pw-bot: defer
