Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803139022A;
	Mon, 12 Oct 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831307; cv=none; b=mLAPVwkhkby5SQuqByhA8O9wp72I2d24xnCiDpoe0Rmap2zNapMigzOrIqLRUA3SQPN4zG8slfyoiRdCqY6T663LG4oYKnmazBYsXv7pFZ/erdyI+BwLVEVdmMYnPwXnB30sEfMpPYXJtkuOhSBmkwxM2VIM8ItZ5N60qBXKqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831307; c=relaxed/simple;
	bh=mn54VEFSO9BYGS9DJrNKynPu0E3YTdfhj48FM7wXe+c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEPg45FnI35daafq6HalYcN9yFgkfNMGek73An//pJR8Y0SMVi1APjUYLUEAVkNc1U2IW5CVdJe5PkWhcZv4+LrtN0lDTKF6cKjIukoPTzgOgePL2Dazxers4PDYhgRgAli++qbb1VrkfsHieBkrSrXcw9v1FV2EfjdBRL209FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsQD45KZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsQD45KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1C51F008A3;
	Mon, 12 Oct 2026 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831305;
	bh=FWf8BEPAafAqioNWSHTG/VKLEJntaaSOQcfM4GN5d9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XsQD45KZxxd55koTO/Gr5WMjNTXladhUvZ8zTtj4qZk33NTHxS6kr7of9ODvUMZTk
	 EDt1f2J0uXPn4+jPFZuBN4uOYICGVmbHUCcEnb+NFNnQq6LsPGExXn2gTGJOXLROe2
	 VWrrSXoKe8wZdy12u7xe09zzu/Dx5VDSOE/rO4Ttqp/C25p7CRChUhr32y6FJOM6yP
	 guKoI8msYPMdRtqZsoagUnOziyPI5o3YC9PZkuQ8VsQSONeLgSLw1TK7loYKJxNULa
	 LHOsMCrOiUJ8mfqqzG1aZ9I93ryMoRrwYNwpTqXMuY/P7eWqm7Wm/iVFpmMK4CuPoB
	 JuZCZJHpwpKLw==
Subject:
 Re: [PATCH net-next v2 2/3] netlink: specs: add genetlink-legacy spec for GTP
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: pablo@netfilter.org, laforge@gnumonks.org, donald.hunter@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 18:55:04 +0000
Message-ID: <179183130475.434549.3854225855048467985@kernel.org>
In-Reply-To: <20261008181031.4129029-3-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-3-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The echoreq request attribute list in
  Documentation/netlink/specs/gtp.yaml (lines 159-165: link, version,…
- [Medium] The getpdp reply attribute list (&pdp-reply,
  Documentation/netlink/specs/gtp.yaml lines 138-149), which the dump…
- [Medium] The spec declares the 'gtp' multicast group
  (Documentation/netlink/specs/gtp.yaml lines 167-170) but describes no…
- [Medium] Adding Documentation/netlink/specs/gtp.yaml makes
  tools/net/ynl/generated/Makefile generate and compile gtp-user.c/gtp-…
- [Low] peer-addr6 and ms-addr6 are declared in
  Documentation/netlink/specs/gtp.yaml with `checks: exact-len: 16`…
- [Low] delpdp in Documentation/netlink/specs/gtp.yaml (line 120,
  `request: *pdp-attrs`) reuses the full newpdp request list, so it…

--

netlink: specs: add genetlink-legacy spec for GTP

This commit adds a genetlink-legacy YAML spec for the existing GTP generic
netlink family. It covers the NEWPDP, DELPDP, GETPDP and ECHOREQ commands,
the GTPA_* attribute set and the "gtp" multicast group. It also adds the
spec to the GTP entry in MAINTAINERS.

> diff --git a/Documentation/netlink/specs/gtp.yaml b/Documentation/netlink/specs/gtp.yaml
> new file mode 100644
> index 0000000000000..7193f5e53a257
> --- /dev/null
> +++ b/Documentation/netlink/specs/gtp.yaml
> @@ -0,0 +1,170 @@

[ ... ]

> +      -
> +        name: peer-addr6
> +        type: binary
> +        checks:
> +          exact-len: 16
> +        byte-order: big-endian
> +        display-hint: ipv6
> +        doc: IPv6 address of the remote GSN peer (GGSN or SGSN).
> +      -
> +        name: ms-addr6
> +        type: binary
> +        checks:
> +          exact-len: 16
> +        byte-order: big-endian
> +        display-hint: ipv6
> +        doc: IPv6 address of the mobile subscriber served by the context.

[Severity: Low]
Does exact-len: 16 match what the kernel accepts for these two attributes?
In gtp_genl_policy in drivers/net/gtp.c they have no type:

	[GTPA_PEER_ADDR6]	= { .len = sizeof(struct in6_addr), },
	[GTPA_MS_ADDR6]		= { .len = sizeof(struct in6_addr), },

That makes them NLA_UNSPEC. With the family's liberal validation, .len is
a minimum length, so the kernel accepts longer payloads and
nla_get_in6_addr() reads the first 16 bytes.

ynl_gen_c.py turns exact-len into NLA_POLICY_EXACT_LEN(). A policy
generated from this spec would therefore reject input the kernel accepts
today.

For the same .len = sizeof(struct in6_addr) pattern, mptcp_pm.yaml,
nfsd.yaml and wireguard.yaml use min-len: 16. Should these two use min-len
as well?

> +      -
> +        name: family
> +        type: u8
> +        doc: Address family (AF_INET or AF_INET6) of the context addresses.

[Severity: Medium]
With this spec in place, tools/net/ynl/generated/Makefile will start
generating and compiling gtp-user.c. That Makefile picks up every spec
via SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml), and GENS_UNSUP only
excludes conntrack and nftables.

The compile uses -idirafter $(UAPI_PATH), so #include <linux/gtp.h> finds
the build host's /usr/include/linux/gtp.h before the in-tree uAPI header.
The generated tables use GTPA_PEER_ADDR6, GTPA_MS_ADDR6, GTPA_FAMILY and
GTP_CMD_ECHOREQ.

Older installed kernel headers (for example 6.1-era distro headers) don't
define these identifiers. On such hosts, would make -C tools/net/ynl fail
to build gtp-user.o?

Other families with recent uAPI additions (ovpn, psp, wireguard, ovs_*,
mptcp_pm and others) force the in-tree header in
tools/net/ynl/Makefile.deps. Does gtp need a similar entry, like this:

CFLAGS_gtp:=$(call get_hdr_inc,_LINUX_GTP_H_,gtp.h)

> +
> +operations:
> +  list:

[ ... ]

> +    -
> +      name: delpdp
> +      doc: Delete a PDP context.
> +      attribute-set: gtp
> +      dont-validate: [strict, dump]
> +      flags: [admin-perm]
> +      do:
> +        request: *pdp-attrs

[Severity: Low]
Is reusing the full newpdp request list correct for delpdp?

gtp_genl_del_pdp() only checks GTPA_VERSION, then calls
gtp_find_pdp()->gtp_find_pdp_by_link(). That lookup reads only LINK,
NET_NS_FD (through gtp_find_dev()), FAMILY, MS_ADDRESS, MS_ADDR6, VERSION,
TID and I_TEI.

The kernel silently ignores peer-address, peer-addr6, flow and o-tei on
delete. Listing them here suggests in the spec, generated docs and
generated C API that they help pick which context gets deleted.

The getpdp request list below matches the lookup. Could delpdp use that
list instead?

> +    -
> +      name: getpdp
> +      doc: Get or dump one or more PDP contexts.

[ ... ]

> +        reply: &pdp-reply
> +          attributes:
> +            - version
> +            - tid
> +            - peer-address
> +            - peer-addr6
> +            - ms-address
> +            - ms-addr6
> +            - flow
> +            - i-tei
> +            - o-tei
> +            - family
> +      dump:
> +        reply: *pdp-reply

[Severity: Medium]
Should link be in this reply list? gtp_genl_fill_info() always emits it:

	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
	    nla_put_u8(skb, GTPA_FAMILY, pctx->af))
		goto nla_put_failure;

That layout is used for GETPDP replies, for dump entries and for the
NEWPDP/DELPDP notifications. ynl-gen-c builds reply structs and parsers
only from the listed attributes, so generated C clients will drop the
ifindex.

gtp_genl_dump_pdp() walks every gtp netdevice in the namespace. The
per-message GTPA_LINK is the only way to tell which device a dumped
context belongs to.

> +    -
> +      name: echoreq
> +      doc: Send a GTP-U echo request to a peer.
> +      attribute-set: gtp
> +      dont-validate: [strict, dump]
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - link
> +            - version
> +            - peer-address
> +            - peer-addr6
> +            - family

[Severity: Medium]
This list doesn't seem to match gtp_genl_send_echo_req(), which requires
ms-address:

	if (!info->attrs[GTPA_VERSION] ||
	    !info->attrs[GTPA_LINK] ||
	    !info->attrs[GTPA_PEER_ADDRESS] ||
	    !info->attrs[GTPA_MS_ADDRESS])
		return -EINVAL;
	...
	src_ip = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);

ynl-gen-c only generates setters for the attributes listed for the op, so
a generated C client has no way to send ms-address. Would every echoreq
from such a client fail with -EINVAL?

The handler is also IPv4-only. It uses ip4_route_output_gtp() and an IPv4
udp_tunnel_xmit_skb(), and it never reads GTPA_PEER_ADDR6 or GTPA_FAMILY.
Should peer-addr6 and family be dropped from this list?

net-ns-fd is not listed either, but gtp_find_dev() honours it when
resolving GTPA_LINK for this command:

	if (nla[GTPA_NET_NS_FD])
		net = get_net_ns_by_fd(nla_get_u32(nla[GTPA_NET_NS_FD]));

Finally, the ms-address doc reads "IPv4 address of the mobile subscriber
served by the context". For echoreq the value is used as the local source
address of the echo request instead.

> +
> +mcast-groups:
> +  list:
> +    -
> +      name: gtp

[Severity: Medium]
The gtp multicast group is declared, but no operation has notify:, event:
or mcgrp:. Where are the messages the kernel multicasts on this group
described?

The kernel sends three kinds of message on GTP_GENL_MCGRP:

  gtp_genl_new_pdp()->gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, ...)
  gtp_genl_del_pdp()->gtp_tunnel_notify(pctx, GTP_CMD_DELPDP, ...)
  gtp0_handle_echo_resp() / gtp1u_handle_echo_resp()
      ->gtp_genl_fill_echo(msg, 0, 0, 0, GTP_CMD_ECHOREQ, echo)

The first two use the gtp_genl_fill_info() layout. The echo responses
carry version, peer-address and ms-address.

In tools/net/ynl/pyynl/lib/ynl.py, pyynl only accepts notifications whose
IDs are in async_msg_ids. YnlFamily.__init__() fills that set only from
async ops.

A ynl client that subscribes to gtp would therefore drop each of these
messages with "Unexpected msg id while checking for ntf". C codegen also
won't produce any notification parsers.

Echo responses only arrive through this multicast. Can a spec-based client
send echoreq but never see the result?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008181031.4129029-1-anilkaushikwireless%40gmail.com
