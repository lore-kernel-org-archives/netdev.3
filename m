Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528836F91E;
	Mon, 29 Jun 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731489; cv=none; b=PYGz00IuXpO9hFDCAKzyrvf49plbxpwd2I9DGnOETFiKQaAikPoxUFvtpvETh4PSxXRRdUYe0XVP4U8ZhxQiLxGhlRzhvQRmUn/mw0dwvSsAeygJPi8mm1WISu0LMDsTP2HIyjA8CRLUMH5Rdq7BX+2ouo71L+s5r1b5nZu4ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731489; c=relaxed/simple;
	bh=VIhHBFAAk1V5ISkXSs4odDoyYxGDJPj7uRrNDbXxr8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiNU7oI9b/Qv7NlqgMUZkgbsVn/Qi1C3+rV5o5WynwWFPG+MYlJV/eHbvW5+wQ9ZVffruI/jORaUPPgys2hVgfXecMv8df5R7lgRjlnxQPI/H+ykIPSekkiMz5aMhZbI7rC6yTAwtqDtJnUNP7Dv4S1Wohu043oDEQMKjLoy5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=5jj+/jM8; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="5jj+/jM8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=jPAvt4qaBDMoIurCHx70ouodE4Ai1NaWhHP67n45SmU=; b=5jj+/jM8kzonl4B7
	XJdz4oWYE8E8yYUtrOmNyccKZxdT86dDo5mmb/lELsNfM2q4/9lPJrbgSPCbq0l9hhS/Ic4FNhWRm
	CQ6tIi760AvxADxXVzgVttzly7dQbzSaSYCD7FRCXlXSxXSHpT4dNMMDMaSLeJa/acNYBioYmMAlt
	9tnhVQdD6TMQPgAj/PWazeEsVbgwCjdVNB2VcaOFtnRASUZCr9YwJ1Hicjf0p13qPTK3q65+dZ1to
	cACsKcRR+VVeoNZpIZhKOtE4YIlvukMcAo9NQQzktprBzN+uVg9Y918AEDVoFXuIAXEE4t3paW22/
	+fbV6rq/AHfYOFXDyw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1we9tN-000PL2-9D; Mon, 29 Jun 2026 12:11:09 +0100
Message-ID: <74e05f3d-39a6-4a4c-8bc3-d4f23a54ef69@codethink.co.uk>
Date: Mon, 29 Jun 2026 12:11:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix missed le32_to_cpu()
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622143707.497198-1-ben.dooks@codethink.co.uk>
 <b375d36c-112e-4662-b538-fd10fa927ecc@bootlin.com>
 <20260624192205.4485cd61@kernel.org>
 <2a92fd9d-42b3-4564-b784-ec504d4d82b8@bootlin.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <2a92fd9d-42b3-4564-b784-ec504d4d82b8@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 25/06/2026 08:07, Maxime Chevallier wrote:
> 
> 
> On 6/25/26 04:22, Jakub Kicinski wrote:
>> On Mon, 22 Jun 2026 19:51:39 +0200 Maxime Chevallier wrote:
>>> Hi Ben,
>>>
>>> On 6/22/26 16:37, Ben Dooks wrote:
>>>> The print in ndesc_display_ring() sends the des2 and des3
>>>> to the pr_info() without passing them through the relevant
>>>> conversion to cpu order.
>>>>
>>>> Fix the (prototype) sparse warnings by using le32_to_cpu():
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 6 (different base types)
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des2
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 7 (different base types)
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
>>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des3
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> I agree on the principle, but this isn't a fix so this'll have to wait
>>> until net-next re-opens :)
>>
>> Humpf, why are we not seeing this on x86 allmodconfig ? 🤔️
>>
>> $ make C=1 W=1 drivers/net/ethernet/stmicro/stmmac/norm_desc.o
>>    DESCEND objtool
>>    CC [M]  drivers/net/ethernet/stmicro/stmmac/norm_desc.o
>>    CHECK   drivers/net/ethernet/stmicro/stmmac/norm_desc.c
>> $
> 
> Heh good point indeed !
>    
>>>> Fix the (prototype) sparse warnings by using le32_to_cpu():
> 
> Ben, what's this "prototype" sparse ? a custom tool of yours that
> you used to find that ?

I have an RFC to add variadic and thus also printf/scanf formatting
to sparse. This is waiting on review after the original got re-worked
to add scanf and a few other bug-fixed and shuffles.

Ref: https://marc.info/?l=linux-sparse&m=178185274600679&w=2


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
