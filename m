Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591873CF94E;
	Wed,  3 Jun 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489535; cv=none; b=mz1EoFNZeGIZ43WiONixGK/eSpwAreJdkJ/J2wR+A9y+9JMBeSO9BtdyQSu6kLVH2KAYosfRNyJ2LYO5XBtlddgmHO9RU3Sg1v4AIlFihYg2H+X0caFCSox48/RtyihTeMXo/ugg+pwixe2ODc55gMh+XEyOO9JUTvThd8ZbrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489535; c=relaxed/simple;
	bh=nv8RFHB1bk058g3Pep+W8gYkHjr7zBTtQ5peOwCoXzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3czbnWau/dPQELuWasKHj/G0K5c7s9bMzp4AVTjAcQygh4CTlb0QEMrahDjmzF4SRVvS9Bk24BDej73sKpV5yW0tAlMkfNdsGJk863sJBPL8mpGHgPgfkxbWB9A7eIk69GX690nyb9PRW2CrLb+1NjK6Nd/fb0f9OHKXDhPPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=huHWvXEm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="huHWvXEm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wspG7vULJdlXyrP1LmOsjb7L6AhxYdvNVoxhxQz3yCI=; b=huHWvXEm/ON1ldWcJR/Q6IDPzr
	Pzz+f7WBsyikHVdeNRaT28kPxUWymxbJfZCdmw8uRAvUosdMrRGjL6oeG8gAScUFCdFoBCj7h3m42
	Hqb0TomeW/Uu57RpBoxO6ImHY+PJDBe6UD/2Lr2++kI3sB4jbZPDOCD5a8RDme/HaC0w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUkf5-005sHE-Gq; Wed, 03 Jun 2026 14:25:31 +0200
Date: Wed, 3 Jun 2026 14:25:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format
 specifier for MAC addresses
Message-ID: <c6a2aadf-af29-49ac-9154-2b014f4288d1@lunn.ch>
References: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>

On Wed, Jun 03, 2026 at 01:20:11PM +0200, Andy Shevchenko wrote:
> Convert to %pM instead of using custom code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
