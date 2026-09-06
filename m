Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C373D891E;
	Sun,  6 Sep 2026 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788668527; cv=none; b=WvAkHPVS6rlk2uxqvU2+iwP9FRkzXWE90slrkq5bgEo8+aB4H0gF2LZDIpN/7zccQzWZzag963a7Lb2j79Qc+BLLfClRTnIYpC3yPagtCTdgEE2wrdV3Jb0kp8fDfxiC/NV+hlApHPx6esEL5rQLHq+x7IBMryZZjJAvLRx/JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788668527; c=relaxed/simple;
	bh=rbIiz3uJQFoVxoHrgo07TtcLEnv99oexyx4ls1WQz08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ9zycyRtB3xePj88QhCBfQGVT2iabOJtSIEBleDLYQ2K/VdoRwXXlmQuoZsUb688OYhrGKOt6LtHW0Sb5Hq/M4DaGQZLu7dIU7O8j2cSPmiojEQdAnD6QngMNTNBD3zeUz7KY2JoPxAraL12Mu5HD2EoLV7G7LbyCv6jdw+nl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RxOQo9e4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxOQo9e4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3MKb3iLUbR2VkDI8TJ/lPhLP7ryFwI1nuNrk7TVhqBI=; b=RxOQo9e4AidBJLBpkObkvI03zu
	fqP1oR3VjEOOgqhXPGq6gXddJP4t62DxuxhoioKaTy86lIN5XMz/O55+FErL6JES17h0k9vV2ee6e
	NFvYSr7i/Srd/eGHT/88f+DC8CUpKaEfN/K2/Oq+mYFntoYFtTf4YoKNLhk14hR48qPxTdZCmvCbQ
	mMVrBv2EX8YikP25iFU/a7FM96evG8Xv4u3tmpgD6W+DYGEMcPqzNf3c7KBQjnVFoVco8icDlKB5Y
	4ZEdUVOcw52xgy2WgniHIMraw3jBCPAhQD8C/wL1PpifXSTUAsR0qNah4ymWkw3iu+p7QqGtG8dLz
	OnU8u6jA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x34OH-00000004ftg-2bU8;
	Sun, 06 Sep 2026 04:22:01 +0000
Message-ID: <f63c002a-39ce-490f-9a7b-4f6baa8147b6@infradead.org>
Date: Sat, 5 Sep 2026 21:22:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: mctp: Fix the struct net_device name
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905095116.42147-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905095116.42147-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 2:51 AM, Karl Mehltretter wrote:
> struct netdevice does not exist; the type is struct net_device.
> 
> Use it.
> 
> Fixes: 6a2d98b18900 ("mctp: Add MCTP overview document")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/mctp.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/mctp.rst b/Documentation/networking/mctp.rst
> index c628cb5406d2..3bff00c11702 100644
> --- a/Documentation/networking/mctp.rst
> +++ b/Documentation/networking/mctp.rst
> @@ -19,7 +19,7 @@ networks.
>  
>  An interface (or "link") is an instance of an MCTP physical transport binding
>  (as defined by DSP0236, section 3.2.47), likely connected to a specific hardware
> -device. This is represented as a ``struct netdevice``.
> +device. This is represented as a ``struct net_device``.
>  
>  A network defines a unique address space for MCTP endpoints by endpoint-ID
>  (described by DSP0236, section 3.2.31). A network has a user-visible identifier

-- 
~Randy
