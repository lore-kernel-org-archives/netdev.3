Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D524534A7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112991; cv=pass; b=ZHUPI6Zn4I5Eg8ymtFOxRBza9j+yd9wkj90rYvG49wyPbUDHoZnbNTY0g5NE6hrDRTO1UJG+WJOZR42PNQB36c8CotHpNCnrU/mYNk10aNEPwP+hDeerpgg7U7Vng9n1AkDCVOEpCvlncIulgzooIPn4gXEsv22TNdJv08jwJBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112991; c=relaxed/simple;
	bh=aZGKfL3QuDsd4IV/LQDvu27JhAeZANTouNPDY3sRBkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT/Q1LmwKAeDJrdMOdoduRO2DvflBssiBqG1PYiSuXz767WskNXISXcAAO84vIweV+e9FjJP/2KGeGWkc0AH2ZuA8J3mXDe6fhTs/Ld4J8MTbOT4UZVgx1jOuz9kVo9YYn1+1hF8HlcNTym+Cp7YBQVXdXjSfE5tIl8UPNJliwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DnqNkRhM; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DnqNkRhM"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso198687b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112977; cv=none;
        d=google.com; s=arc-20260327;
        b=flZyCqP2kbpMhrmZjFQdFaIwfhyLhOQ4OF+RZ7/tDE+1b6KQVhr8A42BIv1WCj/jrW
         RZfo2wF19QgHLXQMTCG8m/iI/Ro2tj9NihOIQEcGMPaGwgK0l0xUbUxSZgDHmFYEz1O1
         gEHcKNYnVYSlIGjwDiLGPX45D1+ZQXEjq2yRFHRezGNH6hx7wiw05T5tV5cm1Rbx3/2J
         VT7fYkbs2NDAZJ1FOMn0ck69bTxDgMo5/P1Rn/I6GJ+HA9mDWkPZXGi2+Xn/IY4SyL+y
         CiYyygJEVEPA1fB+zSur0iyKJ60UQ+M5CH/ikcRQ8RaShynm6IWcDeZNrWNjAotxKGQl
         n7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        fh=UxWnTNemcreQBom6ZZra+YH79euTrEY7bPLRACemUXk=;
        b=QTSrwpR2nOsmWr3jjyB5hGyzlIhXZcMqv9Io7BsDaxqcQDbfDdkJrj3E2/p/5x3z7g
         SaTQp6IXFG9F/iyjEuAJxfwYVLDKrqyJs9RNlCszYY3Mi/Sd0w+Q/Mw+PRjWnhC6LWde
         oCJfllWq8E1Oy7JtifqbF1KSal+Ea6bwR6oKKCcn4+1L2knh3s6Uue91FmIk2IldcXMC
         wM7yvFePdd+vw58Fhs5IM7F1G9C0wEaUJvxDrdGV9RM4gaa77zn56HJSe8mpu7MQEgBJ
         HFcVGpDblJywoschtJNFBLQ8LGnQGv4EC50bt2UCNCk3cxkWsuHSQLb3YB/Tp/RqUI49
         P3VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112977; x=1790717777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        b=DnqNkRhMANDAbz8S5xGFlfWPA4TC6HEBdoloJTzkhG4LfCrEPYGEKtpT/8TOc+jc+K
         kZvWarBK8zOodWUKLeMNCiGOEM0hQh2wzWAUI2U9ZL78Shhz7CSiDe/oWd5nFcvAnZ9L
         CIafMBSlVa1Q0EWrcXq706DUipXzYhPHoezVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112977; x=1790717777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        b=P0pqMpYv9YLt4KsiuSpUTv+3cRhdfcdsRc7dwqkbcfrpBw+mkmGgnKb0vIkaLuBalQ
         bjM8vWA/HwibDq67ScK/4McBtKscEqdMCZqmaPYMS58HWmQXXSltSRtPr3Zy/5Bo6g5O
         pFwlsSCI93uk7cuDSbhsKsR10rbuSjrtPVuq+aEZlSBELiKHqEOhv1wYyChXbBbWCUT6
         teX4HykUweCTpLc/p2hIrRmFo/7UElzchV3nRzKGlMQM3FWorbVfNg5WkENl7FLRDlsM
         yOZ6Cf7hBftGO8e4j+bF/cFCUB3Y7P4ig/iskYR9DyFHosvnwwkKWNSV8TDiyBfsKfY5
         HzqA==
X-Gm-Message-State: AFuF++mpbO1gCwWy9JVjvY1S7dJ4ZitD3m7NGjEUdV7fuWgPf6LWuvEv
	M4v2SuhwsVDueDoNUEx64ETXb44VUc/ahxCwwXdllFVvEiwLi6ZvMqqWSmYM8rsyYQGVWgyL6OI
	kZoBCJztI4lB3xwMbuq/qaiigHQZpZTmbDP2QuopS
X-Gm-Gg: AYBFou3G9mmDTY6CCkTwNahysUQZ5Z8pEH5OLWD16aF/muPuWZ1rBZTYfuFLJBxas0i
	yNqzkHpI1vZWwtnPBSgFQAuR07UlIDBBYMBkM5F8WCh44W9AtWxix4zdllzjLerY6UpTVVfFNLd
	MlidXDWk6Yqb3nOAs13UtEZSWlW0eWKK6ETNfY9Qdx83qRZs3x8jbH8JKt7K+ISk4kGn9KlW/vz
	8RJ66WsvI37iXlcjZRDXz6NMAmW9mJNzSlMyYxjmcG/qtAvHR54x0SoocfEAnIQNsy4sBeVODzH
	ue2zVGuHBkmOiOQ+qois5z/NTIcLX9SDxIyCJsByNpMwfHhu15/5AZASSSPnyN+ydD7pXN+cZZg
	gdtTSqm2IEf9UTGtJQje5JLMy6JCrK98UTA==
X-Received: by 2002:a05:6a00:4099:b0:86d:3958:6b13 with SMTP id
 d2e1a72fcca58-87d1b0c0ee7mr833702b3a.19.1790112977303; Tue, 22 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-7-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-7-i.maximets@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:36:05 -0400
X-Gm-Features: AcwNN1WkTM90t4zAGVak1fLnVY1e6J2lGuTsKVieqJYWq0WRhgHFKVnTUE18TSw
Message-ID: <CAM0EoMmF8KE2m0B8rON8iOcaQAHWMSS6G=CkOdwh9snaTzvNpw@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to
 extensions realloc
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_ct.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index f62051ec9d57d..411e3dd92d072 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1102,19 +1102,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> -               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> -               if (err !=3D NF_ACCEPT)
> -                       goto nf_error;
> -       }
> -
>         if (commit) {
>                 tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
>                 tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
>
>                 if (!nf_ct_is_confirmed(ct))
>                         nf_conn_act_ct_ext_add(skb, ct, ctinfo);
> +       }
>
> +       /* Run helpers for the connection if nf_conntrack_in() was execut=
ed
> +        * or if we're about to commit.  This has to be done after all th=
e
> +        * extensions are already added.
> +        */
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> +               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> +               if (err !=3D NF_ACCEPT)
> +                       goto nf_error;
> +       }
> +
> +       if (commit) {
>                 /* This will take care of sending queued events
>                  * even if the connection is already confirmed.
>                  */
> --
> 2.55.0
>
