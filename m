Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8A5540A0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969535; cv=none; b=X3p0eu+IYL25rhKoYdfbggkWsxvuShspNEBuHZY8gzMN6Ip5G03POZzR9w6PXjW/UEyz2V5tG9A32BRqU6vyNQAbGzrD3e6eWdCiHH5c0eTw4pCjYK8O+bmhQr4crnxtlIHF6uf762v0Uki8P6du3srSkyhI93+DOwOgQyFAV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969535; c=relaxed/simple;
	bh=DbatF1EO5Sl0cWqR3de2fKTajc7bO68REbsixr4ciGI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhynWHg0CxVbDqFz0DdVDKB160osy48IIKiRRhUpNTg2C8PJV/E9gMTj8Y3vNzAmNyJt2aj7TzzCTfGto3jtXfB4Fb8ToINX59AaWNxzBF9koLOk+mX10tRB2/UcOc7Dg4ToaIe3YGNdx0OidCzTzy7+2myvlZ1Oq+pYg7FrUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAntDst0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAntDst0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A6B1F00A3D;
	Wed,  9 Sep 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969534;
	bh=v4nVvfL0psxch2UpDad+O1x5gvRUPk3EnxcqiNDL1dg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aAntDst0CKsQrffmLCyORbeCe7qV9d2K7BRIXRVfCc9rGaPmDWS6U6xxuPNgjKmo+
	 7plFJaJjUgE1yTAO7lK1RN+ppjkQodAhyo8/QKtZh5AeA4Q9E9DqtuA3Lptfggz0kH
	 Hd+mdUE7iI30a+bA4WL7W3TWiK4YzM+rGUYzGuxU8fisO9pwmvRKfxBv7jAVIB+Qi2
	 pdGLBp6PDBTOYVyknd65hCA6RNv3S/7Uuhu5V4iXMUnlbAEbCbt6wHzcZ1yGiTjkM8
	 hZcXViYbKaqFAOHKLzYB9nnDnLNNG+TX5hc6jN/wmpSgrx6/kOl5aO573fX5tMi3n5
	 edt+Eyg94atCw==
Subject: Re: [PATCH v1 net 4/4] neighbour: Skip default parms when resumed in
 neightbl_dump_info().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, tgraf@suug.ch
Date: Wed, 09 Sep 2026 15:58:53 +0000
Message-ID: <178896953304.219967.11444505618528200206@kernel.org>
In-Reply-To: <20260907215853.3709987-5-kuniyu@google.com>
References: <20260907215853.3709987-5-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] net/core/neighbour.c: neightbl_dump_info() — the patch does two
  independent things but documents only one.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it is the
  same user-visible symptom class the changelog addresses and remains…

--

neighbour: Skip default parms when resumed in neightbl_dump_info().

This adds a new cb->args[2] flag (default_skip) so that
neightbl_dump_info() does not re-emit the default parms message for a
table when a multi-part dump resumes in the middle of that table's
per-device parms walk.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index b90957b630cee..15eedaef65781 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2587,9 +2587,10 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
>  {
>  	const struct nlmsghdr *nlh = cb->nlh;
>  	struct net *net = sock_net(skb->sk);
> +	int default_skip = cb->args[2];
> +	int neigh_skip = cb->args[1];
>  	int family, tidx, nidx = 0;
>  	int tbl_skip = cb->args[0];
> -	int neigh_skip = cb->args[1];
>  	struct neigh_table *tbl;
>  
>  	if (cb->strict_check) {
> @@ -2613,12 +2614,13 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (tidx < tbl_skip || (family && tbl->family != family))
>  			continue;
>  
> -		if (neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
> +		if (!default_skip &&
> +		    neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
>  				       nlh->nlmsg_seq, RTM_NEWNEIGHTBL,
>  				       NLM_F_MULTI) < 0)
>  			break;
>  
> -		nidx = 0;
> +		default_skip = 1;

[Severity: Low]
Is the removal of nidx = 0 from this spot, and its reappearance at the
tail of the per-table loop, a second and separate behaviour fix?

Before the patch, nidx was only reset right after the successful
neightbl_fill_info() call, never at the end of a table walk. So when the
skb fills up and neightbl_fill_info() fails for table N, the break path
stores the previous table's parm count:

	/* table 0 walked to completion, nidx == N */
	/* table 1: neightbl_fill_info() fails, break */
	cb->args[0] = 1;
	cb->args[1] = N;	/* table 0's count */

On resume neigh_skip is N while nidx restarts at 0 for table 1, so the
first N per-device parms of table 1 take:

			if (nidx < neigh_skip)
				goto next;

and are never emitted, which is the opposite symptom from the duplicate
described in the changelog.

After the patch nidx = 0 runs at the loop tail, so the break path stores
cb->args[1] = 0 and nothing is skipped. The changelog does not mention
this hunk at all. Could the changelog say that moving nidx = 0 fixes the
stale-nidx-on-break case, or could that hunk be split into its own patch?
As written it reads like cosmetic reordering that could be dropped during
review or a stable backport.

>  
>  		p = list_first_entry(&tbl->parms_list, struct neigh_parms, list);
>  		list_for_each_entry_continue_rcu(p, &tbl->parms_list, list) {
> @@ -2642,12 +2644,15 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
>  		}
>  
>  		neigh_skip = 0;
> +		nidx = 0;
> +		default_skip = 0;
>  	}
>  out:
>  	rcu_read_unlock();
>  
>  	cb->args[0] = tidx;
>  	cb->args[1] = nidx;
> +	cb->args[2] = default_skip;

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but it is
the same class of user-visible symptom the changelog is fixing, so it may
be worth mentioning.

The parms walk in neightbl_dump_info() resumes by position index only.
rcu_read_lock() is dropped between dump invocations and no reference to
the last dumped struct neigh_parms is kept, so cb->args[1] can refer to a
different object next time around.

Writers mutate the same list under tbl->lock. neigh_parms_alloc() inserts
at the front of the region the dump iterates:

net/core/neighbour.c:neigh_parms_alloc() {
	...
	spin_lock_bh(&tbl->lock);
	list_add_rcu(&p->list, &tbl->parms.list);
	spin_unlock_bh(&tbl->lock);
	...
}

and neigh_parms_release() removes from it:

net/core/neighbour.c:neigh_parms_release() {
	...
	spin_lock_bh(&tbl->lock);
	list_del_rcu(&parms->list);
	parms->dead = 1;
	spin_unlock_bh(&tbl->lock);
	...
}

So if one invocation emits parms 0..4 and stores cb->args[1] = 5, and a
netdev is registered before the dump resumes, every previously dumped
entry shifts to index+1 and the entry formerly at index 4 is emitted a
second time. A netdev unregister shifts indices down instead and an entry
is silently dropped.

Neither cb->seq nor NLM_F_DUMP_INTR is used anywhere in
net/core/neighbour.c, so user space cannot detect this. Should a
generation counter plus NLM_F_DUMP_INTR be added on top of this patch for
the RTM_GETNEIGHTBL dump?

>  
>  	return skb->len;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907215853.3709987-1-kuniyu%40google.com
