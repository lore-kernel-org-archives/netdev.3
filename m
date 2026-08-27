Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933944E671
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855915; cv=pass; b=e0xfG1wS4PWDkA6deOvgaLSK40ajNnwyj9x/a89anpybpSZrLk2YAnVrMMAUY1bIO1p/dtr69Q+NrCNMsDq6RUeyGGbM719HyQ9gW8I6yxFGY2f8KAkZKxIxNlnp6OckN1zvvvY2Jtw4S90jktFS0c+QKNAPU5mwfclbc1JxYC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855915; c=relaxed/simple;
	bh=rxnWqQdnwias0sCGqPIkSwuv4XVIyzVXplkgsrStZGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcAkTpRbByYWUJ863Ybpy4iiRGeNRwJ0J+90E/SJMzqtAYFdkixa/7HMaP4xMtCn5/DMNG+6yz+AtsQolHb3Wl019VdPnL/b8+Rhe77ylVqiCXBjyBYYJA+wYy4I0NPwQX2qbt+nVXZgDtCq2rAhdL8idaKSXXoqy7O6A1hstOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OABMlJDM; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OABMlJDM"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c744a00edso319662d50.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787855912; cv=none;
        d=google.com; s=arc-20260327;
        b=qheviCXbg0owfIArOj75bP7pa6UMnCpzWwD52rEEEzujq2ciKVrcj4PZbhrJ1IOBf2
         0ZhQAhrjkkHu8P1gtSwZUbd6yemxm7IEQ2VKEEcnUujFYzojBmLbzZ1Luil1LRjVuTwv
         KHNoBBKFqOfZLcBioygHsItmvzAl01qHarUdOrgbwIHfjl0myINZxlgMm171nACpawr2
         WXFa5FL3tZoUsuENUIEmaTGo3PJNaWZSr9MaMDk5hKMtTwwu+QOyaKT9UAb1tcBlcH3O
         ruFLOGiICAez53J4QFAO/2fr1khGIc8Z+39+FjVJuFIu6H2juEMLV+R1YWmz+eVEZw2s
         XNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pv6sTNPGFzOFtJOLlSTMVhTMFC8bbFeFSQbwESwAySE=;
        fh=ueQSjq1HJEwaD19rhoU+dI2YLfUhSUU4vGSx7Gdp6n4=;
        b=NO0aNjiIJyO1vgLtmU5dWWQf44nfa2XsBvD8RuiV7pf2sMnZCUBd2HDLB0FocQRQoa
         oxrOVrqucWLhNWl99I7s8nRL8nmyK6k4eeW+VJQOrdrLXqGZ+4H9akIXtjKVWwByWGLZ
         AzP4/w233fpfgkftfS/qXrtEB2X9bQNEPsdwQ+Qn4OvIQwMxn2wQe2mGOWvOVsvw/3Jm
         cGhhOYsfUzqeLS3g74ZaWE6i0AuCPz+xCDOdU/iUGm0ntlbaq9/toLq8kxdOSeK+Y/ln
         MW9tUKipNqPF7VFM7Pks7DcL9izM1nZThKwOkIdSaYqzBjCEDzfHdLCLwbRkzFQBKpxe
         KeIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787855912; x=1788460712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pv6sTNPGFzOFtJOLlSTMVhTMFC8bbFeFSQbwESwAySE=;
        b=OABMlJDMVUSjWZc3P0eZ47JlRncatwJlzZ/rbb2sOrt3I7xB6SjmKzF3rNd4xzTT/j
         9ChU4wOPRcC2wiVaRZXVNQAeWw67TNcG/kuQLmjr8cHvu7BQJGbRLo0sD9qc3fsbkihE
         Rg9yOFblWRqlKus7kEThSVfxW8M+HOktCQKEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855912; x=1788460712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pv6sTNPGFzOFtJOLlSTMVhTMFC8bbFeFSQbwESwAySE=;
        b=YdHQ9DFwOrAkZ2nQ3w3eIBG9JNKBrUUvsPCAXWeuJpmoUufHedHTwWLJz4yfx7ms6Y
         A4b2BV9wVKSaQvyBztJflnNhN0JwxzgGhYzQEcybcheD8EkIQ+kv2TZs7i1+0fOuQxjz
         VYWZ5lewrlAkoZOowPwRr3vpoaadzWCiuEJXCkHAy7dia11mtkQggLVw7pz6ZBjvO7LF
         4r1pzewB4XCOhwLMUmwFEfI9gGPQRxZjUhDHhYPkMl7Ysj+1qLZnSTdL3P+MIU9Kel0/
         4Mr2FFcQWCRnBMYoBX+D+7ylDi/IHoP39t5YCsLv7GZpf/fpM7+FNLb8Y1OQvZXaIHhW
         YuFQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro19mgawKVPHpQy8jDrJp1zHI3mnOwUhshZKgDmLbOPMYCJnZh/tc6rvMDaZBqcBb+RuCiKi8c=@vger.kernel.org
X-Gm-Message-State: AFuF++lqHfgldrgFF4IXnfq5cSm6u5wxmj1IMHAOYBsGbubhpTVHe7Zq
	4+xDWY9yP8OA51jQT4d91aOM58dHyUKLWLqrwFzgfCVbAHwDx0ne+BV/GFNESfXbnOHW2fHRhLf
	XvWEI6kX+9hNmHomi7FoZJdWNmtvjc3Obfh/JMNY2
X-Gm-Gg: AR+sD13vkcgij5chRSNpeYmP4C1TL6xgad9uyoFfyQABdmFAWmBId4WVCY6SST0H8p/
	9BLGH8efHu/gfhVJKHYYefdeXLFai7n9SFrzxoJUZJZ3SeVqKTeSb0jG1b7v4ITjv8qsbEWWQpz
	wYd1qHbh5w59ixHp4j9sKtxoTE5EvIgzZjrRCLtCPUEwQ5dP/G+g5/hsAlVwxD5TMox0mHyV5nD
	ee/6I59Y2UUtErdb7mPLNiVR5p3o23Tet2uURh54HVl5cNkGqVmM69Ll8g+xVOqualpzbWR8Ux+
	lmiXbs/dAwVC5RFQh06ggSQeDe1eyUkLFwReU45XuNtcE3bmyhUI2uC6CnKT
X-Received: by 2002:a53:d143:0:b0:667:b314:aea4 with SMTP id
 956f58d0204a3-66e4c645d19mr115794d50.16.1787855911615; Thu, 27 Aug 2026
 11:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153903.4143642-1-victor@mojatatu.com> <20260824153903.4143642-3-victor@mojatatu.com>
 <20260827084927.GB396647@horms.kernel.org>
In-Reply-To: <20260827084927.GB396647@horms.kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 27 Aug 2026 15:38:20 -0300
X-Gm-Features: AcwNN1UcCn0589IEusTSJKTSb9Sl5YsKYcjl8zIhAil8DpXcu8US4-Xm3z6TlAs
Message-ID: <CA+NMeC9BemY9OqZqUWTP7dQoLmBBHyL+ctqBVMQZa9gNupSwSg@mail.gmail.com>
Subject: Re: [PATCH net 2/4] net/sched: act_api: size the RTM_GETACTION reply
 from the actions
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	baowen.zheng@corigine.com, louis.peens@corigine.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:49=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Aug 24, 2026 at 12:39:01PM -0300, Victor Nogueira wrote:
> > tca_action_gd() already walks every requested action and accumulates
> > attr_size +=3D tcf_action_fill_size(act), then wraps the result in
> > tcf_action_full_attrs_size().  For RTM_DELACTION that value is handed t=
o
> > tcf_del_notify_msg(), which allocates max(attr_size, NLMSG_GOODSIZE).  =
For
> > RTM_GETACTION it is silently discarded and tcf_get_notify() allocates a
> > fixed NLMSG_GOODSIZE skb instead.
> >
> > Any action whose dump exceeds that fixed budget therefore cannot be rea=
d
> > back. For example, act_pedit overruns the budget with 32 actions of fou=
r
> > munge keys each, act_police with 32 policers once the optional
> > rate/peakrate/result/avrate attributes are present
> >
> > Fix this by passing attr_size through and allocate the reply the way th=
e
> > add and delete paths do.
> >
> > Note on exposure: RTM_GETACTION is the only one of the three action
> > commands that is not capability checked - tc_ctl_action() requires
> > CAP_NET_ADMIN for RTM_NEWACTION and RTM_DELACTION only - so this turns =
a
> > fixed NLMSG_GOODSIZE reply into a user sized allocation on an
> > unprivileged path.  It is bounded by TCA_ACT_MAX_PRIO actions per
> > request, and tca_action_gd() does not reject duplicate indices, so a
> > single large action can be requested 32 times; an act_bpf program near
> > BPF_MAXINSNS is about 32KB of dump, or roughly 1MB for one request.
> > Creating such an action still requires CAP_NET_ADMIN, and the add and
> > delete paths have sized their skbs this way since the Fixes commit.
> > Should this ever need bounding, GFP_KERNEL_ACCOUNT would charge the
> > reply to the caller's memcg.
>
> Hi Victor,
>
> The AI-generated review of this patch [1] makes the case that this
> allocation is a concern and ought to be addressed up-front.
>
> While I do see that GFP_KERNEL_ACCOUNT is not used in TC,
> and that does give me pause for thought, I am concerned
> about the size of the allocation a user can indirectly request
> the kernel to make.
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.41=
43642-1-victor%40mojatatu.com
>
> Text of AI-generated review:
>
>   Should this allocation use GFP_KERNEL_ACCOUNT rather than plain
>   GFP_KERNEL, given that attr_size here is caller influenced on a path wi=
th
>   no capability check?
>
>   tc_ctl_action() only gates the privileged commands:
>
>   net/sched/act_api.c:tc_ctl_action() {
>         if ((n->nlmsg_type !=3D RTM_GETACTION) &&
>             !netlink_capable(skb, CAP_NET_ADMIN))
>                 return -EPERM;
>         ...
>   }
>
>   so any process that can open an rtnetlink socket in the netns reaches
>   tca_action_gd() with RTM_GETACTION, and now controls the reply size
>   through the accumulated attr_size instead of getting a fixed
>   NLMSG_GOODSIZE skb.
>
>   The commit message says this is "bounded by TCA_ACT_MAX_PRIO actions pe=
r
>   request, and tca_action_gd() does not reject duplicate indices, so a
>   single large action can be requested 32 times".  Is that bound per
>   request only?  Nothing appears to limit how many such requests an
>   unprivileged caller can have outstanding at once.
>
>   With a classic BPF action near BPF_MAXINSNS, tcf_bpf_get_fill_size()
>   budgets nla_total_size(bpf_num_ops * sizeof(struct sock_filter)), rough=
ly
>   32KB, and the 32 slots give roughly 1MB.  An alloc_skb() of that size
>   exceeds KMALLOC_MAX_CACHE_SIZE, so kmalloc_reserve() falls through to a
>   high order GFP_KERNEL page allocation, and the RTM_GETACTION handler is
>   registered without RTNL_FLAG_DOIT_UNLOCKED:
>
>   net/sched/act_api.c
>         {.msgtype =3D RTM_GETACTION, .doit =3D tc_ctl_action,
>          .dumpit =3D tc_dump_action},
>
>   Can direct reclaim and compaction for that order-8 request run under
>   rtnl_lock here?
>
>   On the retention side, netlink_attachskb() admits the first skb on an
>   otherwise empty socket regardless of sk_rcvbuf:
>
>   net/netlink/af_netlink.c:netlink_attachskb() {
>         if ((rmem =3D=3D skb->truesize || rmem <=3D READ_ONCE(sk->sk_rcvb=
uf)) &&
>             !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
>         ...
>   }
>
>   so a caller that never reads its socket can keep one oversized reply
>   queued per socket.  Since the allocation is not GFP_KERNEL_ACCOUNT, non=
e
>   of that is charged to the requester's memcg.
>
>   The commit message already notes "Should this ever need bounding,
>   GFP_KERNEL_ACCOUNT would charge the reply to the caller's memcg" - is
>   there a reason not to do that in this patch, considering the add and
>   delete paths that set the precedent are behind CAP_NET_ADMIN while this
>   one is not?

I tend to agree with Paolo on this.
As of now, those actions will have to be created using CAP_NET_ADMIN
so I don't know whether the exposure is that much higher, but I could
be missing something.
WDYT?

cheers,
Victor
