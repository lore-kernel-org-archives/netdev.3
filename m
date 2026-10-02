Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB641A575;
	Fri,  2 Oct 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940760; cv=none; b=O7zNpAV6Y2gwm4eq125tt26jH2F+oc8biphUaFqBz8Yt2gjugOUIr8O8AlFPkh87ozB142LB2xJVSw0FSUQTfosq9dBDJGR3obhl5DZKbZrPrD4d06zyEYjG5nG4DGjf8qUjESaIeiyUjdE8LN1y8dHeBmx0lxywjmW9mOvIKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940760; c=relaxed/simple;
	bh=2MkwPHu6okdl080KKqMuqRXFQdLBlWrvNi6PDh7DJZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffPJEAR4gHtOPA4LMbMiDiLLJ28Id2bnDyQtCtTxvQwKEDQbAd0rLLmU6l26eZ2mVS7KSW+ZEQz/LUrpXsxl8w9xLl71D6JdWEFYKOJHLRWIDrdaUM/O1/9SVzfKyztZbBf0tzeniBqb+uSWmEP5/kyuEFtrTyO9apBkyZFeTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHEoTf2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHEoTf2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860971F00893;
	Fri,  2 Oct 2026 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940758;
	bh=z6h+9qkpEQmZBB+v7zPi5VXyZ2RJTE/Ql4menSxgvxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eHEoTf2qFsT5c+FfzajKn5ESewP7KdqYYVdjwWeiemJKgmAv4ROLFWPQIspmv8mS9
	 BHeAf62LFAotr4v0DO6QsNpB6haMBJE/+1EgWNchXQJoO+uFQSy4loAo80z/TUV1vm
	 XULnvzNRujP3gJ0MHALD0UkHaD81ap6bvr/nkKcHrjoiYDCat46S+77TUXBabKnRmp
	 Yp1X5JVFoewp4Yp3Ja2amwyhknCF5RWr0bCKroLoFyZeWci4o016XdbG4U6UFgPsBa
	 ictx/uxW5zFpdWI9n2fncdOhzumfRGJCtQzNtD5QNJPB7QOtkpvn3XZHT8n3W4po6y
	 bfxi7v0dMgWvw==
Subject: Re: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, edumazet@kernel.org, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 11:32:37 +0000
Message-ID: <179094075705.434549.2448687224694925234@kernel.org>
In-Reply-To: <20261001112948.322463-4-jiayuan.chen@linux.dev>
References: <20261001112948.322463-4-jiayuan.chen@linux.dev>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that after the floor `beta_scale =
  max(beta_scale, 8U)`, `(cwnd * beta_scale) >> 3` "is always >= 1 with…

Pre-existing issues:
- [Low] The patch checks `beta` only once, in the __init function
  cubictcp_register() (net/ipv4/tcp_cubic.c:507-512).

--

tcp_cubic: fix divide by zero and endless loop on bad module params

This patch makes cubictcp_register() check the beta and bic_scale module
parameters at init time. It rejects values that would cause a divide by
zero or an overflow when beta_scale and cube_factor are computed. It also
raises beta_scale to at least 8 so the TCP friendliness loop in
bictcp_update() never sees a zero delta.

> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 119bf8cbb007c..33b383e1307fb 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -504,12 +504,21 @@ static int __init cubictcp_register(void)
>  
>  	BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
>  
> +	if (beta < 0 || beta >= BICTCP_BETA_SCALE ||
> +	    bic_scale <= 0 || bic_scale > INT_MAX / 10) {
> +		pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n",
> +		       beta, bic_scale);
> +		return -EINVAL;
> +	}

[Severity: Low]
This is a pre-existing issue and this patch doesn't introduce it. The
check only runs once, in the __init function cubictcp_register(), but
beta is still registered as writable:

    /* Note parameters that are used for precomputing scale factors are read-only */
    module_param(beta, int, 0644);

So root can later write any int to /sys/module/tcp_cubic/parameters/beta,
including negative values or values >= 1024. The write goes through the
generic param_set_int(), which does no range check.

cubictcp_recalc_ssthresh() reads the live beta on every loss event:

    ca->last_max_cwnd = (tcp_snd_cwnd(tp) * (BICTCP_BETA_SCALE + beta))
            / (2 * BICTCP_BETA_SCALE);
    ...
    return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);

If beta is set out of range at runtime, can this u32 arithmetic produce a
garbage ssthresh and last_max_cwnd? beta_scale is also never recomputed,
so it would stop matching beta.

The comment above the module_param() calls says the precompute parameters
are read-only, which isn't true for beta.

Runtime writes don't bring back the divide by zero or the endless loop,
because beta_scale and cube_factor are only computed at init. Still, the
new range only holds at load time. Should beta be 0444 like bic_scale, or
use a custom setter that enforces the same bounds?

> +
>  	/* Precompute a bunch of the scaling factors that are used per-packet
>  	 * based on SRTT of 100ms
>  	 */
>  
>  	beta_scale = 8*(BICTCP_BETA_SCALE+beta) / 3
>  		/ (BICTCP_BETA_SCALE - beta);
> +	/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >= 1 */
> +	beta_scale = max(beta_scale, 8U);

[Severity: Medium]
The commit message says this makes (cwnd * beta_scale) >> 3 "always >= 1
with cwnd >= 1". Does that still hold when the u32 product in
bictcp_update() wraps?

net/ipv4/tcp_cubic.c:bictcp_update() {
    ...
	u32 scale = beta_scale;

	delta = (cwnd * scale) >> 3;
	while (ca->ack_cnt > delta) {		/* update tcp cwnd */
		ca->ack_cnt -= delta;
		ca->tcp_cwnd++;
	}
    ...
}

If the wrapped product is less than 8, delta is 0 and this loop never
ends during ACK processing.

With beta=0, the raw beta_scale is 8*1024/3/1024 = 2, and this clamp
raises it to 8. At cwnd = 1 << 29 the product is 2^32, which wraps to 0.
Without the clamp, delta would have been 2^27 there. The same happens for
any beta whose raw beta_scale is below 8 (roughly beta < 512), at
cwnd = k * 2^29.

There is also a case that predates this patch. beta=983 gives
beta_scale=130, and 33038210 * 130 = 4294967300 wraps to 4, so delta is
again 0.

All of these cwnd values are far above the documented design limit of
cwnd < 1 million packets. With the default beta=717, a zero delta needs a
cwnd above INT_MAX, so default settings are not affected. The normal TCP
state machine doesn't look able to reach the 2^29 cases. The ~33M case
might only be reachable with extreme tuning.

Would it be more robust to guard delta itself, for example by computing
it in 64 bits or forcing it to at least 1? If not, should the commit
message and comment say that the guarantee assumes the product doesn't
overflow?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001112948.322463-1-jiayuan.chen%40linux.dev
