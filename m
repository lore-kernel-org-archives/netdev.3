Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C0415F12
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352923; cv=none; b=Lw3FJPMsC9cDMpVD/OU7rQoBCjsOmWa/q9VHsIRFafYB31FCAWVAlQJd91bvCy3SoVgbl6qjTQGjlaxDZXOJLei5yIPJ0llPtNgI+vqaXk+AyCoe3FEf48h1myvBFIpHBGU7qTkXe0gaZtzfm2A3ff9opGHaymjfhRRiVSZtn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352923; c=relaxed/simple;
	bh=z8+NKlZVaJg0D1viDndIi21e6QYlTGrfLeaOwjDv2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8H7qXQMUU2okjtCsL/xfSWWHdhRqK5ec8D0cjP79uo7Mu9cspv4lcC/UA79OhZkffVY0SywonkCqRrZjcwo0zoVQXSxZxsg/pGWxhcNgsICZWnX0J7ClTIg6S0AgQQIdt1DLJuF15+17eOa4nNab7QR9gFSGKRrGxhyaH3M9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETKAfiMW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETKAfiMW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so3014825e9.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792352920; x=1792957720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=ETKAfiMWGZMMjK7jvf+EaLF1zybUc4XOoUGXkkdzOT+59t/NrkQf6gawa07DV3ZO3I
         titJE0Pr86WP9hXNUrXseD5dRyKG/JCU2T2Auzz/SdVKR11XM+Rtqeqse7uVZ441dMWW
         2nO7O1Pv/jQF3jd5uyj73CIq3I7VmG9Uje8TcM+mDAYhpZ4Y+Mz0S6CDfOrCnFLT1wzb
         WEwWqAiZM7DGBXwiyrnfa1zqwgDFgo/+muOr7p3zy8hkfm55HmSTagkrYGealGz7Xmh3
         eCjWOKR4BZBk3KZnVlDN90n8H+I5rDwXnTa6laULzLc6pXGM7j2izhEefpar7jW0tfXn
         Iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352920; x=1792957720;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=0wJk8cJb2yg6GfiQPieqOLz9PmJ4CUAU8KgeG8wOz5rKuIVdmmyQ38Xg1/rYHyeObn
         Pl8cxrVjjZ07D9ldigNF7pAGi+Cmy/NrAzaf+UTahSKzKkXJy7pMBhfVcUx6bD7fVH/G
         uapUbMtkX8M2Dnlr3UqqP6AG77VadFwFoP4lURLzfnsbqg81FcejlPWv4NpSR/mPjNoz
         4+x9Tn7juRwNQFdqTSCOdOHNZE2MYLn5bFw6kJauP+0i01byW9VL/729Ch48+JpXo95u
         XDYxIaUyvbfDq6yT8FHmxliH3anqTZUjj7uhNJrW1eJGpjIkBruf3m+cPZ+hBny0ZjdT
         yohw==
X-Forwarded-Encrypted: i=1; AKwUvBxEp4osmVN7hYKSSBA4yVeTA0rAj3Ek26MVnkqNsqbCr7Y7FUsjbSIX0a1nZXH6kOVfUBMrBqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfqrdHJ+/a/JmmeZHV4nnqC5ljl6UgZOYcKw9f9OxYIyK3ExUn
	bs2QtnIw8fe3RmeZLk88ZSw2vWD3wrf8EuhaeRmzjUXFyr+oUF0JvAMD
X-Gm-Gg: AYBFou05qD8Oy1Uz5zetEv7XW66swxLNM+KCtkhX10tCzap6/JtIcmfh0pJR1k4pwAp
	QnAZVXnWb89kU1AN5xyjKyKHfETJsqewUbF5ibVhltavLY7OHJvcEx69O0mjR97zWqfV61dYnjM
	XUSUskduo7y99AiJFTbkrQlwa5Htt3UY1sRe5Q70sKvZ1mDHG0+LHCeGmzw8BLly1aGt3cpA49M
	XPDt4C/TZjgq+LFMJw2F4QfTzFya81Ampekk19ylnEhA2JxdR+b6Rj0TLXZ6dVmC56nyJOYfbeb
	Z7c0Zf72/Cb7NyxTkOChUxqCE2lGa3WacTWMt691m20pryQuByttwkvgrRE2QHl8pbzI+sct7vz
	coKTYcFCn+4sgJhXr1jXCvpxa3ldP29HcwemgUmaoCFoL0rK7XAI1An+SvnIdxGFSae3GjP9TAD
	sbcTw/+g08I77hi12a55P+J5lzTurTb0Bg0dzmSKMXM16f2aGelTpgcg4OVGiwqEgyVlZ9W8RF5
	cqmII74odGAxe37D5PGcLu9/M8/Kyzs8H4=
X-Received: by 2002:a05:600d:8488:20b0:4a1:e3e2:93e0 with SMTP id 5b1f17b1804b1-4a1e3e2967dmr30105055e9.32.1792352920294;
        Sun, 18 Oct 2026 12:48:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm18886835f8f.54.2026.10.18.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:48:39 -0700 (PDT)
Date: Sun, 18 Oct 2026 20:48:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, eperezma@redhat.com, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018204838.4080b238@pumpkin>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 15:24:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > against the 7.2.10 source tree. I have reproduced the leak on an
> > unmodified 7.2.10 kernel.  
> 
> 
> This should fix it I think? Can you confirm pls?
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vringh.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..4b097170bd36 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
>  		return ret;
>  
>  	if (vrh->use_va) {
> -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __get_user(tmp, uaddr);

Can't that be a normal get_user() call?

David

>  		if (ret)
>  			return ret;
>  	} else {
> @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
>  	tmp = cpu_to_vringh16(vrh, val);
>  
>  	if (vrh->use_va) {
> -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __put_user(tmp, uaddr);
>  		if (ret)
>  			return ret;
>  	} else {
> 
> 

