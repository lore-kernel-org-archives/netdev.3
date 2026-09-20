Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91947C0EF;
	Sun, 20 Sep 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944453; cv=none; b=Ky72YW40SiKJmFXrnc7+wo2mH3aggwi4hGm4qM1yj9aBQWJIu7cqcy5BN3UEj+OZ4FsAGOCLIQ9klOs6+5wWjamx0ELw1Ln4EXxGAvr6Z3zL0ox258CQ7ZCiwJqvV77fDl0qQfDYvYFM0eQx3Kyb4BaFJc5cHass4iTBPaBHtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944453; c=relaxed/simple;
	bh=onOYSvPUpit+gvgpTtlSBppL1rSOHFtmtV8Nt7k4BA4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeSuxMRZmLvZwTk3hQpR94mS5nQe0q5nbkNi/Z9vXq9XFTASm1qV1eqcXF0qUesF9L4V/llKDp59avStB59FMt/KsHGRPLOW/l51eLrfxbqVK0xpED0sNDrCFga0Kcs7sbet+qWkDWh20BfnMrcDmYIQFexD1T2VSrnehGyq1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbzqay3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbzqay3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA1D1F000FF;
	Sun, 20 Sep 2026 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944451;
	bh=6yDggSHaGUVpeXWX9+nw1N3c24hggX5UI/mOiac1mKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wbzqay3G72b01mjin/PGPX97gaGS+A7NncilwxRG9Dn/8JLAV8AWQor+YvPovAVv1
	 A7G/pKxKgNDKsF6DsYv8YDmNA6X30Ji2jYXuZulDUjURdptPfTLdlkyH7keLzQuIV8
	 UGXwX92uFypl/+G0ltIbnEN3C42HFfR342owB3cT2AAVe98tnD97F/Re40w7PcJZ3E
	 BmnPDYkeKAuHCEJkpZtEKxbV2Xx2JWJRYz4rL+gzcavq46bxYKINg2/xfVM4Zcw0td
	 Qt5wI2WE4Ygk2nZuQBpM7orcplDcLOO25RQhY6H3On87imoPM/wYVA6AAv+WYt3Z5e
	 g1d+1umGOTCUw==
Subject:
 Re: [PATCH] net: slip: fix out-of-bounds access on short CSLIP packets
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:47:30 +0000
Message-ID: <178994445036.2160803.93100448666025209@kernel.org>
In-Reply-To: <20260919223432.3882500-1-benquike@gmail.com>
References: <20260919223432.3882500-1-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message describes work that the patch does not do, and
  names the wrong bug class.
- [Low] The new reserve literal 120 in sl_bump()
  (drivers/net/slip/slip.c:338) is undocumented and unlinked to the code…
- [Low] The Fixes tag is wrong.

Pre-existing issues:
- [Medium] The rx_over_errors early return in sl_bump()
  (drivers/net/slip/slip.c:338-341) discards a compressed frame without…
- [Low] Claimed TOCTOU race between the reserve check in sl_bump() and
  sl_realloc_bufs() swapping/shrinking sl->rbuff and sl->buffsize.

--

net: slip: fix out-of-bounds access on short CSLIP packets

The patch changes a single constant in sl_bump() in drivers/net/slip/slip.c,
raising the reserve required before a compressed frame is handed to
slhc_uncompress() from 80 to 120 bytes.  Frames that do not leave that much
room in sl->rbuff are dropped and counted in dev->stats.rx_over_errors.

No Link: tags present in the commit header.

> net: slip: fix out-of-bounds access on short CSLIP packets
>
>     In drivers/net/slip/slip.c, verify packet length before invoking
>     slhc_uncompress() / slhc_remember() on compressed SLIP frames so
>     truncated CSLIP headers cannot read or write past the receive buffer.

[Severity: Medium]
Does the changelog match what the diff does?  The only change is the
tail-reserve constant in sl_bump() going from 80 to 120.  No packet length
verification is added, and the slhc_remember() arm is not touched at all:

drivers/net/slip/slip.c:sl_bump() {
	...
	} else if (c >= SL_TYPE_UNCOMPRESSED_TCP) {
		...
		sl->rbuff[0] &= 0x4f;
		if (slhc_remember(sl->slcomp, sl->rbuff, count) <= 0)
			return;
	}
	...
}

Is the "truncated CSLIP header" read the message describes actually
reachable?  slhc_uncompress() rejects isize < 3, bounds the checksum fetch
with "if (cp + 2 > end)", passes end into decode() for every delta field:

drivers/net/slip/slhc.c:decode() {
	...
	if (*cpp >= end)
		return -1;
	...
}

and rejects len < 0.  slhc_remember() has its own runt checks:

drivers/net/slip/slhc.c:slhc_remember() {
	...
	if (ihl < 5 || isize < ihl * 4 + sizeof(struct tcphdr))
		goto runt;
	...
}

The problem the new constant does address looks like a different one:
header re-expansion past the end of rbuff on a write, not a read of a
truncated header.  In slhc_uncompress(), hdrlen = ip->ihl * 4 +
thp->doff * 4 can reach 120, and the reconstruction writes into the caller
buffer:

drivers/net/slip/slhc.c:slhc_uncompress() {
	...
	hdrlen = ip->ihl * 4 + thp->doff * 4;
	...
	len = isize - (cp - icp);
	if (len < 0)
		goto bad;
	len += hdrlen;
	...
	memmove(icp + hdrlen, cp, len - hdrlen);
	...
}

With at least 3 input bytes consumed, those writes reach up to
sl->rbuff + count + 117, so with the old 80-byte reserve and rbuff =
kmalloc(buffsize + 4) a slot primed with maximal IP and TCP options
(ihl = 15, doff = 15, via a preceding uncompressed TCP frame) could be
written out of bounds.  Could the changelog describe that sequence, the
derivation of 120, and the fact that this is a heap write overflow rather
than a read of a short header?

>     Fixes: b5451d783ade ("slip: Move the SLIP drivers")

[Severity: Low]
Is this Fixes tag pointing at the right commit?  b5451d783ade only moved
files, and its changelog says so: "Move the Serial Line Internet Protocol
(SLIP) drivers into drivers/net/slip/ and make the necessary Kconfig and
Makefile changes."  git blame of the pre-patch line gives:

1da177e4c3f4 drivers/net/slip.c (Linus Torvalds 2005-04-16) if (count + 80 > sl->buffsize) {

so the undersized reserve predates the move and predates git history.
For a bug this old, would it be better to drop the Fixes tag and rely on
Cc: stable, so pre-3.1 trees are not skipped by stable tooling?

> diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
> index fdd6f63fb849..4389985979cf 100644
> --- a/drivers/net/slip/slip.c
> +++ b/drivers/net/slip/slip.c
> @@ -335,7 +335,7 @@ static void sl_bump(struct slip *sl)
>  			}
>  			/* make sure we've reserved enough space for uncompress
>  			   to use */
> -			if (count + 80 > sl->buffsize) {
> +			if (count + 120 > sl->buffsize) {

[Severity: Low]
Could this 120 be a named constant, with the comment explaining where it
comes from?  Nothing here ties the literal to the arithmetic it has to
track in slhc_uncompress():

	hdrlen = ip->ihl * 4 + thp->doff * 4;	/* up to 60 + 60 */

which is how the old 80 drifted from the real bound.  The sibling caller
open-codes yet another unexplained literal for the same expansion bound:

drivers/net/ppp/ppp_generic.c:ppp_receive_nonmp_frame() {
	...
	if (skb_tailroom(skb) < 124 || skb_cloned(skb)) {
	...
}

Would a shared macro next to slhc_uncompress() keep the two callers and
slhc.c from drifting apart again?

Also, does this narrow what is accepted?  Compressed frames with
sl->buffsize - 120 < count <= sl->buffsize - 80 were previously
decompressed and delivered, and are now dropped with
dev->stats.rx_over_errors++.  At the default MTU of 296 (buffsize =
max(2 * mtu, 1152) = 1152) that is roughly the 1033..1072 byte range.
Could the changelog mention that acceptance and statistics change?

>  				dev->stats.rx_over_errors++;
>  				return;
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but should this early return
call slhc_toss(sl->slcomp) before dropping the frame?  The same omission
exists with the 80-byte reserve and on the "compressed packet ignored"
return; this patch only widens the rejection window by 40 bytes.

When the frame is discarded here, the decompressor never sees it, so
comp->recv_current and SLF_TOSS keep their old values:

drivers/net/slip/slhc.c:slhc_uncompress() {
	...
	if(changes & NEW_C){
		...
		comp->flags &=~ SLF_TOSS;
		comp->recv_current = x;
	} else {
		if(comp->flags & SLF_TOSS){
			comp->sls_i_tossed++;
			return 0;
		}
	}
	...
}

and the caller just resets the counter and carries on:

drivers/net/slip/slip.c:slip_unesc() {
	...
			sl_bump(sl);
		clear_bit(SLF_ESCAPE, &sl->flags);
		sl->rcount = 0;
	...
}

If the dropped frame carried NEW_C selecting receive slot B, recv_current
still points at slot A and SLF_TOSS stays clear.  Since slhc_compress()
omits the connection index once its xmit_current matches, can the next
frame for B arrive with an implicit connection id and be decoded against
slot A's saved cs_ip/cs_tcp, producing a packet with A's addresses and
ports plus B's payload, and leaving A's cached state wrong until an
uncompressed TCP frame for A re-primes it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919223432.3882500-1-benquike%40gmail.com
