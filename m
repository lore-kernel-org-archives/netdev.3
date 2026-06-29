Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751ED4418CC
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752201; cv=none; b=GxzAs+kjpMQinLXG6yM601ewE0KfRp8kNziN5cdwQEJXvZ0YW8eh19wR9AwsL+pd3oi5l0gOMEmX7C07uArCqWHY6IcRinfWaEAN7+wtIbdeF6VNY8H82DhOM9dEILMj1nsgqQNPvdOSm9GDwEqBRUDTCsj/ZVtW7fzoUHEkx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752201; c=relaxed/simple;
	bh=gBZWSxXdy7AR6CqB/9JUonpwfrKmaB5iQbLAnXss5L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnRINpuxGsWw9XwIZry4GAFpAHvXLOMP6B+X7rKPUNC7mWx//uoFt1YYB/t28V6CIUgcdtCY8IRfvnfLfc7jR2yfnPKfdLcGO8Sh0E42qnzdp22Ncm0I420eWEgxZfyVj201pvUEJCZEckQ7+xPecKIwd7zhSTbMvNlU6nmnQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ksTvSdwX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ksTvSdwX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d85BYFUSxVzbAk2TuZ8K+6l+mQ8rREsFOyiC5vI1KYQ=; b=ksTvSdwXcHjA9Q+a9twZdxrqE7
	gqS77WVxRKCIvStm3MNAfD4qMY0j6kd4RElCB8qTxK4vyhdL/YyuIPnf920JJYPcB8392OvdErcAi
	gooCYMjR6hIeGpqf36Q9MLloowyqOzPykEvuDw6Zes1gzVZmCuAGBNTyS9FFjCteXSK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weFHg-009n4z-EU; Mon, 29 Jun 2026 18:56:36 +0200
Date: Mon, 29 Jun 2026 18:56:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
References: <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>

> +        name: inject-error-count
> +        type: u32
> +        doc: |
> +          Number of errors to inject. Each invocation injects the specified
> +          number of bit errors into the data stream.

Sorry, but i could not implement that, in a sensible way, given its
current specification.

I suppose i could simply flip the first `inject-error-count` bits, and
make the rest of the stream perfect? I could also wait until the stop
command is received, and then flip that many bits before i stop the
stream? But none of these seem sensible.

Please make this specification have sufficient details, or references
to 802.3, that you could give it to another engineer and get back a
reasonable implementation, without having to answer any questions.

> +      name: phy-test-act
> +      doc: |
> +        Configure PHY test parameters. Each attribute is optional and only
> +        specified attributes are applied. TX/RX patterns are set on the
> +        local port. BERT and error injection operate on the receiver port.

Error injection operates on the receive port? That is not what i
expected. I should go read 802.3, and understand how this is used.

	Andrew
