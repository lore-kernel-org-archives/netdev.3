Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215553B42C5;
	Thu,  1 Oct 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860251; cv=none; b=CslkmtscMTqcrIrY24AVJRMtPZZwj3co0stKsGGdv+dnjwBYADCpMjfS8voHgLTatj2pNALytPjbiRZPdzwmyCrXa+zv56UgZTAT4epd9oc77t2uJHzV8HqxNmniKnvBGw9J/lJEQbiI+8el6/NoRdDe25pgVCPIDM4KPzi/Yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860251; c=relaxed/simple;
	bh=kxXQogOeUX3Kx04xBLOlYQwwK6FzYp2p5MuWKhYkquc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhekMhP/v6J0e6zA8ApErBVSbU0n1qG6v+7zCezFUGrt3Z8jnuXbJcCEaCuKkT0bvlb43eODCDmXei7oNiYJCU6Xg7CtSZRNE8Z1IMEmRaQ1pDIL1bqzvCTHn3DUMPXCII1ghdymlmUzsdrV+HvcQs3m7VK4HDKzDGrtxpCtK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuHfhS3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuHfhS3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC071F00898;
	Thu,  1 Oct 2026 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790860249;
	bh=T9vy0uBKibmsftiUhNEkFh/F7dlFoe2+T067/9pVxVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YuHfhS3Tap08NELR+YntHiUMyIY0MTwERQWvHUAmefD0RBMmluxssqWM12+CHVNeY
	 fhCATlhX80YkR4aHJgyLI6fgmlwUqeuaSu4N7Zd7bWGurs+GxNOG7rS2K/IMKI15Ve
	 w3lDlHUWbncxiAVvkv7bifCkQ8WH7H1PZn3u1+FD4Q2rwSeQ1LJKFaxw26UsRAdsF6
	 jkpjzpBsqr0MiK0JZGEeBu33WPatSG1rXVphmKkhnIku9Nqz0440IXK5x9rar5fbjQ
	 3Sp3fq9BvDiP06KCjjhMQV/ULl9yolysHB+TUBtu3xs7GLDpa4eNsA32OWv6lSLVo2
	 qaTldB5EJmBLA==
Subject: Re: [PATCH net-next 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stephen@networkplumber.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 13:10:48 +0000
Message-ID: <179086024885.434549.7181506584049266209@kernel.org>
In-Reply-To: <20260930100937.206377-4-jiayuan.chen@linux.dev>
References: <20260930100937.206377-4-jiayuan.chen@linux.dev>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] cubictcp_register() checks the global `beta` at line 507 and
  reads it again for the beta_scale division at lines 516-517…
- [Low] The commit message says cube_factor and cube_rtt_scale need
  `bic_scale * 10` to be positive.

Pre-existing issues:
- [Medium] The new check in cubictcp_register()
  (net/ipv4/tcp_cubic.c:507) rejects beta < 0 and beta >=…

--

tcp_cubic: fix divide by zero and endless loop on bad module params

This patch adds a check to cubictcp_register(). Before the scale factors
are precomputed, it rejects a beta outside [0, BICTCP_BETA_SCALE) and a
bic_scale that is not positive. It also clamps the TCP friendliness delta
in bictcp_update() to at least 1, so the ack_cnt loop always ends.

> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 119bf8cbb007c..2f04dca5be095 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c

[ ... ]

> @@ -504,6 +504,11 @@ static int __init cubictcp_register(void)
>  
>  	BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
>  
> +	if (beta < 0 || beta >= BICTCP_BETA_SCALE || bic_scale <= 0) {
> +		pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n", beta, bic_scale);
> +		return -EINVAL;
> +	}
> +

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. This
check only runs at module init, so can beta still be set out of range
after the module loads?

beta is registered as writable and uses the plain int setter:

net/ipv4/tcp_cubic.c:
    /* Note parameters that are used for precomputing scale factors are read-only */
    module_param(fast_convergence, int, 0644);
    ...
    module_param(beta, int, 0644);

After load, root can write any int to
/sys/module/tcp_cubic/parameters/beta. That includes values this patch
now rejects at load time.

cubictcp_recalc_ssthresh() reads the live beta on every loss event:

    return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);

With beta = -1 the multiplication is done in u32 and ssthresh comes out
at around 4M packets, so there is no multiplicative decrease. With
beta >= 1024, ssthresh ends up >= cwnd. beta_scale also keeps the
init-time beta, while the loss path uses the new value.

Runtime writes can't bring back the divide-by-zero or the endless loop.
beta_scale is only computed in the __init function, and bictcp_update()
now has the max(..., 1U) clamp.

Would it make sense to make beta 0444 so it matches the comment? Another
option is a module_param_cb() setter built on
param_set_int_minmax(val, kp, 0, BICTCP_BETA_SCALE - 1), like the one
tcp_bic.c uses to bound max_increment.

[Severity: Low]
The commit message says the scale factors "need 1024 - beta and
bic_scale * 10 to be positive". However, this check only enforces the
lower bound of bic_scale. What happens when bic_scale > INT_MAX / 10?

Further down in cubictcp_register():

    cube_rtt_scale = (bic_scale * 10);	/* 1024*c/rtt */
    ...
    do_div(cube_factor, bic_scale * 10);

bic_scale * 10 is a signed int multiplication, so any bic_scale above
214748364 overflows it. For example, bic_scale = INT_MAX gives -10
(0xFFFFFFF6 as a u32). That produces exactly the same cube_rtt_scale and
cube_factor as bic_scale = -1, which is one of the cases the patch is
meant to reject.

This can't produce a zero divisor, so there is no crash, but every CUBIC
flow gets the wrong scaling. Could the check also reject values above an
upper bound such as INT_MAX / 10?

[Severity: Medium]
Can beta change between this check and the division that follows it?

beta is 0644. load_module() calls mod_sysfs_setup() before
do_init_module(), so the parameter file is already writable while
cubictcp_register() runs.

param_attr_store() takes kernel_param_lock() and calls the setter without
checking module state. cubictcp_register() does not take that lock and
does not keep a local copy of beta.

The check and the use are separate plain loads:

    if (beta < 0 || beta >= BICTCP_BETA_SCALE || bic_scale <= 0) {
    ...
    beta_scale = 8*(BICTCP_BETA_SCALE+beta) / 3
        / (BICTCP_BETA_SCALE - beta);

Suppose the compiler reloads beta and a write of 1024 lands between the
two loads. Then (BICTCP_BETA_SCALE - beta) is zero, and the
divide-by-zero this patch fixes comes back.

This only affects CONFIG_TCP_CONG_CUBIC=m. It also needs the compiler to
emit a second load of beta.

Would it close the window to read beta once with READ_ONCE() into a
local, then use that local for both the check and the beta_scale
calculation?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930100937.206377-1-jiayuan.chen%40linux.dev
