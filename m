Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503825;
	b=ZcLc/SON3M9EZWcDxQi0TVEkTiY+jr6ftoE1ZB3Uci7OQfWGku/iknrgQvzr4bs2/0Rl
	 Heu4IccE8zG9vcwyTpSDzZBgrBPiIQ5YLnGNKs2dIsiwR+1Sy70iv5BiSLsaHcZlfJ8cM
	 si2TgKA/NpEIq0NWaRdEqdL7iM79vMcmhZl6NtZQpqmsz0ML7bp0GnB+l87UDZNFvb4Hp
	 0NTVRAu5s+hLL92dymv7+YukcNVD32YFo+A9B6q31UIcptZ4rRhsE+fyjPTrFGJv6nXMh
	 Sk4Ao/lkF8g1oqFer2corZdhBeFQTZ3U/5NK3XFQe9e4NLPGMtYgFeEPdPq/ABdPcXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503825;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lbceaQnyYO+efbC0A+siEddi+szNng1/wSnp2i9IZO4=;
	b=2Q7ZZeCvMYqz1hnZwa1xqz30KknOpmwoMbMTQfPb5pwV5nZ1XqBx+BgSRPSGupDBhOpf
	 UwvzIclYWilDXS5hLiEtwGsMxRDdOneE71rAB/1+iCMsQquzHfv4+0/MIO3kwKC9tQ2Q7
	 OcytXbszU6SEWBLoQaQOP2jgrVyTag09FqC5Cw3kWKcg6nCsfX/l+HEVSUWn6z5Jz7xcz
	 A80QKtI/wt/i7eUD2x5/OEojy76yASp9mX0mby8PTbR7ZYBqHS32s1Gdm0S8muJvkmDIM
	 3iKbUcdjw1HNX5KlEYpyTErW5p0xH4B1pt8uyJ3/U3kE51gJgWHP5TIYCt2dNHbchVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsrBlg1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D28606A335;
	Sun,  1 Nov 2026 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsrBlg1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995901F0093A;
	Sun,  1 Nov 2026 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793503824;
	bh=lbceaQnyYO+efbC0A+siEddi+szNng1/wSnp2i9IZO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SsrBlg1fYVFg/i/QPkcZlDZizwbsht9jcoF+m5GapDguUvDDiVTQwwAns3/E7QTac
	 9b2/SA2NB+DcYuEwdeQsXyS274Z8aBiDNf4VpkNIVbAH1a2isSnLGqKwVxKyqC7PRp
	 K+LNANPE1Q4by8924UdPRqfZUKVgR+hxpmgZo+yS+OZ6igS/l+Hv2mXecQuflDKtUi
	 oaq5YlLkIgwuQapkF40upLGnx/4tsN52HACUArRJ129n6zZ985HEJBlWvy134N7I1V
	 44ig2RAbQra/m0AxrnG72kTCFqoALhMlhm8H0BPZclJEWOi87Xdwlc6tJtip1OpZ5V
	 qA4vuuJ490uoQ==
Subject: Re: [PATCH ipsec v2 2/2] xfrm: use cached offload ifindex when
 migrating an SA
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 antony.antony@secunet.com, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Sun, 01 Nov 2026 03:30:23 +0000
Message-ID: <179350382315.3131.13286442217714808392@kernel.org>
In-Reply-To:
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
References:
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch's only AI-disclosure trailer, 'Assisted-by: LLM', sits
  below the '---' separator, after 'Signed-off-by: Cen Zhang'.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the patch now
  reads the cached xso->ifindex as a stable snapshot while the rest of…

--

xfrm: use cached offload ifindex when migrating an SA

This patch changes xso_to_xuo() to use the ifindex cached in the offload
record instead of dereferencing xso->dev. This closes a NULL dereference
when xfrm_dev_state_flush() races with XFRM_MSG_MIGRATE_STATE. It also
annotates the xso.dev check in xfrm_do_migrate_state() with READ_ONCE().

> Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
>
> ---
> Assisted-by: LLM

[Severity: Low]
This isn't a bug, but the Assisted-by tag is below the "---" separator,
so git am and b4 drop it when the patch is applied. The applied commit
ends at the Signed-off-by line and has no Assisted-by trailer.

Documentation/process/submitting-patches.rst ("Using Assisted-by:") asks
contributors to acknowledge tool use with an Assisted-by tag. Earlier
xfrm commits such as c4a5f0071cc6 ("xfrm: cache the offload ifindex for
netlink dumps") put it in the regular tag block.

Could the tag be moved above the "---" line, next to Fixes: and
Signed-off-by:?

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 781d4ec565aae..1cea24380797d 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1240,7 +1240,7 @@ static void xso_to_xuo_ifindex(const struct xfrm_dev_offload *xso, int ifindex,
>  static void xso_to_xuo(const struct xfrm_dev_offload *xso,
>  		       struct xfrm_user_offload *xuo)
>  {
> -	xso_to_xuo_ifindex(xso, xso->dev->ifindex, xuo);
> +	xso_to_xuo_ifindex(xso, READ_ONCE(xso->ifindex), xuo);
>  }
>  #endif
>  
> @@ -3462,7 +3462,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	} else {
>  		bool inherit_offload = !(um->flags & XFRM_MIGRATE_STATE_CLEAR_OFFLOAD);
>  
> -		if (inherit_offload && x->xso.dev) {
> +		if (inherit_offload && READ_ONCE(x->xso.dev)) {
>  			xso_to_xuo(&x->xso, &xuo);
>  			m.xuo = &xuo;
>  		}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
patch now treats the cached ifindex as a stable snapshot, but the rest of
the inherited xuo still comes from fields that teardown changes.

The dev check and xso_to_xuo() run without x->lock.
xso_to_xuo_ifindex() does plain reads of xso->dir and xso->type:

net/xfrm/xfrm_user.c:xso_to_xuo_ifindex() {
	xuo->ifindex = ifindex;
	if (xso->dir == XFRM_DEV_OFFLOAD_IN)
		xuo->flags = XFRM_OFFLOAD_INBOUND;
	if (xso->type == XFRM_DEV_OFFLOAD_PACKET)
		xuo->flags |= XFRM_OFFLOAD_PACKET;
}

At the same time, under RTNL, xfrm_dev_state_flush()->xfrm_dev_state_free()
does:

net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
	...
		WRITE_ONCE(xso->dev, NULL);
		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
		netdev_put(dev, &xso->dev_tracker);
	...
}

Migration holds xfrm_cfg_mutex and the notifier holds RTNL. Nothing
orders the plain store and the plain load of xso->type.

Would KCSAN report this as a data race?

Suppose the flush lands between the READ_ONCE(x->xso.dev) check and the
type read. The xuo then gets the valid cached ifindex but loses
XFRM_OFFLOAD_PACKET. xfrm_state_migrate_create() then tries
xfrm_dev_state_add() on the clone in crypto offload mode.

As far as I can tell, this is contained. xfrm_dev_state_flush() calls
xfrm_state_delete() before xfrm_dev_state_free(), so this later locked
check in xfrm_do_migrate_state() throws away the clone:

	spin_lock_bh(&x->lock);
	if (x->km.state != XFRM_STATE_VALID) {
		spin_unlock_bh(&x->lock);
		NL_SET_ERR_MSG(extack, "State already deleted");
		err = -ESRCH;
		goto out_xc;
	}

The dump path has the same plain reads of dir and type, through
copy_user_state_offload(). The xso->dev NULL dereference described in the
commit message does look fixed.

Should the dir and type reads be annotated too, or the snapshot taken
under x->lock, so the inherited xuo stays consistent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0%40gmail.com
