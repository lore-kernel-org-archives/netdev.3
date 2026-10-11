Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810234349A5;
	Sun, 11 Oct 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716279; cv=none; b=R+hseD0Dd4Q90vGkKdzWQ5RWrRGJl0FnqHvk0gwf3sWw41eRsH4C8UPPHQYH/BfpbzxvwsvxSrSYPOpgjR2RQquXD8d2QomiwnS3LA8Dmq1hJ/G2zjfWNKMJ3JTz0qPKdAjizn7cU7NK30Rjb4j+mehOFB+20gVZMEC9W5KKqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716279; c=relaxed/simple;
	bh=Tc+kodKhvmE85izlb62Bko0JDfZzSIuHoRrryaVi6WI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjJvS+QDpRvrgPYhYK+nTFli+yXX8LY7j4ZYiTr0A2LYKOd7ApWLBTrYD02grLfbmFFhr0k8RyLvCybX2gHMFyM/oZsm/R6MvoRcyfka2Jul588JXZroc/2xsYz60MXkmOVF+ax76MAvnncurnZ1F6zBdA6yucQQWnizyels4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu7LBny3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu7LBny3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F1B1F0089B;
	Sun, 11 Oct 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791716278;
	bh=uYuOmDYM/OtK+7dgfGCc9gOnVlb1C8Q7VQ5dl8fWrGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eu7LBny371tm+drfFPWUHLdRE7m/j6wCcToNLE8hlLEPCRk7XejJzvq7Yxwo3qDd7
	 cMoYs8cINc4K3NXS6+3egWscPqOK0Y74hnNsnrrMU6LyVcNMby1nkEgKOIGW57/A9r
	 PQ+tNqEKh2DIyo6WZIAbwOdyExI4eSWE/jivR/Lj9lmsG3WQgBZEMc/gCNrhglhfSW
	 O0wfgDI7O8+RTTusDxOemUq/hPkEu6/lLBVzrkYKJNW0wt5qcYNcfPSZkEpDpuAKsa
	 7OZGhvedR/Vgr9qEhs5DD2BCR5lUU4EFI7AHhSi4ibn9xcMZDANtgjbltnmb9P1VHw
	 an25/iXGLF3jg==
Subject: Re: [PATCH ipsec v5] xfrm: iptfs: fix pp_ref_count underflow when
 sharing page_pool frags
From: netdev-bot+sashiko@kernel.org
To: antony.antony@secunet.com
Cc: chopps@labn.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:57:57 +0000
Message-ID: <179171627713.434549.11629734394381610294@kernel.org>
In-Reply-To: <xfrm-iptfs-pp_ref_count-underflow-v5-1-c25508ec9160@secunet.com>
References: <xfrm-iptfs-pp_ref_count-underflow-v5-1-c25508ec9160@secunet.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the iptfs_skb_add_frags() hunk is
  cosmetic: "Its destination skb never has pp_recycle set today, so…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits in the
  function the patch edits.
- [Low] iptfs_frag_ref() (net/xfrm/xfrm_iptfs.c:453-466) decides whether
  a frag is page_pool owned differently from the release path.

--

xfrm: iptfs: fix pp_ref_count underflow when sharing page_pool frags

This adds iptfs_frag_ref(). When the destination skb has pp_recycle set
and the frag's head page is page_pool owned, it takes a page_pool
reference. Otherwise it takes a plain page reference. The helper is used
in iptfs_consume_frags() to fix a pp_ref_count underflow on the TX
aggregation path, and in iptfs_skb_add_frags() for consistency.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..86688c0c3db96 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c

[ ... ]

> @@ -449,6 +450,21 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
>  	return true;
>  }
>  
> +static void iptfs_frag_ref(skb_frag_t *frag, bool recycle)
> +{
> +	netmem_ref netmem = skb_frag_netmem(frag);
> +	struct page *head;
> +
> +	if (recycle && !netmem_is_net_iov(netmem)) {

[Severity: Low]

This is a pre-existing issue, but the net_iov handling here doesn't
match the release side.

For a pp_recycle destination, every net_iov frag falls through to
__skb_frag_ref() -> get_netmem(), which never touches pp_ref_count.
The release path in napi_pp_put_page() does this:

	netmem = netmem_compound_head(netmem);

	if (unlikely(!netmem_is_pp(netmem)))
		return false;

netmem_is_pp() returns true for page_pool backed net_iov. If such a frag
is shared through iptfs_skb_add_frags(), the release would drop a
pp_ref_count that was never taken.

This doesn't look reachable today:

  - Software ESP can't pass an unreadable skb on to IPTFS input. When
    skb_copy_bits() fails, esp_remove_trailer() calls BUG().
  - mlx5 is the only unreadable-netmem driver with IPsec offload, and
    mlx5e_xfrm_add_state() rejects modes other than transport and
    tunnel.
  - On TX, iptfs_frag_ref() is only called on the head page.

The net_iov behaviour is also the same as before the patch. The commit
message already says "The netmem/devmem path is not addressed and
probably needs a fix in net/core".

Could this be handled together with that net/core change?

> +		head = compound_head(netmem_to_page(netmem));
> +		if (page_pool_page_is_pp(head)) {
> +			page_pool_ref_page(head);
> +			return;
> +		}
> +	}
> +	__skb_frag_ref(frag);
> +}
> +

[ ... ]

> @@ -486,7 +502,7 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
>  			tofrag->len -= offset;
>  			offset = 0;
>  		}
> -		__skb_frag_ref(tofrag);
> +		iptfs_frag_ref(tofrag, skb->pp_recycle);

[Severity: Medium]

The commit message says this about the hunk:

  Its destination skb never has pp_recycle set today, so behaviour
  there does not change.

Is that accurate for the RX reassembly path?

In __input_process_payload(), the "Reuse the received skb" branch keeps
the skb the driver delivered (skb_pull(skb, data)). That skb keeps its
pp_recycle bit. If the inner packet is incomplete, it becomes the
reassembly destination:

		if (skb->len < iplen) {
			/* Start reassembly */
			spin_lock(&xtfs->drop_lock);

			xtfs->ra_newskb = skb;

On the next ESP packet, iptfs_reassem_cont() uses it as newskb. The
sharing gate there only requires pp_recycle to match:

	if (!skb_has_frag_list(skb) && !skb_has_frag_list(newskb) &&
	    (skb->head_frag || skb->len == skb->data_len) &&
	    skb->pp_recycle == newskb->pp_recycle) {
	...
		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);

On a page_pool NIC, both skbs have pp_recycle set. Before this patch,
the shared frags got a plain reference from __skb_frag_ref(), but they
were later released through napi_pp_put_page(), which decrements
pp_ref_count.

Doesn't that make this hunk a fix for the same underflow on the RX
reassembly path, not just a consistency change? Could the commit message
say that both the TX aggregation and RX reassembly sharing paths were
affected, since that matters for stable backports?

>  		shinfo->nr_frags++;
>  		shinfo->flags |= SKBFL_SHARED_FRAG;
>  
> @@ -2171,7 +2187,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
>  		new_truesize = SKB_TRUESIZE(skb_end_offset(from));
>  	} else {
>  		iptfs_skb_head_to_frag(from, &toi->frags[toi->nr_frags]);
> -		skb_frag_ref(to, toi->nr_frags++);
> +		iptfs_frag_ref(&toi->frags[toi->nr_frags], to->pp_recycle);
> +		toi->nr_frags++;
>  		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
>  	}
>  

[Severity: High]

This isn't a bug introduced by this patch, but since
iptfs_consume_frags() is being changed: can it corrupt a cloned source
skb?

In iptfs_output_queued(), only the destination is checked for clone or
shared state:

		if (shi->frag_list || skb_cloned(skb) || skb_shared(skb))
			share_ok = false;

The per-source test never checks skb_cloned(skb2) or skb_shared(skb2):

			if (share_ok &&
			    (shi2->frag_list ||
			     (!skb2->head_frag && skb_headlen(skb)) ||
			     skb->pp_recycle != skb2->pp_recycle ||
			     skb_zcopy(skb2) ||
			     (shi->nr_frags + shi2->nr_frags + 1 > MAX_SKB_FRAGS)))
				share_ok = false;

iptfs_consume_frags() then memcpy()s fromi->frags into the aggregate
without taking frag references, and does:

	fromi->nr_frags = 0;

If skb2 is a clone, that skb_shared_info is shared with its sibling. The
sibling is left with data_len > 0, nr_frags == 0 and no frag_list, and
the aggregate becomes the only owner of the page references. For
comparison, skb_try_coalesce() only moves frags when !skb_cloned(from),
and takes references otherwise.

Cloned skbs could reach this point with nothing uncloning them before
dst_output() -> iptfs_output_collect():

  - netem duplicate on an xfrm interface (netem_enqueue() uses
    skb_clone())
  - a non-mmap AF_PACKET listener on the xfrmi device
    (dev_queue_xmit_nit())
  - tc mirred from xfrmi

In each case the skb can be a forwarded non-GSO, non-linear, head_frag
RX skb.

With netem duplicate, the second clone is later accounted with
skb->data_len += skb2->len (or sent as a first skb) after its frags are
gone. The ESP output path can then hit BUG_ON(len) in __skb_to_sgvec().
An AF_PACKET reader could get -EFAULT. A concurrent reader, or DMA on a
mirrored device, could access pages after the aggregate frees them.

This dates back to b96ba312e21c and needs CAP_NET_ADMIN configuration.
Should the share_ok test also reject skb_cloned(skb2) or
skb_shared(skb2)?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/xfrm-iptfs-pp_ref_count-underflow-v5-1-c25508ec9160%40secunet.com
