Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407130567F;
	Sat,  5 Sep 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644014; cv=none; b=fBNpIHC+i5BNZ9lFu5tGDA8592cbH2gbLw/vWBi7uNTtCpmOlCyaM7MGfTgwVTZ8nqh3JRCL2H1YUVCIWyHChG4l298+365svbiaizLgKEGaFNsI9H+P8vtJvXZxT+DfHdSUuQ+UWJjfafYznybL0nFY+iIE27NBQ026+JnsUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644014; c=relaxed/simple;
	bh=nMcIZDaz9P6YdZuk4NTAeD7iuucBcT+K/0Mx4g+BVCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTIK0foed+Vs4OGQj9o5eslJDNRaibyA5d/5VyGpqxcpoGeYDTWJ/ELbN+Ec1aBFilqvJeN+D5swQCo3pvnFM65lzKdXtk72t1jki2egSe0RPc+nLww6JbtoeVlTpyjsIbGcj65Aeaxr3D1bA0zEtDlQIHYzduhZAXftyGwZB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qM+Zt6l7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qM+Zt6l7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QpF39hniDTQuoy0euIv85pXwDNYc1GpquiCShFxAM/c=; b=qM+Zt6l7dch/x9ZG6GPN3KJyW4
	ax4/vllnBeSp+O9tAnsYRhfg8KJmsFn7mSodDFgGf2RgQEAUZP2LD7P4shDAqenB4IQnY8cZRA6mw
	56Rsy4ZjxHoEmdpFajqcJ4v6KcSweV6T50VbArNfR4+lK3uOEzB4rq/Uan+NWGbI18GYmJyWyGGoW
	kzeYXAZadMyD5PwrL0YIPMTSLc6wMShng9IYXhbUNLj457/Xw2eMf9sJDiKSj9dPDGxQOV1otyPpW
	01RfGnACjsjET2b2iCj11dor5bJqINPJBt4DPM2/2eSYSD2V9QqCgGmtND+F8BFlS2PGthHdIhfMU
	35SlN+hw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2y0x-00000004Qlg-0Ks3;
	Sat, 05 Sep 2026 21:33:31 +0000
Message-ID: <a9eb3030-3f51-45ef-a675-94c1b2389555@infradead.org>
Date: Sat, 5 Sep 2026 14:33:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: networking: page_pool: Use
 page_pool_put_netmem_bulk() in the kernel-doc directive
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20260905084711.40105-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905084711.40105-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 1:47 AM, Karl Mehltretter wrote:
> page_pool.rst asks net/core/page_pool.c for page_pool_put_page_bulk().
> Commit 024bfd2e9d80 ("page_pool: make page_pool_put_page_bulk() handle
> array of netmems") renamed the function to page_pool_put_netmem_bulk().
> Since then the directive finds nothing and the bulk release helper is
> missing from the rendered page.
> 
> Use the current name.
> 
> Fixes: 024bfd2e9d80 ("page_pool: make page_pool_put_page_bulk() handle array of netmems")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
thanks.

> ---
>  Documentation/networking/page_pool.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 817f8b78d246..d0be2b800a06 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -83,7 +83,7 @@ that NAPI context, the page pool may safely access consumer-side resources
>  		 page_pool_get_dma_addr page_pool_get_dma_dir
>  
>  .. kernel-doc:: net/core/page_pool.c
> -   :identifiers: page_pool_put_page_bulk
> +   :identifiers: page_pool_put_netmem_bulk
>  
>  DMA sync
>  --------

-- 
~Randy
