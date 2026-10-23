Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753038;
	b=ug67cCdHnxXKg+uiMIW0Rbp8X2Bu84rTpx/+7oFGBgNVOohYiikynuAzJH/6gq+2hQNa
	 AYBOSKurcT6YIKpqr2qqKB/aalPJpSpGEf0OeE1Buqn+UfEtCpXRpJg6wUMdRaLvUAKFP
	 Gtd+TmN6u8ZfkLE36rM5qCGjoMsXpjtB8zZM8nDme7/GzltN7lVTbRHIf8JWLXeFlnHkG
	 f7gi+VyF7ylR3VleVB6SBjVSIL9+4e1TdXNQ5vjS/PfADP7NRTgALHNTDn4tmt+IK8X1Z
	 phBu/8dbH9LjwtrUV/sq7b2S7VHCDiLgd14mB4sbMga1ATGWPVi9tkGKZOkriep4Jvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753038;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HcMEWNk0PrzIlARA4ivkGz0J4NFUazDyhITo0HMlvAU=;
	b=DNV6NR//a4PphY+Ap05w3C1Rle6/PAsrFOqozEksOa6JPX9FAZuregVDvrZBda4XHfGe
	 AqbjBShbjnL69YX3PuKm58OZv+57lDXt6cArJH/+yANkDRMYJcVvSESqjrEWk3cl9B1pI
	 4YwmshlyytzUcizxjPfXd3r9zUy8HBfF1sD6Ledal6g8Db/NALjv4jHgquxKqVpiQqXwD
	 7/bLxXP0opxqFAB3xz6pTCgAzXjMHKU5TKbwtC5HZVLpEZuO9sCZbBX+l5zegASX1kQB7
	 HfFed1oUcn8iPMksBElVH5HmlMCCLa30x8UIEwTErW7lzNib5PtuOviufafFCfJb9cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0wb45n2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B1606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0wb45n2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C81F01825;
	Fri, 23 Oct 2026 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753037;
	bh=HcMEWNk0PrzIlARA4ivkGz0J4NFUazDyhITo0HMlvAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0wb45n2ibBbXVex2hxODLWd4ahjpfZZryiBceqX0a/FImeOEcA58MKmnYOAZz1QZ
	 9isuHiCVt82XaRRC/GZOgeM7KRVIJpQngBFAcppCKpGxonOFWUj8dVI94xe2og2/1r
	 6sSgSuWGAwqnkwmGrX9nm2GYwfgzP5KX+VZBNi0XllAz/fTmTMcJTS+KMJVxhYKd14
	 fFgGVyCWQ4+7+60bKbP+KzUuxosOx02DY9RdAZ/7BsN+31mAS550+e8YG/ssTnSXba
	 sGkeT5qKmionYUK74lDSHywIOfhUgisnSzZXy/aZG2MTdxXXG0l6U5wJElWjUlMJcA
	 sDn6TsCIL9HVA==
Date: Fri, 23 Oct 2026 11:57:14 +0100
From: Simon Horman <horms@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: gred: keep the qdisc lock while updating
 the table
Message-ID: <20261023105714.GJ708417@horms.kernel.org>
References: <20261021155434.66572-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155434.66572-1-phx0fer@gmail.com>

On Wed, Oct 21, 2026 at 11:54:33PM +0800, Dudu Lu wrote:
> gred_change_table_def() publishes table->DPs/def/red_flags under
> sch_tree_lock(), drops the lock, and then keeps writing state the
> datapath reads without it:
> 
>   - gred_enable_rio_mode()/gred_disable_rio_mode()/gred_disable_wred_mode()
>     set/clear table->flags;
>   - the red_flags_changed loop writes table->tab[i]->red_flags;
>   - the shadowed-VQ loop frees table->tab[i] and clears the slot.
> 
> gred_enqueue() and gred_dequeue() read those same fields (test_bit on
> table->flags, q->red_flags, t->tab[]/t->DPs) under the same root lock on
> another CPU, so the post-unlock writes race with the enqueue path:
> 
>   BUG: KCSAN: data-race in gred_change_table_def [sch_gred] / gred_enqueue [sch_gred]
>   read (marked) to 0xffff000007ad3b00 of 8 bytes by task 110 on cpu 0:
>    gred_enqueue+0x88/0xc60 [sch_gred]
>    dev_qdisc_enqueue+0x4c/0x19c
>    __dev_queue_xmit+0x10a4/0x1ea4
> 
> The comment justifying the early unlock only covers the DP-vs-DPs check,
> which the shadowed-VQ free loop relies on; it does not cover the scalar
> mode bits and per-VQ red_flags written afterwards.  Move the unlock below
> those updates so everything the datapath reads is published under the
> lock that protects it.
> 
> Fixes: 6639607ed9de ("[PKT_SCHED]: GRED: Use a central table definition change procedure")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
> 
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest with
> CONFIG_NET_SCH_GRED=m; KCSAN reported the race at the claimed sink.  The
> reproducer source is not posted here per Documentation/process/security-bugs.rst;
> it is available on request.
> 
> Triggering conditions
> ---------------------
> CAP_NET_ADMIN to reconfigure the qdisc; the race is stochastic (long clean
> stretches between reports).
> 
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.

Reviewed-by: Simon Horman <horms@kernel.org>

