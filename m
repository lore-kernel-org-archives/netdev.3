Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C92628D;
	Sun, 19 Jul 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466962; cv=none; b=YzJX8gA7CznARTh+9n4p7/g18lpcoDdlXwk5UyTI3qcAJ0RFaiaIQW9aeVwkbY0XAADqZGuFUAh2fIm+GuEd/rmoLdJbdy9MdkyZ/L2CBJZkQy7oPzQeVbf0+uaw5DFkyE0aO4opUvCXD4Aq52c/JWpFnTlv/2Mot/Hj7hVTzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466962; c=relaxed/simple;
	bh=djK9PBw+YMCd7xpduYKYFtUhP1OVO+gXtrwt7xkezmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTOj1XB7wLq2BFi6P0BQ0MsMciQ8Wx54foXNNiV+EiJ3xlPXMLVpqEuVEWL55IHCES/Xm1i8W62E5qmSINe5Un8CF1t1ArsNfww660jPZvDBJARXpTwqk8C2eT8uBIX2v2pUAcxlHBMXOtq7NVQ4hHv/wqdieMK1YTVF2GwqH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=Xi23eaET; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="Xi23eaET"
Received: from [192.168.1.182] (ip-62-24-73-79.bb.vodafone.cz [62.24.73.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id AA3155340216;
	Sun, 19 Jul 2026 15:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1784466952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T/65GqDGW+jYgBWQOl9lJd2Sg4bnFS7MM/Ya0eKAQrg=;
	b=Xi23eaETBB5sKNsi2hhpFOFk9HjdunNdX3FAIYhD5lRSKa8zT6PdA0DGu5Z2WjcFcZNAPl
	6nNNyiaFJRkG1QSUa3VIRsYRFnLDJEDr252Nm7fU8GHzkNyJbcbZR+NXwg4OiYY05FaJV6
	pX79FmHD67bzrZq6RCfS/xOiISfORzE=
Message-ID: <18c3e13f-88e4-458e-9f57-7aceeb1ce1d1@ixit.cz>
Date: Sun, 19 Jul 2026 15:15:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] nfc: s3fwrn5: support the S3NRN4V variant
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
 <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2026 21:06, Jorijn van der Graaf wrote:
> The S3NRN4V (e.g. on the Fairphone 6, SM7635) is an S3FWRN5-family NFC
> controller that needs different bring-up, selected with a new
> samsung,s3nrn4v compatible:
> 
>   - It ships with working firmware behind a bootloader protocol this
>     driver does not implement (GET_BOOTINFO times out), so the firmware
>     download step is skipped. Its RF registers are (re)loaded with the
>     proprietary DUAL_OPTION command (the HW and SW register blobs merged
>     into a single stream) instead of the START/SET/STOP_RFREG sequence.
> 
>   - Its reference clock speed is configured with the single-byte FW_CFG
>     form, sent from the ->setup hook (after CORE_RESET, before CORE_INIT).
>     The selector value (0x11) is taken from the vendor configuration for
>     this part; its encoding is not documented.
> 
>   - It gates its XI clock through a CLK_REQ line: the chip drives it high
>     when it needs the clock, notably to synthesise the 13.56 MHz poll
>     carrier. Left always-on, the free-running clock never lets the chip's
>     TX PLL lock on a fresh start and it cannot poll (it falls back to
>     listen only). Service the handshake when a clk-req GPIO is described,
>     gating the clock on it; without one the clock stays always-on.
> 
> The variant is carried as match data by both the OF and the I2C device
> id tables so the two match paths agree, and the OF table is now
> referenced unconditionally for its match data, so drop the
> of_match_ptr()/__maybe_unused annotations from it.

Hello Jorijn,

thank you for the work on the driver!

Please, send the "drop the of_match_ptr()/__maybe_unused annotations from it." 
type of change as part of the series, but as a separate commit before the new HW 
support introduction.

Since you touch S3FWRN5_I2C_DRIVER_NAME, replace define S3FWRN5_I2C_DRIVER_NAME 
occurenced with the "s3fwrn5_i2c" directly before introducing the support (also 
separate commit)


> 
> The error policy differs between the two configuration steps on purpose:
> a clock misconfiguration is fatal (a ->setup failure aborts CORE_INIT),
> whereas an RF-register update failure is only warned about and bring-up
> continues, since the chip falls back to the RF registers programmed in
> its flash and NFC may still work.
> 
> Unlike the host-endian word read in the legacy rfreg path, the
> DUAL_OPTION checksum is accumulated with get_unaligned_le32() and emitted
> little-endian explicitly, so it is correct regardless of CPU endianness.
> 
> Existing S3FWRN5 / S3FWRN82 setups keep the firmware-download path and
> the always-on clock, unchanged.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
> Changes in v2:
>   - Rename the new compatible to samsung,s3nrn4v, matching the binding
>     change (Requested by: Conor Dooley).
>   - Close a race in the probe-time CLK_REQ seeding: the GPIO level is
>     now read under clk_lock (new s3fwrn5_i2c_clk_sync(), used by both
>     the irq thread and probe), so a level read before the irq fired can
>     never overwrite the fresher state the irq thread applied (found by
>     the Sashiko AI review of v1).
>   - Reject malformed rfreg blobs (word alignment, single-byte section
>     index bound) up front instead of failing at STOP_UPDATE.
>   - Handle gpiod_get_value_cansleep() failure instead of gating the
>     clock off on error.
>   - Add an s3nrn4v i2c_device_id entry carrying the variant so both
>     match paths agree.
>   - Describe the of_match_ptr()/__maybe_unused removal in the commit
>     message.
> v1: https://lore.kernel.org/20260703202601.78563-3-jorijnvdgraaf@catcrafts.net
> 
>   drivers/nfc/s3fwrn5/core.c    |  40 +++++++++-
>   drivers/nfc/s3fwrn5/i2c.c     | 138 +++++++++++++++++++++++++++++++---
>   drivers/nfc/s3fwrn5/nci.c     | 119 ++++++++++++++++++++++++++++-
>   drivers/nfc/s3fwrn5/nci.h     |  32 +++++++-
>   drivers/nfc/s3fwrn5/s3fwrn5.h |  14 +++-
>   drivers/nfc/s3fwrn5/uart.c    |   2 +-
>   6 files changed, 330 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
> index af0fa8bd970b..59317eaad7ac 100644
> --- a/drivers/nfc/s3fwrn5/core.c
> +++ b/drivers/nfc/s3fwrn5/core.c
> @@ -122,11 +122,47 @@ static int s3fwrn5_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>   	return 0;
>   }
>   
> +static int s3fwrn5_nci_setup(struct nci_dev *ndev)
> +{
> +	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
> +
> +	/*
> +	 * Runs after CORE_RESET, before CORE_INIT. The S3NRN4V needs its
> +	 * reference clock configured here (the downstream stack does it in the
> +	 * bootloader, before CORE_RESET, but this is the earliest hook the NCI
> +	 * core offers and the chip accepts it).
> +	 */
> +	if (info->variant == S3FWRN5_VARIANT_S3NRN4V)
> +		return s3fwrn5_nci_clk_cfg(info);
> +
> +	return 0;
> +}
> +
>   static int s3fwrn5_nci_post_setup(struct nci_dev *ndev)
>   {
>   	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
>   	int ret;
>   
> +	if (info->variant == S3FWRN5_VARIANT_S3NRN4V) {
> +		/*
> +		 * The S3NRN4V ships with working firmware behind a bootloader
> +		 * protocol this driver does not implement, so there is no
> +		 * download step; the NCI core has already done CORE_RESET +
> +		 * CORE_INIT. Just (re)load the RF registers via DUAL_OPTION.
> +		 */
> +		ret = s3fwrn5_nci_rf_configure_dual(info, "sec_s3nrn4v_hwreg.bin",
> +						    "sec_s3nrn4v_swreg.bin");
> +		/*
> +		 * Keep going even if the blobs could not be loaded: the chip
> +		 * still enumerates and falls back to the RF registers programmed
> +		 * in its flash, so NFC may work anyway.
> +		 */
> +		if (ret < 0)
> +			dev_warn(&ndev->nfc_dev->dev,
> +				 "rfreg configure failed (%d)\n", ret);
> +		return 0;
> +	}
> +
>   	if (s3fwrn5_firmware_init(info)) {
>   		//skip bootloader mode
>   		return 0;
> @@ -152,13 +188,14 @@ static const struct nci_ops s3fwrn5_nci_ops = {
>   	.open = s3fwrn5_nci_open,
>   	.close = s3fwrn5_nci_close,
>   	.send = s3fwrn5_nci_send,
> +	.setup = s3fwrn5_nci_setup,
>   	.post_setup = s3fwrn5_nci_post_setup,
>   	.prop_ops = s3fwrn5_nci_prop_ops,
>   	.n_prop_ops = ARRAY_SIZE(s3fwrn5_nci_prop_ops),
>   };
>   
>   int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
> -	const struct s3fwrn5_phy_ops *phy_ops)
> +	const struct s3fwrn5_phy_ops *phy_ops, enum s3fwrn5_variant variant)
>   {
>   	struct s3fwrn5_info *info;
>   	int ret;
> @@ -170,6 +207,7 @@ int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
>   	info->phy_id = phy_id;
>   	info->pdev = pdev;
>   	info->phy_ops = phy_ops;
> +	info->variant = variant;
>   	mutex_init(&info->mutex);
>   
>   	s3fwrn5_set_mode(info, S3FWRN5_MODE_COLD);
> diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
> index e9a34d27a369..7d20e737e402 100644
> --- a/drivers/nfc/s3fwrn5/i2c.c
> +++ b/drivers/nfc/s3fwrn5/i2c.c
> @@ -23,9 +23,76 @@ struct s3fwrn5_i2c_phy {
>   	struct i2c_client *i2c_dev;
>   	struct clk *clk;
>   
> +	/*
> +	 * Optional hardware clock-request handshake. When a CLK_REQ GPIO is
> +	 * wired, the chip drives it high while it needs its XI clock -- notably
> +	 * to generate the poll/reader carrier -- and the clock is gated on it
> +	 * instead of being left always-on (which never lets the chip's TX PLL
> +	 * lock on a fresh clock start, leaving it unable to poll).
> +	 */
> +	struct gpio_desc *gpio_clk_req;
> +	bool clk_on;
> +	struct mutex clk_lock;	/* serialises clk_on against the CLK_REQ irq */
> +
>   	unsigned int irq_skip:1;
>   };
>   
> +static void s3fwrn5_i2c_clk_set_locked(struct s3fwrn5_i2c_phy *phy, bool on)
> +{
> +	lockdep_assert_held(&phy->clk_lock);
> +
> +	if (on && !phy->clk_on) {
> +		int ret = clk_prepare_enable(phy->clk);
> +
> +		if (ret == 0)
> +			phy->clk_on = true;
> +		else
> +			dev_warn_once(&phy->i2c_dev->dev,
> +				      "failed to enable clock (%d); NFC may not poll\n",
> +				      ret);
> +	} else if (!on && phy->clk_on) {
> +		clk_disable_unprepare(phy->clk);
> +		phy->clk_on = false;
> +	}
> +}
> +
> +/*
> + * Apply the current CLK_REQ level. Reading the GPIO under clk_lock makes
> + * concurrent callers (the CLK_REQ irq thread and the probe-time seeding)
> + * safe: whoever runs last applies a level read after the earlier update,
> + * never a stale one.
> + */
> +static void s3fwrn5_i2c_clk_sync(struct s3fwrn5_i2c_phy *phy)
> +{
> +	int level;
> +
> +	mutex_lock(&phy->clk_lock);
> +	level = gpiod_get_value_cansleep(phy->gpio_clk_req);
> +	if (level >= 0)
> +		s3fwrn5_i2c_clk_set_locked(phy, level > 0);
> +	else
> +		dev_warn_once(&phy->i2c_dev->dev,
> +			      "failed to read CLK_REQ (%d); keeping clock state\n",
> +			      level);
> +	mutex_unlock(&phy->clk_lock);
> +}
> +
> +static void s3fwrn5_i2c_clk_disable_action(void *data)
> +{
> +	struct s3fwrn5_i2c_phy *phy = data;
> +
> +	mutex_lock(&phy->clk_lock);
> +	s3fwrn5_i2c_clk_set_locked(phy, false);
> +	mutex_unlock(&phy->clk_lock);
> +}
> +
> +static irqreturn_t s3fwrn5_i2c_clk_req_thread(int irq, void *phy_id)
> +{
> +	s3fwrn5_i2c_clk_sync(phy_id);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static void s3fwrn5_i2c_set_mode(void *phy_id, enum s3fwrn5_mode mode)
>   {
>   	struct s3fwrn5_i2c_phy *phy = phy_id;
> @@ -146,6 +213,7 @@ static irqreturn_t s3fwrn5_i2c_irq_thread_fn(int irq, void *phy_id)
>   
>   static int s3fwrn5_i2c_probe(struct i2c_client *client)
>   {
> +	enum s3fwrn5_variant variant;
>   	struct s3fwrn5_i2c_phy *phy;
>   	int ret;
>   
> @@ -172,15 +240,61 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
>   	 * S3FWRN5 depends on a clock input ("XI" pin) to function properly.
>   	 * Depending on the hardware configuration this could be an always-on
>   	 * oscillator or some external clock that must be explicitly enabled.
> -	 * Make sure the clock is running before starting S3FWRN5.
> +	 *
> +	 * If a CLK_REQ GPIO is wired, the chip gates the clock itself (driving
> +	 * CLK_REQ high when it needs XI); service that handshake. Otherwise just
> +	 * make sure the clock is running before starting S3FWRN5.
>   	 */
> -	phy->clk = devm_clk_get_optional_enabled(&client->dev, NULL);
> -	if (IS_ERR(phy->clk))
> -		return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
> -				     "failed to get clock\n");
> +	mutex_init(&phy->clk_lock);
> +	phy->gpio_clk_req = devm_gpiod_get_optional(&client->dev, "clk-req",
> +						    GPIOD_IN);
> +	if (IS_ERR(phy->gpio_clk_req))
> +		return PTR_ERR(phy->gpio_clk_req);
> +
> +	if (phy->gpio_clk_req) {
> +		int clk_req_irq;
> +
> +		phy->clk = devm_clk_get_optional(&client->dev, NULL);
> +		if (IS_ERR(phy->clk))
> +			return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
> +					     "failed to get clock\n");
> +
> +		/*
> +		 * Unlike the always-on branch below, this clock is enabled by
> +		 * hand from the CLK_REQ handler, so devm will not disable it on
> +		 * unbind. Gate it off explicitly if it is still on at teardown.
> +		 */
> +		ret = devm_add_action_or_reset(&client->dev,
> +					       s3fwrn5_i2c_clk_disable_action,
> +					       phy);
> +		if (ret)
> +			return ret;
> +
> +		clk_req_irq = gpiod_to_irq(phy->gpio_clk_req);
> +		if (clk_req_irq < 0)
> +			return clk_req_irq;
> +
> +		ret = devm_request_threaded_irq(&client->dev, clk_req_irq, NULL,
> +						s3fwrn5_i2c_clk_req_thread,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"s3fwrn5_clk_req", phy);
> +		if (ret)
> +			return ret;
> +
> +		/* Seed the clock state from the current CLK_REQ level. */
> +		s3fwrn5_i2c_clk_sync(phy);
> +	} else {
> +		phy->clk = devm_clk_get_optional_enabled(&client->dev, NULL);
> +		if (IS_ERR(phy->clk))
> +			return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
> +					     "failed to get clock\n");
> +	}
>   
> +	variant = (uintptr_t)i2c_get_match_data(client);
>   	ret = s3fwrn5_probe(&phy->common.ndev, phy, &phy->i2c_dev->dev,
> -			    &i2c_phy_ops);
> +			    &i2c_phy_ops, variant);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -205,13 +319,17 @@ static void s3fwrn5_i2c_remove(struct i2c_client *client)
>   }
>   
>   static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
> -	{ .name = S3FWRN5_I2C_DRIVER_NAME },
> +	{ .name = S3FWRN5_I2C_DRIVER_NAME, .driver_data = S3FWRN5_VARIANT_FWDL },
> +	{ .name = "s3nrn4v", .driver_data = S3FWRN5_VARIANT_S3NRN4V },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
>   
> -static const struct of_device_id of_s3fwrn5_i2c_match[] __maybe_unused = {
> -	{ .compatible = "samsung,s3fwrn5-i2c", },
> +static const struct of_device_id of_s3fwrn5_i2c_match[] = {
> +	{ .compatible = "samsung,s3fwrn5-i2c",
> +	  .data = (void *)S3FWRN5_VARIANT_FWDL, },
> +	{ .compatible = "samsung,s3nrn4v",
> +	  .data = (void *)S3FWRN5_VARIANT_S3NRN4V, },

is S3NRN4V really a variant of S3FWRN5 or is it just S3NRN4V?

>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
> @@ -219,7 +337,7 @@ MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
>   static struct i2c_driver s3fwrn5_i2c_driver = {
>   	.driver = {
>   		.name = S3FWRN5_I2C_DRIVER_NAME,
> -		.of_match_table = of_match_ptr(of_s3fwrn5_i2c_match),
> +		.of_match_table = of_s3fwrn5_i2c_match,
>   	},
>   	.probe = s3fwrn5_i2c_probe,
>   	.remove = s3fwrn5_i2c_remove,
> diff --git a/drivers/nfc/s3fwrn5/nci.c b/drivers/nfc/s3fwrn5/nci.c
> index 5a9de11bbece..7034fb810e18 100644
> --- a/drivers/nfc/s3fwrn5/nci.c
> +++ b/drivers/nfc/s3fwrn5/nci.c
> @@ -8,6 +8,9 @@
>   
>   #include <linux/completion.h>
>   #include <linux/firmware.h>
> +#include <linux/minmax.h>
> +#include <linux/slab.h>
> +#include <linux/unaligned.h>
>   
>   #include "s3fwrn5.h"
>   #include "nci.h"
> @@ -20,7 +23,7 @@ static int s3fwrn5_nci_prop_rsp(struct nci_dev *ndev, struct sk_buff *skb)
>   	return 0;
>   }
>   
> -const struct nci_driver_ops s3fwrn5_nci_prop_ops[4] = {
> +const struct nci_driver_ops s3fwrn5_nci_prop_ops[5] = {
>   	{
>   		.opcode = nci_opcode_pack(NCI_GID_PROPRIETARY,
>   				NCI_PROP_SET_RFREG),
> @@ -41,6 +44,11 @@ const struct nci_driver_ops s3fwrn5_nci_prop_ops[4] = {
>   				NCI_PROP_FW_CFG),
>   		.rsp = s3fwrn5_nci_prop_rsp,
>   	},
> +	{
> +		.opcode = nci_opcode_pack(NCI_GID_PROPRIETARY,
> +				NCI_PROP_DUAL_OPTION),
> +		.rsp = s3fwrn5_nci_prop_rsp,
> +	},
>   };
>   
>   #define S3FWRN5_RFREG_SECTION_SIZE 252
> @@ -117,3 +125,112 @@ int s3fwrn5_nci_rf_configure(struct s3fwrn5_info *info, const char *fw_name)
>   	release_firmware(fw);
>   	return ret;
>   }
> +
> +/*
> + * Configure the reference clock. The S3NRN4V expects the single-byte FW_CFG
> + * form (just the clock-speed selector). The downstream stack sends this in the
> + * bootloader before CORE_RESET; the earliest the mainline NCI core lets us in
> + * is the ->setup hook (after CORE_RESET, before CORE_INIT), which works.
> + */
> +int s3fwrn5_nci_clk_cfg(struct s3fwrn5_info *info)
> +{
> +	u8 clk_speed = NCI_PROP_FW_CFG_CLK_SPEED;
> +
> +	return nci_prop_cmd(info->ndev, NCI_PROP_FW_CFG, 1, &clk_speed);
> +}
> +
> +/*
> + * S3NRN4V RF register update. The HW and SW register blobs are merged into a
> + * single stream (HW first) and pushed via the DUAL_OPTION command:
> + * START_UPDATE, one SET_OPTION per 252-byte section, then STOP_UPDATE carrying
> + * a 16-bit checksum (running sum of the merged stream as 32-bit words).
> + */

While it's "register update" and function is named "configure_dual", it's 
loading firmware.

If it's not a firmware, but only configuration, it can reside inside the driver, 
maybe LLM even be able to decode to understandable sequence of registers and values.

For next revision of the patch, I'll likely still have some additional feedback.

With next revision send also as last patch the device-tree entry for the 
Fairphone 6, so we can also get additional testing from developers/users.

Thank you again!
David

[...]
