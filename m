Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A93264F9;
	Mon, 24 Aug 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577312; cv=none; b=WIPj6p+xxyE9FxKUoR8imDtlQ5oUOnyZ9MlZjQozDNF3kJH4yTOnuJ0Aj91h9uDTEMKc4QPutvwA7AOJ8yPOFdaKsZJb1tUJNQwC8qu1xZ+yRVfFvM2MlfyD//Iy0KKwo+xuSmHGn/4w8eRH+mmL0+FO6NwFyX2e9NjtR4ltzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577312; c=relaxed/simple;
	bh=lXIPyvy1X7UvxfR/v5uXpPyN5bsuH8AK8bFTqQeQC+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My0LFgc9g9DTX6fydAy+BmwLG/QkBJvSEQmBP4qT4dkRdjyYNoqrNN4GcRJ1ZTOZ0rbsJ/XCv7qs94FnFRetc/TSQ73/v8acpaa1jH9Ayn6pq9IWtnd6yz2sU4tu7YW98RV99LJi96uFODDbYue+7fHkiQD8gMKVEErSe9Rg4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVhogL74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVhogL74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280571F000E9;
	Mon, 24 Aug 2026 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577310;
	bh=huzrhbuEltnFZhsFdMvi18OsDnmKRxLADDVTTKgMQtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VVhogL74ypzN31xbBU/khmY+YZVSQ40p5fMPtHM9u+svQOoFdvxqtatc9tYy8C8Cg
	 fN28g6+uV0OFklcMjjosXoIDOlcNLoVMw4h2s1ejJdRH+3/1QPnZR4C9ayjPmvN+M2
	 +q9FGnLtzoBIlI1jrARAj+4ljLQ2t9kbXy9h8C46GoXNEKyGg6RbY4zI3y9ouA0WHC
	 lcG6MXKvKZCpmXBPNMQjBjKIHBbvp8oHL+Uvd4Dxutd81QWVDK7EGeUEav+//9zbTZ
	 I8FpPrlzkG/iwgpgAQ7fSuhPmNvWIkbacLr+lOOj+20aAn2WYRvlwts2HD+HE8azdj
	 9do/eM5oGt2HQ==
Date: Mon, 24 Aug 2026 14:15:05 +0100
From: Simon Horman <horms@kernel.org>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com,
	wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/2] net: enetc: restore RX ring congestion mode
 after ring reconfiguration
Message-ID: <20260824131505.GU265046@horms.kernel.org>
References: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821064140.1315611-1-wei.fang@oss.nxp.com>

On Fri, Aug 21, 2026 at 02:41:38PM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The RX BD ring congestion mode (CM) enables the ENETC MAC to generate
> PAUSE frames when ingress congestion occurs. It is configured only in
> the phylink .mac_link_up() callback, which is invoked when the link
> status changes.
> 
> However, enetc_reconfigure() tears down and re-creates the RX BD rings
> at runtime without any link status change, for example when enabling or
> disabling PTP RX hardware timestamping. enetc_setup_rxbdr() rebuilds the
> RBMR register from zero, which clears the CM bit, and since the link
> status does not change, .mac_link_up() is not called again to restore
> it. As a result, flow control silently stops working after such a
> reconfiguration.
> 
> To solve this issue, track the desired CM state in a software flag
> ENETC_RXBDR_CM, which is maintained by the .mac_link_up() /
> .mac_link_down() callbacks and consulted by enetc_setup_rxbdr() when the
> RX BD rings are (re)configured. Both ENETC v1 and ENETC v4 are affected
> and are fixed in the same way.
> 
> ---
> v2:
> 1. Add a generic helper enetc_set_congestion_mode() to set the
>    congestion mode of the SI's RX BD rings
> 2. Move the setting of ENETC_RBMR from enetc_setup_rxbdr() to
>    enetc_enable_rxbdr()
> 3. Add gen_lock to struct enetc_si to prevent concurrent access to
>    ENETC_RBMR and the ENETC_RXBDR_CM bit of priv->flags
> v1 link: https://lore.kernel.org/imx/20260728023217.2499420-1-wei.fang@oss.nxp.com/

Thanks for the updates.

The AI-generated reviews provided by sashiko-bot elsewhere in this
thread appear to relate to pre-existing issues that I don't believe
should impact the progress of this patch.

For the series:
Reviewed-by: Simon Horman <horms@kernel.org>
