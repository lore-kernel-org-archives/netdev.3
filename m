Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31596489FB1;
	Mon, 19 Oct 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405403; cv=none; b=AphMbYCZSm5jFdH2EmOmwBIZz42UAKIWpzNs+fFX/ktlmi8EO12OWhokBcoFarALdR9Dj4VZW+tRavKtToiR2dhm0QqPhgXP93bOmmTkYVfypDRis9sTqiiEzCOSOOxxP4Va9UtMLMWygPkWi+9U2febFEXaEuR35ttDJYKzzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405403; c=relaxed/simple;
	bh=D2DpqXHKr2BB5k/h0wRiqWbQTtMgZbmFnDLlZNR9ykk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rnOdIpO2rwZSTNZkgMGRTULus24ZNMisELHX4nH0at0Y/FlfZOvSEoMXAMWJ1Ve1fiO/Jz/zGwQ0DkgYs8lYbM7UOwSd3CylwQbPTggPzt1GrXkFVjb3GuN0ELvmY0czhTgpMFLuehKN9k8uEsEimUrst4SUlORQe3V+0Syhsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=kuR5vTRt; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="kuR5vTRt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A108A0E36;
	Mon, 19 Oct 2026 12:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792405399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8qk2GDfQQQsZBsDDJ4QXyfH1jnkv+9Y903FV15Heg0g=;
	b=kuR5vTRtyssQXI9xQU2DPD5Xv3Y6FiDW00xYnLU/ujJvaFJxLRb9TDRxevqhwMbQ2T5eoQ
	XAZGwmV/yMRrxVZ9vC/Q7qN6fKZbvkds2QwDsKTphI+nAka1FcaQNpLzMhzN7cFLS1tvZS
	ki3DBpgFKl7ifI+1kFYEcMKMwlByw6qRZLGVKlZP2tdV9XRGS3nGD6gqqAnmBeMQS9fGK2
	gfjBZ1jQAHsbVvGQqu91wTjI/xZjQcxqazEHBPlBsp82+GdaQ0S3wzHmWlLqBrzAbjoJbx
	+/mBv1rOtRvf0sLPH4iOF0vzcyLFBs/E651OflD6dAJpuWXGMIoDyrl0liunyQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 12:23:19 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX
 timeout
In-Reply-To: <784a571839d5dd83c2c3e8ea38844159f353de77.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <784a571839d5dd83c2c3e8ea38844159f353de77.1792008404.git.cbabroski@nvidia.com>
Message-ID: <5cabe797885011ea204a793557d8639a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chris

On 15.10.2026 17:00, Chris Babroski wrote:
> The driver does not implement ndo_tx_timeout, so the core TX watchdog 
> is
> never started. If a TX DMA channel stops completing descriptors, its
> queue stays stopped and the interface cannot transmit again until it is
> brought down and back up.
> 
> Add an ndo_tx_timeout handler that schedules a work item to reset the
> device. Under rtnl_lock(), the work detaches the netdev, closes it,
> soft-resets the DMA controller, opens it again and reattaches it. This
> is the sequence suspend and resume already use, with the DMA controller
> reset taking the place of the full hardware init.
> 
> Because everything is reopened, the RX path, PTP and the PHY link are
> restarted along with TX. For PTP, the reset has the same effect as
> bringing the interface down and up. As on suspend and resume, the PTP
> clock is unregistered and registered again, and its time is reset to 
> the
> system time. The hardware timestamping state is also reset, so the RX
> filter returns to none and one-step sync insertion is disabled, while
> the driver keeps its TX timestamping flags. PTP applications have to 
> set
> up timestamping again.

Is it ok to re-register the PTP clock on a reset the driver starts by 
itself?

ptp_clock_unregister() makes the open /dev/ptpN return -ENODEV, and
since the old index stays taken while ptp4l holds it, the reopen comes
back as a different /dev/ptpN. So ptp4l has to be restarted, which is
more than "set up timestamping again"...

How about moving clock registration to probe instead, so it survives
the reset? Then only the hw timestamping config would need to be put
back.

> 
> lan743x_dmac_init() did not check that the DMA controller soft reset
> completed, so the work could reopen a controller whose reset timed out.
> Return the error from the poll so the work can tell. Probe already 
> fails
> when lan743x_dmac_init() returns an error, so a controller that does 
> not
> come out of reset now also fails probe.
> 
> If lan743x_dmac_init() or the reopen returns an error, the interface is
> taken down with dev_close() so it can be brought back up later. The
> hardware is already closed at that point, so route ndo_stop through a
> wrapper that skips the hardware close while the device is detached.
> 
> ndo_stop is called with rtnl held and cannot wait for the work, so it
> only cancels a pending one. A work that is already waiting for rtnl
> returns if the device is still down when it gets the lock. If the 
> device
> was opened again in the meantime, it is reset once more, which only
> costs an extra link flap. On remove, the work is cancelled 
> synchronously
> after the netdev is unregistered.
> 
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 74 ++++++++++++++++++-
>  drivers/net/ethernet/microchip/lan743x_main.h |  2 +
>  2 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 8d256a80dac6..2545a846478d 100644

> [...]

> +static void lan743x_reset_work(struct work_struct *work)
> +{
> +	struct lan743x_adapter *adapter =
> +		container_of(work, struct lan743x_adapter, reset_work);
> +	struct net_device *netdev = adapter->netdev;
> +	int ret;
> +
> +	rtnl_lock();
> +
> +	if (!netif_running(netdev) || !netif_device_present(netdev))
> +		goto unlock;
> +
> +	netdev_warn(netdev, "resetting after TX timeout\n");
> +
> +	netif_device_detach(netdev);
> +	lan743x_netdev_close(netdev);
> +
> +	ret = lan743x_dmac_init(adapter);
> +	if (ret) {
> +		netdev_err(netdev, "DMA controller reset failed: %d\n", ret);
> +		goto close;
> +	}
> +
> +	ret = lan743x_netdev_open(netdev);
> +	if (ret) {
> +		netdev_err(netdev, "failed to reopen after reset: %d\n", ret);
> +		goto close;
> +	}

Unrelated to this series, but lan743x_pm_resume() seems to ignore this
return value.

> [...]

Thanks,
Nicolai
