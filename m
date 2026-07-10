Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDB1DB13A;
	Fri, 10 Jul 2026 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688534; cv=none; b=a5u+puGEElgucZjGghWkuGj/X3G45dQ4vPlhp8KFxAr4+6H/kh5EFpRcOtCWFUoxoGjVeTuiaAuZxJXx/cYWHlemIcoYN1Kd2EIu0PCaV2Z6VzjAl0Dg6eSKIQk0CJQR+cSdnA0IadIXtx/+vaJAZM7i5e8ZqV1e4pbXZMar4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688534; c=relaxed/simple;
	bh=ujv/DaGIPKZ0TNBzP/JAa8ZYnKDf4vXoekQGvDKezHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaxKDHUoU7R1RkwKcO4qNGYoNeTxXhNoPe/wvrGaswerjZTTxx6/xdQjcQRFhEeA9mJDIh2oVr8R5gK5/tl+ODfJtSVEQfXTaUXW0/UttcXcXDROjdrfPuEwih9Q85MtLBxgKTK/he4RccAMbr/jDqCGYl/V9pjIknanLBWXKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4MtIaqt/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4MtIaqt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UAwFrjTBDerGbH6KBvfKveLxNipsm+/aKm/Antmi/Xw=; b=4MtIaqt/OHUnv4FNhdZMAes09q
	8x/1HBDnP1XzY23rrRRh8xHiOJFeey6gX7Ylv5I5a1800IxUPRhnjkwiJcjOUBNGvSm7rl2+1DBsl
	CBZL831CQuVBpzX6mjB0/1Y1tPG8SP8JW2bCP0R+Pq7e2nyRrayIyrV6WABuTDwZNDHQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiArb-00BdtC-4e; Fri, 10 Jul 2026 15:01:55 +0200
Date: Fri, 10 Jul 2026 15:01:55 +0200
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
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
Message-ID: <a6c19002-ae04-4baa-bdd0-65bba6bc501d@lunn.ch>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
 <20260710-mv88e6x41-fixes-v2-1-e23654c65aa0@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-mv88e6x41-fixes-v2-1-e23654c65aa0@padl.com>

> index e966e7c4cc5de..aca64fd4cb95c 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -165,16 +165,20 @@ struct mv88e6xxx_info {
>  	 */
>  	bool dual_chip;
>  
> +	/* Has a dedicated ATU FID register. */
> +	bool atu_fid_reg;
> +
> +	/* Supports PTP */
> +	bool ptp_support;
> +

Moving structure members around to make it pack better should not be
mixed with a fix. Add the atu_fid_reg next to other bools. But please
move the ptp_support in another patch, sent to net-next.

> -	const struct mv88e6xxx_ops *ops;
>  
> -	/* Supports PTP */
> -	bool ptp_support;
> +	const struct mv88e6xxx_ops *ops;
>  

The rest of the patch looks fine.

    Andrew
