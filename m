Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C83AFCE6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888200; cv=none; b=ISSWVXMICDT4zUWPtIdfqn7vWLiTjAzHVTUn+ulUfUM/Yw/NkoF7zeWiry3fFvavcJ8/msXNbL4gbWLzOqUJjtYDcIQ7Yj9kr3VJ686XtBqywPR+OGAqwnCWifMXH/Rn5PemasNX/+biL/V/wq7+1P1IFpE4sIUqB3lTnk80RuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888200; c=relaxed/simple;
	bh=ByWSXE/7WPxPiNDq+DRGyvhy49vCl/cF9okG2hZGg/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eo257sgGPFjJsAWpNknrBA2pqySlabiLDe+gqZJ8kcDdZAYJIf8/ddZIjncuEFPuLM77Y8CQ9zIfUjWvIqmanPF59E8NhkMgg4eFkoskS3oJwU8sRpjiYF2SMn00Nxmowm7D/ILDCwmxltSZdeqEdZ+BR4Je6SQlvapeAnbltx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kf6r3GJs; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kf6r3GJs"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ByWSXE/7WPxPiNDq+DRGyvhy49vCl/cF9okG2hZGg/w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791888196; v=1; x=1792492996;
 b=Kf6r3GJs5jBx4fJr0BPFL3eF88FyyQi1jChmXGlaEyNgPwMwFh5kycydk3a42uCgBKkSMiY9
 /o6R8ccl7NK/Kbyv+o3c4V6LgcxMPeS8J1ev3wL5HOu4BONbINFzh8nF7J9n0X2r8VvKl2BhpWo
 X77og7vExEk9JPIt4Zcm9eK4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8e08e36eb5f4ac01;
	Tue, 13 Oct 2026 10:43:16 +0000
X-Mizu-Trace-ID: 8e08e36eb5f4ac01
X-Migadu-Flow: FLOW_OUT
Message-ID: <5c500376-0573-446d-81cf-70bc38ae4aea@linux.dev>
Date: Tue, 13 Oct 2026 11:43:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: ptp: switch to gettimex64()
 interface
To: James Clark <jjc@jclark.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Miroslav Lichvar <mlichvar@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261008103809.1848255-1-jjc@jclark.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261008103809.1848255-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2026 11:38, James Clark wrote:
> The stmmac PTP support currently implements the gettime64 callback to
> retrieve the hardware clock time. Update the implementation to provide
> the gettimex64 callback instead, adding support for the
> PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> The system clock readings are taken around the read of the nanoseconds
> register in get_systime(), so get_systime() gains a ptp_system_timestamp
> argument.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Assisted-by: LLM
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> Changes in v2:
> - Read PTP_STNSR with readl() and drop the two rmb() calls
>    (Nicolai Buchwitz, Maxime Chevallier)
> - Fix the kernel-doc of stmmac_get_timex() and an over-long line
>    in stmmac_adjust_time() (netdev CI)
> - Link to v1: https://lore.kernel.org/netdev/20261006103610.98277-1-jjc@jclark.com/
> 
> Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
> Width of the interval between the two system clock readings
> bracketing each PHC read (2000 calls of 25 samples each):
> 
>                                           min      median
> Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
> After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    583 ns
> 
> On this board the 24 MHz arch timer counter advances in steps of 7
> (~292 ns), so all intervals are multiples of that.
> 
>   drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++++-
>   .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  7 +++++--
>   .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 21 ++++++++++---------
>   .../stmicro/stmmac/stmmac_selftests.c         |  4 ++--
>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  3 ++-
>   5 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index a8a5c8fdd5e..6efbfe50102 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -493,6 +493,8 @@ struct stmmac_ops {
>   #define stmmac_fpe_map_preemption_class(__priv, __args...) \
>   	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
>   
> +struct ptp_system_timestamp;
> +
>   /* PTP and HW Timer helpers */
>   struct stmmac_hwtimestamp {
>   	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
> @@ -502,7 +504,8 @@ struct stmmac_hwtimestamp {
>   	int (*config_addend) (void __iomem *ioaddr, u32 addend);
>   	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
>   			       int add_sub, int gmac4);
> -	void (*get_systime) (void __iomem *ioaddr, u64 *systime);
> +	void (*get_systime)(void __iomem *ioaddr, u64 *systime,
> +			    struct ptp_system_timestamp *sts);
>   	void (*get_ptptime)(void __iomem *ioaddr, u64 *ptp_time);
>   	void (*timestamp_interrupt)(struct stmmac_priv *priv);
>   	void (*hwtstamp_correct_latency)(struct stmmac_priv *priv);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index b9a985fa772..870c740b4a5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -183,7 +183,8 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
>   					 10, 100000);
>   }
>   
> -static void get_systime(void __iomem *ioaddr, u64 *systime)
> +static void get_systime(void __iomem *ioaddr, u64 *systime,
> +			struct ptp_system_timestamp *sts)
>   {
>   	u64 ns, sec0, sec1;
>   
> @@ -191,8 +192,10 @@ static void get_systime(void __iomem *ioaddr, u64 *systime)
>   	sec1 = readl_relaxed(ioaddr + PTP_STSR);
>   	do {
>   		sec0 = sec1;
> +		ptp_read_system_prets(sts);
>   		/* Get the TSSS value */
> -		ns = readl_relaxed(ioaddr + PTP_STNSR);
> +		ns = readl(ioaddr + PTP_STNSR);
> +		ptp_read_system_postts(sts);
>   		/* Get the TSS value */
>   		sec1 = readl_relaxed(ioaddr + PTP_STSR);
>   	} while (sec0 != sec1);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 3bfcc9760dc..e54a3c88782 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -89,7 +89,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>   		u64 cycle_time;
>   
>   		mutex_lock(&priv->est_lock);
> -		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> +		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops,
> +					       &current_time, NULL);
>   		current_time_ns = timespec64_to_ktime(current_time);
>   		time.tv_nsec = priv->est->btr_reserve[0];
>   		time.tv_sec = priv->est->btr_reserve[1];
> @@ -114,15 +115,15 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>   }
>   
>   /**
> - * stmmac_get_time
> - *
> + * stmmac_get_timex - read the PTP clock, with system timestamps if requested
>    * @ptp: pointer to ptp_clock_info structure
>    * @ts: pointer to hold time/result
> + * @sts: pointer to hold system timestamps around the read, or NULL
>    *
> - * Description: this function will read the current time from the
> - * hardware clock and store it in @ts.
> + * Return: 0
>    */
> -static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +static int stmmac_get_timex(struct ptp_clock_info *ptp, struct timespec64 *ts,
> +			    struct ptp_system_timestamp *sts)
>   {
>   	struct stmmac_priv *priv =
>   	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
> @@ -130,7 +131,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
>   	u64 ns = 0;
>   
>   	read_lock_irqsave(&priv->ptp_lock, flags);
> -	stmmac_get_systime(priv, priv->ptpaddr, &ns);
> +	stmmac_get_systime(priv, priv->ptpaddr, &ns, sts);
>   	read_unlock_irqrestore(&priv->ptp_lock, flags);
>   
>   	*ts = ns_to_timespec64(ns);
> @@ -200,7 +201,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>   
>   		target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
>   
> -		stmmac_get_systime(priv, priv->ptpaddr, &ns);
> +		stmmac_get_systime(priv, priv->ptpaddr, &ns, NULL);
>   		if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
>   			return -EINVAL;
>   
> @@ -304,7 +305,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
>   	.pps = 0,
>   	.adjfine = stmmac_adjust_freq,
>   	.adjtime = stmmac_adjust_time,
> -	.gettime64 = stmmac_get_time,
> +	.gettimex64 = stmmac_get_timex,
>   	.settime64 = stmmac_set_time,
>   	.enable = stmmac_enable,
>   };
> @@ -321,7 +322,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
>   	.pps = 0,
>   	.adjfine = stmmac_adjust_freq,
>   	.adjtime = stmmac_adjust_time,
> -	.gettime64 = stmmac_get_time,
> +	.gettimex64 = stmmac_get_timex,
>   	.settime64 = stmmac_set_time,
>   	.enable = dwmac1000_ptp_enable,
>   };
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 6097f312fce..2ae4f0e760c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1778,7 +1778,7 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
>   		return ret;
>   
>   	read_lock_irqsave(&priv->ptp_lock, flags);
> -	stmmac_get_systime(priv, priv->ptpaddr, &curr_time);
> +	stmmac_get_systime(priv, priv->ptpaddr, &curr_time, NULL);
>   	read_unlock_irqrestore(&priv->ptp_lock, flags);
>   
>   	if (!curr_time) {
> @@ -1800,7 +1800,7 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
>   
>   	/* Check if expected time has elapsed */
>   	read_lock_irqsave(&priv->ptp_lock, flags);
> -	stmmac_get_systime(priv, priv->ptpaddr, &curr_time);
> +	stmmac_get_systime(priv, priv->ptpaddr, &curr_time, NULL);
>   	read_unlock_irqrestore(&priv->ptp_lock, flags);
>   
>   	if ((curr_time - start_time) < STMMAC_TBS_LT_OFFSET)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 42a00446e9b..57ebeb2c19c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1070,7 +1070,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>   
>   	mutex_lock(&priv->est_lock);
>   	/* Adjust for real system time */
> -	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> +	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
> +				       NULL);
>   	current_time_ns = timespec64_to_ktime(current_time);
>   	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
>   					qopt->cycle_time);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
