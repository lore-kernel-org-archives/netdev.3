Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88841D4EF
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949352; cv=none; b=m4pJjaHPhTwy8C4NkWz7YJW6uMd/KMYItMnk4ocMxyYAbBGvfd8lkzpT4c3B0Gi3HQC3hMNPDEUGmVfoW5gSAelmjAlUaPwAc3hYUZM2VriM/OKfVNriPRzmb1c/kGQM4A9ZN45QLiEjiV76AhnWOJ8h7pprNSoKHg9ZCrQ66mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949352; c=relaxed/simple;
	bh=jzG+g7iKYUUcWcvBzIkAZUCX9UIB+TGAE+Az/emZlVI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oc5szKntjY48kkQhMdqTS+SPLejgbHTH5+8XOKJJ3gJTNH9oeboBR4fh15EUlFjdGHWMpoBisA3uhyCXOEnQX2OZEG2d7Mdl/+ej3DVgV2ESIjF8gKL0FqUzVPzyRkLRpejDa7N6JZyw5vUZzRK2ZT6hAob7/8Sn29PAcS9SXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpnv0zWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpnv0zWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295041F00A3A;
	Wed,  9 Sep 2026 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949350;
	bh=EMSy4EtAPU3DJadtZckO+KxZ2jy5yHNr/i9X9uKLqWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cpnv0zWwZOjhadomaxv350ejoh6ZAKzXIunkMwnCFBYNpiCOrqOQ16/zE8bLV6uPW
	 So6rSYdZfjs6viojJ1AUXB7zV9LSnWKISnjEhTdZH2Ys1HKpVF8tvmuwCUWIBLuI65
	 U+Sh5pBWpZZTv16/WWM9EL1r5K9A1QmBA2Ap8hrOzmfHtnQvS/8p1M51xqvWCUwAXR
	 ce9onpwhR2eFDZPgFtmv5LpZ0YaPhF++yVEKthP9EQ+tuEZcFMNxr2s6ZpsI6zJ823
	 Q/75eSk547WyEu/JuXlvhwMYK5EoL4cxxnTBwrWiLn/P8aLQ41l26WHtQKuzF/MK9d
	 Y9hHJOGIUeeIQ==
Subject: Re: [PATCH net v2 2/4] net/sched: cls_route: Reject handle aliasing
From: netdev-bot+sashiko@kernel.org
To: victor@mojatatu.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org
Date: Wed, 09 Sep 2026 10:22:29 +0000
Message-ID: <178894934962.219967.16944577524953312446@kernel.org>
In-Reply-To: <20260907192133.2639067-3-victor@mojatatu.com>
References: <20260907192133.2639067-3-victor@mojatatu.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/sched/cls_route.c:route4_set_parms() — the duplicate-
  handle scan rewritten by this patch (line 463: `if (fp->handle ==…

--

net/sched: cls_route: Reject handle aliasing

route4_set_parms() scanned the destination chain for the filter's old
handle instead of the handle it is about to be linked under, so a change
that moves a filter into a chain already holding nhandle missed the
collision and created two filters with the same handle.  The patch makes
the scan compare against nhandle and adds an extack message.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829205422.854785-1-victor%40mojatatu.com

> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 17b0ebb766626..9710b77d379c4 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -460,8 +460,12 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
>  		for (fp = rtnl_dereference(b->ht[h2]);
>  		     fp;
>  		     fp = rtnl_dereference(fp->next))
> -			if (fp->handle == f->handle)
> +			if (fp->handle == nhandle) {
> +				NL_SET_ERR_MSG_FMT(extack,
> +						   "Handle %x is already in use",
> +						   nhandle);
>  				return -EEXIST;
> +			}

[Severity: Medium]

Should this scan skip the filter that is being replaced?  When
route4_change() is called with an existing filter, fold is still linked in
its bucket chain while route4_set_parms() runs, and f was seeded from it:

net/sched/cls_route.c:route4_change() {
	...
	if (fold) {
		f->id = fold->id;
		f->iif = fold->iif;
		f->handle = fold->handle;

		f->tp = fold->tp;
		f->bkt = fold->bkt;
		new = false;
	}

	err = route4_set_parms(net, tp, base, f, handle, head, tb,
			       tca[TCA_RATE], new, flags, extack);
	...
}

fold is unlinked from b->ht[] only after route4_set_parms() returns
successfully, so the new scan can walk into fold itself.

Two things seem to follow from that.  First, for an in-place change that
keeps the same to/from, nhandle equals fold->handle and the scan matches
fold, returning -EEXIST for the very filter the user asked to modify.  The
old code compared fp->handle == f->handle, which is also fold->handle, so
the self-match itself is pre-existing and not introduced here, but the new
extack now reports "Handle %x is already in use" for the object being
modified, which reads as a foreign collision.

Second, does this newly allow a filter to be silently renumbered?  The
0x7F00 order bits are only folded in for the create path:

net/sched/cls_route.c:route4_set_parms() {
	...
	if (handle && new) {
		nhandle |= handle & 0x7F00;
	...
}

So for something like

  tc filter change ... pref 100 handle 0x10101 route from 1 to 1 classid 1:9

nhandle comes out as 0x10001 while fold->handle is 0x10101.  to_hash() uses
only id & 0xFF plus the 0x8000 bit, and from_hash(nhandle >> 16) is
unchanged, so both handles land in the same b->ht[] chain and fold really is
visible to the scan.  With the old comparison against f->handle the scan
matched fold and the change was refused; with the comparison against
nhandle it no longer matches, the change is accepted, and

	f->handle = nhandle;

renumbers the filter from 0x10101 to 0x10001.  After that, del or replace by
handle 0x10101 no longer addresses the intended filter.  Was that change of
behaviour intended here?

There is no memory-safety consequence either way: the -EEXIST return happens
before refcount_inc(&b->filters_ref) and before the f->handle / f->bkt
assignments.

For what it is worth, both halves appear to be addressed later in the same
series by "net/sched: cls_route: Fix in-place replace" (ba2f28f8), which
turns the test into

	if (fp != fold && fp->handle == nhandle) {

and carries the order bits over with

	if (handle && (!fold || nhandle == (handle & ~0x7F00)))
		nhandle |= handle & 0x7F00;

so the concern is limited to the intermediate tree state at this commit.
Would it make sense to fold the fp != fold exclusion and the 0x7F00
carry-over into this patch so no bisect point renumbers filters?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907192133.2639067-1-victor%40mojatatu.com
