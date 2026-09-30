Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA5450412
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767314; cv=pass; b=dYBwwuH9tqP+aoHr+l8I+wb5QDKpCVBd8VA0ZwFiiU0YKnC2jOOIAiJzIrfAUHKnA7GUOPzQbcvTM1f/sEZtpKa6Jdqu89vNtzLFICFiw34tNvg7wPHUZ3E5GvGk9nquB/+UIYyxx68fS+W8xUgl2PZzT0xjQtuN4qG3/wIlrjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767314; c=relaxed/simple;
	bh=nDG4cmfEbSlkfCKB3UpP5C6IJQLVyHZ+Tm6WTD0xZDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsDBda37aMCCdU4zqu1UAQSmpgQz7w3HKDEFggh1odIPVwH2VH1JhwzeaQPrhrwJe/9odIVdxr+jT33qpZ9EDAGci8b11zfkQMAmYg+DxoUyT4bTZn3RajYMHw75LybsAkYlicGsmu7GYjO12NSOmck8xfXoELEG5rqPU8N2nqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wb6SqNIN; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wb6SqNIN"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332bdd8296so69944501cf.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790767311; cv=none;
        d=google.com; s=arc-20260327;
        b=QGmH0xYk4mT9eSZQvgQYwd77WeeRmi5IW72cTO1ZwQGvfWmHKhfFI0uDDDterYFKhK
         XALfRmiLCt6CUcTb/wP6ea5taICgCZPe9KT+95wWv/LRGceP0S7qbYHOyKfEiaNC1fOn
         yXgdliOVYMUkrCJ4/rNQaf757hlkjpxviY5A2GZIoBPX06t0/ElvNfVXUpBG6yW1y1SW
         P8SWLNVQ0Ss77tMEqaZ0GZrQ82n0uIyLzM0+fqPZxKWqD6CJitrJJzuvzJrIgDoQzlao
         EdZaDcIxpczxDKuoSrkSgQR3v3Yxo5nJ2TFqbc7WHD9o8vNPOrNrIJFS/Kmief93A/XS
         UyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfpGJXYUt+pqZqeEvkxMBx7LIO0yq5hTEhvmFChh8bc=;
        fh=4jjzYlKDPz7dkCfNo3/QrN+rtsCJU28STic+UxJMowo=;
        b=FChISril04lwZn7UQnP408eFgcb4ADGjruSkvm4XqtTQ7RNy17cvI5T38W1LOpf9LA
         BOM/7O70APCeaXnZbHJO0LuwWKTZVogNOwctUxOb0jSIv7PExWiHP/3lytPXnWZb5Y7F
         JGtXyJ2xjIUAtXB6+YTD5dr1WVjKRja5omqoAbbxC4zZywF8kMldbtlnw0868gnXmEv9
         Q2ytmWYg4Hsz+CKEN6WG9v4Oci/muu9I7jpJdAg/rMcaIOcpuFhhxFpeaEctqKuayeh7
         F/N/wKLDYEYxvhHOJ2lTA0dOOjQBa445PxEafti/zVUqv8LhuTBtaTcZ7ur8gmnZA3ch
         eF+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790767311; x=1791372111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfpGJXYUt+pqZqeEvkxMBx7LIO0yq5hTEhvmFChh8bc=;
        b=Wb6SqNINtqLZ8SBCO1EFhtCGRmjq83Qqs4k4VOB/55N3pFqah9bOxrYRMwnImUmskG
         KCpE2vzmcduVXdZ6wkmPQ/c/32fA+/lZe8fmJc8uER1Djf4VoFwbB5j4b+ycnBEWdTC1
         nsofptYgx/RQsbjpD/Qm6JK/8hPU/2RmdjvUSuVwottldGc4lY4hJLbCSKWkNyfob2W8
         JuEABsXW/B34D5LvcWFzTEUCVXAORe44vgF/i+IV4EnPQtAUTN9wsYQj2CAFOcxsdMHa
         lwcpK1z6ymXpapgDBeGVADrtEwQ9xr/3rQm8JMV2XmS572xVfq5NMz705lZVdKNba7uQ
         OABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767311; x=1791372111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfpGJXYUt+pqZqeEvkxMBx7LIO0yq5hTEhvmFChh8bc=;
        b=d39CY3sf3M8e8XlDWcd8DbLr7zB2RIsqo6Sbczs50by8cUdYfQRwRYvhw3umIh9PCg
         33vim+CjhPPgPS165Y5ZYI8tJx6x+9SVnJdHEXxs/QwisdP/2e1PeL5Uwrptf/FuNJWK
         B5FQzQS2ResTwAria0K43RNl7RevG+FwH5wTUKc1fmgRF5inpZ1l3XFfa18otYcbwUi4
         CnJCu3kphz2KqMokRaGoIptdx51oPN/hFaACfiQBv072cpHLEZZLgZE7Q64fdmV7Jwae
         UZgpn5wDfj8H/SbHvcon5FBcLpqiJfmuoAZpuKAnm4APXK1a6GIHCfjKHmdTlsqoe/Xs
         lkQA==
X-Gm-Message-State: AFuF++miIBwjw/ZloNFArm28IgWstetrzlNri36+lj7cwT5PRQdCxoPT
	m55H1rpIXx4ymcdspltsu3/lM6eC9Ni7KWLYv4NGvEWj+B3Oo28OaUBtSgU3AZdUEYpT2SK7nhV
	plLGzoocz2wZaWEs9xPPw8zrkTebTIGRADAjIFrkr
X-Gm-Gg: AYBFou2B/31HUskPiBiEFPQAObudRa/ZBuL/oGs9pW2FBZXjiO0ZZ+DZWuWVWdzXybZ
	dVTxhYtvbov1rrp2BKSEjZvnMaTnPHwBiEDCVvIrZd40AH+9Ni5HF+eUSqIcAto9pPZuiN1BhTq
	dBgWU/tR66uxjmK3Gk+0fdNnrRaeL0maOuV+gnBSvw2AMBM6avT4Tm+w+efezv6drT4JbLFtfEr
	bzoSIrX8Ip7HYY2FTFTjNZ2sLIBBm3COeoTVaawk4G0IyjgWCJR1ycxIbdu/DijdZujaWCjEWUr
	FfxJ5gB2BenTLWIhSazVtLqqEpQH6s1s+u74e7HzTunWe53zrik5n5b4eGGQh4yQ+DIT1DUiLyc
	3PBS2Tg48K4GHYFha19b+NdlRu36UcDiKUNNDGgYh2jIKxwjsYyoGyvCbbXQSUaZrFs8+
X-Received: by 2002:a05:622a:1443:b0:533:4b39:4e28 with SMTP id
 d75a77b69052e-53374d85b1emr19082141cf.33.1790767310634; Wed, 30 Sep 2026
 04:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930100937.206377-1-jiayuan.chen@linux.dev> <20260930100937.206377-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260930100937.206377-4-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 13:21:39 +0200
X-Gm-Features: AclHuK8zNCR_V-ToSw-vF65D2n_UEp7o3edqp2vCKW91KoxifKRbepto8X6oeW4
Message-ID: <CANn89iLwivMvNWC0oDgmQgTcKjrj_Ar8deh7Bc2jqyRXwv52tQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:10=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> beta_scale and cube_factor are computed once at module init, and they
> need 1024 - beta and bic_scale * 10 to be positive: beta =3D=3D 1024 or
> bic_scale =3D=3D 0 crash right there, beta > 1024 or a negative bic_scale
> gives garbage or wraps to 0. Negative beta can also make beta_scale 0.
> Reject them.
>
> A small beta also gives a small beta_scale, and (cwnd * scale) >> 3
> truncates to 0 for a tiny cwnd (e.g. 2), so the TCP friendliness loop
> never ends. Clamp delta to 1.
>
> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> Target net-next since it is not a big problem.
> ---
>  net/ipv4/tcp_cubic.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 119bf8cbb007c..2f04dca5be095 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -298,7 +298,7 @@ static inline void bictcp_update(struct bictcp *ca, u=
32 cwnd, u32 acked)
>         if (tcp_friendliness) {
>                 u32 scale =3D beta_scale;
>
> -               delta =3D (cwnd * scale) >> 3;

I would prefer not adding a test in the fast path to work around
silly module parameters.

beta_scale is computed once at module init, we can make sure it is >=3D 8
there. tcp_snd_cwnd() is >=3D 1, so delta would be >=3D 1.

With the integer divisions, beta_scale >=3D 8 iff beta >=3D 512,
so the default beta (717 -> beta_scale =3D 15) is not affected.


> +               delta =3D max((cwnd * scale) >> 3, 1U);
>                 while (ca->ack_cnt > delta) {           /* update tcp cwn=
d */
>                         ca->ack_cnt -=3D delta;
>                         ca->tcp_cwnd++;
> @@ -504,6 +504,11 @@ static int __init cubictcp_register(void)
>
>         BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
>
> +       if (beta < 0 || beta >=3D BICTCP_BETA_SCALE || bic_scale <=3D 0) =
{

bic_scale * 10 can overflow if bic_scale > INT_MAX / 10

> +               pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n", be=
ta, bic_scale);
> +               return -EINVAL;
> +       }
> +

Something like this (untested) :

if (beta < 0 || beta >=3D BICTCP_BETA_SCALE ||
   bic_scale <=3D 0 || bic_scale > INT_MAX / 10) {
    pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n",
      beta, bic_scale);
    return -EINVAL;
}
/* Precompute a bunch of the scaling factors that are used per-packet
* based on SRTT of 100ms
*/
beta_scale =3D 8*(BICTCP_BETA_SCALE+beta) / 3
/ (BICTCP_BETA_SCALE - beta);
/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >=3D 1 */
beta_scale =3D max(beta_scale, 8U);

Thanks.
