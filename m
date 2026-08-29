Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E63C37A2;
	Sat, 29 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788019028; cv=none; b=OUT8PregSBQfADb3BxyA4L3Ek1OJUmCIuIC+08Cb07TW/AW16Q3F7qLQBtqtkv+M99hbd8YK+mcIIJS3dHg8GqqeSURtwKU1ixViIeg6v44BkvbZAB6FO5uj2zsTqRS2qDWeGnq6m5LkIG8s4bmj9a8hkMDOkrp7++zuOAJXzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788019028; c=relaxed/simple;
	bh=HeCXmdkgRFbDezLSHWSl0Pwk1Bc2zb0lZwKQ/W0UEVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prnV5oIaE2Dr0rlchZjWYYLQeWZxjrUdengkHMpx014g0fGRJr7pbaV0DG5KMxiw7uyWVeQHciH3MwVe2s5aX8J7GV3deIXQ605UjLOTJkXnOcuSGAkzuUv7XK/xXjlFJB479M7Y6KSx66Fj8OQWSA+PoSlWo7zE2HuTP2nwLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2tjMpSUp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2tjMpSUp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3EqEssvX4y3oKC26f8RzZt874lyrdjRDqGiG8St32LQ=; b=2tjMpSUphVTxVDM/4As863VXtL
	tMqCzKQXzq6YfWKp5LfTq1UK6MvxuMtFEAdbVJxelz0IBzKA6NE5OXIvvub8JZLsBLMv6+pJ+6hub
	VAbZE34MdFruBDZTUNNfNQll0n3EDmlOmMqXnsfysZW7WxyVvlv7Dyggp0br80cfRspY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x0LQ9-001wv6-T1; Sat, 29 Aug 2026 17:56:41 +0200
Date: Sat, 29 Aug 2026 17:56:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org,
	syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net] devlink: request flash firmware without instance lock
Message-ID: <007f4b52-f19e-4b7f-b9aa-6002b3213423@lunn.ch>
References: <6a908733.1d9ded08.62e62.00d9.GAE@google.com>
 <20260829142525.3900565-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829142525.3900565-1-miguelgarciaroman8@gmail.com>

On Sat, Aug 29, 2026 at 04:24:40PM +0200, Miguel Garcia wrote:
> request_firmware() may enter the userspace fallback and call
> try_to_freeze(). Holding the devlink instance lock across that call
> triggers a lockdep warning and can block unregister for the duration of
> the firmware fallback.
> 
> Drop the instance lock around firmware loading in both flash update paths.
> The callers hold a devlink reference, which also pins the parent device.
> Recheck registration after reacquiring the lock before calling into the
> driver.
> 
> Fixes: b44cfd4f5b91 ("devlink: move request_firmware out of driver")

Jacob Keller was the author of this patch. It would be good to Cc:
him.

	Andrew
