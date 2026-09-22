Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB453A88F;
	Tue, 22 Sep 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075727; cv=none; b=uSnnyc/XDcwmEW6OPccJLSHVI5P2F+LyBS1NR1FeLfZ67V3mAIobdjyU04+SDn4y44JYl0JvJXkc1fI/N+pCTW7YiMC6La05jo4OhplZ2PCC3aQE1WkjDp8q6A/PPrhzGALHgzd6vihWrDMv23a7Zy1FcocfmTMH4dgt6fHUlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075727; c=relaxed/simple;
	bh=uG10CpKzITeuRozAFTUxxhD0O4dxaawtIgjeDCip7uA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OGRUdLULSZGriiljVcJP9cLxmHnog0o8Kz+xO3EezTj70hZtIVQ1kyxx6eDNmuKIe1AQK8+roujVEy7EGNZKRX0oEbaLNtQUwAwOVtwLgjTT5uziL62lR2dYLNX1NNqRgLLCeoyXNNJHxBMgLbyPrltywtkL2ySEOFsMY71CphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cM5nP/xs; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cM5nP/xs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62DF5A48A8;
	Tue, 22 Sep 2026 13:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790075722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YeioCQeruug6cneljdT1FzQx8F1lcbWO1Yj8R6eHz6I=;
	b=cM5nP/xsxiUBzdOpJmU8Q+6Cimk/dIQWR3dRTOl8a+LvS/7ur8/KCRx3SXCLa93uPhSyRz
	MiHK8xLLt1a2PQEfMQHQBuvGkLwW03SOm3rnpsSRpKFHY0xMfLNOvlyCYi1x1PZ4IYEkRj
	MRt59c8gUHEoO1m/VSJM8Fqu0iSWdT5y3u34GtcH4Ln0AfnUSh6p9rK+SJK4ZocaZxsGCR
	JbMOr5OBN3872LKZnzHC48fZTm7WtV9RpZUl5g1sXKNeB8pAgp6zFcFyTV5AucLxcYaOI4
	pKCvNB08TkIO5BFzeDdl6qWwsuvSZ+A8F7cx1wBYYqbsvGhC/xte/36/v1jGXQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 13:15:18 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Rafal Ozieblo <rafalo@cadence.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: macb: Rework hardware timestamp
 configuration
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
Message-ID: <1130cfbd992c343c4cc32d08b9bad662@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kim

On 22.9.2026 11:10, Kim Wooseok via B4 Relay wrote:
> This started with two problems I found while using PTP hardware
> timestamping on a Raspberry Pi 5. A rejected RX filter could still
> change the TX one-step setting, and the PTPv1 Sync and Delay_Req 
> filters
> returned success without enabling RX timestamps.
> 
> This series reworks gem_set_hwtst() to validate the whole request 
> before
> programming the hardware. It calculates the settings locally, then
> updates the registers and saved configuration under bp->lock. With the
> register writes now in the setter, the two helpers are no longer 
> needed.
> 
> The remaining patches use the existing ALL fallback for the specific
> PTPv1 filters, turn off one-step mode for TX_OFF, and clear SRTSM when
> switching away from a PTPv2 filter. Each change is kept in its own 
> patch.
> 
> I compared the old and new behavior on the Pi 5. When I requested a TX
> mode change together with an invalid RX filter, the patched driver
> rejected the request without changing the saved settings or NCR. I
> also switched from one-step TX and PTPv2 RX to other settings and back.
> Only the relevant bits changed, and restoring the original settings
> restored NCR.
> 
> For the PTPv1 filters, I checked the effect by sending Sync and 
> Delay_Req
> packets over Ethernet. Before the change, the packets arrived without
> hardware timestamps. With the patches, the driver returned ALL and I
> could read the hardware timestamps from the received packets. PTPv2
> multicast reception continued to provide hardware timestamps, and
> selecting NONE disabled timestamping. I ran these tests with the 
> changes
> backported to the Pi's existing Linux 6.18.46 RT kernel.
> 
> On net-next, I built the series with ARM64 allyesconfig and 
> allmodconfig,
> both with W=1. Sparse reported no diagnostics in macb_ptp.c.
> 
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
> Kim Wooseok (4):
>       net: macb: Preserve timestamp settings on rejected requests
>       net: macb: Enable RX timestamping for specific PTPv1 filters
>       net: macb: Disable one-step mode when TX timestamping is off
>       net: macb: Clear SRTSM outside PTPv2 receive filters
> 
>  drivers/net/ethernet/cadence/macb_ptp.c | 63 
> ++++++++++++---------------------
>  1 file changed, 23 insertions(+), 40 deletions(-)
> ---
> base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
> change-id: 20260922-codex-macb-hwtstamp-submit-25ab4a2e6b94
> 
> Best regards,
> --
> Kim Wooseok <5mghybrid@khu.ac.kr>

For the series:

Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5 (macb 
rp1 with BCM54210PE)

Regards
Nicolai
