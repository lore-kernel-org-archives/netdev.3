Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BB4DE711;
	Wed, 16 Sep 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591754; cv=none; b=IEmY5IHLV3CQWnSzuS1PA3U4jBjpuJEBKLl3kMCNW0PE/u9QfmfTvi3pCB2JYdqt0Al/1msxFFC2HpoKOX+9cmV1NJaSLxINWE6EbTmAzsNFs3h5sCbN8nwRuG+jjG0THGMHh6SZPT+L82UKs/H6fn0Qp4weRLBnn0/RoNPuw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591754; c=relaxed/simple;
	bh=jZm7cvYebjdOTnoSV4XmNqE6abVT7cPvhG1TYilIYzM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ne/RxlgbIIj/nQbdVoOYbep2qrkhj4dN/ByPQ/9rCnmndo6Ni15rgb5wjjNHxfuFuJyw7+yCThH9ZADPoIAx10lPrhSnogKoAE7iV4fLWitixAmQ0gvhNA5Iw2qvc1hP4JwBozizmIUfHVWmGEn4LfNJqHz4duZrax3Oz+6hZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0IYniTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0IYniTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574311F000FF;
	Wed, 16 Sep 2026 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591735;
	bh=5RbcbbDHx5wP8CLc8jRAe7E9kzoDFjTjj5s6whZ9fYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O0IYniTlbLxlQm4+uJr3vyJlIUA8aTbGgbe2MnqSvUeTznfyUiFZcdrAPywankfDY
	 NrUNcwGMy1y0s0/cQevpCLLWtdVrF3ucfPmS0lW34laUT6H/+YoJQB3trjPjU6Wm/+
	 kpjs8m2AiPZHdbObJ0Mms3rXBrFvRdQwvq347iTHZws7n9jN8DhHJAWwxYl9L5OD4I
	 Bu0K6FqwLGHVmsuTzakPCo+BHNO7jksZuQ2CCLHchZ3kAbTRRciZ3jflj/GiqtloBH
	 qCVO4y7Bc0VWYJ5/ioIX//4nLz6ZRZhVT/CnOjynivneE8yCxqCrYtdKH3HvZBAXfi
	 g7W/jY8FzmHmA==
Subject: Re: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU check
From: netdev-bot+sashiko@kernel.org
To: enelsonmoore@gmail.com
Cc: arend.vanspriel@broadcom.com, aleksandr.loktionov@intel.com,
 shaojijie@huawei.com, petrm@nvidia.com, jacob.e.keller@intel.com,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-parisc@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mgr@kernel.org
Date: Wed, 16 Sep 2026 20:48:53 +0000
Message-ID: <178959173388.22033.1828981129063538898@kernel.org>
In-Reply-To: <20260915024551.196126-1-enelsonmoore@gmail.com>
References: <20260915024551.196126-1-enelsonmoore@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Inverted rationale in the commit message.
- [Low] Stale `#include <asm/processor.h>` with a now-false self-
  documenting comment.
- [Low] Comment/code mismatch introduced by the comment rewrite in
  init_registers().

--

net: tulip: winbond-840: remove never-true 486 CPU check

This removes the runtime boot_cpu_data.x86 <= 4 test in init_registers()
of the winbond-840 driver and collapses the surrounding preprocessor
chain so that the i386 non-module case now falls into the generic
architecture branch.  The comment describing the two cache alignment
cases is reworded at the same time.

> net: tulip: winbond-840: remove never-true 486 CPU check

[Severity: Medium]
The subject and the message body say the condition is always true:

    Therefore, since 486 support was removed from the kernel in commit
    8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
    condition is always true. Remove the check.

Is the polarity backwards here?  boot_cpu_data.x86 holds the CPU family
(3 = 386, 4 = 486, 5 = 586), and after 8b793a92d862 the minimum family
for 32-bit builds is 5:

arch/x86/Kconfig.cpu:
    config X86_MINIMUM_CPU_FAMILY
            int
            default "64" if X86_64
            default "6" if X86_32 && (MPENTIUM4 || ...)
            default "5"

So a family <= 4 CPU can no longer boot the kernel and the predicate is
never true, which is consistent with the patch keeping i |= 0xE000 (the
else branch) rather than i |= 0x4800.

Should the wording be something like "the condition is never true, so
the else branch is always taken"?  As written, a reader or a stable
backporter would expect 0x4800 to be the value preserved for i386
built-in builds.

> diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
> index a5581f1d01417..c42eaf0eef642 100644
> --- a/drivers/net/ethernet/dec/tulip/winbond-840.c
> +++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
> @@ -876,24 +876,14 @@ static void init_registers(struct net_device *dev)
>  	i |= 0x02;		/* give Rx priority */
>  
>  	/* Configure the PCI bus bursts and FIFO thresholds.
> -	   486: Set 8 longword cache alignment, 8 longword burst.
> -	   586: Set 16 longword cache alignment, no burst limit.
> +	   Set 16 longword cache alignment, no burst limit.

[Severity: Low]
Does this single unconditional line still match the code below it?  Two
different values are still programmed, and neither one is "16 longword
cache alignment, no burst limit" (which the table just below decodes as
0x8000):

    #if defined(__powerpc__) || defined(__i386__) || ...
            i |= 0xE000;    /* C000 = 32 longwords | 2000 = 32 longword burst */
    #elif defined(CONFIG_SPARC) || defined (CONFIG_PARISC) || defined(CONFIG_ARM)
            i |= 0x4800;    /* 4000 = 8 longwords | 0800 = 8 longword burst */
    #else
            i |= 0x4800;

The deleted "486:" line is the one that described 0x4800 accurately, and
that value is still programmed on SPARC, PARISC, ARM and the unknown-arch
fallback.  Would it be better to drop the prose entirely, or restate it
for both remaining cases?

The 0xE000 half of the mismatch predates this patch; the new part is that
the wording is now unconditional and also covers the 0x4800 branches.

>  	   Cache alignment bits 15:14	     Burst length 13:8
>  		0000	<not allowed> 		0000 align to cache	0800 8 longwords
>  		4000	8  longwords		0100 1 longword		1000 16 longwords
>  		8000	16 longwords		0200 2 longwords	2000 32 longwords
>  		C000	32  longwords		0400 4 longwords */
>  
> -#if defined (__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
> -	/* When not a module we can work around broken '486 PCI boards. */
> -	if (boot_cpu_data.x86 <= 4) {
> -		i |= 0x4800;
> -		dev_info(&dev->dev,
> -			 "This is a 386/486 PCI system, setting cache alignment to 8 longwords\n");
> -	} else {
> -		i |= 0xE000;
> -	}
> -#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
> +#if defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
>  	i |= 0xE000;

[Severity: Low]
With boot_cpu_data gone, is the header include at the top of
drivers/net/ethernet/dec/tulip/winbond-840.c now stale?

    #include <asm/processor.h>		/* Processor type for cache alignment. */

That was the only user of asm/processor.h in this file, and after the
patch the cache alignment selection in init_registers() is purely
compile-time arch conditionals, so the comment no longer describes
anything the code does.  Should the include (or at least the comment) be
dropped in the same change?

> #elif defined(CONFIG_SPARC) || defined (CONFIG_PARISC) || defined(CONFIG_ARM)
>  	i |= 0x4800;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915024551.196126-1-enelsonmoore%40gmail.com
