Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FB3CA4A9;
	Thu, 10 Sep 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022700; cv=none; b=lm1MA9d5Kr21HOsEyhfQoBwBif3lgL+SFhoB5JpfV+WSGSRgJ1pn4sYRFIMfUhqzHNnaZGWKgd6fOqKewi3uP6NUB+KwzaaXx8FTQxt2CTiStXbeI0ZG0QDiPLraC6hmb4sDYBu/d9/PFVODfQ1cP8SJy8su5dwhpIiXXeL2ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022700; c=relaxed/simple;
	bh=PjYv362revCo4avBeav6JnovRi/SMvmuaUpoVJmI464=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFHGgSKNsv+4LB4451yNnm4RW8e7OT+tCMYMq+PUR3KGa0MXWCcWov5i1daZghwrRoL1qVnqh8dCEhvoNuCPYVIMaYNmluAAKWpCdloeZ1+mWRaKpUiN27fXqgHVrOXH22dDbMmJKFUcnrhaWeZ9sH+NB5cWbUbFzcPVb3txKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2a6kFC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2a6kFC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924531F00893;
	Thu, 10 Sep 2026 06:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022698;
	bh=6zD3JQiC1jlfVhWrsmFwTnMrKYR9qkjb5JFwVg65lS0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L2a6kFC9BqhIHuv6pH51PKIigK8+3rdYHpxW3ahp/TTr6WEFv5nsn2Fix+jU2c6LL
	 lA22X5IDpitG7u8K0t2bZtlW3FPlwwbnlC4ex8++fkwFap7HQSSns0xCb6QgKfMbpN
	 tgmtupj8oElywdkGYkcLN8hSr1/DeELpeV9R13710bQmRORXzdcxnfUXoHAbrJEI0m
	 2pqpY9/essViYIIZzcHJHXCLmN6uD5fORxUqjsk1S8Wdb1oZ1cZY4K6+SljRunp6Q3
	 SCWD3Q8UGP7xUYzZ2ppPoSEr0YbxZyTKn126F/3bQtZEsMUCu0MoXewOzHMbl+AgVx
	 ZCQJ0LBg8rmvA==
Subject: Re: [PATCH net-next] xfrm: add ARIA CBC and CTR support
From: netdev-bot+sashiko@kernel.org
To: his1415@pribit.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 06:44:57 +0000
Message-ID: <178902269711.219967.15840470225546817223@kernel.org>
In-Reply-To: <20260909054530.7861-1-his1415@pribit.com>
References: <20260909054530.7861-1-his1415@pribit.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Duplicated `.compat = "aria"` alias in `ealg_list[]` makes the
  new `rfc3686(ctr(aria))` descriptor's legacy alias permanently…
- [Low] Inconsistent default key sizes (`defkeybits`) between CBC and CTR
  modes for ARIA.

--

xfrm: add ARIA CBC and CTR support

This adds two XFRM encryption algorithm descriptors so ARIA can be
selected for ESP, one for cbc(aria) and one for rfc3686(ctr(aria)).
Both are marked pfkey_supported = 0, so they are reachable only through
the XFRM netlink interface.

> diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
> index 70434495f23f..16c70dc1a426 100644
> --- a/net/xfrm/xfrm_algo.c
> +++ b/net/xfrm/xfrm_algo.c
> @@ -512,6 +512,34 @@ static struct xfrm_algo_desc ealg_list[] = {
>  		.sadb_alg_maxbits = 256
>  	}
>  },
> +{
> +	.name = "cbc(aria)",
> +	.compat = "aria",
> +
> +	.uinfo = {
> +		.encr = {
> +			.geniv = "echainiv",
> +			.blockbits = 128,
> +			.defkeybits = 256,
> +		}
> +	},
> +
> +	.pfkey_supported = 0,
> +},
> +{
> +	.name = "rfc3686(ctr(aria))",
> +	.compat = "aria",

[Severity: Low]
The two new entries advertise different ARIA key strengths: the
cbc(aria) entry sets .defkeybits = 256, while the rfc3686(ctr(aria))
entry sets 160, which - going by the "/* 128-bit key + 32-bit nonce */"
comment on the rfc3686(ctr(aes)) entry a few lines further down - means
a 128-bit ARIA key plus a 32-bit nonce.  So the default for the CBC
variant is ARIA-256 and for the CTR variant ARIA-128.  Was that
deliberate?

For comparison, every other cbc(...) entry in ealg_list[] (cbc(aes),
cbc(camellia), cbc(serpent), cbc(twofish), cbc(sm4)) uses 128, and the
AES CTR counterpart uses 128 + 32.  If ARIA-256 is the intended default
here, should the CTR entry be 288 (256-bit key + 32-bit nonce) to keep
the two consistent?  If not, should the CBC entry be 128 like its
siblings?

As far as I can tell nothing breaks either way: attach_crypt() derives
the key length from ualg->alg_key_len rather than from uinfo.encr, and
with .pfkey_supported = 0 there is no sadb_alg_minbits/maxbits pair to
disagree with, so defkeybits is effectively documentation for these two
entries.  But since it is documentation, having two entries for the same
cipher in the same table imply different default key sizes is confusing
to read.  Please also add the "128-bit key + 32-bit nonce" style comment
on the 160 if that is indeed what the value encodes.

        ^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Should the CTR entry carry a .compat alias at all, given that the
cbc(aria) entry added just above already claims "aria"?

xfrm_alg_name_match() accepts either the name or the compat string, with
no distinction between modes:

net/xfrm/xfrm_algo.c:xfrm_alg_name_match() {
	return name && (!strcmp(name, entry->name) ||
			(entry->compat && !strcmp(name, entry->compat)));
}

and xfrm_find_algo() only ever acts on the first matching entry:

net/xfrm/xfrm_algo.c:xfrm_find_algo() {
	for (i = 0; i < algo_list->entries; i++) {
		if (!match(list + i, data))
			continue;

		if (list[i].available)
			return &list[i];

		if (!probe)
			break;

		status = algo_list->find(list[i].name, 0, 0);
		if (!status)
			break;
	...
}

Since cbc(aria) comes first in ealg_list[], does a lookup of "aria"
ever reach the rfc3686(ctr(aria)) entry?  It looks like the .compat
field on the CTR entry can never be used, so the CTR variant is only
selectable by its full name via
attach_crypt()->xfrm_ealg_get_byname(ualg->alg_name, 1).

There also seems to be a second effect in a build where ARIA and CTR are
enabled but CBC is not (CRYPTO_ARIA=y, CRYPTO_CTR=y, CRYPTO_CBC=n).  The
probe of cbc(aria) fails, xfrm_find_algo() hits the break and returns
NULL, and attach_crypt() reports:

net/xfrm/xfrm_user.c:attach_crypt() {
	algo = xfrm_ealg_get_byname(ualg->alg_name, 1);
	if (!algo) {
		NL_SET_ERR_MSG(extack, "Requested CRYPT algorithm not found");
		return -ENOSYS;
	}
	...
}

so "enc aria" would fail with -ENOSYS even though a later entry
advertising the same alias is instantiable.  Is that intended?

For comparison, the existing rfc3686(ctr(aes)) entry in the same table
sets no .compat because "aes" is owned by cbc(aes), and the other
pfkey_supported = 0 entries here (cmac(aes), rfc7539esp(...)) omit
.compat as well.  Would dropping .compat from the rfc3686(ctr(aria))
entry match that convention?

> +
> +	.uinfo = {
> +		.encr = {
> +			.geniv = "seqiv",
> +			.blockbits = 128,
> +			.defkeybits = 160,
> +		}
> +	},
> +
> +	.pfkey_supported = 0,
> +},
>  {
>  	.name = "cbc(twofish)",
>  	.compat = "twofish",

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909054530.7861-1-his1415%40pribit.com
