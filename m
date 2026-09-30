Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E44D0A0D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776737; cv=none; b=npJ1QPyXBOqiJ4jwWucBLYPDuCYcvIC+jgYaGyZY1/heEVCrmI1zfm1tkOsn7wGAlRXTJ4Tvj1llHUXjW4+KrY6EhY4YT3y5d7ukFv3qjVqHM2mEsfdS70du7PhgjgvbB+T6sAiIUO3CnQNFiu757W0KsJ6r2EC8WeOEEQpSYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776737; c=relaxed/simple;
	bh=hS0TU0s4bS7h9cgUDINh849W6hQxsTfFBcFjK2+s0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3j6vAE+sOXN23UunnZLfq/JAzfC3klrv/EUUXIf2i+tCDqDvOGPmKBtVEVWeIKoX7znvePynPkVF4es0SpGmusnAjcmYb6UyjPq7yaegyr3ZtGk39vFizmNegwQ5dfoBdr0yiE0LbqaULkrLVwgPEnQo8XYu/axezR9rusEdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nXXTQZs8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nXXTQZs8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kMusvZ6KpzHKFXeVwZ02ckI3tGEQ/AXWetjsCecASZk=; b=nXXTQZs80kcGeP41iCat9KkyLg
	TwXWUYIzgzfV52fG6acYadQN5XsELZAy3+EVnX64xhsvPuPdKmkYkSPe/g5SEHxXjIhX/9nml+msA
	481w2sxgWnmjNb6vUOry7SwLsvXoLsuyGVkoMYNMSxIAWWGYCmzKgICIij533Hir2smQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBupb-008Asf-7x; Wed, 30 Sep 2026 15:58:47 +0200
Date: Wed, 30 Sep 2026 15:58:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shubham Das <shubham.das@intel.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
	alexander.duyck@gmail.com, lee@trager.us, siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com, dasshubhamk@gmail.com,
	magnus.k.lindberg@ericsson.com, jonas.wirandi@ericsson.com
Subject: Re: [RFC net-next 0/2] ethtool: add interface caps and PHY tests
Message-ID: <fdabe2a5-d198-423a-a9f6-1bb842b8d372@lunn.ch>
References: <20260930132151.932792-1-shubham.das@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930132151.932792-1-shubham.das@intel.com>

On Wed, Sep 30, 2026 at 08:21:46AM -0500, Shubham Das wrote:
> This series adds two new ethtool netlink commands:
> 
> 1. intf-caps-get: Discovers the functional block layout of a network
>    interface. Each block represents a hardware point (MAC/PHY/MODULE) at
>    a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its supported
>    capabilities (loopback, test patterns, BERT, error injection).
> 
> 2. Add ETHTOOL_MSG_PHY_TEST_GET and ETHTOOL_MSG_PHY_TEST_SET for per-block,
>   per-lane PHY testing using test patterns, BERT (Bit Error Ratio Test),
>   and error injection. The block_id from intf-caps-get identifies which
>   hardware point to test.
> 
> The block model uses:
>   - component: identifies the hardware entity (MAC, PHY, or module).
>   - sublayer: identifies the 802.3 sublayer (RS, PCS, FEC, PMA, or PMD).
>   - instance: identifies multiple instances of the same component, such as
>     internal and external PHYs.
>   - depth: identifies the host-side or line-side block within the same
>     sublayer.
> 
> Prior discussion on this proposal:
> https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2

When adding new APIs you also need to include a user, so we can see
the API in action.

    Andrew

---
pw-bot: cr
