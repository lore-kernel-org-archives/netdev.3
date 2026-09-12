Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0732D7F8
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249161; cv=none; b=PSkUiC2Fl99fgU3WouPmypnVps807yTX+68F6ZcSDUpRNN1p6IZy4CONAI8eaCYCOZyBOn1kZSfnne0TKFtZUKNpHUbXnX5x9tzXOuf3tZNRdUb4mn6lAAnpaEpxBBV6UiE9ADGyhaYkwY5KojiWRQ4UXfL4EoffafAJzkivD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249161; c=relaxed/simple;
	bh=uTYoSAY9L9GNWe89LCcqoMez9d2pG0NEsvovRN5YYn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlg2vrfkBeoUbPv9qAFpsY5E8+YdsYeT7zHcnXHh2od/55xPiQ38a8rn/OquQULYinwUQFGQdkKiuglgn/MbmNIGKaT3HH5FYEi1dLdFCinV/yqzETkDMhncVIT7Ib6HE5hcd++E9XdV8+MbQKdheJ9kFu2HiUs2JnZ/kR1a0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XgQoqzId; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XgQoqzId"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A45B2C63448;
	Sat, 12 Sep 2026 21:39:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B74260580;
	Sat, 12 Sep 2026 21:39:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00B2E11C7AFA9;
	Sat, 12 Sep 2026 23:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789249146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lZT6RlOhkt+EWSh2HQUd1bKDLTnT3xlJTc9dltgodwI=;
	b=XgQoqzIdO4NMDQi9D3AxENE7d5xKIKvCWynl195QwX3AsYG0ZcYmaeiD6mg4PLN7wH5TKR
	PlXYlME3nHoJqmjTFb/jDlhaK1hP8MIHd3W1bgfqB5ELkSVz71yTdAYYEcppz5tHBcFz4M
	83WXYZx8NPdlt76spPGt8u9TRWB44MQdaKt4ppTB/LUwK04tB3E56V7uisHFxwZXgqbz2M
	8KgGQEIbGtpm3HCfn/J6RwGHpZwOpoV8Mhy8gCnHNb6+9cA3TdURDNBEV4bv+jt/ds3+IU
	zg1yXfgWyNGHAkJgmS6FO7P5dRXP7uudkqvLg+S6I0vWE0THaKxjygddeONK7g==
Message-ID: <6ef48513-6302-44a1-833d-613f2b8a9e21@bootlin.com>
Date: Sat, 12 Sep 2026 23:39:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: report phc_index as -1 when no PTP clock
 is registered
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Gal Pressman <gal@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 9/12/26 23:16, Lorenzo Bianconi wrote:
> When hardware timestamping is supported but no PTP clock has been
> registered yet (e.g. while the interface is down), stmmac_get_ts_info()
> currently reports phc_index as 0. Zero is a valid PHC index and would
> make userspace resolve the wrong clock; the absence of a clock should
> be reported as -1, matching ethtool_init_tsinfo() and
> ethtool_op_get_ts_info().
> 
> Report -1 when no PTP clock is available.
> 
> Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timestamp")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Ah nice, I've briefly saw that just yesterday but haven't started digging,
thanks for fixing this :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

