Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971844;
	b=j2US/5D7Kwk6bb393lDBvCrsMxaJeObXDWdshZlTN1nU3JeSVHlMZyCbaQa66+UZgWyy
	 p448W/+WcieN5Uj1QmhoADYEa+Lp9cnFmjGKxtVq754RnroMii43NOVyZCXjUSFhUBqpY
	 LrKXAVulvNU08Dgt7g46dm0UWLvTzZnv9OXGOmkEJjlxgQ7w3g37xUoi7tAVt1UFn5XNL
	 R5r5oKY12BgeNTzOE4vv/8iIYGDsrUQ9QUahqakehRKc6C9xVkFPi4l2+lx4vAU+A4GC2
	 UcT9laH+CcWC64a8Ly2DvMICnTUr9eSELPLU/fSVlyi1k4HioZPPBp3eI/mOj7ferAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971844;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Tnl0RKB6UtuKZuafATHpWiMuTZFb3Yz87x+53TxGrEM=;
	b=cksfncmLS1pHqjD20YM21dDntUIfucuvmqU3We6cLa0QSfiIG9Sozk6jolaIuuQXggN4
	 1efOTD309ymNdhKfMOpw9HGlta1SgX62f07SGYZTf5eawx3ZDQ6TQ9rF830lsIqOXcoqu
	 2+X4snllzd3AZ8dt7DVwppkvE1vXAwM72RK9tnpB7gSwQ2EkmVSpfe4QX8tQCJqwFbb/o
	 jPIgaSegHw0XjOhWa3c//UIJLUy4PVLos75d5kJcumuWOinWoM261UqPRr53m9lvwM43B
	 1QP1iwp/4xrALWtAnVa0vDchMIKSmq7c78nZk7/1nGn+kHGhdD9OLfwhFga2abfojJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8GZfcxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BC606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8GZfcxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B821F031E1;
	Sun, 25 Oct 2026 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971843;
	bh=Tnl0RKB6UtuKZuafATHpWiMuTZFb3Yz87x+53TxGrEM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G8GZfcxbKSeuq9m4vIPiW2PnzkwI0cLb4Wdhl6fPO82dcnRIBNl7OSFVq/GR1BPDr
	 gZiMH/SfALF9GdX7dCuGD1hzOJ56vAKk/M/YCpMWHSZRnlEkHJ0+IEExcBJxkLb1Oc
	 A/YBhJNLMowU+OkiQbweai0ACjYC7wrtFjCUrb5xLkPkzLdxfYFgqigNjqXP6g9B/i
	 UMjsHNHbjLr660k8iP1UswFsggEd0sqHPEHaVBFxhZL1eDajXPIim103M+5ADEbFzj
	 c4iV65PBGFTtwtDfNOaA4IMdAyKyoH7KkqvBPfcINcuhsNZG8tOrcTHSD4c8+PVi6j
	 yTCGEnhelqSEA==
Subject: Re: [PATCH net v5 09/13] ice: E825: clear PHY_TSTAMP memory prior to
 soft reset
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:44:02 +0000
Message-ID: <179297184201.3134.9594473446313979273@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-9-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-9-72289a4ac8eb=40intel=2Ecom=3E?=
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

- [Low] In ice_ptp_phy_soft_reset_eth56g()
  (drivers/net/ethernet/intel/ice/ice_ptp_hw.c), the read sweep…

--

ice: E825: clear PHY_TSTAMP memory prior to soft reset

This commit removes the write-based ice_ptp_reset_ts_memory_eth56g(). In
its place, a new ice_ptp_clear_tx_memory_status_eth56g() reads every
PHY_TSTAMP index for a port. That sweep is now called at the start of
ice_ptp_phy_soft_reset_eth56g(), so the soft reset clears the internal Tx
timestamp counter after the reads. E825 is also dropped from
ice_ptp_reset_ts_memory().

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07b55fbb88dd..5637925c0e68 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>  	u32 global_val;
>  	int err;
>  
> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> +
>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",

[Severity: Low]
The sweep has no return value and always runs before the PHY_REG_GLOBAL
read and the three PHY_REG_GLOBAL writes. Any of those sideband accesses
can fail and make ice_ptp_phy_soft_reset_eth56g() return early. If that
happens, the port has been swept but its internal counter was never
reset.

The new kdoc for ice_ptp_clear_tx_memory_status_eth56g() says:

  Due to interactions with an internal HW counter for the number of
  outstanding Tx timestamps, this *must* only be called as part of the
  ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
  may become out of sync and prevent new timestamp interrupts.

Doesn't this error path leave the port in the state that comment warns
about?

I could not find any visible effect from this today:

- ice_ptp_init_phc_e825c() stops at the first port that fails.
- The error reaches ice_ptp_init_owner() or ice_ptp_rebuild_owner(), and
  both treat it as fatal for PTP.
- Recovery paths, such as a link toggle or a driver reload, run the sweep
  and the soft reset again.

So this looks like a robustness and documentation mismatch rather than a
functional regression.

Could PHY_REG_GLOBAL be read before the sweep, so that a failure at that
first step happens before the counter is touched? Alternatively, the kdoc
could be updated to cover the error path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
