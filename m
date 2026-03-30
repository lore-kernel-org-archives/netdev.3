Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3D22156C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888756; cv=none; b=e5zZuaQIxoI7QkpLCSWojdZzJw/0NgmA4wBzalzZ+ifjcj0lZ6rE4A33dwuWOgGCFQ2x2EZJtKkRNDj53fAW5EeNvge3RagIdxQpiqsL+N7ywmc1wRr/bWQSZcKhVO+KxAAO+64sqHJmu5cfxAZB/an7hrQfGvMmHm4JQPJyUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888756; c=relaxed/simple;
	bh=ZUH1EzqhEQYQsHM8QLqTtn7dWj1iYiSq0SCIO8wWtHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbQhZM51ySab23F6dTf+gGZUbwLBkXAmkdAs5YSkJgkBSrD8XSTzrA5PQbNnmvbom69E28GqeJxvTSLB4UDwp9NUt6DLyMDR9XJkrXMhTtPcIiIHxtccjBnuptjIYIdxbgFTg7JQle1DkES/5sVsiY9ty5ptsOoebKXItxNt6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VCgdExw6; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCgdExw6"
Message-ID: <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774888751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3mc2GuvqhmMb9wrRKINoXWmbXrHX0jcttXX5kjZeOQ=;
	b=VCgdExw6qemPpBn+YPalVDfAPwFou3CU45L015mPhPUNvW3Qm4ve0edar5JI5H7r9WIlXF
	Gp2F7453FlE9AkKt+KgWrTX39Ji2hu/K2YOjjf72UiN5m6Xb6LNiu98s0a5ZiwzUEozmXy
	zHVK6RMuNz+4/2YKCFXzmMy3W/7t2Qw=
Date: Mon, 30 Mar 2026 17:39:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] igc: fix Tx timestamp timeout caused by unlocked TIMINCA
 write in adj fine
To: Bob Van Valzah <bob@vanvalzah.com>, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org, julianstj@fb.com,
 jeff@jeffgeerling.com
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/03/2026 04:25, Bob Van Valzah wrote:
> Hi,
> 
> We found a race in igc_ptp_adjfine_i225() that causes "Tx timestamp
> timeout" errors and eventually wedges EXTTS when a PTP grandmaster
> (ptp4l with hardware timestamping) runs concurrently with PHC
> frequency discipline (any GPSDO calling clock_adjtime ADJ_FREQUENCY).
> 
> Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA without holding
> any lock.  Every other PTP clock operation in igc_ptp.c (adjtime,
> gettime, settime) holds tmreg_lock, but adjfine does not.  When the
> increment rate changes while the hardware is capturing a TX timestamp,
> the captured value is corrupt.  The driver retries for
> IGC_PTP_TX_TIMEOUT (15s), then logs the timeout and frees the skb.
> Repeated occurrences eventually prevent EXTTS from delivering events.
> 
> The attached reproducer (triggers in ~17 seconds on i226):
> 
>    One thread calling clock_adjtime(ADJ_FREQUENCY) at ~200k/s on the
>    PHC, another sending UDP packets with SO_TIMESTAMPING requesting
>    hardware TX timestamps at ~100k/s.  A Python reproducer is at:
>    https://github.com/bobvan/PePPAR-Fix/blob/main/tools/igc_tx_timeout_repro.py
> 
>    At realistic rates (1 Hz adjfine from a GPSDO + ptp4l at 128 Hz
>    sync), the race triggers in ~30 minutes.
> 
> The attached patch holds ptp_tx_lock around the TIMINCA write and
> skips the write if any TX timestamps are pending (tx_tstamp[i].skb
> != NULL), returning -EBUSY.  This doesn't fully close the hardware
> race (a new TX capture can start between the check and the write),
> but at realistic rates the residual probability gives ~25 year MTBF
> vs ~30 minutes without the patch.
> 
> A complete fix would likely require either disabling TX timestamping
> around TIMINCA writes (via TSYNCTXCTL), or making the timeout recovery
> path more robust so a single corrupt timestamp doesn't wedge the
> subsystem.  We'd welcome guidance from the igc maintainers on the
> preferred approach.
> 
> Tested on:
>    - Intel i226 (TimeHAT v5 board on Raspberry Pi 5)
>    - Kernel 6.12.62+rpt-rpi-2712 (Raspberry Pi OS)
>    - Intel out-of-tree igc driver 5.4.0-7642.46
>    - Stock upstream igc_ptp.c (same code, same bug)
> 
> 	Bob
> 
> ---
> 
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -47,8 +47,10 @@ static int igc_ptp_adjfine_i225(struct ptp_clock_info *ptp, long scaled_ppm)
>   {
>          struct igc_adapter *igc = container_of(ptp, struct igc_adapter,
>                                                 ptp_caps);
>          struct igc_hw *hw = &igc->hw;
> +       unsigned long flags;
>          int neg_adj = 0;
>          u64 rate;
>          u32 inca;
> +       int i;
> 
>          if (scaled_ppm < 0) {
>                  neg_adj = 1;
> @@ -63,7 +65,21 @@ static int igc_ptp_adjfine_i225(struct ptp_clock_info *ptp, long scaled_ppm)
>          if (neg_adj)
>                  inca |= ISGN;
> 
> -       wr32(IGC_TIMINCA, inca);
> +       /* Changing the clock increment rate while a TX timestamp is being
> +        * captured by the hardware can corrupt the timestamp, causing the
> +        * driver to report "Tx timestamp timeout" and eventually wedging
> +        * the EXTTS subsystem.  Serialize with pending TX timestamps:
> +        * skip the rate change if any are in flight.
> +        */
> +       spin_lock_irqsave(&igc->ptp_tx_lock, flags);
> +       for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> +               if (igc->tx_tstamp[i].skb) {
> +                       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);
> +                       return -EBUSY;
> +               }
> +       }
> +       wr32(IGC_TIMINCA, inca);
> +       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);

It's a bit weird solution, because in this case we may end up having no
successful calls to adjfine with high amount of TX timestamp packets in 
flight. Another problem here is that access to timing registers is
guarded by tmreg_lock, but here you use ptp_tx_lock, which protects
queue.

Were you able to recover "corrupted" time stamps to figure out why they
are discarded?


> 
>          return 0;
>   }
> --
> 2.39.2

