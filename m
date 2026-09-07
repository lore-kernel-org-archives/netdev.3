Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAD48CD72
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808467; cv=none; b=kME7dP+q5mJJxUGX2x6mxY8py2CjAS+pYsdt4pKuI5fapVyDpTbSbC1jPkkLbGQQGRvBj4X4sZe0BFFHJ65q7MjglxiGc1ebK4QI/aellJdpY7s57cDVcHW4yjoO8pvIsyzxg0LsiURjrGExVryDegC7NtNu7OuP+C7Fu7lF/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808467; c=relaxed/simple;
	bh=YUn3bZxbx8eNXmQObUDFKTAdi+IpDOvpl6ArCXbhqaY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mi4yJxuJcqI8j6ehmKJNoimVCl2oUR8oEwq4CV3WWHrTwN6VZR87M40OPULvTJ5VMBG0PTgBke+Jj5fqACGow6cl4qEVkWpRppW/V0aXj/RqxsUn2BOIA1Z2edww83Uh57NDimHyJx1AYzWHHemtDKCxx1LbqExuM2pio2HRj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxn5G1J0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxn5G1J0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE461F00A3D;
	Mon,  7 Sep 2026 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788808465;
	bh=ytk14hzY3jSiZlVYYiUkjp0GqfWGyDc/i9es8X0IzPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxn5G1J0Yp+P5GP8XzeBjf1m4E0A4n7a188vZSFL8Xv0yA+QcU1TpzmEo7Ijc1cdy
	 QfpBtxir1kBe+zoCy4+ZrbJeYgSqqZrXbuoVQvSmedHDY3lFBMQYHVcDyDgPx7Oyie
	 a+jqn1aIepbS2q7cMMQe4pGDN26D9pYCJ5en03uoIDsytNKnDGpFhZQQbpa2XR40CS
	 1hEv2L+n02TriqRiHiKes7REqy7GOZceWFx5Ce4KDfKuEyuBYhMwOGOHbq3H1HPsCP
	 /cnmKNbr6yg8mXSVK6dxtBOwFr3MvrwZQt7Z3/dJ4U8l3QCGGU+yL/42e7iTu/L1MG
	 Uom4QRxvqrCkg==
Subject: Re: [PATCH net-next 2/3] netlink: specs: fou: local-v4 and peer-v4
 are big endian
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, kuniyu@google.com
Date: Mon, 07 Sep 2026 19:14:24 +0000
Message-ID: <178880846466.219967.3542374542122357419@kernel.org>
In-Reply-To: <20260904191412.3872344-3-kuba@kernel.org>
References: <20260904191412.3872344-3-kuba@kernel.org>
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

- [Medium] Switching `FOU_ATTR_LOCAL_V4` / `FOU_ATTR_PEER_V4` from
  `NLA_U32` to `NLA_BE32` in `fou_nl_policy[]` (net/ipv4/fou_nl.c:21,23)…
- [Low] The patch fixes a real, user-visible YNL byte-order defect
  (missing `byte-order: big-endian` on fou's `local-v4`/`peer-v4`) but…

--

netlink: specs: fou: local-v4 and peer-v4 are big endian

This adds byte-order: big-endian to the local-v4 and peer-v4 attributes in
the fou netlink spec, since fou_core.c treats both as __be32 via
nla_get_in_addr() / nla_put_in_addr(). The regenerated policy in
net/ipv4/fou_nl.c changes the two entries from NLA_U32 to NLA_BE32.

No Link: tags present in the commit header.

> diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
> index 32d34be1dc63a..1d0db6ba7e52b 100644
> --- a/Documentation/netlink/specs/fou.yaml
> +++ b/Documentation/netlink/specs/fou.yaml
> @@ -50,6 +50,7 @@ attribute-sets:
>        -
>          name: local-v4
>          type: u32
> +        byte-order: big-endian
>        -
>          name: local-v6
>          type: binary
> @@ -58,6 +59,7 @@ attribute-sets:
>        -
>          name: peer-v4
>          type: u32
> +        byte-order: big-endian
>        -
>          name: peer-v6
>          type: binary

[Severity: Low]
Should this carry a Fixes: tag?  The commit message describes a
user-visible YNL defect ("Without byte-order YNL swaps them on little
endian hosts"), and the annotations were missing from the moment the spec
was added by commit 4eb77b4ecd3c ("netlink: add a proto specification for
FOU").

The kernel side has always treated both as network-order addresses:

net/ipv4/fou_core.c:parse_nl_config() {
	...
		cfg->udp_config.local_ip.s_addr = nla_get_in_addr(attr);
	...
}

net/ipv4/fou_core.c:fou_fill_info() {
	...
		if (nla_put_in_addr(msg, FOU_ATTR_LOCAL_V4, sk->sk_rcv_saddr))
	...
}

so a ynl client on a little-endian host configures and displays a reversed
address.  Would adding:

	Fixes: 4eb77b4ecd3c ("netlink: add a proto specification for FOU")

let backport tooling pick this up?

> diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
> index 309d5ba983d04..cdb174b92cdd2 100644
> --- a/net/ipv4/fou_nl.c
> +++ b/net/ipv4/fou_nl.c
> @@ -18,9 +18,9 @@ const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
>  	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
>  	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
>  	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
> -	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
> +	[FOU_ATTR_LOCAL_V4] = { .type = NLA_BE32, },
>  	[FOU_ATTR_LOCAL_V6] = NLA_POLICY_EXACT_LEN(16),
> -	[FOU_ATTR_PEER_V4] = { .type = NLA_U32, },
> +	[FOU_ATTR_PEER_V4] = { .type = NLA_BE32, },

[Severity: Medium]
The commit message says the policy change "changes nothing".  Is that
accurate for policy introspection as well as for validation?

The validation claim holds: nla_attr_len[] in lib/nlattr.c gives NLA_BE32
and NLA_U32 the same length, the range handling is shared, and neither
attribute has a range check.

But the policy dump has no NLA_BE16/NLA_BE32 arm, so NLA_BE32 lands in the
default case that is shared with NLA_UNSPEC and NLA_REJECT:

net/netlink/policy.c:__netlink_policy_dump_write_attr() {
	...
	switch (pt->type) {
	default:
	case NLA_UNSPEC:
	case NLA_REJECT:
		/* skip - use NLA_MIN_LEN to advertise such */
		nla_nest_cancel(skb, attr);
		return -ENODATA;
	...
}

and the caller turns -ENODATA into "skip this attribute":

net/netlink/policy.c:netlink_policy_dump_write() {
	...
	err = __netlink_policy_dump_write_attr(state, skb, pt, state->attr_idx);
	if (err == -ENODATA) {
		nla_nest_cancel(skb, policy);
		again = true;
		goto next;
	}
	...
}

fou registers fou_nl_policy family-wide (.policy = fou_nl_policy in
fou_nl_family), so this is the policy exported through CTRL_CMD_GETPOLICY.
Does that mean FOU_ATTR_LOCAL_V4 and FOU_ATTR_PEER_V4 disappear from the
policy dump, where they previously showed up as NL_ATTR_TYPE_U32 with a
0..U32_MAX range?

Tooling that feature-probes attributes via the policy dump (ynl, the
wireshark netlink dissector) would then see them as absent.  FOU_ATTR_PORT
and FOU_ATTR_PEER_PORT already have the same problem as NLA_BE16, so would
it make sense to add NLA_BE16/NLA_BE32 cases to
__netlink_policy_dump_write_attr(), or at least to mention this in the
changelog instead of "changes nothing"?

>  	[FOU_ATTR_PEER_V6] = NLA_POLICY_EXACT_LEN(16),
>  	[FOU_ATTR_PEER_PORT] = { .type = NLA_BE16, },
>  	[FOU_ATTR_IFINDEX] = { .type = NLA_S32, },

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904191412.3872344-1-kuba%40kernel.org
