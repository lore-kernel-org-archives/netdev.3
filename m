Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764107;
	b=g+Q0j6fniHsAV+V109V34C1ZNhUvEFCzVyaAJagugeqIYLkn6pZfw51wcrEnwtiH3DXB
	 8/JlJ0mmENRe3CueOr336fGpuK6mdLdK0+tJwevL/cNnzNGva2IqLZqyaH9vcqSfy+AGV
	 EeKwR6+S4bRFkbdwD3UqIo+mnova+R/31OMEaVReO2LoCV8pSszdVafSzy0SlwH2m/9s3
	 j7pNilYYwmL3YAXeHhjXURgpYycabTa2UjreX06HeHAfvy9fu2O30S9YK5X0kstKAZPPq
	 PcOBbtury5txkTKpIGKzlPSaSyUcV1fnXOHvQx2/ObtozybTUQqrEcK9FePfunqvG/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AZ5unzVtyr6CfHrWvwZoGwosTQWFch4ButYqGt7D1j8=;
	b=sciVHzCU+gD9A9Bq0G2MeW9MNEOuaqXSRFoNK3Mr9LEpAMuZCUGhWIHJKs48UAk5UhM7
	 inwD3ontRKZUKmQChipZJZEcbYQ8rkrQGSHk2DPnAZfcKFEDzFnHuOnq5kdFA9XhX6V1M
	 oah8l89XpmSW9IARQdn1Z+NxK9kwlGapKsKj82DB50fFWGPlr0xmlN/gBkJ79MTioRgzg
	 soyMiYyIIFotBQuw63bdhWKHPJBU5ximYYo7z2MsIfNQI5BCxsXLmQeeliAMWlOGu56z7
	 7ar87PIXgeqndtNHH35+he8q6uB23uEOzNna1CpDncdWuAh4Zq3lqJ9P/3gaD9unYTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wPYdmPqf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005E606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6005E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wPYdmPqf
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-150ef97e790so6555c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764106; cv=none;
        d=google.com; s=arc-20260327;
        b=Rldkn1YvzEnsmJqdnBmIQZRyySqHMuJtATEttaqtVktwUGi7B4YIHSDAh1i7QxBZ+F
         M7Ioj2XbjDHEdMdLMCl+uIoqjqoboc+ypgVtaDH7y1UVAkjtu8rkjqAoHpUPaoZq6BML
         uCdYdVE+TRuyfg4HbksB0Co4tZ9rMhwGuVQ84dU9G2myn7ZtpXKqPMhSp9p0ZVKfnPWb
         1W0dSVYlZAwNV6kDa4t9HiVKwiiPLZ7chLjCA+LrPRyMPDpVAh+ZZOE0cYAUGngO4TFt
         lVcCMMpzONDlyGOdRVyjB+Psaj+6GORRYJSw4V0tBwEWd3F9FfPRi12mRPZ4omEKTrEp
         aR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AZ5unzVtyr6CfHrWvwZoGwosTQWFch4ButYqGt7D1j8=;
        fh=F7Q1rQx/igrTJI8A/8drwnQMmrMJ0Nnf5ba1pr2oHyc=;
        b=Aa4kyB5bBU4KpS3iAJ1HJfEnuF9WRxrEuAKgRBuHWyKqMc+hJo0hMwcDZtkKOa49FG
         7G1cswtYG1FWPdiipb4dTL1p9+GYHHJxpvCpKmVBt+9I7Uz5JdXoZgzGAcsuSb8lbmUj
         yHro5NTU1h5vpzZ5qesUSSo2ePLqZj7Swq0TEc9D3pt4We3zVN+j9XSI/bu4ac3JKE4j
         v7hKHjPTvT2vfwxpVh4e+UHFtWzMT8cWfCYEu/200AIvUT0KdYdKY6Qurk7z5C+E5oBv
         klsGz1dlAGV5ozB1QVt+iCl5RyzgyhGmmjZaYcPqsklJdRZTIle2pxGmzIuQSxc9T0eu
         cJVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792764106; x=1793368906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AZ5unzVtyr6CfHrWvwZoGwosTQWFch4ButYqGt7D1j8=;
        b=wPYdmPqfXnyOltg+FP7kgXJ4uj0kDhmegBss6eSH6WmNEYHLIj1Gy5lFw7Jm4LnqQO
         6QpIIXbrvH2B30v9g7aC1dO2y956luRqGAYgeBFjtzVen+yJGzQclDhWrzIPHlRC9E2J
         xM/23US6enwkl3uD1SkjgmGPSSE/PSqo3znQpbVL+iADFprEiBTmYm4UiCuf51AkqGH/
         74IT045LqQYW4nXg0h+yeleQaWVLe0I61ZTHg2uvAEGQEEFMQTxmrG8TuAeHBgjneOy4
         JD8qhiSFafHacc87tCsi91gRws5SsHbvmZIGWceMykIUH9Q7t+T82wdirUnVGK/YoP5B
         I/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764106; x=1793368906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZ5unzVtyr6CfHrWvwZoGwosTQWFch4ButYqGt7D1j8=;
        b=yGv42UWLfJYwyrfSub0r2u28prdK8TL/ABVfWVdsdQ/6vi2XWgd2kHiXHreY4eqIG2
         +3D8bMQMe/jqJ485CYyGmL8y1IQbKLdoYt0rfFmJQrK05qMFerwByKUQTYCzB5lwWnKh
         J2aiW0k8NQQz08kL2d7HjCR4ATRQgGIlbh3yZyQUmn97xyU1w1I7CIjZzG37ExvipGxj
         gO2xDA2jOvUBJw4oeGz+7hT+q7hl3K+c5uT9/5igAA16sPOcPUFIfLHfmFeq+Qq67GCY
         M11rB6Uztv6Yxw80bzKUTQ4r4ZJhowLGaClpmKkLZt8Gu32T7CvVFveQLzfplvQckgCa
         VA9A==
X-Forwarded-Encrypted: i=1; AKwUvBy9GHyKuWDUmzS0mDAqD/yiQd1m1MPGjTZpEbHw1a0lE+vJBDdhDjeV1v/EL/k6EUL37Z3tepA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiLXxomLu6rg5+/V98R8I1oRZit913SeY0ohqmjnXC9auUAakH
	t5RE8UCxdZqZle86Oucqhu1PJvPPbYyYiv3Pf2eHPl3IA7kPs4xyXTONcwcK9/ssnxzCaYyYqFx
	GgZbuRpFB+3GEH+DOv0JO0wgtayblygUnWKcnrqEn
X-Gm-Gg: AYBFou3c9XioRXdGSfa2F4EDErsdv7pFCxq1iYPJU0OXyETmfWKeg0f+gTVjhs5yAY8
	6MqXeZa2HuTH0gJsqLeU/EUU4O9rimdTbg3Oe7/CnVwrZ/RyHZAgQwGRsO9MyADWorBTY3lEq01
	NpOvb3OotknL39NnRGd2XnVYjA8ptyVhrecWEO5ec4mZYZaUriL/fGG+NlsY+KBd/RpzEYliOZy
	7cWjCAFJg+gHVxJ5FELX9e+BzLTHD2ZRBiAJfbMP+aC47fTNWOKi4HSKqU6ZwDnbbYJ2SP9OJmE
	0JafwRg5XPVwtuv5tY88rcEpH0WhRsl6dZLQ89jS7M6fGnMlU99fLRG7TTUdhcUdJz08pOZH3I9
	dwNb7DLPZMWsvpXS0cWJh3JYt1QXeGcAUkac9BKg8eUQnkY3D9GDsZnHlLnQ6qksPOGZ4
X-Received: by 2002:a05:701b:4189:20b0:186:2ed4:45e1 with SMTP id
 a92af1059eb24-195f75291c4mr269263c88.7.1792764104890; Fri, 23 Oct 2026
 07:01:44 -0700 (PDT)
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
 <20261019-b4-skbuff-bug-on-followups-v1-2-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-2-41dbef50b9f7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 07:01:30 -0700
X-Gm-Features: AclHuK_0I1BOQb_enDLqQZci6PJ1fSRcgVvjvJoI-HqZD9AWV_ZZ1S_9BLYGvcw
Message-ID: <CAHS8izMH4KHksqAYfo6csvhZx5ja+ghmfK07=PQAcF0Uzk940w@mail.gmail.com>
Subject: Re: [PATCH net-next 02/15] net: skbuff: add skb_checksum_full() that
 reports failure
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:50=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_checksum() can't fail.  When the range runs into unreadable frags
> or past the end of the skb it returns 0, which is also a valid
> checksum, so its callers can't tell the sum from a failure.  For the
> receive-side validation helpers that means a packet whose payload was
> never checksummed can pass, and commit 20ddd0fd2fcd ("net: skbuff:
> don't BUG() on leftover length in skb_checksum() and friends") made the
> past-the-end case one of those instead of a BUG().
>
> Add skb_checksum_full(), which adds the range's sum to *@csump and
> returns 0, or returns -EFAULT for unreadable frags or a range past the
> end of the skb, and -EINVAL for a negative length, leaving *@csump
> alone.  It's __must_check so a caller can't ignore the failure, and it
> recurses into frag_list members through itself so a failure there
> isn't lost either.
>
> skb_checksum() becomes a wrapper around it that behaves as before for
> the callers that haven't been converted: it returns 0 on failure and
> warns once if that was because of unreadable frags.  The following
> patches convert the core users, and the rest will follow per subsystem.
>

Is it possible to stop sending 1 large series where some patches are
related and some patches are not? Are the changes for segmentation in
this series related to checksumming?

> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/skbuff.h |  2 ++
>  net/core/skbuff.c      | 56 +++++++++++++++++++++++++++++++++++++++++---=
------
>  2 files changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 09db32f70b53..969b1c3269ec 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4279,6 +4279,8 @@ int skb_copy_bits(const struct sk_buff *skb, int of=
fset, void *to, int len);
>  int skb_store_bits(struct sk_buff *skb, int offset, const void *from, in=
t len);
>  int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int o=
ffset,
>                                         u8 *to, int len, __wsum *csum);
> +int __must_check skb_checksum_full(const struct sk_buff *skb, int offset=
,
> +                                  int len, __wsum *csump);
>  int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int o=
ffset,
>                     struct pipe_inode_info *pipe, unsigned int len,
>                     unsigned int flags);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a2b52a5a61a9..061c61422a38 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3545,12 +3545,31 @@ int skb_store_bits(struct sk_buff *skb, int offse=
t, const void *from, int len)
>  EXPORT_SYMBOL(skb_store_bits);
>
>  /* Checksum skb data. */
> -__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __ws=
um csum)
> +/**
> + *     skb_checksum_full - checksum a range of an skb
> + *     @skb: buffer to checksum
> + *     @offset: offset in @skb to start at
> + *     @len: number of bytes to checksum
> + *     @csump: the sum to add to; on success the range's sum is added to=
 it
> + *
> + *     Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if =
@skb
> + *     has unreadable frags in the range or runs out before @len does.  =
On
> + *     failure *@csump is not changed.
> + */
> +int skb_checksum_full(const struct sk_buff *skb, int offset, int len,
> +                     __wsum *csump)
>  {
>         int start =3D skb_headlen(skb);
>         int i, copy =3D start - offset;
>         struct sk_buff *frag_iter;
> +       __wsum csum =3D *csump;

Check for reverse christmas tree.

>         int pos =3D 0;
> +       int err;
> +
> +       if (unlikely(len < 0)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               return -EINVAL;
> +       }

We don't normally go for these defensive checks.

--=20
Thanks,
Mina
