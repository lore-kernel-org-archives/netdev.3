Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000746985A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620825; cv=none; b=Fvap+0hIwVfds/3776aloNjiJqJVxAbbf726umrFkNzQMY1vdDpSHu1oRiCaQL00Zqc7t8IzWEbVTww2Cr3xAHaqMOKpGpNvINMA/StQHVlQB+LipjPHXWPgCZYSUreI8h31Exmzw/dKCEHLEIT9fHb8DjD9vjMOxsy7baM/x3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620825; c=relaxed/simple;
	bh=mIMg3GpGnjxCOF+x0X883SsbbzLGZeniRtVjG86VZ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F16TXPdiJynnkXQI0I+eGxRcn80AL/DQEW3mZeFkdwt58/8VgZmzj0HKEqWVjEmCydecEvUp6gssTLeQ5mx03NaD0Kq+mcI/tVvDNmYrzIsrBBzgLpHGJg43aRJGwRefSfmif4s1rlRo1f1+W+UwelxPhdO5Z9MLlpMBVWEAR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsAU3APF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n2dirSnU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsAU3APF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n2dirSnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786620823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2FrrsRU5V1HJtH9l/0Gbv9BbbcK3/MMcp3Hv+XyxFk=;
	b=HsAU3APFdvUGLYba805rCEQ+UhMdhz5haYEs6vL9nvxtkGHhnrynp5f4GIIT+wQMvH1jQe
	YZ0xXHQw6BVDhphnMiqKZ/dUbCXDoqfq8vOVRv57OKIhu6n7o9V03EuM1Y9YXZhBw6Kkhu
	H7mSKczrNHo0EmGdpXkED1nR9z95o20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-z9SP-4T0M5eRLmSHboev9w-1; Thu, 13 Aug 2026 07:33:38 -0400
X-MC-Unique: z9SP-4T0M5eRLmSHboev9w-1
X-Mimecast-MFC-AGG-ID: z9SP-4T0M5eRLmSHboev9w_1786620818
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e658363so438060f8f.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786620818; x=1787225618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J2FrrsRU5V1HJtH9l/0Gbv9BbbcK3/MMcp3Hv+XyxFk=;
        b=n2dirSnUQoZRAqVWgErMaBqjxhlekJ4yLzIlPX5fClwg63uwZvGRebHGAkwNnAbRyq
         nwms+xp3O5rkBQwira3moxEHO49qe+rO2rZHKwkHhI4OO549YAGUKeaspJctKKXFAwmI
         PfHirYm3QAXVTTSy8VN+i8qbUYVFh0ApiZsMtFUwmGpJsvN9WgcWTBhvL6C8zOG08W3X
         xjFVgduzlXj84aFCIes/XcYZaHCb1GoorBF3bv1ijDjhzG7Z59AmgOETVy7ZRfy0pj3N
         xfx0fQ3fKL4uGoJPVXYc4mm+5ji8eqVhdiYjv2thqmVFJnadNxlQbJpDj4A6MMYAgIvs
         aO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620818; x=1787225618;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J2FrrsRU5V1HJtH9l/0Gbv9BbbcK3/MMcp3Hv+XyxFk=;
        b=MJrOUB5oWCJ2l0L5NC/e4bY7xeUczqsaO8+aVd31MAyX2PiUrCzqM/Bkgr0Yv2zsjS
         1MHuKknuBvZtLENbQ1P5MMYVnWIyX/VXjgWbfmd0cY0My0O8/wJESl8Xk4gPWgSfrJdE
         U3PmvumA6TQJBA78Tg6kGdx94CVr0qmT87/H8SAcII9EYrekiJ3hTESDu/loK46/VpQF
         TSovwMeWgWa8Z0xKYrZItX2DXF0dQDmPsnvK7v8V7N9t+CAud8rb55cYnJVMrY3Pczhn
         LQX3TYGYLcPE069PC5faCzM/VpWSTpYEn1fRx99aNSpjklCAWWAb3z0bpd0aylagIMlV
         8X4g==
X-Forwarded-Encrypted: i=1; AHgh+RoJTTGP98w65kzK6cKD7m3EucOkngTSD5bqssUIyB+KgppJhuAjK9jM2XlvSkc6MCwoSsGJGUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGh/eAcm3LQa5wDUz3W6tsmnQZjHEjRloUTvZ9PjVim7jVV4ip
	jWTf9oyhNbWVedMMG7GEh3vzPSO99slMHF+EDwE3dExWXpcyL6TbCjmiFHfNWW662gERprJhFF7
	ycjOSLYBwFPWLaXzz4gvrxOttuLJ/txHft/8bV/ejCf9YsW8oCPzgle/e+w==
X-Gm-Gg: AR+sD112fLhA+n4SNJHP8jSFs1Rgk+PiUT0TITeth9vw8jvIfhXKimOXl2EuvkcBzz1
	ziEMs1PIYV8Cylb9Irf64jzjK7AUjzJ3PxvGZ3LMbMd5upBbvs3FjLzYzMTZ84fsMBuyM4YinSf
	h3X+/jSwKYyDDZeorAti9COOrcsYEOHSVMGbEfm71YCJO+8DpWnJIYJL80wSWGabqfj/iL9B1ck
	IE4MN0GBazicGMDQiFwXnWjjOUGecQtm7Swqn9bx0NW/aENEa+S77Qz77DBjbPkyt34lfQvKXb+
	4gPaHuGmX56M6kJDuNxQ3CLwHH7COIcxmyq1SQEJVtyOf3bGAo+iiRqD/8KYuXEM9NZ32KzDNuj
	93B0HwH0IPpCFimxTjjO9aji2gk1SL724Aum/M4k8f7fd2/W8lm+F11OoK7l88arrUdy3yeBPrc
	s=
X-Received: by 2002:a05:6000:29c3:b0:481:5048:1b78 with SMTP id ffacd0b85a97d-48159ca613bmr5523978f8f.5.1786620817764;
        Thu, 13 Aug 2026 04:33:37 -0700 (PDT)
X-Received: by 2002:a05:6000:29c3:b0:481:5048:1b78 with SMTP id ffacd0b85a97d-48159ca613bmr5523905f8f.5.1786620817287;
        Thu, 13 Aug 2026 04:33:37 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af441sm6497140f8f.22.2026.08.13.04.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:33:36 -0700 (PDT)
Message-ID: <4659a101-904b-43a7-acc0-012020887088@redhat.com>
Date: Thu, 13 Aug 2026 13:33:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: rsc_dump and hv_vhca return NULL on
 create error
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Eran Ben Elisha <eranbe@nvidia.com>, Feng Liu <feliu@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Kees Cook <kees@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20260811061637.3195320-1-tariqt@nvidia.com>
 <20260813092655.GB196815@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813092655.GB196815@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 11:26 AM, Simon Horman wrote:
>> @@ -63,9 +63,9 @@ static inline void mlx5_hv_vhca_destroy(struct mlx5_hv_vhca *hv_vhca)
>>  {
>>  }
>>  
>> -static inline int mlx5_hv_vhca_init(struct mlx5_hv_vhca *hv_vhca)
>> +static inline void mlx5_hv_vhca_init(struct mlx5_hv_vhca *hv_vhca)
>>  {
>> -	return 0;
>> +	return;
>>  }
> 
> The AI-generated review on netdev-ai [1] points out that the
> return; line is unnecessary and inconsistent with surrounding code.

I'll remove the line when I'll apply the patch

/P

