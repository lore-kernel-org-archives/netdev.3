Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266877;
	b=PZr3sWjo8z8btXOsGtEmAfXDCQ6TzRYz32jrIbfmdiL+wSQFAqXuJ95pL0sUqiHJZKT+
	 ji1XGQXeM+CGakWgPCEaGWt23kZmdtAe0HotQtuwMIZs7Kz8Hbp8jYgMop3M93JyFINmL
	 /oB+vFrE3/3uSLTlbP5R39K4Ukldf8q4Teyu6H5yzQgxEoFBsbGOH+Gy0VQ38rVc0wpun
	 lo9tIkVNQl/lbWoYfh3apj8UanKxOIAI6n8ill3SQJH8KRzOVFw/ulaCGDyKD3eGk4CDT
	 sR9eCkfdfQEDC+5SFwMapP3Z2gEy8auCfgz8YXmfo5iR73IMMqiKQ5P/kJDgLPGQujg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266877;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FiCnljuGyNGaj0HbHSZT4YVlY9zOU7UkK0FlS9zRQiA=;
	b=A6ofkR8kQA/q6Y9fm/pjbeY+c7uFsI/g5FwMrPQRqxZv8RaSDhoF7Uk/sBwQ7F/+ZzgD
	 K01X679lq6fQ5mf5QxoWdu1MISJgVI4rLePbqKnc1UNppPTm4JDwD3tKTj90L+ZIcamUB
	 a6MElu1oynLO6z6zBKVHeJcd9W/B2Lz1lxOCKBaK1hd+7ArEo6G8A4Hy7NOEZqkO4kZDv
	 QE0JhbgggJpgw+g3oRhQCoPZM4+I1qAWbTWSnqF8Xq24hw/AC2LzSj84UdQbTX3KWVu4n
	 JO7cZK6XmQKUhU5NDDEoCrYcqxRHYERszfPTuRpabbMrSmhD8+C3h7A//Jhl9gmITNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhzFRr70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D606A321;
	Mon,  9 Nov 2026 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhzFRr70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923381F008A1;
	Mon,  9 Nov 2026 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266877;
	bh=FiCnljuGyNGaj0HbHSZT4YVlY9zOU7UkK0FlS9zRQiA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FhzFRr70Du8Rt19xCOs/PIpms+QmHfdBkjbTH02WlPQs42/ml0YpwWrh0IF4WAuhE
	 DlimZoy1QOpL38cZvbm/7rDSkX9sW9XxDnB/Lk9ChPKekqpo9zz8QB6IdxoRI3MSf0
	 Akt/WGJ9zko+JrWBg+kVA2IdzxiCnheBL8kBgIsyevXWkyj9iGu+e6+rQgUjuMGERE
	 B5+3Wk+5YiH0EkJLfkOoWGORZhuiZntjDM+AYKTt7VFt1MZ0nf+b+8Xpn+JZZJAqtp
	 LWYf25H924h08eMFQ4/1g1ytbiWzqf25EJhzb5V3l8Mqrz1PGZ03Qa+mnDy9MpZiho
	 FFVhQ00COX3qw==
Subject: Re: [PATCH] net/sched: em_meta: clamp shift to value width
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:27:56 +0000
Message-ID: <179426687612.994134.14586477741084121759@kernel.org>
In-Reply-To: <PonpZoq156a2aiUCGrHWYeg_kl3yFtp5oE2JaeCRJosmPfqWvGCrSlM-dn8lG7kSQpaAJuSaDN1zwr8X9UTC_DxfkFYZQVEQpV9kb-dMWxc=@proton.me>
References: <PonpZoq156a2aiUCGrHWYeg_kl3yFtp5oE2JaeCRJosmPfqWvGCrSlM-dn8lG7kSQpaAJuSaDN1zwr8X9UTC_DxfkFYZQVEQpV9kb-dMWxc=@proton.me>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/sched/em_meta.c, em_meta_change() (lines 942-945)
  silently rewrites a user-supplied hdr.shift above BITS_PER_LONG-1 down…
- [Low] Commit-message and DCO problems.
- [Low] The patch has no Fixes: tag even though it fixes user-reachable
  undefined behaviour.

--

net/sched: em_meta: clamp shift to value width

This patch clamps the user-supplied hdr.shift of both em_meta operands to
BITS_PER_LONG - 1 in em_meta_change(). The aim is to avoid an undefined
right shift in meta_int_apply_extras() when the u8 shift is BITS_PER_LONG
or larger.

> Hello,
>
[ ... ]
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/sched/em_meta.c:762-770 (meta_int_apply_extras), 906-941 (em_meta_change).
> Longstanding code; the sibling fix pattern exists in act_pedit.
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Low]
The commit has no Signed-off-by: line, so it can't be applied under the
DCO. Could it be resent with one?

The only trailer is this Reported-by:, and it names the patch author.
Is it needed?

The greeting, the "Affected version/commit" line with its tree hash and
line numbers, and the paragraph on compile and test status read like
cover letter material. Should they go below the --- line, or be dropped?

The paragraph also says "every code path cited below was re-verified",
but nothing is cited after that sentence.

[Severity: Low]
The changelog only says "Longstanding code". The shift in
meta_int_apply_extras() goes back to the initial git import. Should this
carry a tag so stable trees pick up the fix?

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
> index 48bdd77df0a3e..6681c6793cb80 100644
> --- a/net/sched/em_meta.c
> +++ b/net/sched/em_meta.c
> @@ -936,6 +936,14 @@ static int em_meta_change(struct net *net, void *data, int len,
>  	memcpy(&meta->lvalue.hdr, &hdr->left, sizeof(hdr->left));
>  	memcpy(&meta->rvalue.hdr, &hdr->right, sizeof(hdr->right));
>  
> +	/* Keep the shift within the value width to avoid undefined
> +	 * behaviour in meta_int_apply_extras(), like act_pedit does.
> +	 */
> +	if (meta->lvalue.hdr.shift > BITS_PER_LONG - 1)
> +		meta->lvalue.hdr.shift = BITS_PER_LONG - 1;
> +	if (meta->rvalue.hdr.shift > BITS_PER_LONG - 1)
> +		meta->rvalue.hdr.shift = BITS_PER_LONG - 1;

[Severity: Medium]
Can this silent clamp change the match result for an out-of-range shift?
meta_int_apply_extras() uses the clamped value directly:

net/sched/em_meta.c:meta_int_apply_extras() {
	if (v->hdr.shift)
		dst->value >>= v->hdr.shift;
	...
}

When shift is BITS_PER_LONG - 1, the top bit survives. The result is 0 or
1, not the 0 you would get if every bit were shifted out.

For example, on a 32-bit kernel, meta(random shift 40 eq 0) would fail
about half the time. On 64-bit, the same request always gives 0 for a
u32-sourced value. The same __u8 uAPI value now gives a verdict that
depends on BITS_PER_LONG.

em_meta_dump() also reports the rewritten shift back to userspace:

net/sched/em_meta.c:em_meta_dump() {
	...
	memcpy(&hdr.left, &meta->lvalue.hdr, sizeof(hdr.left));
	memcpy(&hdr.right, &meta->rvalue.hdr, sizeof(hdr.right));

	if (nla_put(skb, TCA_EM_META_HDR, sizeof(hdr), &hdr))
	...
}

So tc filter show would print 63 or 31 instead of the configured shift.
Is that intended?

The new comment ties the clamp to the value width and to
meta_int_apply_extras(). However, the clamp also rewrites
TCF_META_TYPE_VAR operands. For those, shift is a byte trim count, and
a large value is not undefined:

net/sched/em_meta.c:meta_var_apply_extras() {
	int shift = v->hdr.shift;

	if (shift && shift < dst->len)
		dst->len -= shift;
}

var_dev and var_sk_bound_if are at most 15 bytes long, so VAR matching
does not change. The dump does change, though, and the comment doesn't
describe that path.

In act_pedit the shift is used to compute an offset. Here, the shifted
value is compared directly with the user operand.

Would one of these be a better fit?

- Reject shift >= BITS_PER_LONG for TCF_META_TYPE_INT with -EINVAL.
- Leave hdr untouched, and set dst->value to 0 in meta_int_apply_extras()
  when shift >= BITS_PER_LONG.

Either way, could the changelog describe the behaviour change?

> +
>  	if (!meta_is_supported(&meta->lvalue) ||
>  	    !meta_is_supported(&meta->rvalue)) {
>  		err = -EOPNOTSUPP;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/PonpZoq156a2aiUCGrHWYeg_kl3yFtp5oE2JaeCRJosmPfqWvGCrSlM-dn8lG7kSQpaAJuSaDN1zwr8X9UTC_DxfkFYZQVEQpV9kb-dMWxc%3D%40proton.me
