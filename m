Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1247FB19;
	Mon, 14 Sep 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403463; cv=none; b=lukPiCNc2KWM1jijRRwHAjHHJk3sv5DQRfE9ZIKQ0gNBF/gzAMwV3n8DtQEZLw8HnCMDarz/X7p/lrIRIYeM/Uc/hYUO3W1D6K6GB2rz5BRsrDjzDo150KVQ1olIPenGQcxFCrF9la2/A6KHXAq1Ufw7AoR7JjGKAZY3GHZS+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403463; c=relaxed/simple;
	bh=LKuTqMDdJPaZM67BXIxFb/9FzE5q2YyfLbZDlOiBX64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJU/GQCNz8liw05ca0Wzg+Zn8YGJ1ujMMyG2p33FdoZxXYGffG+Q3V6zUdKqJqyPkeXPPbmUtvFi92cmjEFLuWevbeza/nJRI4Qw+aSqZjoD/R5O1ZlzxBKovGTmiQfx/uSpGJHW9U9/UfdTRYFco/8mIYR7ksAq0X4mEBjmCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dLcC5hW8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dLcC5hW8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gnE7p0PUnlywMk71Ol94qSTg5kyIy8MxfbfvQTLt0Hw=; b=dLcC5hW8WjrpC0vNR5y/Y/q8oy
	e3k7X+NqHVxvWWkGfQrwYLYV3K1Ule6dKsd9l/o2L8WC+Vxi9v7WQRvo9RiHeNjQpreVbqXJahWb9
	RlC3ONcFyH/GNBWk1xBZnQAEnSGm6UhHsNRO8ATKN9BTQT41aOs5r1ACXypa3UBJH+1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x69Zp-00574g-Ds; Mon, 14 Sep 2026 18:30:41 +0200
Date: Mon, 14 Sep 2026 18:30:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] net: mdio: realtek-rtl9300: convert
 "fwnode" left-overs to "of"
Message-ID: <e43b8a30-2f88-408b-9d3e-90ecaf063ab7@lunn.ch>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
 <20260912130451.3757276-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912130451.3757276-4-markus.stockhausen@gmx.de>

On Sat, Sep 12, 2026 at 03:04:49PM +0200, Markus Stockhausen wrote:
> The latest developments of the MDIO driver consistently used the
> "of" API. Convert the remaining "fwnode" left-overs too. Also
> align the continuation line of otto_emdio_probe_one() with the
> opening parenthesis, as required by the kernel coding style.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
