Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72094346766;
	Sat,  4 Apr 2026 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343484; cv=none; b=DUKh6zjgDZxuzNijM9S8K2wCDEaHfVRT8dfL+fY0KA4osL3MBYJj9ER3u0OfFY/scBJmn/dW3eqf/IqOJu5Wpem9879HsCXDG2Qkoo2pIJP3HGSkBn7uXKr2a3KZDcqBnS2gdBTbRxnHnim0vJ65c2Bqc+ntMbdftE6iiZFxMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343484; c=relaxed/simple;
	bh=Rq7DIi64uKrmqdoFE4tGl+Z8IRbgMKFMFPetdFcVoqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1YM8aryIn8eXJx8IGmERjcFcpV7B7Jf4hHqdVmEfTZwZSU2+XD9huTTefzh3I2nOiBZr+gDTpPy6COT0hhTt+BuOZ8p1Lzyz74CqDHcnt9zH7kaPiwBl4GJeXayfhQcBZrxxslCm/AZ5tv8s2dmWsCR+AxEtAp/4LZpZru1WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GPV4cmJC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GPV4cmJC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uWFYRLtXvi/KHM0z+xTR3W5M/A1gg25CbR14JLehmFc=; b=GPV4cmJCz4eCqHFVw38J8zh493
	vRLqaDW2ZYofoqvmYTWTSZotvH+EaHxlEI3LNQfm1BZlTZsYtfZZZo0+NnfbMNNfdEiRNjV/VDeYD
	SgRvcBB3hnFq3RmnETO9pNZO/XH4WSpjdwI476iuaqwh02bDOXJnp8UWqENtWQRO32W8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w99wA-00EonL-H1; Sun, 05 Apr 2026 00:57:54 +0200
Date: Sun, 5 Apr 2026 00:57:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <6d5d6483-9c39-4b1f-9372-3a3b7749bd53@lunn.ch>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
 <adGSjRScv9tcYRoU@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adGSjRScv9tcYRoU@google.com>

> Yeah happy to hear any input on it, the controller actually seems to be
> a designware IP

Ah, interesting. Ideally you want to use the existing designware
driver. Take a look at txgbe_i2c_register().

	Andrew
