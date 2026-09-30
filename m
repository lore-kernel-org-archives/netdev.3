Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F950B43C;
	Wed, 30 Sep 2026 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800871; cv=none; b=jj8RWVfdoY3o5k54CZwlsucG35+jtsT7iqo0SEC8Vhk2004C0jF3w04FEujhf+A/T2WL84AF1RCH4gyvE9uAuPyrr0LWIDPMQ9fscc93BC1wA+gWIseXssraHZ9pQWs7dzEDUryH0sfmGEg5VHnL9/BxxgO5j+s3NdPZ7WFwHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800871; c=relaxed/simple;
	bh=qftue8LAVCfe9/Ww//SW39c0xQdEsRs0r4tpmWpCCJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkY6Y117gY3CW+9TPc/E2AVZn7M1LCBUSZcIiU/SK8xNNPHjNQ42s2zKW7qxribFxRBwiNfCFs8hUJJn9GYfqaIZvZEnrxbP+y5o9TjTCGhWNOkpc56zNtTV+/GCRgnxgknBNu2Lo3QhkKTRUZ0JnX46snLgQuTkRDhk82rP4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHScRGBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHScRGBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECCE1F000FF;
	Wed, 30 Sep 2026 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800870;
	bh=fiTSotZVNzG3RYwFvfm7nlfh2PC3f5RVrwIlh50qYgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bHScRGBr0j6KA1GmiT1QSu8JzEc6tE15aDZ0LKjyMWQdymbE7130yQYqxBZtCYSwD
	 wdhgl7kEd1drczvOTCzWXCjxtk1wIIpNR0baojalXjCkn+tq7PxtcYsBA8j7u3x2u7
	 SpH2ferBZErFj/Z4rsUEKykoePAq0MmFduVkGJr+T7enmiTfugS8mwSD1G5Xa2rpM/
	 Sen+NGRstfyalSdpuYHa2INA7t2E+B1O1bqR1eLlCV350sshorJ7oQ6seux2gRh4wa
	 a6ouksgq86/Si0zXkhcZx6UbRrBJk0it+LKvUqWZIVYPTxDZPmt6ib4b+XXhc5kL7d
	 btQZ1+NbQHi0w==
Date: Wed, 30 Sep 2026 13:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Kuniyuki Iwashima
 <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 thomas.petazzoni@bootlin.com, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: keep the NAPI_DISABLE flag while napi is
 disabled
Message-ID: <20260930134109.0fc3824a@kernel.org>
In-Reply-To: <189e048f-d04a-4440-bf65-166c747ed6cf@bootlin.com>
References: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
	<20260927154142.656700c6@kernel.org>
	<189e048f-d04a-4440-bf65-166c747ed6cf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 09:08:29 +0200 Maxime Chevallier wrote:
> On 9/28/26 00:41, Jakub Kicinski wrote:
> > On Sat, 26 Sep 2026 21:47:13 +0200 Maxime Chevallier wrote:  
> >> This seems to be more general than stmmac though, there are lots of
> >> drivers that create the napi instances in .probe(), so they still live
> >> outside of .open()/.close(). It was verified by running the following on
> >> an mvneta board :  
> > 
> > Not sure this works, you assume ownership if DISABLE is set but we set
> > it to start the shutdown, not once we stopped the poller.
> > 
> > We've been tempted to "fix" this multiple times. I'd prefer to fix
> > drivers.  
> 
> There's 2 classes of problems then
> 
> - drivers that create a napi instance but don't use it even when
> admin up (stmmac, I think it used to be the case for i40e looking
> at the history). Fixing the driver makes sense then
> 
> - drivers that add napi instances at .probe() time, in which
> case setting threaded to 1 -> 0 when the interface is admin down
> is always going to hang. There's quite a few of them :
> 
> git grep -p netif_napi_add | grep probe | wc -l
> 75

TIL git grep -p, nice!

> So at least 75 drivers call netif_napi_add from their probe
> functions.

Mostly old drivers, half of which we should probably delete :S

Can we not refuse disabling the threaded state if the device
is down and has NAPIs?
