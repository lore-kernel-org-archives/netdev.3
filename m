Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503872;
	b=HFzRJeU2wRY4zJKz8NOMiRGwYe4SwRxpq7aapzXJ22SFSTjQjDj6olz0vYxzizMW5paX
	 uju1dseuw0NFbUgC7y4gb+szA9No2S8mc5m75/DROzQn7HErD4iekf+t9QsQp01qFWsHT
	 xjS5SdQHBq8tTZKxs0p8tHW5Iq0EjJQWOQ8IUzH43K1gruVZNEnbXFHT6bCO0VcdUmwEa
	 v4vWAR6+5coKCsgFer8DaImhJ80msv7HgQbAJQUSQmZ0mMm8rowtJNHgWyb5aD0o1bnkz
	 AvBYJPYdhex43MnyQY6EO5hpO/4352DUuQgIrtKFMdOXen3YBhnCsi2ldVGoRTahXnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503872;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6/lts8UHglPwoIUdhVhv4E41rBr0awp3JcM6GQfq77Y=;
	b=O2cCVSUUjgbfMOWjqhznoYGyOGM+fSZBiIgOymscM0jKZKyatLwVljwvJyeupa+1mbYJ
	 Y8dFBWkGqhmGEc5ctwYgXW8IpPSHuLtO8B8auUBZ3fcW/xFl/XEWQB6YjmTItWbTqiFWk
	 COQlpOXKWdaGymOY+DsDsvmi3R2LUqQAkXsz9QUTbSA1CTJid4UWwgMBdYdyXR5R/4Cst
	 9IsMuvLSPoI6iIga6J7gRzncz/HHv9KRByUhNce42GdQG91+Ifi96kMZj/NZeI+6epqnf
	 ic2VgFoSes7ll8v6v9pyQ4wn36BAf8zGxudE028DmXa8Wo6Sc9xXAVImH6JCkJYoiXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYKvg3wx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC2606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYKvg3wx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0270A1F000C4;
	Thu, 12 Nov 2026 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503872;
	bh=6/lts8UHglPwoIUdhVhv4E41rBr0awp3JcM6GQfq77Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HYKvg3wx0aw0A9XnLWJfCnsl4jQIXjda3h9HKOZO/oDPEPrTQh+qkXWei3ntyMenv
	 2uDGcz2pJWKDuU8eYKEB9u8HIK5S+Hh14ewwLC81NMIlKyIWF8QnM8RSNtKjJWp4lP
	 f7Qw65wvPsPRI2dkJfn3TvRLMpufrt24p/h+HNpeEMrKyc32U9hYBRiUZIlyIcL9G1
	 z53WaZTz43fXXXRAFdt8oMp0R6LCrxV7MR+8v0NbFZUkMNrsF+LSPrfn17TpZxAS/y
	 d3qPgGCPTnS/Fop6Km9UmYxGY+tD4CPYZ6OapRk7iawzf6jTwG4nqMajNRQN7R8AQc
	 P8gBd2YwTOHTw==
Subject: Re: [PATCH net-next] mlxsw: Disable LAG collector when requested
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch,
 petrm@nvidia.com
Date: Thu, 12 Nov 2026 17:17:51 +0000
Message-ID: <179450387153.2199510.7230065692935796784@kernel.org>
In-Reply-To: <20261111170925.2809513-1-idosch@nvidia.com>
References: <20261111170925.2809513-1-idosch@nvidia.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Before this patch, mlxsw_reg_slcor_col_disable_pack() did
  nothing in practice.
- [Low] mlxsw: missing Fixes trailer for
  mlxsw_reg_slcor_col_disable_pack() bug fix

--

mlxsw: Disable LAG collector when requested

This commit changes mlxsw_reg_slcor_col_disable_pack() so that it packs
MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_DISABLED instead of the "collector
enabled" value. A collector disable request now takes effect in the ASIC,
and packets received on a disabled LAG port are dropped in hardware.

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
> index 01fcbd1c8d015..9dbeabf5536d1 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
> @@ -1491,7 +1491,7 @@ static inline void mlxsw_reg_slcor_col_disable_pack(char *payload,
>  						    u16 local_port, u16 lag_id)
>  {
>  	mlxsw_reg_slcor_pack(payload, local_port, lag_id,
> -			     MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_ENABLED);
> +			     MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_DISABLED);
>  }

[Severity: Low]
This fixes a real bug in mlxsw_reg_slcor_col_disable_pack(), but the
commit message has no Fixes: trailer. As far as I can tell the helper
has packed MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_ENABLED since it was added
in commit d1d40be084c6 ("mlxsw: reg: Add link aggregation configuration
registers definitions"). The LAG code in spectrum.c has used it to
disable collection since commit 0d65fc13042f ("mlxsw: spectrum:
Implement LAG port join/leave").

The commit message says this is not a regression, and the patch is
aimed at net-next, so leaving the tag out may be deliberate. Without
it, though, stable tooling has nothing pointing at where the bug came
from. The same goes for anyone bisecting LAG ingress behaviour on
Spectrum.

Should this carry a Fixes: tag against d1d40be084c6? If the intent is
to keep it out of stable because it changes ingress behaviour on
existing LAG setups, could the commit message say so explicitly?

[Severity: Medium]

Now that this write takes effect, can mlxsw turn off the hardware
collector on an 802.3ad port that the bond still treats as collecting?

In drivers/net/ethernet/mellanox/mlxsw/spectrum.c, one tx_enabled bit
controls both the distributor and the collector:

mlxsw_sp_port_lag_changed() {
	if (info->tx_enabled)
		return mlxsw_sp_port_lag_col_dist_enable(mlxsw_sp_port);
	else
		return mlxsw_sp_port_lag_col_dist_disable(mlxsw_sp_port);
}

That bit comes from bond_lower_state_changed(), which only reports
whether the port is distributing:

	info.tx_enabled = bond_is_active_slave(slave);

struct netdev_lag_lower_state_info has no collecting field. So the driver
can't tell "collecting but not distributing" apart from "disabled".

Also, mlxsw_sp_master_lag_check() only checks tx_type. Bonds with
coupled_control=0 are still offloaded.

With independent control, ad_mux_machine() can move a port from
AD_MUX_DISTRIBUTING to AD_MUX_COLLECTING, for example when the partner
clears its Collecting bit. On entry to that state the bond does:

	case AD_MUX_COLLECTING:
		port->actor_oper_port_state |= LACP_STATE_COLLECTING;
		port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
		port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
		ad_enable_collecting(port);
		ad_disable_distributing(port, update_slave_arr);

ad_disable_distributing() calls bond_set_slave_tx_disabled_flags(). That
function only sets the backup state and leaves slave->inactive at 0. As a
result, bond_should_deliver_exact_match() still accepts frames on this
port in software.

The lower state notification still carries tx_enabled=0, so the driver
runs:

mlxsw_sp_port_lag_changed()
  mlxsw_sp_port_lag_col_dist_disable()
    mlxsw_sp_lag_col_port_disable()
      mlxsw_reg_slcor_col_disable_pack()  /* now COLLECTOR_DISABLED */

Before this patch, the ASIC kept collecting in this state, which matched
the bond.

A conformant partner only clears Collecting while it is in ATTACHED and
not distributing, so this doesn't look like a lasting black hole. The
problem is the window when the partner starts sending again:

- A coupled control partner moves to COLLECTING_DISTRIBUTING as soon as
  it sees our Sync.
- An independent control partner moves to DISTRIBUTING as soon as it sees
  our Collecting.

Would the partner's first frames be dropped in hardware during that
window? The drops would last until our mux machine reaches
AD_MUX_DISTRIBUTING and the deferred bond_slave_state_notify() delivers
tx_enabled=1.

This also seems to conflict with the commit message:

  "Packets received on a disabled LAG port are now dropped, as they are
  in the bond's software datapath."

In AD_MUX_COLLECTING, the bond's software datapath doesn't drop these
packets. Is that statement accurate for this state?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111170925.2809513-1-idosch%40nvidia.com
