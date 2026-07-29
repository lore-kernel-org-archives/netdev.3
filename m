Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC303EC803;
	Wed, 29 Jul 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337227; cv=none; b=Q+CWXuA3bA4Mdij1ZDasl1YtUqHxZzN+VWIHKoFhcMc5wY5vx9r0Zh0FEIZISRYflmOweChgEr335xvkPsVcHLi+I/EhWqIrTt8rcIS7Uc+7+ICDeVkgT4wUspwcxoRseOW5vmlo0AqZnMKJwkmoh5szH8ilVr1o5W3zdyL7HbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337227; c=relaxed/simple;
	bh=zLwGWMrcexBHZWN0ZjyUBW6+xoPSUOoQGrcxHW7aHMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfn4nN4usuB7LOr0L0wXqK6XjGWyGhRkMWb8ha2cVizy0xKiHkT/4ewYiqIRPNHbCYChN0Ife9OH2cSCzH32Yz1mcLoqiP2JkgRbWg5hga3oASLhdyVmqAEt5bHgxc0Rek5v+eXVh8zTKi4Ib2PRLmVRgC160EgJ5B4saotma3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y8V5FrxL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y8V5FrxL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cj+4lhJ1n3MPXSWyH7rhu8SAlhn7g60qkPpqBkN1LkU=; b=y8V5FrxLXtgatI3vzZOlycuMlS
	7suQUYWoaafeHW/0gFBD8zc8hZVhrQHG9Jgmt8NmPFca/zB1LHxytHT2x6qAFTB9yhrQe3xjEgLOz
	s+QKtdiA15SKTjfNV32Nuj4eHNmrBJDZGipieU3o8owHHiK/aYGasgSRtxgbGAPiGsAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp5lQ-00Epyj-Pb; Wed, 29 Jul 2026 17:00:08 +0200
Date: Wed, 29 Jul 2026 17:00:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] e1000: drop dead switch statements in configure_tx/rx
Message-ID: <a422c52e-27de-4c10-93ca-4e82e7cbc517@lunn.ch>
References: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
 <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>

> I see the point, but as the code is quite old and its extensive development
> period passed long time ago, i believe value of such cosmetic patches is
> rather questionable.

It might be worth looking at the history of this code and see why it
is this way. Sometimes odd code like this is actually a bug of some
sort, maybe a merge conflict resolution which want wrong.

      Andrew
