Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AD43A7E5
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136128; cv=none; b=k1EeFCDoDnyozeA6vcLPXm6RsipqmKvm6aDWLuRZDm6MuhULm9qxh6N7GpkQifN74xv7bjW+jH/+fQ0VKYJL4oFGmWPiDQKs8peKPR1sESp5kSatZ9e8jcRraEktgvuXgiRJ/OQsGVusvEC9GNFnDnDZriiSq22RJ5Wmd3qNSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136128; c=relaxed/simple;
	bh=aJjjBscF++e5EfCDfsiCmfEHPb6hFQ6PRAMM1E0hmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EusnTSoW7wSgZsnNvfNeHqfaBt0r+fwEY2J8Csw6G3IkJxDNEaye6A0qEbohNT9U/gVqO04BT1CeaAQhGEKAuOeLIZP3M6GUHptN1kyVIxxxy79LelerOIHd+wWJYdagotb1soNL+6SYsRq8viOOQk1G3Fz08EHYSNtXMt5LH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUapP4UN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUapP4UN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D181B1F000E9;
	Wed, 15 Jul 2026 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784136125;
	bh=9GyguhdI2WXmMziu2euOZtnY6PB4P1G6F5165q2AxPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUapP4UNNVVRG5nBbyVyd3S/O0snpoTQmV+h6dbd1n34jyFuFFR7wS8WSJocYsMvs
	 Jd8YqXVGWPkibV+4sQ2edoRhBvnBxMMiqrwAOv6vXxfHJj/8IG+SwwjvGqk9r1kd4W
	 OtJ6yHf8rgnuvbtx+SlO7rSuvwT1FUGCTSs0WUG4lhhthkYe72Z4g48E7Sr/cUJgWc
	 keyJRWSHkMz0ybybUcSy93i0rkrGyPeFJp0scInmrq7cCt/7DA3k+8DRhJo7tDjOy+
	 NQpfAvLo2PjyXc6EgNdVcXAFsqAR3GIxShhampWhob+6WYzAgezoaDU4Q2VSVLt974
	 iW6wI3dumDurQ==
From: Simon Horman <horms@kernel.org>
To: harshitha.vr@chelsio.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com
Subject: Re: [PATCH net] cxgb4: consider EtherType when validating filter priority ordering
Date: Wed, 15 Jul 2026 18:21:51 +0100
Message-ID: <20260715172151.124003-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708131650.14747-1-harshitha.vr@chelsio.com>
References: <20260708131650.14747-1-harshitha.vr@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH net] cxgb4: consider EtherType when validating filter priority ordering ---
commit eeb9ac7dfbda27ed06d0d26da6184a96f69d0da6
Author: Harshita V Rajput <harshitha.vr@chelsio.com>

cxgb4: consider EtherType when validating filter priority ordering

This commit updates cxgb4_filter_prio_in_range() and cxgb4_get_free_ftid()
to consider EtherType during priority validation. It allows adjacent filters
with different EtherTypes to be inserted regardless of their priority order,
as they would not match the same packets.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> index 657d96b9e2f66..8462455d9330f 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c

[ ... ]

> @@ -536,15 +536,24 @@ static bool cxgb4_filter_prio_in_range(struct tid_info *t, u32 idx, u8 nslots,
>  	if (!prev_fe->fs.type)
>  		prev_fe = &prev_tab[prev_ftid];
>  
> -	if ((prev_fe->valid && prev_fe->fs.tc_prio > prio) ||
> -	    (next_fe->valid && next_fe->fs.tc_prio < prio))
> +	/* Filters with different EtherTypes can never match the same
> +	 * packet, so skip the priority check between them.
> +	 */
> +	if (prev_fe->valid && prev_fe->fs.tc_prio > prio &&

[Severity: High]
This is a pre-existing issue, but by only checking the valid flag here,
could concurrent filter insertions bypass the priority checks entirely?

When a filter is allocated, its bit is set in the hardware map but its valid
flag remains 0 until the firmware replies asynchronously (where filter_rpl
sets f->valid = 1).

If a concurrent TC filter insertion occurs (e.g., via unlocked TC or parallel
shared block updates across different ports on the same adapter),
cxgb4_get_free_ftid() finds the pending rule as a neighbor using
find_last_bit() or find_next_bit(), but skips the priority check because
prev_fe->valid or next_fe->valid is 0.

Should this logic also check the f->pending flag to prevent a second thread
from inserting a conflicting filter at an index that violates priority
ordering?

> +	    (!prev_fe->fs.mask.ethtype || !ethtype ||
> +	     prev_fe->fs.val.ethtype == ethtype))
> +		return false;

[Severity: High]
Does suppressing the priority check against immediate neighbors with a
different ethtype break the global sorting invariant of the TCAM filter array?

Since cxgb4_filter_prio_in_range() only validates against immediate allocated
neighbors, skipping the check allows out-of-order insertions. Once the table
contains interleaved EtherTypes, could this lead to hardware priority
inversions?

For example:
Index 0: IPv4 prio 5
Index 1: IPv6 prio 2

If a new IPv4 prio 3 rule is inserted at Index 2, it only checks against
Index 1. Since Index 1 is IPv6, the check is skipped. This inserts the prio 3
IPv4 rule after the prio 5 IPv4 rule, resulting in priority inversion since
hardware evaluates TCAM filters sequentially by index.

Additionally, does this broken transitivity affect cxgb4_get_free_ftid()
when inserting into the HASH region?

cxgb4_get_free_ftid() incorrectly assumes that find_last_bit() in the
HPFILTER region yields the rule with the highest tc_prio:

cxgb4_get_free_ftid() {
	...
	ftid = find_last_bit(t->hpftid_bmap, t->nhpftids);
	if (ftid < t->nhpftids) {
		f = &t->hpftid_tab[ftid];
		if (f->valid && tc_prio < f->fs.tc_prio)
			break;
	}
	...
}

With interleaved priorities, this assumption no longer holds.

> +
> +	if (next_fe->valid && next_fe->fs.tc_prio < prio &&
> +	    (!next_fe->fs.mask.ethtype || !ethtype ||
> +	     next_fe->fs.val.ethtype == ethtype))
>  		return false;
>  
>  	return true;
