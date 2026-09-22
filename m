Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27454CF54;
	Tue, 22 Sep 2026 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086965; cv=none; b=o2I9cyFImSrCaSGJpsI9JfCluogM93HsnINDCuCNE3vxDiXHSi4eMO59xXUekd9+ZhCsZ6ECvijUYdXiVG7nieHD6fDmskjDhHZEmUoczNHbblVhzHiij26MxJ1qKq1Ve984wb7ERs5+qTcrA1oKYs1jJ8u4N/lOm2es31lGQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086965; c=relaxed/simple;
	bh=1tzx0m/5St24hhThfkmXckdvIUcLaLSM+RFu64tXey8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCQv8XUFDiO0rSuWe3aFat2Jvp/D/EQgJFJabD+oLrGtQYLjIYeetr2og1Wg3etH9/2Lm82C1CNHn52jj6p/nlWS3DJe0Bez0irUgPJyUnncrAqNbPUhXRpQcYPQ3MZmNJuQ5QHoxzenFelemcgQhi6BS38vb9d9fWZSveAhacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsnFD+Mh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsnFD+Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C521F000FF;
	Tue, 22 Sep 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790086964;
	bh=XTtBb0RcHyYD8F5/FlgEaoXL7NuhC48cDY/6CZ5lAiE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MsnFD+Mhl5AoCBYjn6As/Kh5vn36Dv7YEvryCdBxCiKlNTulQEb5okMyK661k5GG1
	 Q5Z6v09OFA0depqSkLFyoiH2yVwwmxgep3DoAlBbYjj+rlLbDJZRtRVGZSuIhywnim
	 nQA98EAM+hoSXT8zf4WEamOYb9gaX/AzNwfdHgNIYqMTLAj7BN6jdM0P0Vf8VyR6fR
	 wi1Jz+sGlLOnLSgTDvJw8RhCswffWY9jR2njQzGm5zNBqwxxReM2PhvTY3Rf0JIeFw
	 0Ehm1dhN4uPMSmgvbgKJdfC9AgjuNT6zhufjGPi8Ae3TkuURoQ61AfvS4KTlQQsH4A
	 Af6CIowEWUkAw==
Subject: Re: [PATCH] net/sched: fix potential stack infoleak in em_text_dump()
From: netdev-bot+sashiko@kernel.org
To: bernard.ladenthin@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alexander.potapenko@gmail.com
Date: Tue, 22 Sep 2026 14:22:43 +0000
Message-ID: <179008696307.2160803.12571414057980490083@kernel.org>
In-Reply-To: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
References: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The `Fixes:` tag and the commit message body misattribute the
  stack infoleak to b04202d6065c ("net/sched: replace strncpy with…

Pre-existing issues:
- [High] Out-of-bounds read on the request (parse) side of the same ABI
  field: em_text_change() (net/sched/em_text.c:50) passes the raw, user-…

--

net/sched: fix potential stack infoleak in em_text_dump()

This zero-initialises the on-stack struct tcf_em_text in em_text_dump()
so that the bytes of conf.algo[] not written by strscpy() are not copied
to user space by nla_put_nohdr().  KMSAN reported the leak on both
"tc filter show" and a raw RTM_GETTFILTER dump.

Link: https://lore.kernel.org/netdev/20250327143733.187438-1-richard120310@gmail.com/

A couple of questions below, one about the Fixes attribution and one
about the matching parse path.

> The original code used strncpy() which zero-pads to the destination size.
> Commit b04202d6065c ("net/sched: replace strncpy with strscpy") replaced
> it with strscpy(), which does not pad, creating this condition.
> Zero-initialising the struct closes it.
>
> Fixes: b04202d6065c ("net/sched: replace strncpy with strscpy")

[Severity: Medium]
Is this attribution accurate?  The call site that b04202d6065c replaced
was bounded by sizeof(conf.algo) - 1:

net/sched/em_text.c before b04202d6065c:
	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);

strncpy() zero-pads only up to the supplied bound n, not to the
destination size, so with a bound of 15 on the 16-byte algo[] the last
byte was never written:

include/uapi/linux/tc_ematch/tc_em_text.h:
	struct tcf_em_text {
		char		algo[TC_EM_TEXT_ALGOSIZ];
		...

Doesn't that mean nla_put_nohdr(skb, sizeof(conf), &conf) already copied
one uninitialised stack byte to user space before b04202d6065c, and that
b04202d6065c only widened the window (12 bytes for a three character name
such as "kmp", which matches the quoted "Bytes 168-179 of 199")?

If so, could the Fixes tag point at the introduction of em_text.c, or the
patch carry Cc: stable@vger.kernel.org covering the older trees?  As
written, stable selection driven by this Fixes tag will skip every tree
older than b04202d6065c, which keeps leaking the final byte of algo[] on
every dump of a text ematch.

Could the sentence "The original code used strncpy() which zero-pads to
the destination size ... creating this condition" also be adjusted, since
the old call padded only to the bound of 15?

The code change itself looks correct and complete for the current tree:
the uAPI struct has no interior padding (algo[0..15], from_offset,
to_offset, pattern_len, the layer bitfield byte, pad, sizeof == 24), so
= {} clears every transmitted byte.

> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 343f1aebeec2..4132f8c3c5fc 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -113,7 +113,7 @@ static void em_text_destroy(struct tcf_ematch *m)
>  static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>  {
>  	struct text_match *tm = EM_TEXT_PRIV(m);
> -	struct tcf_em_text conf;
> +	struct tcf_em_text conf = {};
>  
>  	strscpy(conf.algo, tm->config->ops->name);

[Severity: High]
This is a pre-existing issue and is not introduced by this patch, but
since it concerns the same algo[] field it may be worth handling in the
same series.

After this change the emitter always produces a NUL-terminated,
zero-padded algo[], while the parser accepts an algo[] with no NUL at
all.  em_text_change() validates only len, the layers and the offsets:

net/sched/em_text.c:em_text_change() {
	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
		return -EINVAL;
	if (conf->from_layer > conf->to_layer)
		return -EINVAL;
	...
retry:
	ts_conf = textsearch_prepare(conf->algo, (u8 *) conf + sizeof(*conf),
				     conf->pattern_len, GFP_KERNEL, flags);
	...
		flags |= TS_AUTOLOAD;
		goto retry;
}

data here points straight into the user-supplied rtnetlink message, with
no copy and no termination:

net/sched/ematch.c:tcf_em_validate() {
	void *data = (void *) em_hdr + sizeof(*em_hdr);
	...
}

On the TS_AUTOLOAD retry the unterminated name reaches:

lib/textsearch.c:textsearch_prepare() {
	...
		request_module("ts_%s", algo);
}

and vsnprintf's %s handler scans for a zero byte with no length limit on
the source side:

lib/vsprintf.c:string_nocheck() {
	int lim = spec.precision;
	...
	while (lim--) {
		char c = *s++;
		if (!c)
			break;
	...
}

with spec.precision == -1 for a plain %s.  If a caller sets every byte of
algo[], from_offset, to_offset, pattern_len, the layer bitfield, pad and
the pattern to non-zero values, can this read past the end of algo[] and
past the end of the netlink message into adjacent kernel memory, and
embed those bytes into the modprobe request name?  For requests large
enough that netlink_alloc_large_skb() uses vmalloc, the scan would be
walking towards the guard page.

The reachable path is RTM_NEWTFILTER with an ematch tree containing a
TCF_EM_TEXT match whose algo does not resolve to a registered ts_ops, so
the first textsearch_prepare() returns -ENOENT and the retry with
TS_AUTOLOAD is taken.  That needs only CAP_NET_ADMIN in a network
namespace, plus CONFIG_MODULES.

Would rejecting an algo[] without a NUL byte in em_text_change() be the
right companion fix, so both ends of the uAPI agree on the format?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
