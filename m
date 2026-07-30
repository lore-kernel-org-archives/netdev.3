Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D563AAF66;
	Thu, 30 Jul 2026 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445774; cv=none; b=deJtuChs8NEg+a/D+woYVx+zu+gXEYc7H4AUY4ql+sCJnFpFL87AuMK9BiNpmU7chnYsY8rilFQkeEWF32SFQv/dXKisZY3uzcpZCSYmavYx3j5+HDtevXfhwWNkb5KgJN57ga+YQD1+G7TvCRmcuXRuyl/CgvIo8cu4D8+RJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445774; c=relaxed/simple;
	bh=UxWT9pZD7jsupbg+yzBF6AobjQZUVfZ8V/kD5ALgy8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jamdVQXUdTYoPb4wt6VWLdDaGVXae64wpkUeoHltuveoBkm8R7rkahCYx8FP9aw8DeAVmf/jXO0rnA9z6pS5LfCTXZSCke6xk5TOu3LJrG5NzpFVwDq3+sVP7u/hlHKzSs9Y9Y6x5LhMiFsg/38BTxBYHKYMxh+VrDIWTG4Wdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfSp5Nqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfSp5Nqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3211F000E9;
	Thu, 30 Jul 2026 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785445772;
	bh=o/8dSSIj9lkXv3MuG30lGjcuHSzXvi0DuglxVmQ7pis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JfSp5Nqt+AU71MExM65jKtN9EhkcTret1IKNZypgvTuMgiUru7201Cl+4JreBmLp9
	 UABNHbmM/DQy1qrgzwpKRhrU3wqQ4FMUtl58IgB7qRNimNkfAlgkYiodOD481I0nWi
	 yrINmIXiUg4lqUiwDlCeRCZi9MjisR6KKDId2+NROY5kcqannbBYotV4Rd/bZCiZHi
	 e4JKG3DnqozVEJLjaLSITO1a8r2WkOL+ArAWCsty6y1gHs6/4a3PhWNaWyxiVaXj4N
	 /x/zFdGDiBCzuV2F5BxdTT9MOG7JKOF4E0flHYNDsczqktZGe412A2Qq8DosMHuSZn
	 jbGLQcFQHOhsQ==
Date: Thu, 30 Jul 2026 14:09:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] rtnetlink: cap IFLA_VFINFO_LIST at a
 documented number of VFs
Message-ID: <20260730140931.14d5bf4b@kernel.org>
In-Reply-To: <20260730090700.65867-1-iprintercanon@gmail.com>
References: <20260729185513.52564971@kernel.org>
	<20260730090700.65867-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:07:00 +0300 Artem Lytkin wrote:
> rtnl_fill_vf() emits one IFLA_VF_INFO per VF into the IFLA_VFINFO_LIST
> nest and closes it with nla_nest_end(), which stores the accumulated
> length into nla_len. That field is a u16, so a nest larger than 65535
> bytes is written truncated modulo 65536.
> 
> Nothing catches it on the way. if_nlmsg_size() adds rtnl_vfinfo_size()
> for every VF, so the skb really is large enough and none of the nla_put()
> calls fails. Userspace then walks the message with RTA_NEXT(), which
> advances by the stored length, so parsing resumes inside VF payload and
> the attributes after the nest are read out of VF data: IFLA_VF_PORTS,
> IFLA_XDP, IFLA_LINKINFO, IFLA_PERM_ADDRESS, IFLA_AF_SPEC. iproute2
> prints "!!!Deficit" and strictly validating parsers reject the message.
> On CONFIG_DEBUG_NET kernels nla_nest_end() also splats, via the
> DEBUG_NET_WARN_ON_ONCE() added in commit 1346586a9ac9 ("netlink: add a
> nla_nest_end_safe() helper").
> 
> Where the wrap falls depends on what was asked for and on the host. A VF
> costs 196 bytes, 296 with statistics, 236 with GUIDs and 336 with both.
> On a kernel without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS the statistics
> carry a padding attribute each and cost 32 bytes more, which makes those
> two 328 and 368. So the nest overflows somewhere between 179 and 335
> VFs. ice allows 256 VFs per PF
> (ICE_MAX_SRIOV_VFS), which reaches it. Statistics are included unless the
> request sets RTEXT_FILTER_SKIP_STATS, so the common case is the one that
> wraps first.
> 
> A limit that moves with the requested attribute set and with the host's
> alignment requirements is not something userspace can be told, so use
> fixed numbers instead and document them as what the interface supports:
> 256 VFs, or 128 when statistics are included. Both stay well inside
> U16_MAX even in the largest per-VF encoding, at 60416 and 47104 bytes
> respectively. rtnl_vfinfo_size() applies the same limit so that the skb
> is not sized for VFs that will not be emitted.
> 
> A device with more VFs than the limit reports a shorter
> IFLA_VFINFO_LIST. IFLA_NUM_VF keeps carrying the real count, and
> everything after the nest stays parsable, which is the part that is
> broken today. An empty nest is already emitted for a PF with no VFs, so a
> list shorter than IFLA_NUM_VF is not a new encoding.
> 
> Returning -EMSGSIZE instead, which is what nla_nest_end_safe() would
> give, is not an option here: a nest that does not fit in a u16 will not
> fit in a retried skb either, so it would turn a link dump on such a
> device into a hard failure.
> 
> The other large nests in rtnl_fill_ifinfo() were audited and cannot
> overflow. IFLA_AF_SPEC is bounded by a handful of address families at
> about a kilobyte each, and IFLA_VF_PORTS would need more than 560 VFs,
> which no in-tree driver allows.
> 
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Link: https://lore.kernel.org/netdev/16b289f6-b025-5dd3-443d-92d4c167e79c@intel.com/
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
> v2:
>  - cap at fixed limits, 256 VFs and 128 when statistics are included, and
>    document them in the netlink spec, rather than dropping whichever VF
>    happens not to fit (Jakub)
>  - drop the Fixes: tag, this is a long standing limitation of the
>    interface and not a regression (Jakub)
>  - retarget net-next for the same reason
>  - changelog: corrected the per-VF sizes, which mixed two configurations,
>    and dropped IFLA_PROP_LIST from the list of attributes that follow the
>    nest, since it is emitted before it
> v1: https://lore.kernel.org/netdev/20260725132236.88318-1-iprintercanon@gmail.com/
> 
>  Documentation/netlink/specs/rt-link.yaml |  5 +++++
>  net/core/rtnetlink.c                     | 25 +++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 68c26a70bb649..b80c2ac3ac311 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -928,6 +928,11 @@ attribute-sets:
>          name: vfinfo-list
>          type: nest
>          nested-attributes: vfinfo-list-attrs
> +        doc: |
> +          Per-VF details. The list holds at most 256 VFs, or 128 when
> +          statistics are included, because it is one attribute and has to fit
> +          in a u16 length. A device with more VFs than that reports a
> +          truncated list; num-vf still carries the real count.
>        -
>          name: stats64
>          type: binary
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 31c65a545a107..6395ea6701210 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1174,12 +1174,30 @@ static void copy_rtnl_link_stats(struct rtnl_link_stats *a,
>  	a->rx_nohandler = b->rx_nohandler;
>  }
>  
> +/* IFLA_VFINFO_LIST is one netlink attribute, so everything nested inside it
> + * has to fit in the u16 nla_len. Bound the number of VFs described there at a
> + * fixed value rather than at whatever happens to fit, so that the limit is a
> + * property of the interface instead of one of the requested attribute set and
> + * the host's alignment requirements. The largest per-VF encoding is 368 bytes
> + * with statistics and GUIDs and 236 bytes without statistics, so both limits
> + * keep the nest well inside U16_MAX.
> + */
> +#define RTNL_VFINFO_MAX_VFS		256
> +#define RTNL_VFINFO_MAX_VFS_STATS	128

No strong opinion which to choose but I'd either move these defines
somewhere visible or just use the literal values. There's a common
fallacy that all literals must have defines, IMO if the literal is only
used once, by a small well scoped helper (here rtnl_vfinfo_max_vfs())
there's no ambiguity. The define is an extra indirection obfuscating
the code.

If you don't care either way either - I'd do the literal thing, and
let the comment describe the helper

> +static int rtnl_vfinfo_max_vfs(u32 ext_filter_mask)

if you pass the "real" num_vfs in here you can also subsume the min()
into the helper. Perhaps the helper should then be renamed s/_max/_cap/

> +{
> +	return ext_filter_mask & RTEXT_FILTER_SKIP_STATS ?
> +		RTNL_VFINFO_MAX_VFS : RTNL_VFINFO_MAX_VFS_STATS;
> +}

Other than that LGTM. Please send v3 as a new thread, not in reply to.

And FWIW (sorry, Im going to reply here to avoid splintering) I maintain
that net-next is better :) We are capping, who knows is someone
complains. So I _don't_ want this in LTS.
