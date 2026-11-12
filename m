Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461606;
	b=SHIv2wIZm1TePXD4skx+pSrojkZsURvDeZnhy5tiUcN+8E1wbUpooZQTg6jLkH8sK720
	 4fhSnvmJ3yyA5DAWFqqBfLtceyn1jWaPDf9uTuCzK73CPG9i47hZQ7QQU019uUrScqDp/
	 m7KtAHydHj24tyqiwdFG5bEEZhu7AfqFxRKTImBvqfQVCs2G9VPc/vCm31TVDaq3fWVE9
	 KGq1LPPMITbhrEmjZGdjBL/ECKpU7kh8zH/km/nXOp4LD7yDxCngCbSqBmObuvXkQeSjx
	 CaqIFWQ3SFzPTlD7abIhBJYxDDaZPgUJL7YHuX9pmTZFE0/pEiK0zdbpbhpX5CDVoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461606;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CO51/hU61kNk4ENwyXqdIT392/bNVTYpfxwzPQhTQnM=;
	b=2jbPrEPpiBkYTT/Y51fkTZbDYWfcRjuOOmbF//QbZoVA8WFPzWUpFJ54OTjiWPX+4cSm
	 mvC62NlEXTtkmyMMneIxnkh/ibO/87Jh2YRupMMXkLHDNig/kreabTmLmVo3P1k8zoLxe
	 vTf3lShVTX+dyAUwuPc3ddQ7lIymK4FjacJMTPaMF3idZP166NqCSum1ByW25LJ2wUSrA
	 D/vKXWZncFrAuQNKx4Q88F7v01Waq5AdAgwVw3RA/9gk6V82qpR1tZm5eotLmqscHnpI9
	 9EZC5PHoNjTjUieYH4AMxpJbZy2ySAnDdfRKrZssTiQThrdW8kPbZxMrmgPlNptRG0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmB1CV38;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457D606A323;
	Thu, 12 Nov 2026 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmB1CV38
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E793A1F00A05;
	Thu, 12 Nov 2026 05:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461605;
	bh=CO51/hU61kNk4ENwyXqdIT392/bNVTYpfxwzPQhTQnM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OmB1CV3806LKgBOIfhRSoVy4jJRILwS2q7Nyo9Vy3g6Ee0tdrH5FDJH1VYYi3Uljv
	 6krsIpvaOec2YLmfha6m4BanNEuw8eO1uRUvMIIzqvsszYOVA6KRnfbhFD6yD5VqKv
	 WzfqL+7yxaA8q5CPmXu2uLyE1ZlpMjunNRzQ6RQQFQgDvXY/W1yvXDglGI1fITRmDW
	 1Qt+KIch2u4UHsIFVnKpttqy5rrYWYQgDbhq0bKiN7Usfbhs8BinGhfTrcLIPbqclJ
	 MPajcwXFvow96iBZSxJ43uV8IfLilCubiTE+CIcdlmbq9hHhPxURZYCLM9mI0Iy6Sf
	 QnrDE3IYr7acQ==
Subject:
 Re: [PATCH net-next v1 1/3] r8169: make PHY OCP access safe in atomic context
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 05:33:24 +0000
Message-ID: <179446160443.2199510.6882437840923328941@kernel.org>
In-Reply-To: <20261109023022.770-2-javen_xu@realsil.com.cn>
References: <20261109023022.770-2-javen_xu@realsil.com.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] When the PHY OCP write handshake never completes, the CPU now
  busy-spins with local IRQs disabled for the full timeout, and the real…

--

r8169: make PHY OCP access safe in atomic context

This commit replaces the sleeping rtl_loop_wait() handshake in
r8168_phy_ocp_read() and r8168_phy_ocp_write() with a busy-wait based on
readl_poll_timeout_atomic(). It also serializes GPHY_OCP accesses with a
new phy_ocp_lock spinlock, so that the upcoming RTL8127A PTP code can
access PHY OCP registers from atomic context.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index cd4ebc654dd0b..96d3a2bd70947 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -1234,30 +1236,52 @@ static bool rtl_ocp_reg_failure(u32 reg)
>  	return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
>  }
>  
> -DECLARE_RTL_COND(rtl_ocp_gphy_cond)
> +/* PHY OCP registers may also be accessed from atomic context (e.g. by the
> + * PTP code), therefore busy-wait for completion instead of sleeping.
> + */
> +static int rtl_phy_ocp_wait(struct rtl8169_private *tp, bool high)
>  {
> -	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
> +	u32 val;
> +	int ret;
> +
> +	ret = readl_poll_timeout_atomic(tp->mmio_addr + GPHY_OCP, val,
> +					!!(val & OCPAR_FLAG) == high, 1, 250);
> +	if (ret && net_ratelimit())
> +		netdev_err(tp->dev, "PHY OCP access timeout\n");
> +
> +	return ret;
>  }
>  
>  static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>  {
> +	unsigned long flags;
> +
>  	if (rtl_ocp_reg_failure(reg))
>  		return;
>  
> +	spin_lock_irqsave(&tp->phy_ocp_lock, flags);
>  	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);
> -
> -	rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
> +	rtl_phy_ocp_wait(tp, false);
> +	spin_unlock_irqrestore(&tp->phy_ocp_lock, flags);
>  }

[Severity: Low]
What happens here when the device stops responding and MMIO reads return
all-ones, for example after surprise removal, a PCIe link down or during
AER recovery?

In that case OCPAR_FLAG always reads as set. rtl_phy_ocp_wait(tp, false)
never sees its condition met and spins until the timeout, with local
interrupts disabled by spin_lock_irqsave().

Is the timeout actually 250us? poll_timeout_us_atomic() in
include/linux/iopoll.h only subtracts the udelay() time, plus 1ns per
iteration, from the budget:

		if (__delay_us) { \
			udelay(__delay_us); \
			if (__timeout_us) \
				__left_ns -= __delay_ns; \
		} \
		cpu_relax(); \
		if (__timeout_us) \
			__left_ns--; \

The time spent in the non-posted readl() is not counted. So each write
that times out would keep interrupts off for about 250 x (1us + readl
latency). That is longer than the commit message says:

  "keeping the previous maximum wait time of 250us"

Long write sequences would hit one such window per write. Examples are
the rtl_fw PHY firmware download, the r8169_phy_config.c tables via
rtl_writephy()->r8168g_mdio_write(), phylib MDIO ops such as
r8169_mdio_write_reg_c45(), and the r8127 SFP init.

Before this patch, the same failure path slept in rtl_loop_wait() via
fsleep(25) and left interrupts enabled.

The read path in r8168_phy_ocp_read() doesn't seem to have this problem,
because an all-ones value meets the "flag high" condition right away.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109023022.770-1-javen_xu%40realsil.com.cn
