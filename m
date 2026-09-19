Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B72341057;
	Sat, 19 Sep 2026 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781195; cv=none; b=cZ+siPkttDR/NDkblga3EAWVqOUvUvG3kjHGQ+ludm9k3H9QxfPvTseHnlubm5Baxl4wtO5JB55Ag1shkU/aVr6Ut+1HweNwX1BXFrugdpZJ0daZFUx312KYA1kmxI5l/9ldD7F9n3nK/m92rO7crDwGV2kntpqz+eMoEJpuTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781195; c=relaxed/simple;
	bh=l/MN9t6mROeXSjlCQ74rUjZIYcNfbkNUjBS6l6EWYJA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfLxgd5QdBVSXjesaquBvERs0GpkE96GmQ2jURq+gwYgmVFhn38MHA4b4X/aNfyIs1694WSfm66uZbIfUUUfLgf4q5GCmCEC0lq1RzQJM6KXB5cD6kiu3ARSAf2cxmsUlv4G6NESHIlMEwQaOXL1Y6CLoyZ5wTvPWffwWC9cAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZmutLaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZmutLaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9001F000FF;
	Sat, 19 Sep 2026 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781193;
	bh=p3L0rxgEAbtQEbqFgNrv4RPCI8jZ2s9hpAeajLJYIjo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JZmutLaDrSSvKwpF1bXOQJe7FHYCACfDGfh9tPLD0ct/BOu7xu82Yf8weJ2jrUYCu
	 B48diOYBirxOGBxXxWAKon7jDJapAWg+UuatBmElf4plCW7Lko98zfmmiClcwkWWJO
	 zqpCG/XYFaiC8K+fFK08rV0uQFmCHLtZo2KkOiiZM3KZhTAI5Vurl5AQpVnQ0OlAvh
	 8z7KVjhxAkXaU+YKqW9yqeDUYOpqvx4ol3Lgo2LOrVJOnDfG1YOZlPeQpL9qoau1te
	 MPeb8i0jCHJW9kwhhgQRGZmlhiOuYerK4qLyrJH2NtrgBlkSg2IK7yyJ6B8pGxgZwq
	 jyi62okAMtTSw==
Subject: Re: [PATCH net v4 2/7] net: stmmac: selftests: Validate EEE based on
 the actual LPI timer value
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 david.laight.linux@gmail.com
Date: Sat, 19 Sep 2026 01:26:31 +0000
Message-ID: <178978119141.22033.4149996295411788008@kernel.org>
In-Reply-To: <20260917215339.2022523-3-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-3-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] In stmmac_test_eee() the deadline of both new polling loops is
  derived exclusively from priv->tx_lpi_timer (max_duration =…
- [Medium] stmmac_test_eee() infers the *current* LPI state from
  monotonic event counters instead of the actual MAC state.
- [Medium] stmmac_test_eee() validates priv->tx_lpi_timer against
  STMMAC_SFT_MAX_LPI (5 s) at stmmac_selftests.c:473 but never caches…

--

net: stmmac: selftests: Validate EEE based on the actual LPI timer value

The EEE selftest now sends a frame, waits up to roughly twice the configured
LPI timer for the enter-LPI interrupt counter to increase, then sends a
second frame and waits the same amount of time for the exit-LPI counter.
It also bails out with -EOPNOTSUPP when the configured LPI timer exceeds
five seconds.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 614b5995dec5f..2f9f7746c40ae 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -30,6 +30,7 @@ struct stmmachdr {
>  			      sizeof(struct stmmachdr))
>  #define STMMAC_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
>  #define STMMAC_LB_TIMEOUT	msecs_to_jiffies(200)
> +#define STMMAC_SFT_MAX_LPI	(5 * USEC_PER_SEC)
>  
>  struct stmmac_packet_attrs {
>  	int vlan;
> @@ -462,12 +463,16 @@ static int stmmac_test_mmc(struct stmmac_priv *priv)
>  static int stmmac_test_eee(struct stmmac_priv *priv)
>  {
>  	struct stmmac_extra_stats *initial, *final;
> -	int retries = 10;
> +	unsigned long timeout, max_duration;
>  	int ret;
>  
>  	if (!priv->dma_cap.eee || !priv->eee_active)
>  		return -EOPNOTSUPP;
>  
> +	/* Bail out if the configured LPI timer is too long */
> +	if (priv->tx_lpi_timer > STMMAC_SFT_MAX_LPI)
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
Is it intentional that priv->tx_lpi_timer is read twice here, once for the
bound check and again later for max_duration, without caching the checked
value?

Between the two reads stmmac_test_eee() allocates two stats buffers and runs
a full loopback transmit/receive, which can take up to STMMAC_LB_TIMEOUT
(200 ms).

priv->tx_lpi_timer is written outside the selftest by
stmmac_mac_enable_tx_lpi() in stmmac_main.c:

	priv->tx_lpi_timer = timer;
	priv->eee_active = true;

That path is reached from phylink_link_up()->phylink_activate_lpi() inside
the phylink_resolve() work item, which takes only pl->phydev_mutex,
phy->lock and pl->state_mutex, not rtnl. The selftest itself runs with
rtnl_lock held from __dev_ethtool(), so the resolve work can update
priv->tx_lpi_timer in the middle of the test.

Given that neither ethnl_set_eee() nor phy_ethtool_set_eee() range-check
ETHTOOL_A_EEE_TX_LPI_TIMER, can the value used for max_duration therefore be
one that was never validated against STMMAC_SFT_MAX_LPI? For example, a
timer of 60000000 us gives 120 s per wait loop, and 4000000000 us wraps in
the u32 multiplication below to 3705032704 us, i.e. around 3705 s per loop,
all spent in msleep(100) with rtnl_lock held.

Would reading priv->tx_lpi_timer once into a local u32 and validating and
using that single copy (with 64-bit or otherwise bounded arithmetic for the
doubling) address this?

>  	initial = kzalloc_obj(*initial);
>  	if (!initial)
>  		return -ENOMEM;
> @@ -478,14 +483,21 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
>  		goto out_free_initial;
>  	}
>  
> +	/* Snapshot stats, we want to count the in_lpi events. We may enter
> +	 * LPI just after the packet was sent.
> +	 */
>  	memcpy(initial, &priv->xstats, sizeof(*initial));
>  
> +	/* Send a frame, then wait to enter LPI */
>  	ret = stmmac_test_mac_loopback(priv);
>  	if (ret)
>  		goto out_free_final;
>  
> +	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
> +

[Severity: Medium]
Does this deadline hold for small LPI timer values?

The patch adds an upper bail-out for priv->tx_lpi_timer but no lower bound,
and the value is user-configurable via ethtool --set-eee tx-lpi-timer, and
can also be 0 via the eee_timer module parameter used in stmmac_open().

For a timer of 0 us, _usecs_to_jiffies(0) is 0, so "timeout = jiffies" is
already at the boundary and the loop body may run zero or one time. For any
timer below ~200 ms the budget is smaller than the loop's own msleep(100)
granularity, so the loop degenerates to a single sample.

Independently of the granularity, stmmac_mac_enable_tx_lpi() programs the
link-status gate on every EEE enable:

	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
			     STMMAC_DEFAULT_TWT_LS);

with STMMAC_DEFAULT_LIT_LS defined as 0x3E8 in common.h, and
dwmac4_set_eee_timer() documents it as:

	/* LS: minimum time (ms) for which the link
	 *  status from PHY should be ok before transmitting
	 *  the LPI pattern. */

So 1000 ms of stable link is required before LPI may be transmitted at all.
With a configured LPI timer below roughly 400 ms and a recent link-up (the
usual bring-link-up-then-run-ethtool-t sequence), does the enter-LPI
deadline expire before the hardware is even permitted to enter LPI, making
stmmac_test_eee() return -ETIMEDOUT and stmmac_selftest_run() set
ETH_TEST_FL_FAILED on working hardware? The previous fixed ~900 ms budget
covered those cases.

Would a floor on max_duration, or a lower bail-out mirroring the new upper
one, be appropriate?

>  	/* We have no traffic in the line so, sooner or later it will go LPI */
> -	while (--retries) {
> +	timeout = jiffies + max_duration;
> +	while (!time_after(jiffies, timeout)) {
>  		memcpy(final, &priv->xstats, sizeof(*final));
>  
>  		if (final->irq_tx_path_in_lpi_mode_n >
> @@ -494,20 +506,38 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
>  		msleep(100);
>  	}
>  
> -	if (!retries) {
> +	memcpy(final, &priv->xstats, sizeof(*final));
> +	if (final->irq_tx_path_in_lpi_mode_n <=
> +	    initial->irq_tx_path_in_lpi_mode_n) {
>  		ret = -ETIMEDOUT;
>  		goto out_free_final;
>  	}
>  
> -	if (final->irq_tx_path_in_lpi_mode_n <=
> -	    initial->irq_tx_path_in_lpi_mode_n) {
> -		ret = -EINVAL;
> +	/* Re-snapshot, as we want to measure exit_lpi events. We should be
> +	 * in LPI right now.
> +	 */
> +	memcpy(initial, &priv->xstats, sizeof(*initial));
> +
> +	/* TX something so we go out of LPI */
> +	ret = stmmac_test_mac_loopback(priv);
> +	if (ret)
>  		goto out_free_final;

[Severity: Medium]
Can the "We should be in LPI right now" assumption be established from
irq_tx_path_in_lpi_mode_n?

That counter is a monotonic per-event counter bumped from the IRQ handler
and never decremented on exit, see dwmac4_irq_status():

	if (status & LPI_CTRL_STATUS_TLPIEN) {
		ret |= CORE_IRQ_TX_PATH_IN_LPI_MODE;
		x->irq_tx_path_in_lpi_mode_n++;
	}

The enter baseline is taken before the first loopback frame, so an entry
event that occurred in the window between the memcpy() and the transmit
inside stmmac_test_mac_loopback() satisfies the first comparison even though
the frame itself terminated that LPI interval:

stmmac_xmit()
	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
		stmmac_stop_sw_lpi(priv);

stmmac_stop_sw_lpi()
	timer_delete_sync(&priv->eee_ctrl_timer);
	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
	priv->tx_path_in_lpi_mode = false;

The same applies when unrelated stack traffic (ARP/ND/MLD on an up
interface) wakes the TX path during the up-to-100 ms poll interval, and for
the LPITXA hardware path where queuing a frame leaves LPI immediately.

In that case the re-snapshot folds the matching exit event into the new exit
baseline, the second frame is sent while the MAC is already awake, no new TX
exit-LPI event is generated, and with no further traffic the second loop
drains its full budget and returns -ETIMEDOUT, which stmmac_selftest_run()
reports as ETH_TEST_FL_FAILED.

The driver already tracks the current state in priv->tx_path_in_lpi_mode
(and LPI_CTRL_STATUS is readable). Would checking the actual state, or
waiting for a fresh entry event after taking the exit baseline and before
sending the wake frame, make the two phases deterministic? As written, phase
one can also pass on an entry event that predates the test frame, so the
enter-after-frame sequence described in the commit message is not strictly
verified.

> +
> +	/* Wait for the exit LPI interrupt */
> +	timeout = jiffies + max_duration;
> +	while (!time_after(jiffies, timeout)) {
> +		memcpy(final, &priv->xstats, sizeof(*final));
> +
> +		if (final->irq_tx_path_exit_lpi_mode_n >
> +		    initial->irq_tx_path_exit_lpi_mode_n)
> +			break;
> +		msleep(100);
>  	}
>  
> +	memcpy(final, &priv->xstats, sizeof(*final));
>  	if (final->irq_tx_path_exit_lpi_mode_n <=
>  	    initial->irq_tx_path_exit_lpi_mode_n) {
> -		ret = -EINVAL;
> +		ret = -ETIMEDOUT;
>  		goto out_free_final;
>  	}
>  

Thanks,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917215339.2022523-1-maxime.chevallier%40bootlin.com
