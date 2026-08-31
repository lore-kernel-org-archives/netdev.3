Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333B4B04AD;
	Mon, 31 Aug 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186097; cv=none; b=sWgQBLg/aPmbJbtaB1G/OPfwVE+zHfA5DqQCh0EbNagROOO373yqoBNw+KTqFl808El05o6IMxLhAp4Hqo5DjycNRHwtDI+i8BxLyC1OR8wZ6X5Loy7m1oLjo40heOXkSwA0c7dHe+hiVB650JBVhS1Qoqqp9zj3IVTyUzgYBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186097; c=relaxed/simple;
	bh=Cbj4SmL/HmFlX0opMeV7rymmt8ClbofHkHft1OaL008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY1QOb8p11baQHYLeiuV4/wE6cnl6dfFD5dpHvXIdbtCNcRsu41B+GJSWgoneEmPUqysmJeyuv7M5tHndjED5K/nt40DQMXq8Qzhf0qLCreU7Fn0JU3bEYuDq+0xgMPrIiMCyj/75iasohOso7f1mxN6Ws/U6+E/W/NJqxOLd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5ENMEaZ3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5ENMEaZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=op2r4VuirEnMC3u7dv/vw63MGr9eicbsiUQlpuqsjoU=; b=5ENMEaZ36ehEG3/oe7nqGeYtpa
	nVN4siXXnkXp9v6uaQId2Pg1SvjqdIzH46vj/hd/WE/iIFKB2FAQGu8c7jAJLDCB3T6rgxdNf+ogp
	tRE2VRlT7i0o6Jso8FY9mmTbkjg+T1swbgQ8ybECF49A8bepHCBD7rJ6rQLHe8I4p7PU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x12t5-002C9P-NU; Mon, 31 Aug 2026 16:21:27 +0200
Date: Mon, 31 Aug 2026 16:21:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v8 02/15] phylib: Add support for PHYs with
 broken forced mode
Message-ID: <64b7b1b3-28a0-41bf-b32c-1d1ce3c75033@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-2-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-2-de905f2ee426@birger-koblitz.de>

On Mon, Aug 31, 2026 at 11:58:51AM +0200, Birger Koblitz wrote:
> Add support for PHYs which only supported auto-negotiated
> speed modes. This prevents a kernel warning and stack-trace within the
> phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
> because they do not support forced modes.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
