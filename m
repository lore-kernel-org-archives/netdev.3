Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843F4CCDF3;
	Sat,  5 Sep 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636660; cv=none; b=Xr1ZlNxM71/ilQ43MpSJo1yb1qvLs8fwDOAhyUF+3HwMY6KCnWr7M1v2Vyzofp2gr4yr3T6R9fA+I3VDC8Xr3nyAvaWklHuXMwVMP5C9nVFAVgVLSmLkfPO1Y+OF4MtwtMXnYl0zlY54SEgtCmhbOdTb9HyLCWLRjdOlDl5Ig9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636660; c=relaxed/simple;
	bh=7oqVkMh0iepzi0wZgu7ndtGyfZ5A0OzVjxfY5Kpa4uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SabQfWBUM7545OtvSGJyIpohEsLAaCo3ea3OsEGNGZ97vK63lCt9xVgZky26uXJ/+Sm+s2zSc+RJoH7qhS1/meBkH+FRsSTtiPXM3NgQJNACsBmvR2PymDSwFDnFD8oKRigtJ8ld/gsPQATHD+9K7LQyHUJR0MTPR/4IhcWftns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lRQdOr6n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRQdOr6n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b9N7NiMVNx5Y8xSfQTNw7rzupRQ2JjFKSe8iDmIGEHI=; b=lRQdOr6nESlKKoH/BiPYZmUqN+
	fx60+kZm/C7sIJuCe43iVM+a/b+hN4d3kfaYXKtoN0wsBJgiWQg1i4vuSvMWDFPfuum8bopFDvS1V
	yGGqfLNiPdTZ1Yu2Wo4kUURXeyN5S/mWeBSaAOTU54MfkwW8OmuT7RJ/N2gfUCKGe2nqn670VM5Ue
	McCn/McRAfkETGmMCLSleAEO6BzhVmg7fWawLPYMPqVWQu4ltPmGu8eZWxFNc+flha4x1tHGiig2R
	OjsGy54aBgIfnI1Pey0o+YbPIWu7CL3FE7FzEyvAm2JhEnIfE+ZU0A48cFx7wma3/S5riIlCDNSRW
	MmmWdKQA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2w6K-00000004N0B-2emE;
	Sat, 05 Sep 2026 19:30:56 +0000
Message-ID: <7826de5b-c3d1-4f09-991a-2943e5dbef15@infradead.org>
Date: Sat, 5 Sep 2026 12:30:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: phonet: Fix the struct sockaddr_pn name in
 the example
To: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?Q?R=C3=A9mi_Denis-Courmont?= <courmisch@gmail.com>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905104123.43511-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905104123.43511-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 3:41 AM, Karl Mehltretter wrote:
> struct sockaddr_spn does not exist; the name is struct sockaddr_pn.
> 
> Use struct sockaddr_pn.
> 
> Fixes: 297edb600326 ("Phonet: support active connection without pipe controller on modem")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
thanks.

> ---
>  Documentation/networking/phonet.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/phonet.rst b/Documentation/networking/phonet.rst
> index d705cc5b09fc..e5551fc45c78 100644
> --- a/Documentation/networking/phonet.rst
> +++ b/Documentation/networking/phonet.rst
> @@ -172,7 +172,7 @@ two endpoints directly, using connect() on the active side. This is
>  intended to support the newer Nokia Wireless Modem API, as found in
>  e.g. the Nokia Slim Modem in the ST-Ericsson U8500 platform::
>  
> -  struct sockaddr_spn spn;
> +  struct sockaddr_pn spn;
>    int fd;
>  
>    fd = socket(PF_PHONET, SOCK_SEQPACKET, PN_PROTO_PIPE);

-- 
~Randy
