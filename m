Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D355479868;
	Sun, 20 Sep 2026 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941360; cv=none; b=Z6G8bBt3hg0hEFb1GsnBGEZAmpChaRCUEpiMQ7N6qHQv7inLqWPmK3Kbj6fVkrfu1NxH7BdGkL26DszcjNr8QtX5Mza9RdVnuq7PhramUpO2zqtO4zuZZ0KiRM6VtMMw6aYwsSpF3gPjekTkxAvWeZkmIaxLWNMyuM8SjM/SNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941360; c=relaxed/simple;
	bh=jnjlhAO7JTD9Qr286Zr0u2xmysrHTrM6aVxmgFlnK0s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2xUsy003sVIPCX32J++UPQnvLSl6bR0cyQhnmoBrvMKke1ubz/jbTcu8FLjdTCGiHwXWS7XDl/NKf5ngyTHstT1T9PWuEjMzvYGf3Mjh26gXga+3GblVyRlInbAlVIRjLL7UT16FGMI7QYKUTYg1CIBi820We2yl0pvs3sZJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr8zSGNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr8zSGNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C671F000FF;
	Sun, 20 Sep 2026 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941353;
	bh=QRvXAkqYuBQsD2cNZg7XGTxIucykhgC8EeXr2IZ2NMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lr8zSGNQV0WIIb2svRRGk7P2rBs+9fC4L1jPEP+gb5LEFmM1Du9RlviQhuVC7HVGA
	 TEfRsYCDa4QNXa3j9IpSBTTEjf59QgAOt4tYy8YsiokzgmlGW0YZCqwqc2nzX2gvE+
	 pm7ew+HwxWgKsTp67NwiRCq8TwVhDBwI5fAE3xMz/k9l8Se19/0F0rDNVBjyd3NFF0
	 uoZPyrQIUNYqAfu6w/dRYt51f5lZTscgoMPXnrXwN09v+b7GPVa+jKhFFLRsLdpRsr
	 resAh8E14dvWZSbLB7l/d0g8aKUrXJPYifFoBj1I+dpRFFRzTkHYy8Osx2lfa0zMns
	 p2PY8K/9kySeg==
Subject: Re: [PATCH] fou: reject FOU_ENCAP_DIRECT with protocol 0 to prevent
 sk_buff leak
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:55:52 +0000
Message-ID: <178994135278.2160803.7705915349827245144@kernel.org>
In-Reply-To: <20260919215238.3471141-1-benquike@gmail.com>
References: <20260919215238.3471141-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new creation-only constraint `if (cfg->type ==
  FOU_ENCAP_DIRECT && !cfg->protocol) return -EINVAL;` was added to…
- [Medium] The changelog states the leak happens "When a FOU_ENCAP_DIRECT
  socket is configured with FOU_ATTR_IPPROTO == 0".
- [Medium] The `Fixes: 08d323234d10 ("net: fou: rename the source for
  linking")` tag points at a pure file-rename commit (Jakub Kicinski,…
- [Low] The patch makes FOU_ATTR_IPPROTO conditionally mandatory for
  FOU_CMD_ADD (required whenever FOU_ATTR_TYPE == FOU_ENCAP_DIRECT) but…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the patch
  entrenches the rule "protocol 0 is invalid" on the input side while…

--

fou: reject FOU_ENCAP_DIRECT with protocol 0 to prevent sk_buff leak

This adds two checks: fou_udp_recv() now drops packets when fou->protocol
is zero, and parse_nl_config() rejects a configuration that combines
FOU_ENCAP_DIRECT with protocol 0.  The goal is to avoid fou_udp_recv()
returning 0 to udp_queue_rcv_one_skb(), which consumes the skb without
freeing it.

No Link: tags are present in the commit header.

A few questions about the changelog first:

> When a FOU_ENCAP_DIRECT socket is configured with FOU_ATTR_IPPROTO == 0,
> every received packet returns 0 from fou_udp_recv() and leaks the sk_buff.

[Severity: Medium]
Is this the reachable trigger on the current tree?  The generated policy
in net/ipv4/fou_nl.c declares:

	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),

and min/max range checks run from validate_nla() for every present
attribute in both liberal and strict modes, so GENL_DONT_VALIDATE_STRICT
does not bypass them.  An explicitly supplied FOU_ATTR_IPPROTO of 0 would
be rejected with -ERANGE before parse_nl_config() is reached.

The case that does reach fou_create() with fou->protocol == 0 looks like
omitting FOU_ATTR_IPPROTO entirely while setting
FOU_ATTR_TYPE=FOU_ENCAP_DIRECT: parse_nl_config() memsets cfg and only
assigns cfg->protocol when the attribute is present.

Could the changelog be reworded to describe the omitted-attribute case?
That also changes which trees are affected, since the min:1 policy only
exists in newer trees.

> Fixes: 08d323234d10 ("net: fou: rename the source for linking")

[Severity: Medium]
Is this the right Fixes target?  08d323234d10 is a rename of
net/ipv4/fou.c to net/ipv4/fou_core.c with no functional change, so it
cannot have introduced the leak.  The "return -fou->protocol;" in
fou_udp_recv() and the absent FOU_ENCAP_DIRECT protocol validation both
predate it and come from 23461551c006 ("fou: Support for foo-over-udp RX
path").

With the current tag, stable tooling will limit the backport to v6.3 and
later, while older trees carry the same logic under net/ipv4/fou.c and
additionally lack the min:1 policy on FOU_ATTR_IPPROTO.

> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 5e867f1b5c1d..3fc087c808bc 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -77,6 +77,9 @@ static int fou_udp_recv(struct sock *sk, struct sk_buff *skb)
>  	if (!fou)
>  		return 1;
>  
> +	if (unlikely(!fou->protocol))
> +		goto drop;
> +
>  	if (fou_recv_pull(skb, fou, sizeof(struct udphdr)))
>  		goto drop;
>  
> @@ -696,6 +699,9 @@ static int parse_nl_config(struct genl_info *info,
>  	if (info->attrs[FOU_ATTR_TYPE])
>  		cfg->type = nla_get_u8(info->attrs[FOU_ATTR_TYPE]);
>  
> +	if (cfg->type == FOU_ENCAP_DIRECT && !cfg->protocol)
> +		return -EINVAL;
> +

[Severity: High]
Does this new check also break FOU_CMD_DEL and FOU_CMD_GET?
parse_nl_config() is the shared request parser for all three commands,
and all three propagate its error verbatim:

net/ipv4/fou_core.c:fou_nl_del_doit() {
	err = parse_nl_config(info, &cfg);
	if (err)
		return err;

	return fou_destroy(net, &cfg);
}

Only the add path consumes cfg->protocol and cfg->type; fou_create()
assigns fou->protocol in the FOU_ENCAP_DIRECT arm.  Delete and get select
the listener purely through fou_cfg_cmp():

net/ipv4/fou_core.c:fou_cfg_cmp() {
	if (fou->family != udp_cfg->family ||
	    fou->port != udp_cfg->local_udp_port ||
	    sk->sk_dport != udp_cfg->peer_udp_port ||
	    sk->sk_bound_dev_if != udp_cfg->bind_ifindex)
		return false;
	...
}

so neither type nor protocol participates in matching, and
Documentation/netlink/specs/fou.yaml describes del and get as selecting by
endpoint only.

Since fou_nl_policy is a global policy that contains FOU_ATTR_TYPE for
every op, and all ops set GENL_DONT_VALIDATE_STRICT, a FOU_CMD_DEL
carrying FOU_ATTR_PORT plus FOU_ATTR_TYPE=FOU_ENCAP_DIRECT and no
FOU_ATTR_IPPROTO is accepted by the netlink layer today and removes the
listener.  After this patch it returns -EINVAL before fou_destroy() runs,
so the udp tunnel socket stays alive.  FOU_CMD_GET has no
GENL_ADMIN_PERM, so unprivileged queries hit the same rejection.

Would it be better to place this check in fou_nl_add_doit() or in the
FOU_ENCAP_DIRECT arm of fou_create(), where the value is actually used?

[Severity: Low]
This isn't a bug, but the new rule makes FOU_ATTR_IPPROTO conditionally
mandatory for FOU_CMD_ADD without updating the in-tree ABI description or
reporting the missing attribute.  Documentation/netlink/specs/fou.yaml
still lists ipproto as an optional attribute with only:

      -
        name: ipproto
        type: u8
        checks:
          min: 1

Given that an explicit 0 is already rejected with -ERANGE, the only case
this code adds is a missing attribute, which the netlink guidelines ask to
be reported with NL_SET_ERR_ATTR_MISS(extack, FOU_ATTR_IPPROTO).  As
written the bare -EINVAL is indistinguishable from the other -EINVAL
returns in parse_nl_config() (missing FOU_ATTR_PEER_PORT, or
FOU_ATTR_IFINDEX without a local address).  Could the spec be updated and
an extack added?

[Severity: Low]
This is a pre-existing inconsistency and not something this patch
introduces, but the patch cements "protocol 0 is invalid" on the input
side while the reply side still advertises it.  fou_create() sets
fou->protocol only in the FOU_ENCAP_DIRECT arm, so it stays zero for
FOU_ENCAP_GUE, and fou_fill_info() emits it unconditionally:

net/ipv4/fou_core.c:fou_fill_info() {
	if (nla_put_u8(msg, FOU_ATTR_AF, sk->sk_family) ||
	    ...
	    nla_put_u8(msg, FOU_ATTR_IPPROTO, fou->protocol) ||
	...
}

So a FOU_CMD_GET reply or dump for a GUE listener reports ipproto=0, a
value the same attribute definition (min:1) refuses on input.  Should the
attribute be omitted for GUE sockets, or the spec annotated to allow 0 on
replies?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215238.3471141-1-benquike%40gmail.com
