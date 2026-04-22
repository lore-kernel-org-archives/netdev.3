Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC23D170E;
	Wed, 22 Apr 2026 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860004; cv=none; b=kJH7Rg2MMxZoYUv/MpPCh1Q+r0bwYyg6kfJa+xNkZkqOlKj+EAVVywbqYUzVzHSnMnUJJs+Q9vF03+4MWSMEQTQpPrIeYvFto9JLcKanaPyfiwfjdo4Ys8NUwfLkNMN+HLCKq8DgQLaT29hSxGCDHGJCX0QrnThT2x6D8ExIMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860004; c=relaxed/simple;
	bh=/s0YhOlKdnN1aATsWHE4WRZhey91VqJ0A6Vg5srU/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO+OvZM65yUrdwkIBg2ho1GFZ+kc/41k/q1dNcZwKezgdXA8+QZcqwPb+nEE6MA9ePPKUSk+WkYlTxt5CsCgqvNDG4mn+zZOgJMRkH0qIm69NbRiCBIrFh9CiamCuF1Hr+ryd3usBTBl7eAM90r9nhk7FLkyYr24twbt886xf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vYYw7S8n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vYYw7S8n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yFRF5ZSkdDClglChI7bgyrDcalsy3TCNzU4RceX72a0=; b=vYYw7S8nHvHjgWhrEjAPUImI+h
	VLfQATE1bXo5r6fFwULDhIH5kc7wR0HF4TwWuCzifZKDJjlqxN68P9Km9UkEuivlMu7DSC3hdJ5U6
	4PqeXRPNCB5fsMjag9qwrM1F1yX+ZSDNoYEE/JzpfV8QG/7RlRzq4ce1UMVBFrvVAp6w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFWS9-00H1kJ-VB; Wed, 22 Apr 2026 14:13:13 +0200
Date: Wed, 22 Apr 2026 14:13:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 11/18] drivers: net: cirrus: cs89x0: Remove this
 driver
Message-ID: <c6696785-6f1f-4747-996a-d86a60a23d0b@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-11-69517c689d1f@lunn.ch>
 <CAMuHMdWz=ucmKxHXmzKj=oTn6yMVxPnkNxtG6X2C3ts_ZCg4Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWz=ucmKxHXmzKj=oTn6yMVxPnkNxtG6X2C3ts_ZCg4Cw@mail.gmail.com>

> > -config CS89x0_PLATFORM
> > -       tristate "CS89x0 platform driver support"
> > -       depends on ARM || (COMPILE_TEST && !PPC)
> > -       select CS89x0
> > -       help
> > -         Say Y to compile the cs89x0 platform driver. This makes this driver
> > -         suitable for use on certain evaluation boards such as the iMX21ADS.
> > -
> > -         To compile this driver as a module, choose M here. The module
> > -         will be called cs89x0.
> 
> This is the more modern DT-based part...

No dependency on OF?

> However, no users of these compatible values ever appeared upstream.

Thanks for the information. That helps with the removal.

       Andrew
