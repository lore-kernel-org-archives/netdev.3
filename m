Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AF3B14D4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907744; cv=none; b=Jvw71yJpW1KlEygiD9ZPybrviLiIXuBXJIjUIoX0EfEOAzUSw4gABKb2cLpC/wrre46mduQ8ncjrirJ2xFAK+bx7bHWXR5I/l4/LI5LmjZCzXn5UmcWHeiy7Gn31ywMDwCvrv+bFxh8sCuxrrzVSl7d9o4M5GqVOEjzZlQ2QIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907744; c=relaxed/simple;
	bh=Xf+vcN4BzZJYWyCCg+IHSp7N2pgZE3yTia8lmOH+2Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXyl4IWAazN9UsegGX6o4DvS0DjkgSP5QvVqDTbVi6nkMC6YxToiVzgFdjBGU1O9UVvat6UGvGLrkFjqL/wMQBTf94Uuk0g9lllMhtOwEFLsz8qWwggWXdN89kP4IuHT7q9u19ZT3A7Xx0Y/RxwuKNaEuWGRe9m3UGBM4W+5YbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of/PafQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of/PafQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B3D1F00A3A;
	Tue,  8 Sep 2026 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907733;
	bh=Il8UIHJC/7UbD1enFL8myjYOeOo48gkLLAOCJErYPhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Of/PafQX5fgNU7VN7GcgmI+9ij0Vz9WWqEpVXSgex0RVsaXLD2Ex8oKV9Aj0tMhOk
	 12PGBlMMNjrmijszMPutJaKeeoLjqzPAp0SKM1pB20qg4zW34aGKtOWNnhJVeU28SA
	 wC+FB+GMfLMc7bR5MTM6S0m92z0p58CfttKBR0dozVxhnDOF8OPVmehz4J6xE4d+Sx
	 epAUGtv0ye9V8TLjNoY7btlCWPYKFAGSSbqty0UOiakOYbC74/MiySFOySmatk79XU
	 srLa9T0MJwcYBbParbgZzrOgax+Tiu1XPMRbrNo1JJm93iQuAaaifIf7iMTuxJIVsK
	 x8ga0za46n+2g==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 01/12] xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
Date: Tue,  8 Sep 2026 15:48:02 -0700
Message-ID: <20260908224803.1587019-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-2-steffen.klassert@secunet.com>
References: <20260907093020.2228346-2-steffen.klassert@secunet.com>
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
xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()

This adds an up-front range check to iptfs_skb_can_add_frags() so that
iptfs_skb_reset_frag_walk() is never entered with an offset at or beyond
the end of the walk's fragment data, where its unbounded advance loop
would read past walk->frags[]. The guard mirrors the one already present
in iptfs_skb_add_frags().

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 597aedeac26eb..2ce15c472cc4d 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -416,6 +416,14 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
>  	if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
>  		return false;
>  
> +	/* Reject an @offset that is at or beyond the end of the walk's data
> +	 * before calling iptfs_skb_reset_frag_walk(), whose fragment-advance
> +	 * loop is otherwise unbounded and would index past walk->frags[].
> +	 * This mirrors the guard already present in iptfs_skb_add_frags().
> +	 */
> +	if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
> +		return false;
> +

[Severity: Medium]

Should this return true (or be conditioned on len) instead of false?

In the iptfs_reassem_cont() path the walk is prepared and then queried
with the same offset:

net/xfrm/xfrm_iptfs.c:iptfs_reassem_cont() {
	...
	fraglen = min(blkoff, remaining);
	copylen = min(fraglen, ipremain);

	if (!skb_has_frag_list(skb) && !skb_has_frag_list(newskb) &&
	    (skb->head_frag || skb->len == skb->data_len) &&
	    skb->pp_recycle == newskb->pp_recycle) {
		fragwalk = &_fragwalk;
		iptfs_skb_prepare_frag_walk(skb, data, fragwalk);
	}

	if (fragwalk &&
	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
	...
}

Since offset == walk->initial_offset == data here, the new clause reduces
to walk->total == 0, and iptfs_skb_prepare_frag_walk() sums exactly
skb->len - data, so it only fires when data == skb->len, i.e. when
remaining == 0 and therefore copylen == 0 as well.

For that case the guard now sends control into the else branch:

	} else {
		if (skb_linearize(newskb)) {
			...
		}

		/* copy fragment data into newskb */
		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
				      copylen)) {
			XFRM_INC_STATS(xs_net(xtfs->x),
				       LINUX_MIB_XFRMINBUFFERERROR);
			goto abandon;
		}
	}

with copylen == 0 and data == skb->len.  skb_copy_seq_read() calls
skb_seq_read() before it looks at len:

net/core/skbuff.c:skb_copy_seq_read() {
	for (;;) {
		sqlen = skb_seq_read(offset, &data, st);
		if (sqlen == 0)
			return -EINVAL;
		if (sqlen >= len) {
	...
}

and skb_seq_read() returns 0 once abs_offset >= st->upper_offset, so the
zero-length copy returns -EINVAL and iptfs_reassem_cont() takes the
abandon label, where iptfs_reassem_abort() frees xtfs->ra_newskb and
destroys the in-progress inner packet reassembly.

Before this patch the same input took the sharing branch: can_add_frags()
fell through its "while (len && fragi < walk->nr_frags)" loop with len == 0
and returned true, iptfs_skb_add_frags() returned immediately via its own
!walk->nr_frags check, and reassembly continued via
"if (copylen < ipremain) xtfs->ra_wantseq++;".

Two inputs from a peer on an IPTFS SA appear to reach this: an AGGFRAG
payload carrying only the basic/CC header with block_offset >= ipremain
while a reassembly is in progress, and the "newskb->len < iphlen" block
copying exactly iphremain == remaining bytes so that "data += copylen"
leaves data == skb->len.

Would a guard on len, for example returning true when len == 0 and only
rejecting when there is data left to add, close the stack out-of-bounds
read without changing the reassembly outcome?

The other caller, iptfs_pskb_add_frags() in __input_process_payload(), is
only reached when capturelen > iphlen and remaining >= iphlen, so it does
not appear to be able to hit the new guard.

For reference, this behaviour is unchanged through the rest of the series:
the only later change to net/xfrm/xfrm_iptfs.c is the ra_runt iplen check
in "xfrm: iptfs: fix runt reassembly panic from short inner tot_len", and
iptfs_skb_can_add_frags() is the same at the end of the series.
