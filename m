Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268637;
	b=chf4lfUGrRPusfVsVfJTiTJq9uvalGtRdz/RgH/LwpxoPcqDWFlAMbCV8+qG8iF41ECQ
	 teGO5PSpmzBRN+l1Kupym8x+NfQkS1vKd+73vz2T4CxpY3tSGIGGblXBkkipmNl/PnOij
	 2LurqUaBLfK5v2yfHnB0/4PYoFTdAbiymVdOU6Gb5KOKZ1uneq4CUoruSKJL849yfg3C5
	 bRmO8HBaizTsScA3zkbxJrIkIyWvH3wNFh4IKnti8B1nihAvZ8eiVKYdTT9kKnub6N58f
	 gTxWxiwMQ4FF1K4xl6wDe+b0rxb9jKqohA0G43nFV1RB8YbQK3GLmOh+zN+gDMugTDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BReoVkiECa7pO46jz+laYP3UmgjC0qBIUABqQxeEPFs=;
	b=exPQgbRqhSoHhqaM01lRpKUcZ+2PF7r7l/Ou9GG3W6JzrzEMbVWXgILV7GO7+w2tQJ8v
	 0e7ziggySV0DwU6cG1oo9dWfQoNHAqyMI0VGpTbB2VOgQYmLlIQdg1FPSB1fFm27FcIuv
	 ZTUSHMAyIPQPYEU3Klv3v/S971SFaT+sAng3KqnlJIBpsehhqmWWHst/z9RVMh7Hs/vLb
	 NjGRN4q336W5tQ13xV2mi00ypMD2HkLsRIIT/u5mYKlPggH9VlqzWNuEpZN8q2Q+pMKPT
	 NY4IZhq+DEKpZ5z49FH0ntrRlUYWT+78wqlrPBSoCc7ZVVEfBxV4VMpZ/uK9T6eOoZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b28RH7Jm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69060A5BFD;
	Mon,  9 Nov 2026 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b28RH7Jm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E01F0089F;
	Mon,  9 Nov 2026 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268637;
	bh=BReoVkiECa7pO46jz+laYP3UmgjC0qBIUABqQxeEPFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b28RH7JmMbOeYuZA2Lmk2iAe4+j43zXqpOOcVyyGq+CESAKk83OqxAzwOsWTBOeZP
	 bxOufFF9C9K0dCJD5qzEgw5kSfC5dKm+k2tQ7GLZQlvJPe1XGgZ+JijqRpm7RUPQ1F
	 57v9gp0P4F9KiZPfsFyisZ+RPvOkJBJvDx+i01aVmd5hDvaj91AHTPflBnUXCWm+ym
	 notBDiBMZLn9tqKqmRLTNVCL6ZC0Q6S4TrKq6MNTFZ8S0Ra1SFhKNxtWUyJRX6r0xc
	 AcnFB13GT+r9wRpb/zks/mot/o8+k/6tbCL82EviaN+lWBDuoioz1XFRXjwhDByN8j
	 IePOVXshYakPA==
From: Jakub Kicinski <kuba@kernel.org>
To: james.hilliard1@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: acx00: report receive statistics
Date: Mon,  9 Nov 2026 15:57:15 -0800
Message-ID: <20261109235715.1618218-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102-submit-acx00-phy-stats-v1-v2-1-3c8a664407c1@gmail.com>
References: <20261102-submit-acx00-phy-stats-v1-v2-1-3c8a664407c1@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: acx00: report receive statistics

This patch exposes the ACx00 EPHY receive frame, byte and CRC error
counters through the generic PHY statistics interface. The page 9
hardware counters are sampled from the update_stats callback, and the
deltas are accumulated into 64-bit software totals. Snapshots are taken
before reset and suspend, and a new baseline is set after config_init.

> diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
> index d19ba6d8069a4..1375784d28373 100644
> --- a/drivers/net/phy/xpowers/acx00.c
> +++ b/drivers/net/phy/xpowers/acx00.c

[ ... ]

> @@ -110,6 +139,105 @@ static int acx00_ephy_write_page(struct phy_device *phydev, int page)
>  			   FIELD_PREP(ACX00_PAGE_SELECT_MASK, page));
>  }
>  
> +static int acx00_ephy_read_counter(struct phy_device *phydev, u8 reg, u32 *count)
> +{
> +	int high, low, check;
> +
> +	/* The free-running counter can carry while its two halves are read. */
> +	do {
> +		high = __phy_read(phydev, reg);
> +		if (high < 0)
> +			return high;
> +		low = __phy_read(phydev, reg + 1);
> +		if (low < 0)
> +			return low;
> +		check = __phy_read(phydev, reg);
> +		if (check < 0)
> +			return check;
> +	} while (high != check);

[Severity: Medium]
Is there anything that bounds this loop? It only exits on an MDIO error
or when high == check. There is no limit on the number of passes.

When this runs, __acx00_ephy_update_stats() has already taken the bus
mdio_lock through phy_select_page(), and priv->state_lock is held. On the
periodic path phydev->lock is held as well:

_phy_state_machine()
  phy_update_stats()
    acx00_ephy_update_stats()
      __acx00_ephy_update_stats()
        phy_select_page()        /* takes mdio_lock */
        acx00_ephy_read_counter()

Suppose the high half reads differently on every pass. That could come
from noisy or faulty register reads. It could also come from a pass
delayed by about 5 ms while the RX byte high half is advancing at line
rate.

Would the state machine worker and every other MDIO user on the bus then
block, including the AC300 control path? Would suspend, resume,
soft_reset, config_init and get_phy_stats block too, since they need
state_lock or phydev->lock?

Would a small retry limit that returns -EIO or -EAGAIN be preferable?

> +
> +	*count = (u32)high << 16 | low;
> +	return 0;
> +}
> +
> +static int __acx00_ephy_update_stats(struct phy_device *phydev)
> +{

[ ... ]

> +	for (i = 0; i < ACX00_NUM_STATS; i++) {
> +		u64 count = counts[i];
> +
> +		if (priv->stats_valid) {
> +			if (count < priv->stats_last[i])
> +				count += i == ACX00_STAT_RX_BYTES ?
> +					ACX00_RX_BYTES_WRAP : BIT_ULL(32);
> +			priv->stats[i] += count - priv->stats_last[i];

[Severity: Medium]
Can this subtraction underflow for the RX byte counter?

ACX00_RX_BYTES_WRAP is 4,000,000,000, but acx00_ephy_read_counter() can
return any value up to 0xFFFFFFFF. Nothing checks that a sample is below
the wrap value before it is stored in stats_last[].

If stats_last[] is at least 4e9 and a later sample satisfies
count + 4e9 < stats_last[], the u64 subtraction wraps. For example, with
stats_last = 0xFFFFFFFF and count = 1000:

  4,000,001,000 - 4,294,967,295  ->  about 1.8e19

That result is then added to priv->stats[ACX00_STAT_RX_BYTES].

One way to get such a sample is a PHY that stops driving MDIO while
stats_active is true. Consistent 0xFFFF reads pass the high == check
test and produce 0xFFFFFFFF. Another is a variant whose byte counter
does not wrap at exactly 4e9, since that value comes from testing on
one setup.

priv->stats[] is deliberately kept across reset, power-off and suspend.
Would one bad sample leave rx_bytes wrong for the life of the device?

Would a modular delta such as (count + WRAP - last) % WRAP, or a range
check on the sample, avoid this?

> +		}
> +		priv->stats_last[i] = counts[i];
> +	}
> +	priv->stats_valid = true;
> +
> +	return 0;
> +}

[ ... ]

> +static void acx00_ephy_get_phy_stats(struct phy_device *phydev,
> +				     struct ethtool_eth_phy_stats *eth_stats,
> +				     struct ethtool_phy_stats *stats)
> +{
> +	struct acx00_ephy_priv *priv = phydev->priv;
> +
> +	mutex_lock(&priv->state_lock);
> +	stats->rx_packets = priv->stats[ACX00_STAT_RX_PACKETS];
> +	stats->rx_bytes = priv->stats[ACX00_STAT_RX_BYTES];
> +	stats->rx_errors = priv->stats[ACX00_STAT_RX_CRC_ERRORS];

[Severity: Medium]
Do these values match the documented meaning of the fields? The kernel-doc
for struct ethtool_phy_stats in include/linux/ethtool.h says:

 * @rx_packets: Total successfully received frames
 * @rx_bytes: Total successfully received bytes
 * @rx_errors: Total received frames with errors (e.g., CRC errors)

The commit message says "the packet and byte counters include errored
frames as well as successfully received traffic", and
__acx00_ephy_update_stats() accumulates them unchanged. That means a CRC
errored frame is counted in both rx_errors and rx_packets, and its octets
are counted in rx_bytes.

stats_put_phydev_stats() in net/ethtool/stats.c exports these values as
ETHTOOL_A_STATS_PHY_RX_PKTS and ETHTOOL_A_STATS_PHY_RX_BYTES. For this PHY
those attributes would therefore mean something different from the
documented contract.

rx_packets could be corrected by subtracting the CRC error count.
rx_bytes cannot be corrected without a per-frame byte count. Should
rx_bytes be left unreported, or should the shared documentation be
changed instead?

> +	mutex_unlock(&priv->state_lock);
> +}

[ ... ]
-- 
pw-bot: cr
