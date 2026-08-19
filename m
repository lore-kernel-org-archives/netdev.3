Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F232A3D7
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152174; cv=none; b=N06D27GO+fQiCjJNcfTV1ayqY9G4AfIx942gOsZZtq56XnNDk6oHGt4u28VyT9vs9gJm9J6V+LZnKhriNYZRWjcGm94YMXAwrdk55ALVwqaoRg+LRtH/v7ptVfuyuJCEnRisrkOohOInOlNgYCnnWNHhMugwZVcab+QVwW+2iAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152174; c=relaxed/simple;
	bh=vI4mZ8ID9nWWe7YRkiMDwn0Sq907xgeZdCRCgCui7r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2Ig7fArBiCVdZjpkIyqSsa+e5ONWuyanEfVALk8JaPqb3FXbBEsVtAcF3gsl/HRiDgju+ZCFValIRz6K/rgWQ62KSnJtqoQOqiS1rNcpJw6mp1P+oWxe7Qpstwhjw2+bgXQJ/Vea0mxLecIdrEVF0+C71NVG01jCTqabxj2twU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tY5BVwn4; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tY5BVwn4"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vI4mZ8ID9nWWe7YRkiMDwn0Sq907xgeZdCRCgCui7r0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787152168; v=1; x=1787756968;
 b=tY5BVwn4Xiw8iwdUOGy4mi91yrSPq0/GfLCSfNJJOvbklsaxpai1z9IIUmmaxP347eE3CNdJ
 rI1puLuDqAWMW+1uURApTI77jm63lzNaea8aS0AQSgjucwEfLNbAWjKaj1uzqKhhMqMZ1LVp5Jp
 HtxUEindbIh00Du08E27bXAk=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2601:647:6300:a030:c8df:e66c:f17b:da8f] (2601:647:6300:a030:c8df:e66c:f17b:da8f)
	by smtp.migadu.com with ESMTPS id c88b68efcd18501e;
	Wed, 19 Aug 2026 15:09:28 +0000
X-Mizu-Trace-ID: c88b68efcd18501e
X-Migadu-Flow: FLOW_OUT
Message-ID: <9a164a52-755e-470d-8ad3-58d7e4c2bd35@linux.dev>
Date: Wed, 19 Aug 2026 08:09:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] forcedeth: fix off-by-one when saving/restoring
 non-PCI config space
To: Marek Czernohous <mczernohous@gmail.com>, netdev@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Diedrich <tobiasdiedrich@gmail.com>, linux-kernel@vger.kernel.org
References: <178682367884.3748309.5288746298966501007@gmail.com>
 <178682367885.3748309.10595890901761762683@gmail.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <178682367885.3748309.10595890901761762683@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/15 12:54, Marek Czernohous 写道:
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
>    UBSAN: array-index-out-of-bounds in drivers/net/ethernet/nvidia/forcedeth.c:6225:25
>    index 385 is out of range for type 'u32 [385]'
>    Call Trace:
>     dump_stack_lvl+0x5d/0x80
>     ubsan_epilogue+0x5/0x2b
>     __ubsan_handle_out_of_bounds.cold+0x54/0x59
>     __this_module+0xe398c/0xe9010 [forcedeth]
>     pci_pm_suspend+0x80/0x170
>     dpm_run_callback+0x51/0x160
>     device_suspend+0x1a2/0x4a0
>     ...
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

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> Assisted-by: Claude:claude-opus-5
> ---
>   drivers/net/ethernet/nvidia/forcedeth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index 58d3e55def48..dc804e111564 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -6221,7 +6221,7 @@ static int nv_suspend(struct device *device)
>   	netif_device_detach(dev);
>   
>   	/* save non-pci configuration space */
> -	for (i = 0; i <= np->register_size/sizeof(u32); i++)
> +	for (i = 0; i < np->register_size/sizeof(u32); i++)
>   		np->saved_config_space[i] = readl(base + i*sizeof(u32));
>   
>   	return 0;
> @@ -6236,7 +6236,7 @@ static int nv_resume(struct device *device)
>   	int i, rc = 0;
>   
>   	/* restore non-pci configuration space */
> -	for (i = 0; i <= np->register_size/sizeof(u32); i++)
> +	for (i = 0; i < np->register_size/sizeof(u32); i++)
>   		writel(np->saved_config_space[i], base+i*sizeof(u32));
>   
>   	if (np->driver_data & DEV_NEED_MSI_FIX)

-- 
Best Regards,
Yanjun.Zhu

