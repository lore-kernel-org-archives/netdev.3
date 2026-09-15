Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646835E1A8;
	Tue, 15 Sep 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503997; cv=none; b=RrWQCm49+mqHkfLuriMIWvsiD1PJlGwEy7ES1VgXkHidhkl833AQcoIHWRhtwnKtE4AEtw/E/9XwBsZBw4Z7BM4rosgkBgMm8b+Ml9p7rIQUORk0z0rHHo1VvTwVqFoVJazo2vwFaMeHqdNv5Nl16U2M7yHFcl8MPAgfN7q3q7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503997; c=relaxed/simple;
	bh=p9FzcHvzEo6//+9LkWPlg4+X47e9L8Vsw++LvvWbZkA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bek/aPazehfy0MbmcEO59mR1VxfzhqAm1REjLDVsu6Dvt1tnsnfAygE73lhKQj0k4ncMk/NLvYYL4c9QRUGhYPS4xNhbSmWsiM/04mQfuLFCLw4t2cXbZhbc44vd87BQKY0SLMpqkPykUL3eNhmEr96OTu+W2bUpklEECQ5kOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpMi0nVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpMi0nVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43B91F000FF;
	Tue, 15 Sep 2026 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503996;
	bh=qC+xnHENasn5vp64ecDoz3DjX2JIj8WYObnXwzazahM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kpMi0nVwTEK7U8lEwyax67+haOFcnLPFPQie/53QLQ4D4aa9OzXjTvBg86b+b2Mmx
	 G/6Oha2BoPhzwKMHO7y933z9U54w9qUdcFmRqiL7pUhezDapl8n5nE9QpctUC6pk2x
	 e73mm95frwdq5eTHrDsnJhgh8azyBB7DQVTk601EQtnzfen8GhODXuPMVj5kzLAG1E
	 obT7v6WrOFtcZa7SONCwQh2HjrA9NBiNzaUDpc2ha0ZV+i/5cyPDPvOPx2jcG/Kbm8
	 +vkNvCfKM/YicxwN3CE1u/JoefruZinRw/0oFCatVDgqtJzZGvfUSjwRoMoP+Rx5aQ
	 pRLREm+LZFcFA==
Subject: Re: [PATCH net-next] net: phy: marvell: add support for active-low
 and active-high LEDs
From: netdev-bot+sashiko@kernel.org
To: olek2@wp.pl
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 20:26:35 +0000
Message-ID: <178950399524.22033.13133348870074259078@kernel.org>
In-Reply-To: <20260914200847.445375-1-olek2@wp.pl>
References: <20260914200847.445375-1-olek2@wp.pl>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete mask for 2-bit LED polarity field in
  phy_modify_paged.

--

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -3585,6 +3589,41 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
>  	return marvell_get_led_rules(index, rules, mode);
>  }
>  
> +static int m88e1318_led_polarity_set(struct phy_device *phydev, int index,
> +				     unsigned long modes)
> +{
> +	bool force_active_low = false, force_active_high = false;
> +	u32 mode;
> +
> +	if (index >= M88E1318S_MAX_LEDS)
> +		return -EINVAL;
> +
> +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> +		switch (mode) {
> +		case PHY_LED_ACTIVE_LOW:
> +			force_active_low = true;
> +			break;
> +		case PHY_LED_ACTIVE_HIGH:
> +			force_active_high = true;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (force_active_low)
> +		return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
> +					MII_88E1318S_PHY_LED_POL,
> +					MII_88E1318S_PHY_LED_POL_ACT_HIGH(index), 0);
> +
> +	if (force_active_high)
> +		return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
> +					MII_88E1318S_PHY_LED_POL, 0,
> +					MII_88E1318S_PHY_LED_POL_ACT_HIGH(index));
> +
> +	return -EINVAL;
> +}
> +
>  static int marvell_probe(struct phy_device *phydev)
>  {
>  	struct marvell_priv *priv;

[Severity: Medium]
The LED polarity field in page 3 register 0x11 is two bits wide per
LED, but m88e1318_led_polarity_set() only ever touches the lower bit
of the field. MII_88E1318S_PHY_LED_POL_ACT_HIGH(idx) expands to
1 << 2 * idx, so for the active-low case the phy_modify_paged() call
clears just that one bit and leaves the upper bit of the pair
untouched; for the active-high case the mask argument is 0, so no
bits are cleared at all and only the low bit is set.

That means the result depends on whatever the field held before. If
the LED was left in one of the encodings that has the upper bit set
(e.g. the tri-state/high-Z variant configured by the bootloader or by
strapping), asking for active-low leaves the pair as 0b10 - i.e. the
requested polarity is silently not applied - and asking for
active-high produces 0b11, which is not one of the documented
encodings. Since this callback is reached from the LED polarity
plumbing on any DT/sysfs configuration, the LED can end up in a state
that neither the user nor a later led_hw_control_get() agrees with.

The fix is to read-modify-write the whole two-bit field: pass a mask
covering both bits (something like GENMASK(2 * index + 1, 2 * index),
or a dedicated MII_88E1318S_PHY_LED_POL_MASK(idx) macro) and the
desired encoding as the set value, so both the active-low and
active-high paths fully define the field. Since you have the 88E1318
hardware and I do not have the TRM in front of me, could you confirm
from the datasheet what the upper bit of each pair means and what the
correct encodings for plain active-low and active-high are? If the
upper bit selects tri-state-when-off behaviour that we deliberately
want to preserve, please say so and add a comment, but then the
active-high path still must not be able to produce the reserved 0b11
combination.

While you are there, please also use BIT()/GENMASK() and parenthesise
the shift in the new macro rather than open-coding 1 << 2 * (idx).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914200847.445375-1-olek2%40wp.pl
