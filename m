Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD73939B9;
	Tue,  7 Jul 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450661; cv=none; b=msEvglzkwVThg6p8yr8biQJLPU9ny+vDfNpTZuhv9VBgVDyDUAgi32cjDZdhLlkqjxy9LgKYZ7spBcuctMo8rSRnpno06DE4ShaHO4ijzdSph59hNTGlJPjy2sqa9AvoJYn+f6edt6r1HAKSvZNBulROWIJZeyNB6QN5c1a7sKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450661; c=relaxed/simple;
	bh=FNuTwQ0Cg5/5qbttkSU918S64H/kaHnHsuLr2D+UCBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp5dERrd3NaVgVpa2KZ8obGcJGABiGcPSzKcznx9RTKDVFFphJH9RXvHo8UHbtvBxhoED0D50kNOfo3Ut9xAg1pet5JXHkrJxxMzbXMJiyt+Vu3m45G7Eld65FvpninJ38CZK58ecvfKH8I1ND5b6T+u3kfnjI5nbJ9NCUx4rSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tbPJZbO2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tbPJZbO2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ct1RYm16x3GFzu4FMGkc7eTBInRFcY8Ty+VPr5iXQDg=; b=tbPJZbO2+zUHCABOu6WpC9n2UX
	ApKquvPNPi+iTfI9xQUwt3a7HVpJUahC+fmqFDKiAAu7/RqX7VSiPe+7ikL1S21NFsfuh328vAtgK
	8fKPtjvBCnTULNOFDdD3758vwMIM+cdyfwUF7MoVlDipJHktpUez/ijS2s39YIJCYAuE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whAz2-00BDI8-Rq; Tue, 07 Jul 2026 20:57:28 +0200
Date: Tue, 7 Jul 2026 20:57:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/stmmac: Protect against zero queue DTS config
Message-ID: <d4fb7a9f-c0bb-4ced-8428-14bd2aa66d85@lunn.ch>
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
 <CGME20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee@eucas1p1.samsung.com>
 <20260707174431.1264520-2-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707174431.1264520-2-j.raczynski@samsung.com>

On Tue, Jul 07, 2026 at 07:44:30PM +0200, Jakub Raczynski wrote:
> Commit 8a7bca6de6de protected against inputing number of tx/rx_queues_to_use
> over kernel supported limit in DTS config. AI review mentioned that we also
> should protect against zero queue input, because this would cause issues
> down the line. Missing config is not an issue as stmmac_plat_dat_alloc()
> does apply '1' by default.
> 
> Fix this by adding check for zero queues input during DTS parsing
> 
> Fixes: 8a7bca6de6de ("net/stmmac: Apply MTL_MAX queue limit if config missing")

I'm not sure a Fixes: is justified here. Does this bother somebody? As
far as i understand, for this to actually do something the system is
broken anyway?

>  	if (!of_property_read_u32(rx_node, "snps,rx-queues-to-use", &value)) {
>  		if (value > MTL_MAX_RX_QUEUES)
>  			value = MTL_MAX_RX_QUEUES;
> +		else if (value == 0)
> +			value = 1;

If the DT is broken, don't we want it to be fixed? -EINVAL would make
it obvious.

    Andrew

---
pw-bot: cr

