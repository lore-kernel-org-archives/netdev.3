Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262950;
	b=f1gV+Ld03mifkjncyC1buHN9cYaKAoTMyHn6obd7MtrsvybgmZfzwnst23TO+Jli2no0
	 g4Lxx4L0gMvOxFFWRezymifEcvWunziWTXEblfE165xVU6HukrNZnVVdXcHLhPJNoMIfJ
	 xdNG53skvUrHctT4xqwBY4MEvt8H8Oor759pFquE+YFeWoKiMTi59/GSflJ25htBmok6h
	 nEas9qFRjk1x+sl8Y0cQh6Ywct8U1DfAUfIY1bkxZl0CirpzE1MeOZUssYJI3XnpYZ16Y
	 f9rnnND9ZV+fIfzxfgmZbZKDe609TQzWeKIHcaY0ZnXD9w/h/1YTiLurvICyVS0SLOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262950;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1SCSdzox+bP/RO+n6prMBcIjjP00zBeENm/X4ViZbYQ=;
	b=XD+fRwcX+TePB32CXOZdjk2dM0FmGt+8auQzkph8I12mHRGKAN15f5UmENF9qiD8yeiP
	 Gqo8v+pRKot/0mWnGLbWd21HVd+f7qPqKA5lyyV8TG708qiaqTt0ZDHtgQEWP1UTcerH+
	 wDwXdz4/wrdMbjjPxSOJu712Ia1c17nhPRwVpYrdHV/EBCCdTXTC6uD+M8JE0RzV0n51x
	 kQxmK5qgeQKtcyJCnZwzLYbA0LHNAu4zCUuCZznwUrJ/aU4nYBt7RaYC3b5nblN4I50Sf
	 UE772evieaZjR13ybzrWLZ1gGPVd5Ecqon/MhMd5Gl524NBaDn15dcUgRGlo2CJuuxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6dFzm4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CB60A2602;
	Mon,  9 Nov 2026 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6dFzm4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DD71F008A3;
	Mon,  9 Nov 2026 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262949;
	bh=1SCSdzox+bP/RO+n6prMBcIjjP00zBeENm/X4ViZbYQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E6dFzm4XI6LcHL+nTc+WRfaR+UjLrn2W8AnX6y3pHEwSIrTDCa5yPuybVa5WQl6+H
	 l+8+PG3Uqnl7e7HN3WsiP8NNPQ4SeNNOrIedlV6ewr+gQBTL3FmRbN1yHbhJCys31p
	 HvuBLVyd/8Ubd2jA5X1W4ZDUp78RTZaMZUFO8SoNAAcINRoayHYED6/06PVC3BYsgo
	 M4R/qGDXiS2yUn5Fndh005N3ohf0MmhwqHyuw0kktXp5FdMY12H9j5QSa5frOhc5U7
	 upkywPg+ttccJeECk3eiaDvkN2cF88vj2M9RtkMIVqZIBZkB64qCRlbxRfsDMl5UVk
	 E3ktUkl+o9GIQ==
Subject: Re: [PATCH net-next v5 4/7] net: dsa: motorcomm: Isolate all ports
 during chip setup
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:22:28 +0000
Message-ID: <179426294858.994134.8238322500260280963@kernel.org>
In-Reply-To: <20261108214450.1662362-5-mmyangfl@gmail.com>
References: <20261108214450.1662362-5-mmyangfl@gmail.com>
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

- [Low] In yt921x_chip_reset() (drivers/net/dsa/motorcomm/chip.c), the
  new port-isolation loop does not run right after the hardware reset,…

--

net: dsa: motorcomm: Isolate all ports during chip setup

This commit writes all-ones to YT921X_PORTn_ISOLATION for every port in
yt921x_chip_reset(), so that all ports are isolated after the hardware
reset. It prepares for a later isolation refactoring. The commit message
notes that traffic can still leak before and during the reset.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 7686995b803f3..fbf3a0cba49b3 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -2257,6 +2258,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
>  		return -EINVAL;
>  	}
>  
> +	/* Block all traffic as soon as we reset the hardware since it now acts
> +	 * as a dumb switch.
> +	 */
> +	for (int port = 0; port < YT921X_PORT_NUM; port++) {
> +		ctrl = ~(u32)0;
> +		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
> +				       ctrl);
> +		if (res)
> +			return res;
> +	}
> +

[Severity: Low]
The commit message says ports are isolated "right after the hardware
reset". Does the placement of this loop match that?

In yt921x_chip_reset() the loop comes after the CPU tag TPID check, and
that check can return early once the reset has already completed:

    res = yt921x_reg_write(priv, YT921X_RST, YT921X_RST_HW);
    ...
    res = yt921x_reg_wait(priv, YT921X_RST, ~0, &val);
    if (res)
        return res;

    res = yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
    if (res)
        return res;
    eth_p_tag = FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
    if (eth_p_tag != ETH_P_YT921X) {
        ...
        return -EINVAL;
    }

If the TPID read fails, or the TPID does not match ETH_P_YT921X, the
function returns before any isolation register is written. The chip has
already been reset at that point, so it forwards between all ports.

yt921x_dsa_setup() then returns the error:

    mutex_lock(&priv->reg_lock);
    res = yt921x_chip_reset(priv);
    mutex_unlock(&priv->reg_lock);

    if (res)
        return res;

Probe fails and the hardware is not touched again. The switch keeps
bridging every front port.

yt921x_chip_detect() has already checked the chip ID, mode and extmode
before the reset. Would it be safe to move this loop to just after
yt921x_reg_wait() and before the TPID check? That would also match the
commit message.

The code is the same at the end of the series, in "net: dsa: motorcomm:
Support BR_FLOOD and BR_MCAST_FLOOD offloading", where the TPID check
still runs before the isolation loop.

>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108214450.1662362-1-mmyangfl%40gmail.com
