Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2623D994;
	Sun, 25 Jan 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769356347; cv=none; b=TljIDSqEkVa+LldFHC694cTSaFLXoK0hsZkTb2ieMa/1YQTS7nbDUP/hrPUYAdomD93UuqP3G4hNOzantuZBMy17yr3lJ7DlFpBeRbnpgVIKeq4ZZ2zNEIxtk52Q5RybdPHGvkNZJ5tWOmPxgRvR9RiqeUzuyg6kk4qeVsCSDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769356347; c=relaxed/simple;
	bh=D33rqpyLTFodzdQ1dhJ+xXv0QwjFVoFFH+qj+aLzPV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0LyR3YBIF8OMNBrg+9n0so4jxPdv8UVFp5hHAqnoeNtVpQUjxcL3sAU2dRUFEMALxPxvJsWnItMeMLVptr+mB6vAwh11Pnh0vgYE2mKdSeSSHO+ygF7IyrgG0E09IpQrl4+TjW/rcZs778Nx3CyeoAKzUwB2CN4JJVlemUJLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PRW8ylLj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PRW8ylLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PjVVGGDzGJQg82HdwI3cCgNHZMB2P+MQX3RCeVSgvs8=; b=PRW8ylLjfCMycHvlq2GxlY0E4q
	agdG9qdhoxJZLUUXXb7wwomAtyOXE2U+4KV6vzwsAF0kQOWhliAe2lvPiDviO9/CbyEKJmDYObsoV
	zelwWS+vwrPNyplXNJJMUH3Pbbe1/ZOBtMkUDGSRZZ3t6dbOROFL81tuls0f8algsm+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vk2PP-004cSM-EV; Sun, 25 Jan 2026 16:52:15 +0100
Date: Sun, 25 Jan 2026 16:52:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 net-next] net: usb: remove unnecessary get_drvinfo
 code and driver versions
Message-ID: <9d03bd34-1c35-4cde-b29c-08e5387139ba@lunn.ch>
References: <20260124102042.112101-1-enelsonmoore@gmail.com>
 <aXTHhI710LK1EsTG@smile.fi.intel.com>
 <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
 <e91dfc01-373d-4d3e-9dd4-9fb3be92f756@lunn.ch>
 <CADkSEUhf5Dpy=yFNQBksEhKjwj-+n07ujADmVHFUv0go5pYbhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUhf5Dpy=yFNQBksEhKjwj-+n07ujADmVHFUv0go5pYbhQ@mail.gmail.com>

> > We prefer lots of small patches, they are easier to find time to
> > review. Combing patches is generally the wrong things to do.
> This is also helpful to know; thanks. I had assumed the opposite was
> preferred (if the combined patch was fairly small) to reduce the
> amount of mailing list traffic.

mutt(1) can show and delete emails faster than i can scan the subject
lines for keywords to see if they are interesting. So the absolute
number of emails does not matter.

For most reviewers, it is not an 9 to 5 job. Reviews get fitted in
between other tasks, maybe while waiting for a build to complete,
drinking coffee, etc. Small patches which can be quickly reviewed are
more likely to get looked at. Big patches will get deferred, and maybe
deferred again and again.

So if you want your patches reviewed and merged quickly, make then
small, good commit messages, obviously correct, and quick to review.

       Andrew
