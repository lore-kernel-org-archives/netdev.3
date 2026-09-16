Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70B4BD35C;
	Wed, 16 Sep 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578191; cv=none; b=EANXhecNDtSRX7Or72O1gkxPep49RRx+e+We6H1tAZofhjnKoehXTRbjnSC5co/nFjn9+IFmhNNlh8OD3TDGrmCeR4wAM7jtrLy/8fQudUrAxOGw2fWbmaQryDPPml+0sWHhOWP6/eOXjjtK8wP6SYu/uUwgLCj6uL3ezPlIO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578191; c=relaxed/simple;
	bh=mW0CfWU+9u0Ij+rB9yD5qMUuEkbzwqaA5ymQLxfbKMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvKw5FLEv0A3x2Z1X/fcHg1tRcwHHbjo3YlrRMPbCdDwNw3iQaf2LzwjIkLWMX5xC4Xv5dPM9m2TVci67RyHK4VJNyZEdcM8sT+jjWoU742LBhZ+5mFgsU0RJWEJdYeZOD+s2GsrruX6ioVA/+zRm1GRUieivTC9EECfWa2+j4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dw+L42hZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dw+L42hZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wvr75hfjma7Gt6w5bo6zMYCNMx80OfaXsWak+1N9kJE=; b=Dw+L42hZdOLZG48Uk4kYEdhuZv
	8nQkc0qxUdAGrHLuV6TSLTlWZ7ogs7C6HIgWqhuu1TIQcn2gRXlGUovWgQwrW0/cwDh0h60cda/qP
	oBdq40gIR9CML66DqH/5b5jhkl4C52mPEWgPVlRab3RA12R7i+8wrpjV80VxplD3gDD7KjBQECmb3
	Iogqhq2EgYIc5NVa9I24fRGO0CuAjpCt/+jiWQYcKeClWN/QW6BQ0lDv/2i1izvhKKTdAmrKLmhLk
	ec66k71U3P4Fp8Kp9Lgw+tjjwSR6kNZDnvYcxYhlSe5RTRo94NbuBYZ4qz2SYBGsYtT4cPfV5ZKlF
	HmomLk9g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6t25-00000009pG3-2Lz0;
	Wed, 16 Sep 2026 17:02:53 +0000
Message-ID: <02fcbedb-94de-467b-a1b3-275689f1a6cb@infradead.org>
Date: Wed, 16 Sep 2026 10:02:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: net: dsa: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260916123458.314458-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 5:34 AM, Manuel Ebner wrote:
> Add missing ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/dsa/dsa.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
> index 42a99f5df..7edfdd555 100644
> --- a/Documentation/networking/dsa/dsa.rst
> +++ b/Documentation/networking/dsa/dsa.rst
> @@ -864,7 +864,7 @@ The drivers which act upon the ``dsa_db`` argument in ``port_fdb_add``,
>  DSA associates each offloaded bridge and each offloaded LAG with a one-based ID
>  (``struct dsa_bridge :: num``, ``struct dsa_lag :: id``) for the purposes of
>  refcounting addresses on shared ports. Drivers may piggyback on DSA's numbering
> -scheme (the ID is readable through ``db->bridge.num`` and ``db->lag.id`` or may
> +scheme (the ID is readable through ``db->bridge.num`` and ``db->lag.id``) or may
>  implement their own.
>  
>  Only the drivers which declare support for FDB isolation are notified of FDB

-- 
~Randy
