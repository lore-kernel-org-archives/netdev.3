Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303452;
	b=Et1L/K8djvl6nW8WuGMvBrK36J9fWs61CqwCTiTeNFMXieYH31UG6UuKJw3nI/y4nMn9
	 F14SRkf3tkgG4XI1/HgTDMVONgtPxZqBUKoea/jpbKdj7sTjPzEgaWq3wQXClFKXxxsVV
	 FFOAbs5CoZsaiV8ZCjC1tShTp9cCGRU7rpkiRukACe9C7lr311EgpBBmyAJEC/KbrikPm
	 WZIsla06R14386iZeY5PylDmDIj7B78KKKPLqetiIIbouC+W+JCk+ZkBJJERY1keUDN3d
	 /ZfaCsS0WCj7Nt6ZGofdyiFa2HVuAhxWuF/ajy+W0mVHUefV6lqjN4ARyuDsblup8Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303452;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kS7nubamV8gOBMgsZDEML31xlkinLAFRBkCqbcdYeBY=;
	b=ZGxysWG7ZNFPneXFnsYTP3V8wGGVB2MGZE6OATasUTxEDUUU5todrWcRP3+93APSJomH
	 YchBWgW4M1/CdCocAmhXgCqkG6ZKX8ZNfsSN77x3GiEGWAGr6C9bqkJB09ThnRnmuoilf
	 d3O4Bzlk4gH7Vm3kHGjVKOy8W3csfwC2tRvKq6wSvCS1DBaF/iL742qjyxbsdYpqBblb3
	 CkLFGutw2IiBKoCv80zJRvEUSGshguU1g6sNyAGiapJBw8dk/CXzxZCqPTbRigojEsryy
	 hPmK1/ifvUKT18IxFPlOkLRjzVzT8loiI0+Gmpkjwsx64QW2JARBlRce6nmI00hJi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G5V/BY5R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54945606A90E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5V/BY5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1826E1F0089F;
	Tue, 10 Nov 2026 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303451;
	bh=kS7nubamV8gOBMgsZDEML31xlkinLAFRBkCqbcdYeBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G5V/BY5RFXUn+ytEm36F8l4jsz9zSjQxpD8jvcuSlDkhnRiDdblF9WIaRygnR9w0t
	 ppfi/0PhIcy+6iuLs79MKmDrd1SUO6fkDm54sdUFDvvjmYKCeKl5PJMtWlUhLyPgT6
	 3NI79nYmtpUidfk+KEiccTf3vuSuucPDua2whQOZwZUf6oOTVk+jVFtpG4vBFbkr70
	 BeDIiQBA6v7Q+FxCWoqnaoEq2Dgp15LIk+cl4RvlkLB8QVYK2Ad3+NTDPzLX6Dp1sS
	 OS+etUQ7X94N52NsO+eVnAxpSrbcqoFaMh52QFvy6+5fa3vGnrdMqBQa3W4pxXgjlQ
	 mVj5LOZQVuBFQ==
Subject:
 Re: [PATCH net] xfrm: reject duplicate state resolution in xfrm_migrate()
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, nakam@linux-ipv6.org, shinta.sugimoto@ericsson.com,
 yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, junvyyang@tencent.com,
 stable@kernel.org, corvus@tencent.com
Date: Tue, 10 Nov 2026 09:37:30 +0000
Message-ID: <179430345062.994134.8366892764007604715@kernel.org>
In-Reply-To: <20261106091929.52067-1-juny24602@gmail.com>
References: <20261106091929.52067-1-juny24602@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch leaves the use-after-free it describes reachable,
  because it removes only one trigger.
- [Low] The commit message understates when duplicate state resolution
  can happen.

--

xfrm: reject duplicate state resolution in xfrm_migrate()

This patch makes xfrm_migrate() reject a migration entry that resolves to
an SA already stored in x_cur[]. It drops the extra lookup reference and
goes through the existing restore_state rollback. The goal is to prevent
the Stage 4 put-then-delete sequence from accessing a state after its
last reference is gone.

> xfrm_migrate_check() rejects identical migration entries, but entries
> with different old_reqid values can still resolve to the same state.
> In particular, old_reqid == 0 is a wildcard, so it can match the same SA
> as an entry carrying that SA's reqid.

[Severity: Low]
Is this description complete? Two entries with the same non-zero
old_reqid can also resolve to the same SA.

xfrm_migrate_check() compares the addresses with memcmp() over the whole
xfrm_address_t:

net/xfrm/xfrm_policy.c:xfrm_migrate_check() {
    ...
	if (!memcmp(&m[i].old_daddr, &m[j].old_daddr,
		    sizeof(m[i].old_daddr)) &&
	    !memcmp(&m[i].old_saddr, &m[j].old_saddr,
		    sizeof(m[i].old_saddr)) &&
    ...
}

copy_from_user_migrate() copies all 16 bytes from userspace:

net/xfrm/xfrm_user.c:copy_from_user_migrate() {
    ...
	memcpy(&ma->old_daddr, &um->old_daddr, sizeof(ma->old_daddr));
	memcpy(&ma->old_saddr, &um->old_saddr, sizeof(ma->old_saddr));
    ...
}

For AF_INET, xfrm_migrate_state_find() uses the family-aware hash
functions and xfrm_addr_equal(..., m->old_family), so only a4 is
compared. Two entries that differ only in the unused upper 12 address
bytes pass xfrm_migrate_check() and still resolve to the same SA.

The new x_cur[j] == x check catches this case too, so the code is fine
here. Could the commit message describe the more general mismatch between
the memcmp() based uniqueness check and the lookup semantics? That would
help stable backporters see which inputs trigger the bug.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cea6842e6454d..41ea5da825b64 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c

[ ... ]

> @@ -4702,6 +4702,17 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  	/* Stage 2 - find and update state(s) */
>  	for (i = 0, mp = m; i < num_migrate; i++, mp++) {
>  		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
> +			for (j = 0; j < nx_cur; j++) {
> +				if (x_cur[j] == x)
> +					break;
> +			}
> +			if (j < nx_cur) {
> +				xfrm_state_put(x);
> +				NL_SET_ERR_MSG(extack,
> +					       "Multiple MIGRATE entries resolve to the same SA");
> +				err = -EINVAL;
> +				goto restore_state;
> +			}

[Severity: High]
Does this fully close the use-after-free in Stage 4? Stage 4 still drops
every lookup reference before it deletes the same states:

net/xfrm/xfrm_policy.c:xfrm_migrate() {
    ...
	/* Stage 4 - delete old state(s) */
	if (nx_cur) {
		xfrm_states_put(x_cur, nx_cur);
		xfrm_states_delete(x_cur, nx_cur);
	}
    ...
}

Duplicates in x_cur[] are one way for an entry to have no table reference
left at that point. A concurrent hard expiry looks like another.
xfrm_timer_handler() takes only x->lock, not xfrm_cfg_mutex, and on hard
expiry does:

	err = __xfrm_state_delete(x);

The data path can arm this right away. xfrm_state_check_expire() sets
XFRM_STATE_EXPIRED and starts mtimer with a zero delay once the hard byte
or packet limit is reached.

If __xfrm_state_delete() runs between the Stage 2 lookup and Stage 4, the
lookup hold is the only reference left. The sequence would then be:

xfrm_migrate()
  xfrm_states_put()
    xfrm_state_put()          /* refcnt -> 0 */
      __xfrm_state_destroy()  /* queue on gc list, schedule gc */
  <task preempted>
                              xfrm_state_gc_task()
                                synchronize_rcu()
                                xfrm_state_gc_destroy(x)  /* freed */
  xfrm_states_delete()
    xfrm_state_delete()
      spin_lock_bh(&x->lock)  /* freed memory */

Could Stage 4 call xfrm_states_delete() first and xfrm_states_put()
afterwards? With that order the lookup holds keep each state alive across
xfrm_state_delete(), and a second delete of a state that is already DEAD
just returns -ESRCH. xfrm_do_migrate_state() in xfrm_user.c already
follows this order: it calls __xfrm_state_delete(x) and then
xfrm_state_put(x).

Rejecting duplicates still seems worth keeping so one SA is not cloned
twice. On its own, though, it does not seem to cover the concurrent
expiry case.

>  			x_cur[nx_cur] = x;
>  			nx_cur++;
>  			mp->encap = encap;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106091929.52067-1-juny24602%40gmail.com
