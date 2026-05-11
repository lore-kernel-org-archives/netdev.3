Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690235A387;
	Mon, 11 May 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522543; cv=none; b=lHwbPrSBFz6fui9RtPQsJug7HLUcaAlzf6IQY7hUr7yOfhD8nnLlcmWfkqR9pKF4XvUXB6GoZyOT9Q+d/BxNgZimK1Qk0/j/TGaGmtDqXFbBEKarqmEnABItj64ODYbHxekasco3NfElnaYfWULaPKNWkVWO0TL4QYVp/MXe/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522543; c=relaxed/simple;
	bh=9Y68VwPkNI2fatbDkGtBJDAMWLyyp/LPtMfuCNkGVXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQwc9BVPABA7pj5pCrLgstWqqAQ1qldb9u8lyD7ZUnCQruKUbGx43zV+/mMSeRiu3bR49wiVmm1/bHyW83kRtuNpyRwYPzDbHe40hIibmxZ3/IZDW9qz4jHiLUYVY5h7AkvTDXBvvvZ6HiN518FnZDRabsz9yEftyZSKnxtICqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yj1MP7Vo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yj1MP7Vo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vsGS4vFF5QeO0IhCclm4fdwQEVJvfcIGnL1YjIGgI4w=; b=yj1MP7Vob7yZV2mosq/gmgdk+/
	RZhkaLTFVn8MdJQ6SayK6iWnh+O9YF9u0Had9gK62lqdnbI8ibZVWHwFRCJa2VJ+nI7RSRTzp81w3
	A0nboaaxxIht28zgF8fFY4hMowaci3mC7+XizmN2hPqf1sL6dLowjOHZm0R40TsGiEe0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMUxK-002Q5I-Om; Mon, 11 May 2026 20:02:14 +0200
Date: Mon, 11 May 2026 20:02:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
	k.tegowski@samsung.com
Subject: Re: [PATCH net-next 1/3] net/stmmac/dwxgmac: Modify DMA functions
 for future hardware
Message-ID: <5b94f49e-5f1a-40fb-af34-f4a9d4738502@lunn.ch>
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
 <CGME20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50@eucas1p1.samsung.com>
 <20260511165416.3093015-2-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165416.3093015-2-j.raczynski@samsung.com>

On Mon, May 11, 2026 at 06:54:14PM +0200, Jakub Raczynski wrote:
> Datasheet for newer hardware of XGMAC (3.20a and 3.40a) list support for
> up to 16 DMA/MTL queues. Currently maximum amount of queues in 8 set by
> STMMAC_CH_MAX, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES macros.
> But before we set these to higher value there are changes to be made.
> 
> While newer hardware supports up to 16 MTL/DMA queues, there is support only
> for 8 TC's (traffic control) entries. Current source assumes these are equal,
> which might not be true. While in some cases it would be just incorrect value,
> there are possible wrong memory accesses.
> 
> Fix this by saving number of TC supported by hardware in mac_device_info and
> verify it in related functions. Also use TC count rather than MTL_MAX values
> where it applies.
> +	/* Newer XGMAC hardware does support up to 16 MTL/DMA queues but
> +	 * only 8 traffic class queues. Redirect these, but this is error in
> +	 * configuration.
> +	 */

If this is an error in configuration why not return -EINVAL when the
configuration is requested?

	Andrew
