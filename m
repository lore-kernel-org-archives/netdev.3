Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364813;
	b=T8zaZJSI8fc3TueX3TEfF9oJtmxlqgJSUeCgHlsCsaCl58/oTxUa7oxTSUqlzkJfOiub
	 6WskblXVGTAPy9Lj7YG6KvGzzZSnr3roAwgD5JDai/Crof8D6vuQqjXFtbUCxfTVwaW+2
	 4A/5uc1ayRyEDgh4s614q3pNE1s2GKBQzhwiGy+TVryxKoJ7cuE30zmP9UsimrVDYs8t/
	 5C4PnaCB6QJgm8Ukf95/KV3dndROFDmM3j7QDYeuEjAjfXQ61sX0S8UcsLalNw002Klcl
	 CWm9uXg4cURJ9kym+o4KckrletxOhmE32RHow36CDiIt3Xlp8rF0vvQngHA4738RZ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364813;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=frvv6tcU3LMgjEDgFGjkYc4XINTd2XEZyaxle6//g4U=;
	b=pyrmxRqojubZOu+ijN1MHGcdnDpHm1xMnSemn33Ro8GjTMZSevO7jqtOq5fSz01xI6Ub
	 VboAnGYod1Ce/Ff/czZN8cAXLkiFUZtQrF5i33xl4jYvBIP+VwJ1hqAnZeT8e8OqLGu2e
	 hbiU8ZceqRDf0bDCeOKdTCTgFty/h9z2QdGm1FmHCkvNbKodeLVteeY3ehGZ8ZQMjBNrN
	 xT2QGzFgmM/IaG1RW1o9A2SlldXDu42CNHLxOmxbBaoS+fWNWGWmqAHAFEg2vtl8+WlWQ
	 3twWADxIb1G2tYgITUU1MyvacR5HlKtOGECSUcAy6BgPuhedo7I5lCokhThmgRAPUUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olIHMhsq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88029606A33A;
	Fri, 30 Oct 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olIHMhsq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9205C1F00A02;
	Fri, 30 Oct 2026 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364813;
	bh=frvv6tcU3LMgjEDgFGjkYc4XINTd2XEZyaxle6//g4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=olIHMhsq8Ahi4xlYkqsUDUAFN6cKOa0RiamKEXNGkWC+09PgsivGO1jODa/FSyJKC
	 9TgoBDgecOU5kdarcOOxcNL9EoZ9ivUREbqaaPBL0DO6220xwaotGHHP5C35YQLUul
	 pQ8BsTH/E3JrKhHeTIrO8YASxOCLqN/I9NElyHcA+klCJQnj5Wxe8/8ue/l5Zs8aTo
	 n6sJb/VDzhPcmCfO7HkXvg6j0Lx798u4TBgdHdAsjUSR4e0dwfwZizGjGChM+CFV5+
	 vN/SI5rfqshqZdIrLXGIGvXVOm+W3q6Vyaz1JlSUywq0IYaAPG4GG+r6j+iQl9fXha
	 3fp8sQlCj+XbA==
Subject: Re: [PATCH net v4 3/3] sfc: ptp: avoid racing PPS timestamp updates
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 12:53:32 +0000
Message-ID: <179336481210.3134.2636807043421655737@kernel.org>
In-Reply-To: <20261026123023.3566549-4-alex.austin@amd.com>
References: <20261026123023.3566549-4-alex.austin@amd.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch removes the shared ptp->host_time_pps race from
  drivers/net/ethernet/sfc/ptp.c, but the same race is still present in…

--

sfc: ptp: avoid racing PPS timestamp updates

This patch removes the shared host_time_pps field from struct
efx_ptp_data in sfc/ptp.c. efx_ptp_synchronize() now returns the PPS
timestamp through storage owned by the caller. The PPS worker therefore
no longer copies a field that a concurrent SIOCSHWTSTAMP-driven
synchronization could be rewriting.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index e26269fae38d6..37511f234d76d 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -1500,14 +1504,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
>  {
>  	struct efx_ptp_data *ptp =
>  		container_of(work, struct efx_ptp_data, pps_work);
> +	struct pps_event_time host_time_pps = {};
>  	struct efx_nic *efx = ptp->efx;
>  	struct ptp_clock_event ptp_evt;
>  
> -	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
> +	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &host_time_pps))
>  		return;
>  
>  	ptp_evt.type = PTP_CLOCK_PPSUSR;
> -	ptp_evt.pps_times = ptp->host_time_pps;
> +	ptp_evt.pps_times = host_time_pps;
>  	ptp_clock_event(ptp->phc_clock, &ptp_evt);
>  }

[Severity: Medium]
This fixes the race in sfc/ptp.c. Is the same race still present in the
Siena copy of this code, drivers/net/ethernet/sfc/siena/ptp.c? That file
also descends from the Fixes target 7c236c43b838, and this patch doesn't
touch it.

In siena/ptp.c, efx_ptp_process_times() still writes the shared field:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_process_times() {
    ...
	/* Set PPS timestamp to match NIC top of second */
	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);
    ...
}

The Siena efx_ptp_pps_worker() copies it after synchronization returns,
with no lock held:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_pps_worker() {
    ...
	ptp_evt.type = PTP_CLOCK_PPSUSR;
	ptp_evt.pps_times = ptp->host_time_pps;
	ptp_clock_event(ptp->phc_clock, &ptp_evt);
}

Meanwhile, the SIOCSHWTSTAMP path can run another synchronization:

efx_siena_ptp_change_mode()
    efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS * 2)
        efx_ptp_process_times()
            ptp->host_time_pps = *last_time;

Can this give the partially updated PPS timestamp that the commit message
describes, but for Siena NICs?

Siena also looks more exposed than sfc was before this series. The Siena
efx_ptp_synchronize() takes no phc_lock or any other mutex. The
WRITE_ONCE(*start, 0) handshake runs before efx_siena_mcdi_rpc_start(),
and the ptp->timeset[] processing runs after efx_siena_mcdi_rpc_finish().
Could two concurrent synchronizations clobber each other's state there
too?

The earlier patch in this series, "sfc: ptp: serialize host and MC
synchronization transactions", seems to have handled that only for sfc.

Should the same caller-owned out-parameter change, along with the
serialization, also be applied to siena/ptp.c? If not, could the commit
message say why Siena is left out?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
