Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BE3A7832
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546557; cv=none; b=Q5uXBu1SGCKq8fsIeMWHvH4xq0LQKnVhAhtiRu2Oq8lZmpw5ysMcTDXnZwY+3tZDs9uPCqxFDnn1pRFq1qxJ8nSy2GgnVMiU1TElFS5xROZUk0HFqxmAmOZYrXvY/KFhaj9BWFx8QdRCxlThNtQjHs0uZRfxwbwL9D8xw5SfEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546557; c=relaxed/simple;
	bh=09JoTQ21UX7uxYzwyLnsdFIM8lXjiQivoBrx9D9CmRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYZ8PWFhynEd4MnoFCBsldQ8l2kvhXnWTHwCyw8T3saKrzhMVs+WxcSh7ua4SVlSN1aCL2tWqJwL+PoxAKlQn+G8W6w8xGRAzEiQAWmcH5iXx8FNxxjjBU1TuE0wmmKdXPtc23NXz1JZBHS8/y/3aFrevMcQ1ed4uIeXd8jN1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMW88YNd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMW88YNd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6750AC2C663;
	Sat, 23 May 2026 14:30:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47D1E60733;
	Sat, 23 May 2026 14:29:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFC1910811D8A;
	Sat, 23 May 2026 16:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779546545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mHhnvBQQOzaPt/sP4pwL64YurTUCgvlJpmdobNgx7zQ=;
	b=DMW88YNdtLj9/yk/0+7APtxEcOVqYp2wqFxKApKysVOh+UeDYycLjtcCcE5OGOllUhPtad
	laS2W7zDdjD+xPVLQlFys5HDmwVLOdxCG76Bb18T2XsncxVCkRwDTMYbW2oHd6nJpRchUo
	AjieXyCp7HbG/idSl+plYgRFzrGF15GNsgjWrXn56L5iXIvBwvyQRlLsrFvUH5AFR0Ke4R
	5p8rMwvjITYDHx3MxoVYgQCsFjHxEpmDjkXNHWvpWOPtEPNM8M9h1MdUzwRKZgzVS9uky6
	BlfnI2I68UCy/BqKJkyn6+7ZsUlgRK0FETmkwUxRGcHfnBV/xxYaqa3k9wVfTg==
Message-ID: <1fa0f765-b284-45d0-afd7-f6028b99733b@bootlin.com>
Date: Sat, 23 May 2026 16:28:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/9] ethtool: module: call ethnl_ops_complete() on
 module flash errors
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com,
 andrew@lunn.ch, kees@kernel.org
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-2-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> When validate() fails we are skipping over ethnl_ops_complete()
> even tho we already called ethnl_ops_begin().
> 
> Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: kees@kernel.org
> CC: maxime.chevallier@bootlin.com
> CC: petrm@nvidia.com
> CC: danieller@nvidia.com
> ---
>   net/ethtool/module.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/module.c b/net/ethtool/module.c
> index cad2eb25b5a4..741f6fb25d45 100644
> --- a/net/ethtool/module.c
> +++ b/net/ethtool/module.c
> @@ -427,10 +427,11 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
>   
>   	ret = ethnl_module_fw_flash_validate(dev, info->extack);
>   	if (ret < 0)
> -		goto out_unlock;
> +		goto out_complete;
>   
>   	ret = module_flash_fw(dev, tb, skb, info);
>   
> +out_complete:
>   	ethnl_ops_complete(dev);
>   
>   out_unlock:

