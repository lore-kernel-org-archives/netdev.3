Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477C37FF46;
	Thu, 24 Sep 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258514; cv=none; b=jmQbP1z6JGWViiU+J3IWNPSx+Y3aa69U1TW3KwobwgzeVVqD+eVvbDJmEVLl5+hExsrBvUXns20FlZ/rDIVA7AQzK+fOEMZlnCImHxGiaaRp8gR2EvBv4+XZpT48odGEs8zHQkeSOoNiv1DgikGxM/7mmE9znjv2CezDBjl04Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258514; c=relaxed/simple;
	bh=aHsy67d+fZoOnYPBsMFzRDU5A7gYGftdVu+c18ElYBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poc8JRTnLk6BWL8ZM65UIOJTgpth4QG96vkGwry3PVvyUJXhu6Auda4hmBdx5K29Sp0NyrfNTYuzStKQuR1R1Kbv53erVzLZiJUlENIKZ7LH07eKgT45a9NQx3xY/3ggSvngJzC097Al3sS5HA6efVtDsf9v3r6O+qJMytswKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QH/B/57E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QH/B/57E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kXxhkioDddTums+xarLrP2BZOVQtvNgRLMZigX1+ngw=; b=QH/B/57EQyu9H4oYrZV25VryUG
	ySKfXyzuu4LWNeh057dq9X1+xKpx/SJ/2zgsLVIWauC3Td92cy1WWrQbvzaOK3qnvWs6qoMK2zI9m
	wp7gjpyyhVKoEbtqnd1B8tv55qqDcy7z5pr6gPmFkBOPRN3XgH1X5H/4lC03+NQ42Iic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9k15-0070Pb-SX; Thu, 24 Sep 2026 16:01:39 +0200
Date: Thu, 24 Sep 2026 16:01:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
Message-ID: <74331b98-2bb1-4908-89db-ec91131ba6ad@lunn.ch>
References: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
 <9a79f51e-50ec-4df2-b908-71573c81b69e@lunn.ch>
 <93e44830-d141-4ba5-8048-fbbaf4a2a63d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e44830-d141-4ba5-8048-fbbaf4a2a63d@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 11:58:52AM +0800, Hongmei Xu wrote:
> Apologies for the careless submission. I will fix the changelog and
> improve the commit description before sending v3. I will also ensure
> patches go through internal review before posting upstream.

Please also don't top post.

It really is worth subscribing to the netdev mailing list, and
spending 15 minutes a day reading patches and review comments.
Anything we point out to other developers also applies to you. You can
learn about processes by look at what others do, and what we say when
they get is wrong. It becomes really annoying to have to repeat the
same thing again and again, because developers are not learning from
each other. This is all basic training i would expect any big company
to give to its employees when working with Mainline.

Thanks
	Andrew
