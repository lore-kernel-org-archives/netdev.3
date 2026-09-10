Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C4346A0A;
	Thu, 10 Sep 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033141; cv=none; b=na4Ap+M4RAGE/YzNZpuJvp2sM3ZW5MSGrAu8ONYZ/I7jjfD4zHVYo1EG5dHDW2xtiotNknQERxQfedQND7FiQxW/T2xIdbQXvMfRJNZPF57UzUh9jnwonpPBOimzgt81K4YaY50TGzBhYZaDI39pWrp+du1nz88t7mzW9n22NaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033141; c=relaxed/simple;
	bh=bJfsk8vN7fKf/YDjhEoOtYubg6qlVu8X/PVtSRAykeg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5Zx6v2pKNEter6SnUrxVY7L4SheeqE4xp48XPoufXf78VWTiZcIRmVAAPmsdVHp8F47MhrarfvhsBlODqjNUGoJp+bS9e7WPfpm03j24KejqVktChIBf8/nFCAskxUpNCEKjVNKAgaYnLomYK1bmRIgQNSFagG2Y/ikpwiXM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG5CeSrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG5CeSrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F721F000FF;
	Thu, 10 Sep 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033139;
	bh=aWKG4e3xaK5k7/mQ03wur/M0dRnzIddGLGbECwxYiRk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RG5CeSrdV+YSrlamJa4FD9ZLD1OUHpgEJjs3BH1bGo8aUw41rvHS++gyXtG0DGuNU
	 pFDC0RJ8PBMX+QfI/LnXYt8/9XOiL034K53SCgbtNMqW1nE5PyjuYCHt+PjjtoxLA6
	 0nk+r0cJIln7hQ78fIgO3h5Ied3bXb0XN3xzkuh07hoeuyluwtUc/N7theOMR7iVkd
	 nMkFoL91SgwP+6MhggmwiWoZDc4nfD5Nz7iO5B2qvdDFoFpamPAUfW3FcMGPIeTiWA
	 iLwLZ/JjBVfDpchKoBvvsNNN84jyAto3db/BFSBD8zpJ+ZYc/iXtfi1yza2+HA8Z5o
	 yM429LLkstKUw==
Subject:
 Re: [PATCH net 1/3] vxlan: vnifilter: limit the VNI range of a single request
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, razor@blackwall.org, roopa@nvidia.com,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 09:38:58 +0000
Message-ID: <178903313861.219967.6252085743999078920@kernel.org>
In-Reply-To: <20260909092645.3105263-2-alishmery18@gmail.com>
References: <20260909092645.3105263-2-alishmery18@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 1 · Low: 0

- [High] The new cap is enforced per VXLAN_VNIFILTER_ENTRY attribute, not
  per netlink request, so the bug class the commit claims to close stays…
- [High] The added check can be bypassed entirely because
  vxlan_vni_add_del() (drivers/net/vxlan/vxlan_vnifilter.c:820) iterates…
- [Medium] The kernel now emits VNI-filter messages it will refuse to
  parse.

--

vxlan: vnifilter: limit the VNI range of a single request

This adds a driver-local constant VXLAN_VNI_FILTER_RANGE_MAX of 4096 and
rejects a VXLAN_VNIFILTER_ENTRY_START/END pair whose span is wider than
that, in vxlan_process_vni_filter().  The stated goal is to stop one
RTM_NEWTUNNEL or RTM_DELTUNNEL message from creating up to 2^24 VNIs
under rtnl_lock.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e0886..f18ce0e1e741 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -17,6 +17,14 @@
>  
>  #include "vxlan_private.h"
>  
> +/* Maximum number of VNIs a single RTM_NEWTUNNEL or RTM_DELTUNNEL request may
> + * span.  VNI filtering is mainly used on bridged VXLAN devices where the VNI
> + * is derived from the VLAN, so a span wider than the VLAN ID space has no
> + * practical use, while an unbounded span lets one netlink message create up
> + * to 2^24 VNIs under rtnl_lock.
> + */
> +#define VXLAN_VNI_FILTER_RANGE_MAX	4096
> +
>  static inline int vxlan_vni_cmp(struct rhashtable_compare_arg *arg,
>  				const void *ptr)
>  {

[ ... ]

> @@ -869,6 +877,17 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
>  		return -EINVAL;
>  	}
>  
> +	/* Only bound a well-formed range; a start above the end selects no
> +	 * VNI at all and is left behaving as before.
> +	 */
> +	if (vni_end >= vni_start &&
> +	    vni_end - vni_start >= VXLAN_VNI_FILTER_RANGE_MAX) {
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, nlvnifilter,
> +					"VNI range spans more than %u VNIs",
> +					VXLAN_VNI_FILTER_RANGE_MAX);
> +		return -EINVAL;
> +	}
> +

[Severity: High]

Is this bound per request, or per VXLAN_VNIFILTER_ENTRY attribute?
vxlan_process_vni_filter() is called once per entry from
vxlan_vnifilter_process():

	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
				 sizeof(*tmsg), rem) {
		err = vxlan_process_vni_filter(vxlan, attr, nlh->nlmsg_type,
					       extack);
		vnis++;
		if (err)
			break;
	}

The vnis counter is only used afterwards to emit "No vnis found to
process", it is never a budget, and vni_filter_policy places no limit on
how many nested VXLAN_VNIFILTER_ENTRY attributes a message may carry:

	static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
		[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
	};

A minimal entry is a 4 byte nest header plus an 8 byte START and an 8
byte END, so a message that fits inside the default sk_sndbuf can carry
on the order of ten thousand entries, each of which passes the new check
while spanning 4096 VNIs.  That sums to more than the entire 24-bit space
in one message.  The handlers are registered with flags 0:

	{THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL, vxlan_vnifilter_process, NULL, 0},
	{THIS_MODULE, PF_BRIDGE, RTM_DELTUNNEL, vxlan_vnifilter_process, NULL, 0},

so rtnl_lock is held for the whole loop, with no lock drop and no
cond_resched(), and each iteration of vxlan_vni_add_del() still does
kzalloc_obj() plus netdev_alloc_pcpu_stats() per VNI in vxlan_vni_alloc().

Would the bound need to accumulate the span across all entries of the
message, or be applied in vxlan_vnifilter_process() before any entry is
handed to vxlan_process_vni_filter()?

The commit message says:

  "The check sits in vxlan_process_vni_filter(), where the span is known
  and before any VNI is created, so it rejects the request before any
  work is done."

Since entries are parsed and applied one at a time, an oversized entry in
the middle of a message returns -EINVAL only after all preceding entries
have already created their VNI nodes and sent their notifications.  Should
that sentence be adjusted, along with the comment above the constant which
describes the value as a cap on what "a single RTM_NEWTUNNEL or
RTM_DELTUNNEL request may span"?

[Severity: High]

Can this check be skipped entirely with a large START value?
vni_filter_entry_policy declares the two attributes without any maximum:

	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },

so START = 0xffffffff and no END gives vni_start == vni_end ==
0xffffffff.  The "!vni_start && !vni_end" test above does not fire, and
here vni_end - vni_start is 0, so this looks like a one VNI request and is
accepted.

vxlan_vni_add_del() then iterates with a signed counter:

	int v, err = 0;
	...
	for (v = start_vni; v <= end_vni; v++) {

v starts at -1, and in "v <= end_vni" it is converted to unsigned against
the __u32 end_vni, so 0xffffffff <= 0xffffffff is true, a VNI is created,
v++ makes v == 0, and 0 <= 0xffffffff is still true.  Does the loop then
keep walking upwards from 0, creating a node plus per-CPU stats plus a
notification per iteration under rtnl_lock, until -ENOMEM or until
rhashtable returns -E2BIG (vxlan_vni_rht_params has .max_size =
VXLAN_N_VID, so max_elems is about 33.5M)?  vxlan_vni_in_use() returns 0
for a namespace holding a single vnifilter device, so nothing seems to
abort it earlier.  Once v passes INT_MAX the increment is also signed
overflow.

The same applies to any range that ends at 0xffffffff, for example
START = 0xfffff001 with END = 0xffffffff, whose span is 4095.  Would
bounding the absolute values (or making the loop counter unsigned) be
needed in addition to bounding the difference?

[Severity: Medium]

Does this make the dump output unparseable by the same code path?
vxlan_vnifilter_dump_dev() merges an unbounded run of contiguous VNIs
that share a remote into one VXLAN_VNIFILTER_ENTRY:

		if (!dump_stats && vnirange(vend, v) == 1 &&
		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {
			goto update_end;

and then calls vxlan_fill_vni_filter_entry(skb, vbegin, vend, dump_stats)
once for the merged run, emitting a single START/END pair with no clamp on
the span.  The commit message keeps it legal for a device to hold the whole
VNI space through several requests, so a device populated with, say,
100000 contiguous VNIs via 25 accepted requests is dumped as one entry
with END - START == 99999.  Replaying that entry, or deleting the run with
one RTM_DELTUNNEL, now returns -EINVAL with "VNI range spans more than
4096 VNIs".

Should the dump side chunk merged runs to the same maximum span, or should
the input restriction be expressed as something other than a limit on the
START/END span?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909092645.3105263-1-alishmery18%40gmail.com
