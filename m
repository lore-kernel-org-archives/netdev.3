Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6E29ACCD
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844623; cv=none; b=AF70Vw1X7gdlEsDgUeP/d8Cne4/aSM8/bL2J33jUDkMwpeHzNEg3w/MTpLt0kd4maEDoUaHkulMXhWRYsZBVToDEYa4dLWQBH5mht/Zat+0uEm/5AAOuLlgasRAW67Bdez8gQ1xTHkuixYpQVpKv0Gjp7A/bpmeeSREMP1QQkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844623; c=relaxed/simple;
	bh=7s8/8cDfsPaK2y5JJoE4m0Hwi2/jgC3vizIzkm7p+XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+qm3vD/Kf2mP3WRWOaOBwoBUCQz/KzRSKpeySKBwqrg7lBGOiJMTiJ1w9Ghlp4n0oRdCvYgGf2FshsreE3oYNDl68g9r/hUTdK2GM57Bz7HyypckSB9Dghbt3FTtcQzlt4ELfExoO/uoj+yzxto3H3dkHccJN+hcw01HDlcjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTs3tVnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTs3tVnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954911F0089A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790844621;
	bh=SWqRlDbPftbcD+rALI3lGyZaGrwekj/hB2xl1qNHfKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YTs3tVnXXAZBBx3Tai7HqnPF2BhT+odllLwj3sewniitOytgDhyqn36Oyc33gitrf
	 eAK9I/QPu5QOfEKBpyDth/8LHncM2Ljj7n9zPf6MLCdrNjj/to60wVN5X99lXOC1x+
	 KW7GRWvESSZly/7E7awQ0gcSD5jfBtyKtXCzM8Dbl6hVbfKGK0o6H1buZ+YwPkJdow
	 BSg14nAljwBlHPqOXVKIU7ERXuDc4LmNSXML8QvzX/cRkkd9tG9Aa2/1LN5UFUeAPg
	 Xq1fhWymZ1/79fiv9uOeb97OJV8y4398Ho2RiyLsDWfQWzJE5rzqPyRiqsrrvzzTMr
	 bzNQ9Tk/S+7gg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49dfaa16190so175433fac.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 01:50:21 -0700 (PDT)
X-Gm-Message-State: AFuF++lcHeg+i3+HvLKimKovqmM3cJ+Ikth+kzzs41Y2QX2hjJA5lGWW
	ijhn8BgNPfqzmZCnfCeNX6rVGs5KMLkr8TI9E4/pJJQVOWBwspT7Jnq2RUU4gS5JtvQaCSnxS30
	jRmrms+fPQieCp7Q9dcstr29OT3siLo8=
X-Received: by 2002:a05:6871:4729:b0:492:e616:2f40 with SMTP id
 586e51a60fabf-49df0664405mr1931751fac.41.1790844620917; Thu, 01 Oct 2026
 01:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790761119.git.petalzu987@gmail.com> <11a750c626d9a100259dc0b32e330f5429773320.1790761119.git.petalzu987@gmail.com>
In-Reply-To: <11a750c626d9a100259dc0b32e330f5429773320.1790761119.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 10:50:10 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqAff10vk_Z+NtN_hMPV0uU5DgU9BBqAkgd-uK_7=fr0g@mail.gmail.com>
X-Gm-Features: AclHuK-KUl4D4Mak2NkCn4JNcrsw5zrKDh8PkOPmfgLA5RocF4d4oRvxwJpm58Q
Message-ID: <CAL4WiiqAff10vk_Z+NtN_hMPV0uU5DgU9BBqAkgd-uK_7=fr0g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] inet: frags: orphan non-wmem skbs before building frag_list
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	herbert@gondor.apana.org.au, vega@nebusec.ai, petalzu987@gmail.com, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:54=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> When a fragment skb cannot be coalesced, reassembly clears skb->sk
> before linking it to frag_list. If the skb still has a non-wmem
> destructor, the callback remains installed and may dereference the
> cleared socket when the skb is freed, causing a NULL pointer
> dereference.
>
> Orphan non-wmem skbs that have a destructor before adding them to
> frag_list. Keep the existing skb->sk clearing for skbs without a
> destructor and for wmem skbs, preserving TX accounting.
>
> Fixes: d15f5ac8deea ("ipv6: frags: Fix bogus skb->sk in reassembled packe=
ts")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  net/ipv4/inet_fragment.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index b286ee429da8..cc6718f579fa 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -652,7 +652,10 @@ void inet_frag_reasm_finish(struct inet_frag_queue *=
q, struct sk_buff *head,
>                         } else {
>                                 fp->prev =3D NULL;
>                                 memset(&fp->rbnode, 0, sizeof(fp->rbnode)=
);
> -                               fp->sk =3D NULL;
> +                               if (fp->destructor && !is_skb_wmem(fp))
> +                                       skb_orphan(fp);
> +                               else
> +                                       fp->sk =3D NULL;
>

Hmm

The root cause is that 18685451fc4e ("inet: inet_defrag: prevent sk
release while still in use") moved skb_orphan() into ip_frag_queue()
and nf_ct_frag6_queue(), but not into ip6_frag_queue().

Fixing this in inet_frag_reasm_finish() is too late. Sockets assigned
by bpf_sk_assign() are often not refcounted (SOCK_RCU_FREE), so a
queued fragment can hold a stale skb->sk for up to ipfrag_time.
sock_pfree() would then dereference freed memory when the queue
expires, on the coalesce path, or in your new skb_orphan(fp) call.

Please instead add skb_orphan(skb) before 'return -EINPROGRESS' in
ip6_frag_queue(), matching the IPv4 and nf_conntrack paths?

Also, a better tag would be:

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")

pw-bot: cr
