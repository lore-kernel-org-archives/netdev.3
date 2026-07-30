Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C743846C;
	Thu, 30 Jul 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418613; cv=none; b=cMQdw8jiZy4KHrvsVotwJiGohRyr1DoRZxM4856rl/qMGIlF19RqVJM06z67H7R6LAGGBGxzaZbeXWdaliF+mxQQzxPCd16S2vIzwKHEM+bZWyQ3Vun2pk5MT3UKxTSRiTwpExhi+s0wRp6rTVbF3X6LbcMuvRfD9/ygmOPp1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418613; c=relaxed/simple;
	bh=cy78vmkSWsMBJa6w7Nx+k4PAR86/jFxz+3HWwQjx5lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7jLvrazrC5jX+yRjUBdE2elTsde3enQVQKtxJpqVNN8i9Z2YDKMdtDclwgsD4MMBCb4aztfLrT9FXY0hmOfsieHjL+hPr4qbTzwNuuYuLaa4Z0EdJppzYMGCWQ4sGrfdF4nn1qIOiWn3qhCBedX1Zyv8+dTMaoC+xlrRlmYs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD6dZVsq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD6dZVsq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DD1F000E9;
	Thu, 30 Jul 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418611;
	bh=ViilNJPgoMkwo2zOy3hAi/9IjN6+I9KEXX+bony59A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BD6dZVsqY9UCd0d4Hfz0+jZzD419tY6GWKb+Oyfn3EQ5eN8p4Oyh+p8p66bJiD85N
	 ZWJ7zEJV98FBm+GkWyj/lFKu+33JF28cG140sxEP/QvdPsROe/saHt2Kb5DlLXJ0Sq
	 xC7klYv89xIZt2hTsv3APFDia1gBwgJUOsX/JTVPiyL/JAqx7l/1KjPMvuRZcEPCuR
	 XT7hxtYowbUuuyFJg3uepjy/kqJmS1SZ1V6jN9sYM98/DyqpPH6sK7yiCSZGyFz5Wi
	 HvXodJYJOMBl3pwljvSop+KjeazH3hwT+ssxxPiXKpS1ZDb1YC8AY3pfcRueU/wN1t
	 YwtP5NK1dWeWA==
Date: Thu, 30 Jul 2026 14:36:47 +0100
From: Simon Horman <horms@kernel.org>
To: hexlabsecurity@proton.me
Cc: David Heidelberg <david@ixit.cz>, Doruk Tan Ozturk <doruk@0sec.ai>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Robert Dolca <robert.dolca@intel.com>, oe-linux-nfc@lists.linux.dev,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3] nfc: fdp: bound the device-reported read length and
 fix an skb leak
Message-ID: <20260730133647.GC51943@horms.kernel.org>
References: <20260724-b4-disp-e8ec6012-v3-1-3a6f3a2fee47@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-b4-disp-e8ec6012-v3-1-3a6f3a2fee47@proton.me>

On Fri, Jul 24, 2026 at 06:22:55AM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> fdp_nci_i2c_read() takes the next packet length from two device-supplied
> bytes and never validates it. The value is a u16 used as the
> i2c_master_recv() count into a 261-byte on-stack buffer: a malicious,
> counterfeit or malfunctioning controller (or an i2c bus interposer) can
> drive it far past the buffer for a stack out-of-bounds write that
> clobbers the canary and return address, or below the minimum frame size
> (directly, or by truncating the computed sum) so the header/LRC strip
> and the next length read run past a short receive. Reject a length
> outside [FDP_NCI_I2C_MIN_PAYLOAD, FDP_NCI_I2C_MAX_PAYLOAD], as a
> corrupted packet already is, and force resynchronization.
> 
> The same loop allocates one data skb per iteration and assumes a length
> packet followed by a data packet; a device that sends two data packets
> in one call leaks the first skb when the second allocation overwrites
> it. Free a previously allocated skb before allocating the next.
> 
> Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
> Cc: stable@vger.kernel.org
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3:
>  - Rebase on current net; no code change since v2. Doruk Tan Ozturk
>    independently found the same missing bound (0sec,
>    https://lore.kernel.org/all/20260720132133.69635-1-doruk@0sec.ai) and
>    noted there that this v2 is the more complete fix -- it also rejects the
>    sub-minimum length Simon flagged and closes the skb leak. Reposting now
>    that the driver has an active maintainer.
>  v2: https://lore.kernel.org/all/20260616-b4-disp-b1f8ab4c-v2-1-2d1fe5955325@proton.me
> 
> v2:
>  - Also reject next_read_size < FDP_NCI_I2C_MIN_PAYLOAD, not just
>    > FDP_NCI_I2C_MAX_PAYLOAD (Simon Horman). The small value is reachable
>    both directly (tmp[2] == 0 && tmp[3] < 2) and through the u16
>    truncation of the computed sum (e.g. 0xff,0xff -> 65538 -> 2); a single
>    range check on the stored value covers both, and also keeps the next
>    length-field read from running on stale buffer bytes.
>  - Fold in a fix for an skb leak in the same function (two data packets
>    in one call overwrite and leak the first skb).
>  v1: https://lore.kernel.org/all/20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me
> 
> Reproduced in-kernel on x86-64 (Linux 7.1.0-rc5, CONFIG_KASAN_STACK=y)
> with a faithful port of the read loop, and at full device magnitude with
> a userspace AddressSanitizer model:
> 
>   Stack OOB write
>     A  no bound, next_read_size 281 -> 20 B past tmp[261]:
>          BUG: KASAN: stack-out-of-bounds in i2c_master_recv...
>          Write of size 281 ... This frame has 1 object: [48, 309) 'tmp'
>     B  bounded to <= FDP_NCI_I2C_MAX_PAYLOAD:   no KASAN report
>     C  well-formed (len 5):                     no KASAN report
>     ASan model, full u16 next_read_size = 65535 -> 65274-byte
>     stack-buffer-overflow WRITE on both -m32 and -m64; bounded build clean.
> 
> skb leak (slabinfo active-object delta over 20000 reads, two data
>   packets each, measured after a slab shrink)
>     without the fix:  skbuff_head_cache +20047, skbuff_small_head +20057
>                       (one orphaned skb per call, unreclaimable)
>     with the fix:     ~0

Reviewed-by: Simon Horman <horms@kernel.org>

