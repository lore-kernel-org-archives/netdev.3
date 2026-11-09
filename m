Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183825;
	b=ZHvQqdTKStp8XMnBFXkP/EVq6N6BJHa+r/eCVr11QwyNttxGVKzGEA9ftedSMQTqH/Dw
	 KJDu/f3QaXdk+SxWtsKyq7Mt1bTm5Sm0tuHitciVtQyQ7GMRnADzMUjbpseIHD9TZea7p
	 ApUCzNwx1MhgVpj9ysyvPDdmYkdFwe5ld/4zti74K+2aB4Dz6H8jSFkgbB8v5RNzFVlOv
	 TJ/4DPHBgfMmk+Djc9EeCMSiVPZFrQQgiFJSvDYaPbfJFwk1hmnA5hEklkpYoV1ustEGm
	 A4zRlHK9mo4B1lkIUKeYFWjgH7v9mpjksWyrP6kpJsNxKS7+Lic2A0mKK9VII2U4scA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183825;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d5oIkC3vkpUeCRqtBQPySjNSXhBUukoSypJuE6glTuE=;
	b=G9emQn93l3l+GnfRnvsXSK8n2HgWz4dAlU1ggFayPuR3WGIg8qoQq30ZTtKDe0MtpRVY
	 HCwGu7bpMLtz3BWOXp5Yd1uKYJIJ5M+5PqxB1j8JaEirBddAchmJs9FuX/6K37UHNrEC6
	 lgB+5R9suvyNsZMssD9MKg+JP1h40vaPiJ1zEBXfmj5ddb0VOYSypdinInHr3ZCYnH/lP
	 BtYbJJfMyIcj2luHpDBn2kbQz7wfysQ1AbaTeFxbzZLcQBoDpl+YQPWcp/QE479MyzFQF
	 4kHhLnxz+/loQlFm0AopeLRRFqMrBnbvYXXdMUZ3AxETemJL95UUH7bQUZXWkq1heiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhzSt7kA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3D606A33F;
	Mon,  9 Nov 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhzSt7kA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74801F0089F;
	Mon,  9 Nov 2026 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183824;
	bh=d5oIkC3vkpUeCRqtBQPySjNSXhBUukoSypJuE6glTuE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AhzSt7kAYN/cG/9Kt6cyoK5fvX4fdx7nzWYVlhBxUr5G3+E61MRofN8TaRP9q6i5+
	 HuwKzzwNdOt0MFEDLCOJ3ExzcKcpJACUgvZ6V/FNfCxDIF/zlb9TAdIb8jxajtvaj5
	 QT0vRE6BSjXUMjANZLDmwE2gArmXM20MoOMdaQMlnBrY/A5/8m8udfhEzBtj1j/tyu
	 EmZ0xb7KkuaO86jkN+yj3vOYlaBLco+Fm6o3q02dcFIb0hh1kWwn8zdHXjTlb7dm77
	 GtULudhIy5fjTaxBj23yw3MM/tVCpb7HdsMLCN3sXNnbTwvEH+P7Mt8zbotKWPa1lj
	 VNpOw1ABwytqA==
Subject: Re: [PATCH net v3 3/5] net: mvneta: unwind a failed mqprio setup
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 00:23:43 +0000
Message-ID: <179418382346.994134.3211728825005845989@kernel.org>
In-Reply-To: <20261104224518.66487-4-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-4-pepe.schlehofer@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/ethernet/marvell/mvneta.c, the new `err:` label
  in mvneta_setup_mqprio() does not put back the hardware state that…

--

net: mvneta: unwind a failed mqprio setup

This commit adds an err: label to mvneta_setup_mqprio(). When a mqprio
offload setup fails, the driver now clears the VLAN priority to RX queue
map, disables the per-queue TX rate limits and resets the netdev traffic
classes, so no partial configuration is left in hardware.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 79711a117c39c..171111d7fe57d 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c

[ ... ]

> @@ -5289,29 +5291,39 @@ static int mvneta_setup_mqprio(struct net_device *dev,

[ ... ]

>  			ret = mvneta_setup_queue_rates(pp, txq,
>  						       mqprio->min_rate[tc],
>  						       mqprio->max_rate[tc]);
>  			if (ret)
> -				return ret;
> +				goto err;
>  		}
>  	}
>  
>  	return 0;
> +
> +err:
> +	mvneta_clear_rx_prio_map(pp);
> +	mvneta_disable_per_queue_rate_limit(pp);
> +	netdev_reset_tc(dev);
> +	return ret;
>  }

[Severity: Medium]
Can this unwind also remove the TX rate limits of an mqprio qdisc that is
already attached, when replacing it fails?

For a failed fresh attach, going back to "no offload" is right. Now take
a shaped, offloaded mqprio that is root as 1:. It gets replaced under a
new handle with a bad parameter, for example:

  tc qdisc replace dev eth0 root handle 2: mqprio ... hw 1 mode channel \
     shaper bw_rate max_rate 10001kbit ...

The new qdisc is initialised while 1: is still grafted:

tc_modify_qdisc()
  create_n_graft:
  qdisc_create()
    mqprio_init()
      mqprio_enable_offload()
        mvneta_setup_mqprio()
          mvneta_setup_queue_rates() fails
          goto err
            mvneta_disable_per_queue_rate_limit()

qdisc_create() then calls mqprio_destroy() on the new qdisc.
mqprio_enable_offload() sets priv->hw_offload only after ndo_setup_tc
succeeds, so the driver is not called again and 1: stays root.

Before this patch, these failures returned before any of 1:'s per-queue
TX rates were overwritten:

  - the RX queue range check
  - num_tc > txq_number
  - mvneta_enable_per_queue_rate_limit()
  - the first TX queue

Now every one of those paths goes through err: and refills all TX buckets
at full rate. Meanwhile tc qdisc show still lists 1: with its max_rate
values.

The replace case was already partly inconsistent before this patch, since
the RX prio map is cleared before validation. Losing 1:'s TX rate limits
is new, though.

"net: mvneta: lift the per-queue TX rate limits", earlier in the series,
made mvneta_disable_per_queue_rate_limit() also clear
pp->txqs[].bucket_refill:

	for (queue = 0; queue < txq_number; queue++) {
		pp->txqs[queue].bucket_refill = 0;
		mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);
	}

Because of that, mvneta_restore_per_queue_rate_limit() will not bring 1:'s
limits back on the next open either.

The earlier series commit "net: mvneta: fix the removal of the mqprio
offload" says that "A replacement qdisc is set up before the old one is
torn down". This commit message only covers the fresh attach case.

Would it work to validate the whole configuration before touching the
hardware? That would cover the RX/TX queue ranges, num_tc against
txq_number, min_rate, and the resolution and range of each max_rate. It
would also need to happen before the mvneta_clear_rx_prio_map() and
netdev_set_num_tc() calls at the top of mvneta_setup_mqprio(). A rejected
configuration would then leave the previous offload in place.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104224518.66487-1-pepe.schlehofer%40gmail.com
