Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514918;
	b=GzpD7Uz3NIPbaUQ0nK0G8gwW9HKIvn2ONeVllOU9vAigUyy5g31evz+RZTU+gRfv7y2S
	 GeC+Iolowqx5hZtW0pTRG3wYPwRwQNtZcJgUSfPt5LEkBKTGIkzeUpplTuasUe0f5f5P7
	 3tnpnu/YjtsMgJskT4V/tBEybUXLKSPLiozxiM0irzusvm748sD6VILNgVir5deND+PHe
	 f2C25tKq+r98aBuIvyhrTXiqjcVyu/eUnlveHV12cmtuoSuUin0RStojuHx/EWAk1N9VR
	 j/R5ZPCKdtTWcJdaDd8NO/EIUZatCdvItOI0SgDXMywSenR56CJFs9ZqbEu7+RKdgkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514918;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JWZrjKwcXmjICx0+YDbcMtJTiJ23RLhSnQ9nOf3lyEk=;
	b=jZUQUTf3AVFMEbCXoVab51wqabw6bkCHpJiRbp91N5Ww0HoiCEMEZL9zt1hPquPYScrs
	 n5wk4PFNmzOyKhF62dJdStUqBInWFzEQftANamDr+nOTRh5UCnAec+aAdF3q5EBv2h7u5
	 SfvsWhuFE7K2M3WoQVS4yLCLdpNCCDAaFDPPG6JuMJozaHa2hoShqgzB9LzapkvuJBYdw
	 CMLP1W8cmJWDo+AcevQmyB02kU2+c76fw4qR+mtdnCVgMfgSizWwUoNZprOWfnUB9m3g/
	 eeodqXozB9zKs7REGB/2rODsCEYt4zsEsh6szuot6BMY0SQhmIabC3qxryiE7hXkZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2hvHRh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44627606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2hvHRh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2E71F000C4;
	Thu, 12 Nov 2026 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514918;
	bh=JWZrjKwcXmjICx0+YDbcMtJTiJ23RLhSnQ9nOf3lyEk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a2hvHRh8sD1ttugenc/VfdkMFMBjjhJD8+pZ38XW+HXDSBxJ11e4ZSIvSvy6ekb3D
	 ITbEzydsJTeLwmLwdgyv1Ne2I/Jvvfgye8tgk5A93WAoyut8ziQA26K4zxbYeXHM1W
	 RHx27T3lmUT1/xIvwpCYr7FFU4IDTW9ur5QE8MY3Y30DWWZ4lppADU8OBGpP1cS6mD
	 5drZT1wQUcsOyx5hEklrnMrmi5dJB6MVDnP5N8+Zf3TcRHCcpjITj8oTyapguWondq
	 n4xoA8xR7Ry0CgBOcOdsQS5uwPFimrXik7N1xXjbCtmLiFK2wU4QGXrGvUBKOxmljA
	 0YphzgoGTqh/Q==
Subject:
 Re: [PATCH net-next 1/2] bonding: 3ad: Receive packets in COLLECTING state
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, razor@blackwall.org, aahila@google.com
Date: Thu, 12 Nov 2026 20:21:57 +0000
Message-ID: <179451491706.2199510.1058504888559496420@kernel.org>
In-Reply-To: <20261111171947.2816258-1-idosch@nvidia.com>
References: <20261111171947.2816258-1-idosch@nvidia.com>
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

- [Medium] The fix clears 'inactive' only when ad_enable_collecting()
  runs.
- [Low] The patch fixes a real, user-visible bug but has no Fixes: tag.

--

bonding: 3ad: Receive packets in COLLECTING state

With coupled control disabled, an 802.3ad port in COLLECTING state should
receive packets, but the RX path only delivers from slaves whose inactive
flag is cleared. This patch makes bond_set_slave_rx_enabled_flags() clear
slave->inactive in addition to slave->rx_disabled.

> When coupled control is disabled, a port in COLLECTING state is supposed
> to receive packets, but it does not. The bond only delivers packets from
> slaves whose 'inactive' flag is cleared, whereas
> bond_set_slave_rx_enabled_flags() only clears 'rx_disabled'.
>
> Fix by clearing 'inactive' as well.

[Severity: Low]
Should this carry a Fixes: tag?

bond_set_slave_rx_enabled_flags() was added by commit 240fd405528b
("bonding: Add independent control state machine"), and that commit only
cleared rx_disabled. The RX gate in bond_should_deliver_exact_match()
checks only bond_is_slave_inactive(), so the bug goes back to that commit.

The notes say this targets net-next because it never worked, and that
makes sense. A tag would still let stable and distro maintainers link the
fix to the original commit:

Fixes: 240fd405528b ("bonding: Add independent control state machine")

> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 598d56b1bc970..cb89aff437f44 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -594,6 +594,7 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
>  static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
>  					       bool notify)
>  {
> +	slave->inactive = 0;
>  	slave->rx_disabled = 0;
>  }

[Severity: Medium]
With this change, inactive is only cleared when ad_enable_collecting()
runs. Can a COLLECTING port still be left with inactive=1 and
rx_disabled=0?

bond_option_all_slaves_active_set() can still set inactive without
touching rx_disabled when all_slaves_active goes from 1 to 0:

drivers/net/bonding/bond_options.c:bond_option_all_slaves_active_set() {
    ...
	bond_for_each_slave(bond, slave, iter) {
		if (!bond_is_active_slave(slave)) {
			if (newval->value)
				slave->inactive = 0;
			else
				slave->inactive = 1;
		}
	}
    ...
}

A COLLECTING port matches !bond_is_active_slave(). This is because
ad_disable_distributing()->__disable_distributing_port()->
bond_set_slave_tx_disabled_flags() left it in BOND_STATE_BACKUP.

The steady-state COLLECTING recheck in ad_mux_machine() only looks at
rx_disabled:

drivers/net/bonding/bond_3ad.c:ad_mux_machine() {
    ...
					if (aggregator->is_active &&
					    bond_is_slave_rx_disabled(slave)) {
						ad_enable_collecting(port);
						*update_slave_arr = true;
					}
    ...
}

Since rx_disabled stays 0, the recheck never fires. Until the next mux
transition, bond_should_deliver_exact_match() keeps returning true, and
every non-LACPDU frame on that port gets RX_HANDLER_EXACT.

The notes list this as known issue 1 and describe COLLECTING as
transient. However, the companion selftest ("selftests: bonding: Add a
test for 802.3ad with coupled control disabled") keeps a port in
COLLECTING indefinitely by clearing the partner's Collecting bit. So a
partner that never sets LACP_STATE_COLLECTING would keep the port
dropping traffic.

Would it work to also check bond_is_slave_inactive(slave) in the recheck,
for example:

    bond_is_slave_rx_disabled(slave) || bond_is_slave_inactive(slave)

That would let the port recover on the next state machine tick.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111171947.2816258-1-idosch%40nvidia.com
