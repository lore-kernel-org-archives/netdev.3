Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524852;
	b=nlpZblBC0JCiHXdVmlLGBBdA2Dt+2V8lkxhCBNcQ1qexKHPUVLUduJ7NLaKCh9CKTxPp
	 nfNAj6ayemJzMBhAiPwl9jnY7GCHCpHvroQeBL4bC6gbOC6FcFQl5r1T3jO9+QtLMAH/z
	 HCBX64CpMEk50lwGXbvi/Pp93xn6Ciqs+wPRAhisv8rapU3HT2eyThc1as/LsQonsUjhK
	 M8YdxbERfKjBzQ30usD3oqbLIFrcVYiMAAxTGGtLWkwRbadf00MvoarrXaSj2XFg5AGAS
	 1HXFNL0W35zXlq7taPVU4cMas4zZQf8/6i8v/UwYQESMh3fT6GCRwOJfHE8zsJngWmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524852;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MZPWqKE0HTV5d6t2sQZTKLkxQbZA4U+ch3xfEQAoZqY=;
	b=Lk64ohi8yFp0Utfjr30CnFr66Ed5fyaKI5feI8ZFRJu692RpMvwxC2sdQwW/DiMS7eaS
	 BxcMbWCT5Eq1iYp6cuQdjNjx9wqI79OWL8ddMfr5hZZZ4LdeJxJ94g0loa6kQKjfhvURC
	 xSW0bFYUGxCbgkO4Zlel4Ju/hY5UsUeYdjpCodaRpCvzJs4xDthDpXpj1m1PhPCFaL9ZI
	 8rSYp8PI++B4a2pCwG0ZoW7FD7BASMY9Ug4UInvQZXATVKwp8scAcJgAQzh/8fDGzbe/k
	 lCiBNyaPH3B99DlABrqNLCXDWL2RxtpEtYZdWbizq/BEiSTe0Q5dD6PKOYRHF3I7zsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SoHIq5dV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EC606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SoHIq5dV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47891F000C4;
	Thu, 12 Nov 2026 23:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524852;
	bh=MZPWqKE0HTV5d6t2sQZTKLkxQbZA4U+ch3xfEQAoZqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SoHIq5dVqlWHWfHKg+FTGshurJjbMffpQnCX695DXnTCUuXETRe+sEtBIdokljW28
	 AA/9RcadE8RSNFOcA64j5dilMBGEqw6omIhX76epcN0i6r+j//bS1R2F4XjoTN6lwJ
	 xhoGxWvRMpkqylzogdcLqkps0+hlNxTFtIIjc/KMBMFaduAdcsQKnA+ncIo8ycVxNE
	 KU2kps3QLkvdGMViqWhgEw0RpVKyqD+kv31OzVX4aELREmZ5BeLbZGkBC8o3pKP62h
	 JRmUNWpHNupXVZHxohf6ZVsCcUqV6n4XlcJUKGKGmu7zPgcQTKkiMbOwzS5Yos9Nav
	 LSWqgrszfMA1g==
Subject: Re: [PATCH net-next v5 04/15] ice: add helpers for Global RSS LUT
 alloc, free, vsi_update
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com,
 poros@redhat.com
Date: Thu, 12 Nov 2026 23:07:30 +0000
Message-ID: <179452485045.2199510.16870447350546923165@kernel.org>
In-Reply-To: <20261110141534.95614-5-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-5-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment on the new `global_lut_id` field in `struct ice_vsi`
  (drivers/net/ethernet/intel/ice/ice.h) says it is "valid when lut_type…

--

ice: add helpers for Global RSS LUT alloc, free, vsi_update

This commit adds admin queue helpers to allocate and free RSS Global LUTs.
It also programs the Global LUT ID and the RSS LUT type into the VSI
context. It adds a global_lut_id field to struct ice_vsi to hold the
allocated LUT ID.

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 432da05c48c08..89a2bdbecf609 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -367,6 +367,7 @@ struct ice_vsi {
>  	u8 *rss_hkey_user;	/* User configured hash keys */
>  	u8 *rss_lut_user;	/* User configured lookup table entries */
>  	u8 rss_lut_type;	/* used to configure Get/Set RSS LUT AQ call */
> +	u8 global_lut_id;       /* valid when lut_type == GLOBAL_LUT */

[Severity: Low]
This isn't a bug, but the comment refers to identifiers that don't exist
here. The struct member is rss_lut_type, not lut_type. The enum constant
is ICE_LUT_GLOBAL, not GLOBAL_LUT.

The only reader of this field, ice_set_rss_vsi_ctx(), checks:

	if (vsi->rss_lut_type == ICE_LUT_GLOBAL)
		global_lut_id = vsi->global_lut_id;

Could the comment be changed to say "valid when rss_lut_type ==
ICE_LUT_GLOBAL"? The same wording is still there at the end of the
series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
