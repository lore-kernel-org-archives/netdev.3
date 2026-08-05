Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12139EF0F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952359; cv=pass; b=WU5oW1+PjLydeXFW0mbf5ZufvwmmR/abcIBehApb7JE7huaKKicYC3mE2+Yzqlu9fcEUnbeMCVmw4Tgss5ABZ1l9NRcKsdGGoffHee0HeY6qStLBe0I+CHqVkilJrUaTyDfqYsjEmFxfhzTZeBiKu0IAGsyrabyGrRX5WL4AfbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952359; c=relaxed/simple;
	bh=e2bnPWY93k3ciIefhfr1b5YgN5w/0NJ3BEUrJi7PVO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO16edvRyOyRsPMS0Wm1g701AY4iBhe6briLpZLHeyf9Vi79zZUBEDwyaNwoGIt9NWETlX7kH5Whlsdewa3yBSVTGdUQn3BkozBsnd+G2xrWGpztL2l1eKUdcFGxw8IRx8mb9XfepdbR1y3pg41rqIVZtb/yjdBqKGUeLHIpy+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Oe5Sc147; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Oe5Sc147"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1614752b3a.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952356; cv=none;
        d=google.com; s=arc-20260327;
        b=qyVIwMzczUW3Walr18SwoAwKh/aW4ZWYe9AuCcsVBwOLEhtEw+Lk2+D31vGUtitkh3
         Hh18rOsl/QqDtJ9CV320sYNDlCCoM/d87nlJ6tBdXYEiZbVJy6ZANtxA4QUg3R8F6mYY
         QeslN183IFE2WynA93jpWinMJWQ2vE0VEZXIB7JGvSh5SaKIbsDPpvEQK0bLaYYsWtIj
         9KZIXULRQmA/fsUdW6NKNpUg5pPyLoUyC7FKgYO2MM4FZPadOLSu1qZ05wOYbnxEM4n+
         PMsh1T4wospMwsOhsvDygaimQC8osl+5FxT63RM0nC4c1iQkk40pwfbEcm5imv3jPFJi
         gP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        fh=ZLlDrKEBXETI5lOx4n1fCZtsarZY+kh2+kU/ySXWisw=;
        b=YZIp2GXBRUCI8+qWrqb0xrBg+fAy5+BJZIm8UgUUl1s9jLDIqa5HutH18szJghPCxm
         +M4/ZkGvRRgcpK3wEx6Oy/Hc/VFTGqeYUcuer3h0sWY2PERfzwde92uwB1y9mGgadwME
         Tmr/d7jjfNfpWd0nteyWogDju1kUTz0b5d+ZRZqkhSE64gZHFR4XHB2k42N8aVi8IjAk
         TfrAlBtRHXm2zN8VQwBAkdKRPScSWrWKG1/PyVl81j60+M55S9geJ8OZUKHWgs08nqmv
         Vl3UcjjkeR88r5OdbiMnXkzpNv7hQ95G9aRITGEqb02ApJvRXXSdgzWNE4Jq3k/lRn2t
         b3tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785952356; x=1786557156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        b=Oe5Sc147+JBEKr76hEsjlXkz/+LIF2zjo40oac4IzWO2oIFfZuiccbwNvYh/LLxmWa
         LJYP/ee+59WEvrH1ecBwlr0wKkYD3wFBZXRHy9U+NRgv2TO6cHQYe3sxwX6RTGk6gsyq
         cCViq12zANEAblEWPLIrYaAes6lhELX9NSPyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952356; x=1786557156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        b=ptAPolqlknQSwJwRi065pK0LvY+dLJWyvb9Z7FBNvEQOYo7aqnSex2sY+WRL9zXruh
         rSC3fHUjusAVa9wW7S3axJjUhXmFDJHFYDhiwz1cTZGf8N25vAgc3hbd5KYD9VfK61xq
         AYLmYlBHchSeQz0OBP8ev/fOL5iQP2jTfhOicVubNsqro+d3y1s6RmgiJXhk2d04Ebw6
         Nqc3HGX+AclLvgnI20yUz4NQInCsaTGf2uGmI66a8jyYqoLsH9VsDAGkuD859U/zO/mK
         bYyzRCjgXCr0iUs7qaWsnzTc+vUfKSsTNYtZvN6NZucpuduljEstiBms7wF+jeHCGypl
         XYVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNoy41H82lZdzC/rkoiY/lQYmRl81jLBFzkS5A96bY7SIt/FAYU8DBjju2aVaCnQz2Ob7I1Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLO3FV07d2RGQ9qE/HQb3E40vljtDipw/G5c9HRtAksIy2RrL
	XDFlIbYHN6QRRyxBnTJo3Pv0Qb0mPV2Dyli0AAFYaa/UMb0BVTik6Z7Y/0A4HHi9AZiHR9SIGZh
	ab1NORvZ7Ia2NlpXsTsZG+tAomamT9cg49uKx/AAU
X-Gm-Gg: AR+sD10lxFyMBW5ZGprBwBGQt+T1ziR7eNXMN41karF6Re/sX+gb6w3HT2Yc7pEkH5n
	bHA+vgQ1g85nIYJyFWyb0obssFiVMVflaETkOiZ9tAgqG2dWg2Xv81XUPxS6xZW6iEcY8KC90/1
	k84yGkqQlYs6VYtwknFI9eASi9NcEHoO+myAkx3sq4TrjTGZv9gIa6m9jZtMAJ1h4SMQ6/NWhJU
	KpMfrWxPq8GADyFwN1mf1zCU1KzaCQVF/BTfAVHaMHZG/CJr/5xirCaeM1tPBicejys/ZZhDmgG
	uZUg03JT8DplucOwnKX7owjEhJPuYnEvVm2pbZj7Ml6qSmu8y/m5IO6mgw==
X-Received: by 2002:a05:6a00:348d:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84f2e0ccba3mr10352497b3a.33.1785952355982; Wed, 05 Aug 2026
 10:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805093012.95155-1-henrymei@tencent.com>
In-Reply-To: <20260805093012.95155-1-henrymei@tencent.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Aug 2026 13:52:24 -0400
X-Gm-Features: AUfX_mzwZqW7-itfrTSXTC_surhIBVhCfhDT6bwPIQqR54fbSSGBf_cXDQQD1NA
Message-ID: <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	corvus@tencent.com, henrymei@tencent.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:30=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com> =
wrote:
>
> tc_new_tfilter() attaches a filter to a chain. When no
> tcf_proto (tp) exists for the given (protocol, prio), it creates one
> with tcf_proto_create(), marks tp_created so the error path can clean
> it up, and inserts it with tcf_chain_tp_insert_unique().
>
> However, tcf_proto_create() can sleep, opening a race window in which a
> concurrent thread may insert a tp with the same (protocol, prio). In
> that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
> *existing* tp, but tp_created is never reset. If the request then fails
> (e.g. kind mismatch), the errout path calls
> tcf_chain_tp_delete_empty() on a tp this thread never created. For
> classifiers without a delete_empty callback (all but cls_flower),
> tcf_proto_check_delete() removes the tp unconditionally: a live tp and
> all its filters are silently lost while the owner's change() still
> reports success. The race is reachable because cls_flower on
> ingress/clsact qdiscs runs without rtnl_lock and can interleave with
> rtnl_lock-holding classifiers such as u32.
>
> Fix this by making tcf_chain_tp_insert_unique() report through a new
> "inserted" out-parameter whether tp_new was actually inserted, and
> gate the errout delete_empty call on it instead of tp_created.
> tp_created itself must stay set on this path: the chain reference was
> consumed by the destroyed tp_new, and errout_tp relies on tp_created
> to decide whether to tcf_chain_put(), so resetting it would underflow
> the chain refcount.
>
> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurren=
t execution")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Aohan Mei <henrymei@tencent.com>

This is the same issue Sashiko found. A patch is here:

https://lore.kernel.org/netdev/20260805134049.927864-1-victor@mojatatu.com/

Also, please add assisted-by: tags going forward if this was ai generated.

cheers,
jamal

> ---
>  net/sched/cls_api.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index fee4524ad..9ceb2b538 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struct t=
cf_chain *chain,
>  static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *ch=
ain,
>                                                     struct tcf_proto *tp_=
new,
>                                                     u32 protocol, u32 pri=
o,
> -                                                   bool rtnl_held)
> +                                                   bool rtnl_held,
> +                                                   bool *inserted)
>  {
>         struct tcf_chain_info chain_info;
>         struct tcf_proto *tp;
> @@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique=
(struct tcf_chain *chain,
>         if (tcf_proto_exists_destroying(chain, tp_new)) {
>                 mutex_unlock(&chain->filter_chain_lock);
>                 tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
> +               *inserted =3D false;
>                 return ERR_PTR(-EAGAIN);
>         }
>
> @@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_uniqu=
e(struct tcf_chain *chain,
>                 tp_new =3D ERR_PTR(err);
>         }
>
> +       /* Tell the caller whether tp_new was actually inserted, or an
> +        * already existing tp is being returned instead.
> +        */
> +       *inserted =3D !tp && !err;
> +
>         return tp_new;
>  }
>
> @@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>         void *fh;
>         int err;
>         int tp_created;
> +       bool tp_inserted;
>         bool rtnl_held =3D false;
>         u32 flags;
>
>  replay:
>         tp_created =3D 0;
> +       tp_inserted =3D false;
>
>         err =3D nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
>                                      rtm_tca_policy, extack);
> @@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>
>                 tp_created =3D 1;
>                 tp =3D tcf_chain_tp_insert_unique(chain, tp_new, protocol=
, prio,
> -                                               rtnl_held);
> +                                               rtnl_held, &tp_inserted);
>                 if (IS_ERR(tp)) {
>                         err =3D PTR_ERR(tp);
>                         goto errout_tp;
> @@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, str=
uct nlmsghdr *n,
>         }
>
>  errout:
> -       if (err && tp_created)
> +       /* Only delete a tp that we actually inserted ourselves. When
> +        * tcf_chain_tp_insert_unique() raced with a concurrent insertion
> +        * it returns the existing tp; tp_created must stay set then (the
> +        * chain reference was consumed by the destroyed tp_new), but the
> +        * existing tp must not be deleted.
> +        */
> +       if (err && tp_inserted)
>                 tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
>  errout_tp:
>         if (chain) {
> --
> 2.50.1 (Apple Git-155)
>
