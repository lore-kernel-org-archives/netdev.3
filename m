Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DC3B8D75;
	Fri, 14 Aug 2026 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748202; cv=none; b=RZ/JyLnzHdq13TC91OMGUWgR6Q0oRP+gRhiqtVJqK+HshKWn57lnwkMoaJiZlc660CozzRHCX4trBGNkhuKlA3GLI+GUck0uzlpn+puKcES4nchaDIoIlk3CVLJ3VLiMt35t0jLmVq8PMDBbhlGJ3kQlM48me8tAxJY3tR77aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748202; c=relaxed/simple;
	bh=Dr0sxwTILYFz6f2PUInpf/nod16F/yTP+TE5nAkzaBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUnZpbVGzg+NFw7WeEAyzeZWfzj+Uk7Wj+AimcaMNbSbbaJiGCvUr9TkuWpCzhQXxHT8hDuvAcuH0Z5SzaW98KI6rJGf3QF86UzMZSg/gFmMGy1C/cN/oq12BAmkKblvA7vYJ2/3lNPYPcTk2WR92qXevQ/wDbDJ0xTyU3obrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ea5s+v9A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ea5s+v9A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tpV7TjA5NxUkOWKtQkMobLldwiPfnra+K0egCk9VvfU=; b=ea5s+v9AZDmZXhb1EOUiDsX/T6
	eQsZ0xhkx5dSVXBMmprOd8nXuXYaVHPxNvGFhStGMOBYhqtK87rXMPIu7Qf5klIr7AlO0gd5jwZAL
	LlHLgN8btradOyfnYiS6DW/kDuXtUc8drkBJ8kblOqHQYMVDf/rGP2bIMN/KAHeBQ7oTT1OX4/eC0
	or/udf+2hZjtGSMqHd44QfAufT8ZsUGI7kgWl3zmeFPxGqbWHEwK87U1jrmXFb90MDGPLkVuwBKFe
	GZvPIGteJqtdaqyRt+U3goubTPQfRyvq0EC5vcM5X7BNcIi8BYsF2/wHzayzfEFyEbRwqKsE4BIyj
	cXS121Eg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0pK-00000003Ha7-0K8s;
	Fri, 14 Aug 2026 22:56:38 +0000
Message-ID: <b428b0d8-5e5e-4e37-aef7-be0c2d0f76f0@infradead.org>
Date: Fri, 14 Aug 2026 15:56:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net_shaper: fix net_shaper_ops kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20260813192131.21254-1-kmehltretter@gmail.com>
 <20260814101408.13bc8cc2@kernel.org>
 <984e036c-0d90-435f-a56b-ea39a2adf923@infradead.org>
 <an-ZnZWVWtDemvSv@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <an-ZnZWVWtDemvSv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 3:49 PM, Karl Mehltretter wrote:
> On Fri, Aug 14, 2026 at 12:04:05PM +0100, Randy Dunlap wrote:
>> On 8/14/26 10:14 AM, Jakub Kicinski wrote:
>>>
>>> Isn't this a problem in kernel-doc extraction / how we embed it for
>>> rendering? Heading are quite useful and IMHO far more natural to use.
>>> My understanding was that kdoc should be able to use basic ReST
>>> formatting.
>>>
>>> Ack on the list indent fix
>>>
>>
>> I don't know of another reasonable solution for this (although I'm no expert
>> on ReST), so
>>
> 
> Yes, this is a problem in how Documentation/sphinx/kerneldoc.py embeds
> kernel-doc output. It parses generated content into a detached node while
> retaining the surrounding title hierarchy.
> 
> The key kerneldoc.py change is replacing the parser call:
> 
> -            self.state.nested_parse(result, 0, node, match_titles=1)
> +            nested_parse_with_titles(self.state, result, node)
> 
> This preserves the headings.
> 
> I tested the networking documentation with Sphinx 9.1.0 and Docutils
> 0.21.2 and 0.22.4, and a full htmldocs build with Docutils 0.22.4. The
> full build produced only unrelated existing warnings.
> 
> I can send this as a two-patch v2, with the list correction first.

Please do so.
Thanks.

-- 
~Randy

