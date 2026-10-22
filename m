Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658272;
	b=yJyAgHh1JBUGy3PStaCfdpz1IjV6XNq3lBxDegSFsAdoN/fd6TqLTbmG3ur4Ut9ooyj9
	 x0GKQZ2Z7e6XWUf5JnT5ZWTRxh4yjatXdlN/SY1iIddaMmRAXVZLKkVgIeDmJnfUkp9Ou
	 Wslrc+SMqZWwUIr21Aogx8V2ezU00vJh90tteZKuA0fe8x/yEazk2G64CbvN6WFV7PWcT
	 lzBg/WIVJe3YQcrGB/iRSm0lgRCB5Qh2CvzKvh2vZX0pNYLcjVTHTTrBIm3vOwnNG9eJ2
	 8CcTszc0OCGgGaqpU3+kqeberOOqD+mD5dCBNqpJlouDmNyVsfL4CfU54lgByesFm2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658272;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
	b=E9GLg3/iZSUY+lSz9n43wM/+a/sjcCuYLdk5cz8Q+KYtsKM+1ocYf8kW8C9bIqie3uAv
	 rwnw3UAS8aTfmj5pmuei31QcEbaCKipVeKNP9SpGSuVjTXZt4BVcuR1vAp+KmmTPgSmZ0
	 qdce5t90qh25sXLEVYtN7NheldgGEftdSKw9+z0RW1nv2zfb3Ik57AJyCkDhKDD2QD+Bl
	 z9nF+rX1oHK+r/Gu+RGpMFyQzbSPwJ5crsblXN03mlNlD1ZRdOEaHMhSUWztwCHXRj4GS
	 49OpQb0vgqIMToY7UkRHFUvQ7kpOeQkmXUty5B9MiMmSWoPVMCQF3hJw6I6fwyi32JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="A/Mmwau1";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ej0LLEa1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0973606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0973606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/Mmwau1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ej0LLEa1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792658265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
	b=A/Mmwau1ifS5fM8g5xYGJ4DNLg+F8zsFs6054zqh/xOgAkmVA/g22xMWYUrK6iKzHckxA/
	T/AsmdjYQTjIQpFxONdR1htTfP/wIY8WbHlCGzmEs0kFTPXuzEH0tmTN6By/tfytfv7ZqZ
	rPOOnuszDmDOOVY/umi+x4Ow/2d6I3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nQarUHZKO1-iO_IYxICg_A-1; Thu, 22 Oct 2026 08:37:44 +0000
X-MC-Unique: nQarUHZKO1-iO_IYxICg_A-1
X-Mimecast-MFC-AGG-ID: nQarUHZKO1-iO_IYxICg_A_1792658263
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso14836045e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792658263; x=1793263063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
        b=ej0LLEa1COd0miBtYfh/Re7eVCX43R1PVUXERJQsuuzdKKJq/B1lf1gSgoGiaw+ADB
         8ROJZyF++ZY0Ksx+LsYy4gmPWE9UFt4r/6/4RpjEqMv9tut4Bn+oM+0n3zdwFTeTX1Md
         XG2NGzh+5odOVOu8sWSglmAWUHtw67EoV2lX+c3EopAfsr9C41UNfboXSF2ZOaYHmn9U
         1+7GpTyRJMZS4FOFpzPgnib8mHMiFKb+GC76V9bD5rYO9JpulVxcVoYVWlfqQCO7Afwc
         76KJoft4PY4fb75dixUVQv8McMHZ/1GxpIbZFxMG+KJMNvyoAgF93GGLy//zN900VA5e
         01dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658263; x=1793263063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
        b=zUFAtffqM04GRQWUC+teSu2QtovcXjWQ/PGS9v172thPo8e6iXOuSlmkVFAlM+15vj
         13RkylIOW85+KxUNDvOYJqKT19kwGpH8eqwRCpro+1PR9WnDApy1U9+cSp5jMoVVSxI0
         +qQUabki0YI9+H/tXNGVeLYCNMtu6Glu+qV1dcKvAr/wni07chi/22hfoeeXoTNy9kSf
         xuw0iaY9Zpua+9oAJFVs65fHyMcfzqe0fUv9elYRFDKXYPwuXR6tyCTgvyXt09FSupsZ
         fCcUwbCjab9XLR4XjCi7F8cEIvWyaSpcLWToCQxH9VZXFx+sZQBjxKJdivr+3hGXqeR4
         UgSA==
X-Forwarded-Encrypted: i=1; AKwUvBw2tQUdd9EsNw3WbnphLHCdPqISnegMMeacaZfsr3lT0hTHYNI0lap5tING8/aEwwmDcMDHKKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxSOLByUJP9b1swKY3Bmva4sHhZfC4HimrY0EtonJjDaTMCnT1
	4FnEk+rFIAg7iXd3TWstg9OVdPRUVEpM3YE8DD5aJ3e5tPjdKiC4l+mLs7+m63LEam4PYggIMBk
	fNcMr0U6ZOILpnQOJXWhC4P2B/FiNnN6uTWxX0OBDVYOimTWwc5TbRJX2nA==
X-Gm-Gg: AYBFou3VGpLnc/Ndlz/vkF+Tms2b+2cy5Ox3rdIB/vuClM3EittC1FC3Zz/FDR+Zaij
	4v4OPxHAOZRMBB0m3Hqjv0LvTO24iMkkmHsdCeTf6D4ZfmHAeja+IelLyUDOG/XLMeFBg/XknX/
	GzAlaJKZWo3aBxvARNzY2trV6TkC1pMg3YnQ2Mdvuymw/WSb3aY0K8QCAPkABn+l8T2CkyLu0ZG
	gJdnaejoBvYa/rV/Sp4Lr37HBHvHRky1efamjoaryzCptm9EYWo0GxMG2+gsODMV0IgLStr9kAv
	0tQ4WFvadEgsSYQoBNNnSeMm1gxzT6Rk4SJ3905QQ+qYtsvpG4ezDwDL/Ut+0jFLQRjqlimOva7
	wqUw3lMIzo2/8WybaW2WKQhhz9HyUrWv3Pl7YFKjV+VixzMTXlYAsktyo6NEoIF852ikO5qkIQw
	==
X-Received: by 2002:a05:600c:138e:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1fdb132a1mr95784495e9.22.1792658263072;
        Thu, 22 Oct 2026 01:37:43 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1fdb132a1mr95784235e9.22.1792658262599;
        Thu, 22 Oct 2026 01:37:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a207b29276sm58527255e9.6.2026.10.22.01.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 01:37:42 -0700 (PDT)
Message-ID: <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
Date: Thu, 22 Oct 2026 10:37:40 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 01:07, Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 11 patches for net-next/main and obsoletes
> pull-request: linux-can-next-for-7.4-20261021.
> 
> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
> CAN-XL devices.
> 
> A patch by Sang-Heon Jeon removes a redundant NULL check before
> netdev_hold() in the CAN RAW protocol.
> 
> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
> for the correct CAN CC/FD frames.
> 
> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
> any context in several CAN helper functions.
> 
> A series by Oliver Hartkopp et al fixes several problems in the CAN
> net-layer:
> 
> 3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
> pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
> calculation after a statistics reset. Followed by a patch to remove
> kernel pointers from the output.
> 
> The last 2 patches are by Oliver Hartkopp as well, they convert the
> unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
> protect the CAN receive lists with a per-device lock.
I'm wrapping-up the net-next PR right now, and this will not make the
cut. Still all the material here, after forwarding the trees post PR,
looks like 'net' worthy. We could merge it afterwards.

Note that there is other net-next material in the same status.

Thanks,

Paolo

