Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECE28690;
	Sun,  6 Sep 2026 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788668544; cv=none; b=mZgNeIqmxk6sertEdzBkHj0luo/ZhDw0+qSxYEUUSDIQ/fuP/iYRrSjQnL7vt0t6hjTY2L0+61ZgMPt4+IIlWcFvTFkCFP1WZeuCr7LEoo21+rMd24E02ueuW0tcuJLYEljHBWHQOugKgVsUseNdU1t1NZ/4a/ykJyiNTWQ+b2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788668544; c=relaxed/simple;
	bh=4bFlLdWEXYvO8s5DnNWD50IObe5rHu06UDOP3Lpaow4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUjzBOSsNqJugHi9duU16s1OfnPD2meoJf85QyM1fYftuKRVKgoN0E/o1YG35A0bsS5Jf88DQRYMqLOcxKI9ei8HClKra7LBBjBVtA+uXR7dREGn7pQ+OAFKsjnkeuFrp9cegO+jTnsUN9cqPUn1XHl5VKBX+lOGbsN4eqrXREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dXH31noe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXH31noe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b5JOelo/8FzpgSP8X8REJO4zAdwDLqFIBn+MQd9hcGg=; b=dXH31noelHRkvGZjB+QyvcD6Mj
	VyzDKc1KaU5vSKtGtrUc7wiy9AuCAKb4YAXvx4B53Qsve41LAPwedYKZDVEQEpwd9+QC596oVyo88
	3zTZD2Isd34YhBZf5Uh5J0gcXWIrTFTXAn9/1VP7qQ477KNDUZgeR+CpZSQUd6HN2wopLbt0QQMrb
	tjD/U+FIZOTPzbrTs5gli9k9pVO9F4p6mDPZASEF3U7xQgn0kN9s8kN2WjTOT04hScNdEwgcvWgyi
	z+uLdQzD0VbKCzt/2sIZJtwZqyNr24zGp6lgvNGCyGbsDMzIoYJGgm6y0IZzsK2YT0N1c1CRnZvV9
	T9jR7Uww==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x34Oa-00000004fuC-2hmJ;
	Sun, 06 Sep 2026 04:22:20 +0000
Message-ID: <0955bc99-242c-4e6f-9791-3a8dd8c1eaa3@infradead.org>
Date: Sat, 5 Sep 2026 21:22:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: mctp: Fix the struct mctp_sk_key name
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905095150.42180-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905095150.42180-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 2:51 AM, Karl Mehltretter wrote:
> struct sk_key does not exist; the type is struct mctp_sk_key.
> 
> Use it.
> 
> Fixes: f4d41c59135d ("doc/mctp: Add a little detail about kernel internals")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/mctp.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/mctp.rst b/Documentation/networking/mctp.rst
> index 3bff00c11702..1b4bffa1ed74 100644
> --- a/Documentation/networking/mctp.rst
> +++ b/Documentation/networking/mctp.rst
> @@ -296,7 +296,7 @@ There are a few possible packet flows in the MCTP stack:
>  	: route lookup
>  	-> rt->output() (== mctp_route_input)
>  	   : sk_key lookup
> -	   : stores skb in struct sk_key->reasm_head
> +	   : stores skb in struct mctp_sk_key->reasm_head
>  
>  	mctp_pkttype_receive()
>  	: route lookup

-- 
~Randy
