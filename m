Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D9444707
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318462; cv=pass; b=ArjQaI+BRGKtMRXVjQ1o+SOpHWf6S5gY6r24N/+haMlLqGGHSmWjni8JDz62jFzprnsjiG1b+eV1kEmflgW5UD4MOOCqHOWIFUdUogO3iGSN35X01TfuqvbSzzAgo0qJzpSsqK94RRFAlZQ1j3u+dx9CQ+epu9Fj6jOFB7V2F3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318462; c=relaxed/simple;
	bh=HZ03q6QMCfUNFk72w9SHszDvgpUzynEt5vA6dxAXJmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbAhLYgjFQX8FcTFa4h2StAP9Ek1NA9DZBZmVTnW9UlGtjv6W9VG9X8R85kw/064STcEf3PlL66P7hR69O/9wui1bAA2ECcwgGLZNnSRMBjFL9qU+qFCKozl682k00MZa2eAVPXOKp26C+XwpGjkFquPdLHzguecH+0LHceQLf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ysCbdpUu; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ysCbdpUu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8484f229529so520976b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318459; cv=none;
        d=google.com; s=arc-20260327;
        b=hBnurY50ambqMekmlvRBDsOOt2yJGTPquUM7jaTEG6fbdqE0+MmrhSQ0/pniAixbBQ
         F9AU0w3S5siJEagvVQHJcpfs56PneLhV2RUj4R+ffRhLKIL/QC90heBi3j4fnt1OL7sv
         N+BU2s8As0rhBdfVJljhGPY6h7ez7/Fh/WFdzGkLBxVAUsrjYVQhVJGzRQv40xlF8+Nu
         ccp2Lkn8WpN4uSiJzL55ZszqIbSRCI03/kYkR28wDl+Mzz5Rgr/HRGy5bXxffjaI+UDU
         1HMpug09lohZvI3J96QfIUwsTyZpZaS3i4CB8TuKhMrH593vYVHJdH4FW5VO2C6YjP+f
         m6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        fh=TQNZBSxBrXgrzCxDRj5GH/QdAZ6l7LqpUg920DtHW1M=;
        b=XNFFEBMToVhgAJOAPt1BE1Q12hsGS9ulWkFhh6Tzf3/E44bGP3jWyU1YUwtY5YgPAw
         KwCEujBiMAJX2vyLOwhd6E5laSQVHA9tbAcbTuhXrvejX8hX00ToDnAHotyu0JbqhZOD
         PXEhVyoHO59PL8W7X+c41D44fup/65xgzt3oxBy7ybCvjTdh8Ah48UQZDMU8/eG73jc6
         VE3FAfg7mBtmstAEF8CP2LA+zEkP0phvxtB7HrSLPuFYbbWsb8haSbPWICUY1+aGYqSP
         WIMKKrFaOJfYUjOSk7ZwTluR0saxNS/auEXYvUt0jTwfX99ozbjD60iplZaccWJluOjA
         AJ3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785318459; x=1785923259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        b=ysCbdpUuqQklTyDRvVm3nrTeFqCX2eA1yvGmNlfn409Z0kC6advfQ7PTe/DJjE9+7f
         kWQEAcUHwGZhDMOZASPw8VyYWnTD5UQGBaX0AK65DrmJNRqMnsnkZ6XJh8WxAwNtxSsp
         D+Jvs0msXPBH0DuPIYj+tYRAJVnj9xiLG9LjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318459; x=1785923259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        b=rG7IXNUAmw8bkRmeBdPZXt0LJvQA3sStdTwuFkycezDN+3TDT3nIRSc3o6/qmdzOS+
         s0NFjZt3Z7zrbRN4F3i8t/Vjv0EI09DHf51annBfAkKAqCUqj5dkjPxNFxUX42Pj4yMy
         m6DySa4nbd02mPSootzFZktGJb/Zp41FU9Wf3CS9B+n81F/OrG/ehWnQ4UAUxVVEtm4j
         kz6N6y3WYS9/iSGKUjdR1BAn3N65bbWJHN7scj/eh0AKaAoafKJ0132TIWITk7g+hHmy
         pCbL8bq75quuXLSFGLQM2Nc/j+XUnVQ1AEi5otll8rrUoKkTCXbPk6dGx02/oNUHYxYN
         tenQ==
X-Gm-Message-State: AOJu0YxcSIgNvGqf17qbTeWyi7EKRgYjMx44Z2TvGe7Kroy6hpUio9s6
	hkbMtk6mMu0SS+qtH2JCtenq42SefmlGVcfWqAvCiOjZ7NHKg84C0dPhFGdT0CCfZXMpEuFYEEA
	PtsrSYtfdU8B0IsiIimFrYPG+vf6P5WUA40DPqvZyQxSIM0gNWqA=
X-Gm-Gg: AR+sD11vHJyWtg87/K0OFbG+HqZJklAk83n+1nlI6O+7j02g+JLtX4J373lYdNFKM8N
	7rxInn/G4KP128R0hm7a3d1KYqd8qVlZRtTMwTsWGdKP1Y+jRpNhi6za9LOdqdrDjPsMw+t7WRp
	tYZEdMh07VqKEUyosuDN798/rd+L+9e+pTuRkgTYhRl2Eyx0Sfw6ZaUORYtSleQTbJAFlaGh13M
	frh4ZW8ZDTJj66FtDPHC+70M6JJ3u2qeFIh3qYXSH6vtXljpt/E7r8rekLcRkbF3nrBMd0vlNYN
	V+M+8JrH2AT0QFvIsi0MzNnHNlQFEfcePEmdg450/Bn5Qg==
X-Received: by 2002:a05:6a00:1706:b0:848:8027:cb6 with SMTP id
 d2e1a72fcca58-84e933eaefcmr6362985b3a.45.1785318459189; Wed, 29 Jul 2026
 02:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729094411.46257-1-jhs@mojatatu.com>
In-Reply-To: <20260729094411.46257-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 Jul 2026 05:47:27 -0400
X-Gm-Features: AUfX_mwgbQ0U7pv5D3VeUXm1gxszOqY5ZeqR6CSf7Ek3QRtFrUAkKnSTcfb0S0A
Message-ID: <CAM0EoMnv4H5Y0xhq6vpATMzuvoPzAEacAu9wGMP4MyLmdG3Dfg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_route: fix fastmap use-after-free on filter
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	santosh.kalluri129@gmail.com, victor@mojatatu.com, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The route4 classifier maintains a 16-slot fastmap cache that stores raw
> struct route4_filter pointers indexed by (id, iif). The reader
> (route4_classify) populates this cache via route4_set_fastmap() for every
> classified packet that hits a filter. The writer (route4_delete,
> route4_change) clears the cache via route4_reset_fastmap() before
> RCU-deferred kfree of the filter.
>

Sigh. I forgot to add v3 on the subject. I could resend if needed.


cheers,
jamal

> This creates a UAF race:
>  1. Reader walks the RCU-protected bucket chain, finds filter f
>  2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
>  3. Reader calls route4_set_fastmap() and writes f into the cache
>     *after* the writer's reset, caching a pointer about to be freed
>  4. After the RCU grace period, kfree(f) executes
>  5. Next classified packet on the same (id, iif) tuple hits the stale
>     fastmap entry and reads f->res from freed memory
>
> Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
> concurrent add/delete stress test (provided by both zdi and Santosh).
> Both triggered KASAN slab-use-after-free reports in the route4 fastmap
> paths.
>
> Fix:
> Introduce a per-filter boolean dying flag to suppress stale fastmap
> republishing by in-flight readers.
>
> Fixes: 1109c00547fc ("net: sched: RCU cls_route")
> Reported-by: zdi-disclosures@trendmicro.com
> Reported-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> ---
> V1->V2
> 1. Fix based on feedback from the Sashikos
> https://sashiko.dev/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079=
-1-jhs%40mojatatu.com
>
> Restore the "if (tcf_exts_get_net(&f->exts)) route4_queue_work(f);
> else __route4_delete_filter(f);"
> preserving the tcf_exts_get_net() contract for netns teardown.
>
> V2->V3
> Revert earlier suggestion from Santosh's rcu sync to Paolo's suggestion t=
o use
> the dying flag approach.
> ---
>  net/sched/cls_route.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..eded7aacd3f7 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -52,6 +52,7 @@ struct route4_filter {
>         struct tcf_result       res;
>         struct tcf_exts         exts;
>         u32                     handle;
> +       bool                    dying;
>         struct route4_bucket    *bkt;
>         struct tcf_proto        *tp;
>         struct rcu_work         rwork;
> @@ -66,9 +67,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
>
>  static DEFINE_SPINLOCK(fastmap_lock);
>  static void
> -route4_reset_fastmap(struct route4_head *head)
> +route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
>  {
>         spin_lock_bh(&fastmap_lock);
> +       if (f)
> +               f->dying =3D true;
>         memset(head->fastmap, 0, sizeof(head->fastmap));
>         spin_unlock_bh(&fastmap_lock);
>  }
> @@ -81,9 +84,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, i=
nt iif,
>
>         /* fastmap updates must look atomic to aling id, iff, filter */
>         spin_lock_bh(&fastmap_lock);
> -       head->fastmap[h].id =3D id;
> -       head->fastmap[h].iif =3D iif;
> -       head->fastmap[h].filter =3D f;
> +       if (f =3D=3D ROUTE4_FAILURE || !f->dying) {
> +               head->fastmap[h].id =3D id;
> +               head->fastmap[h].iif =3D iif;
> +               head->fastmap[h].filter =3D f;
> +       }
>         spin_unlock_bh(&fastmap_lock);
>  }
>
> @@ -297,6 +302,13 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                                         next =3D rtnl_dereference(f->next=
);
>                                         RCU_INIT_POINTER(b->ht[h2], next)=
;
>                                         tcf_unbind_filter(tp, &f->res);
> +                                       /* Mark the filter dying under fa=
stmap_lock so
> +                                        * any in-flight reader that stil=
l holds it
> +                                        * will skip the republish in rou=
te4_set_fastmap().
> +                                        */
> +                                       spin_lock_bh(&fastmap_lock);
> +                                       f->dying =3D true;
> +                                       spin_unlock_bh(&fastmap_lock);
>                                         if (tcf_exts_get_net(&f->exts))
>                                                 route4_queue_work(f);
>                                         else
> @@ -307,6 +319,11 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                         kfree_rcu(b, rcu);
>                 }
>         }
> +
> +       /* All filters are unlinked and marked dying, so no in-flight
> +        * reader can republish a stale entry after this reset.
> +        */
> +       route4_reset_fastmap(head, NULL);
>         kfree_rcu(head, rcu);
>  }
>
> @@ -334,11 +351,11 @@ static int route4_delete(struct tcf_proto *tp, void=
 *arg, bool *last,
>                         /* unlink it */
>                         RCU_INIT_POINTER(*fp, rtnl_dereference(f->next));
>
> -                       /* Remove any fastmap lookups that might ref filt=
er
> -                        * notice we unlink'd the filter so we can't get =
it
> -                        * back in the fastmap.
> +                       /* Clear any fastmap entries that may ref this fi=
lter and
> +                        * mark it dying so in-flight readers can't repub=
lish it
> +                        * after the reset.
>                          */
> -                       route4_reset_fastmap(head);
> +                       route4_reset_fastmap(head, f);
>
>                         /* Delete it */
>                         tcf_unbind_filter(tp, &f->res);
> @@ -558,7 +575,7 @@ static int route4_change(struct net *net, struct sk_b=
uff *in_skb,
>                 }
>         }
>
> -       route4_reset_fastmap(head);
> +       route4_reset_fastmap(head, fold);
>         *arg =3D f;
>         if (fold) {
>                 tcf_unbind_filter(tp, &fold->res);
> --
> 2.34.1
>
