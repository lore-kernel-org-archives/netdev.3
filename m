Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577243B3BE9;
	Wed, 14 Oct 2026 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946757; cv=none; b=mjAaUvf5OhGS4SxBvT12mEP/qWfp/701FfkKSYc5IvlXhXiWRw7dfh24g78e9UcIhgUt7ToU/Q1yGioW4QQXM3hcawgAqtqE7XuRKaiCxzfMOFHs3Mtj9ovqXkvARhT0+W5BwQAt+9tv79VQOTcL9JvNhqKLOrazod8Kd1A4bAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946757; c=relaxed/simple;
	bh=j+Rxvd54Vk6gDEKPc1lDdpDc8XgdhDfMLzvBtXpI//Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwyGzKukqMqtBdEjVPEOjJW1FyAiWLm77LOfkk/7Ck0lfF1w6l5BS6Pt/MGcBBMAUKd4QmWOFtq1yQxkTmFqexWGl29AWnpMqTu1gRRL6O+X2Vx/+07f6dF1tkM7WAfSTFxPx58Cu9G8+VZhzoddBRme9cDaG5nCDlWfWos3ftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvaTii6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvaTii6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7314C1F000FF;
	Wed, 14 Oct 2026 02:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946756;
	bh=spueybEMAhCuXo502eXZZyRO76o30hz6Q1fAMv+3EDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gvaTii6NU8sZpmAHSOCu21UcIYfU+KOdrdltjELOPdJxerFQ+uTB6rAWIOMUu9ALf
	 gcZiZU+pv2LholQJNu0lAZ/OVYyk7YF7x5gZDFFF35IuVATAcDhV75mDrAJlvigW3o
	 3Q4yr7oO/8vIyTKt3fUl/Vl+frDVlt1s0rNajHXOlJxkDcTz95Ze6B3ZDWBHojDW2S
	 kquth0Jhb344lJxHr1qs4jmgXp8MgSdGWDFjV22xlmNwIrDyu+82mSCuLEs9qmTKkW
	 FbaURQ7Osq4Gejk+yIsU1rfxtQpm1Hy44KBMrwpw5TT1XJIdg+HC/fPN0y4fIDPCz6
	 37BogXu47VRYg==
Subject:
 Re: [PATCH net-next v16 5/5] net: rnpgbe: Add link status handling support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Wed, 14 Oct 2026 02:59:15 +0000
Message-ID: <179194675502.434549.7732604818016535673@kernel.org>
In-Reply-To: <C41AE78496D9DC2B+20261013023109.63764-1-dong100@mucse.com>
References: <C41AE78496D9DC2B+20261013023109.63764-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds a rule for the shared FW<->PF mailbox window:
  before a PF command overwrites MUCSE_MBX_FWPF_SHM, any unacknowledged…

--

net: rnpgbe: Add link status handling support

This commit adds link status handling to the rnpgbe driver. Firmware link
events arrive over the mailbox and are handled by a service task that sets
the carrier state. Firmware is notified on port up/down, and probe now
configures autonegotiation through a new PHY_LINK_SET command.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> index 2310f01df1f50..ef00b948ad0f6 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c

[ ... ]

> @@ -320,6 +418,44 @@ static int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size)
>  	return 0;
>  }
>  
> +/**
> + * mucse_write_mbx_pf_coalesce_event - Write around a level-like event
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_write_mbx_pf_coalesce_event(struct mucse_hw *hw,
> +					     const __le32 *msg, u16 size)
> +{
> +	const int size_in_words = size / sizeof(__le32);
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int err;
> +
> +	err = mucse_obtain_mbx_lock_pf(hw);
> +	if (err)
> +		return err;
> +
> +	err = mucse_ack_pending_event(hw);
> +	if (err)
> +		goto release;

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index e28f3193aa854..683e0ea741136 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c

[ ... ]

> +int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
> +		       u32 speed, u32 duplex, u32 mdix_ctrl)
> +{
> +	union mbx_fw_cmd_req_u req = {

[ ... ]

> +	int len, err;
> +
> +	len = le16_to_cpu(req.r.datalen);
> +	mutex_lock(&hw->mbx.lock);
> +	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
>  	      ^^^^

[Severity: Low]

This patch adds mucse_write_mbx_pf_coalesce_event(). It acknowledges any
unacknowledged firmware event in MUCSE_MBX_FWPF_SHM before a PF command
overwrites the shared window. Only SET_PHY_UP and LINK_REPORT_EN use it.

Should mucse_mbx_set_link() go through mucse_write_mbx_coalesce_event() as
well? Right now it uses
mucse_write_and_wait_ack_mbx()->mucse_write_mbx_pf(), which writes the
window without checking fw_req. mucse_mbx_powerup() and
mucse_fw_send_cmd_wait_resp() use the same plain path.

One way to reach this is remove or shutdown after an earlier mailbox
failure. rnpgbe_down() treats a failed LINK_REPORT_EN(false) as non-fatal:

    err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
    if (err) {
        ...
        dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
    }

It then sends SET_PHY_UP(false), which can trigger a link-down event.

rnpgbe_rm_adapter() and rnpgbe_dev_shutdown() tear down the event consumer
before the power-down notification:

    rnpgbe_free_mbx_irq(mucse);
    rnpgbe_notify_powerdown(mucse);

The cancel_work_sync() in rnpgbe_free_mbx_irq() can drop a queued
mbx_work. An event can also arrive after free_irq().

In both cases rnpgbe_notify_powerdown()->mucse_mbx_powerup(hw, false)
writes POWER_UP(false) over that event with the plain writer, and the event
is never acknowledged.

What happens depends on how firmware handles a PF request that overwrites
an unacknowledged event. Could the power-down command be misparsed, or time
out waiting for an ack, in that case?

The stale event also looks like it carries over to the next driver
instance. mucse_mbx_reset() syncs hw->mbx.fw_req to the current counter
without incrementing pf_ack. On the next ifup, mucse_ack_pending_event()
then sees fw_req == hw->mbx.fw_req and skips the acknowledgment.

> +	mutex_unlock(&hw->mbx.lock);
> +
> +	return err;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3B42BE25B3696EAE%2B20261013022920.63529-1-dong100%40mucse.com
