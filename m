Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211460;
	b=Dc9IbsJ67eJzpd8v7JKMA5c6HAblr4WvPuw3tAr1zBhe2q343Xj3BBF6Rck3mioEAx32
	 Ax7SFD7YZfgDH7RqCykvd7uATQrqs/E+HYyIP4tE4iL44gAjIq5Qi8K+qA5wfoU8VccI/
	 jpu1vxZA+PT7ceOztiBgeHu+D4n93pznFHkGlHvwdQa6GSVa75QbgzBXQGPmTauzJEG7o
	 YLf/lMMw5QF2/Ru4FUSSdrFU3caQNRRPvi7Rf5krYxOvYqH+Suss/N0RBjsg7VzdSjOsq
	 XLaUi2BXkoAKhr3fVsoo28TNfryrJzoXST69tI47KKE0uJ61u1anD/a8CHm8+0Ld/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211460;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aTB+qmr+k6hrfExn8YMUYkBKlFM/bzuSQoxuiUonvFM=;
	b=d4UGSi3+S+92CSbMGqBHKiHnpx74GGRTeIMm/CPslhvdwQR3SHEYMnG2Rn2CCMQKJfPN
	 Kkw55QUXcXHWjrMKeqiKBCaGi0aMV/J0+npB+an9h+9B35PC/8PUMFt2Rx30u1w3kxwDq
	 kctI21UUY6ZldquB/q98zQUS1+4S9fT2tbY5WEj3WB9q/l/DqbdUcJmRQlNDjQtUq9Lvu
	 Y+xuz93mgbNq3riq10eC+XwxQK3yTIcD1WLONW/vQfjeg6rBCae0BAVcn+pXFotFJb7cm
	 97vL8VPbX+vfS1T5pBkIl60VEQxPqWijFWIABWRv0PmPpU1W/VVloFrLTwes7L1qOAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYt2jHLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E0606A31D;
	Wed, 28 Oct 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYt2jHLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7926B1F01825;
	Wed, 28 Oct 2026 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211460;
	bh=aTB+qmr+k6hrfExn8YMUYkBKlFM/bzuSQoxuiUonvFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DYt2jHLb8pZDWRnfkToccjW+vE2T0iI7ivXTNIJNgxs91DqMaLoDImSYTgVI+Gh4H
	 wfRxWEHJe8UhpBiHByk44xOf39qW2vXEdFfr8YWZKeFEEkcze9xa12vHdKSh0aMWoa
	 eopEMcnFcqKxVmCjWLsM8CPcwdc3uplOAL1jYqyCeHfzCm8YjOeXS2cY8rvKkayZ9c
	 rMJUZ1boofElRx/0CKi+tU1iuHl8suzd+pIVB7/T+vHN0SDQo+uwiz9sAJjYN/jkVK
	 lOTNLWE7tvr+S4BkYCmRn28yYZoayVqTS26GACt+Lthd6v3KfbSgGdXNdJg46+43Eu
	 1Y4T4jX4gnvVg==
Subject: Re: [PATCH] net: octeontx2: fix building without DEBUGFS
From: netdev-bot+sashiko@kernel.org
To: arnd@kernel.org
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de,
 sumang@marvell.com, nshettyj@marvell.com, hkelam@marvell.com,
 yijiangshan@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 18:17:39 +0000
Message-ID: <179321145903.3134.9602070499142320900@kernel.org>
In-Reply-To: <20261027151737.386155-1-arnd@kernel.org>
References: <20261027151737.386155-1-arnd@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fix the CONFIG_DEBUG_FS=n build.
- [Low] The Fixes tag points to the wrong commit.
- [Low] The commit message says making the member unconditional will
  "waste the 8 bytes in the structure in this config".

--

net: octeontx2: fix building without DEBUGFS

This commit removes the CONFIG_DEBUG_FS guard around the rvu_dbg member
of struct rvu. The goal is to let the rvu->rvu_dbg.npc references in
cn20k/debugfs.c build when debugfs is disabled.

> Remove the #ifdef and waste the 8 bytes in the structure in this
> config.

[Severity: Low]
Is the 8 byte figure accurate? rvu_dbg is embedded in struct rvu by
value, not as a pointer.

struct rvu_debugfs contains 12 struct dentry pointers, 6 struct dump_ctx,
a cpt_ctx[MAX_CPT_BLKS] array (MAX_CPT_BLKS is 2) and two ints:

struct rvu_debugfs {
	struct dentry *root;
	...
	struct dump_ctx nix_tm_ctx;
	struct cpt_ctx cpt_ctx[MAX_CPT_BLKS];
	int npa_qsize_id;
	int nix_qsize_id;
};

That comes to about 208 bytes on 64-bit.

> Fixes: 45229e9a9ab5 ("octeontx2-af: Extend debugfs support for cn20k NIX")

[Severity: Low]
Is this the right commit for the Fixes tag?

At 45229e9a9ab5, rvu_debugfs.c holds the only references to rvu_dbg, and
that file is fully wrapped in #ifdef CONFIG_DEBUG_FS. At that point
cn20k/debugfs.c contained only seq_file print helpers.

The always-built cn20k/debugfs.c seems to have first referenced
rvu->rvu_dbg in 1396771b0b7741 ("octeontx2-af: npc: cn20k: Index
management"), which added:

void npc_cn20k_debugfs_deinit(struct rvu *rvu)
{
	debugfs_remove_recursive(rvu->rvu_dbg.npc);
}

The debugfs_create_file() call quoted in the error message came later,
in 1100af13fd14b5. That may also explain why the error only showed up
recently.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index fb4870cd18e9e..3b647e7b4bc20 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -649,9 +649,7 @@ struct rvu {
>  	int			mcs_blk_cnt;
>  	int			cpt_pf_num;
>  
> -#ifdef CONFIG_DEBUG_FS
>  	struct rvu_debugfs	rvu_dbg;
> -#endif

[Severity: High]
Does this build with CONFIG_DEBUG_FS=n?

The definition of struct rvu_debugfs is still inside an
#ifdef CONFIG_DEBUG_FS block earlier in rvu.h, with no #else. So are the
struct dump_ctx and struct cpt_ctx types it embeds:

#ifdef CONFIG_DEBUG_FS

struct dump_ctx {
...
struct rvu_debugfs {
	struct dentry *root;
	...
	int nix_qsize_id;
};
#endif

With OCTEONTX2_AF enabled and DEBUG_FS disabled, struct rvu now has a
by-value member of incomplete type. The compiler would reject that with
"field 'rvu_dbg' has incomplete type".

Every rvu_af object includes rvu.h (rvu.o, rvu_nix.o, rvu_npc.o,
cn20k/*.o, ...). Wouldn't this turn the one error in cn20k/debugfs.c into
a failure in every rvu_af translation unit?

OCTEONTX2_AF does not depend on DEBUG_FS in octeontx2/Kconfig, so this
config can be selected.

Would either of these work instead?

- Move the #ifdef CONFIG_DEBUG_FS so that dump_ctx, cpt_ctx and
  rvu_debugfs are always defined.
- Build cn20k/debugfs.o only when CONFIG_DEBUG_FS is set.

The Makefile currently builds cn20k/debugfs.o unconditionally:

rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
	...
		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \

>  	struct rvu_devlink	*rvu_dl;
>  
>  	/* RVU switch implementation over NPC with DMAC rules */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027151737.386155-1-arnd%40kernel.org
