Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4F3F88B8
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195365; cv=none; b=OCNN454nsfnPplaXSwL4Zr7GouNeC077EN8BOr5UFKLZzY1fnqjaxF+RBQJdvU+dUXdIVrLLXyz4lpPrZ5QMxE/uy4Bj+l2inJc4J+taPqyr5i3CmZADgWAHmJ823WyUVKIIubCL8zE+AerjHZsT7o50MeRUqeyl84ijG3iCCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195365; c=relaxed/simple;
	bh=8WBazS4qsTnOmhdS6Y4/23AAFIKBY2Mtn7BBWVPz0OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Shpiw4tLx7HtX02qoSfL123fIa8Ps9QetyQKCqVTdSddtLcDJaeAQ6lOX0NSpIO2Cy8B4YZCzCfPjnzmwEOtZS7bBMShgabIRX6lOvaIjNT+S9PyXjB3k95w913Bg1rj79JlU3AJ7lTC7FtQvO24OqiyXZDw6cGlr4gDQ2boPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Og+tMsr7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Og+tMsr7"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c160875e029so61523566b.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1784195361; x=1784800161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ED4iRRKmIdvEEhhUwlOZxc3atZJOfUtWecCzx1pzaa4=;
        b=Og+tMsr7YnzcximGvDbjbR9gGF9/NFdgGzRr+LN+/mNy0wGOHAMoFVhFQ2wMotGOwG
         k5GKFMdRz89V7JUxQBHhQJkhDiu+T9xouGaeyyCnTyb+bLhZPtZK57f9rltPcxhDEfw1
         j0Fm1ZABJbBZ8NpI9s9oZz0WigtUu/6biM44LpW9uLQG1VPbuybaygJhXfHsB0S51LLT
         gqBwuLLIgM8GrCitjpvXr2TnWbpvytzXYAcYJ5IcP8xoigxY/v0zoIwLIDr3Lw79PqDq
         LenFMbR+Zyo21Dm2pQI+eAw6uxGK/eCV8yof0O41CBzVzLgOzEdymTESvJex0rSea8xQ
         h9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195361; x=1784800161;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ED4iRRKmIdvEEhhUwlOZxc3atZJOfUtWecCzx1pzaa4=;
        b=cKEOUgZa3940Ul+20rdx8nlq3DaHJIDb7DSiy6zntpqkgwAHVFed808kIuBdTefdsT
         dUGT+VqxnNq0UspBEzHI1oHebYpOy9JlwfM5AGsuXIw78XmtIMvxIDV6/XU4QYyXLGzM
         hLxW8HY42tu8z40sdqeVyCmMAxe0D1eemV1MEbB5kDjkQ3X+nmgu3WsnpzoJ/HkpRdNU
         l7/WDd5ZJNz3KProFIxmqKVJE7ercI18JRYiUD/difF32z8O2rulKZ+RF5ZgoWwbHILQ
         YN6GMJi0QHNLpSAIThDUe52JOmg8UErWksBQdD1i6g2J0+6n9IcLShMyGbvjtaWlVFpI
         slhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr45t4FhwMDfyqpUGj+HdUUbiEJaIVTExrimwNM181qULiSccddPeXTb2XR5wBxyi84lBrcro8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBy43M7jKKt/66OCI/GhlRDFzPZA24s0mjkoKml7e7Pwf45lMD
	/3V3ZV7ykAd9CKjCrOT+K+px9GCDLZ1J2fQPXK4Lam9xI81uki+pGXz+TYe/PN2HypGtI5zSRek
	wctsB88s=
X-Gm-Gg: AfdE7cnLhsP5GkttahHMTtH33QBAmGB6Y9YZULX9TxdkSZI0dYzMaXmhGy+578wxi30
	CayIiWj71s4tzJxVnBIHDaDtWqFRvsLjT73c6nT/kSvAcZtjTR0QaBnY5PexhcJjohjLhgxMqA3
	8h5u7bOZvf9a+PvsmzCzHUvWUyUwbycEql7/vwsWKBhDGXyGc/Y3azJzHY1XbYZ9M/0hGJ0GadQ
	6j6JaQU9VnjnkRHNNRG8bQ7O7IiA6a+20IangWswovzMYuy32Q9CEcYu8ftuSg6Rt3tAt0sDX32
	1gNbZKFYWLXnY/erkYt0GExWfHJYWJMDqaZJxryPKzTolA06UyJ4EFPd5Klwi0oaQ8scWwb+4i7
	DglEXeMgfuJ8VuEr+pEDjR1yUEFJxcnncaftt2SzR7kV8cSzc439saOZfKH0MkiVniy4OSK7NVC
	qGalHCVOQYLcBofDCKg4BwSxoUprB12pU2P2WpnOtiNEejdqaKVpE5ff0SI/XoUU68tg==
X-Received: by 2002:a17:907:7256:b0:c15:ccda:26d5 with SMTP id a640c23a62f3a-c168dd4abc0mr82267266b.4.1784195361179;
        Thu, 16 Jul 2026 02:49:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744e183sm177881366b.51.2026.07.16.02.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:49:20 -0700 (PDT)
Message-ID: <b7f3aedf-a7b7-4a7e-aa24-191192d33225@6wind.com>
Date: Thu, 16 Jul 2026 11:49:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next 2/2] seg6: man: document the lookup
 attribute for SRv6 encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Justin Iurman <justin.iurman@6wind.com>,
 Anthony Doeraene <anthony.doeraene@uclouvain.be>
References: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
 <20260712021155.7621-3-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260712021155.7621-3-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/07/2026 à 04:11, Andrea Mayer a écrit :
> Document the new optional "lookup" attribute for seg6 encap routes. It
> selects the FIB table for the post-encap SID route lookup and accepts a
> table number or a table name.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
