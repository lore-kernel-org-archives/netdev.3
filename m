Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D137268C;
	Fri, 25 Sep 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344571; cv=none; b=ArTmtIdLz8bbCfFFhnrF0CLx492MdxU3S7raWexwOwULoSL8H5O/p68XCqNXlkid9wSMy9NKr8JcNVMC1KJNuaY5c+ytqM4rOxgo6Mrc5B8M4l1M8FbjB38qjFDdeJB05tfgrrpKDOdqF4HLW3/KzJ7Wid5yXLw8eW9lXJ7waxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344571; c=relaxed/simple;
	bh=ayNHMPle4jmqcQu6r4rVG6AymghxFUOo6O6xrmXMZkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnrGj6hPB+CL1HRJsJoQvGN4kH/sT7gj14V1zJKb8EG308Jd+jn5ZTimfQg04J00JpNlAfcnrjC9A39WdI2Ga/w8UaRJg9MXmfbPD6I4TpDESeo8K7Cxp6zHudEE6zCQhCaLm4IZlKCVZ5he7uQ4ar3n3XgvuQEWSKaqtHUCp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i4HLVt89; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i4HLVt89"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AFE6A1A101D;
	Fri, 25 Sep 2026 13:56:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 836B56073B;
	Fri, 25 Sep 2026 13:56:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7533C103282D5;
	Fri, 25 Sep 2026 15:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hEBpoBlVwydzP4lHw8pOPXDZ4NiqRqj1RR7inYsLQ9o=;
	b=i4HLVt89ESvlWyKbMPI7qq21ZWtFV57bngwEqzWaWLkR5vKf9AwyJ8p4y06sbtDKJA4uHF
	3wEsPeeAzL8JovsJ8mbRMzCsZbnbglHTPUPyLvGILELDje6m2+P+PxLSJle+ByMIG6YMG/
	g0cngD5CSyegR9v0NmuUzrOJb0u9L47t34D4o7NVGhDeHmMgSBrXY2QVuRW8iptmpZvc1K
	HN+OFixiGadFo3wzCKyvZaAVBFZK85B4OQp93QxSpkvvbcU3EUxL2hgEEjI9c0F1VGG8kw
	4DtSdpRTa22TWxK0jz9L41grpDJtIJtK3L7oUELpAhDT0hiGBM69sekSxm+veg==
Message-ID: <0ddf8280-0a66-4dbf-9195-1b90e97015c5@bootlin.com>
Date: Fri, 25 Sep 2026 15:55:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp
 provider index
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925135237.3432266-1-nb@tipi-net.de>
 <20260925135237.3432266-2-nb@tipi-net.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260925135237.3432266-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/25/26 15:52, Nicolai Buchwitz wrote:
> A provider index of 0xFFFFFFFF picks a provider on hardware that has
> none. phc_index is an int where -1 means no PHC, and the u32 from user
> space ends up as -1, so the two match.
> 
> TSINFO_GET uses -1 for "no provider requested" and answers with the
> default provider instead of an error.
> 
> Reject the value in the netlink policy, which covers every comparison
> site.
> 
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> NLA_POLICY_MAX does not fit here, .max in struct nla_policy is s16.
> 
>   net/ethtool/ts.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/ts.h b/net/ethtool/ts.h
> index d901a879a671..ab9805308353 100644
> --- a/net/ethtool/ts.h
> +++ b/net/ethtool/ts.h
> @@ -5,9 +5,15 @@
>   
>   #include "netlink.h"
>   
> +/* phc_index is an int and -1 means no PHC, so keep the request non-negative */
> +static const struct netlink_range_validation ethnl_ts_prov_index_range = {
> +	.max = INT_MAX,
> +};
> +
>   static const struct nla_policy
>   ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
> -	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },
> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &ethnl_ts_prov_index_range),
>   	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
>   		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
>   };

I think you can simply do this:
[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
	NLA_POLICY_MAX(NLA_U32, INT_MAX),

> base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

