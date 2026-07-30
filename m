Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDE340260
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412355; cv=none; b=gxUpmdsw8ZWKPigadYLa/4JtlkJVGkbtgGQTizJgsVOoEaqJ01m5j/kT5oQOfRb6S0+XGq4fgaXZhMwC/fZNZpxtPg5LNDfx1W23kVuwwWKPJweG9AVbLzLIuIenDNU2XtFp5XRlYPHawuNLYELFThNLq8e8sKSoyq7Y5KeytFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412355; c=relaxed/simple;
	bh=cLNG7xC9PLsrkSSYz25s0Cz7ftpMmDkBXbeXpilAccs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0irBDL1p5hfISmSygUNr9eeYXJip5sfpArKKptdO3Jg3c+7iUd+wJGd+ewzfGNSVXQCgYVmi2SR3Atx5UAp+lR7Zh0Ll63blK/5JlZ75ycPzMtiuuPjqn2j5BHDRrzE2lBOaXYxT3pakuE7SzFEgYCCuHys0kUUykvE9ZQilb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez6ZEEB9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tDUNu8Li; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez6ZEEB9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tDUNu8Li"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785412352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hzbp1LAeckLpILrkJZAqATFkaErtUnNOLbJLz59+JfY=;
	b=ez6ZEEB9O38cAnrSbnmElCaJymf4J6WqVRpt8U4kb6E/tcXOGHQ+stdnRVf9ZiDz/FgifP
	Xk/mdx1dnqh34swnhfSriyWiFEC59xi16CqpImv8HrTCW3Pz1Vmm6j9bL323vJwXtG4Fr+
	FLinagSnk7BdN4N1hT+tSsS4v6R1ccY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-yjU95_iANyOKvUcPVF7IEg-1; Thu, 30 Jul 2026 07:52:31 -0400
X-MC-Unique: yjU95_iANyOKvUcPVF7IEg-1
X-Mimecast-MFC-AGG-ID: yjU95_iANyOKvUcPVF7IEg_1785412350
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso13531255e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785412350; x=1786017150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hzbp1LAeckLpILrkJZAqATFkaErtUnNOLbJLz59+JfY=;
        b=tDUNu8Li2IGMT3k/3JWXkegF6WtgvO649xPrlMRyWRCw6BNFuS56NFfqmu70mGp61H
         +gEXuIqNSIlN1eIV+61g+dXl3YJHK99LRIQleHnScdZqmnXgXsx+VTeMvilloQCLy+EA
         Yd5anG7F2Y/wVUz+hvM/j3YfyFs1dM3Al3Z7piDrkthVeYWeEIw6DfhmkoWADUjMdx9X
         LM4hwwcTsgvIdpVefEy/CalHphBjgSCINh8dSVtCo6nZNiOuRcQRT0C1T8vUF61heGkd
         xOKSwRoj7oK4QQrEpYrkT2wJeu/g+hb9kq4dPgYOjfMkUI1HZyLbSatkHEI5xErrjDEU
         gZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412350; x=1786017150;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hzbp1LAeckLpILrkJZAqATFkaErtUnNOLbJLz59+JfY=;
        b=UgOstko70OKdZr8rJymeXjgVHQcA4qCEe2iSTpzGQyixXKOfAMWYlBbzVHgl9DHAQu
         vHQqS+6zwj2k2sjXXhNcMr2GbkZT8JFdcBL4I1xbK3TtF0bDXuD19Q1rlHiE4k/tOMIi
         m9L2Ed7S5zC+83R09/rKjOx2PVWL04x56Y8POKpmUEBhANSfvSHuwb2BupG5o2xgap2i
         mzJadhMSTAek8VED6B13uXdEcDd/V+V0DzATdDQwst9aMktMJBRKDMwKPnoPN3NBbrMu
         XTNn/ixzkl9EBXFKkoCsVjpwGmDJevzT4CxSLHu/BNOCzhSmeHG9KA6I6CLUoW2zcivV
         DPxg==
X-Gm-Message-State: AOJu0Yx7YzqQTpXa1qDG8XT9oCD9JbJlDc7goDI/mWkXm4tGAI1QTfjf
	R7Y/vOcSdrSAGoemYweJxYXDsrWk8V4AkmF2MOysUtuZwMr71tPlX65bPJNN9muSen53Uap4FSZ
	Wd1l+cvisSJXuYSn6KAbHXtn3+I/9tnomrSeOpOw7k+qX9UU0zfG1tKFOKg==
X-Gm-Gg: AR+sD13qLHgg2uoAzAZ1mg83UxkH/ZM40yFOgw1k4N5AdWisfwAZ3GuHsSAXM2JBmnN
	/UP+xJU1Vb2vS1xAa8oHrNzCuXr3ZtMJffJ52a0jCLE2pm+oSLnr1w3Jdiub6o5t6low2fSXlc8
	r+Sv9zhrXamnfQPoi42fciATjrULrE7SHPxfB48Fh4Ro51PuFNBLauzwjz3EUgEbl7EanNMl8MF
	aS0a62fAunyLMqj6t3xCnAQF3I89LbwQHiHq8AnoNKcqNFWcSflVtkgGdabeLfH4FkCCFwdriJ6
	kQ9Ds0Sv75U69Vb/GFPpN6Dqyg8Q3p3cc5Fw31Mai4tNwV6cyiAcNK/4kggppladFcteuiYeQe2
	41VlZbPYsAI1OjIO2Kr5wkgz4I8h51IDxDyIwzJwPVwhNp4G9ycTEXtNOu7xchPjTp1+mGcMDdj
	YYuQ==
X-Received: by 2002:a05:600c:3b07:b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-49800e7580fmr28848905e9.12.1785412349976;
        Thu, 30 Jul 2026 04:52:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3b07:b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-49800e7580fmr28848385e9.12.1785412349487;
        Thu, 30 Jul 2026 04:52:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f1a7f7sm65258175e9.5.2026.07.30.04.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:52:28 -0700 (PDT)
Message-ID: <55b10825-5ecb-4abc-8551-bc4fc3c20365@redhat.com>
Date: Thu, 30 Jul 2026 13:52:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/15] net: macb: implement context swapping
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/26 5:29 PM, Théo Lebrun wrote:
> MACB has a pretty primitive approach to buffer management. They are all
> stored in `struct macb *bp`. On operations that require buffer realloc
> (set_ringparam & change_mtu at the moment), the only option is to close
> the interface, change our global state and re-open the interface.
> 
> Two issues:
> - It doesn't fly on memory pressured systems; we free our precious
>   buffers and don't manage to reallocate fully, meaning our machine
>   just lost its network access.
> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
> 
> Instead, we shall:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass newly allocated buffer pointers to the hardware
>  - start interface
>  - free old context
> 
> This is what we implement here. Both .set_ringparam() and
> .ndo_change_mtu() are covered by this series. In the future,
> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.
> 
> The change is super intrusive so conflicts will be major. Sorry!
> 
> --
> 
> During iteration V3, the LLM raised many race conditions because BH
> features aren't disabled at close and might do a variety of bad things
> (interact with NAPI while disabled or re-arm IRQs). This is NOT fixed
> here. Here we focus on swap, not close. The series is way too long
> already.
Note that Sashiko gemini has more to say:

https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bootlin.com

At least the possible deadlock in patch 13/15 looks real to me.

Please also note net-next commit c82ff94592fb

/P

