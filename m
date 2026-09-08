Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B34B0496
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907748; cv=none; b=IKJ9UETEGWlO5a2OPhJhcpIIz5xRvCTcJPUcQ7SNR3h8oGc1c7zeJqvKw4O6PqfRtC8bL+ZUjsZtQ1opUOFiSTsVhrcH1bYQ6Fxtw+kOsCvSPN5IjBaMVDs81W+Nkl3bFtREeHvUVnPkBuRxrodAllUZwWS4ddhnW8ndGJj1WY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907748; c=relaxed/simple;
	bh=jL+aQOqgHPCDRYvDxQ2LfO6RNt+ndVGH78i7XzchLD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVm5m9lbwa76rvydWR8YwU6IRa8319w2Pv7G8pw7kPCFpGHSQ0KrzHVSecn+s1cDTon3+mYiTK1X3m29W6w2beDeI/In3yEFZiKdiTBxUffDoyjNMLHdB6QWVyf6NVAa3G7i6ahHgsXKf3qve56sDb9Th0FD7rpSQzE8nfjNVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5z0Sjxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5z0Sjxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4261F00A3E;
	Tue,  8 Sep 2026 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907736;
	bh=9VYPeGD/e4GRNiwluAz8JywV2SAWKYvx4UzVTD1hpSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5z0SjxpzjgU4Wg8Nr+8m4KmIGMPPHeMHaFC2fWS4/z+DsRXUSlEBQgkINJAd0oBR
	 mw0jWkXC9Eav7R8gDJQEj7YuDLeZRxLKUxiBJOidkxq/DHtJr05Xjla0nxSVEh0Y/t
	 +5A1+sJ5KzfmUbz1JheTPgw0W7nKMTppNFTVIKuBmq5IwWyhrGfG4FN/+DsoG7gsJK
	 A7VGaHyHYnnBZwuz8uA6LEdz2foV9cTj3X0+P9VVaUzEIaaMRBoDjo+M3e7znqnlnx
	 v0yCN0KLKlbL/3v0XIgZXv6/ZVMXVibggYVGNQpYeH4Xz0LBWLlObpdGqGdoBlt3n7
	 7JCxBAJUirkQg==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 04/12] xfrm: iptfs: fix runt reassembly panic from short inner tot_len
Date: Tue,  8 Sep 2026 15:48:55 -0700
Message-ID: <20260908224855.1591147-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-5-steffen.klassert@secunet.com>
References: <20260907093020.2228346-5-steffen.klassert@secunet.com>
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
xfrm: iptfs: fix runt reassembly panic from short inner tot_len

This tightens the runt continuation path in iptfs_reassem_cont() so the
declared inner IP length must cover at least the IP header size before the
in-progress reassembly skb is allocated, replacing the old check against
sizeof(xtfs->ra_runt). A few questions below on how completely this matches
the in-place validation, plus two pre-existing observations in the same
function.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 2ce15c472cc4d..6920940a35b49 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -828,8 +828,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>  		 * allocate an in progress skb
>  		 */
>  		ipremain = __iptfs_iplen(xtfs->ra_runt);
> -		if (ipremain < sizeof(xtfs->ra_runt)) {
> -			/* length has to be at least runtsize large */
> +		if (ipremain < __iptfs_iphlen(xtfs->ra_runt)) {
> +			/* length has to be at least the IP header size */

[Severity: Medium]
The changelog says this will "Align the runt path with the normal path by
requiring the declared inner length to cover at least the IP header size."
Is that alignment complete for IPv4 with options?

__iptfs_iphlen() never looks at iph->ihl:

net/xfrm/xfrm_iptfs.c:__iptfs_iphlen() {
	if (iph->version == 0x4)
		return sizeof(*iph);
	return sizeof(struct ipv6hdr);
}

The in-place parser uses the declared header length instead:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
	...
	iplen = be16_to_cpu(iph->tot_len);
	iphlen = iph->ihl << 2;
	if (iplen < iphlen || iphlen < sizeof(*iph)) {
		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
	...
}

So a runt-started inner IPv4 packet declaring ihl < 5, or ihl * 4 greater
than tot_len (for example tot_len 20 with ihl 15), passes the new check,
gets a 20 byte allocation, is treated as completely reassembled and is
handed to iptfs_complete_inner_skb() and xfrm_input(), while byte-identical
input arriving wholly inside one outer payload is rejected with
LINUX_MIB_XFRMINHDRERROR. Should the runt path also test iph->ihl so the
two parsers agree on both acceptance and MIB accounting?

As far as I can tell the residual effect is bounded, since ip_rcv_core()
drops such a packet:

net/ipv4/ip_input.c:ip_rcv_core() {
	if (iph->ihl < 5 || iph->version != 4)
		goto inhdr_error;
	...
	if (!pskb_may_pull(skb, iph->ihl*4))
		goto inhdr_error;
}

The panic class described in the changelog (tot_len in [6, 19] making
"ipremain -= copylen" underflow) does look closed by this change for the
runt path.

Also, the kernel-doc on __iptfs_iphlen() says it returns "the IP header
size based on the IP version", and the new comment here says "length has to
be at least the IP header size". For IPv4 with options that is the minimum
header size rather than the header size. Would it be worth rewording either
the comment or the helper's kernel-doc?

>  			XFRM_INC_STATS(xs_net(xtfs->x),
>  				       LINUX_MIB_XFRMINIPTFSERROR);
>  			goto abandon;

Two further observations in this same function, both outside the hunk.

[Severity: High]
This isn't a bug introduced by this patch, but can the copy fallback later
in iptfs_reassem_cont() still reach skb_over_panic() on the normal
(non-runt) path?

net/xfrm/xfrm_iptfs.c:iptfs_reassem_cont() {
	} else {
		if (skb_linearize(newskb)) {
			XFRM_INC_STATS(xs_net(xtfs->x),
				       LINUX_MIB_XFRMINBUFFERERROR);
			goto abandon;
		}

		/* copy fragment data into newskb */
		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
				      copylen)) {
	...
}

There is no tailroom check before skb_put(newskb, copylen), and copylen is
min(min(blkoff, remaining), ipremain), so it is bounded only by the outer
payload length and the declared inner IP length.

When the in-progress skb came from the frag-sharing path, its linear head
is only iphlen plus XFRM_IPTFS_MIN_L2HEADROOM:

net/xfrm/xfrm_iptfs.c:iptfs_pskb_add_frags() {
	skb = iptfs_alloc_skb(tpl, copy_len, false);
	...
}

reached from __input_process_payload():

			    !(skb = iptfs_pskb_add_frags(first_skb, fragwalk,
							 data, capturelen,
							 skbseq, iphlen))) {

and skb_linearize() only adds about 128 bytes of tailroom:

net/core/skbuff.c:__pskb_pull_tail() {
	int i, k, eat = (skb->tail + delta) - skb->end;
	...
	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
	...
}

A continuation outer packet that is a plain kmalloc'd linear skb fails the
sharing precondition (head_frag is 0 and skb->len != skb->data_len), so it
lands in this fallback. With a roughly 1420 byte reassembly the head ends
up with a couple of hundred bytes of tailroom, and a continuation carrying
several hundred bytes more makes skb->tail exceed skb->end, which
skb_put() turns into skb_over_panic() and BUG(). Would guaranteeing the
tailroom (pskb_expand_head() or a skb_tailroom() test against ipremain)
before the skb_put() be appropriate here? This path still appears to be
present at the tip of the series.

[Severity: Low]
This is a pre-existing asymmetry rather than something this patch changes,
but should the runt path also arm the drop timer when it publishes
xtfs->ra_newskb?

net/xfrm/xfrm_iptfs.c:iptfs_reassem_cont() {
		newskb = iptfs_alloc_skb(skb, ipremain, false);
		if (!newskb) {
			XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINERROR);
			goto abandon;
		}
		xtfs->ra_newskb = newskb;
	...
}

The reassembly-start site in __input_process_payload() does arm it:

			xtfs->ra_newskb = skb;
			xtfs->ra_wantseq = seq + 1;
			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
				hrtimer_start(&xtfs->drop_timer,
					      xtfs->drop_time_ns,
					      IPTFS_HRTIMER_MODE);
			}

So a reassembly started from the runt path has no expiry, and if the peer
never sends the next sequence the skb (sized by the declared inner length,
up to about 64KB) stays pinned on the SA until another packet arrives or
the state goes away. The memory is reclaimed at teardown:

net/xfrm/xfrm_iptfs.c:iptfs_destroy_state() {
	hrtimer_cancel(&xtfs->drop_timer);

	if (xtfs->ra_newskb)
		kfree_skb(xtfs->ra_newskb);
	...
}

so this looks like retention past the intended drop time rather than a
leak. The publication itself is serialized, since iptfs_input_ordered()
holds xtfs->drop_lock across the iptfs_reassem_cont() call.
