Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E818C008;
	Mon,  6 Jul 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346307; cv=none; b=WpB3CekROlZ269di92V+AM2KFjSa9D7MqJczbjHqBtNlM/WVMZJK65nyKsH7CwT7obeCeVUCtGJzzEgAKwD2py9lkLKN2RQMMgv8kiYrp1TemfVTseGlC4sLE6nVkguUbfi4cMUwjK9o7AKLNCqkRfRKhxg3tBWbCZ1z14vPwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346307; c=relaxed/simple;
	bh=lkAFaYGEao++IKnSzYgKo6EJpcZg5F7hSxyK4imz4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiWZo+bBOvaTEpTLSIWLAFc0McgRdIjawA6bMNapfdE0Hwgm1psXrBUQjntU6jZqfLy/j3BroP1BC5QphIdfx7cgr/nNKbOnjFcul3ptb6dDs2UGufIXDYIR661PMXhkGlHw762XDWq8m08UpDhX+LT8u8RtzyUt4REW1WBYprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wuJTfgQ4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wuJTfgQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GHUWA0+7peyvHO+iBsxA1/V10pSUVW7Kn735d4eyL10=; b=wuJTfgQ4rHweUj4fRL8yDFGf/r
	WzBjcrN1em2lx1b+9DbcNinyXfALxV/J08I7agu3zNqStHokQmjEnI10eK8k507VvPyZookfOPZEe
	zLqGdtggCR90KQH3HL50zdacwCGeKWggr2Fa0mV8aDIPAcSQqbm7JW7K1vWvRkAUNaus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgjpt-00B03A-1A; Mon, 06 Jul 2026 15:58:13 +0200
Date: Mon, 6 Jul 2026 15:58:13 +0200
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
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import style
Message-ID: <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>

On Sun, Jul 05, 2026 at 10:38:41PM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
>  drivers/net/phy/qt2025.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> index 470d89a0ac00..efde3f909367 100644
> --- a/drivers/net/phy/qt2025.rs
> +++ b/drivers/net/phy/qt2025.rs
> @@ -14,11 +14,17 @@
>  use kernel::io::poll::read_poll_timeout;
>  use kernel::net::phy::{
>      self,
> -    reg::{Mmd, C45},
> +    reg::{
> +        Mmd,
> +        C45, //
> +    },

Given the comment this should be sorted in 'ASCIIbetical order',
isn't this wrong, C comes before M? 

	Andrew
