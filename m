Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFD42CAE0;
	Tue,  6 Oct 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290948; cv=none; b=MsfC31GX2nDSlcoztUGR+yJ4mXbSv1DQwzMD+gjSHlUM3vB4F4G5+pCkPemjQa6xGgz9e6prtwTIr4tRkh27DCBS7Eax/VWlPNtMflnH4zTm9WEo5WUJ55ET34FrLA2raZL35weCbMEk1XGWOGJ9MqkZMHo9PCCVDJ4UbT0nZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290948; c=relaxed/simple;
	bh=bt2Kyyd45F3UQpAxqVewFKugC8GodJpfuF+rBuT+ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRAScBen7QYTHZAk+8zU2coOx/mzoi8S1GI07lLVvyr6jI53i07j7SlxNaBGGel4InBSs4Hfs74PU3nrCscHx+pU0L2oV63MGVFQuzPn7ySiIOBfUqH/ymX6ytyzuwbZNjX1Q0SBZMX9CBkZzg0Ila6PtJo41poNUXbf6FJn2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o2urgcrk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o2urgcrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5YiNPITWqK30Kiy9ZsIp5HIBNcsrtx+hz6EOp6QsdvI=; b=o2
	urgcrkxx98UQ4nvGw1KmJDCALdhVySQncwHuegOxmEvSHVZp2JbT70ymGZ3iSA72fMPmYyQczCI8m
	W/KzUS8RSVrcDIMaWmEcWIou6zBjVS973Tnk2no4U3NT+jk/XYNAt+e6LULlUVTycf8zF7Jyax9WV
	Ow+saoE4kPd4Mm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE4ax-009GK2-Gj; Tue, 06 Oct 2026 14:48:35 +0200
Date: Tue, 6 Oct 2026 14:48:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Message-ID: <89dadff0-d78a-4d4d-8ac2-be299e00ae9b@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>

> +static bool oa_tc6_req_tx_hwtstamp(struct oa_tc6 *tc6, struct sk_buff *skb)
> +{
> +	bool drop = false;
> +	u8 tsc;
> +	u8 i;
> +
> +	lockdep_assert_held(&tc6->tx_skb_lock);
> +
> +	if (!skb || !(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +		return drop;
> +
> +	if (!tc6->hw_tstamp_enabled)
> +		goto out;
> +	if (tc6->ts_config.tx_type != HWTSTAMP_TX_ON) {
> +		tc6->tx_hwtstamp_lost++;
> +		goto out;
> +	}
> +
> +	tsc = tc6->ttsc_current_id;
> +	for (i = 0; i < OA_TC6_TTSCC_REG_ID; i++) {
> +		if (!(tc6->ts_ttsc_pending & BIT(tsc -
> +		    OA_TC6_TTSCA_REG_ID)))
> +			goto slot_found;

The indentation is a bit off. Generally the whole of BIT(...) would be
on the next line.

> +		tsc = oa_tc6_next_tsc(tsc);
> +	}
> +
> +	/* All the three slots are waiting for its event. This skb
> +	 * can't request timestamp. Marking it to be dropped.
> +	 */
> +	tc6->tx_hwtstamp_lost++;
> +	drop = true;
> +	goto out;
> +
> +slot_found:
> +	tc6->ts_ttsc_pending |= BIT(tsc - OA_TC6_TTSCA_REG_ID);
> +	tc6->ttsc_current_id = oa_tc6_next_tsc(tsc);
> +	oa_tc6_tsinfo_tx(skb)->tsc = tsc;
> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +out:
> +	return drop;

The goto's here are a bit spaghetti code like. Since all out: does is
return, maybe just use "return true" above.

>  static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  {
> +	u32 regs[OA_TC6_STATUS0_TTSC_REG_COUNT];
> +	bool ts_valid = !!tc6->ptp_clock;
>  	u32 value;
>  	int ret;
>  
> -	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &value);
> +	/* When timestamp is disabled, there is no behavior change
> +	 * as it reads only STATUS0 register. When enabled,
> +	 * TTSCA_HIGH..TTSCC_LOW are fetched together with STATUS0
> +	 * to avoid having to make second SPI transaction. Reading few
> +	 * extra registers, even it may not be needed every time this
> +	 * function is called, it is more efficient than making second
> +	 * SPI transaction, when needed.
> +	 */
> +	ret = oa_tc6_read_registers(tc6, OA_TC6_REG_STATUS0, regs,
> +				    ts_valid ?
> +				    OA_TC6_STATUS0_TTSC_REG_COUNT : 1);
>  	if (ret) {
>  		netdev_err(tc6->netdev, "STATUS0 register read failed: %d\n",
>  			   ret);
>  		return ret;
>  	}
> +	value = regs[0];

I assume there is a #define for register 0? It would be more readable
to use the name.

> +int oa_tc6_ptp_register(struct oa_tc6 *tc6, struct ptp_clock_info *info)
> +{
> +	int ret = 0;
> +
> +	/* Not supporting hardware timestamp isn't an error */
> +	if (!tc6->hw_tstamp_supported)
> +		return ret;
> +
> +	snprintf(info->name, sizeof(info->name), "%s",
> +		 "OA TC6 PTP clock");

Are names meant to be unique? Have you tested this on a board with
multiple devices?


> +	tc6->ptp_clock = ptp_clock_register(info, &tc6->spi->dev);
> +	if (IS_ERR(tc6->ptp_clock)) {
> +		ret = PTR_ERR(tc6->ptp_clock);
> +		tc6->ptp_clock = NULL;
> +		dev_err(&tc6->spi->dev, "Registration of %s failed\n",
> +			info->name);
> +	}
> +
> +	if (tc6->ptp_clock)
> +		dev_info(&tc6->spi->dev, "%s registered. index %d\n",
> +			 info->name, ptp_clock_index(tc6->ptp_clock));
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_ptp_register);
> +
> +/**
> + * oa_tc6_ptp_unregister - Unregisters clock related callbacks
> + * @tc6: oa_tc6 struct.
> + */
> +void oa_tc6_ptp_unregister(struct oa_tc6 *tc6)
> +{
> +	if (tc6->ptp_clock) {
> +		ptp_clock_unregister(tc6->ptp_clock);
> +		tc6->ptp_clock = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_ptp_unregister);
> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> index 403a9c22b5f1..06fe88f1ed7c 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> @@ -18,6 +18,9 @@
>  #include <linux/wait.h>
>  #include <linux/phy.h>
>  
> +/* Tx timestamp capture register A (high) */
> +#define OA_TC6_REG_TTSCA_HIGH			(0x10)
> +
>  /* Control command header */
>  #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
>  #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
> @@ -33,6 +36,7 @@
>  #define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
>  #define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
>  #define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
> +#define OA_TC6_DATA_HEADER_TSC_OFFSET		GENMASK(7, 6)
>  #define OA_TC6_DATA_HEADER_PARITY		BIT(0)
>  
>  /* Data footer */
> @@ -44,6 +48,8 @@
>  #define OA_TC6_DATA_FOOTER_START_VALID		BIT(20)
>  #define OA_TC6_DATA_FOOTER_START_WORD_OFFSET	GENMASK(19, 16)
>  #define OA_TC6_DATA_FOOTER_END_VALID		BIT(14)
> +#define OA_TC6_DATA_FOOTER_RTSA_VALID		BIT(7)
> +#define OA_TC6_DATA_FOOTER_RTSP_VALID		BIT(6)
>  #define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
>  #define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
>  
> @@ -70,6 +76,22 @@
>  
>  #define OA_TC6_REG_MMS_MASK		GENMASK(19, 16)
>  
> +#define OA_TC6_TSTAMP_SZ			8
> +
> +#define OA_TC6_TTSCA_REG_ID			1
> +#define OA_TC6_TTSCB_REG_ID			2
> +#define OA_TC6_TTSCC_REG_ID			3
> +
> +/* STATUS0 and the TTSCA/B/C capture registers are contiguous in MMS 0, so
> + * they are fetched with a single control transaction while timestamping is
> + * available.
> + */
> +#define OA_TC6_TTSC_REG_OFFSET		(OA_TC6_REG_TTSCA_HIGH - \
> +					 OA_TC6_REG_STATUS0)
> +#define OA_TC6_TTSC_REG_COUNT		(2 * OA_TC6_TTSCC_REG_ID)
> +#define OA_TC6_STATUS0_TTSC_REG_COUNT	(OA_TC6_TTSC_REG_OFFSET + \
> +					 OA_TC6_TTSC_REG_COUNT)
> +
>  /* Internal structure for MAC-PHY drivers */
>  struct oa_tc6 {
>  	struct net_device *netdev;
> @@ -95,6 +117,16 @@ struct oa_tc6 {
>  	bool prot_ctrl;
>  	enum oa_tc6_quirk_flag quirk_flags;
>  	struct gpio_desc *reset_gpio;
> +	struct hwtstamp_config ts_config;
> +	struct list_head tx_ts_skb_q;
> +	struct ptp_clock *ptp_clock;
> +	bool hw_tstamp_supported;
> +	bool hw_tstamp_enabled;
> +	u64 tx_hwtstamp_pkts;
> +	u64 tx_hwtstamp_lost;
> +	u64 tx_hwtstamp_err;
> +	u8 ts_ttsc_pending;
> +	u8 ttsc_current_id;
>  };
>  
>  enum oa_tc6_header_type {
> @@ -121,5 +153,8 @@ enum oa_tc6_data_end_valid_info {
>  	OA_TC6_DATA_END_INVALID,
>  	OA_TC6_DATA_END_VALID,
>  };
> +
> +void oa_tc6_cleanup_tx_tstamp_skbs(struct oa_tc6 *tc6);
> +
>  #endif /* OA_TC6_STD_DEF_H */
>  
> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> new file mode 100644
> index 000000000000..d83f6ad9373a
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface framework
> + *
> + * Author: Selva Rajagopal <selvamani.rajagopal@onsemi.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <linux/mdio.h>
> +#include <linux/phy.h>
> +#include <linux/oa_tc6.h>
> +
> +#include "oa_tc6_std_def.h"
> +
> +static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6,
> +					const struct hwtstamp_config *ts_cfg)
> +{
> +	u32 regs[OA_TC6_REG_INT_MASK0 - OA_TC6_REG_CONFIG0 + 1];
> +	u32 cfg0, irqm, status0;
> +	bool disabled;
> +	int ret;
> +
> +	if (tc6->ts_config.flags == ts_cfg->flags &&
> +	    tc6->ts_config.tx_type == ts_cfg->tx_type &&
> +	    tc6->ts_config.rx_filter == ts_cfg->rx_filter)
> +		return 0;
> +
> +	spin_lock_bh(&tc6->tx_skb_lock);
> +	disabled = tc6->disable_traffic;
> +	spin_unlock_bh(&tc6->tx_skb_lock);
> +	if (disabled)
> +		return -EIO;
> +
> +	/* CONFIG0, STATUS0 and INT_MASK0 span one register block, so a
> +	 * single control transaction covers all three.
> +	 */
> +	ret = oa_tc6_read_registers(tc6, OA_TC6_REG_CONFIG0, regs,
> +				    ARRAY_SIZE(regs));
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "Failed to read CFG0 block\n");
> +		goto out;
> +	}
> +
> +	cfg0 = regs[0];

OA_TC6_REG_CONFIG0 - OA_TC6_REG_CONFIG0?

> +	status0 = regs[OA_TC6_REG_STATUS0 - OA_TC6_REG_CONFIG0];
> +	irqm = regs[OA_TC6_REG_INT_MASK0 - OA_TC6_REG_CONFIG0];

It then follow the pattern?

   Andrew
