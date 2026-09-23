Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E257C70C;
	Wed, 23 Sep 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177526; cv=none; b=VSlBUFioksPR3NDvngAKF0/xhSN3hMbQD19EzMNOVII8reAHArwS2taIh7qlow3AKDOroWdFgWSjwZ0uguZTT5STfHm6G2a/A19G/k7Jl5EsNumf4ZiTqn/BIaUMNXWnfQhXfy8R/nZ7p1QvOd1g1lK9VHK/8eMnz++Dc/zWhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177526; c=relaxed/simple;
	bh=VTKGwo6LoVGstSXXjlbhVu+SDOuyIzugKyGt27rL1O8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxNFcLSseeF7xeNSH8rGx8oK7Lj37bcpZQF5ZaLpAEFIQjK9qBtfX/jWpQLCrTt7pwYsJOlZby+1bYcSL5GclzOHKAM1TYFvNrQDLpncVzVtV4y+3ZNX/mq+KGAOM4DkWohHb+VaShaxWJnrmheA70kqsnuO0wVSFDkg9TiXqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOJVYqOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOJVYqOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8C21F00898;
	Wed, 23 Sep 2026 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177520;
	bh=AsmHmr4Wa7aVFd4oyPu7QduJaGJGRGUqPmIIMvb1cvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EOJVYqOQvcSX+MBdvX7/XIlTHobRhcz/c2v/Bpor3lXPUhC85BDRnGAEfKxT3tqbI
	 asSH/qq0bceZrmvR2Jp+QElhD4iN+Nrr+0ihPARyuxEdPdglJiEzC26m3a54lhcEmi
	 pETAWRX/y+q77LmDftO90LKHTU1UX8JShIV05xhvOaojFjtdVyzajL9oLq0UL21dYH
	 djPnP9rO/NelmVv5Hqf/jgNlX6JJCoy7jsX6Vysgk5XnGBZcQ2brAhGiB+t9IbBbAn
	 6rMOV/hhh8IiKcBAtX9BDKXSmvtEufv/PYBpdvQXxPEs3KYlBAuhYVVCdbltt5t+M4
	 GrwmJqGXrVPPA==
Subject: Re: [PATCH] tipc: fix TLV out-of-bounds read in
 tipc_nl_compat_net_set() and depth mask
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:31:59 +0000
Message-ID: <179017751912.2160803.802056507685231815@kernel.org>
In-Reply-To: <20260919212857.3241483-1-benquike@gmail.com>
References: <20260919212857.3241483-1-benquike@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message mischaracterizes the code it changes.
- [Medium] The new mask introduces a header/row mismatch for a request
  whose depth field is exactly TIPC_NTQ_ALLTYPES (0x80000000, flag set…
- [Low] Two unrelated fixes with two different Fixes: tags are bundled in
  one commit.

Pre-existing issues:
- [Medium] When TIPC_NTQ_ALLTYPES is set,
  tipc_nl_compat_name_table_dump() only bypasses the type comparison…

--

tipc: fix TLV out-of-bounds read in tipc_nl_compat_net_set() and depth mask

This adds a missing TLV payload length check in tipc_nl_compat_net_set()
before dereferencing the request payload as a __be32, and masks
TIPC_NTQ_ALLTYPES out of the display depth in
tipc_nl_compat_name_table_dump_header() and
tipc_nl_compat_name_table_dump().

A few questions below about the commit message and about the masking hunks.

[Severity: Medium]
The commit message says:

    `tipc_nl_compat_name_table_dump()` checks `depth > 1` and `depth > 2`
    with `TIPC_NTQ_ALLTYPES` still set in `depth`

Is that description accurate?  tipc_nl_compat_name_table_dump() uses
equality tests, not greater-than tests:

	if (depth == 1)
		goto out;
	...
	if (depth == 2)
		goto out;
	...
	if (depth == 3)
		goto out;

With TIPC_NTQ_ALLTYPES set, none of those equality tests matched before
this patch, so all four columns were printed, which agreed with the
header path where 0x80000000 > 4 clamped the title count to four.

Given that, isn't the real effect of the masking hunks to start honouring
the low depth bits for ALLTYPES requests, that is, to print fewer columns
than before (depth = TIPC_NTQ_ALLTYPES | 1 now yields one column instead
of four)?  Could the changelog describe that behaviour change instead?

The message also calls both changes "validation flaws".  In
tipc_nl_compat_name_table_dump_header() the header[] array is only indexed
after the clamp:

	if (depth > 4)
		depth = 4;
	for (i = 0; i < depth; i++)
		tipc_tlv_sprintf(msg->rep, header[i]);

so there is no out-of-bounds access in that path.  Should the depth-mask
part be described as an output formatting change rather than a validation
or memory-safety fix?

> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index d9a4f94ea2d4..9b2d93704e23 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -881,7 +881,7 @@ static int tipc_nl_compat_name_table_dump_header(struct tipc_nl_compat_msg *msg)
>  	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(struct tipc_name_table_query))
>  		return -EINVAL;
>  
> -	depth = ntohl(ntq->depth);
> +	depth = ntohl(ntq->depth) & ~TIPC_NTQ_ALLTYPES;
>  
>  	if (depth > 4)
>  		depth = 4;

[Severity: Medium]
What happens for a request whose depth field is exactly TIPC_NTQ_ALLTYPES,
that is the flag bit set and all low depth bits zero?

In tipc_nl_compat_name_table_dump_header() the masked depth becomes 0, so
the clamp does not trigger, the title loop body never runs, and only "\n"
is emitted:

	depth = ntohl(ntq->depth) & ~TIPC_NTQ_ALLTYPES;	/* 0 */

	if (depth > 4)					/* false */
		depth = 4;
	for (i = 0; i < depth; i++)			/* no iterations */
		tipc_tlv_sprintf(msg->rep, header[i]);
	tipc_tlv_sprintf(msg->rep, "\n");

Meanwhile the row formatter below stops only on depth == 1, 2 or 3, none
of which match 0, so every publication still prints all four columns.
Does that leave the report with an empty header line followed by
four-column rows?

Before this patch the same request was self-consistent: 0x80000000 > 4
clamped the header to four titles and the rows printed four columns.

The legacy implementation that this code replaced handled depth 0
explicitly, in nametbl_list() in net/tipc/name_table.c before commit
44a8ae94fd55:

	depth = (depth_info & ~TIPC_NTQ_ALLTYPES);
	if (depth == 0)
		return 0;

Would it make sense to normalise or reject a masked depth of 0 here, or to
have the row formatter use the same clamp semantics as the header?

> @@ -932,6 +932,7 @@ static int tipc_nl_compat_name_table_dump(struct tipc_nl_compat_msg *msg,
>  	if (!(depth & TIPC_NTQ_ALLTYPES) &&
>  	    (type != nla_get_u32(publ[TIPC_NLA_PUBL_TYPE])))
>  		return 0;
> +	depth &= ~TIPC_NTQ_ALLTYPES;
>  	if (lowbound && (lowbound > nla_get_u32(publ[TIPC_NLA_PUBL_UPPER])))
>  		return 0;
>  	if (upbound && (upbound < nla_get_u32(publ[TIPC_NLA_PUBL_LOWER])))
>  		return 0;

[Severity: Medium]
This is a pre-existing issue and not something introduced by this patch,
but since the new mask lands directly above these two bounds checks it
seems worth raising.

TIPC_NTQ_ALLTYPES only bypasses the type comparison; the lowbound and
upbound filters still run, so publications get dropped from an "all types"
dump.  The uAPI contract in include/uapi/linux/tipc_config.h says all
three selectors are ignored when the high depth bit is set:

	__be32 type;	/* {t,l,u} info ignored if high bit of "depth" is set */
	__be32 lowbound; /* (i.e. displays all entries of name table) */
	__be32 upbound;

With depth = TIPC_NTQ_ALLTYPES | 1 and lowbound = 200, does

	if (lowbound && (lowbound > nla_get_u32(publ[TIPC_NLA_PUBL_UPPER])))
		return 0;

still skip every publication whose upper bound is below 200, even though
lowbound should be irrelevant for that request?

The legacy code enforced this, in nametbl_list() before commit
44a8ae94fd55:

	if (all_types) {
		...
		lowbound = 0;
		upbound = ~0;
		...
	}

Should the lowbound/upbound tests be gated on the ALLTYPES flag as well?

> @@ -1139,6 +1140,9 @@ static int tipc_nl_compat_net_set(struct tipc_nl_compat_cmd_doit *cmd,
>  	u32 val;
>  	struct nlattr *net;
>  
> +	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(__be32))
> +		return -EINVAL;
> +
>  	val = ntohl(*(__be32 *)TLV_DATA(msg->req));

[Severity: Low]
Could this be split into two patches?

This hunk is the out-of-bounds read fix in tipc_nl_compat_net_set(), where
only TLV_CHECK_TYPE() ran before it from tipc_nl_compat_doit(), and it
matches Fixes: d7cc75d3cb6b.  The two earlier hunks only change how
TIPC_NTQ_ALLTYPES is masked out of the display depth for
TIPC_CMD_SHOW_NAME_TABLE and match Fixes: 44a8ae94fd55.

The two changes touch disjoint commands: TIPC_CMD_SET_NODE_ADDR and
TIPC_CMD_SET_NETID versus TIPC_CMD_SHOW_NAME_TABLE.  Splitting them would
let the memory-safety fix be backported and reverted independently of the
output format change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212857.3241483-1-benquike%40gmail.com
