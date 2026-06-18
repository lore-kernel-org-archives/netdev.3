Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803573ACEF8;
	Thu, 18 Jun 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770104; cv=none; b=tTF70uUUgR0ECLug548tMFjnMeTSXy5WaqlRMU43U9WzdzBAeAjQdJMWPKqQqoYRLff/gytBAZYozq50JLTvLwXAP0qU2zLlVCsmhIuj0RFoOfYpB4NxpPh2chhea9o4JcdTPMPVISaOh7s7Om5gMoC1hIFWwpBRDGqLosdxxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770104; c=relaxed/simple;
	bh=oRLqE+kB2vt23/313VSf7Q+3nRPggtnAfNkYXhLlA3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCrSJsJ+M9DzuFwhJikmfs7y/HTZVY1GjqINlhqAGaN+gELprrAFntxkOgam7Qwy94l8m7I7uuCwimeZoEdrMh/wnpCzRmWWH7+yeWGWWL0DegW99i65yoLSOp+eMoWO3sAYf81iBeM/Zb9/Id4XJ6Fz1ZOYS2LgGpCT53fgZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qpbi+Gg4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qpbi+Gg4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SQy0avkriDIictZ3KCnrtlI9MRTd4cCGeM4LFQno+hU=; b=qpbi+Gg4i+LiNk1IPJg5h9tYrm
	0zgLItrzBLIbGQwHMKAcYwBAGLD+Yrb0ssgRtDWWxlB3s5niQt64nXK+e1jEwQyzu8MHdF289qzkY
	QOKqPsTrJZUsZI9ILyEMMEjQwswBUqGcrF9NZd3lmL7hMfXM5q6wRcmB9A7Q8cxCL9g0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wa7nH-008J6x-E5; Thu, 18 Jun 2026 10:08:11 +0200
Date: Thu, 18 Jun 2026 10:08:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] igc: Wait for MAC passthrough after reset
Message-ID: <08e031fe-d6b9-45bf-9eef-5da3b49da939@lunn.ch>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618073324.1843310-1-acelan.kao@canonical.com>

> +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
> +					      struct igc_hw *hw)
> +{
> +	u8 addr[ETH_ALEN] __aligned(2);
> +	u32 orig_ral, orig_rah;
> +	u32 ral, rah;
> +	int i;
> +
> +	if (!igc_is_lmvp_device(pdev))
> +		return;
> +
> +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
> +
> +	for (i = 0; i < 100; i++) {
> +		msleep(100);
> +		igc_read_rar0(hw, addr, &ral, &rah);
> +		if ((ral != orig_ral || rah != orig_rah) &&
> +		    is_valid_ether_addr(addr))
> +			return;
> +	}

Please use one of the helpers from iopoll.h

       Andrew
