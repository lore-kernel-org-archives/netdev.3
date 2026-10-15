Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46B35E950;
	Thu, 15 Oct 2026 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040295; cv=none; b=lDMaWbxAxjUg1ojzmOYhpRWYFc7xha5o6XmGQhi3IIiWw45d2Lu9eO7XMC0d2/PZyUd2nnab9iBTsju7jbS+4lUlxJmKmMJ2mQzkjLg0P7Uadhv1D0QD5wX8vcCLnjt65NblWnhBH8m1yJpnb1R0GZV+MSVC0223onYAx/H3w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040295; c=relaxed/simple;
	bh=clUiAKhLEx4WFMI0PNW0Z8EWPCN3W0nXfiaXiKbBvZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjVCPPu8F/fWgOXB9VMNz2Nnd29aZjGEn4BC/NDyK1PluFnq7FMcVRAkghVippAf3Arktlr5eHmB4iBsjXIhw7cMWozP3RKyK8YpHbjVDZ/UiBcrN8ajg7ok7dPKJLNWsb0zrhbxi23dcKBEuPnd/fNiZEv7tpqEQ9jaDsffqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAZgCBxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAZgCBxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB101F000C4;
	Thu, 15 Oct 2026 04:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792040293;
	bh=q158/zsMzI1U2HCglnHVdw7Kf32xTgm9ETONvsqEy24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kAZgCBxL9eWGCOft6x1B3Pog4zCC7kP68oCE/+IqtiQssfKJzgyecNjIPYVuyDvr3
	 DapY5jl3T9nCv6zkcahRLR7KNOd3X7bJSca6JbZS+rsmlvq/vwwXJohuBGd1n3iIcs
	 F5weX3FU8nrEYHDmhrYXyxoXdLfFsH9EGLKlR3F1BalCENigpxBAhDifuQZoFGJkcO
	 XFIMn0a++kcA/qjozmXaewiefl9OcXSPt/lQKBJM/FhYDLKvO5cxHtdCkAGjBl5bu0
	 LLzggU2Jgp3lQwFFtMOobLqm9PQm85mW6Nid7G5iCNDUuFmvIYpUkZJXsF68bXBbo6
	 Z9F6yQQvM/aoA==
Message-ID: <9e10a74b-a73b-4899-a652-898e21de69a6@kernel.org>
Date: Thu, 15 Oct 2026 06:58:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/lib: prefetch ahead in __csum_partial()
To: Rosen Penev <rosenp@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Stapelberg <michael@stapelberg.de>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>
References: <20261014194818.11640-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261014194818.11640-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/10/2026 à 21:48, Rosen Penev a écrit :
> __csum_partial() walks the buffer linearly and reads each cache line
> exactly once. On cores without a hardware prefetcher, such as the 464FP
> in the APM82181, every new line is therefore a demand miss that stalls
> the loop. Packets received by non-coherent DMA are never in the cache,
> so this is the common case for GRO checksum validation: when routing
> TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
> of all cycles and is the top entry in the profile.
> 
> Issue a dcbt MAX_COPY_PREFETCH cache lines ahead in the main loop,
> the same distance csum_partial_copy_generic() already uses. That is
> 128 bytes on the 44x. dcbt is only a hint and never faults, so
> prefetching past the end of the buffer is harmless. Lines that are
> already cached, for example when checksumming data the CPU just wrote,
> are left untouched.
> 
> Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
> routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
> was toggled at runtime, in the same boot:
> 
>                LAN->WAN               WAN->LAN
>                Mbit/s  csum cycles    Mbit/s  csum cycles
>    before      495     30.5%          439     27.2%
>    after       599     15.3%          520     13.7%
> 
> That is 58% less time spent in __csum_partial() per byte.
> 
> The prefetch distance was chosen with an earlier, slower driver
> configuration (median of 3, Mbit/s):
> 
>    distance    LAN->WAN   WAN->LAN
>    none        370        341
>    64 bytes    430        381
>    96 bytes    438        397
>    128 bytes   438        385
>    160 bytes   434        386
>    256 bytes   423        383
> 
> Prefetching the first lines before entering the loop made no
> measurable difference and is not done.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   v3: use MAX_COPY_PREFETCH
>   v2: reword commit message and retest numbers.
>   arch/powerpc/lib/checksum_32.S | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index cd00b9bdd772..5bb872e9e68f 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
>   	bdnz	2b
>   21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
>   	beq	3f
> +	li	r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
>   	lwz	r0,4(r3)
>   	mtctr	r6
>   	lwz	r6,8(r3)
> @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
>   	lwzu	r8,16(r3)
>   	adde	r5,r5,r7
>   	bdz	23f
> -22:	lwz	r0,4(r3)
> +22:	dcbt	r3,r9
> +	lwz	r0,4(r3)
>   	adde	r5,r5,r8
>   	lwz	r6,8(r3)
>   	adde	r5,r5,r0

