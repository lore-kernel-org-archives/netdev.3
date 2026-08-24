Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05940860D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573797; cv=none; b=ohRGDZd8YoLZIqzHn5IHbnnlDRHpCx6iLeS1audsacRuedOKa0uYx9vFlgqi2JoRXu1dXV5cM3FpIy7XuxUWnQOSadk7Y3Ha9rdrpdjhX7ws9IUYkg5A+smgdVJryPTH5tkOV+OmlpDV8HUI/e3EYKnIu8dm7huArLnpnpNrWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573797; c=relaxed/simple;
	bh=HY4/hY4GCajGPhuTzoCwJqa6n5dUUJ+IAciAHIaCMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPukdUi1QxjhOSa3nmXRpQkxt+eg0ZhMsph8j321lgmIfJuE1vjJKjkgAqFQ9F1WIOfKpa+lHRqrnig00O/DBNFtO4vxy2fb23EvzHtGAEOsBSS2zh9MxXVydUGiwpzrPP4sJF1sGI085W+NshI8Rw5k2j0rLja1oF/3cnEbK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUSf5U+F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUSf5U+F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so30501225e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787573794; x=1788178594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUVSX1eeyklzM5HaiS0BAggEVkmh4XRpRi/E/jeaeS4=;
        b=fUSf5U+FTFVHSbziIYs2tXvW3N52m1z7rkVgN1oHY1GGgwmEqYzAdRVzXWpPURf2ON
         3+IEyznNxlempmTGh7q6cJUgbSiCWIku1541CeA7b4hzq2bapCf6rnTOM4RSBtSeg9tZ
         2YvMEvTLwwVHyz3lMhyM8U37moTgYrNbnlB3Fr7ZDFzJm+b9INWIl5f5Cm2kp3iFXB+1
         mAWgzV7i0MDKyXkcCFPUk4Hm5RHGUccO3aVZovBx2CKZFm9bNpOAWtUIHL4c5CuNoKDg
         ea7YgAyCFD9uRdjgFznLcVLiCAXujM+6vdFw4qu2u/zdU5PhTYFdTsWy1I5/9UjKAk1J
         UZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787573794; x=1788178594;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUVSX1eeyklzM5HaiS0BAggEVkmh4XRpRi/E/jeaeS4=;
        b=FnV8NqeP5lwJvO3HxKIVstoH2m2/6f1PCeONY84Ysi2GvOEEVBx+9KaeJSC0GxrgMg
         akJCHOlFHCdSWO8Xz4T3Fuh71MVNMnOTAGu3neJxKqFz/1kf5IlpItnB2jNkL8M3cho3
         TphVfiOsHo7aD+3vkXEkO7zNKxSbOT/R0MKGMhDiZPKJ2PwXcUIm4hAvncPX3NpBrwZQ
         IcODiLJMADVd0dG5jY35UI9lhyMpxiO7n2RR5J+O7sdixG5OvatReDAUVEINiDfjr1FJ
         p2WpqwQOUAjBtiRwoNd2Ck3MfJngvEsdn51dd8+4CdREvG25LvyVsvAYUhErmWacaypl
         fbww==
X-Forwarded-Encrypted: i=1; AHgh+RqI3hhz/er6AxgobZkZOglLC15fFoccNadBaTDYDSiN4rmjssvy4z/6qqHsrLpW3GKOuoMwCLk=@vger.kernel.org
X-Gm-Message-State: AFuF++l28cyiVhIqr/x54m+iIVh6N9r50jGoi7L5nFWv/qFyE84IEkLY
	CgbrFeRR+DmcgjhLY4HK2pW86WG8yo4hWtUszxZY1eXQIHvwvtyZ+zFS
X-Gm-Gg: AR+sD11BG3KLCJTw75MzQ0NChZFEhGPzXts9vqK0Oe8DTzk/kYPozQuvGrmJC77exlW
	guHpnes9yEIIFsThdpWxwqQuVZ4+J+5QBC/uO6keDnaYAkyitfbFVkEVqmIZy7wuq1HP0A+fS6B
	X9/+sefRYb/5u6T40/neFlaRDqVNw2O7Ej2L8H7Q5DFGVAzRL43h6CPke3KqhjmdvYJWL0Pn4bP
	Dzxe7xrVkzMs4lh4z4Wwa5QBXN6Oq/kEfnpWdrFrpx3YGaIOHnV68WQeP+oeyE6dkk+LvFRgtkM
	YM5z3ZciDHTkC+1diTc9oBnS/hUR3mu8V5LhdKrgp/GulD1FuLHaTDn6jiNx3QIdrpISfUdU3Zt
	uOl3rRSDpRL2mwBY58peN+ZmnNbJ3cYknUdJe8dwykhbn0fHd1OlNxpmVAeSBmz9GU6LfW0p5E4
	SXSDDlP2XQjlLn24aLtwzOV7bcQ65yf1NOOBTTHHYXTQNBwQPGPkX4O2iu8F9U/vF4KBoJ+fS8g
	NwKisHSK84bS0XY4ISdCJxuWA==
X-Received: by 2002:a05:600c:198c:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-499c19e6763mr198896505e9.15.1787573794238;
        Mon, 24 Aug 2026 05:16:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b95dsm87898475e9.11.2026.08.24.05.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:16:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:16:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rongguang Wei <clementwei90@163.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Rongguang Wei
 <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v1] vsock: validate buffer min/max size in
 setsockopt
Message-ID: <20260824131632.2d325c42@pumpkin>
In-Reply-To: <20260824091257.136269-1-clementwei90@163.com>
References: <20260824091257.136269-1-clementwei90@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 17:12:57 +0800
Rongguang Wei <clementwei90@163.com> wrote:

> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
> do not cross-validate against each other, allowing userspace to
> set buffer_min_size > buffer_max_size.
> When min > max, buffer_size is silently clamped to an incorrect
> value. For example, setting min=512KB then max=128 results in
> buffer_size=128 despite the user requesting much larger buffers
> via SO_VM_SOCKETS_BUFFER_SIZE.
> 
> Reproduced with a test program:
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
> 	   512 * 1024, sizeof(int));
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> 	   128, sizeof(int));
> // User asked for 1MB but got 128 bytes silently
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> 	   1024 * 1024, sizeof(int));
> 
> After that use getsockopt to get the buffer_size = 128 and
> buffer_min_size = 524288, buffer_max_size = 128.
> The buffer_min_size > buffer_max_size and the kernel accepted
> contradictory values without error.
> 
> Add value check to fix this issue. Return -EINVAL to userspace
> when setting MAX_SIZE to a value smaller than the current MIN_SIZE
> or setting MIN_SIZE to a value larger than the current MAX_SIZE.

That is going to break userspace that sets the minimum before the maximum
when the new minimum is larger than the old maximum.

David

> 
> Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  net/vmw_vsock/af_vsock.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index a33b2a2d381d..5faa30ee8745 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2050,12 +2050,20 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  
>  	case SO_VM_SOCKETS_BUFFER_MAX_SIZE:
>  		COPY_IN(val);
> +		if (val < vsk->buffer_min_size) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		vsk->buffer_max_size = val;
>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>  		break;
>  
>  	case SO_VM_SOCKETS_BUFFER_MIN_SIZE:
>  		COPY_IN(val);
> +		if (val > vsk->buffer_max_size) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		vsk->buffer_min_size = val;
>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>  		break;

