Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16762D0C7E;
	Thu,  9 Jul 2026 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577039; cv=none; b=SxBWtTLb1HXoH79lClo6emN/7q8SSVZGIS8P68027e9tX0wzSb6hfM/KJt/bELeiu1cQ4wC3zuAjnUziyZtxXdHOXBFW5HO7HVp3dTDo6CozLhSqXwClPaOe6bW1cn1B4GO8/HGU8RRXAGggvpFPdxowVBHh4hIGksJfOEzpISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577039; c=relaxed/simple;
	bh=yBwghVt1yNXuJBhObJimnOjBdFffvi0j64Q90GWAsqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHo44sKrGVXU9Sh+MGJ7g5Unbuw4Arm2NV44Rhg2GUUEJ7sXPVVUcq41kv0KLgzjMS2SPSwUfvgjro49zugrvXI2u9oEiYikMq0MSm6P+m7WxneoGkzPjIPCcCo3G2Em3wuDVlVSfc6zcQx28sgD1XWtmS4y4p36VTDUV7VgmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVfDTVbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVfDTVbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC281F000E9;
	Thu,  9 Jul 2026 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577037;
	bh=wRU5zaDrC1juEMW/sUNE1efvtJdHXySbPC6CXC4p05g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LVfDTVbhfalfFS5xJ1E2WTjP4lfNeK4pubNaxrFiDOaP174Oeb4k8mSUEWzxl06v2
	 jIjz9Vglma1zhMySah9/Uisq7XhNj6qAxX5ycLQ2TJCCbIJCiv/6X85J6EyWD26Hmw
	 MAtMd4FwnNWifoUobgwb1EMCxGxHw9l2JMBxemR2gySuNkkz0t2+Dr8e2Lh7Yzgk6B
	 Ki270Wm3zDEgs3ZS0JtQ1oApmGFCOhVBqCXtLq27bK3w9W/p8K0zkhZjXPe5DOEKU5
	 PQlGJdFvXlvTh1MNzUnWwlms3/3zdQMV6ZGKZ4/MU8QRVbYIGWky86472L7+2p8VMI
	 y8LrQRVnYzlLw==
Date: Thu, 9 Jul 2026 08:03:50 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: zwq2226404116@163.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	Wanquan Zhong <wanquan.zhong@fibocom.com>
Subject: Re: [PATCH v3 1/1] bus: mhi: pci_generic: fix Rolling Wireless
 RW135R-GL and RW151 support
Message-ID: <5j3wmfvr22upwu7wxraletiic4frdfkpusbko5xbegfgk3xdc7@e7oayedqofnz>
References: <20260701095344.309409-1-zwq2226404116@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701095344.309409-1-zwq2226404116@163.com>

On Wed, Jul 01, 2026 at 05:53:44PM +0800, zwq2226404116@163.com wrote:
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
> 
> bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support
> 
> - Increase RW151 MBIM channel ring size from 4 to 32
> 
> On HP and Lenovo laptop platforms the device probes successfully and
> WWAN ports are created, but pci_generic enables runtime autosuspend
> (PCI D3hot/M3) after a short idle period. Resume from runtime PM leaves
> the modem in MHI SYS ERROR; driver recovery (reset) fails and the device
> becomes inaccessible (PCIe config space reads as 0x7f).

Inaccessible means, config space reads should show '0xff' for all registers, not
'0x7f'.

> The failure is not
> self-recoverable while runtime PM remains enabled; keeping power/control=on
> avoids the issue.
> 

You really need to find out the cause of this issue. 'no_m3' flag indicates that
M3 state is not supported by the device. Is that really the case here? Or the
PCIe port or the device itself doesn't support D3Hot properly?

- Mani

> Set no_m3 on RW135R-GL and RW151 so probe does not enable runtime M3
> autosuspend for these modules.
> 
> Power management testing (separate from runtime PM above):
> - Suspend-to-RAM (S3/mem): tested on RW135R-GL and RW151; MHI/MBIM/wwan
>   function after wake.
> - Suspend-to-disk (hibernate): not available on the test platforms
>   (/sys/power/state lacks "disk", ENODEV).
> 
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
> 
> ---
> v2 -> v3: RW151 MBIM ring size 32; disable runtime M3 (no_m3)
>  drivers/bus/mhi/host/pci_generic.c | 4 +++-
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index d598bb3b3981..d0fee7e3ba3a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -942,6 +942,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
>  	.sideband_wake = false,
> +	.no_m3 = true,
>  	.mru_default = 32768,
>  	.edl_trigger = true,
>  };
> @@ -949,8 +950,8 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
>  static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> -	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
> -	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
> +	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> @@ -986,6 +987,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw151_info = {
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
>  	.sideband_wake = false,
> +	.no_m3 = true,
>  	.mru_default = 32768,
>  	.edl_trigger = true,
>  };
> 
> --
> 2.50.0
> 

-- 
மணிவண்ணன் சதாசிவம்
