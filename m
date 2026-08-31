Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC01EB19B;
	Mon, 31 Aug 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185769; cv=none; b=PXBE6MbMz5FBrhBZwsr/NW3gqxDe+qS7SxUZc14WFRuVTfzF9Kf/Y98MA0shb3VIJlceJLU+u5s5KM6soj/UAG23glBXIrxaxE6KAJGve8325ZIKGI8WdZqi7B/a+ymos9C+qaEXexFPX7IQc2nYQm3I6wUODx7s4PHYnZd8lXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185769; c=relaxed/simple;
	bh=Q506UtALJZDAwaCQ+XsBK9zNZIsBs96j+jJ1hn9vNpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F85yTbB0apNJHEtRlmwWCrdnIosiEegT9v/8zI2700m29QfqWKQUpMrblJj4A0xyfGUVoY1AGz/8ItjuySf4qA/E0QyK9bq5CyDPBmhlqcUc/S/nWAMUK58Vi0GapGxVxg8bquqTwIL7Hc5PBVBIZyYAakpSqIpMvACxEnU0FGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gn4EsTb3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gn4EsTb3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LoVdAEp4Ckg0U5ae6E9TaW5qVUi9bps+Kh35frHLA5Y=; b=gn4EsTb3fkTaJ3pfhG13CZCXS3
	6BtIgbuyhsIuShMVX0CbQHLYUOI+/66mMNDeuqS5ZY5LmnaykYJw+YKRlrOpHFTmWWxobuPy6stTu
	N3hhYeAae7WoFM9pmmKBfMDcfg1s89HVunj/SlbH5JjpRImIb86Mc38q9MU4CM9R+wsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x12nh-002C7W-NM; Mon, 31 Aug 2026 16:15:53 +0200
Date: Mon, 31 Aug 2026 16:15:53 +0200
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
Subject: Re: [PATCH net-next v8 01/15] phylink: Add phylink_mac_interrupt
Message-ID: <f2a35a86-66d1-44ed-b0a6-28b4269bbb94@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-1-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-1-de905f2ee426@birger-koblitz.de>

On Mon, Aug 31, 2026 at 11:58:50AM +0200, Birger Koblitz wrote:
> Add the phylink_mac_interrupt() function to phylink, which
> passes a link-change interrupt received by the MAC to phylib.
> This function can be used by drivers which want to avoid
> polling the PHY and instead rely on an interrupt received by
> the MAC when a link-change happens.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
