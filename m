Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608080;
	b=o8TxYaRJykbTYSa67/MkVx2ycapwmkZpOuocv/0bihBjwAS/RsqtZKRAfXVLuQx6Hw0D
	 wtBAgMf6eCfKeaIvbbWZZETvmMuQWrikc8kvpBzfO7HKdJ0mM2YxZ4hzcsSefF/RpCBIO
	 m2sjhanG6ap5oXGkEA9HZodA7TI2u2qHUA4LTjHGuUEv/DP9n/FlaoD1pt5b1xcDCEtSl
	 d/8XLUk/I24tTd9x2Bqzk/uVFhHLE8ET4SS4wFE0JmDQdSynUjqAGQInift4ElILBLl9h
	 yj07IurUB2ejIhQiBCUgaKAtfwIhhbbPY1pi5jnpjPFg0pvENzuYaXn4YHXH2RoCEkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608080;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IBHCcd05o+1mEei4Bw9D2N+VVd5u58/HSmDfdKcBqPc=;
	b=WWnExIoicfr2fnBuQF2+RgGpVGfrPGjtDggPns6KOhEQS2hvpzy9u28qqRlkcThlll5D
	 e3z8Dl3+WZlPoROD2Ajdr3ZWwVUPFykJFrDDMu1B/2YlWoQEOQ1sI1krc1t6ktnEC9Pzn
	 eOtgV4aXWae/4XRFwNXGN1fdkllYXwzKuKeDdZsv7m5yYo6OqeDdQB1BiwmJ6JXpalt26
	 zYMHtdqSo2t3OzF5+LR/sO+cBwDNQaf0SkGLB8Zo1sriLT4lyqEp7bbzyPOA96Jj0arss
	 w4wkiJ5g5D2ha00I5qCnGZJZvcpmCy2vrFDZDWlcMxYErb03yDg8qqW15dRDYJxYo4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqHzVdqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5660A3827;
	Fri, 13 Nov 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqHzVdqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8D1F000C7;
	Fri, 13 Nov 2026 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608080;
	bh=IBHCcd05o+1mEei4Bw9D2N+VVd5u58/HSmDfdKcBqPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UqHzVdqA2kKS7BKcwRJlVgq/03CVgPbhjtYBTYDb5yietosthehPWwLnSydmBIJoj
	 16s/fS3B84RzT6pQ3IVO7Yjb+R64gIihLFkXMRYK147QPVWsB6N51wUlU3oDpycjSn
	 4APL9MNMz2e2aIm64ADlfYWDHrd9uEGyZOsNsOxMPrrZpKYg2DL0TkJMv1fUzF9fzR
	 oYLevxT0Lpnm47jD0W6+O08wrq89UiPBrpYLZmn5CTy8wGStxpXUo02hoCv9PTc0PU
	 nc3GMVgpy+qA8qARzR52ZN32iyxZKvBLH3RNmcIBuVNMRqOWpBEI1C5y1y667r9tze
	 hIiAxBjtf7CeA==
Subject: Re: [PATCH net-next] netlink: specs: rt-route: move fixed-header to
 operations list
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, wessel@jacobi.pw, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn
Date: Fri, 13 Nov 2026 22:14:38 +0000
Message-ID: <179460807877.2199510.9635428422960175112@kernel.org>
In-Reply-To: <20261112-ynl_fixed_header-v1-1-8475ea19e409@kylinos.cn>
References: <20261112-ynl_fixed_header-v1-1-8475ea19e409@kylinos.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message names the root cause: the doc generator only
  renders keys on each `operations.list` entry and ignores operations-…

--

netlink: specs: rt-route: move fixed-header to operations list

This commit moves the operations-level "fixed-header: rtmsg" key in
rt-route.yaml onto each entry in the operations list. This makes the
fixed header show up in the generated HTML documentation.

Closes: https://patch.msgid.link/8610ee11-e1dc-481a-9654-11188a06786a@jacobi.pw

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 48d1659f20f34..b5786b465eeff 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -708,13 +708,13 @@ attribute-sets:
>  
>  operations:
>    enum-model: directional
> -  fixed-header: rtmsg
>    name-prefix: rtm-
>    list:
>      -
>        name: getroute
>        doc: Dump route information.
>        attribute-set: route-attrs
> +      fixed-header: rtmsg

[Severity: High]
Should this be fixed in the doc generator rather than in the spec?

The commit message says:

  "The doc generator only renders fields on each entry in the operations
  list, not operations-level keys."

That limitation is still in place after this patch. In
YnlDocGenerator.parse_yaml() in tools/net/ynl/pyynl/lib/doc_generator.py,
only the list is passed down:

    if "operations" in obj:
        lines.append(self.fmt.rst_subtitle("Operations"))
        lines.append(self.parse_operations(obj["operations"]["list"],
                                           family))

parse_operations() then renders only the keys of each list entry:

    for key in operation.keys():
        ...
        value = operation[key]
        if key in linkable:
            value = self.fmt.rst_ref(namespace, key, value)
        lines.append(self.fmt.rst_fields(key, value, 0))

The schema allows an operations-level fixed-header as a family-wide
default (operations.fixed-header in netlink-raw.yaml). The rest of the YNL
tooling uses it as the per-op fallback:

tools/net/ynl/pyynl/lib/nlspec.py:SpecOperation.__init__() {
    ...
    self.fixed_header = self.yaml.get('fixed-header', family.fixed_header)
    ...
}

These specs still set fixed-header at the operations level, so their
generated HTML still leaves out the fixed header:

  rt-addr.yaml       ifaddrmsg (only getmulticast repeats it per op, so
                     newaddr, deladdr and getaddr are still missing it)
  rt-rule.yaml       fib-rule-hdr
  rt-nexthop.yaml    nhmsg
  ovs_datapath.yaml, ovs_flow.yaml, ovs_packet.yaml, ovs_vport.yaml
                     ovs-header

The ovs_* specs are genetlink-legacy, so they can't use the approach in
this patch. If the family-level key is dropped, op.fixed_header no longer
matches family.fixed_header, and ynl_gen_c.py rejects that for
non-classic families:

tools/net/ynl/pyynl/ynl_gen_c.py:RenderInfo.__init__() {
    ...
        if op and op.fixed_header:
            if op.fixed_header != family.fixed_header:
                if family.is_classic():
                    self.fixed_hdr_len = f"sizeof(struct {c_lower(fixed_hdr)})"
                else:
                    raise Exception("Per-op fixed header not supported, yet")
    ...
}

_multi_parse() has the same check.

Could parse_yaml() or parse_operations() render the operations-level
fixed-header as a family default, or apply it to each op that has no
fixed-header of its own? That would cover all of the specs above and
make this rt-route.yaml change unnecessary.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-ynl_fixed_header-v1-1-8475ea19e409%40kylinos.cn
