Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD463BB694
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168440; cv=none; b=Q+ZUfMeNKKSTemOVwr0tBl7a7AhYkUFo+bvNe/GyfGcWGTbdw2sFV/dRCwBRuXDbUdbktWWY3GEXsmxTBKVgpE88hM7fKl4QovcDgcnoAlvYjiZTdoaokD3T9WavfCa8eJBsLvVWuncTRexkVcV9PColwii2UWu+4TfyRYk9rXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168440; c=relaxed/simple;
	bh=5yQMXAwhHnYZgBYKW2MDPK0RSrlLyAG003TZ8UqAOWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNwiWLDjqXdpLYhHccwbBnzoy1jckTizBZu3x4UDyaEfvaV1a2kqrldfLSXh2oaPdI/rufEmcKSPS1aFHl6gYMivZSBpSxwEa3HsKwx7BX1nj7TPh7lRsslGBnD6MZJaMlMT4q3fyho3o3bngfLhENhug8tdy9MYbV2d0fBps5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYJ3pKh5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYJ3pKh5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf452def93so510885ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785168437; x=1785773237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eaZER3QQCcXPH1+PSyRnvRqQoWpnrxvjkGDsYgSg+gg=;
        b=KYJ3pKh53Ehomf0ky7uWNfUOImRVjJDHH7PwVsEbCKbnzBeFetgLWL74TyrNJYOKfH
         sNopta529bPNyNkUjUlop52LVlCn8j7Kd5lBNFsIcL5X3zvj9tv9zY3I9hfOxk36qJr1
         a0dlAhaclmKjGf+VfLL7K/sdv8lvA1mxy5HA2yCkJvKlqMw/RktWz8zqCIrJ1fqYL+tw
         MPUFu0bxDl0gV8yNBJ0I5GoVbxH8luIqzjX6W0LkCh9iOU9r1MGuKSwUr6R2qW8BE8Rh
         U1igVajDP30egZ/diOKjohGOVSeZ0Wvj4epeW7DfnLvMZHMSAsk6ABy431/yXgRlf+PX
         f8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168437; x=1785773237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eaZER3QQCcXPH1+PSyRnvRqQoWpnrxvjkGDsYgSg+gg=;
        b=FsWHK7IfEWs03F76PeKzUj3WlD6uZPGoN1s4aVaaoNBXokjj+npMNXkc9F5VRR7Azg
         zBpOwGrE2mFBYjXAqD+KKD3/4an3iCEKUyY54c8jktW52YPa/0Vy80y2Re2q54gkU2fd
         oROZdjI8np1JWn+ym4MsCN4y9vjlzFDOGG6H2QOYkLDX6n67bBXU5+E/GiWk6h44Wu0Y
         7BshaTUVAgIFx5zzB6AHRbMdVi/HQ6U8Nk4QRQp3C6LyxmpalvDKRjaQ5xe/aW9gP6lb
         l4K87Gh3X+LMbdIZPUjTT99Oki0fRUE8eC/xgDEAB83K4nPMDzpuRguy2dZgfS+q+BdF
         XLYg==
X-Forwarded-Encrypted: i=1; AHgh+RrVfODAha35/mreaEgKFeF18pMF/SaOzUt0oAronKRtgqyzIpO7OPWg9EC1iLl/u4jupvFaZ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtKLMErZUkLCM38K7ZFyTw2AyBJGYP9hSpsbnVnBM8Vuz/mvB
	M7JLX6OE67jM2F+FQG/9H0kmcp263MFZ39YdikrB+EmUgW5w5bn8cYkdMSXQEg==
X-Gm-Gg: AR+sD11Gvpd+fMOwPAxVGhQcKsa5T04woMw6BkZmDQNCXXC6wkZIiPXW70T8b02Of1u
	OpH1Fo8sh03sT9sg3FinL0cc+ApJNlZDoEWKISPnnbPWvvXFZVppXBJ2+V/yileyEnI4LwazF67
	gOnMwI5rnruehD8c1YNPArWXSxNUR3sdQb58CWH9LOx+yzJssh0R5UuVtNhvKreXYa3SU9Qlxq+
	z6C57vfqi6MYSW04g91y4/d1m9EfO9CdR3gHEVt+88WtCAei9fKsw6rT0VR2zBtR4ZqA3Q7Nr1r
	zi5qF1bBMxo5j9Pge5LwoO/Y/vCT2Sgxsp0aw12Xgwy+NP0aEsbnpDtqz6jAqSwh4ROFEfwXQW7
	zk0bSyPgtmm5eNYxDdY5ANk+GPc1oCZ1j74L99M3AXdtQbtpFW6CjKMliekTIHuLBfCeekhs06J
	0ctDk9BzzZZngszCKKzbnzhAU=
X-Received: by 2002:a17:903:2f84:b0:2cc:80d6:b72 with SMTP id d9443c01a7336-2d00e890003mr565665ad.20.1785168436897;
        Mon, 27 Jul 2026 09:07:16 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bc49sm37383445ad.7.2026.07.27.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:07:16 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:07:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Message-ID: <ameCMuhluA6j21mL@devvm29614.prn0.facebook.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>

On Mon, Jul 27, 2026 at 12:19:37PM +0100, Pavel Begunkov wrote:
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
>     the former + for consistency. 
> 
>  net/core/datagram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..173b5d97bd40 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> +	if (i && skb_frags_readable(skb))
> +		return -EFAULT;
> +

Doesn't this still break the allowed scenario where the user does
sendmsg(not devmem) before sendmsg(devmem), and tcp tries to append to
the write tail skb?

Best,
Bobby
