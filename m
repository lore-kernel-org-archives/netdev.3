Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3381B4F09;
	Sat, 19 Sep 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777294; cv=none; b=d6NtUTFiWzcoUTCYWEQnhBzAkeN7pcG6p+5PFA9fXzoq/obLEt3JqwINXCPf2MTuSr4pd5FGyOCHvMP2hxVkaxwBB2QOlcZe2tKK08B2dDQGOg1SyV86kgQmRfcAFRCptU7HpHPDplEojSGy1H2EsAFsNTL8DLevgWV8wUZw8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777294; c=relaxed/simple;
	bh=hDJ9tnKNSk5KEFyRpWdz3JKEPnVX11Y2zIDwgdVzMUA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhDC66bwifTEcOGTFqVBxEBe3WBvmrLqJaphLR6Xo3kkbXLLbLstzubUtkIZ8IYq/XjSxNAOZ/GzTgQWQUZp2DfHFha/aJ4d9jy1eLPSDtcVrFomDSjxSC3/UBQ8M8Kv45aOvT5x0NxtuQd2on/5pvTRpCqB1wWRzEdAOCGZXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEnySwUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEnySwUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A81F00898;
	Sat, 19 Sep 2026 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777292;
	bh=cHUR9u0FNALlXk8gSaLeRB2+YeSYHwq/ZZ/8fs2t1L8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PEnySwUCQNP/TtM0aTQlYLGTaZnkx7pLJp+vWXgV7ye50QGJQ8RGFy/EPD3LiDOKK
	 DUtpnPGHinOSfupgECfNX11bJyik9lp4st1dyisUo92UzgJep9PQfUjBukHDvOy1sp
	 +WlQkiLnXdQD1j05Hl2Dmil34+st4+78KS1rKW19Q6UWL4PkNkCav5M0SGISqC5WmB
	 Emdh47BRwylLuQTXC0bu9e+YtH/TH4YoD0ch8GuNti37a0k46XgAHGPIBPR1VCrBf9
	 LWeqSMdK+89g6xMMffENv6zl3Ewi07tGmzeQk2n5zwMkU00xm23zck7aLpiW94S2pb
	 a11TqpNjwPpkg==
Subject: Re: [PATCH net-next v2 2/5] vxlan: vnifilter: bound the number of
 VNIs one request may touch
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 00:21:31 +0000
Message-ID: <178977729135.22033.13147755210230234567@kernel.org>
In-Reply-To: <20260916193449.2552039-3-alishmery18@gmail.com>
References: <20260916193449.2552039-3-alishmery18@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The kernel's own dump output is no longer accepted by the
  kernel's own input path.
- [Low] Ambiguous framing: the changelog describes a concrete kernel
  defect — one netlink message making vxlan_vni_add_del()…

--

vxlan: vnifilter: bound the number of VNIs one request may touch

The patch adds vxlan_vnifilter_check_msg(), which sums the START/END span
of every VXLAN_VNIFILTER_ENTRY in an RTM_NEWTUNNEL or RTM_DELTUNNEL
message and rejects the message with -EINVAL if the total exceeds a new
driver-local limit of 4096.  The range extraction used by
vxlan_process_vni_filter() is factored out into
vxlan_vni_filter_entry_range() so both sides compute the same range.

v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

Two questions, one about the changelog and one about the new check.

> vxlan: vnifilter: bound the number of VNIs one request may touch
>
> With both endpoints bounded to the 24-bit space, a single RTM_NEWTUNNEL
> or RTM_DELTUNNEL message can still ask for all of it.
> vxlan_vni_add_del() loops over the span creating one VNI node and one
> per-CPU stats block per iteration, all under rtnl_lock.

[Severity: Low]
This part of the changelog reads like the description of a user triggerable
defect: one netlink message makes vxlan_vni_add_del() iterate over up to
the whole 24-bit space, allocating a vxlan_vni_node plus a per-CPU stats
block per iteration while holding rtnl_lock.

There is no Fixes: tag naming the commit that introduced that loop
(f9c4bb0b245c "vxlan: vni filtering support on collect metadata device"),
and no statement that this is a policy/hardening change that should not be
backported.

Since the patch also narrows what userspace may send in one message, could
the changelog say which of the two it is, so stable triage does not have to
guess?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 5aaaaeee81107..9a1baca39d8b0 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -17,6 +17,15 @@
>  
>  #include "vxlan_private.h"
>  
> +/* Maximum number of VNIs one RTM_NEWTUNNEL or RTM_DELTUNNEL message may add or
> + * delete, summed over all of its VXLAN_VNIFILTER_ENTRY attributes. VNI
> + * filtering is mainly used on bridged VXLAN devices where the VNI is derived
> + * from the VLAN, so a message touching more VNIs than the VLAN ID space has no
> + * practical use, while an unbounded message can walk the whole 24-bit space
> + * under rtnl_lock.
> + */
> +#define VXLAN_VNI_FILTER_MSG_MAX	4096
> +

[ ... ]

> @@ -846,12 +855,77 @@ static int vxlan_vni_add_del(struct vxlan_dev *vxlan, __u32 start_vni,

[ ... ]

> +static int vxlan_vnifilter_check_msg(const struct nlmsghdr *nlh,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *vattrs[VXLAN_VNIFILTER_ENTRY_MAX + 1];
> +	struct nlattr *attr;
> +	u32 vnis = 0;
> +	int err, rem;
> +
> +	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
> +				 sizeof(struct tunnel_msg), rem) {

[ ... ]

> +		/* vni_filter_entry_policy has already bounded both endpoints
> +		 * to below VXLAN_N_VID, so one entry adds at most VXLAN_N_VID
> +		 * and vnis cannot wrap before the test below rejects it.
> +		 */
> +		vnis += vni_end - vni_start + 1;
> +		if (vnis > VXLAN_VNI_FILTER_MSG_MAX) {
> +			NL_SET_ERR_MSG_ATTR_FMT(extack, attr,
> +						"Request asks for more than %u VNIs",
> +						VXLAN_VNI_FILTER_MSG_MAX);
> +			return -EINVAL;
> +		}
> +	}

[Severity: Medium]
Does this make the driver emit a VXLAN_VNIFILTER_ENTRY that it will then
refuse to parse back?

The changelog states that a device may still hold the whole 24-bit space as
long as it is populated by several messages.  On dump,
vxlan_vnifilter_dump_dev() merges every contiguous run sharing a remote
into one entry with no clamp:

	if (!dump_stats && vnirange(vend, v) == 1 &&
	    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {
		goto update_end;

and vxlan_fill_vni_filter_entry() serializes that whole run into the same
START/END pair that update requests use:

	if (nla_put_u32(skb, VXLAN_VNIFILTER_ENTRY_START, vs))
		goto out_err;

	if (ve && nla_put_u32(skb, VXLAN_VNIFILTER_ENTRY_END, ve))
		goto out_err;

So a device populated with more than 4096 contiguous VNIs sharing a remote
dumps as a single entry whose span vxlan_vnifilter_check_msg() rejects with
-EINVAL on replay.  Should the dump side be clamped to the same constant so
the two representations agree?

A second question on the same check: it does not look at nlh->nlmsg_type,
so RTM_DELTUNNEL is bounded as well.  vxlan_vni_del() only looks the VNI up
and frees it:

	vninode = rhashtable_lookup_fast(&vg->vni_hash, &v,
					 vxlan_vni_rht_params);
	if (!vninode) {
		err = -ENOENT;

Since the delete path allocates nothing, is bounding RTM_DELTUNNEL
intended?  As written, a device holding more than 4096 VNIs can no longer
be torn down with the single range the dump reported.

> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -975,6 +1043,10 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
>  		return -EOPNOTSUPP;
>  
> +	err = vxlan_vnifilter_check_msg(nlh, extack);
> +	if (err)
> +		return err;
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916193449.2552039-1-alishmery18%40gmail.com
