Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280B3FAE09
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820573; cv=none; b=aAqAnkTny669pdzNmsytYPWHQpftwIBk5+tUcTHR6TxacWrBiUBmx4wwpqv9OqPstHhpdmZOoktmZvXgUFhTx2MHu0w7XWDWfrhb6Sfj8B5J+Z6LvdnNRkN5YXsfk83kARZg4m/BYtMWP2jDPcoRtlwriXwOz35jkl6ElaRB5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820573; c=relaxed/simple;
	bh=Jvq0Zkh8EHea6Lp0q4ZTg6kqf+JrWn0MEt3gX3JiyPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azc2CDFQSKlaIsQ1/6XCIxvQ+kZ6C0PzH7LtD4b991zJ/izR+X0T+w3rXZmaC8Gz5aEGa1m2/3MzLokBTohR5qLiU6K/nbg54uHisCBI9XxTjXZOjJ8LWUyOE44ZZiI8CE2aGfhMF53UmVVFgFaB65B4fAa9MxQm+WmoS4ioFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEyXv6F8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEyXv6F8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFFC1F000E9;
	Thu, 27 Aug 2026 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787820572;
	bh=VjKkpf6Vci1MTkmu+VIM+ERfrOeYP5ZcyjDzf3FKwb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEyXv6F8JQ1qzjvNpI/pLhv/LFl9tHAFaR4YzHP4OyhEIcRbPGpa4QdSuX9L1F8At
	 NrquCAvWXCPdhh7zPgWNxKsFIX3l7mDweEw2fI/0j1FFeZJ/2Rr9HKqFyVoGtd5MYQ
	 W3G2HBI+fJF4irI7lvZEERanei+botdAMr8d6IisuF8cXuEUNluGB5EPT/oqpSauZ+
	 8ExYaRi7hSjNQseqpXFPHqT3lOkydTIYz7u57bHdqCFUHn5gGONpgDTUog631uRVuh
	 I/63lcE7fMCPH3YEltk0EjsgX+a5MJzZJaFQzJZViqCl2gwuSqmB949HDpConWKfBS
	 DzS8DoqI5RWIA==
Date: Thu, 27 Aug 2026 09:49:27 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	baowen.zheng@corigine.com, louis.peens@corigine.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/4] net/sched: act_api: size the RTM_GETACTION reply
 from the actions
Message-ID: <20260827084927.GB396647@horms.kernel.org>
References: <20260824153903.4143642-1-victor@mojatatu.com>
 <20260824153903.4143642-3-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824153903.4143642-3-victor@mojatatu.com>

On Mon, Aug 24, 2026 at 12:39:01PM -0300, Victor Nogueira wrote:
> tca_action_gd() already walks every requested action and accumulates
> attr_size += tcf_action_fill_size(act), then wraps the result in
> tcf_action_full_attrs_size().  For RTM_DELACTION that value is handed to
> tcf_del_notify_msg(), which allocates max(attr_size, NLMSG_GOODSIZE).  For
> RTM_GETACTION it is silently discarded and tcf_get_notify() allocates a
> fixed NLMSG_GOODSIZE skb instead.
> 
> Any action whose dump exceeds that fixed budget therefore cannot be read
> back. For example, act_pedit overruns the budget with 32 actions of four
> munge keys each, act_police with 32 policers once the optional
> rate/peakrate/result/avrate attributes are present
> 
> Fix this by passing attr_size through and allocate the reply the way the
> add and delete paths do.
> 
> Note on exposure: RTM_GETACTION is the only one of the three action
> commands that is not capability checked - tc_ctl_action() requires
> CAP_NET_ADMIN for RTM_NEWACTION and RTM_DELACTION only - so this turns a
> fixed NLMSG_GOODSIZE reply into a user sized allocation on an
> unprivileged path.  It is bounded by TCA_ACT_MAX_PRIO actions per
> request, and tca_action_gd() does not reject duplicate indices, so a
> single large action can be requested 32 times; an act_bpf program near
> BPF_MAXINSNS is about 32KB of dump, or roughly 1MB for one request.
> Creating such an action still requires CAP_NET_ADMIN, and the add and
> delete paths have sized their skbs this way since the Fixes commit.
> Should this ever need bounding, GFP_KERNEL_ACCOUNT would charge the
> reply to the caller's memcg.

Hi Victor,

The AI-generated review of this patch [1] makes the case that this
allocation is a concern and ought to be addressed up-front.

While I do see that GFP_KERNEL_ACCOUNT is not used in TC,
and that does give me pause for thought, I am concerned
about the size of the allocation a user can indirectly request
the kernel to make.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor%40mojatatu.com

Text of AI-generated review:

  Should this allocation use GFP_KERNEL_ACCOUNT rather than plain
  GFP_KERNEL, given that attr_size here is caller influenced on a path with
  no capability check?

  tc_ctl_action() only gates the privileged commands:

  net/sched/act_api.c:tc_ctl_action() {
	if ((n->nlmsg_type != RTM_GETACTION) &&
	    !netlink_capable(skb, CAP_NET_ADMIN))
		return -EPERM;
	...
  }

  so any process that can open an rtnetlink socket in the netns reaches
  tca_action_gd() with RTM_GETACTION, and now controls the reply size
  through the accumulated attr_size instead of getting a fixed
  NLMSG_GOODSIZE skb.

  The commit message says this is "bounded by TCA_ACT_MAX_PRIO actions per
  request, and tca_action_gd() does not reject duplicate indices, so a
  single large action can be requested 32 times".  Is that bound per
  request only?  Nothing appears to limit how many such requests an
  unprivileged caller can have outstanding at once.

  With a classic BPF action near BPF_MAXINSNS, tcf_bpf_get_fill_size()
  budgets nla_total_size(bpf_num_ops * sizeof(struct sock_filter)), roughly
  32KB, and the 32 slots give roughly 1MB.  An alloc_skb() of that size
  exceeds KMALLOC_MAX_CACHE_SIZE, so kmalloc_reserve() falls through to a
  high order GFP_KERNEL page allocation, and the RTM_GETACTION handler is
  registered without RTNL_FLAG_DOIT_UNLOCKED:

  net/sched/act_api.c
	{.msgtype = RTM_GETACTION, .doit = tc_ctl_action,
	 .dumpit = tc_dump_action},

  Can direct reclaim and compaction for that order-8 request run under
  rtnl_lock here?

  On the retention side, netlink_attachskb() admits the first skb on an
  otherwise empty socket regardless of sk_rcvbuf:

  net/netlink/af_netlink.c:netlink_attachskb() {
	if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
	...
  }

  so a caller that never reads its socket can keep one oversized reply
  queued per socket.  Since the allocation is not GFP_KERNEL_ACCOUNT, none
  of that is charged to the requester's memcg.

  The commit message already notes "Should this ever need bounding,
  GFP_KERNEL_ACCOUNT would charge the reply to the caller's memcg" - is
  there a reason not to do that in this patch, considering the add and
  delete paths that set the precedent are behind CAP_NET_ADMIN while this
  one is not?
