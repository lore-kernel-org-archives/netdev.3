Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950474;
	b=mVvN1x25e9axFVKvakht1BmXLHatsxZ2/hvn/1e7oWa6cOhYJV4Fh4U7Srk6meqLSIbF
	 fmfjRaWN/Kr9ILN0VSc4lQsrvH40XAECCm2bB+47frtd5CajvQG6B0r5lAZpfmSOfj1fw
	 3tvjc1emGzmyPn0rMMfo/r9lsDHy2StAZS+ZvKKL8d9/eJaoiMoRiMApC1dddVbSsRf+6
	 94QaVQtUxqS8nWq9Tpa6c2Z7/70/ryRXs6zUbWhxiBqunpnK/OLzKOvlwbLcQyEOLvttJ
	 wTl7H/WzJ9TrCuw0eZKSPVkbjCOx16VD15ZLEnoDxCvoWCypzumb2f02j1Fv3fvRh/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PHNL2zci2V+tXy+ZuToX2Iy4V2hn/n3XFhH6YxOGTOo=;
	b=hd7eAQpAvr8xfC5ufvvEFlO9CnDUHupyfBrAgMikBld4RSXe7eD0/paQry94RzlOhQnc
	 ip28dlgO2G9Ehj27duT5LQRe++9NLcvrz2c0ZGnjzXYVBHocUAvNAqBkvwRZJdxu7X3eq
	 xj73MdL0d7nuVTYfessEjmp9iJIzgFmxopeBCzC2hkn2xNqBERONXL07DNyTUBDvpgtWD
	 WQoYJiwzROPNyyoEVlJnxGwRnfFVyuyArHFDSYnVobIVNK6LoVcWywcs4LdlLjcYC9PWc
	 AOz+RVqgSPGSvc9GbPYZGybscC6yYC6kOJ8vyQI5O8XJ9/zbSpUC4GVzSuI6PB/ZdLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YDcLTFMo;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A31606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A31606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YDcLTFMo
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1412050a91.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792950473; x=1793555273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PHNL2zci2V+tXy+ZuToX2Iy4V2hn/n3XFhH6YxOGTOo=;
        b=YDcLTFMoTSzSAm4OWtfNk+bkKL7NDNbur5AttMw6S/UuExcEY0azW8hea51cPdLKaa
         yBOAguSs0jsHUY2Xo3GHDeuphY3g3f67viFtYO5Vkqk4G0mBIqATxQdTwdTIb4tguf1A
         4+e5jr0vX2p3xYwtcMKS9EScKdBNSuNpwtsA6REmdXVnwdkKMHB6uV+Q8q8mIZs1SXKJ
         KFPJOvNEkl4nOuqYMR9W1YQu5iXlmlfUcYxyRiPLVSjRUEKNvvFGV5oWfxoZValoGEBB
         bVoTJakSmKbCR8BzLp3l52oM/zJNVKAG02tAsdymiFA6mkJ84WA/kaIKocQggaINQtEo
         DsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950473; x=1793555273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHNL2zci2V+tXy+ZuToX2Iy4V2hn/n3XFhH6YxOGTOo=;
        b=sR4/fy+f6f9S25kPq+RK90zTRTcYeVdl5SThHpvMcx5BPcIZG0CMty3o5/+TdCIIrT
         xsABWr66o2yFY417L7d+XwjC+Y+62u05ZWCNvR/tzEI6LNVqZkUxI0UuTvslki24Ii5e
         sKyqCfJziiuL3ZXrGr7YkRXIDdM1my4cifuQdm0JC/8N2dGNwa0qF+QkDjB7chOIYF1U
         kkzE42yF2OQtyRQj9OalSv0tFXuu4wNUh92GrAznfHmZnE/j4tNriYx5RkqADeMsRj0d
         CCT9UPxfp17pWqRKqIvSmg9gqG5e1z7zHcv+0v8qv1iTHi9m9qZ8/3SQQFx7XgeUrYaQ
         VVXQ==
X-Gm-Message-State: AFq9FYKc/2L0VZwliK4nSCeY7NnsVxiiWE5+UJ/l5IqDUaYXcpziL28x
	+UPWm1tkN0zqVe0vdhYAy94BUit1JtEtqWZPtnfvPwnDPvvAUSC/41ihA5j007mGAUXMyXjLju9
	8RCzL8ME=
X-Gm-Gg: AYBFou2qjnS97cVdLhsQcNyxFOBWgfL5qo1r1maYML0dnLhLLtmeW1Qnnuk98yh9e0q
	NbYnmlHkiPfCGXiLqZTGxBX8f3pd4aRrT59cbpMgQR6/+4bg/PDtpPMQWhigF4Q6umOQ2ESXqll
	QF7TlaRaUY8j/1qYXjx7P2tuhqqOWI+lB2lQsZyziBTCllm5VI4cn70WV+ffenCTGcJHcSuNaQ8
	B5Vu7/sKT+ozTzcZ/VXyxhWZb+yv71fSN91DOqK+QGx3XA4Li22+W9Ut8/t2YG1A2yQpSdYUaRp
	TyPqyhDxvHhl/5LnU3onq8Canlxpx5d7H4hDtZlSbskcSSqKrKi1Qfe8UvEoqqtcDeLgD0CA0pH
	Ap4Or0a0IycpGpn/khD3275sa+QHqGsoWza1k69FzggI/80W9iao5/AgIyuDdcUpZTXvg57ZflK
	xPL4TPyyghLg0tDn7Heg6URxV5B781DlsA8FszhAZFXAH/MgHcsOp127qylauOmISskB3l4ebNc
	gYtiLrO7KE3RyLKTJ4SQK8h/qPZmOfuHrMcDMM1a/junHtMLSa9XjWFDDVL8RbFz2W7tyEUZd5e
	/XRY9jHH4UTc7uAw22MxcA==
X-Received: by 2002:a17:90b:4a51:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3adeafc9d9cmr4075613a91.65.1792950473363;
        Sun, 25 Oct 2026 10:47:53 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb24a83sm5367423a91.17.2026.10.25.10.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:47:52 -0700 (PDT)
Date: Sun, 25 Oct 2026 10:47:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuen Su <zypulsecore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip: flush nexthop-object routes without
 compatibility attributes
Message-ID: <20261025104750.37da5b0f@phoenix.local>
In-Reply-To: <CAC9WPdwmM4=64DH5nY85srnLhRBS7PkjR9vrsALpob-GutbmZw@mail.gmail.com>
References: <CAC9WPdwmM4=64DH5nY85srnLhRBS7PkjR9vrsALpob-GutbmZw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 20:00:26 -0700
Yuen Su <zypulsecore@gmail.com> wrote:

> Route dumps carry RTA_NH_ID together with compatibility-expanded nexthop
> attributes. Copying both into RTM_DELROUTE is rejected. Compact the
> flush copy while preserving the exact ID and route selectors, use its
> new length for batching, and leave the original dump intact for verbose
> display.
> 
> IPv4 blackhole objects synthesize a route type which may differ from the
> FIB alias. Without a type selector, omit that synthetic constraint.
> Retain explicit type filters so a typed flush cannot delete another
> alias sharing the prefix, metric and nexthop ID. An ambiguous typed
> request remains a conservative failure.
> 
> Add real-kernel regressions for IPv4/IPv6 single nexthops, groups,
> ordinary multipath, mixed flush batches, blackhole aliases, cross-family
> gateways, exact metric/table retention and type-filter preservation.
> 
> Signed-off-by: Yuen Su <zypulsecore@gmail.com>
> ---

Lots of issues identified by AI review

On Sat, 17 Oct 2026 20:00:26 -0700, Yuen Su wrote:
> Subject: [PATCH iproute2] ip: flush nexthop-object routes without
>  compatibility attributes

The underlying bug is real and worth fixing, but this submission has a
blocking delivery problem, one correctness regression, and some invented
test scaffolding. Details below.

1) The patch is whitespace-damaged and cannot be applied
---------------------------------------------------------

  $ git apply --check iproute2-ip-flush-nexthop-object-routes...patch
  error: corrupt patch at line 192

The mail was injected through the Gmail web API:

> Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;

which rewrapped long lines mid-statement. For example the new function's
signature arrives split across a continuation line, and nearly every
added test line is broken at column ~70:

> +static void flush_nexthop_compat(struct nlmsghdr *n,
> +				const struct nlmsghdr *source)

> +	ts_ip "$0" "Add selected single-nexthop route" -"$family" route add
> table 111 "$prefix" nhid "$nh" metric 10 mtu 1400 advmss 1360

Please resend with git send-email (or git format-patch + an attachment)
so it applies cleanly. I reviewed the logic from the quoted text, but
nothing can be tested in this state.

2) The RTN_UNSPEC hunk papers over a kernel dump bug -- please call
   that out explicitly
--------------------------------------------------------------------

> +	if (!filter.typemask &&
> +	    r->rtm_family == AF_INET && r->rtm_type == RTN_BLACKHOLE)
> +		flushed->rtm_type = RTN_UNSPEC;

The commit message describes this as IPv4 "synthesizing a route type",
which undersells it. In fib_dump_info() (net/ipv4/fib_semantics.c):

	if (fi->nh) {
		if (nla_put_u32(skb, RTA_NH_ID, fi->nh->id))
			goto nla_put_failure;
		if (nexthop_is_blackhole(fi->nh))
			rtm->rtm_type = RTN_BLACKHOLE;
		if (!READ_ONCE(fi->fib_net->ipv4.sysctl_nexthop_compat_mode))
			goto offload;
	}

Note the type is overwritten *before* the compat-mode bail-out. So for

	ip nexthop add id 301 blackhole
	ip route add 192.0.2.0/24 nhid 301	# fa_type = RTN_UNICAST

the dump reports RTN_BLACKHOLE regardless of nexthop_compat_mode. A
delete built from that dump carries fc_type = RTN_BLACKHOLE, fails to
match fa_type = RTN_UNICAST in fib_table_delete(), returns ESRCH and
aborts the flush. That is a kernel bug: rtm_type ends up describing the
nexthop object rather than the FIB alias, and it is independent of the
compatibility-attribute problem this patch is otherwise fixing.

I am not asking you to drop the hunk -- without it, ID-only flush of
IPv4 blackhole-object routes stays broken, including your own test case.
But two things should change.

First, the commit message must say plainly that this works around a
kernel dump bug, with the trace above, rather than calling it a
"synthetic constraint". Otherwise the workaround outlives the memory of
why it exists. Please also report it on netdev so the dump can be fixed
at the source and this can eventually be reverted.

Second, be accurate about the cost in the comment. fc_type == 0 is a
wildcard in fib_table_delete() (net/ipv4/fib_trie.c), and the loop takes
the first otherwise-matching alias and stops:

	if ((!cfg->fc_type || fa->fa_type == cfg->fc_type) &&
	    ...
		fa_to_delete = fa;
		break;

The delete still carries RTA_NH_ID, protocol, scope, prefsrc and
metrics, all matched here and in fib_nh_match(), so the exposure is
narrow: only aliases identical in prefix, table, dscp, metric, nexthop
ID, protocol, scope and prefsrc, differing *only* in type. And since
this path requires !filter.typemask, the flush dumps and deletes all of
them in the same pass anyway -- so in the steady state this is an
order swap, not an over-deletion. Residual risk is a concurrent-change
window, not the general case.

That is a defensible tradeoff; it just needs to be the documented one.
The current comment ("Never weaken an explicit type filter") describes
the guard but not what is given up when the guard does not apply.

3) Invented test environment variable
--------------------------------------

> +if [ -n "$IPROUTE_TEST_PARENT_NETNS" ] &&
> +   [ "$(readlink /proc/self/ns/net)" = "$IPROUTE_TEST_PARENT_NETNS" ]; then
> +	ts_err "Refusing route writes in the parent network namespace"
> +	exit 1
> +fi

IPROUTE_TEST_PARENT_NETNS does not exist anywhere in the tree:

  $ grep -rn IPROUTE_TEST_PARENT_NETNS .
  (no hits)

Nothing sets it, so the guard is permanently false -- dead code. The
testsuite already isolates every test; testsuite/Makefile has:

  PREFIX := sudo -E unshare -n

Please drop the block.

4) ts_ip treats any stderr output as a failure
-----------------------------------------------

Worth double-checking the new test against __ts_cmd() in
testsuite/lib/generic.sh:

	$CMD $@ 2> $STD_ERR > $STD_OUT
	if [ -s $STD_ERR ]; then
		ts_err "${SCRIPT}: ${DESC} failed:"

Any warning on stderr fails the step regardless of exit status. The
deliberate-failure case correctly bypasses ts_ip and invokes $IP
directly, so that one is fine -- but several of the nexthop and route
add steps will emit warnings on kernels without full nexthop-object
support and fail for the wrong reason. Consider gating the whole file
on a nexthop-object probe with ts_skip.

5) What is right, for the record
---------------------------------

The core of the fix is correct and I'd like to see it respun:

- The strip set matches what the kernel actually rejects, for both
  families. net/ipv4/fib_frontend.c:

	if (cfg->fc_nh_id) {
		if (cfg->fc_oif || cfg->fc_gw_family ||
		    cfg->fc_encap || cfg->fc_mp) {
			NL_SET_ERR_MSG(extack,
				       "Nexthop specification and nexthop id are mutually exclusive");

  and net/ipv6/route.c rejects RTA_GATEWAY/RTA_OIF/RTA_MULTIPATH/RTA_ENCAP
  alongside RTA_NH_ID. Since nexthop_compat_mode defaults to 1, the dump
  does carry both, so flush really is broken today.

- The buffer accounting is sound. The overflow check still uses the
  original (larger) n->nlmsg_len, so it stays conservative, and

> -		filter.flushp = (((char *)fn) + n->nlmsg_len) - filter.flushb;
> +		filter.flushp = (((char *)fn) + fn->nlmsg_len) - filter.flushb;

  is load-bearing: without it the next message in the batch would be
  written after a gap and the kernel would parse garbage. Reading from
  the source message while writing into the flush buffer is safe --
  they are distinct buffers.

6) Minor
---------

- The commit message should state the problem, the root cause and the
  fix. The validation appendix (CI links, assertion counts, sanitizer
  claims, "No production router or NSS firmware was tested") does not
  belong in the posting; trim it to the one-line note that real-kernel
  regression tests were added.

- Naming: the local `flushed` reads like the filter.flushed counter.
  Something like `dr` (delete request) would be clearer.

So: fix the delivery, document the RTN_UNSPEC workaround for what it is
(and report the dump bug upstream), drop the dead netns guard, and the
rest looks like the right fix.
