Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302362;
	b=E9aF8WL8zsqOxnfSyl8q+uYIGnjgNktxtBYSn9Ym6nqnC6iiye5PlIOX5wMX9QCaTD7A
	 9Vav0qW2qXqPIsRtqdz0z89+v/jE9sJ5zsfaBLFn5LjOuK4d1hpu1bK8iyZgo5mZOdMec
	 +vr9pGabCS9jBDP+fw1e/pCoLugfxjJSjOLoPtAcAA35BvgJHmH102iWrqK+MeqKD5zAS
	 7n89DzEru6RDHBsnknA3XJPdQProWAXOc3mPbAT8yKKiHPKhe6PUvykIqLEGMt/N09EHi
	 z+2edxZYk5aykRlgENjzKeB5fDT6sSst72FXbLY/AkD3y5LRRfrYXSYd35qDOe5WuTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302362;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1lgSH5IuSLix0Y5Q87huJLSem8KubFPPy50MySmjKP8=;
	b=R7zK9db2l45SvJAGBVTS7u/MkYesPLpsxWUwEXM1qH2aT2KVhEKopx8BFjQYShyz71pA
	 BILH/MGhEUGaGhM7WMeZE56VCT7agdttlVQs7LMVsIZ4eSYOFvjAS8/KeON/avdq3WAAC
	 4lKvZnKKEKYSvxhBfxOXZcd4ggUu16lDfT7+0P50zFqSoxyMvAlgubmF/KtfS5BjrTQ0H
	 0xwila+MTZytbUWb6p+Mw4igrcDYW4qDhbEm8J0EhUEocknphPYmkLQ5OYfVIFv+dodKF
	 SYUvbpgY+59meJq93RCPBSwHJFe1NzO0n2fJo2GXlGqHm4/137wGjUaA1sxYFh9fh6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgUEMCiU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AD606C664
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgUEMCiU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A851F008A1;
	Tue, 10 Nov 2026 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302361;
	bh=1lgSH5IuSLix0Y5Q87huJLSem8KubFPPy50MySmjKP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LgUEMCiUH2lU8GtyM2P3dC/cJl6bV1TVHO5hk3KByLZ90bsVLRMFUi7jpANyh/wVG
	 YVRfk18tHXTX9iqGxzK/CaHM1vd9MIbrf8uF/NkcTe63v4OeanR6zwYN1qL4EB/vxx
	 kPvU1NvCAkIRA/288HfFguyLdO1+hNOUCt4oXedIoU3cYkBaDmivVAqXBuz2zn4p23
	 V3c38rCT00uxd81iuF+CvOUOL3mrDDZAF+HQZTO6MRz5DpWeT8bzo1pwrKIMZTgd0s
	 EP92SXJT2fpuLHbFfB5knewq5ZNqBZIOon8hGfLGZoo1lKvbp4UyViFRoDF5+E1vYZ
	 HWlXbttV8+26w==
Subject: Re: [PATCH net] xfrm: delete migrated old states before dropping
 their references
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shinta.sugimoto@ericsson.com, yoshfuji@linux-ipv6.org,
 nakam@linux-ipv6.org, netdev@vger.kernel.org, junvyyang@tencent.com,
 stable@kernel.org, corvus@tencent.com
Date: Tue, 10 Nov 2026 09:19:20 +0000
Message-ID: <179430236030.994134.16814357178144716775@kernel.org>
In-Reply-To: <20261106090300.29203-1-juny24602@gmail.com>
References: <20261106090300.29203-1-juny24602@gmail.com>
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

- [High] This patch fixes the Stage 4 x_cur[] path but leaves a matching
  use-after-free on the restore_state error path in xfrm_migrate()…

--

xfrm: delete migrated old states before dropping their references

This patch reorders Stage 4 of xfrm_migrate() so the old states in x_cur[]
are deleted before their lookup references are dropped. The states then
stay alive during xfrm_states_delete(), even if an expiry timer or a
concurrent deletion has already removed them from the state tables.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cea6842e6454d..39ca04432220b 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4726,8 +4726,8 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  
>  	/* Stage 4 - delete old state(s) */
>  	if (nx_cur) {
> -		xfrm_states_put(x_cur, nx_cur);
>  		xfrm_states_delete(x_cur, nx_cur);
> +		xfrm_states_put(x_cur, nx_cur);
>  	}

[Severity: High]
This fixes the x_cur[] path. Does the restore_state error path in
xfrm_migrate() still have the same use-after-free for the x_new[] states?

net/xfrm/xfrm_policy.c:xfrm_migrate() {
    ...
restore_state:
	if (pol)
		xfrm_pol_put(pol);
	if (nx_cur)
		xfrm_states_put(x_cur, nx_cur);
	if (nx_new)
		xfrm_states_delete(x_new, nx_new);
    ...
}

In Stage 2 the new state is stored without taking a reference:

	xc = xfrm_state_migrate(x, mp, net, extack);
	if (xc) {
		x_new[nx_new] = xc;
		nx_new++;

By this point xfrm_state_migrate()->xfrm_state_migrate_install() has
already published xc with xfrm_state_insert() or xfrm_state_add(). The
state tables now own its only reference, and __xfrm_state_insert() has
armed mtimer.

Once published, xc can be found by SPI lookup on the data path. Its curlft
was copied from the old SA by xfrm_migrate_sync(). That means it can be
deleted without xfrm_cfg_mutex, for example:

  xfrm_state_check_expire()   /* hard byte/packet limit reached */
    hrtimer_start(&x->mtimer, 0, HRTIMER_MODE_REL_SOFT);
  xfrm_timer_handler()
    __xfrm_state_delete()
      xfrm_state_put()        /* drops the only reference */

The 1s mtimer reaching hard_add_expires with the copied add_time has the
same effect.

Userspace can still reach restore_state after xc has been published. One
way is xfrm_policy_migrate() returning -ENODATA (no template matches) or
-ENOENT (dead policy). Another is a later entry's xfrm_state_migrate()
returning NULL, for example -EEXIST from xfrm_state_add(). That later
entry's xfrm_state_migrate_create() allocates with GFP_KERNEL and can
sleep, which makes the window wider.

If xc has already been freed by then, xfrm_state_delete(xc) would take
xc->lock and read xc->km.state on freed memory. If the slab has been
reused, this could also lead to list corruption and another put.

Reordering cannot fix this one, because xfrm_migrate() never holds its own
reference on the x_new[] entries. Could a reference be taken on xc before
it is installed? The parallel path xfrm_do_migrate_state() in xfrm_user.c
already does this:

	xfrm_state_hold(xc);
	err = xfrm_state_migrate_install(x, xc, &m, extack);

That reference would then be dropped after xfrm_states_delete() in
restore_state, or on the success path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106090300.29203-1-juny24602%40gmail.com
