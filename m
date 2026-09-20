Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94593859C3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789916197; cv=none; b=T4z6Sro3CjzN/RfnV/rOtHlaMX43P5HXSFv2+8QP9U2p4RANhDsa3gFSR3I3etwkIOewZ9VK7SWjD56IaK53TqEW3yQP7P8gWMTCQ5HlPNimpLwevNk2IlRZKjrJ1QqH0CDv2YqRDygxYiqVvW9b9r0KKvYNsYYCh0VFTu2r2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789916197; c=relaxed/simple;
	bh=eGJze0nH6h+3Hwgl6OL6KCSyHnDdiTya01pY0aKUVk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjVyZTJEtxZe2+mVtkqNPGZb6gl6oq0Vcg8LfwbvljbHrLkWqG4ZUz39VUqp2MIECFXj52cKcgSlvW55OGE7yC1J/A7FlNpK+oz5cVFGywyMCSqKjT/wC7xpZ8h7cFd5WbDhHvnYkoyOgfGQXx5DQquSA+mKrwuAVF/nBHk7gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6QVmV360; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6QVmV360"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t46bK8APOLWejh55S9/08atEb3gYVCjGk8btZc0o1dU=; b=6QVmV360HYQ1BqWuo89l9TQXp7
	IT1mb2quRSYFgL7J55C3MWsk1pHBTWfpPCz9eBubd0v9KjJ41UwcY+HENn+NL1LE2E0oYeCScaJoZ
	ePYrP+HOSfSzPDnUCE4/Fx4OvQRjHWjeba0sllMKMRjjDtNEP6mfFQ+q8SzuyMnHsUOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8Ixs-006ARX-8O; Sun, 20 Sep 2026 16:56:24 +0200
Date: Sun, 20 Sep 2026 16:56:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/3] net: txgbe: keep MAC enabled for NCSI and WoL
 for SP devices
Message-ID: <0b4c65e5-b2c3-4c8b-9db7-d221ffab6ec5@lunn.ch>
References: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
 <F55611137A66BAC3+20260920085114.1062503-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F55611137A66BAC3+20260920085114.1062503-2-jiawenwu@trustnetic.com>

On Sun, Sep 20, 2026 at 04:51:13PM +0800, Jiawen Wu wrote:
> The .mac_link_down() in phylink callback disable MAC TX unconditionally.
> This is not suitable for devices using NCSI or WoL, where the MAC needs
> to remain enbaled after the link goes down to support the corresponding
> functionality.
> 
> Skip disabling MAC TX when the subsystem device ID indicates an NCSI or
> WoL device. Keep the existing link-down handling for other devices.

NCSI i can understand, but phylink knows about WoL. This makes me
think your WoL code is broken. Please review it.


    Andrew

---
pw-bot: cr
