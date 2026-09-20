Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336663C5DC5
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932001; cv=pass; b=Ypenboax9Z3hlx2OMNLiE9GtsfooM7/02FavLgOO9aVk/EVqULROxNV+j9eunF6uAqHRm4RvqhIAcM0Q1wwx/0lHejjG8eP+TeOzN55MqOJdV/QNF7wqFKCk2dYA+BVofcY4L30yv9XKkwCe7v3z4DyPj83Fn483b6AQpgTD5fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932001; c=relaxed/simple;
	bh=6SpgTwcIIQqjPbDa4mTNcZ8/Jqu2VPFbm+vZpZ7fjkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CohAfK6QISXi4Zw1N9MWD7tpHFflTbvAVDgk9QqkEZpDnA+bALc9dfgIvFFLDK/YziHppGN5DC2a0BQPJmulWYfzwTs3hmE61hm5yQNxVUd2IQxuQ7GwHqx52UxdmiZLQuRT0my/wos1+eiQdtXLwFae3Uu3FTIGhXRjbyuGHmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHzfCDNk; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHzfCDNk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso2354111a91.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789931999; cv=none;
        d=google.com; s=arc-20260327;
        b=PQlGqZs96zlG/O+zzY1QneyAPUUZDjSQKb+oh3wuyX/R1mF/PglpsHg+g0wZSYGjpb
         zYWBrJK+lu1wK5vES2IDqoLEMpzhWKDuDvfkBB1+zcovZq59Xe4M5N3esjk18a/tyhvY
         MpIslZvJI3rvUjeRllTTc+dNNIyFcCCoQWg42ed9hhW4TCsTmKl6ChxxAdETSqsum0Sr
         4qIOT5v270oFPh0eoYTrWkb0rE9kO0CKJj5/iOA7sAktiU/pz2+S9dtOOuRN8yGS7BUG
         UhZ6oqS4CiQQzxJL8sQFTVyeWhY2tOhQd10LIqDhSmc+GdiXXEhdDXJg6mKdOzU4pz4c
         ao+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gWhRaROW89yV5OS3p3Oh/TR8um8lkux/C2SiVG/FN0U=;
        fh=jXG6vs5HoQTsvPOozeck6AfEAt7z269vB7q/XhYbczE=;
        b=ecwntpcExfRF2p9m9DgTimxmXmfU+N/YjxbVBihICys41RF0vAa3RZMNHm9cne/S/g
         CG2h+ycZCfcmcfC69TDOK1ES6gyLu1JE3SVxo1K8I2snhUFmW0Eaap9e5oPL4WirgxDH
         hwGM8hqCTaPAhS+kexLr1JPcQd6/cNUNqpnj2UfpjNvr8nP3uhotoJJzEnJDMEpLVj15
         DR+m2NOa2QQHKX0TtMKIBHE4g3QtaGvgxQP2CgSED2caISZylmX/8Zw7M45c9s7tVdRQ
         e8leLuvRldMjJN+qSEZuyBzYYYIcFeNUXIXgupiXNvLYO/eG+/43HdEH+68d1bgdONFU
         si6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789931999; x=1790536799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gWhRaROW89yV5OS3p3Oh/TR8um8lkux/C2SiVG/FN0U=;
        b=UHzfCDNkUeg8JygLeU7bjSLvlWmWi6ZIEklM0UBEnKAR8ZTh9HxcLwp+heWsyVG4lR
         71FnwslAXVzqZeZPJS8LqjIfXT1uc045WKQXbiRas3lThtJrdYQwyHmu0qwlt8R0uOX9
         h/G3000ZuDcFlLp9YIDUeUAK0Y7+RqpIBBXbIS7SuM7aVl5PJGo8lfAm4s77wFGcvbMq
         md14K+E6sVbL+V/uP2/IbVCt1JQlJmqOmhXqcAhsvLlkkOtyhIM2h8X9bRGeBuW+COya
         9Xttr6ClXOCHU+e1xXigAlFDnImG2j55q5cA0bIMbtwxJdZLScZ8nDW4wV3XWbL0T1KR
         dEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789931999; x=1790536799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWhRaROW89yV5OS3p3Oh/TR8um8lkux/C2SiVG/FN0U=;
        b=U4Yhp1hOaCVIFNor6cdFF3HKyHuMFfdBzdYd2eOwu6IZZ4Sj1pydJ0BazDExrJbQE/
         fGLb9AqiQhkhED+7RG0q961qoydpoW+DZttVlq9lvXtfePbFFQbI8HOlDtKwB90tGYKS
         lWEpkyqrGcCixbdAC8NXSzUAx6EmLpHA9BYXxJJtHo3UBvDHY2VaIhyYECNd2BTWGax+
         NhrfojzXUPyNX866ewzWmlK0o4w7iBGLj3BtR3a2MxDSPV8R4bo31rYNRMikMGv817lQ
         dnA8aM1uslJeNwjqgATfw3BbK7K7r9SICk432ETutVjr4rno9e+6JI14y58FfFDwYQS7
         uJWg==
X-Forwarded-Encrypted: i=1; AKwUvBw4FmGvxHJaeXH0SS4qhvDug9HA0idKDkIJ7CTFwAuvHKfT9PQUXuzhhUP5sZM6b/FfGXl/Idw=@vger.kernel.org
X-Gm-Message-State: AFuF++nJo+3udfP//jlAsKCbtBC74RvAgtJmZ6WS0DTbzQMpE7Of713+
	pfzkVt+BxzopyFpJVa3jK2n9jlVzhSM2zBosFgKFFOLcsJc4MkNwcHg4HmsVNjasI+yfA7+ajvI
	ag7A7KcxJuupZbpwNpvMKJ2BWn7xWRMqjIuPQVUW5
X-Gm-Gg: AYBFou0Umumyz2wWAlCOecdpdA+W4uF/NmgmIoerurqCejfWiZ03p/Iy8wkJ0lKJfDO
	zeSSASAjhUFmakhIiAe5kjutgnM9Fv0Gf2P1eupi1lRJgIENtTsPXhz7f1b9KwL1nCupJ/wK5PN
	B4mfVSxmJ2/hCpgC3CtYT6lhHYldT33QqfSF6AUfJduX6Zm2QLcEB8mQuZ5RvXC8bRSnIPctxCb
	ZCWcjDKXar/IMkimmBI9rmvGydROi//v04lNK+B2LTjDYnNhCVzYgUx9lieofdopIMJrb2ZXEsQ
	ZnBcfcv+MkvWW199xhu+NWOeFtYqLbZdhya1oaVrAEtcaW3D+JvMwg5EaYUfh60xi0p7O+v07cV
	foZLG+tJNRYbnROMQgx93rn1bTmNhGlZN2TCBk6MJt3gs/FJUOoJ7dHK+PBdk/peJBHYf/1HdQS
	v+zsZ4KD2rV1+2LgS7vwy1blAXqzXm3qqbAZs=
X-Received: by 2002:a17:90b:4a01:b0:3a0:4abe:fcbd with SMTP id
 98e67ed59e1d1-3a04abf0758mr914250a91.19.1789931998859; Sun, 20 Sep 2026
 12:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919215238.3471141-1-benquike@gmail.com>
In-Reply-To: <20260919215238.3471141-1-benquike@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 12:19:46 -0700
X-Gm-Features: AcwNN1XNFaIA_FuRm5dvT0DJBzJTY_mCtk-5E27wg2ToTpoFvLwk3Ok8gbD_32g
Message-ID: <CAAVpQUDwLnRfv1PkkexsC04D8wLSeARekuUDSTOenyRctWG8MA@mail.gmail.com>
Subject: Re: [PATCH] fou: reject FOU_ENCAP_DIRECT with protocol 0 to prevent
 sk_buff leak
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 2:52=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> In fou_udp_recv(), returning -fou->protocol to udp_queue_rcv_one_skb()
> triggers IP protocol resubmission when fou->protocol > 0, whereas returni=
ng
> 0 tells the UDP tunnel layer that the skb was consumed without freeing it=
.
> When a FOU_ENCAP_DIRECT socket is configured with FOU_ATTR_IPPROTO =3D=3D=
 0,
> every received packet returns 0 from fou_udp_recv() and leaks the sk_buff=
.
>
> Reject FOU_ENCAP_DIRECT configurations with protocol 0 in parse_nl_config=
()
> and drop packets if !fou->protocol in fou_udp_recv().
>
> Fixes: 08d323234d10 ("net: fou: rename the source for linking")
> Assisted-by: LLM

Looks hallucinated ?

commit 7a9bc9e3f42391e4c187e099263cf7a1c4b69ff5
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Thu Jan 15 17:24:48 2026

    fou: Don't allow 0 for FOU_ATTR_IPPROTO.


> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 5e867f1b5c1d..3fc087c808bc 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -77,6 +77,9 @@ static int fou_udp_recv(struct sock *sk, struct sk_buff=
 *skb)
>         if (!fou)
>                 return 1;
>
> +       if (unlikely(!fou->protocol))
> +               goto drop;
> +
>         if (fou_recv_pull(skb, fou, sizeof(struct udphdr)))
>                 goto drop;
>
> @@ -696,6 +699,9 @@ static int parse_nl_config(struct genl_info *info,
>         if (info->attrs[FOU_ATTR_TYPE])
>                 cfg->type =3D nla_get_u8(info->attrs[FOU_ATTR_TYPE]);
>
> +       if (cfg->type =3D=3D FOU_ENCAP_DIRECT && !cfg->protocol)
> +               return -EINVAL;
> +
>         if (info->attrs[FOU_ATTR_REMCSUM_NOPARTIAL])
>                 cfg->flags |=3D FOU_F_REMCSUM_NOPARTIAL;
>
