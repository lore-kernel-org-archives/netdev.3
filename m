Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C220D4E9;
	Tue,  1 Sep 2026 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221543; cv=none; b=Wn7lNHJWIAPAucGKRFKS01AYMZjms5HRVdl+fKQvi28Rhfcu3ai+ym5dWlShli4uYd5+CpYEZwBZSw8pJYt2BCLTyVh5q0eIs1eT/brmoeqjG5uE8S/engnbDKtltsAft7Uzd/rfNYh7+mK5YCVGcV1knNFz57isHgTJFS8ugMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221543; c=relaxed/simple;
	bh=UFQAt9s9CJ1zIjyWk1tji4LFj3JnoQKqSEK+6TyznVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar7X+js8CPMxYI0mN+gZljwZBDjXYDzs1+wA3yLFCY+/hmbxWskgoa0D0Nj2q5zg0HQx6VXrpqTzGjVHr7Z5WnCohSFXxcHy4U45FRxVzLFk2v8kvJlCaRoNi7uE+DwI8pfCZkjSlrPKeHk2jl+kNzH7yWWElZxEBvm9TMZpbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n5Lop7Hs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n5Lop7Hs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=drnZj9ls+Re3u3xWFMdJ9ITFaJJVUQr1ILP70Ur9h/g=; b=n5Lop7Hs9qzLRTh6aTMexZHCFM
	59wIXe05Amg7DeRdLCJpXJyIS2O+ud5/qQ60GugK50PpLZIDOWHXpazK0xx8Xo++m9JhzY02KEeDt
	xu3g9vlUwiH29QQ8JiTqsBfJUi5K56kVYs/RLCxS2m65LxMK5Sd1LcV1b43UTh9qU4OM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1C6k-002H9w-SC; Tue, 01 Sep 2026 02:12:10 +0200
Date: Tue, 1 Sep 2026 02:12:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect
 filter ability for UC filter
Message-ID: <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831070121.349778-3-maxime.chevallier@bootlin.com>

On Mon, Aug 31, 2026 at 09:01:20AM +0200, Maxime Chevallier wrote:
> Contrary to dwmac1000 that gets its number of perfect filter entries
> through the 'snps,perfect-filter-entries' property, dwmac4 allows
> reading the filter size from the HW features registers.

Does dwmac4 take any notice of "snps,perfect-filter-entries"? Should
it be marked deprecated?

   Andrew
