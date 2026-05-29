Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE434FF55
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017191; cv=none; b=OsJBOJLFGzMBXydFPJlON/goO+ooGDp/XiItf1mA5cK73st0IDZfRkMDpnbHjnAJaA2jGke8nzezjEvfXitirfKlllUGwD5Ie5bi7BeYpk2XUiiyF7AEp/h2QMbTS58XV1eeDeF9kpb4yCWBrI6y/Jiwi56pGO6irh0keB/carg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017191; c=relaxed/simple;
	bh=8GEMGyAGKy6UVJva9PZGktFdqT8EsP2nwE+Mr4iFgd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3FL614jINsua6fm2GzqdzsadDyrFtLLZaIaBDlAikFiB3ZlF90DG5IqTfWciRv1uTdk9KygmHZ8WK8Ut3ULnwBG1S5JE4wi3d6U1ueFQBqWNjb5ZRWw2eeHEGhmpAenzQ/i9ruGcof5vmpEfDFNNc3cR7EhH5tonm5/wewmlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pecXuBZB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pecXuBZB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TtMR/xDnpmU/Akb/Ar8zNkXGVM2z428HeWHqW6yjirw=; b=pecXuBZB/8O/VKFzBkY7m9JyBQ
	pQJ5Z16B9iHVaE46t632CayQW3LH/qObjJleH4rgrk/hE2n5q5noXFTZnapk3ksRN82BY92DVfuHj
	NBuLmGB7afwuMa5RbxJnXn/Ugcdb+O1z/ukFivnBOwtBh4QkQ481b66zB/MsD8tintac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlmW-004zNH-5Y; Fri, 29 May 2026 03:13:00 +0200
Date: Fri, 29 May 2026 03:13:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v2 3/4] net: mdio: realtek-rtl9300: use command
 runner for read_c45()
Message-ID: <9138c28b-25db-497e-9230-b254d13d6e5c@lunn.ch>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
 <20260527163449.1294961-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527163449.1294961-4-markus.stockhausen@gmx.de>

On Wed, May 27, 2026 at 06:34:48PM +0200, Markus Stockhausen wrote:
> Convert the read_c45() path to the new command runner. This needs the
> additional helper otto_emdio_read_cmd() that can issue the command runner
> and process a read operation. It is basically nothing more than
> 
> - run the command
> - read the command result thorugh the I/O register
> 
> With this in place convert the read_c45() like the alread existing write
> C22/C45 implementation.
> 
> - bus calls otto_emdio_read_c45()
> - this handed over to SoC specific otto_emdio_9300_read_c45()
> - the registers are filled
> - the otto_emdio_read_cmd() is issued
> - that calls the command runner
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
