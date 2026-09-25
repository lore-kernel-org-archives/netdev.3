Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194D36DA1D;
	Fri, 25 Sep 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345247; cv=none; b=f8Lu9YShvujEXscm9DfF0JmsJ3TxY9hbKogByesm9jUll2+dHsRKM50RUiiAWTwBixKLmRRAd4Lj/+RPlmrrYPX9P/3OOoCWKAFY/2QPhYx106C9VT6fmV3dwnji1eZHGwLFgRjFar/tZkmYEO7pCdLvPOAdFuPeQ7RnwkgsNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345247; c=relaxed/simple;
	bh=OWNwx3igPHd5zezYVmfUralRuTPVl8k8u8pllrEOmGA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WNJr34GSpWMF9WUWgxFOQ6vevwZ/FNpTmpnhDPLjRcxyd3iS61G0mNn8weoHVJTYS4rlmoMspfQ6welQwaHl9iyyFJABGYR96YFRsyu4ZyCxNbG4kN9vgYxctYjrOVe6mChiug3xyLsN7aFKBQVnpfJPy5IazO4sVrEdas/GczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=A9vuSLIh; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="A9vuSLIh"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16484A4AB3;
	Fri, 25 Sep 2026 16:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790345242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wszvQQiRXalcox4l6tz/ie/Pc2v62Nht4zolc4s6TS4=;
	b=A9vuSLIhnDLgveyGJV8dLCG7R0Sitypbr1cVH95QFrMZk8sRzV6aKPQE/B2OF38DOST8jj
	OXTAl52ltcUnpH0wY7qNiv/edJbnbrdetj0LKBGSMwfY/T66N0EfLTjWNmemprGaE6FS7U
	HpnYyBOVPOquSKW+bnq/8IkYpy5LnCloxMOJkW2lGRS/livrXqqwXblrMTm9ru9Kavnd2/
	wFkOY1ABSrkZ4Nx3XB1DQY2R7AMokIDdZnzG7W5UbWnH1UONc19FtSYngp3N3pkwb/tE/f
	JqU4eSqs4jsRqkCaP1l53C0vvXi7NbnAW+Miw1iBp68Yyco3FbKPwbaxufee4w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 16:07:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp
 provider index
In-Reply-To: <0ddf8280-0a66-4dbf-9195-1b90e97015c5@bootlin.com>
References: <20260925135237.3432266-1-nb@tipi-net.de>
 <20260925135237.3432266-2-nb@tipi-net.de>
 <0ddf8280-0a66-4dbf-9195-1b90e97015c5@bootlin.com>
Message-ID: <5ff0fa6eee1605e546d433c7944fa769@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kory

On 25.9.2026 15:55, Kory Maincent wrote:

> [...]

>>   static const struct nla_policy
>>   ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = 
>> {
>> -	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },
>> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
>> +		NLA_POLICY_FULL_RANGE(NLA_U32, &ethnl_ts_prov_index_range),
>>   	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
>>   		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
>>   };
> 
> I think you can simply do this:
> [ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
> 	NLA_POLICY_MAX(NLA_U32, INT_MAX),

That was my initial thought, but unfortunately it doesn't work. struct 
nla_policy's
.max is s16 and INT_MAX is truncated to -1. It ends up as U64_MAX in the 
range check
and in the end nothing gets rejected.

     include/vdso/limits.h:8:25: warning: overflow in conversion from 
'int'
     to 'short int' changes value from '2147483647' to '-1' [-Woverflow]

> [...]

Thanks,
Nicolai
