Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29E207E00;
	Sat, 26 Sep 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439732; cv=none; b=i7CoL0U3eUlPpi4VZAYjKShfEr1oO1o3A17po5ragpoNp7wDekuRCYlWiQ6ka+foSWs6YAemGAKwkorjuYABVe7AepwO0lnx1FykNJTvxVL7hSfF/YGlI5xS3KQYGfP0vGG985Dzpz17oPltrY+6eozKaupk/vNo0TTCR60+pQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439732; c=relaxed/simple;
	bh=9uFUYyle1YFb+YdZaC78mZ0aDMo/wx/Y+4R23X9phkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf97qC4RPi4vlPNaKl1ETOh34scgvf7ETtLMLi5hoWbbbiqqiS478fK0iiW7tArsQb6CT8epLPPWak+H/IV9HBllcOohAhC4NyesSkZ6I5i8yeJhWU3QF4SY06Wtnav3gAKmIChAUsI1gs40poBoQg9yLC5GCAtZgkKUCvfNGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwqgmk1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwqgmk1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256BC1F000FF;
	Sat, 26 Sep 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790439730;
	bh=e+Qr2230Lu2sLj4UI5sDrSPVvb8HYtybN1/cvDBHd3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iwqgmk1eeGsFzySD6F5rYQQm0GYO9bhJEDdTKXHL+KDOeEGVPhqLg6jpSECUfNFSy
	 RcOKPRYvZpmct50+ddgzN1AxWj9Z72FyGrgvSSUMrlgIDSKJnxCyzMmF2UsXXYIAfm
	 lsr9PYToJNmEVdq0pXZC/i5cAFYE6xCWacnYCdkjOSqBmsO2UEMP/VNKrpiWoY7dgP
	 Rz35fK/GVLjQ8M4WDRknNgYl97xk1Roqh0UMU5/6OPDzEWgM7Flgzlk1m0LoTK4hIx
	 obDD/DdCPWABEi+agrwAbRFoIlEiNFtz/RCRNcooqw9PJ+88VTpV6UcIVpOMKmhHPh
	 cM/zPICs+2+Hw==
Date: Sat, 26 Sep 2026 17:22:05 +0100
From: Simon Horman <horms@kernel.org>
To: mhun512@gmail.com
Cc: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: drain PEROUT requests before canceling the
 timer
Message-ID: <20260926162205.GX13925@horms.kernel.org>
References: <CAGEsz8EYe=gBFr_hEYFLUeiJMRtau=eV3cDUUmHJOQkC0qvfqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8EYe=gBFr_hEYFLUeiJMRtau=eV3cDUUmHJOQkC0qvfqw@mail.gmail.com>

On Thu, Sep 24, 2026 at 09:03:39PM -0500, mhun512@gmail.com wrote:
> fec_ptp_stop() cancels perout_timer before unregistering the PTP clock.
> A PEROUT ioctl can set perout_enable, release the driver's locks and
> then be preempted before hrtimer_start(). The unregister path waits for
> that ioctl, which can rearm the timer after it was canceled. Removal
> then frees the netdev containing the still-armed timer.
> 
> Unregister the PTP clock first so all in-flight ioctls have returned
> before canceling the timer. Clear the PEROUT state and compare channel
> afterward, then disable PPS. Serialize the channel write with PTP clock
> shutdown and skip it when that clock is off.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> b/drivers/net/ethernet/freescale/fec_ptp.c
> index 56801c2009d5..67901e036ac3 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -506,10 +506,13 @@ static int fec_ptp_pps_disable(struct
> fec_enet_private *fep, uint channel)

Hi Myeonghun, all,

This patch does not apply because the two lines above should be a single line.
Unfortunately this means that CI did not run on this patch.

Please repost after figuring out what went wrong here.

-- 
pw-bot: changes-requested
