Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCC352015
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515652; cv=pass; b=eDKHo60qOt6vDD8+rSZQEf2LNgN4TWSZl+7/v4TkiOM13Yn3M1M3gkxh2Du4GJ6fUIZACNlPWPjIY3OwDZ39byI3f7bnFhKhgVnawXmyOrk+YbabQMQmzbAflxbEFbsf1U7+dP8nzmsuXM1V4w9ingsw54ImlQYirXsvyX6xjww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515652; c=relaxed/simple;
	bh=okHwXQSOYRv/EX6kAKl/uikenhAdgox5qe1/tlHCQtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQdqleINzsnWgvvI6sEk33sVvu0skAhAWD9M6MRvWcaAzxEr9manGxlxgGxu5r9hs3ORGuLAZSnTtbmVFBmguj71UVplsY49OGygvJhMv2fTuM9LdoB/Y00KPx/cGSRimDQ6ZtCc7y+NwPQ0pQyIHVxnjS3XTxHJcngHW1ylBj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=qcqIdadu; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="qcqIdadu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1021730b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515649; cv=none;
        d=google.com; s=arc-20260327;
        b=iUdpL5VPvsvxOUSRKq69/8BRagALTSt9nTIykrdBs4MWgXEtyoiTVzL2kxoLWd+gFk
         4kg84uEwTFWJEoO0+gsq0xRu67thecDE4IoallDSgjv6/bl9QFKSfn5uPwCzw6rWzsg9
         WrvvZP16CSuVh/TuEN2QZ1zDumqo2JVKoVkyFGmNG97ZHveI8O28RDWswoP34pzYZFfy
         WI9xKejfn9V9Dsn4CI/cncl2J2lW1qCZ7ofWzV/q4Cv65tre9/+OaDDrN/tzcjS/k/r1
         tM2Lr1+Oq+n+7ZcS1q2bK90KzbjA7K86VfNBXBgYbQopCm41EHaOOkfayft5igZFfrL3
         ZXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        fh=Iq8sixuyhpWophDSdzBZhMFWeWCQA5yKpNi/LOrsxp0=;
        b=N4OcK+bqohHhmL9NIODYBMNro+lquUTMOgCr36kKQycgqA1vYflq1hEC7S0LFzgHQM
         mqStOTZL7aiYuzzqaJKy+On/vZ/WhrumIVt5M3tVWGMNNZtBBzo2moJFfcSQQQFtjCmH
         DvSfzSrGYGJMM8hbnkoSehcgSWWOJqT39SBdvZYKCMasMEHLWuVUfcVnCgSxKKYi8uln
         NlKfa2H+eg8RWy6YCsRdT8z9VAClnVTQVRy6X2OMIHxDW/kKLecYLwvKVdElntKs+vPo
         YjP0EANBR6hwC6ryexmouMPRx+WDaGwf8KVm2/OP9YjTPKM7fsrHyrq8AHF+WumDO6lf
         dLyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785515649; x=1786120449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        b=qcqIdaduX3RIF4vIElnRwjAJXV0m7ygIPu02yQ+BFyTY5DZALjkWa2LzYO/qPVbUbP
         nTBgTRYngvvHndp527YNUiB4ZlUDz/sIyz2Xein2HM78RQpSeFskJht3qAMFEyvotISN
         njX2IGllh9gcmDhpiyqF/6a4G/LN8CiRTDHeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515649; x=1786120449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        b=QjQCj2uYGeUrKExhhb6VN9L0SISD2sBIv81GJoDGSvc8YotcCeoNEykqJC/DO3+Pk8
         agIpB4KxgSWwEh4kiM+OAxBBJDJP21d7SCAvl8SW4WYmz2CFE93ZZ7Tl1AYiAWpdL17v
         5qXU+aivRtLVsNqc8/vPdNi7dibnXfGBJuN1qSJgKicJH4JwxYQnBA7+gQTWyse4uG86
         SvPO9kSbHS5girl+fidjp30BJwikj+p3jjc7h8AlgF00A+5tsTZbAmIQA6DIyWYDVi0c
         YCqwhdGUUNVp453EfQ1248MVE1qDmcbhjHDXaJ5p4fnqoLmW0mv6+jFojG7RaY/YOqA/
         FGAw==
X-Forwarded-Encrypted: i=1; AHgh+RoyKvJeRkUXLDxPovu7KaDuK37K0veRlV3B18vym3PtFZL1+iiY93e5++643EI25cErvHiEQkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGLDlIXv3PTsMu7SulDkX1QwVdLguv7vNnLKKE70zF+L0q1Dj
	HAoLKuCrwDODvs3t+eW2iOUktvT/J5/CKd5VjYI8rWoG60AXWhor41ZaXeAsYq99CNiJVTEiUio
	10rspnx5kifKfd742ZPA4dPlLYEqJympexp5iTToO
X-Gm-Gg: AR+sD11CnsMB/qQGuVIV1CzcFl3In/IpGVPehjT9DCmssgqulXqJjgFgBWnA1J65jln
	3PGbi9WI1HbqihayRBPqbAogmkblG8cwCJU4rBFJPDEFnl+7ur+TNRC1Ab7TYDis79sJHCjLkLT
	fcsXpu47P+V/FXL0bIzjVm1tHSItp9lDn3/uIY+4TkD3X15HThxuTzvbpJrRqCI8jrUvdepj8vL
	ir68EO0kvQcZrmYV2kM23XSWM87NnlTZUWStSNf7dqmzjsUxGsYOA++0mF/mnXUD0sP0tgzZd/5
	FMtR1VHERAKledkIO7jQ+5ErIuTQf97uyYAbPpQrQnPnTQ4e6Y/P7j3MMJEp9L/K3Roq
X-Received: by 2002:a05:6a00:430d:b0:848:2ef5:50dc with SMTP id
 d2e1a72fcca58-84ee49a3159mr240282b3a.36.1785515648841; Fri, 31 Jul 2026
 09:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731153031.3201165-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260731153031.3201165-1-nicoyip.dev@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 31 Jul 2026 12:33:57 -0400
X-Gm-Features: AUfX_mzWP3nhr226FdASueIw6k8K3-HTeoneL27FCRHreI6GF6mzQr2bcITxGdw
Message-ID: <CAM0EoM=2Yqg2FqCpxvn7teM8E1m6oF6nebyvXA+JBKuwpowSQA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: keep tcf block alive during offload unbind
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@mellanox.com>, 
	Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> An RTNL-unlocked filter request can race with qdisc teardown on a shared
> tcf block.  The filter request takes a temporary block reference before
> teardown drops the qdisc owner's reference.  Teardown then enters
> tcf_block_offload_unbind() without retaining a reference of its own.
>
> The following interleaving can occur:
>
>   filter request                   qdisc teardown
>   tcf_block_refcnt_get(): 1 -> 2
>                                    __tcf_block_put(): 2 -> 1
>                                    tcf_block_offload_unbind()
>   tcf_block_refcnt_put(): 1 -> 0
>   tcf_block_destroy()
>                                    access block->nooffloaddevcnt
>
> The unbind path may sleep in flow_indr_dev_setup_offload(), allowing the
> RCU grace period to expire and the block to be reclaimed.  It then
> continues using block->cb_lock and block->nooffloaddevcnt.
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in tcf_block_offload_unbind
>   Read of size 4 at addr ffff88811ae590a4
>   Call Trace:
>    tcf_block_offload_unbind+0x158/0x190
>    clsact_destroy+0xd6/0x690
>    __qdisc_destroy+0xdf/0x290
>    qdisc_graft+0x5d7/0x1560
>    tc_get_qdisc+0x415/0xd50
>    rtnetlink_rcv_msg+0x367/0xa40
>   Allocated by task 85:
>    tcf_block_get_ext+0x803/0x1570
>    clsact_init+0x1ff/0xb50
>    qdisc_create+0x392/0xde0
>   Freed by task 88:
>    __kasan_slab_free+0x43/0x70
>    __rcu_free_sheaf_prepare+0x5c/0x220
>    rcu_free_sheaf+0x1a/0x100
>
> Keep the qdisc owner's reference until offload unbind completes by moving
> the unbind before the refcount decrement.  A concurrent temporary
> reference release can no longer destroy the block while unbind uses it.
>

Please always send a reproducer - either as a tdc test case or if it
is sensitive send it privately to me and Cc the other maintainers.
I will not look at it without a repro.

cheers,
jamal
> Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower pr=
oto ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/sched/cls_api.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index fee4524adc98..d3b2506d87cf 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1312,6 +1312,9 @@ static struct tcf_block *__tcf_block_find(struct ne=
t *net, struct Qdisc *q,
>  static void __tcf_block_put(struct tcf_block *block, struct Qdisc *q,
>                             struct tcf_block_ext_info *ei, bool rtnl_held=
)
>  {
> +       if (q)
> +               tcf_block_offload_unbind(block, q, ei);
> +
>         if (refcount_dec_and_mutex_lock(&block->refcnt, &block->lock)) {
>                 /* Flushing/putting all chains will cause the block to be
>                  * deallocated when last chain is freed. However, if chai=
n_list
> @@ -1325,15 +1328,10 @@ static void __tcf_block_put(struct tcf_block *blo=
ck, struct Qdisc *q,
>                 if (tcf_block_shared(block))
>                         tcf_block_remove(block, block->net);
>
> -               if (q)
> -                       tcf_block_offload_unbind(block, q, ei);
> -
>                 if (free_block)
>                         tcf_block_destroy(block);
>                 else
>                         tcf_block_flush_all_chains(block, rtnl_held);
> -       } else if (q) {
> -               tcf_block_offload_unbind(block, q, ei);
>         }
>  }
>
> --
> 2.43.0
>
