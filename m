Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC62EACF9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685491; cv=pass; b=F4vbXiH3ANGiMCAehlIm5sexvMt9miVQmrG9Wzt5uShOcycXM5DSdQ10je6EkC3UOfsbJdJy5nlqvlGdRhxbVOC5XdsXnAz6zl1osw6CA5lRsGuD0XGFqky5ZO4aBzpRVvZba9dhPf0XOFVEr4CE1JcC6+Q47EYicobw+X+oDdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685491; c=relaxed/simple;
	bh=dk806SjFpPH8NpVBblIdKzY6q05TLQru/qiEollp5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgytjjAV7YT5/vK3O8XpYhTJ2uc6Q6c6gDB2LDC34IKip3cAxAQ1Cw0901OoZMqAFQHsqj9+8LeBVURkYNF1sc4CLpY0sI5FWXU2wbN0niVbl6r+lBzvo0F3rNyYuj/xvYINJPzQTE/1sbnxXjX9brh9+jTeotH9X5mndxS5y98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=GDaRLRfh; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="GDaRLRfh"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso828346a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786685489; cv=none;
        d=google.com; s=arc-20260327;
        b=AXVB+xEHYkl+LcRU3DmbiReBmbfWDqzxfqDHYKfAkwvviW6BKYEPd3sb+g//EYxNn7
         wrH4hgNzxJaC/8r2JNPCQCp3P6B+jjw5ZysHolgZ0blQ5leUIIui3vbOVGmLc4shmOfN
         MSth+WjNbZFosJ+jnG0U2szb8VfJxD9CO0MRJHaffzn3Qz+A/rBXk9/6zmWf0J+Buhm+
         PEZtcAQl38PZSd24Cxc99pRGitJPSs7qBkFmz/AGvFV3POLNmOoYmBKOOaS0VvlmwKfF
         RWgC2x7YOXlXRLVquf39WAP1n5Qy3P0+nI0b2+PVYbAlsPb8YZBB98QscJlQxxKW5L2V
         3C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        fh=0uJ2GG2ySjB/naqxwlYfDao/GPGgR+qwdVdzGI2YA6c=;
        b=IO+nQwzUyJ1xk9Jrgevt0yQtg+CxKtgtShIinZeNZqrT6OINindqDblKtDz0Cg/qd5
         VdiPsBqvvwp8yt+bMPb6cCu1joObcaepJ2A1QwvEGEw0oM3n55F9ALt/lQt5LfpDw218
         23mafMV2Ouq9HDXy6/ruzb/WJjVf4Nb8l8JguRlLKCPMxLC86kdAjbz47A3wXO3jP3YY
         hFr8oMItKhwkJhHcX9WZ3zfhMFSSkFlyoEnu1px0bDcTPNrMm9ijmNCQaifNb49EmSAz
         LMFaAi037tGhBibBawjatH//jlOQQcQ1cjG1N5kJDVjWh1Z04bVNQ2ldyIDdrWdYuHFK
         W9vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786685489; x=1787290289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        b=GDaRLRfh7DV9k1AuwzbnXKMLTm3QEt+b2WULffiru3j2Q0aXm68Q4UU7yeKx2btcD/
         svVopxw/6JSPLOfC48mvW/Dx/KtzZQjeiecFtDAE8UC+AviblPrAMTx7epsQMxYaho6r
         dScVg3TIDfhwz1Srv0gsUaqJvV3wlEfOn+ZfVj5mjL2XRIU+qz13EJHOiHjDrLOrkH2j
         pSKKHacPp/SoLZpCz4EoHFlXVgX7bBSPN5Wqc0Y97OnIjgBd/P0rfGGYgCI9RrFshgml
         Fdbis8QPS6Jk4M+4AHAyieoREZfdAt8Gvj0q4/r8jGZ8AdZI+Y1VCepklQ50d4P0r4pf
         5caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786685489; x=1787290289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        b=Uy6yEEf6bkvdnxbgWoiUoV/dx+pAfZS6fTv3C7zZ31Lidl6G1EaQXZRcyYDFlNq6ck
         E33rN+Wy5MaiQ5vW5DVbj87P6HVLFLccYrtkG5+PTxqMABUhbjzFuVCcN9k0Hes5LU90
         Oa8G8eZR+9bZTvAVBmnTNKzfUaxVfV+csEhiJ8CxNsLXp8dYVTgwMM34oyV9MOzrbSSE
         3pACQqs7ZjZsMn93WW/t2sJeXwyaOgWVITKHMo3NsvWvA+VOhpVK61Noqz5u915lE/vs
         EzdojOtOehMQry4ShykOsTT1nMHfCtm24AyWVJVqSk3FEuSCwH3rJRvOsby+FQLd+6Ha
         /lXw==
X-Forwarded-Encrypted: i=1; AHgh+RpDR0OrVyL5TM0meFW1nr60ldgbUs/Rsr6TinMTa9CgCJ57uQFUqx9UgSeyVEf2oRxp6RDhRlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytsxTJ4IvDvcApiZrWDqNNFfGvJg+9A/zstINkDt7v//YQ+J2T
	2koCrvUPvjw4nbSLECDYtjnaTw4FyANJPoVVtwrJPOmjZqDOOeYY4llWLAKlRPiGm46BpL/vD1q
	vG3BihX0N5k97rvRrQcwxOzr51pVafXGR7M62ZBb5RAPJN1c093UeIg==
X-Gm-Gg: AR+sD12V3Exu+m1m8KYVBH30kvgqqpOb7/LBTbMGYnbRqcspcWzZBrUziH3RulST1MC
	NYJtTkZeBK4tBm6lIhrvXzkA+CI/rOE+6jADan0aGoyZeD42Mp4Ms1DGqfVAKs7aHfaN5vLvzzL
	7FCcg5cDy5uty6sttgHAPRxuQUWVcdUHXPGV7blJ1dBmIvUaDPy25mkH/yAyjaXn/2s2nzZjsRo
	ttdWO6xCnxyt7fdWGfeomnTF8UpFURRk8YDycB6frT8FvZFyPcVze9NSsn/C/5V44aqg7zKI3ys
	T6UleD+lVrX1iz69qi0Gd4YmvK923XBKSSWA1A718DyBcw==
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3933b8c1041mr3685605a91.16.1786685489453; Thu, 13 Aug 2026
 22:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it> <20260814052541.1198373-1-xmei5@asu.edu>
In-Reply-To: <20260814052541.1198373-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 13 Aug 2026 22:31:18 -0700
X-Gm-Features: AUfX_myIgXG-OsLrFyLRWQjjcH7O6vsQUmJd4IgyhW0PB5LEPUCYkeJ32826dYg
Message-ID: <CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: andrea.mayer@uniroma2.it
Cc: dsahern@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	bestswngs@gmail.com, justin.iurman@gmail.com, alex.aring@gmail.com, 
	davem@davemloft.net, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	pabeni@redhat.com, stefano.salsano@uniroma2.it, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> Hi Andrea,
>
> We noticed this is still not fixed in net.  We tested your idea and it
> works.  This is the patch we tested:
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 9c677eb1d1a6..51941ad656a3 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -368,23 +368,16 @@ static void seg6_update_csum(struct sk_buff *skb)
>                            (__be32 *)addr);
>  }
>
> -static int ipv6_srh_rcv(struct sk_buff *skb)
> +static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>         struct inet6_skb_parm *opt =3D IP6CB(skb);
>         struct net *net =3D dev_net(skb->dev);
>         struct ipv6_sr_hdr *hdr;
> -       struct inet6_dev *idev;
>         struct in6_addr *addr;
>         int accept_seg6;
>
>         hdr =3D (struct ipv6_sr_hdr *)skb_transport_header(skb);
>
> -       idev =3D __in6_dev_get(skb->dev);
> -       if (!idev) {
> -               kfree_skb(skb);
> -               return -1;
> -       }
> -
>         accept_seg6 =3D min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled=
),
>                           READ_ONCE(idev->cnf.seg6_enabled));
>
> @@ -485,12 +478,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>         return -1;
>  }
>
> -static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> +static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>         struct ipv6_rpl_sr_hdr *hdr, *ohdr, *chdr;
>         struct inet6_skb_parm *opt =3D IP6CB(skb);
>         struct net *net =3D dev_net(skb->dev);
> -       struct inet6_dev *idev;
>         struct ipv6hdr *oldhdr;
>         unsigned int chdr_len;
>         unsigned char *buf;
> @@ -499,8 +491,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         u64 n =3D 0;
>         u32 r;
>
> -       idev =3D __in6_dev_get(skb->dev);
> -
>         accept_rpl_seg =3D min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_e=
nabled),
>                              READ_ONCE(idev->cnf.rpl_seg_enabled));
>         if (!accept_rpl_seg) {
> @@ -689,10 +679,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>         switch (hdr->type) {
>         case IPV6_SRCRT_TYPE_4:
>                 /* segment routing */
> -               return ipv6_srh_rcv(skb);
> +               if (!idev)
> +                       goto disabled;
> +               return ipv6_srh_rcv(skb, idev);
>         case IPV6_SRCRT_TYPE_3:
>                 /* rpl segment routing */
> -               return ipv6_rpl_srh_rcv(skb);
> +               if (!idev)
> +                       goto disabled;
> +               return ipv6_rpl_srh_rcv(skb, idev);
>         default:
>                 break;
>         }
> @@ -837,6 +831,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>         icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
>                           (&hdr->type) - skb_network_header(skb));
>         return -1;
> +
> +disabled:
> +       kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> +       return -1;
>  }
>
>  static const struct inet6_protocol rthdr_protocol =3D {
>
> We don't want to take your credit, so if you have time, could you send
> this as v3?  If you don't have time to land it, we are happy to send it
> for you.
>
Sorry for my English. I mean, if you agree with this patch, you can
take it (it's based on the proposed version you mentioned).
You don't need to follow our version of imp.

Thanks,
Xiang

> Thanks,
> Xiang
