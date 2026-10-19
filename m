Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422598;
	b=SeoDrySeDSFyLqppVQPoxfB3C8pz1kj9arvHkoAoaODZacbmHVRLxQRzqLEQ+RXn0RJB
	 Yrt6Z3wDKL2OC/sFgW/tVJ5mnn6zHVEFnWk6+DRwblP6MoHyNZXbgxrKNoPWQlMomuBei
	 osYwDsfygCaTzmWN9YZgksaBmdPNLnAFd0+HAQbDK/LYpWXhOaFXilY8EanPLcRnwlptQ
	 SYcjfG4V0iZMOdYamIBJ7qQP7rK3AfzZj8yPzl9fAgD/0GKDQDz8914/GIB4ZJb+XFhxf
	 wyQGO5f2rQN+EEHy0MekZTmE3o80BGmXeBdcRmDem4dLHwjl6n2GHyigSfGVe5H/YHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AWZK7vcabRIRlNI5I0Qlo1HJVZRHgTLgm0d3t+p60UQ=;
	b=PX2Vn1Y+uvuOdi+OEoWnAp7Z3p6Y1Mrt4skrdgSz3iUoug5ueKw2QoEk2bn0TJOakF6t
	 XMITPt7t9KktzjmD3hLJFjwcdVo9RDlRTmq5gmSYZtP9J0qEw+OnsbcGiD+VEu/OWfSRN
	 xIsFZHenqRMKHcKekwMjsZkM29NQThcqlkg4yCDeSUB4z0PKFxOTIQ/7A9OPLg13n6tQ0
	 rnR/MSm3HmDAXc64IscJGiagEN7NCK25+zWss67Gp3ome6eMNzzWLeDXW2uI5d1m1f06z
	 mXl50scUw02/EnScFtgHTNg8j8OKawVaCcYaFZwJqAwGGpfcZFQdRBbKK1fDMtaerLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EIoCwR6W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98C60874BD
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D98C60874BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EIoCwR6W
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so17822a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792422597; cv=none;
        d=google.com; s=arc-20260327;
        b=A7DCtGe3zHcTAcXpnXQqjr30uIvVe+zow2m/9Edq/fJq6rTHXzjZL3lckc+WPtFlgr
         9XGRiZnMmAbTuL5s1vuRJGhyGUPV1sN05qHJJI8Oz3M5RK2y6/blv80aQUxZBQnKRRiV
         jnjK1UiGRSD5TSvr3BG3qOPwb6d8HJYGNILIm4k5bJUKUnd42bQsHFMwU9J4lFFJad7m
         Txhf7Rl0h5oMVgJ+PnxbSgACYRbBy+VHLlMJ7BBMsqIYB1nbiFlckh9VvLT5jFsgy1xp
         fh2h5ILe550ZBErfghmOx3PywWL2T2RL8mEDt4/rSWEtqOyUwP1dqefArNMLaeDRKslU
         pzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AWZK7vcabRIRlNI5I0Qlo1HJVZRHgTLgm0d3t+p60UQ=;
        fh=8wl7SoG8KlyorRcEGldwX8cDQxJHFpo8RG2IhoK1suQ=;
        b=V2n3pulLp0CiWKpKRDnUcqsVyaBbyDYc0rOj8hAIBvxgI6DLhzZGPVnoX48d3D5rKL
         ZTwhthgdLs/8FsBCWR0Qq4Ec+zlfQKzQaJ93c1J2ShPTv4q8s3ebvMwnhRVv/K00sJNw
         cvEWpI4lIlJ+QvH69VA++GFwUPe7e6qoU6l7YRZ4jZYovMFTISCFgv3iFbzNGc/S64X8
         zyx129FnPU8RwjcdX5/19WfF/i1B2FDUc1i9uu8X95TwCwD8NGhVqajXwdiv1FNOzZah
         OhTKm1IcC/zNaHZwKTps9qmi84UNIgpCy0R1C9TmEFzgEvmHWQcURsYxFbVzLX4B+pZ9
         JEtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792422597; x=1793027397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AWZK7vcabRIRlNI5I0Qlo1HJVZRHgTLgm0d3t+p60UQ=;
        b=EIoCwR6WF0U+xITcGiFBrgQK/JoozZWnJ877F2Y7JCYbvK1Q+jE5WkK2vG+yuRLuyf
         SPNUmTR2bNeR7VR8M8aWBMlyucf/29TbIsCfMVD5B5obeHbXlCbKtYM17Kan2kHSpQxW
         pOavJGdBFW+xpUJ5CbXUGulN6dxFlc30PkY2ZjHtNP7+N0TxsrLhNdOGBkD41z5TdzeC
         MQaSxOUjzDfvlhmbjpjiKG9F4OkUplVORc5AxuwxebdYFikHIPAsQ5Rq/GJNSL/OnPHG
         MCvz/HH32Wmu6+/FQr7BJU/wgMP6OHdaBt0YfPehj9zmMdh11/IElbCgQB3S0OngwDAi
         MskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422597; x=1793027397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWZK7vcabRIRlNI5I0Qlo1HJVZRHgTLgm0d3t+p60UQ=;
        b=AIMYz30lYBk9dBnOFtfwqkgq/fuYc73tHyZELmI8teOXlSHznIwhDlrnd/1AkzpgbO
         huedn7Upjm2dwERkwVZFrImERtW++8h4T+Tly8ASQufS8lmMRl/yQf18apqKzQLL11KB
         JVT42HIl/akl8MwK7jdPsJiaNKBL4TnTjB9f1QzzpyeNUeIAlcTwDkI2JoBmfAEkLuMf
         UHwqkUWNTDbRXhEgy6wI3do/52DUQ6LMKcuUTya21zErDLygm82557j255/zWDR3JMuL
         zuyir2aYea+hIYhd3KBnetXlsqNbWgDTIk1h909mKfYEMFvwVZJ3I5SGftdq5nQetXyo
         259Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNHwgmVadzISkzTksfGdHQ2mKW4b0yJWnNQHpyvnjUf9Pj3VI1BXndDBKLQuGY5XeYsLVrFOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC9uKIMEpN2DuDYZ0GOTKRgE909rsgietiOuXCvk10xyvtRQgv
	IYOIqCJDvvKzaMawxhHFTyQbUPWDekxvCISnHiwW4lHkASGPb6ucUo3s4FMlL39bTi+oet1kpQa
	i7RxosNs5N7P9Ah2ZsPIotTOR5y6CH63zWRiO8yYi
X-Gm-Gg: AYBFou0LfSy5HaMCwSctmnzYqPOvIR5h0Hupgf4W1414jcS1Z4JZq0M2RcF4Fz3UnxF
	QUdOpO6Eh1v6BpO3qwmNYGdeAVHDrbE47vsLVoX2KSIkkXZNeXr8ZbrScutqzBPKWNKSYSty/4I
	o5+Uao4TjKKVNSLt8Rma0JWPsCyM7xDEQMdzB9YTT35gSG6SpMgshcyX5IU5gnTGRgyBWD+MCxE
	cTejukfg7TiraU/9r7n8adUbEBJb/Bbvwiv2NYvxcRyFFnEHYBhANG2jFEvWlqo+mNE5VoH325B
	4JQ4AOiQP6e4L70BTztCqLGohOFSNEa/mP4KgoKbGtpNgrVg/seVOPYw4ml5uDsmtFz4Am8m2ph
	uqi6E9zowzA==
X-Received: by 2002:aa7:c0da:0:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b3d47d2378mr37599a12.3.1792422596059; Mon, 19 Oct 2026
 08:09:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-15-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-15-41dbef50b9f7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 08:09:44 -0700
X-Gm-Features: AclHuK-dz-bSuEIE90POvdnsCfCUclg7akbJCTc6RZqWm9wZlCW3Q22i8toaMP0
Message-ID: <CAHS8izO__8Vqw4_ReEkbgn5UmncveREuwM-q9Mub5CGy-d5c5w@mail.gmail.com>
Subject: Re: [PATCH net-next 15/15] net: update comments that still describe
 the skb BUG_ON()s
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> The skbuff BUG_ON() conversions left a few comments behind:
>
>  - bpf_skb_net_grow() says skb_segment() BUG()s on a frag_list with
>    head_frag set at the downgraded MSS.  It fails the segmentation and
>    the packet is dropped, which is still why the skb gets linearized.
>  - The GSO KUnit test says the non-uniform frag_list case would hit
>    BUG_ON(i >=3D nfrags) with SG.  That check now fails with -EINVAL.
>  - The skb_to_sgvec() kernel-doc doesn't list the -EINVAL that
>    __skb_to_sgvec() returns when @offset and @len run past the end of
>    the skb.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I would have preferred this change is squashed with the code change;
if you re-spin for another reason maybe do that.

Acked-by: Mina Almasry <almasrymina@google.com>
