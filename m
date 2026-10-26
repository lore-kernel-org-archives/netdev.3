Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018653;
	b=anfcSBPWMLLw62gqQ6XOXNNXpcPpMJGNZQpBoj0RSX0dkIssE2Ochh9ApvPX80jFegXV
	 SZMZ8tnJmdJbGBXdAEfKHQ6URnuaE2oEm8jT72c+8He2xAkLrKx3QMQyL+pNBEIDCfxCa
	 VzNYhwy72B56XxUiS1IwNKXAaX2hn/Khd9tXb7HhCuOeYxvhL4dzzuBjCmrXggsyZoUY+
	 EbVEMHUdT8fyzACl9myXgMZwSD2/V5GcI65/qbkp14tF7OPh9SicsGnEE/gl3iNe1Nj4T
	 Ho8G5LXYc3bN9bkAsyn1wVA0cApaTplbnqmVOVLklAH+R2MdWFfJct/9o9c9yHG6jyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018653;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/+0f6L1ejx5QM3sVEKtfmLyTDHGqquYakcMtFvsjOh0=;
	b=qPxumr4RtORa0lQ1c8pNpoyScGIBqYJDHH5QkbgJvZfdtkdVuo4YLxVW2lN3qZ+Yzi6N
	 ALFiogn6JoWqd6aDdEWfuvr1NayOMkUm+hoAwEZb8YxSB5M58fUo4mXVhKuctJXnSRNo8
	 Nx4A1gB97ghh+x1I+JaPsqubeVcXTEpmxLIP/UwoF1uAsrVi9sORqdolEQB47wd/nSNVF
	 g6mvyAeJaxPedPtTTW5Eh8alAcD2EOJRNckg66s2twkCPTRMqkFvdr1kEmhTZJd/6sOWu
	 igIuvADrnmrHb1KKeBIcaK9Tpo3miliDlhCYzJs2RZ5jMA9rfNBCl/NbCcPQ2DszaUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZSxL/+bS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F98606A32D;
	Mon, 26 Oct 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSxL/+bS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A52E1F031E3;
	Mon, 26 Oct 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018653;
	bh=/+0f6L1ejx5QM3sVEKtfmLyTDHGqquYakcMtFvsjOh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZSxL/+bSqXFR88Eu5/VviCYbVV3CsXjFDVfj+IkuzC3g91E2lqCWalqqBYjPSt0b2
	 +uRqJr3u1Qe9LnZ9xh/fCusg71w0rv4/SaA7Z+C3wkRzKkYCKRG5fev48vSWsJ1Nih
	 2N+WreDmnNUV1+GRRnLIg48wjV9ozJXebrOVQPJJyjr+2Q7LC2sPhNWD9dyyY9F1l3
	 mI61z4pH0wcuuJGJsmxOXPCwiYs6KeJK/aDTnoM9k6NzusdwsALlunglnNli1vvucO
	 +OuTNG8uPr+Ux5xaBnLdwIA43Q2wIGXWFoB//0P3e2aLLlgKwtg1d+lr2q3zrAqKeh
	 Ozd7iwDsDldDg==
Subject: Re: [PATCH net-next v18 4/4] hinic3: Add ethtool pause param ops
From: netdev-bot+sashiko@kernel.org
To: gongfan1@huawei.com
Cc: wudi234@huawei.com, tengpeisen@huawei.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ioana.ciornei@nxp.com,
 maxime.chevallier@bootlin.com, mohsin.bashr@gmail.com,
 dimitri.daskalakis1@gmail.com, hramamurthy@google.com,
 larysa.zaremba@intel.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 zhoushuai28@huawei.com, wulike1@huawei.com
Date: Mon, 26 Oct 2026 12:44:11 +0000
Message-ID: <179301865162.3134.6839419847418122778@kernel.org>
In-Reply-To:
 <1e5e99cc3ff7a93094dddf96321ba465ba0ce343.1792671176.git.gongfan1@huawei.com>
References:
 <1e5e99cc3ff7a93094dddf96321ba465ba0ce343.1792671176.git.gongfan1@huawei.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hinic3_get_pauseparam() always sets `pause->autoneg =
  AUTONEG_DISABLE` (hinic3_ethtool.c:883) and ignores…
- [Medium] hinic3: hinic3_get_pauseparam() lacks VF check and exposes
  pause ops on VFs
- [Low] hinic3_set_pauseparam() (hinic3_ethtool.c:902-903) turns the
  __u32 uAPI flags into firmware bytes with `nic_pause.rx_pause =…
- [Low] When hinic3_get_pause_info() fails (mailbox timeout, -EPERM when
  !chip_present_flag in hinic3_send_mbox_to_mgmt(), or firmware status…

--

hinic3: Add ethtool pause param ops

This commit adds .get_pauseparam and .set_pauseparam ethtool callbacks to
the hinic3 driver. A new hinic3_set_pause_info() helper sends the
L2NIC_CMD_CFG_PAUSE_INFO SET command to firmware through
hinic3_cfg_hw_pause().

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index e1f23e2477fa0..3005441056f92 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -869,6 +869,45 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
>  	kfree(ps);
>  }
>  
> +static void hinic3_get_pauseparam(struct net_device *netdev,
> +				  struct ethtool_pauseparam *pause)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_nic_pause_config nic_pause = {};
> +	int err;
> +
> +	err = hinic3_get_pause_info(nic_dev, &nic_pause);
> +	if (err) {
> +		netdev_err_once(netdev, "Failed to get pauseparam\n");
> +	} else {

[Severity: Medium]
Is hinic3_get_pauseparam() missing a VF check? The other pause paths
in this driver treat physical port pause as PF-only:
hinic3_get_link_settings() skips hinic3_get_link_pause_settings() on
VFs, hinic3_get_pause_stats() returns early for HINIC3_IS_VF(), and the
new hinic3_set_pauseparam() returns -EOPNOTSUPP for VFs. The getter has
no such check. On a VF netdev, "ethtool -a" therefore sends
L2NIC_CMD_CFG_PAUSE_INFO to the management CPU through
hinic3_get_pause_info() and hinic3_cfg_hw_pause(). When that command
fails, as it presumably does for a VF, the driver logs the dev_err()
from hinic3_cfg_hw_pause() plus the netdev_err_once() here.

hinic3_set_ethtool_ops() installs the same hinic3_ethtool_ops table
on both PF and VF netdevs, so the core treats VFs as supporting pause.
Because get_pauseparam returns void, neither ethtool_get_pauseparam()
nor pause_prepare_data() can report -EOPNOTSUPP. The user sees a
zeroed or bogus pause state instead of an unsupported error.

The set side is affected as well. ethnl_set_pause() calls
get_pauseparam first and only calls set_pauseparam if a value
changed. Take a VF where the query fails and leaves pause zeroed.
"ethtool -A ethX rx off" sees mod == false and returns 0 without ever
reaching the HINIC3_IS_VF() check in hinic3_set_pauseparam(). The VF
then reports success for a request it can't support.

Would a separate ethtool_ops table for VFs, without .get_pauseparam
and .set_pauseparam, be the cleaner fix? That lets the core return
-EOPNOTSUPP for both ethtool -a and ethtool -A on VFs. Failing that,
should the getter at least bail out on HINIC3_IS_VF() before sending
anything to firmware?

[Severity: Low]

If hinic3_get_pause_info() fails here (mailbox timeout, -EPERM when
chip_present_flag is clear, or a non-zero firmware status), pause is left
zeroed. What happens when this runs as the read step of ethnl_set_pause()?

net/ethtool/pause.c:ethnl_set_pause() {
    ...
	dev->ethtool_ops->get_pauseparam(dev, &params);

	ethnl_update_bool32(&params.autoneg, tb[ETHTOOL_A_PAUSE_AUTONEG], &mod);
	ethnl_update_bool32(&params.rx_pause, tb[ETHTOOL_A_PAUSE_RX], &mod);
	ethnl_update_bool32(&params.tx_pause, tb[ETHTOOL_A_PAUSE_TX], &mod);
	if (!mod)
		return 0;
    ...
}

Take a partial request like "ethtool -A ethX rx on". rx goes from 0 to 1,
and hinic3_set_pauseparam() then sends both directions to firmware. That
includes tx_pause = 0, which came from the failed query and not from the
user. Can this turn off TX pause that was previously on?

Now take a request that matches the zero fallback, such as "rx off" while
RX pause is actually on. mod stays false, and ethnl_set_pause() returns
success without calling the setter. Is the requested change silently
dropped in that case?

Because netdev_err_once() is used, later failures also leave nothing in
the log.

get_pauseparam returns void, so the driver can't report the error. The
older hinic driver caches the last configured pause state in nic_cfg. Would
something similar work here?

> +		pause->autoneg = AUTONEG_DISABLE;

[Severity: Medium]

Should this report the firmware's pause autoneg state instead of
hardcoding AUTONEG_DISABLE? hinic3_cfg_hw_pause() already copies it from
the firmware response:

	if (opcode == MGMT_MSG_CMD_OP_GET) {
		nic_pause->auto_neg = pause_info.auto_neg;
		...
	}

Here nic_pause.auto_neg is dropped. As a result, ethtool -a shows
"Autonegotiate: off" even on ports where hinic3_get_link_settings()
reports autoneg as on:

	link_settings->autoneg = port_info.autoneg_state == PORT_CFG_AN_ON ?
				 AUTONEG_ENABLE : AUTONEG_DISABLE;

On the set side, hinic3_set_pauseparam() rejects any autoneg request and
never checks the port's AN state. The zero-initialized nic_pause.auto_neg
stays 0, and hinic3_cfg_hw_pause() copies it into the SET command:

	if (opcode == MGMT_MSG_CMD_OP_SET) {
		pause_info.auto_neg = nic_pause->auto_neg;
		...

On a port with PORT_CFG_AN_ON, does every "ethtool -A" then write
auto_neg = 0 to firmware and overwrite its pause autoneg state? It's not
clear how the firmware reacts to that on an AN link. It might keep forced
pause settings that disagree with the advertisement, or reject the set
with -EFAULT.

The older hinic driver handles this differently. hinic_get_pauseparam()
reports pause_info.auto_neg from firmware. hinic_set_pauseparam() requires
pause->autoneg to match port_cap.autoneg_state and then passes it through
to firmware.

> +		pause->rx_pause = nic_pause.rx_pause;
> +		pause->tx_pause = nic_pause.tx_pause;
> +	}
> +}
> +
> +static int hinic3_set_pauseparam(struct net_device *netdev,
> +				 struct ethtool_pauseparam *pause)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_nic_pause_config nic_pause = {};
> +	int err;
> +
> +	if (HINIC3_IS_VF(nic_dev->hwdev))
> +		return -EOPNOTSUPP;
> +
> +	if (pause->autoneg)
> +		return -EOPNOTSUPP;
> +
> +	nic_pause.rx_pause = (u8)pause->rx_pause;
> +	nic_pause.tx_pause = (u8)pause->tx_pause;

[Severity: Low]

Can these u8 casts turn a non-zero request into 0?

The netlink path normalizes these values with ethnl_update_bool32(). The
legacy ETHTOOL_SPAUSEPARAM ioctl path does not: ethtool_set_pauseparam()
copies struct ethtool_pauseparam from userspace and calls
->set_pauseparam() with the raw values.

With rx_pause = 0x100, nic_pause.rx_pause becomes 0. Pause is disabled
while the call returns success. Values 2 to 255 go to firmware unchanged.

Would !!pause->rx_pause and !!pause->tx_pause be safer here?

> +
> +	err = hinic3_set_pause_info(nic_dev, &nic_pause);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792671176.git.gongfan1%40huawei.com
