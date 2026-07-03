Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7D3CF1E6;
	Fri,  3 Jul 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091652; cv=none; b=C8a0P1l5uZhiC0vcMv/HVEvwCwTdf29eMvebb3c7S2nP4BNqXuHCL6BppI1AqbiDra3VOAV0jsrYTIt/0r3CbWCaczqshn5rqycxuEM4PN6Jz55y7RwiRUcp3U9DDblkOEJxORmpR8crW2XgDBGI7Oy8yw2pj6RdHtDehBWq+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091652; c=relaxed/simple;
	bh=muoDBVb30i/LzUXr0aecYT85wNLUM576y2LEmP9/nx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIq+l8CqQBbYWT81I3Keqsbm+2JK8y3Ms3imxicFGeH/SD44Wdy+SCUeRQldsHyDXM9U14MP32NDv1E1OUq1n52IZ/YDZ5SQuP6gaEc1UlIQwUkHbxdwIk4S1gweNN058QJRoxMrCB8W6sLcrRUMKV3P18iCjEOvCoNth9xjVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jn72/StC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jn72/StC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+gUd/Qe5lhYfBr9eSOJwdE+oaLRr4FALIBakhhhkTDg=; b=Jn72/StCqPObePXHtCPT4MA/S5
	DTt1BXljnPMdAKQQKTuDAXmD1fGdEOMeavlLG8sz1/Y1RyNg87rTViYvut/Ym9rI5DYSbIi6ZOA7s
	SUejdR2YwWJ8hai4BjmdfFLZyyzLcke5UjRJVOOfBLWdhY/wWDO54cZ++60zhAWy4i3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wffaY-00AZ7B-FM; Fri, 03 Jul 2026 17:13:58 +0200
Date: Fri, 3 Jul 2026 17:13:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.dea>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: embedded PTP timestamp
 support
Message-ID: <6cc25a97-3702-42d0-a667-11494bf5cbe6@lunn.ch>
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
 <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>

> +	/* Arrival Time Stamp Mode (ArrTSMode); see the ArrTSMode encoding in
> +	 * hwtstamp.h. Zero (the default) leaves arrival time stamps in the
> +	 * switch registers; non-zero embeds them in the frame, either appended
> +	 * as a trailer or overwritten at that byte offset past the start of the
> +	 * PTP common header.

So how do you indicate trailer?

> +++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> @@ -8,6 +8,8 @@
>   *      Erik Hons <erik.hons@ni.com>
>   *      Brandon Streiff <brandon.streiff@ni.com>
>   *      Dane Wagner <dane.wagner@ni.com>
> + *
> + * Copyright (c) 2025 PADL Software Pty Ltd

It is unusual to add a copyright for the passed.

    Andrew

---
pw-bot: cr
