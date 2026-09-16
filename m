Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384473BBFB1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577642; cv=none; b=eToPrmyte/OeRY+JvR6WeU5iGdeQZ16WlEoBIo6T2oZOH7n+RP3QIjbRdfqW1gIXki31N1bZwLu1zMYo8QkusH3SHrHbNIB96jibGx05RRcyg1t7s97zMmRdtTMQ3WO8TlK7tr8G1YQM5eDl6hOdbVDOSfJnzcB768nqLdyiv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577642; c=relaxed/simple;
	bh=EM7CE+WdCTpAe7xOGaTErjOkfP5tYkgIqeyCvMsIy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWRIL+x+H6hT5K6t5n+2h+VcPE4RqU5FrFLgTGb/U5t6KfBm/x1DnmbI2BBuFsPA8WarfJ1Hjlfr9B4PnJRDUPHsZgroCGIxcnBW5pc5dOKoZ0ETMHNw5tg0q7XAGrgUZD8GzrN/W0+H3ggt3DyLXo5Q2B5wJn4DdFcwfRr2lNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APOYAFfI; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APOYAFfI"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6bc475ffcbfso552074eaf.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577625; x=1790182425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=APOYAFfIbWCVrGQuRaTBLCgMSL1JCI7tgh9x8gmAONSADgnCnY12/vJ2wxHvfAcHOW
         39Fj6c3KHR5m2Jcz69T4SqWjX9DQYqJDTr7ot55Zp8XUHGESrq/4xkGK7VnuH3EtDebL
         h55MLPATOrJm4deRVrHgE8HmFAme7AQ6CHOloGdP5khJbuKvGCqymGAjMwn6JvE06ShE
         0mIIbLjn5OcYETtXDd2WxchroRZICEL8jKAScxjUxhasSL1S62YNq92kJeJ1jN69M38Y
         k66ReB/Hy7AfKBWs/CxKyQjJ22T9iO0wWaImNmtIz51UTqkKDhxM7vfIzGwgS4VBhzU2
         051A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577625; x=1790182425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=nD5V6h8tFJchysQulhSWMKkWZ9C43O941GAs3Q9A15B6TP91UFW4qpdPem/0B5vzvQ
         iU5p7bBRKAfRpkqBR0qJ4AyLYDCw9pNWqm2YZWfBjnrHq3ZjP2DJa7dLoLT6DSwzIveY
         IHvl6OZiLI0SPpf8iw0seoWagUHram+se2auJoxrw5+xdBao1JMxg7728BILth3SOyHq
         nWJgPWKdwgAkXKMfG3vrGNAK0ehCg4DpoHG5itrmd4bfGnnjslmTYFwGsI1ePJz+CS1H
         /SvUPd/rDVOgMzhrUI+MUn1Q/+BGkpGLRLITzuUvuLYAmzmcOt5BDOpzNsfyvvsENz3+
         uF0Q==
X-Forwarded-Encrypted: i=1; AKwUvByscewGhKuSUlcsACyfwz1yYKx5h1WeTyIzLlsYzkLYhk9U008lKhkVQwTUQjIG/FGWIjQBgVU=@vger.kernel.org
X-Gm-Message-State: AFuF++kchGbIZPr1QicuEJD/+xUBnt4Pc0JGBmHAaEQxnbMUoYlMPjwL
	bt2305NiGh8U8Jtmw1xcuv/9kZqyaryP3m0LM7oL7Y6yR46enV84AWgG
X-Gm-Gg: AYBFou1//mYfleXZGkH5VbcZWUHCu+H5dx+lc3RglCr/FEmW6o3KNqE/IDlhj+6t4CM
	+95COpVNy57ZLHjhF2Re1nHa7ikxNjEcCttsl39JCmjqmKOq2xUjfVFtrx/ORZkeNhfRCAf4pMW
	ypE4FPvo4A0NdpN6QJ/8G+TcWtmxIhtNTvgZQ7nSHnHqbL/2aT+dUAk2j99co9kz6+RaesFrKiX
	ZRaBe+tsz/UleQ0ETkx9Znz3ozOo2uKGjRE1KfjQlsLO1u4mDK4STUI/+B82egbcUgNIFgj1kVx
	gkBKjw5SPwlxUuAxbwinRCXHNSIMuMGVgYg+dyxEc7qIZlxzKVcsV2EzylbtMcmuYggH9fi/7Sb
	BasL9OZ98YtCAuDnbzSrZ6tRx0tnOprd15kCD/kKsWVcL6+pqRPBoftXS7iZQTBAPTNAcNDCUoC
	OeEZsAVRxTf8KISFgc16UShQ3N5r9FGpEr6JDiQ6q3c9dNZx+FJn8jE9X1Srm8Y6R1WepaP40Vm
	9Lj7lfeBt2wvZ2dcI61
X-Received: by 2002:a05:6820:827:b0:6b7:46e9:96fe with SMTP id 006d021491bc7-6c7d3fe8d67mr3338481eaf.46.1789577625513;
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a786574sm2835261fac.16.2026.09.16.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:53:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqrJjfJHWXJafehx@devvm29614.prn0.facebook.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
> 
> Return before calling __vsock_net_mode_string() when *lenp is zero so
> that the helper is never invoked with nothing to parse and new_mode is
> never read uninitialized. This also prevents an empty write from
> locking the current mode.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> 
> Changes in v3:
>   - Move the !*lenp early return before __vsock_net_mode_string()
>     instead of after it, as suggested by Stefano Garzarella.
>   - Add missing maintainer CCs per get_maintainer.pl.
>   - Add Luigi's Reviewed-by.
> 
> Changes in v2:
>   - Return early instead of initializing new_mode to the current
>     value, which would silently consume the write-once transition.
> 
>  net/vmw_vsock/af_vsock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd0467..XXXXXXX 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 
>  	net = container_of(table->data, struct net, vsock.child_ns_mode);
> 
> +	if (!*lenp)
> +		return 0;
> +
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);
>  	if (ret)
> 
> --
> 2.43.0

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
