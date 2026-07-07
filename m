Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FE3F99FE;
	Tue,  7 Jul 2026 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427244; cv=none; b=jpeYYa3eZR3MXsEedUx09W7yElgrQHnhCeiKebfPx6CilMwD8PK8ElVNPTMZCyU+WFvbjVewlFTxgt2E0CFZxjzWFkxPOSS4YpVNHoXTKC6rFHfKBmsMBXy8ceU0CKlif5gJzBcBECB45nlFYyR39mH4f41hle25QGtuDZwbuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427244; c=relaxed/simple;
	bh=2DKRCY6Yc4S3DX9Pjz0yjgSyUaZ4g5g3XzjHNn6v0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq1OqDeUzOIhPmK9CM7QJyEkImUtyBdBuA1Jdm4IfNte/ctB06gRIHdQBpKj1mwOIctuHtz6n/DcHl/ap18r2nVNatAtH+kYOy0jkdQOKeiyUdGwIAOfiIle6l5bQiPdBy8Tega9u6GbR1Xk23qKqXns44Z++82e0uaxzqsnN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Jok4qZ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Jok4qZ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1nkGtrcQiWcU6y5rHCmOwkXl2B09jKLFjYM2ku6mbSU=; b=4J
	ok4qZ2h45gQOE5dxHgG2r89hQpJKi9q4bBe2vIrWcksBObTKbqhN4u7FOok3F+b8pP/ZIVyvRrdE1
	HH149yH/RplbUXomN28MpfGjlVmn8EYZidcTuXoAYk+unoOvY3uvtdjLtQ/V+iBIbP3lqKxj9wQHr
	jNAyWTBO6lQL6Vo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh4dc-00B9mg-I6; Tue, 07 Jul 2026 14:10:56 +0200
Date: Tue, 7 Jul 2026 14:10:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <2f07f731-0b97-4a23-8ccd-f01638fc1c7e@lunn.ch>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
 <akwToZyYvHZPtdjV@monoceros>
 <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
 <akynGw4TQimFiQST@monoceros>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akynGw4TQimFiQST@monoceros>

On Tue, Jul 07, 2026 at 09:15:35AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello Andrew,
> 
> On Mon, Jul 06, 2026 at 11:28:33PM +0200, Andrew Lunn wrote:
> > > That's exactly my thought, and there is commit ad428f5811bd
> > > ("mod_devicetable.h: Split into per subsystem headers") that is part of
> > > v7.2-rc2 and that does exactly that (apart from the filename).
> > 
> > Ah, O.K. net-next tends to great dragged along the -rcX versions. So
> > you can probably submit the networking changes in a weeks time. Just
> > make sure they apply to
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> 
> Note that while I created the patch under discussion on top of -rc2, the
> justification is also valid on -rc1 and the patch doesn't use the new
> headers, so it can be applied to the above repo already now.

Yes, our patchwork instance and its CI agree:

https://patchwork.kernel.org/project/netdevbpf/patch/ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com/


but i was actually meaning the patches which swaps to the broken out
header with only struct mdio_device_id. I assume that patch is the one
which really reduces the number of files which get recompiled on
unrelated changes. That patch can be submitted to netdev probably next
week.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
