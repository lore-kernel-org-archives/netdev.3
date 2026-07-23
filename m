Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70837F30C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829956; cv=none; b=t7kQ+CT8hCqT3cWl6PyWlMj55hTGwzCQGuocXseJUJwB/dh5qB6NPaaH2lOPp+mTn+tePqoNLLnoqR3USlX5dKJOXdqsmTP+aWbTje2u4j6oGghhMLruv4EGkSh7o/6x7aPq5+dSzoJJvGOGC3n7gPSFK4xemhAJ1jVJDLoLxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829956; c=relaxed/simple;
	bh=EfDO5JplHPYnqiqWfGQbjE/8zNpElYxPN5K6r82jX4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuDR5iItR2AP4kB15CmebVKy/uErXeDb/z+DVZ/V0F2SlsElhaC4hgOFGjbCySKb21hNJ538yOxDwYY1zQV8vFYcBHOAD5RWj14UoRagNa28QQQZJgAo7yfmIyXdTvbub/xoQXf/74nMRWXNswpvQ3Xwp8PIdObTuH/XsHKx89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DVZEVT6S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVZEVT6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MKkAxcRx4DbITPKEKTH6AhZ5HmzvsXDQJS8UJvAd3U4=; b=DVZEVT6Si8lNy0cpDnAfDp2q+m
	eQbwQqLnV5wO/qnkXYG4JM1J2o7tAFzdgVLEgBktb5VyDwYI19mRyIUqr+SWr3YqtXC/dZenSEok1
	OjS8x44XihPiQnWz0QIkjdNjN4knRwSe0PxQU9e23wZqBc13d3I8CQ33dy95WaCfJ3iQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmxnr-00DrsR-UE; Thu, 23 Jul 2026 20:05:51 +0200
Date: Thu, 23 Jul 2026 20:05:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org, dietz23838@hs-ansbach.de
Subject: Re: short description of GeoNetworking
Message-ID: <7d4846fd-b997-4e74-b58e-42c3dd1de898@lunn.ch>
References: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
 <20260723174347.2458082-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723174347.2458082-1-simon.dietz@plantwatch.de>

On Thu, Jul 23, 2026 at 07:43:47PM +0200, Simon Dietz wrote:
> Hi Andrew,
> 
> > That is another issue. It make no sense to merge without having at
> > least one wifi driver support the needed frequency bands.
> 
> In the V2V research community there are working out-of-tree patches
> for at least ath9k and proposed changes for ath10k. I think here applys
> the chicken and the egg problem. Why should 802.11p patches be merged
> upstream, when nothing is using them?

Does 802.11p require these protocols? Are you allowed to use plain,
boring, TCP/IP over 802.11p?

What quality are these patches? Hacks or mainline worthy? Is the
frequency management correctly done, which i guess means
wireless-regdb?

	Andrew
