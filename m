Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32847CC78;
	Mon, 21 Sep 2026 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033868; cv=none; b=NNOblpVT1U2ER6RKnFGHRBnlQpF10nXhH/uaywHKl7fL9S0UN1IGmaBJepPqrikACTKU/AZnTWdVdlY3egE87EfG9+WA6sclv/0a2w2zZW7YnGSheB1+oy5FLUOXcc000LT3ET5MH6a/xj5e87h+dtbEOVRMTtoquS+GRjl5K6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033868; c=relaxed/simple;
	bh=pXyaiQnZtAeP7rLSBmA1iQaPG8ekDfFidf3w4+9OPvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luQkj5lHpdJmz/89lk3VZ/pHJ0yDqj+THg3vWpj+yDyMVei5WJNC/kizshBOuI/tokDH4SwHKCt5znWu+ReE5CmVYWxO7rSr+MTzap0/kRnCQ5Ecavq52PuTzgwi/SJfAPI9Tqkg7fcxYWIUmQGJAG/JwBd8iVLULpKPGmZ+dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXHLRQkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXHLRQkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00DD1F000FF;
	Mon, 21 Sep 2026 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033867;
	bh=/4trmqFPsL7oNwrkhGXWPZao4cWrt9a6hBxAYGtJFE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TXHLRQkUtnEWsQvNon8eJ5W06gvMx1xjGLE33ZjXSV9ukeeqX/LDTAf5t52v+hW5m
	 f83wWQ1bNlDs6niPgZEQTsZsUgy+t4eEuGI5Ubolkq1fytrMUifZxTadbGzqFxiht9
	 ubB9dcxcwY5DD3r36hkTmUmWZXP/w2AYQT7sjl/OOQJKF+4Z+TlQ7h/47mkXzBQAFe
	 c3xTgkgJvskLZA9QGUiazElHDgoJYuaweg5xSTkhN8NqFb4Pj/zZzSOT2gNNq+xM1Z
	 FMeBXD1rvVDCJ7h+2pzUFyYh0YTkrr+Y/6ryarqZkoZLEGZ2AS27torpPBSj70R/NJ
	 UrWal6lBTVE0g==
Date: Mon, 21 Sep 2026 16:37:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev, jjc@jclark.com,
 florian.fainelli@broadcom.com, opendmb@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: don't require the hwtstamp NDOs when a PHY
 provides timestamping
Message-ID: <20260921163746.5d5d0070@kernel.org>
In-Reply-To: <8037c32ce6fef79a74ee56973bf185c2@tipi-net.de>
References: <20260918095540.34286-1-nb@tipi-net.de>
	<178998466913.2160803.80702009306181180@kernel.org>
	<8037c32ce6fef79a74ee56973bf185c2@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 12:23:37 +0200 Nicolai Buchwitz wrote:
> > One detail for whoever narrows the tsconfig gates later: the fix is not 
> > a
> > mechanical copy of this one.  The HWTSTAMP_SOURCE_NETDEV branch in
> > dev_get_hwtstamp_phylib() still calls the callback with no NULL test:
> > 
> > net/core/dev_ioctl.c:dev_get_hwtstamp_phylib() {
> > 	...
> > 	if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
> > 		return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> > 	...
> > }
> > 
> > dev->hwprov is only ever assigned in ethnl_set_tsconfig(), which is
> > reached through ethnl_set_tsconfig_validate(), so that branch is safe
> > today precisely because of the check under discussion.  Should the two
> > sites be changed together?  
> 
> No, IMHO not here. It would change change behaviour that never worked.
> Thus I would suggest fixing this with a follow-up to net-next.

Not sure I agree that it's separate but whatever, I don't want the ioctl
fix to miss rc5.

I'd prefer the netlink fix to also target net, tho. Netlink
functionality should match the IOCTL, targeting -next would put user
space in an awkward position when deciding between the two.
