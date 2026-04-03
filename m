Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBE23A561;
	Fri,  3 Apr 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176905; cv=none; b=GrGqNRjiqla5VIDQsQmlfWjZ0JEv6f/Y0K6RJ+HRqvkOWfAnpOS2B25ftQKxBmSJrbpjZhRB6hMFNDi3RNEUj2UW3MgY21aJs+1HCT1NXH8m5dCa/LF9Q/dmHKUTN/xKtD2ZFLcip5Ut/1/7smwy+6R7ED9r4ZF9N/onkBLsJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176905; c=relaxed/simple;
	bh=xL5mwc7z3E4lsVCM4qE0m8ofmyFQ6QU8ifirfLCh+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZVXHo0LRhMgp38NG8GAataG4IqwZLe3YvjFxqxVqqLixfQtMbkMRK+htmYggVU8dMGGW8nzr2xWFcy3+MMFtUKfX+p8rW29tYaGaJveHqEn136SaoztplvNxl8k1SEbuPp5VpehG+N5QnZPYVUUTWsi4ZEhOBE2IxK1oiyFrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Rho20FK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Rho20FK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b0KIRpkRV25lNYB/LVncXLnloOxZcRD8kEPUmzaqR/I=; b=2Rho20FKDBz1wURgu07YLPD5pW
	Fsi8v8vXOXuTGGHbtXbfMcC97KOAFLPwWZ//ATMVIzJwb0uYG0L4I8CGB88fkIi1blZN8UqH4SNdB
	05gG2qW2ypdQhfLnM4fJGFc6T8Bksiofg1AEEQkCIr8C4h15MUNUBMzEIsLep6grbXhE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8SbO-00Eaqs-IW; Fri, 03 Apr 2026 02:41:34 +0200
Date: Fri, 3 Apr 2026 02:41:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: yt921x: Add port police support
Message-ID: <654b51cd-fc06-4dd2-9a6e-421d7333f905@lunn.ch>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
 <20260402223437.109097-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402223437.109097-4-mmyangfl@gmail.com>

> +static void update_ctrls_unaligned(u32 *ctrls, u64 mask, u64 val)
> +{
> +	ctrls[0] &= ~((u32)mask);
> +	ctrls[1] &= ~((u32)(mask >> 32));
> +	ctrls[0] |= (u32)val;
> +	ctrls[1] |= (u32)(val >> 32);

Please use the macros upper_32_bits() and lower_32_bits().

> +	update_ctrls_unaligned(&ctrls[0], YT921X_METER_CTRLab_EBS_M,
> +			       YT921X_METER_CTRLab_EBS(meter.ebs));
> +	update_ctrls_unaligned(&ctrls[1], YT921X_METER_CTRLbc_CBS_M,
> +			       YT921X_METER_CTRLbc_CBS(meter.cbs));

That looks odd. The first call to update_ctrls_unaligned() writes to
ctrls[0] and ctrl[1]. The second call ORs into ctrls[1] and writes
to ctrls[2]?

When you look at the masks:

> +#define  YT921X_METER_CTRLbc_CBS_M		GENMASK_ULL(35, 20)
> +#define  YT921X_METER_CTRLab_EBS_M		GENMASK_ULL(33, 18)

They cross the 32 bit boundary. I think it would be cleaner to deal
with these using GENMASK_U128 and construct the value in a u128. Pass
the u128 to a reg96_write() and let it discard the upper 32 bits?

    Andrew
