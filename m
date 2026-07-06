Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B13148D2;
	Mon,  6 Jul 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343156; cv=none; b=hyVuUzq3l32Y2yyDWuNzwWvb3TtzGKCYW4D7EShkxcbZFc0mrxKSPyL0Upsbqqn8hLtIIpowy6OLRioMHQudRWM9F+GFfX2PaTRftIE3BLSkYCVQrmKuAflK2LI0tn+0T9aWcrPJppYdj7BPVZnqzHEj4unYZYrgsvRoaPlIz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343156; c=relaxed/simple;
	bh=0JRF6pjUj5d8QSrg3bZcE9Up35qIgC6WmylfO3zXQC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Dfj3p7Pj5dZY4xz8TQ5L3LhLN2hp5EyKQOeXh9oTowkf8hqNYK19DMcU5vVC+P6TiGOYqmZ71Wrlp+FzqD08Ou/v+kT2lcbSNk7Uw2Z06U0yBBJAhkswLdHHheNYKxwvF4pAtkYrF5epApE2rXUDY/Aa07WO3lnIS9INefJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RMTFBHbG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RMTFBHbG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y+pk/mW8eLnzzZmnqNJ2g7IkrDk/Lltl+XLEOpMObSo=; b=RMTFBHbGtnsEc8S4mJTd3Vx4Db
	HKJe6lEynWCh2wcdMXJ2ifkehtd5WLtDEwBZKjGZBbBLbCuqJfgrbZS1vwTDfn0Jkkh2Fa278Blq8
	ZwzvWXhYe+nd8zZMq/BC2DRXwM9E7IWP3hXSgLTYH8ed0Zl3qjgZPgRMlZy/rkxljE1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgj11-00AzT6-RD; Mon, 06 Jul 2026 15:05:39 +0200
Date: Mon, 6 Jul 2026 15:05:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import
 style
Message-ID: <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>

On Sun, Jul 05, 2026 at 10:38:40PM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
>  drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
> index 2d24628a4e58..5a21fe09bd62 100644
> --- a/drivers/net/phy/ax88796b_rust.rs
> +++ b/drivers/net/phy/ax88796b_rust.rs
> @@ -5,7 +5,12 @@
>  //!
>  //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
>  use kernel::{
> -    net::phy::{self, reg::C22, DeviceId, Driver},
> +    net::phy::{
> +        self,
> +        reg::C22,
> +        DeviceId,
> +        Driver, //
> +    },

A question from somebody who does not know rust. Does the order of the
elements in the list matter?

Linux has a pattern of sorting multi line lists, because it reduces
merge conflicts. Can this list be sorted?

      Andrew
