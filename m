Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713363CFF61
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952773; cv=pass; b=oJprkPer7xz+W/xw5uCi1NEWosSu937cim9B+1TLiZh7JMDQ+B3F6LTCVdTlus0Ur4r89OB3wwnHrSVuhzy+93ZXONrcsneGpSxSo47gEdoEf/gADr9OrE9zcTmySR0igKe/eOfToNkCYFCJmqiBu5vmfJS+AVgKc8AXaytHI7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952773; c=relaxed/simple;
	bh=FQiUpankytKxTKHY7NyDfEfHcihzlbQLQJ2TP95U4oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFlsWkvQcVfvS3oAfDFMRK29oEu5yWyc7OCfpKj4iUou4wGbPnvBHiwltcQ4ONyNwREpstIFgS6j4TjV1/gsIgwU+cabdVqeuqsY/QuF09oe3gw7YhMtsHDaAbedUst3V2fcKChJvjmtyXobuqCUMATKwHZ2ZEd7dvc6HEAqaZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cWScgGVL; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cWScgGVL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8484f229529so1174613b3a.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952771; cv=none;
        d=google.com; s=arc-20260327;
        b=ZjAqPMCYRo6pPZQ2NG4JQkssEzHXQE/VRW3QR+HLz2OcET2UE65fNh75ffjm26/LbC
         wqcHt65GrvFU+OAy6dPuBfS5AUU69/nsGJyNUKicn0kCrPpOUHrRNEfgshCSoKS3W4kB
         pm2+QpArIo+EZN3SrbKnMVEApG+LTa1UtNEkuQDQXStHFVADiIHf2PqxaAyGn+Elf9sH
         nRUPmi1gMXjARu4GseInOoCuDIgC/JG2EjS1ZEtnllhVeECyHr2nKWdZ/9Jyq25AA8YB
         TkrNSVGZCJY/Gy2fxY7hRQEBLT4CJUlqxXt2LlEbsuqyijKf87r9w/ql/BvXII5CNG1C
         RwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        fh=9E7XFhWTAM0V8WZr0KGWOOBJ/ZKEIODCZ6wgZuoBOOk=;
        b=LuZyhl2s9zqklJIT++/6bxpXvXtVhpX9WD97uxtrpz0i0cB6O1fHw6CPKQhJeSFeMG
         ghVuQtmqSdkaomRt1bp8iAAYvPcF8EsUoLsLrbp36WuKawyWlYfH/pRlFlgVyX5leJ94
         2S3s5yvMT/r3f0gUm9/5kpIi8mOG8lh53Vco4hgpSKuFcVhxzV0zqWxUNsESrV7veUU0
         4SHMKYJKx5ddrVfV04YaS+sLgeZT9PA0tHjf9yIXdnBrLhgawuJxUKA2AeNl8M64tlQE
         lHEPc/BE8/gMKToyaW5iCoEWrC0HUZvJ/D1Je0eBoFZyhbF9KM9eRT4cb87xq+FJCO0g
         b4CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785952771; x=1786557571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        b=cWScgGVLdwPQqhNkaqtuX7xamwsHMsh5gNx/zcaVcRo87eUQ3hEAUeW/w0CE0rBxIc
         qh+5vppVUQHTc3UcvBrVoTsL+Eg1rqRA687zh7PKL8JL1oM4igs/upA4PEBw1CtYpynX
         2mkXaxtTe3iELVHdQ7sws2DPWMGQ5uzSn5Z34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952771; x=1786557571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        b=OWMPBPfRSQdajWqCW/9JfJl9Hj422vmfEQAZHFncRiOm/o8H/bucCRL9MgjT2yjhiA
         85NEepvqxgtJIC058K0aZqN+HfjknBz5VQ/kf/DrEGP3xTxDHRa3pl5VuksHYIwNsfnT
         c8qtqx/+hi1LC4BUxbiYLMs8WiSB2+YP19KlMYOH9qw1DI9k+JBx0eL6vvOBlW3lsmQj
         Uufj7fn3m3dBfh3oGg769xaQeR7tcgvRlWU9jEWQCUi3z+q95tM2HxHjp8JeKLTfiT0I
         QcHvBWfwmcZoumei/LzsEnwjUFqUkFwWqQ1lwEfu+AhmW7E8QEfRBWan/uEdxvDHbjo/
         1NcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6z1twXhq1kMnKF1kQlatkESCkYZyYKA5TUgquB1QgYluf0KztrhivEgh1CXxBfI5+5XM2q3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+qCPLjAVKz39Rg4gqhRc6QNUxZqsX6m28d0bLiVTD7r7LbUS
	vdUBMV1C5GpvL7nzn9KJnD7yf7jwBeM8llIwrofW3UdR3hkc5yhHEYl5qRsHuGvZEgGyPlCZJ8P
	rTszdp9iLdZ3c2d8I4nBhIzqWwunw5QXo+81qMh5J
X-Gm-Gg: AR+sD123pKkVwfRqNkl036xMroOKbKCzyyA56ooVHrlNaXaT6/TvA/qcXVxpKkkbRSP
	fd83CAPi9ClMMQPV/QhWf1Lku1n2tJJ8YIFUfdQixQS7OmLeyqvF2IbSvpTrChPEDY71ikWM7UN
	IBwgXhguN6E+9M0gO6tcV/AHXsVxueLqr5U6Yu6wgt1uWfCGsCUUtGs8U6jNGV/oWAWumlGiCGx
	VXQaFcYRJQVOzuldAS+Vma7mQKVcOrqLCpGxKT905BR0ww8GjHWNEcWF3mmVn/ThF3BmgT04PoB
	CzxR1F5Ju4IpRWj4YYaxnAxX1R9r76Onq5cb3KTYCNSLFw==
X-Received: by 2002:a05:6a00:3cc6:b0:847:9267:2104 with SMTP id
 d2e1a72fcca58-84f2e031753mr9496436b3a.12.1785952767790; Wed, 05 Aug 2026
 10:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805095527.204088-1-hj351016@gmail.com>
In-Reply-To: <20260805095527.204088-1-hj351016@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Aug 2026 13:59:16 -0400
X-Gm-Features: AUfX_mw7KHINX7ExRnnhU-LXBcyk2KKAMoj9Afc75rGtgo1eXfQsICDF53NDjEY
Message-ID: <CAM0EoMniQBhncxxUyOVLt-EB-hwE=P93p-hS-U2ERkphmcEsLQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_gact, act_police: range check the
 fallback control action
To: hyunjungg <hj351016@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, John Hurley <john.hurley@netronome.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:55=E2=80=AFAM hyunjungg <hj351016@gmail.com> wrote=
:
>
> From: Hyunjung Ko <hj351016@gmail.com>
>
> tcf_action_check_ctrlact() range checks the primary control action:
>
>         if (!opcode)
>                 ret =3D action > TC_ACT_VALUE_MAX ? -EINVAL : 0;
>
> TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
> cannot be set that way. But act_gact and act_police each carry a second,
> independent control action supplied by user space that never reaches that
> helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
> TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
> verbatim from the action.
>
> In particular user space can store TC_ACT_CONSUMED, which is
> TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
> range. That verdict tells every caller the action took ownership of the
> skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
> tcf_qevent_handle() all deliberately skip the free for it. The result is
> one leaked sk_buff plus its data buffer per packet traversing the filter,
> unbounded, for all traffic on the chain including kernel-generated
> packets.
>
> Both are trivially deterministic. act_gact clamps tcfg_pval to >=3D 1, so
> with pval =3D 1 gact_determ() returns the fallback for every packet.
> act_police has no mandatory rate, so rate =3D 0 leaves tcfp_mtu =3D ~0 an=
d
> tcf_police_mtu_check() always passes.
>
> TC_ACT_CONSUMED was added by commit 720f22fed81b, after both goto-chain
> guards were written (9469f375ab09 and c08f5ed5d625, Oct 2018); neither
> guard was widened when the new verdict appeared.
>
> Factor the existing range test out of tcf_action_check_ctrlact() as
> tcf_action_valid() and apply it to both fallbacks. The helper cannot call
> tcf_action_check_ctrlact() directly because that also allocates a
> goto_chain, which is exactly what these two sites must not do.
>
> Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
> skbuff_head_cache object plus its 704-byte data buffer per packet. With
> this patch both configurations are rejected with -EINVAL and kmemleak
> reports none.
>
> Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
> Cc: stable@vger.kernel.org # v5.3+
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Two things:

1) We test almost _everything_, so to get a review - even if it as
trivial as this: Always, always send a test case to reproduce even if
it seems as obvious as this. Preferable will be tdc. But you can send
or point to an AI generated poc as well if you cant ask it to create a
tdc test. If the issue is sensitive - send the poc to the tc/netdev
maintainers in a separate email.

2) If you got assistance from an ai - please add assisted-by tag.

Same goes for your other patch...

cheers,
jamal

> ---
>  include/net/act_api.h  | 19 +++++++++++++++++++
>  net/sched/act_gact.c   |  5 +++++
>  net/sched/act_police.c |  6 ++++++
>  3 files changed, 30 insertions(+)
>
> Reproducer needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB and
> CONFIG_NET_ACT_POLICE, plus CONFIG_DEBUG_KMEMLEAK and kmemleak=3Don to
> observe it.
>
> The bad value cannot be set with tc(8) - iproute2 only parses symbolic
> action names - so the fallback has to be planted over raw netlink:
> TCA_GACT_PROB.paction =3D 9 with ptype =3D PGACT_DETERM and pval =3D 1, o=
r
> TCA_POLICE_RESULT =3D 9 with rate =3D 0. Attach either to a clsact ingres=
s
> chain and every packet leaks its skb.
>
> Before, one sk_buff plus its data buffer per packet:
>
>   kmemleak: 166 new suspected memory leaks
>   unreferenced object 0xffff888103baadc0 (size 232):
>     kmem_cache_alloc_node_noprof+0x2f1/0x3e0
>     __alloc_skb+0xe5/0x860
>     alloc_skb_with_frags+0x82/0x750
>     sock_alloc_send_pskb+0x658/0x7e0
>     packet_sendmsg+0x1833/0x4860
>     __x64_sys_sendto+0xe0/0x1c0
>     do_syscall_64+0x102/0x5a0
>
> After: both configurations are rejected at netlink time with -EINVAL
> and "invalid fallback control action", and kmemleak reports no
> unreferenced objects.
>
> For the same reason tdc cannot express the bad configuration, so no
> selftest accompanies this patch. A self-contained C reproducer is
> available on request.
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 20d9e55f8564..fd03f6319e88 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -270,6 +270,25 @@ int tcf_action_check_ctrlact(int action, struct tcf_=
proto *tp,
>  struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action=
,
>                                          struct tcf_chain *newchain);
>
> +/* Range check for a control action supplied by user space.
> + *
> + * This is the same test tcf_action_check_ctrlact() applies to the prima=
ry
> + * control action, factored out for the *fallback* control actions
> + * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT)=
,
> + * which must not reach tcf_action_check_ctrlact() because they have no
> + * goto_chain to allocate.  Without it, user space can store kernel-inte=
rnal
> + * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and i=
s
> + * deliberately not part of the UAPI value range.
> + */
> +static inline bool tcf_action_valid(int action)
> +{
> +       int opcode =3D TC_ACT_EXT_OPCODE(action);
> +
> +       if (!opcode)
> +               return action <=3D TC_ACT_VALUE_MAX;
> +       return opcode <=3D TC_ACT_EXT_OPCODE_MAX || action =3D=3D TC_ACT_=
UNSPEC;
> +}
> +
>  #ifdef CONFIG_INET
>  DECLARE_STATIC_KEY_FALSE(tcf_frag_xmit_count);
>  #endif
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index e949280eb800..565860cccba6 100644
> --- a/net/sched/act_gact.c
> +++ b/net/sched/act_gact.c
> @@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlatt=
r *nla,
>                 p_parm =3D nla_data(tb[TCA_GACT_PROB]);
>                 if (p_parm->ptype >=3D MAX_RAND)
>                         return -EINVAL;
> +               if (!tcf_action_valid(p_parm->paction)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "invalid fallback control action")=
;
> +                       return -EINVAL;
> +               }
>                 if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
>                         NL_SET_ERR_MSG(extack,
>                                        "goto chain not allowed on fallbac=
k");
> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index b16468a98c55..ce08f6840ef7 100644
> --- a/net/sched/act_police.c
> +++ b/net/sched/act_police.c
> @@ -128,6 +128,12 @@ static int tcf_police_init(struct net *net, struct n=
lattr *nla,
>
>         if (tb[TCA_POLICE_RESULT]) {
>                 tcfp_result =3D nla_get_u32(tb[TCA_POLICE_RESULT]);
> +               if (!tcf_action_valid(tcfp_result)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "invalid fallback control action")=
;
> +                       err =3D -EINVAL;
> +                       goto failure;
> +               }
>                 if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
>                         NL_SET_ERR_MSG(extack,
>                                        "goto chain not allowed on fallbac=
k");
> --
> 2.43.0
