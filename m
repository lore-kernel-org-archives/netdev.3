Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A663F104A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859781; cv=none; b=Vom+vxP6zFQzHD/Nzpyiz9omESdA5UPiNcoXhCddPczDWcFmnrC7QPREkmtJXfT8jFwFsnbRDLQ0A2LfQCAit9U9W97e5LceoKzBMQyYNMUaE2ESBXlmlsXMWb+phfQ0+i5lEmfgUhkIxh4R9DoZHjewRyNlE+nNsaSLbTdM9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859781; c=relaxed/simple;
	bh=7zV+wbiqOkr08kFZq4uLO3eQGPk8UCXdfRZsBndXTNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vro18A/whuhd1I8JoJmTFTrQbufHsR8fv+v8rdUqlIcUC5iULcv9Jqz2gUUSFrK5z67OwmdNm4MWhUjf7oUy/oVBxcu2l18vaFkVm7l0p64lk7SSct6X28I3S+s9f9arqPUxycQDpm3FELxBddlIz3JgKFijw/yDYn6St18ICWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg+7v4hD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg+7v4hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3E31F000E9;
	Thu, 27 Aug 2026 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859779;
	bh=PzKd8xTMZhiTnTJWOQFI1SHCJAz2Gl57zMBg7qryKqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bg+7v4hDoD1RuKfVPsvaKYM04rx8REN4gdAd+tHJ4QgG4uFX/eZ19p4pQGE3h9JvL
	 d+ExyMzeyKNr7l7tQJZogexp7dOvHM8Q30Mcek9wLxlqOvb2t4NQqX/cREOMRJlSBp
	 t1WzYxk/9R2KYZq7R4Ft8TJSdmIBgNEhC384NhnqvzYksIKGpBZxZ+W+UIkMar36n8
	 9LkM03W+hfmeg962sE4kYGiTWF0jt8l8y35nXKBZL7xUeKtoAUO2mvuTgp120xAVco
	 XXqRXT7ZXJbXmAqbvitL7H2Gcti4dZ4Y8w4p92NQq/LfXKCh5FBHJSqykDlTGwtbUH
	 Cxxn+S0nlsflA==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/5] ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
Date: Thu, 27 Aug 2026 12:42:58 -0700
Message-ID: <20260827194258.4022962-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826103711.3302915-3-edumazet@google.com>
References: <20260826103711.3302915-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()

This converts ip6_mc_source() from in-place mutation of pmc->sflist to
copy-on-write: a new ip6_sf_socklist is fully populated before being
published with rcu_assign_pointer(), and the old one is freed with
kfree_rcu(), matching ip6_mc_msfilter(). The unused IP6_SFBLOCK macro is
also removed.

> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index ec7fac511c8d5..40e996f36c373 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c

[ ... ]

> @@ -424,58 +422,75 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
>  			goto done;
>  		}
>  
> +		if (psl->sl_count == 1) {
> +			newpsl = NULL;
> +		} else {
> +			newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
> +							      psl->sl_count - 1),
> +					      GFP_KERNEL);
> +			if (!newpsl) {
> +				err = -ENOBUFS;
> +				goto done;
> +			}

[Severity: Medium]
Should removing a source from the filter be able to fail with -ENOBUFS
now?

Before this change the !add path only shifted psl->sl_addr[] down and
decremented psl->sl_count, so MCAST_LEAVE_SOURCE_GROUP and
MCAST_UNBLOCK_SOURCE could not fail.  Now a shrinking update needs a
fresh sock_kmalloc(), and the old buffer's charge is released only after
that allocation succeeded:

	newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
					      psl->sl_count - 1), GFP_KERNEL);
	...
	atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
		   &sk->sk_omem_alloc);
	rcu_assign_pointer(pmc->sflist, newpsl);

so the peak sk_omem_alloc charge for the operation is old + (old - 16).

sock_kmalloc() in net/core/sock.c rejects on the sum:

	if ((unsigned int)size <= optmem_max &&
	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {

With the default sysctl_mld_max_msf of 64 a full filter is 24 + 16*64 =
1048 bytes, so roughly 19 fully populated groups reach the default
optmem_max of 20480 and any further per-source removal returns -ENOBUFS
instead of releasing memory.

mld_max_msf is also registered with plain proc_dointvec and no extra2
clamp in net/ipv6/sysctl_net_ipv6.c, so a single filter installed via
ip6_mc_msfilter() can exceed half of optmem_max, in which case
per-source removal stays impossible for that filter until userspace
clears the whole list (MCAST_MSFILTER with gf_numsrc == 0 takes the
newpsl == NULL path) or leaves the group.

The IPv4 counterpart ip_mc_source() in net/ipv4/igmp.c still does the
in-place shift:

	for (j = i+1; j < psl->sl_count; j++)
		psl->sl_addr[j-1] = psl->sl_addr[j];
	psl->sl_count--;
	err = 0;

Is the resulting difference in error contracts between the two families
for the same socket option intended?

> +			newpsl->sl_max = psl->sl_count - 1;
> +			newpsl->sl_count = psl->sl_count - 1;
> +			for (j = 0; j < i; j++)
> +				newpsl->sl_addr[j] = psl->sl_addr[j];
> +			for (j = i + 1; j < psl->sl_count; j++)
> +				newpsl->sl_addr[j - 1] = psl->sl_addr[j];
> +		}
> +
>  		/* update the interface filter */
>  		ip6_mc_del_src(idev, group, omode, 1, source, 1);
>  
> -		for (j = i+1; j < psl->sl_count; j++)
> -			psl->sl_addr[j-1] = psl->sl_addr[j];
> -		psl->sl_count--;
> +		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
> +			   &sk->sk_omem_alloc);
> +		rcu_assign_pointer(pmc->sflist, newpsl);
> +		kfree_rcu(psl, rcu);
>  		err = 0;
>  		goto done;
>  	}
>  	/* else, add a new source to the filter */

[ ... ]

> +	newpsl->sl_max = i;
> +	newpsl->sl_count = i;
> +	if (psl) {
> +		for (j = 0; j < psl->sl_count; j++)
> +			newpsl->sl_addr[j] = psl->sl_addr[j];
>  	}
> -	for (j = psl->sl_count-1; j >= i; j--)
> -		psl->sl_addr[j+1] = psl->sl_addr[j];
> -	psl->sl_addr[i] = *source;
> -	psl->sl_count++;
> +	newpsl->sl_addr[i - 1] = *source;
> +
> +	err = ip6_mc_add_src(idev, group, omode, 1, source, 1);
> +	if (err) {
> +		sock_kfree_s(sk, newpsl, struct_size(newpsl, sl_addr,
> +						     newpsl->sl_max));
> +		goto done;
> +	}

[Severity: Medium]
Is the new error propagation from ip6_mc_add_src() a deliberate part of
this conversion?

The old code was:

	err = 0;
	/* update the interface list */
	ip6_mc_add_src(idev, group, omode, 1, source, 1);

so MCAST_BLOCK_SOURCE and MCAST_JOIN_SOURCE_GROUP always returned 0 and
always installed the socket filter.  Two failures are now returned to
userspace with pmc->sflist left unchanged:

- -ENOBUFS from the interface-level allocation in ip6_mc_add1_src():

	psf = kzalloc_obj(*psf);
	if (!psf)
		return -ENOBUFS;

- -ESRCH when ip6_mc_add_src() does not find the group on idev.  That
  is reachable with gsr_interface == 0, since the pmc lookup skips the
  ifindex comparison:

	if (pgsr->gsr_interface && pmc->ifindex != pgsr->gsr_interface)
		continue;

  while ip6_mc_find_idev()/ip6_mc_find_dev() resolves the device from
  rt6_lookup(), which need not be the device the socket joined on.

The delete branch above still ignores the identical -ESRCH from
ip6_mc_del_src(), so the two branches disagree.  The commit message
describes only the RCU publication fix and does not mention this change
in setsockopt() return values, which matters for the stable backport
implied by the Fixes: tag.  Would it be worth either splitting this out
or documenting it in the changelog?

> +
> +	if (psl)
> +		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
> +			   &sk->sk_omem_alloc);
> +	rcu_assign_pointer(pmc->sflist, newpsl);
> +	kfree_rcu(psl, rcu);
>  	err = 0;
> -	/* update the interface list */
> -	ip6_mc_add_src(idev, group, omode, 1, source, 1);
>  done:
>  	mutex_unlock(&idev->mc_lock);
>  	in6_dev_put(idev);

[Severity: Medium]
This isn't a bug introduced by this patch, but the companion field
pmc->sfmode is still a plain store while the list is now published
atomically.  inet6_mc_check() consumes both fields together under
rcu_read_lock() only:

	psl = rcu_dereference(mc->sflist);
	if (!psl) {
		rv = mc->sfmode == MCAST_EXCLUDE;
	} else {
		...
		if (mc->sfmode == MCAST_INCLUDE && i >= psl->sl_count)
			rv = false;
		if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
			rv = false;
	}

ip6_mc_msfilter() publishes the list first and updates the mode after:

	rcu_assign_pointer(pmc->sflist, newpsl);
	kfree_rcu(psl, rcu);
	pmc->sfmode = gsf->gf_fmode;

and ip6_mc_source() does the same kind of plain store with
pmc->sfmode = omode.

Can a softirq receive path then pair the newly published list with the
stale mode?  For an EXCLUDE{A} to INCLUDE{A} transition a reader that
sees the new list but the old mode takes i < psl->sl_count and sets
rv = false, dropping a datagram the socket now includes; the opposite
interleaving accepts one that should be blocked.  Both sides are also
unannotated, so KCSAN can report the sfmode access as a data race.

Would publishing the mode and the source list as one RCU-protected
object be a reasonable follow-up?
