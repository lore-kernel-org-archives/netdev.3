Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926771;
	b=KSNkw8bnws1xZqi4bCj5rZg/TB3UpOATpnfl1jXoUprZx++x88Oer55jrq/BvrKGs6vA
	 CbIAtWKYQ7rqpXU5PxDhnFI5jSuCV5+XUvZYTEEaWxUh8fq43g1alAXezUZZPbDDkmqEf
	 fO812Go/h12MRGyu8w/NbDlJTpgmRclbS0+DgjGu63BCMdA4M8GCLRjURaZudvJ6oja3L
	 25HORv8hZeJ2Qkl/SrgBY+ajBYx7AH5UfDFaUjamLBfo3NU5Mn+iSGklPs46dC0Dqa51e
	 gywpKH+c8IOv7i2Bbd6hcEeKsc89SRKCgIzGWz2anjTUyxZdS3IsDJg4i8k6T3/wIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7bS0I0Liv9MOE1zaQ7EZ37BO3IkOmtOT5L+SIMxc7RY=;
	b=MqRF2pkvWFTLUagaorAHeq2hIo22vEvvNlWeAzh+BPMlOnggGsGVSWejuU2/DJSESpaj
	 kk1lSK4uKpc4wD3/EA478feoZsx598BdRPJzzsnXY2kYl7vY/XZvngqGz7jjCCkU6OJPi
	 5TYkgc3KvC+VES80prdCPrnTu+vk+rXZJjOsxuqacDSFc+IRb0PJ6bRw5lJYY1Ej7pTTY
	 zrS3CLLx2GwxVPvqf1U/3f2uueOX6D1IxJirncaUlFaOKV+J0HcQ+ONlsnDSFZACJHyC1
	 EyJA+D0kIUAcm4UVx5qeEz/jQyYTuVXwbMldQGX/3+L24WCboYYkrVYpEIOX143mQPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnvuYoLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61903606A31A;
	Sun, 25 Oct 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnvuYoLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334CA1F01825;
	Sun, 25 Oct 2026 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926770;
	bh=7bS0I0Liv9MOE1zaQ7EZ37BO3IkOmtOT5L+SIMxc7RY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JnvuYoLk48Xcdci+5ImkB59e6LqwX5Ou7c7BbnIePbdw2NRFX0pOR6ypaE4o5zsk7
	 vwS8LsxM0Jvppe2XCGy8eB8GUO/Rf1EfegkiFYI3XSUKveRW7kMu/0yoV6kJKEqLrV
	 HH752iDTqcyu/dYizaDaZbT9H4nyPNmKBKEQj4NwNYq8/v8OytISmlMens2bN4DBDU
	 Rc4e8zGEpYzKvX58bwPNS8wzNmEE7UWHlORNrsqt8jGh3YOl1LyVEm5O41R/0BEgZx
	 35FkZ9iubaAHURDdAiRP0+yqTlHmNKlcGckGyRnzbAzunto6oNUhZeGnbx1k6bBNAc
	 qJbF5DlpNMiEw==
Subject: Re: [PATCH net v3 1/3] sfc: ptp: drop the stale frequency reset in
 efx_ptp_start()
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com
Date: Sun, 25 Oct 2026 11:12:49 +0000
Message-ID: <179292676968.3134.7576333163086767429@kernel.org>
In-Reply-To: <20261021091534.3164258-2-alex.austin@amd.com>
References: <20261021091534.3164258-2-alex.austin@amd.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix leaves the forked Siena driver unfixed.
- [Medium] The commit message understates the bug it fixes and has an
  invalid Fixes: tag.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  for struct efx_ptp_data describes `@current_adjfreq: Current ppb…

--

sfc: ptp: drop the stale frequency reset in efx_ptp_start()

This patch removes the line that resets ptp->current_adjfreq to 0 in
efx_ptp_start() in drivers/net/ethernet/sfc/ptp.c. According to the commit
message, firmware keeps the clock frequency across MC_CMD_PTP_OP_DISABLE
and MC_CMD_PTP_OP_ENABLE. Zeroing the cached value therefore puts the driver
out of sync with the firmware.

> FW does not touch the clock frequency state on MC_CMD_PTP_OP_DISABLE or
> MC_CMD_PTP_OP_ENABLE, so the driver doesn't need to either. Doing so
> just desyncs the driver's cached current_adjfreq from what FW still has
> programmed.

[Severity: Medium]
Could the commit message describe the effect users see? efx_phc_adjtime()
sends the cached value to firmware on every time step:

drivers/net/ethernet/sfc/ptp.c:efx_phc_adjtime() {
    ...
	MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);
    ...
}

So before this patch, the first clock step after any efx_ptp_start() set
the NIC frequency to 0. That covers a SIOCSHWTSTAMP mode change, ifup, and
the reset_required path in efx_ptp_worker().

The servo's frequency correction was lost. Meanwhile, ptp_clock_adjtime()
kept reporting the old dialed_frequency to userspace.

That is more than a cached value going out of sync. Stating it would help
backporters judge how serious the fix is.

> Fixes: ffe9554c17bf ("sfc: Add support for IEEE-1588 PTP")

Is this hash right? ffe9554c17bf does not resolve to any commit. The commit
with this subject appears to be 7c236c43b838, which the other patches in
this series also use:

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 6ca9a75af01d8..2247e5e3e25a8 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c
> @@ -1446,7 +1446,6 @@ static int efx_ptp_start(struct efx_nic *efx)
>  		goto fail;
>  
>  	ptp->evt_frag_idx = 0;
> -	ptp->current_adjfreq = 0;

[Severity: Medium]
Does the Siena driver need the same change? Its copy of efx_ptp_start()
still has the same assignment:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_start() {
    ...
	ptp->evt_frag_idx = 0;
	ptp->current_adjfreq = 0;
    ...
}

Siena reaches efx_ptp_start() through the same paths:

- efx_siena_ptp_change_mode() on SIOCSHWTSTAMP
- efx_ptp_restart(), called from efx_siena_ptp_start_datapath() on ifup
  and reset recovery
- the reset_required branch of efx_ptp_worker()

Siena's efx_phc_adjtime() then sends the zeroed value to firmware as
PTP_IN_ADJUST_FREQ in MC_CMD_PTP_OP_ADJUST.

The commit message does not say whether the firmware behaviour on
MC_CMD_PTP_OP_DISABLE and MC_CMD_PTP_OP_ENABLE also applies to Siena
firmware.

If it does, can the same desync still happen in sfc-siena?

If it does not, is this change wrong for stable trees from before the
sfc/siena split? In those trees, drivers/net/ethernet/sfc/ptp.c also drives
Siena NICs. Also, 7c236c43b838 added efx_ptp_probe() to siena_probe_nic(),
so this code was first written for Siena firmware.

>  
>  	return 0;
>  

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc for struct
efx_ptp_data in drivers/net/ethernet/sfc/ptp.c says:

 * @current_adjfreq: Current ppb adjustment.

Is this unit correct? efx_phc_adjfine() stores adjustment_ns in this field,
not a ppb value:

drivers/net/ethernet/sfc/ptp.c:efx_phc_adjfine() {
    ...
	ptp_data->current_adjfreq = adjustment_ns;
    ...
}

adjustment_ns is the ppb delta after conversion, using adjfreq_ppb_shift,
into the NIC's fixed point fractional nanosecond format. The same comment
is in drivers/net/ethernet/sfc/siena/ptp.c.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021091534.3164258-1-alex.austin%40amd.com
