Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7262D94BA
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754990; cv=none; b=dv+B2nU9GUvIoH4AUa5VPMIq44dHM5Q72slHI6d1JulJKA2eOG6uVA0zjaqXN/GcAXDzj/MTvMm0RbbfQbpR899P0W/gzDjXpYxefe23+cbjqSr2yn8UFuoPo+5e0CsqDfX6T1kqugMm1TPh88dXURHA31F7UciyXjXDuAheiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754990; c=relaxed/simple;
	bh=l9WoQ02aWqk+OnKucwOINo0x52jttggel6Fk86nj2NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQwRmLYKNipqujXTJNQ7yAVak6h1fNAghNCkl35MvhuPhpZl+iEZ5zGwxH1yNFsnLkii2sXmQcyMpWNSBuB0+xSAxhIeNJui4hUDVELoVg3/ih/ULaajPwrq48usemaI2lMsT/K5Fy6mLNbYckTOG3SBrpeUAuzLq9O9rRS1EVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfEYDK43; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfEYDK43"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e5733a5aso393290f8f.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787754987; x=1788359787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdRDLBzJgA6DqtaoACBLAqLpY4rbPCJfQBSnB/1ikN8=;
        b=HfEYDK43ZSIQkSw4cjsM/2EbBxBQlLClG4kwxYmgDY2LgnoXyM6qpoJc6/4Yal+Yr6
         4kKuehLdwdESAdUuc1mo3ZuqGZfUzweaBc+N3vkpEIVTQ7AaIAVlVHdGFYUka6RK9kY0
         2AzZyHdzI4XrkbItM3ArNmLAV+BKhYcSPCE5zcEDwKnGRAj4+uyCFkNZX3W+vm8ea0fU
         7zFLzvEuIytwx45f2D5n+v9HGaSI94eJ3g6xoqvAEcxxIG8EwLcISINpu4/FWhMmzDG2
         ejYlIdHXSoLA0NJ2dk+2oWHD1DY90vc36Oo9WuKsf7Z+BRO3SsipnzbYjODi2a8P7aIt
         t86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754987; x=1788359787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdRDLBzJgA6DqtaoACBLAqLpY4rbPCJfQBSnB/1ikN8=;
        b=l7FmVOUI8j7B/OaLUllPr+qcPsoBByum6Ut1tPAlTnFwQJIuYU+EMz+E7AnXNYq1zB
         9mp/AukEG0duNEa3L2+Nh0t6dNygNb9X7Kw8hDDZv4EaxD1Oj1uTRYqg2MzUxCcF2ilo
         WT75haTXI9SygHPLnaGV5L9EG0c9728BBJTQ5O73OvJvAr2TQx1iMNdYhEREjabXMcRA
         d0X5kLAOVoUrKhS5vqEEELRQ33T0dF0bdT9J0k8y1KmR0LGmocqcyb1kMITN6YGrDqax
         Z5CZltHxN1oXVkclV+mPy03a6SpERxVMoniFINCERNMxD+A7S4DCj+yAXFY4I8uVFYi1
         DIFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFjrp+YCM2v4x3xz7cbDXWK6DffAtuxUGBnMYRkRfLf5yeQFXrrfC3RlZvHMaQJACMbfUNGn8=@vger.kernel.org
X-Gm-Message-State: AFuF++mr5YtLpVru+DV8tVEDpcxbT57V/Yy5Cvt5igav85yVY2knRnGr
	GVz5mq7gV8RbXI9sJwDyBrG8jbXjR5t6cVCZfV9jKgvCmmNeCeEdzSa2
X-Gm-Gg: AR+sD11AumjiwYZt7KD/Sw0kW80m5neeFYEY4TfsnGmzRq8iFNnVrdBA0PLU4NYD5jj
	leOg1EWRlTmHdqWWnhQ/94b9o9ufFyshxFJ31cIcvtITFYIJ/06mqoajCrJ7obhCbh2MeOTZe6R
	c9Cel/6Aa9TcoJ0mIJAmWqG81cSUPJ5/rJxdCV4I1xIgj1qxk3cuZhvuzmwJMV20UrYYoHjJbv+
	gYyKQcMssLma8oqceYNAbqeER/lQFaeCJ1562BH4lOv9/0lUo2LjU+zXlpVL+8KZnI+XWlQq6/E
	dUQJkjzlf3RmCj/wxByY8Kqmip8XhjgeHLY2sHYv6ccxcD2bx4HRHhgVKJkW5ocE40YASIJkTgM
	18eNG8ofenq5DMztsBZnOCXSuK6R4U11Hila6RSw+XYUYzJn+WF1i82RGMacoQR3zkbxc/lp62R
	e7y9KzB8/6XH5WB7X/BCT4NTmgi2UwBYt+fYW+yIWZ2y/CIgg7vOjT+T1ea2NID/B+iG2agmXOi
	d+J7YF9blyFJ6tBWrd1A4EOCDnzbG1M5caSRsuz60hYCpU+eOOT0dG5PWcT+n9hs89uSz7FWNJj
	QUHMdxMDluVW5xLZ
X-Received: by 2002:a05:6000:25ca:b0:481:5bce:44b3 with SMTP id ffacd0b85a97d-482e26c3611mr7897720f8f.16.1787754986456;
        Wed, 26 Aug 2026 07:36:26 -0700 (PDT)
Received: from [10.153.241.141] (82-132-228-95.dab.02.net. [82.132.228.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc10asm3118431f8f.19.2026.08.26.07.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:36:25 -0700 (PDT)
Message-ID: <75cf5a10-f7ae-4b4d-ae47-1556a30d76c9@gmail.com>
Date: Wed, 26 Aug 2026 15:36:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
To: Mina Almasry <almasrymina@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
 <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/23/26 16:58, Mina Almasry wrote:
> On Sat, Aug 22, 2026 at 3:57 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b4237d0e994d6..1e34f50770446 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1170,7 +1170,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> msghdr *msg, size_t size)
>          }
> 
>          if (!sockc_err && sockc.dmabuf_id &&
> -           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> +           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY) ||

This check before your diff fells off. From a quick look, via io_uring
you can have a sendmsg call with dmabuf_id that would happily pass this
check but never goes through net_devmem_get_binding() and
msg_zerocopy_realloc(). It's not much too problematic for now but feels
dangerous to rely on it in the current form. I think we want sth like
this in the end.

if (sockc.dmabuf_id && !sockc_err) {
	if (!binding || zc != MSG_ZEROCOPY)
		// fail;
}

> +            zc != MSG_ZEROCOPY)) {
>                  err = -EINVAL;
>                  goto out_err;
>          }
> 
> It will return EINVAL instead of EOPNOTSUPP but I think that is OK.

-- 
Pavel Begunkov

