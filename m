Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693103;
	b=FilmQsgwTsMCLl1dk64Z3ttxydFCusTJzBTgDh5Qj/x01Pybzx85uG5zuyO46/4tHZfJ
	 m5pX13vHue7D5LgqyFYhL7M8pgSOSiB9zIjVxF7FctqTwSAsTA2VS0OOT5vXzxyjUinxh
	 Q/dWymll6UytTjNulI2RLBwI/R3RW3m0bMoumUHpv1N5JIJQd+nqT4VNtiwCDsoc+vd70
	 GIw/Rl/gSFFkJ58mb2yaLcYmPhMnGaShP8MeuhX5TbsBlNjbPbyLC2GIGBpFadY1OyJbT
	 s+IrTFdHY3VyvOUWhyyRHbhBm6oeho91/Da9qnKz0ZEg9n1LfWP3gvjSRbRLLWX4y+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693103;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=C4FRiEF3XHC29fyAyxPUAdACL1J9ejaADAa4/bfxtTg=;
	b=RZX9Em7ZSYrQzPXrGzegj18UdszzF00KXaK8uSvPSd+88el5LF3rtmsduE9qBKkfqqWM
	 wFyNVq9PjkCFi0RRH++L8gjOE2wKXO/kVsOVvk/452fMcYupKxw3fhjBdB5Mqj7SIBAds
	 YY+xmy/DwCZ/PwEqa7QJ9s+K5UqptjJhSw+jicLlLynLlt3IUG9IAUPA5dfyXTGW0lfXN
	 gvaESkk+oQpKe8EQdIZaYDoLJhtGwWAEa5PveAs1xeS5e72TJhloYzAth6zpbakn9TyhW
	 FNPeQxhXZICqpUZwogMReDh2ILfSQFlF2eA5hqjWvOls53CfFK0ZXkdWMmr+8jIQUWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQR9Cek1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788B606A335
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQR9Cek1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECDC1F000C1;
	Tue,  3 Nov 2026 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693102;
	bh=C4FRiEF3XHC29fyAyxPUAdACL1J9ejaADAa4/bfxtTg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dQR9Cek1St3uwl/UF/jJlox2RMlAJ7/lbrI+WxnMK1TLjNwSAYww2TgUY0q5BDIbV
	 JSlOtGJ7Xv2ZpxvFzAB2+QXDgbQ2Md1lGM6OgAy+GTsoPE6hlzow3dQDc/a7pxu7xz
	 2A2UzOxR7NfFrn5JRdmT5pgv7IgNbpQ4+oXGss2z3Yv91de0bD1cAAYj3ReKBepC/r
	 sbi5E1IL+HgJrFrAKi5+l/c5AZkQTVsdIc+RWnlshyLAVrXofePH0rBX6cQu3vMdb3
	 ADRK473bS0iB7cLwtYoHo2qDzzakgGxmh/VmKaHe8qQAvgFnKG7HlSkuCqvKfJQ7ST
	 H+/odQ6UDK6PQ==
Subject:
 Re: [PATCH 05/14] xfrm: state: reject mark with bits outside its mask on add
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:02 +0000
Message-ID: <179369310218.488856.16451031083235649768@kernel.org>
In-Reply-To: <20261102100451.2505200-6-steffen.klassert@secunet.com>
References: <20261102100451.2505200-6-steffen.klassert@secunet.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This is a regression at this commit only, and a later patch in
  the series fixes it.
- [Low] At this commit, XFRM_MSG_ALLOCSPI still accepts XFRMA_MARK
  without calling verify_mark().

--

xfrm: state: reject mark with bits outside its mask on add

This commit adds verify_mark(), which rejects an XFRMA_MARK whose value
has bits outside its mask. It is called from verify_newsa_info() and
xfrm_do_migrate_state(). The commit also removes the mark sanitization
from __xfrm_state_insert(), so such marks are rejected instead of being
silently truncated.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index e45aa1ed5b965..602404ffc4d4b 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1732,9 +1732,6 @@ static void __xfrm_state_insert(struct xfrm_state *x)
>  
>  	list_add(&x->km.all, &net->xfrm.state_all);
>  
> -	/* Sanitize mark before store */
> -	x->mark.v &= x->mark.m;
> -

[Severity: Low]
At this commit, can a mark with bits outside its mask still get into the
SAD through XFRM_MSG_ALLOCSPI?

xfrm_alloc_userspi() does not call verify_mark(). xfrm_mark_get() masks
only its return value, and m keeps the raw attribute:

net/xfrm/xfrm_user.c:xfrm_alloc_userspi() {
    ...
	mark = xfrm_mark_get(attrs, &m);
    ...
}

xfrm_find_acq() -> __find_acq_core() then stores the mark unchanged and
adds the larval state to the hash tables directly:

net/xfrm/xfrm_state.c:__find_acq_core() {
    ...
		x->mark.v = m->v;
		x->mark.m = m->m;
    ...
}

So ALLOCSPI with XFRMA_MARK {0x101, 0xff} creates a larval SA that no
masked lookup can match. That part is older than this patch, because
__find_acq_core() never went through __xfrm_state_insert().

The legacy XFRM_MSG_MIGRATE path is newly affected.
xfrm_migrate_copy_old() copies the existing SA's mark into the clone:

net/xfrm/xfrm_policy.c:xfrm_migrate_copy_old() {
    ...
	mp->new_mark               = &x->mark;
}

Before this patch, __xfrm_state_insert() trimmed the clone's mark. With
the sanitization removed, the clone keeps 0x101/0xff.

The next commit in the series, "xfrm: state: reject mark with bits
outside its mask on ALLOCSPI", adds a verify_mark() call to
xfrm_alloc_userspi() before xfrm_mark_get(), which closes this. Could
that change be folded into this patch, or moved ahead of it?

[ ... ]

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a2587c7e796b4..0723d791b8b70 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c

[ ... ]

> @@ -3370,6 +3390,10 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			return err;
>  	}
>  
> +	err = verify_mark(attrs, extack);
> +	if (err)
> +		return err;
> +
>  	copy_from_user_migrate_state(&m, um);
>  
>  	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,

[Severity: Medium]
verify_mark() checks only attrs[XFRMA_MARK] and returns 0 when that
attribute is absent. Is um->old_mark left unchecked here?

copy_from_user_migrate_state() copies it unchanged:

	ma->old_mark = um->old_mark;

The old SA is looked up with the masked value. So old_mark
{v=0x101, m=0xff} still finds an existing 0x01/0xff SA.

If XFRMA_MARK is not supplied, xfrm_state_clone_and_setup() gives the
clone the raw old_mark:

net/xfrm/xfrm_state.c:xfrm_state_clone_and_setup() {
    ...
	x->mark = m->new_mark ? *m->new_mark : m->old_mark;
    ...
}

Before this patch, __xfrm_state_insert() trimmed that to 0x01/0xff. With
the sanitization removed, the path
xfrm_state_migrate_install() -> xfrm_state_insert() stores the clone as
0x101/0xff.

The masked lookups test (mark & x->mark.m) == x->mark.v, which can never
be true for that mark. Does that leave the original SA deleted and the
migrated SA unreachable?

The later commit "xfrm: state: exact mark/mask match for SPI-keyed
control-plane SA lookups" changes this to
xfrm_state_lookup_exact(net, &m.old_mark, ...). After that change, an
old_mark with bits outside its mask matches no stored SA, and the
request fails with -ESRCH.

That limits the problem to the commits between this one and that one.
Even so, could um->old_mark be checked here too, or could the exact
lookup patch be placed earlier in the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
