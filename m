Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364811;
	b=Tz2AI0pNpT5P3CL7VOhGdrW1v0Rn6jjKNvka/euCyZTO8Px9jkWKE9oA5zxF73btKiHd
	 steD5iP10mGjr0R/mEQbBAnl32CeuMiOH7cDLkRhLmFoO9JuwMJ4iHtIqaLLc62b0xNo4
	 ZxE52jo5FXOFk1ihffXFu0LO4U/M8JivwfpZuSRwyATMF1mNpVg62r0u465Xpqc6jBpT6
	 nLVxmK+uKPNJOi3KPxVHrAOjCDl0wn4W8dJlL/1eh84EOKA3NucjcMUpc59IOYYNNVj0B
	 TDiuQiCA0cnyESr8kZuTWoN/QgvBON4wxF7XyJXRH4/kjSBKdK+M2ROCJvdin8A5mPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364811;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=o2HEt9xD9eZQG/V6SR9F/F7e950iKP2VIpuBaoq10yA=;
	b=m5QQCSfameNlVNQU3O1afG48G/BaWW8ofNE/C/FcVhXCAuZxRbfkjtptRzpADk4wwOfg
	 gmNleKi6hdKf8nDkQJan+lyVmNEqHn8BXJV6FelIHnAhDp4I1mwoeUlNDQs3NwSw287Im
	 SUbEpRhTvb18zUCb2jl+7om0iEsmnwyIg4B9of7JRUB0cRXu/nZO/jbLj3FhnGOyoIdW4
	 cpzwUCb3fd+87okKwLRhyr4aS6XMNhaP77ga9aU1mjvgwUUnWZcJBiXuoRE99pqpaNvph
	 HHT3xE+LboTXtBMKLyhlewkvc4kKdxdjBreutQsFD67vZ6VjDc0FIw/cgwgFq7TeiuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csPoUyGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D070606A31F;
	Fri, 30 Oct 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csPoUyGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6911F00A15;
	Fri, 30 Oct 2026 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364810;
	bh=o2HEt9xD9eZQG/V6SR9F/F7e950iKP2VIpuBaoq10yA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=csPoUyGQxQ4IIQLVtzbxVZ+VBOKfvaInaf/FsP5Lg1LzUW5dsExqYLM19d7VBTPrr
	 p042uNvVyq7firnkIbTZDeI2sE66+bUa27uzHNu3haxKN0WCVGbjZlbrxDMxcxW5/7
	 zhItr5wnG4mKq4YWG8daPNJKd9w2QO5lksv7gPBZTK3dJjsaZbidJHUWU2P4cuYgDD
	 jF4hK5W5g/Ji06mat3XaUp+kI9anFIyGimDThWwruS+dBLb/Ua7TA0+VCJDLlgfWtU
	 UXmVY8MxY5XWWSqPy/8I/zgjVAwNUcgFkAQsS6rDzjbs028xyCgDPtIZ2DhmOLgqM6
	 coL5wabcLLKxQ==
Subject: Re: [PATCH net v4 1/3] sfc: ptp: drop the stale frequency reset in
 efx_ptp_start()
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 12:53:29 +0000
Message-ID: <179336480940.3134.13795222150880092351@kernel.org>
In-Reply-To: <20261026123023.3566549-2-alex.austin@amd.com>
References: <20261026123023.3566549-2-alex.austin@amd.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix only changes the EF10/EF100 copy of efx_ptp_start() in
  drivers/net/ethernet/sfc/ptp.c.

Pre-existing issues:
- [Medium] At this commit, efx_phc_adjtime() reads
  ptp_data->current_adjfreq (drivers/net/ethernet/sfc/ptp.c:2129) and…
- [Low] The kernel-doc for struct efx_ptp_data says `@current_adjfreq:
  Current ppb adjustment.` (drivers/net/ethernet/sfc/ptp.c:272, and…

--

sfc: ptp: drop the stale frequency reset in efx_ptp_start()

This commit stops efx_ptp_start() from clearing the cached
current_adjfreq. Firmware keeps the clock frequency across PTP disable
and enable. Clearing the cache made the next efx_phc_adjtime() set the
NIC's frequency trim back to 0.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 00cfd8d5b46ea..957ca08092e7f 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c
> @@ -1445,7 +1445,6 @@ static int efx_ptp_start(struct efx_nic *efx)
>  		goto fail;
>  
>  	ptp->evt_frag_idx = 0;
> -	ptp->current_adjfreq = 0;

[Severity: Medium]
Should the Siena copy of efx_ptp_start() get the same change? The Siena
version still clears the cache right after efx_ptp_enable() succeeds:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_start() {
    ...
	rc = efx_ptp_enable(efx);
	if (rc != 0)
		goto fail;

	ptp->evt_frag_idx = 0;
	ptp->current_adjfreq = 0;
    ...
}

Siena's efx_phc_adjtime() also sends the cached value with every time
step:

	MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);

On Siena, all the paths named in the commit message still reach that
reset:

  efx_siena_ptp_change_mode() -> efx_ptp_start()    (SIOCSHWTSTAMP)
  efx_ptp_restart() -> efx_ptp_start()              (ifup, reset recovery)
  efx_ptp_worker() -> efx_ptp_start()               (reset_required)

So the next adjtime or settime would set the Siena NIC's frequency trim to
0. Meanwhile the servo and the PTP core still hold the old value.

The Fixes: tag points at 7c236c43b838, which added this code for Siena
hardware. The later patches in the series ("sfc: ptp: serialize host and
MC synchronization transactions" and "sfc: ptp: avoid racing PPS
timestamp updates") don't touch siena/ptp.c either.

This assumes Siena MC firmware also keeps the frequency across
MC_CMD_PTP_OP_DISABLE and MC_CMD_PTP_OP_ENABLE. The commit message only
says this for the firmware it targets. Does Siena firmware behave the
same way? If so, should drivers/net/ethernet/sfc/siena/ptp.c be fixed as
well?

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc for struct
efx_ptp_data, in both drivers/net/ethernet/sfc/ptp.c and
drivers/net/ethernet/sfc/siena/ptp.c, says:

 * @current_adjfreq: Current ppb adjustment.

The field doesn't actually hold ppb. efx_phc_adjfine() stores the
fixed-point fractional ns value that firmware takes:

	adjustment_ns = ((s64)delta * PPB_SCALE_WORD +
			 (1 << (ptp_data->adjfreq_ppb_shift - 1))) >>
			ptp_data->adjfreq_ppb_shift;
	...
	ptp_data->current_adjfreq = adjustment_ns;

Could the comment describe the unit correctly?

[Severity: Medium]
This is a pre-existing issue, but now that efx_phc_adjtime() relies only
on the cached value, can a concurrent adjtime and adjfine leave the cache
out of sync with firmware?

At this commit, nothing serializes these two accesses:

efx_phc_adjtime():
	MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);

efx_phc_adjfine():
	rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inadj, sizeof(inadj),
			  NULL, 0, NULL);
	...
	ptp_data->current_adjfreq = adjustment_ns;

posix_clock_adjtime() only takes the clock rwsem for read. So an adjtime
can read the old frequency F0 before an adjfine programs F1. Its RPC then
writes F0 back into firmware while the cache holds F1.

The next patch in the series, "sfc: ptp: serialize host and MC
synchronization transactions", appears to fix this. It adds
ptp_data->phc_lock, holds it around the RPC and the cache update in
efx_phc_adjfine(), and runs _efx_phc_adjtime() under the same lock.

>  
>  	return 0;
>  

To recap, these questions concern the Siena copy of efx_ptp_start(), the
@current_adjfreq kernel-doc, and the adjtime/adjfine race.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
