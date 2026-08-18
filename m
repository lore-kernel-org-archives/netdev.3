Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8553AA4F8;
	Tue, 18 Aug 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064669; cv=none; b=lBKZ2SDqlZyzhr2p1S5/UycPIMdLyEtIt8fHB0Fc9b9TldyWS+uwajbgL3eAOlv2aaUH56D3l2YuXn3c/HDxBu3fYVbbM0tqXW//e7fjD1H7auKpCxJvDSvBIygEf9FOBIa79BvsiyImU/lpg8Xhzlw9xBB8PeL6/brpiVGSEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064669; c=relaxed/simple;
	bh=FOblcIZs76inEOf6cemT4oqwUhznzJ8u/Ux32Eo5qKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEAvh5Xe2dez9+rJLMOmR3n1yuBop/jIE8k4ReJyXhKmh1y7lpVs6zEFgCOixt58on8Y6WQ74qrytZNTSOcYS4uIFhqfhDMkEumBXQoRzFDzDOnQroxllQXeH9HMlvRHCkl51+90VQobV1lE+5UWuP+UXThIkNFpMd9dFNTu0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Ze1aY/8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Ze1aY/8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=A5T+Ga75WOdMgw8u9Vqj7YY2NFiNCpLgUc0SP6B+C4Q=; b=3Ze1aY/8FewY2yRsE0/8Sk0WLf
	QkgRK0rugTWCWxNIKM+AHf3E+suaS4EYyqlQ5i8eae8WPIPPMepxILtO7tDYLuTpvXYxJGwylR0os
	VBHccL1AE/a3O3mdnGMdZRvokIrphDgOWmKBgHytL1hfz2oubvFy/NNKhVqxudHFtXzLvspx5FN3H
	hyHZuKs9kvFB+MllMdtCZT2vozs8/OzBj07oagkc818mAxdqd6m/tuneWzhl5PbpvsRjfCZwtb76P
	46vuRgX+Ggt8VYhi4VZZwwlc5pg87MWvbKvCFWJrm/AUqxkQcX6Z3wvgZ9d4xhCMKQWC4SPUchZtP
	RnB3+F2g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwL9a-00000008CZO-3Lvm;
	Tue, 18 Aug 2026 14:51:02 +0000
Message-ID: <1aa6cc61-cc55-4186-91f7-e072af4e1975@infradead.org>
Date: Tue, 18 Aug 2026 07:51:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: oa-tc6-framework: Fix link to specification
To: Stefan Wahren <wahrenst@gmx.net>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260818135958.17311-1-wahrenst@gmx.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260818135958.17311-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/26 6:59 AM, Stefan Wahren wrote:
> Current link for 10BASE-T1x MAC-PHY Serial Interface Specification
> doesn't work - it returns 404. Update the link to the working one.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/oa-tc6-framework.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
> index 013824078cea..0feda2f9d840 100644
> --- a/Documentation/networking/oa-tc6-framework.rst
> +++ b/Documentation/networking/oa-tc6-framework.rst
> @@ -77,7 +77,7 @@ Reference
>  
>  10BASE-T1x MAC-PHY Serial Interface Specification,
>  
> -Link: https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> +Link: https://opensig.org/wp-content/uploads/2023/12/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
>  
>  Hardware Architecture
>  ---------------------

-- 
~Randy
