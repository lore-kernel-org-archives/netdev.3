Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3333DEDD
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276584; cv=none; b=aWYvoauwxgmOLr651vna5xyLNi62NaR8LCt2y5c0ltZWKNBfTPvBDm/AdfTwXhi84kVCq+Qer3k5Jh8EIwEORhvPaRJ9FKjgXTHByRSFM4Kj2OAP2jJDcovc2pbTtHkAXvuTweFvfPAFVmG32S2NbwwjwMmg2SV6COdH1qv+ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276584; c=relaxed/simple;
	bh=OgfKQGcUft8+pubZB1n8Cb5kpcRbRtLkKcWVdrtca3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyDYqCIh+mizLekFiQVHIVh25dVcxKNxQomCUO0D6QXVWDjYUnmEgxFEX7HARjA2JUuigKHYgJ/9jRfWpBfHm34J5+UMUVMdm/TuQ4Bmm8N+P1/78Hy9rW7xMvpf59i2DXZaoybMINdft1ssAeh7Kh0PX/x8YeATO946DTRL8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMLWAPlG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMLWAPlG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b27c7451so8637535e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276581; x=1784881381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NLZAfRK2x9zkSee/fqTuHPNp25jE6qaj7rL/KrN+u8g=;
        b=oMLWAPlGU2OR3WEZegsvP74B/Gd742nWs6VsZ04tDu3gwme40AUEOplGxxP514/B4n
         XVLVHEyH6jcE+qV83iuLm1mbEORVJxF0hbr21NsxedYt+EQsTVlnXIQl9CtXj47EyEdY
         u4bGBS7A3kixYCjL4IzEPB0TUIj/FcHdxeG7betOJ1RLOEamIWsmSVG3l0KKkl7ZvVe4
         ieIhEZPnRA3aRIZJd++afq0BUibUthoQzCqufhurnvvpp+DZR9Ex/XOkQ+FpiF5VEmIB
         YP+w8RVIS8FZ3wPHfJB6QLOuZYJOotcOutklD8iglo9hYqZzFuo4K7ThUv90SiaDoWVX
         wQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276581; x=1784881381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLZAfRK2x9zkSee/fqTuHPNp25jE6qaj7rL/KrN+u8g=;
        b=d5FtWydUS6ZV4VkzqfEpcUsz6PqNONsc5dG0TxLaD12OvHW6PlrmiTuEK6cTfepard
         tPPQkX6yoCfF2Sr1950Sc5eNivdh3ysZqNA9CmWm+vW5M17iPLVihy0mUrqErt/lVTC6
         MV06GtPdaam0nCQhhLlXplSTf9WGEIfPpCzwaAf0FVMS859gO5jf+3nMTGCm3miP2fw/
         P7ovJJSIQUa7fCkHuK0EZFpMoI1417MISt0Mfg5LQy98NZObGDWLRUTHZ/pOwSiJ5vQ2
         WVe+h5AQT/518eW361Y6BbpunXTrK45QzdDbtf0YpkZUxqL9c6CKQbwYiGn2OgvysVcc
         /1JQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1y/k201tNzTnwvH3qXRFk5u/0SLJNjISxyb2NVAEvaCiy6BxgFMnFybGk/lEre57IBmfTBWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTmSNL+Jfklzx/NwEhPHwzo2+AeNhMERlRb1Ss8+TTJR8xDtZ
	MTvyAh4M1FuotSSqfJNRSeqMyJ6yx75lGUphNmuGzYKEs0mPRTC9HeJr
X-Gm-Gg: AfdE7cl9n55+9lPxvnEE1R3bq+2mFmsyP9H8Q5GTgEhW+tUkKNqSL2ovmAMdzYm3jFV
	crl51jvxpnXO7UM6VSqOSFzfsnUTPhfH9byC+Llfnx3+4y0JeLvfxQcOF77IPMjwxcJZu8Hevqj
	RHKqoitfEYjlhLccpM3FOMXwqwcp4KooKqJkOQEh9R7qtR322j6ZFE58iMV/lua1hwKGYKHpkfz
	aGAni+oFwv9PFamWXtNuLdz7StOd67+0OlWQrsZAc5qrFw2iUoPeevvcnh3cTx7aXhRVwkCfNS2
	nbHqM5DmGrVWoT3iSc1+g+45Xj8PtWl/5uEt6UjZY62uWK+hS2jwMAUucD2zY09fqjgfmwhl/tP
	FCQAE45QOO7f1eVeMsuEdWZVHMY0FtM4qCDJCzlIYNOabvDN6s5LKADGq9ZV7EJtOaCcqRH6zAP
	gMaGCs9gXw9ZGXzs52kbb0kYxIauS63t4h5iJOOO0=
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-4954a323b14mr16486755e9.7.1784276580733;
        Fri, 17 Jul 2026 01:23:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm59577575e9.14.2026.07.17.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:23:00 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:22:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont
 <courmisch@gmail.com>, =?UTF-8?B?UsOpbWk=?= Denis-Courmont
 <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Message-ID: <20260717092258.776e63db@pumpkin>
In-Reply-To: <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
	<20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 06:00:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> Continue converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, splitting pep_getsockopt() into a
> do_pep_getsockopt() helper that takes a sockopt_t.
> 
> The thin pep_getsockopt() wrapper keeps its __user signature for now:
> it builds a user-backed sockopt_t with sockopt_init_user(), calls the
> helper, and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/phonet/pep.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index 60d1a5375725b..c7f4ce894af56 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -1078,17 +1078,11 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
>  	return err;
>  }
>  
> -static int pep_getsockopt(struct sock *sk, int level, int optname,
> -				char __user *optval, int __user *optlen)
> +static int do_pep_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
>  {
>  	struct pep_sock *pn = pep_sk(sk);
>  	int len, val;
>  
> -	if (level != SOL_PNPIPE)
> -		return -ENOPROTOOPT;
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
>  	switch (optname) {
>  	case PNPIPE_ENCAP:
>  		val = pn->ifindex ? PNPIPE_ENCAP_IP : PNPIPE_ENCAP_NONE;
> @@ -1112,11 +1106,33 @@ static int pep_getsockopt(struct sock *sk, int level, int optname,
>  		return -ENOPROTOOPT;
>  	}
>  
> -	len = min_t(unsigned int, sizeof(int), len);
> -	if (put_user(len, optlen))
> +	len = min_t(unsigned int, sizeof(int), opt->optlen);

I'm pretty sure that can be min().
More generally I'm not at all sure about negative lengths.
Historically the user type would have been 'int', but it got replaced
by socklen_t which is probably unsigned.
(IIRC one of the 64bit Unix had started using a 64bit type but I think
it was sun objected to making that change so socklen_t was born.)

Also truncating below 4 bytes makes no sense here on BE systems.
Some code will try to write the significant bytes out, but that
would be better done in the wrapper.

> +	opt->optlen = len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) != len)
>  		return -EFAULT;
> -	if (copy_to_user(optval, &val, len))
> +	return 0;
> +}
> +
> +static int pep_getsockopt(struct sock *sk, int level, int optname,
> +			  char __user *optval, int __user *optlen)
> +{
> +	sockopt_t opt;
> +	int err;
> +
> +	if (level != SOL_PNPIPE)
> +		return -ENOPROTOOPT;
> +
> +	err = sockopt_init_user(&opt, optval, optlen);

Have I not looked at these before?
Why is this here, not in the outer code?

	David

> +	if (err)
> +		return err;
> +
> +	err = do_pep_getsockopt(sk, optname, &opt);
> +	if (err)
> +		return err;
> +
> +	if (put_user(opt.optlen, optlen))
>  		return -EFAULT;
> +
>  	return 0;
>  }
>  
> 

