Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618720;
	b=foHHy1Yqvz2mzxQt1SE2nqW6h1JhL5uVwTnmYE0sS0hSG4zzriCTcAT4Va17bsHzdS9c
	 FtJd2GRkSzNzWrNI4G0F3XhpW7+0909PKokMuOejW2wzt1dzCL6umHriTdMQdEKmCFGQZ
	 YgIt1gRcTYEkL4gv7t/Dq87guDBQM4+ytPdwo34aJTjuisgW8YUxXjKqUcAnFvsbO3jno
	 Tp0GQr8JqLdjg21t07AUKHiEs+rj0/9DUlPCDCImCcwaG5m0DiMcWXuzXIQjUHiHmcb+R
	 3R/J6oNOzHblKWJRjBd4VBuJj34XMb/OMfh3MQndJNqyfpf8zJZ0TP4ifYmwfDz4x/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618720;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=enzCf+rj+UxcaGkFPnVJnsh77lRtc2KO0fo2Cm3ge8o=;
	b=a6Jv+AKpIRwvi4u3oaSYQVO09eDaEktFot6bcPjmDvfYA/hS0T9TYIxKY33sSVKlULGi
	 bgpk+/pLEzfDZy3fBl7M+M5vTV42JKurAKV+J/51lwFKZJaX7OOpW+q/91wQaPbR8fNSt
	 8nG8RG0wlg8AOIsGYIdRTO372+D+Ulz8YtIo4TmdnVcqFm7nDY8O+tiaVJG52gTXyUhIW
	 zCwTputTRb7IXoWtRNoiC/S4CVaoQ0HVT1kptmfLoCuDcsF1VdVbUb3XwQIKAwV8FBm2f
	 UhJDsHr1mfOP+PoLB3LpmGS1LJb5sBpdvS/HuCYmUZcBL3bb0Y8Yj0Pe0ki/F1g0Bvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNtOBOfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2F606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNtOBOfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206A21F000C1;
	Wed, 21 Oct 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618719;
	bh=enzCf+rj+UxcaGkFPnVJnsh77lRtc2KO0fo2Cm3ge8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNtOBOfCPOpBdBLe+IcERDbSuvRzLhu94Lqc7Lhi51Faw1jOrU5gpr2F1X6WSDcJ6
	 Mx13bf+Jz+BMnyEHvuB5yf1em+fQdHQyLH9jz22d4ddAllQk/msCKlVE9Lgu2/WnuX
	 dZkod5fBJJoDjkIK78okFMh9tWsaB7x/pqC4snrw57mD6OrW77iai2h3nOYUoDk/uI
	 LULa9Tqv0gsuvCf+85rY5JhNzS+OMsf7cGQKI64sivZ2Di44eytp95yeS0OfziqtIj
	 kB8zJnNhAgLKDckzZMTorrswoT2nc/X++RJApmxwRLXwiAA5ClWZnj/q8EktkbMCrr
	 wK6TqeZdjvKfw==
Subject:
 Re: [PATCH net-next] netlink: specs: Add a spec for nexthops in rtnetlink
From: netdev-bot+sashiko@kernel.org
To: demosthenes.ra@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, dsahern@kernel.org,
 idosch@nvidia.com, horms@kernel.org, netdev@vger.kernel.org
Date: Wed, 21 Oct 2026 21:38:38 +0000
Message-ID: <179261871862.3135.17495304986227666332@kernel.org>
In-Reply-To: <20261019-rt-nexthop-spec-v1-1-9c586edf86ab@gmail.com>
References: <20261019-rt-nexthop-spec-v1-1-9c586edf86ab@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds `YNL_GEN_ARG_rt-nexthop:=--exclude-op
  newnexthopbucket-ntf` to tools/net/ynl/generated/Makefile.

--

netlink: specs: Add a spec for nexthops in rtnetlink

This commit adds a YNL netlink-raw spec for rtnetlink nexthop objects and
nexthop buckets, adds it to MAINTAINERS, and wires it into the YNL C build.
Because ynl_gen_c.py cannot match newnexthopbucket-ntf to a request, that
notification is left out of the C code generation.

> diff --git a/Documentation/netlink/specs/rt-nexthop.yaml b/Documentation/netlink/specs/rt-nexthop.yaml
> new file mode 100644
> index 0000000000000..06c28fa7d2fb6
> --- /dev/null
> +++ b/Documentation/netlink/specs/rt-nexthop.yaml
> @@ -0,0 +1,761 @@

[ ... ]

> +    -
> +      name: newnexthopbucket-ntf
> +      doc: Notification about a created nexthop bucket.
> +      value: 116
> +      notify: getnexthopbucket
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: rtnlgrp-nexthop
> +      value: 32

[ ... ]

> diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
> index 5a186349b5a86..d76d4ca946290 100644
> --- a/tools/net/ynl/generated/Makefile
> +++ b/tools/net/ynl/generated/Makefile
> @@ -18,6 +18,7 @@ include ../Makefile.deps
>  
>  YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
>  	--exclude-op stats-get
> +YNL_GEN_ARG_rt-nexthop:=--exclude-op newnexthopbucket-ntf

[Severity: Medium]
Will C users of the generated rt-nexthop family get parse errors when an
RTM_NEWNEXTHOPBUCKET notification arrives?

The rtnlgrp-nexthop group still carries these messages. The kernel sends
them from nexthop_bucket_notify() in net/ipv4/nexthop.c:

net/ipv4/nexthop.c:nexthop_bucket_notify() {
    ...
	err = nh_fill_res_bucket(skb, nh, bucket, bucket_index,
				 RTM_NEWNEXTHOPBUCKET, 0, 0, NLM_F_REPLACE,
				 NULL);
    ...
	rtnl_notify(skb, nh->net, 0, RTNLGRP_NEXTHOP, NULL, GFP_KERNEL);
}

This runs whenever notify_nl is set, and that includes the periodic upkeep
work for resilient groups:

nh_res_table_upkeep_dw()
  nh_res_table_upkeep(res_table, true, true)
    nh_res_bucket_migrate()
      nexthop_bucket_notify()

With newnexthopbucket-ntf excluded, render_user_family() only emits
ntf_info entries for RTM_NEWNEXTHOP and RTM_DELNEXTHOP. That makes
ntf_info_size 106, so a type 116 message fails in ynl_ntf_parse():

tools/net/ynl/lib/ynl.c:ynl_ntf_parse() {
    ...
	if (cmd >= ys->family->ntf_info_size)
		return YNL_PARSE_CB_ERROR;
    ...
}

No error message is set. __ynl_sock_read_msgs() then skips the rest of the
receive buffer, and ynl_ntf_check() returns an error.

ynl_check_alien() reaches the same code for classic families:

	if (ys->family->is_classic) {
		if (nlh->nlmsg_type != rsp_cmd)
			return ynl_ntf_parse(ys, nlh);

So a bucket notification that arrives during a getnexthop do or dump on a
subscribed socket would fail the whole request.

Two things limit the impact. ynl_subscribe() doesn't handle classic
families, so a C program has to join RTNLGRP_NEXTHOP by hand with
NETLINK_ADD_MEMBERSHIP on ynl_socket_get_fd(). Also, rt-link.yaml has a
similar gap: it only defines newlink-ntf, but rtnlgrp-link also carries
RTM_DELLINK.

The commit message describes the exclusion only as a codegen workaround:

    ynl_gen_c.py looks up a classic notification by the request of the
    same message type, and no request uses RTM_NEWNEXTHOPBUCKET.

It doesn't mention this runtime effect.

Would the alternative offered below the --- line avoid the problem? That
is, teach _render_user_ntf_entry() in ynl_gen_c.py to handle a classic
notification with no matching request. The lookup that needs the
exclusion is:

	crud_op = ri.family.req_by_value[op.rsp_value]

Handling this case would keep the RTM_NEWNEXTHOPBUCKET entry in the
ntf_info table.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-rt-nexthop-spec-v1-1-9c586edf86ab%40gmail.com
