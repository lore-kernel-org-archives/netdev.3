Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AE367295;
	Mon,  8 Jun 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951582; cv=none; b=PDHre0miZVsZOvgrnyGwfKDsfFpLsnOC+bGUElHD9GBtFQEICOcq/k9Umi6K36RySuQINteinPwis0BVF5CRMC32FHP2RxebxslNgVzxOemf37ehL53JfoLvP+nFFflro1mc3kYqkpq4G4VxTgt77UmuT0CYQQaSXIVefUeLDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951582; c=relaxed/simple;
	bh=7F9jn/fEdMi13tnEYtwc9oUqIgD2eqhkP6jhWfbtbeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slSyizLHjL6ocymnQl+1qYxKu4amqqDkbtEEzOxxbpv0pYEYpnucSkOCxQEhITp/OCReCHbS7Rr0TCbsl272oSQjZwbjHhcTkHQfUeeJZu5CzSOETPBEeS77E6Pms0b5nIK+GHiRxYJl2Atp//XMwdeobMA1ULpzBh1swMVEC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7oMZK5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7oMZK5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93AA1F00898;
	Mon,  8 Jun 2026 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951581;
	bh=bWIBY5LUl28yp5MsbXoMql0yAtjBrajs5SLSANim5yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f7oMZK5cCZFS1D519w2gfmLagDibUdphM/mqhB5JatxX/YENzI9XKQ/iEklWMUn6F
	 jRTrpH1XRV88COxVUfnLMTN/yKa0JMQddqlFlS5YOG+DAo9Za6XZIgGELeWEMZSVr1
	 xfWTcdOSFokDIkHdPKJ2HgqDvYeoXl1BG3mLthOP/3WSUCov/W04sQWJu7T+IYtI3n
	 YAfDRPn+xbRNYwIWQnyu5kxQu5sdft67zjTCVDJL0rEyZcw83L1ITb8m862JABqxGG
	 pTKqMADLBVZy7MmkEq2ozn9d/jROIl1aLMCeDMKWBFDpqBicM4vrMgomjBFJIU5f0R
	 z17YV58pKWWGg==
Date: Mon, 8 Jun 2026 13:46:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG
 offload
Message-ID: <20260608134620.3ff18124@kernel.org>
In-Reply-To: <20260608134533.1c913041@kernel.org>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
	<20260606021047.4124576-1-kuba@kernel.org>
	<7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
	<20260608134533.1c913041@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 13:45:33 -0700 Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 12:14:07 +0300 Ioana Ciornei wrote:
> > Please let me know how I should proceed.  
> 
> TBH I saw ~30 bugs and assumed that at least one of them must be real.
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> and
> https://sashiko.dev/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> 
> LMK if all are actually false positives. If not just ignore the silly
> ones. 

Well, I say "just ignore" - sometimes the AI being confused means that
code is hard to understand, even for humans. So I should have say
"exercise some judgment", I guess.
