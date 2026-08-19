Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D53D349F;
	Wed, 19 Aug 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129747; cv=none; b=hs9iMByWG9SH1z26o6czw9xnd8o4W5FydeStta3/S3o8rLlf0xLKxRCe5tQ7M6i/iaOe3R8og7oUKye7Y5wqadbtf9H3tPrGK2zZBNw/gfzKhsbtjS18SKX0PyKgyzs2HWV45rDnjgdh84TFkbJoewdYQ32bBC3eY4enupMfwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129747; c=relaxed/simple;
	bh=C/qJHx+4Q8BcGWWHxL0k9DPwVEOdJLKR1DBaGUiWcBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNOU03N5Cf+9UhbWb9vbui/fwUQwEb6e+cv803VmgXutXKkK9zv5v5/t3xx2+NdLolrHsGDha04zHu/uV6WtiP+0bGMbnpXxqQTZTzhEcWBNltz9Aa5cHIVYa91YlqfyGpyUe8lW6TOy3AbR/OTAS7J1F5PutHgq72COJ+ePHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjYKYqcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjYKYqcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AED1F000E9;
	Wed, 19 Aug 2026 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787129738;
	bh=Bw/pboriH/6QddCg1FhXxRkXlE4opBPyc98EUIIfwgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mjYKYqcPKLPpw9Iy3L2RSkldZ4+4BFuU3sf19WVXL7P1lHyEw2VPK8uNu4cg2Nbmm
	 dwx02RMw4Bs03W2SjPovaLYS8CqccErnj7nIEUJstlNnn40RMrVmtBqmbGukCOA8T0
	 gz8gYtlJ0nWkaISST6dvAvKW3SgogHY2AMBdt3pDn4H0L6z2OZqQxcwBL6Ivv7WZEz
	 5GCFtzln1S4nMLuDcqFERcMEoTjf/DQngofRPrLpCrqflVqIqf/kkBufHZ+iAIv6wu
	 R44XHLerrFppwiuq0s7Zf3gVENf1nFfiEjOIjxguNUe1Ob7YufuRg2DzDS0DAyTY23
	 /ZboQQdlLTo0g==
Date: Wed, 19 Aug 2026 09:55:33 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Czernohous <mczernohous@gmail.com>
Cc: netdev@vger.kernel.org, Rain River <rain.1986.08.12@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tobias Diedrich <tobiasdiedrich@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] forcedeth: fix off-by-one when saving/restoring
 non-PCI config space
Message-ID: <20260819085533.GM265046@horms.kernel.org>
References: <178682367884.3748309.5288746298966501007@gmail.com>
 <178682367885.3748309.10595890901761762683@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178682367885.3748309.10595890901761762683@gmail.com>

On Sat, Aug 15, 2026 at 09:54:38PM +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
> 
> nv_suspend() and nv_resume() walk the non-PCI configuration space with
> 
> 	for (i = 0; i <= np->register_size/sizeof(u32); i++)
> 
> which runs one iteration too many. saved_config_space is declared as
> 
> 	u32 saved_config_space[NV_PCI_REGSZ_MAX/4];
> 
> and NV_PCI_REGSZ_VER3 is equal to NV_PCI_REGSZ_MAX (0x604), so on a VER3
> device register_size/sizeof(u32) is exactly the array length and the last
> iteration addresses one element past the end.
> 
> The element it lands on is np->name_rx[0..3]: saved_config_space[] is
> followed immediately by char name_rx[IFNAMSIZ + 3], and char needs no
> padding. Nothing observable is corrupted by that, because nv_request_irq()
> rewrites name_rx with sprintf() before it is ever passed to request_irq().
> The bug is the out-of-bounds access itself, which UBSAN reports and which
> CONFIG_UBSAN_TRAP=y turns into a trap that aborts the running kernel code,
> plus an MMIO read and, on resume, an MMIO writel() to base + 0x604, one
> dword past the range the driver mapped:
> 
> 	np->base = ioremap(addr, np->register_size);
> 
> VER1 and VER2 devices stay inside the array, but they too get the stray
> read and the stray write one dword past their own window.
> 
> Caught by UBSAN on an Apple Macmini3,1 (MCP79) during a deep S3 cycle.
> The splat below is trimmed: the build path in the file name, the CPU
> and taint lines, the Workqueue line, the "?" hint frames, and the
> frames below device_suspend are all cut. The kernel was tainted, with
> an out-of-tree nouveau and CPU_OUT_OF_SPEC; forcedeth itself was the
> stock module.
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/ethernet/nvidia/forcedeth.c:6225:25
>   index 385 is out of range for type 'u32 [385]'
>   Call Trace:
>    dump_stack_lvl+0x5d/0x80
>    ubsan_epilogue+0x5/0x2b
>    __ubsan_handle_out_of_bounds.cold+0x54/0x59
>    __this_module+0xe398c/0xe9010 [forcedeth]
>    pci_pm_suspend+0x80/0x170
>    dpm_run_callback+0x51/0x160
>    device_suspend+0x1a2/0x4a0
>    ...
> 
> Both loops are hit. UBSAN reports each source location only once per module
> load (__ubsan_handle_out_of_bounds() calls suppress_report(), which does
> test_and_set_bit(REPORTED_BIT, ...) on the struct source_location), so the
> two splats land in the first S3 cycle after the module is loaded and later
> cycles are silent even though the access still runs off the end every time.
> In that first cycle line 6225 is reported from pci_pm_suspend and line 6240
> from pci_pm_resume.
> 
> The same off-by-one was fixed in nv_get_regs() by commit ba9aa134287f
> ("forcedeth: fix buffer overflow") in 2012; these two loops were missed.
> The suspend and resume side was reported on LKML in September 2013 by Marc
> Weber, with the same analysis and the same one-character fix, but the patch
> was attached rather than sent inline and the thread ended there.
> 
> Use < instead of <=, which saves and restores exactly register_size bytes.
> 
> Fixes: 1a1ca86158ee ("[netdrvr] forcedeth: save/restore device configuration space")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> Assisted-by: Claude:claude-opus-5

Reviewed-by: Simon Horman <horms@kernel.org>

