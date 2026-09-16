Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AA3E0C4D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537711; cv=none; b=ZsSgJtTQmpteSQSfwJ+MlIL8qXkJ0xJQnWZEKwenq+0Ip3lMdGCwNbX6G6Xd3uCa+P2QFtT8hkETO4+aY2bbDfHzTuMm0Ej/c3FnRsRh/Zm39AycPlEoG3sAz9LxJwqc1gkGaJjmdhPbM/rtG2yNYgwu+WckdjXnCMQm95yDvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537711; c=relaxed/simple;
	bh=WpQpzE27JX9cYmRFjdY4LlsPimeygl/7S1wbjKiiTBY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFLoj1la+2+hWLjrbO4u3GygXZcAsUntQ3Lm8QkQxFvym+4X6WkkWk2xd/movgwd3zehAS1dzUjffvFYGibYSdTXP5diJ3vk3Qf+yT4EAV36Y19lwNjN2Czxrcq4GkpRKQQRRb0FMscwimtcsYneEtBQRbyLwpZX0OFCoDhGwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q73s6+X8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q73s6+X8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAA81F00893;
	Wed, 16 Sep 2026 05:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789537709;
	bh=B5OTlqNSBn0pbJJZ8WLaYz/2RI7m2Gjf/uQlqD/Me84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q73s6+X8njka0egHhWm069TzlkaT5DcrxkjdVO9RB5vnLuv2EtrriQ/0jtuPO1CzZ
	 aDeaCn69bACEa4Oc7RHVWwWFJlktRJOVIk6eHlbeFyE6WpJN91QwJcDPUm4COn9GTm
	 qTHRvfJfUOQCj4KJTz1IUw/wiZCcUgaLpn12cxbH5IimfyWk+LALPV345ShVgoQ1Xr
	 enz9OZu4l9KPFgV5/lGq2LKjGGmtE/7/qNkEZNMvUR80mf37aqM9A5VSIYyeFqQpkc
	 3us44TuYz2LeHUYNU8oV9Xk/xMEQlZelVWuR/YqH0fGxZ5qM+YBdKVmnZKG7Gqbzz4
	 4eiwYuqr6Zt4g==
Subject: Re: [PATCH] net: fealnx: remove never-true 486 CPU check
From: netdev-bot+sashiko@kernel.org
To: enelsonmoore@gmail.com
Cc: kuba@kernel.org, u.kleine-koenig@baylibre.com,
 arend.vanspriel@broadcom.com, johannes@sipsolutions.net, mgr@kernel.org,
 benato.denis96@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shaojijie@huawei.com, aleksandr.loktionov@intel.com
Date: Wed, 16 Sep 2026 05:48:28 +0000
Message-ID: <178953770825.22033.17119468095020104751@kernel.org>
In-Reply-To: <20260915024638.198865-1-enelsonmoore@gmail.com>
References: <20260915024638.198865-1-enelsonmoore@gmail.com>
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

- [Medium] Inverted rationale in the commit message of "net: fealnx:
  remove never-true 486 CPU check": the log states that after 486…
- [Low] The block comment above the burst/FIFO register setup in
  drivers/net/ethernet/fealnx.c:netdev_open() was rewritten from the two…
- [Low] The patch removes the last user of asm/processor.h in
  drivers/net/ethernet/fealnx.c (`boot_cpu_data.x86`) but leaves the…

--

net: fealnx: remove never-true 486 CPU check

The patch drops the boot_cpu_data.x86 <= 4 test in netdev_open() and keeps
the value that the else arm used to assign, np->crvalue = 0xe00.  The block
comment above the burst setup is reworded at the same time.

A few questions below.

> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index bdc38aac58509..708b61f219156 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c

>     The fealnx driver contains a check for boot_cpu_data.x86 <= 4.
>     This field encodes the x86 generation (3 = 386, 4 = 486, etc).
>     Therefore, since 486 support was removed from the kernel in commit
>     8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
>     condition is always true. Remove the check.

[Severity: Medium]
Should this read "always false" rather than "always true"?

boot_cpu_data.x86 is the CPU family (4 == 486, 5 == Pentium), so once 386/486
support is gone the minimum family is 5 and:

	if (boot_cpu_data.x86 <= 4)

can never hold.  The subject line already says "never-true", so the body looks
inverted with respect to the subject.

The code change matches the "always false" reading, since it deletes the
np->crvalue = 0xa00 arm and keeps the else value:

	np->crvalue = 0xe00;	/* rx 128 burst length */

Taken literally, the "always true" wording would call for the opposite edit
(keep 0xa00, rx burst field 0b101 instead of 0b111).  Could the changelog be
reworded so that anyone revisiting or reverting this hunk later does not
program the other burst value?  It may also be worth mentioning that the hunk
was already compiled out for MODULE, non-i386 and UML builds.

> @@ -839,8 +839,7 @@ static int netdev_open(struct net_device *dev)
>  
>  	/* Initialize other registers. */
>  	/* Configure the PCI bus bursts and FIFO thresholds.
> -	   486: Set 8 longword burst.
> -	   586: no burst limit.
> +	   No burst limit.
        ^^^^^^^^^^^^^^^

[Severity: Low]
Does this new line agree with the code below it?  A few lines further down
netdev_open() still programs a finite 8-longword bus burst into BCR:

	np->bcrvalue = 0x10;	/* little-endian, 8 burst length */
	...
	iowrite32(np->bcrvalue, ioaddr + BCR);

Per the encoding table kept in the same comment ("Burst length 5:3", 0 1 0 ->
8), 0x10 sets bits 5:3 = 0b010, i.e. an 8-longword limit.

Since the removal of the CPU check makes this unconditional, would it be
clearer to drop the line along with the conditional, or reword it to describe
what is actually latched (BCR: 8-longword bus burst, TCRRCR rx burst field at
maximum)?

Also, the retained inline comment on np->crvalue = 0xe00 says "rx 128 burst
length" while the table above maps 1 1 1 to 256.  That inaccuracy predates the
patch, but it is now the only case the header comment describes.

The comment rework itself is not mentioned in the changelog, which only
mentions removing the CPU check.

>  	   Burst length 5:3
>  	   0 0 0   1
>  	   0 0 1   4

[ ... ]

> @@ -858,13 +857,7 @@ static int netdev_open(struct net_device *dev)
>  #ifdef __BIG_ENDIAN
>  	np->bcrvalue |= 0x04;	/* big-endian */
>  #endif
> -
> -#if defined(__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
> -	if (boot_cpu_data.x86 <= 4)
> -		np->crvalue = 0xa00;
> -	else
> -#endif
> -		np->crvalue = 0xe00;	/* rx 128 burst length */
> +	np->crvalue = 0xe00;	/* rx 128 burst length */

[Severity: Low]
This removes the last user of asm/processor.h in the file, but the include and
its justification comment near the top of drivers/net/ethernet/fealnx.c are
left behind:

	#include <asm/processor.h>	/* Processor type for cache alignment. */

After this patch, git grep boot_cpu_data on the file returns nothing, and a
grep for other plausible users (cpu_relax, cpu_data, cache_line*) also finds
nothing.  Should the include be dropped together with its only user?

>  
>  
>  // 89/12/29 add,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915024638.198865-1-enelsonmoore%40gmail.com
