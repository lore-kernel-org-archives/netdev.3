Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D587333730;
	Mon,  4 May 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899426; cv=none; b=WJDs5qaso2MPoCfzfTGBRxahnRp7B+RXByZfPIwGO+ZkmLl4H8MPnKrsEHWy+ufszpTco8vT445yVS9qV1TNbWdHarmdYcQhJw5a3UfernwsOYdWtJ5TOrIxOcDHZ2WIik15HZnIo/Y1kSiHa1J+1A5DrwuQnk4h9idbI8zmVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899426; c=relaxed/simple;
	bh=EMtw5q2Y3rod4LkjP2d/0okxaGgbp2FDWTI8fSJk9+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSeKPVkxnhgy1x9jPkMotQPJFGjHRy7/ttZSmtA8y9NMQevWaewdcUNGy2qnNA9rM67/cKcDc4cA3/DOGuauYyQLLdLlH/Wuz0u1SxcbiiUYlafN9F0I6dFJoYOhjI5IQ/XLkPre7Ur9BiyG/t1sjObmcTl5I+csm2vomqTF1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w7pAD9Id; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w7pAD9Id"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sf8GrloyhDcDE0JIcXxVsYAPHoYQg8R8OEPXBypIWtk=; b=w7pAD9IdOiU9ws7Vk7/0w0jJDK
	gNWkzXN+gg7jRKD+2XD79IoezU1UTa7QePCmPJyOWTJfhWO2Fk0IxFYmi3WMdwtVGRIN+ECvnxv6f
	yisuELJ2BO8yfV1hWy2U7IgWl0Qw2Ltd0OS98JKa3Eh2C4tmpVX4JQgFL4bLgUlyQlOk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJsqy-001GIp-Kw; Mon, 04 May 2026 14:56:52 +0200
Date: Mon, 4 May 2026 14:56:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Carlier <devnexen@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: E610: do not fill EEE lp_advertised from local
 PHY caps
Message-ID: <2e4cc698-70da-4305-ad0c-b5258f029daf@lunn.ch>
References: <20260504062257.77460-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504062257.77460-1-devnexen@gmail.com>

On Mon, May 04, 2026 at 07:22:57AM +0100, David Carlier wrote:
> ixgbe_get_eee_e610() fills kedata->lp_advertised from pcaps.eee_cap
> returned by ixgbe_aci_get_phy_caps() with IXGBE_ACI_REPORT_ACTIVE_CFG.
> That report mode (and the other IXGBE_ACI_REPORT_* modes) describe the
> local PHY only, not the link partner. The X550 path uses a separate
> FW_PHY_ACT_UD_2 activity for partner data; the E610 ACI has no
> equivalent.
> 
> Leave lp_advertised zeroed via the existing linkmode_zero() and drop
> the now-unused ixgbe_eee_cap_map[]. eee_active/eee_enabled are
> unaffected (sourced from link.eee_status).

Hi David

Did you test the EEE autoneg capabilities? Is just lp_advertise wrong,
or is the negotiation itself also broken?

	Andrew
