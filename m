Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870C31A7E4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070226; cv=none; b=kpmNI0dOHEOiHSX2BUwkG+YG+RqwWG/3kukltxpG8MIUtphRQZcv0WfLQIREQzR7eq4bO0kWAK1vWwdSm7td4lXtVEoECWKRVKhRyU8rkr4H77HS0OwcgdI5LLM8wyyfGVXRpk255obrjHsPBOIe9C4UPLVuH5ZlSPEYj/rbOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070226; c=relaxed/simple;
	bh=2SteAAkEUtZDgJA5+hodfPhtLV0H6R5KS2vYu3bBuMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJKWQq5yH6gn47ZusZ6ZSgnkXhuZJ4I32P9oUYXzSpF8Kjcub0iX8TPN3SPJjXQuX5Mvng8w4a7YL1sR1f8SHGSQQXmveuc6ObbRM4I1/pKh6haFEV6luQXGJVXx/c2wW0KaFUxZdjIfk2s+zEmtqLPmGj76HJxAWQX8G4hySwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v0XnQs4t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v0XnQs4t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B53D64E42C09;
	Wed,  6 May 2026 12:23:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 824A36053C;
	Wed,  6 May 2026 12:23:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A718102F249F;
	Wed,  6 May 2026 14:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778070221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eqxpajZ1KJZ+fC2W9FonpNivxhioR1fe6eN8ln+Yq1Y=;
	b=v0XnQs4toe4T3jcgM/mxWh0mXCg/v7YWT40L0Tr4qlweQhaPkqgmDXkbabLXVSrwk0ijOu
	lowsTi0RQm88iqIhMZ+P/JsuwjeLSSM7DxKVjNpppLdpoCBzO4nPtSIOP0excKhTZzk8Qq
	c5iNZD7knhHzJjDQj4b2/W3g7XA8JfBkb0kjGEblfrFfDCImH39J29HPngL8PMyqn6WzJ2
	q5QFzazDV/DMlcmmo+MfGxQtrxNQYo+WWrc4dRY/nuUJdiy7/rZoLdMnj22XpT60Vh+ICv
	IMffHz6dRmLcCjzwSsSwfXd6auIIPx20Ue5dIOWJuTujlIE8lx7quP8/evtXNg==
Message-ID: <08d60afc-56ee-49d1-b124-4d8f6191afcd@bootlin.com>
Date: Wed, 6 May 2026 14:23:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
To: Quan Sun <2022090917019@std.uestc.edu.cn>, netdev@vger.kernel.org,
 andrew@lunn.ch
Cc: kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20260506120131.767679-1-2022090917019@std.uestc.edu.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260506120131.767679-1-2022090917019@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 06/05/2026 14:01, Quan Sun wrote:
> In phy_prepare_data(), the strings rep_data->name and rep_data->drvname
> are allocated using kstrdup(). However, the return values of these
> allocations are not checked.
> 
> If kstrdup() fails to allocate memory, it returns NULL. The function
> phy_prepare_data() will still return 0 (success). Subsequently, the
> handler ethnl_default_doit() continues the execution flow and calls
> phy_reply_size() to calculate the size of the reply message. This
> unconditionally executes strlen(rep_data->name), leading to a kernel
> NULL pointer dereference and panic.
> 
> Fix this by properly checking the return values of kstrdup() for both
> `name` and `drvname`, and returning -ENOMEM if the allocation fails.
> 
> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>

Thanks for the fix :)

You're missing the Fixes: tag however.

Can you please add it ?

> ---
>  net/ethtool/phy.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index d4e6887055ab1..6cf3df1df8659 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -88,8 +88,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>  		return -EOPNOTSUPP;
>  
>  	rep_data->phyindex = phydev->phyindex;
> +
>  	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
> +	if (!rep_data->name)
> +		return -ENOMEM;
> +
>  	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
> +	if (!rep_data->drvname) {
> +		kfree(rep_data->name);
> +		return -ENOMEM;
> +	}
> +
>  	rep_data->upstream_type = pdn->upstream_type;
>  
>  	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {

There's a similar problem a few lines below with :

  rep_data->upstream_sfp_name

and

  rep_data->downstream_sfp_name

The only problematic case really is rep_data->name, as all the other
strings are checked for being NULL upon accessing them.

So either we only fix the rep_data->name allocation checks, or all the
string allocations :)

Can you address this in V2 ?

Thanks,

Maxime
