Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BA4CCDC8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358728; cv=pass; b=ngQtlT2sSOFfPf2CslDSWiH7ofMLKGab3i+ejqXOl/gG8OqhMAMM9F92+8rMLuDA6zOrXxYTEkkSMAxCDVhFnhyxCqHK5hJ77VediWurtJLFice3eTO0GRY8fOpwwvJfWy/B6e1kb2v7bT4Y/T3d40I8cTTdiXQ92f+S6iGsoaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358728; c=relaxed/simple;
	bh=om459VHzGIcS7fnosyh6/zrkKImWOivry8YlszBybgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iP9nswvxFHvT8uhArp/LxdJFY3a7w7/SGKmyLiiiwsaO1AAM3O56/zVVJ9yJkO8vbLOy84wPwGdDtM/RVa3GW4cpuKcdOmMqApshHv6EsRKEfCmjJ1DxJFSkjbs+NBDYV4nXEiucnN4BAyIIrWKzOQKPyd8vXEWen0ABXyOlZ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=prsWrMhm; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="prsWrMhm"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1565265b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 07:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358726; cv=none;
        d=google.com; s=arc-20260327;
        b=aA0uQF5Xpj3IoeEyIXg6raJgT3YpEIAVgEJlzFNAjt/TR2ho0Q6l3MRuOpfpEoN884
         F1I7+6AlkQNnTuJob2+R9eTJn/QBfuUJ8WRwl6H/DkOvv2BEIpvkngqoeyl8lC1dI8IZ
         mAFJhORhQBLNafoBr2p6AvHPoY4PRTUMaaWur0E+4eCGZw21M3KOskZKtNEVERF/EfZh
         pZEPTZgNI88cqXSZVdSZX2U6lM3oC6Gx0u492kmwpbz8KO9TUUtuuO6LwNTAJ1T3GVGW
         kXIPta10FglpenvxpIAMAV02zg5EaEz6CVeviavJoCwG0PC50sGtGqOXdhrronXvAwat
         2nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uYNjIZZ8RMmiF+3QP0G43VfzKqj75CKSNv+DnxNLnmo=;
        fh=WZObNTyBda+jlO3u+3ku4cv8hKJ5z4w0U2RTMO8bX1o=;
        b=FIFPdiESNuI3PgPbdzYObQAxZAKbN1McfYLWWK/1JMnz4RqxVVLT6/6olQmWfTp+Kw
         OeNttpcXy1Pk8cpZRlnXdj/SWzsPUSCFtEWU0wDGB4YP0BjfJdqIp6mbEfVXr4qkE6Rs
         vBJ/sykQrty7NuaRgQj9P8zhBB9jNfM2rD4t2mBoDVAgwOMVEKmoYbNuzbnSI0K5A1UP
         RBZzp0FvO8mD/1L27BjbpFKamxDOB+yk9KiwdMOQ/ibfUwrTvDWVUotOEJk6sfVR/ejc
         FQ6IIoCTjVRvTGwjBDfpp9pnnGTNua0DTwZyKf+zJ5jgFsnXVd1JHvyDd8S8U0VErCKd
         12dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788358726; x=1788963526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uYNjIZZ8RMmiF+3QP0G43VfzKqj75CKSNv+DnxNLnmo=;
        b=prsWrMhmoQUBWPD4+yI4lrN165+gPWImmdf5uctf5fC0QVskkIDoHtsbJp/6DqlUNP
         Oy3h8zmC/NiWoq4vlIgtWwW4neAAVDUum9sNOakazos2t8odkKO21DMfEtGPUarvZ06x
         Qq6oZWA/jCG/eNCGhOqIV36nH8umJHjuuKQh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358726; x=1788963526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYNjIZZ8RMmiF+3QP0G43VfzKqj75CKSNv+DnxNLnmo=;
        b=Z0zfQ3xEWP85pRjBxXvmBL8u/+o6rF6scahHrmiHy9wyK6fF60mdSD6bdAsvOJgwnl
         cnUjMGMMG1zER8ilKRtOtYNgrl5tM9YUBJs4RkzgvyXdRfGAj1Mu7y8cspxBevmOPhk+
         DJSJnr1mxO6TJ8P2DFzr4/SnYDSYhFQEoAOVIGjr7Wqn6FmapYtpH8GQmRhOMeNWSwMu
         MvWRO3Ff5wEm3FI1DX+pjYTh7ub7R1oBWhEkprmE90T6FqHfa5aN+4AbRqZ+XNGvQlzi
         ZHFCMG7toXfXhmHPLtmtInclaKNKDU93xbk17aTnP/HcXNIjaAtqWL9es6cYuUQCfmaT
         0Q3g==
X-Forwarded-Encrypted: i=1; AKwUvBwH8+CHgrPMb7wZNejKSomUe5aAd6NC76uynvb45IFznzv9ajNB0vs4Bpo/x4Ei0m7H8/7zhIk=@vger.kernel.org
X-Gm-Message-State: AFuF++nLrEwHwDc8Lk+1h7AeJPN5m9nko55TdXl3Eo0JUggtUJyylZV2
	QnHypB85lUYkW5w1fxX6sWZwTobuDjcdTFrcsx3WokmfdVhJOxq40Aj4qVqkFUIUdHwjE39ux21
	gV4tJLL/j7HLuFWgyYo9n/F4pdWhqe10UngQKZjz+
X-Gm-Gg: AYBFou1yepDce1KD1lq6InCxMOSjPDc5P3eKjp1uebqcsbcglOsa41KsxGRW4jKMhUx
	LT+iJWi0ZuqQhdRU9otP58qQyiwNkBZ8yliTkm1vQWY5byXevFXe97sh1TEoKd+u9/GJI0e9VaL
	vD9fzCAkyWUhEr0WtcJvCJKADnlOqRXwNQYQjHePymB7D/5zsceStYorIgqv63CkZq5BvpVS0Yj
	722k08vVvsII2hTg8aILlLiqjQv/q8UFDJFyb4zWkWcJjdUm5sSWvFnspIUSDdcgQtP/cE5t1D2
	M2TrRS4adJX6Nt8KO8OLARE5miezziNLZAV3Z8izhyWkfPg6kfdbVP+uVMehCpH6YkWJ4ixSrTs
	QK4ZGexWvfZt4xbQjrCWNPT+Fabg=
X-Received: by 2002:a05:6a00:1701:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-85ed21f2412mr6888834b3a.8.1788358725561; Wed, 02 Sep 2026
 07:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPBHdam0Y5cxjFgm7MgavPNHrb=wOSCG_BODbYsn5y2-CGKfQw@mail.gmail.com>
In-Reply-To: <CAPBHdam0Y5cxjFgm7MgavPNHrb=wOSCG_BODbYsn5y2-CGKfQw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 10:18:34 -0400
X-Gm-Features: AcwNN1U6X99laJb8c88uWPJYk3eUllDdXF5Y-4eBqmjSTbtDjbsRQ5IZUPYJXh8
Message-ID: <CAM0EoMkc57T879QJEOUg4n7pgoff4iLzmF16FGD7j+0ZXmhrug@mail.gmail.com>
Subject: Re: [BUG] net/sched: cls_u32: ht_down refcount leak on replace_hw failure
To: Qingyu Zhang <usupergate@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:55=E2=80=AFPM Qingyu Zhang <usupergate@gmail.com> =
wrote:
>
> Hello,
>
> u32_change()'s replace-failure path leaks a reference on the linked
> hash table (ht_down). A patch is attached.
>
> Type: memory leak (refcount)
>
> * Summary
>
> u32_init_knode() does refcount_inc(&ht->refcnt) for the copied
> ht_down. On u32_replace_hw_knode() failure:
>
>        u32_unbind_filter(tp, new, tb);
>        if (tb[TCA_U32_LINK]) {
>                ht_old =3D rtnl_dereference(n->ht_down); /* live knode */
>                if (ht_old)
>                        refcount_inc(&ht_old->refcnt);
>        }
>        __u32_destroy_key(new);  /* already drops new->ht_down */
>
> The extra inc is on the original knode's table. Destroying new
> already accounts for the copy. Net +1 that is never dropped.
> e8d3d78c19be added that inc; it is wrong given ec5b0f605b105.
>
> * Affected
>
> e8d3d78c19be. Reproduced on 08dbfad3f504. Needs cls_u32, a way to
> make u32_replace_hw_knode() fail (no offload device: kretprobe, or
> a driver that returns -EINVAL), and kmemleak.
>
> * Reproduction
>
>        tc qdisc add dev lo ingress
>        tc filter add dev lo parent ffff: handle 800: protocol all u32 div=
isor 1
>        tc filter add dev lo parent ffff: handle 801: protocol all u32 div=
isor 1
>        tc filter add ... u32 ht 800: link 801: ...
>        # replace that knode so replace_hw_knode fails
>        tc filter del ...
>        echo scan > /sys/kernel/debug/kmemleak
>
> kmemleak: size 192, u32_change, handle 0x80100000.
>
> Because skip_sw on replace is rejected earlier ("flags do not
> match"), the QEMU PoC uses a kretprobe to force the 2nd
> u32_replace_hw_knode to -EINVAL (poc/fail_replace.c + poc/u32_poc.c).
>

Isnt this the same cutnpaste from here?
https://lore.kernel.org/netdev/20260813122242.1690024-4-jedrzej.jagielski@i=
ntel.com/

Have your AI check next time instead of overwhelming us on the list.
It is better not to post anything that makes someone spend valuable
cycles going to double-check this slop.

cheers,
jamal

> * Expected
>
> Failed replace does not change ht_down's refcount of the live knode.
>
> * Actual
>
> The 801: hash table stays referenced after qdisc destroy.
>
> Please consider the suggested patch
>
> Thanks.
>
> Suggested patch:
> ```
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index ac6d0fa5a40e..a619dbb435b8 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -938,14 +938,6 @@ static int u32_change(struct net *net, struct sk_buf=
f *in_skb,
> err =3D u32_replace_hw_knode(tp, new, flags, extack);
> if (err) {
> u32_unbind_filter(tp, new, tb);
> -
> - if (tb[TCA_U32_LINK]) {
> - struct tc_u_hnode *ht_old;
> -
> - ht_old =3D rtnl_dereference(n->ht_down);
> - if (ht_old)
> - refcount_inc(&ht_old->refcnt);
> - }
> __u32_destroy_key(new);
> return err;
> }
> ```
