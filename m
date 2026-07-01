Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2F391E51;
	Wed,  1 Jul 2026 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931310; cv=none; b=Y3k00EniC6YalyjUoMpI8x6goSQLfMZFUlhy7u+akHgmEsN6k3QKDo/TvMqybKUr06Ez2uuXak7C7+2Kee83mAvX6wZfVv4BepAena1v1zIWX7ILW3Qac5+lyAofjwYgEafYfn5C/GIwfcEJ8gtbOe76gbWMSRyEtrPbmFHHBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931310; c=relaxed/simple;
	bh=fWQvVlHdtvTnBbU3mH406//UiA1TLCHxPt3hSDQR95o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVG2R37G/HrTdSTjS+uSLQcu/wNwLIndKfw9eJ94Sdo2Keht9zAbLuUKpX6NYx1ZGMUXySiWRjAdvbOz3KHbi4/BoqUwoVEQR5MoF/kN8hNJre6s29lV6uQg2iXL5fz0IGtweDybKP3shlCmAz/JCR6WXjty5HWDsPN0eX+pwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2rnr7tfR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2rnr7tfR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OagXRuNl2G1lDqHet7J7RIKmiUkCcPy54Z5NexpB9NA=; b=2rnr7tfRYcYSJEYvlFWR6/SjKI
	UsmdlOQHAmkJqT20AXJg7LAZw6D7vjUgDIM1FRiw7Ov7DzXdiEhd6eiAgWUr1zBVql4yoD10PCmz2
	VlVfmunufoHCwg9q5G8jgGh8/+0l+Cx5IiMH5HhlHiZJN2Prui4QzWml9tyli3Ach1bc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wezsR-00AE2E-Mv; Wed, 01 Jul 2026 20:41:39 +0200
Date: Wed, 1 Jul 2026 20:41:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause
 parameter configuration
Message-ID: <d4825084-f450-4951-bf26-79b8e4db8e8c@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
 <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
 <3cc16d45-7b6d-4fb0-8a7b-d6b4d53ab036@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc16d45-7b6d-4fb0-8a7b-d6b4d53ab036@birger-koblitz.de>

> So, I will give phylink a try and send a new patch version out. I am a
> bit worried because the PHYs are real divas, getting them to survive
> a suspend/resume cycle was a bit like herding fleas:

It might be having PHY drivers helps, since it is the PHY drivers
problem to handle suspend/resume. The code is then cleanly separated
between drivers, and one should not effect the other.

	Andrew
