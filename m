Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E122FF22;
	Sat, 12 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172946; cv=none; b=tgK8jdmVhNMJeGIlTEHfrG6g1/CFia92Cy7kYr5MB12YJFxXmOXOZ8AfiqDHazC4A+WJGJ4T9Xp6VJvRwn+tay52u75ClCOIctFxqqLs/TdXY/mCCgdjseLl5WxMvpqk3SLJfjcdHJbqMfovnyzXgyFMJ1RB/wlY6icLthxS6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172946; c=relaxed/simple;
	bh=yRInyT4nAwQjg+M4AjyOXPgq3Tn/6M48qni9EzTqffY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhcCczgLCbiXZMK8WVzReSyFhzpH1piereINp9m9HPi80qEYHqaubF0wejEpKSktzYZxmZa+4irm5vTc+z6EfDWoDeyazagDUP4DClgLb/ZhATtslNwKk2hzQY/FJvSiTNOdI1Qmv0puXUpp+POTBBia8i60vo9dxy2k8R8Q08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Qc59br; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Qc59br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1831F000FF;
	Sat, 12 Sep 2026 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172941;
	bh=6CSta5XhIEPFGyil8kLX3aNZhGbqnm9QcBrHZcXnFkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n7Qc59brARl+nNjXgAcuCuR/XEFef3Fk18OB5E/Zv59cMsMbeCa0zYE+1xxDd1D0p
	 ut8YTzL0gqafmKVP3wsptrGg5z88HeO61gm1hqzjJqglNpn4LGJHgNNdE+fxZrxA4P
	 iE4MVj3TscEQmXAZL/MpytvkWbdv1eb7giclK/K0exAxaRkcG+6iM/AjCm7RUekNEX
	 uNhf9jnnXmvMH825rFcw2oBwsIuCHKude5lhaW1x50Gn1QB98KL5GwFgq3lImcxwHN
	 d8gKUYuHPMhrdZguXZP1hBexbcD/yFLSsCTbqVs3Ybh/KO9Jlb9ZR6yTbnlj4scsLp
	 p3DBONSsOGSbg==
Subject: Re: [PATCH net-next v14 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 12 Sep 2026 00:28:59 +0000
Message-ID: <178917293947.219967.869838796504417154@kernel.org>
In-Reply-To: =?utf-8?q?=3Cb442cc1c7dc708aecef0e4044298c31a86959238=2E1788976?=
 =?utf-8?q?064=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cb442cc1c7dc708aecef0e4044298c31a86959238=2E17889760?=
 =?utf-8?q?64=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Documentation/networking/devlink/mxl862xx.rst (new "Flash update"
  section, lines 70-74) states unconditionally that `-EIO` from `devlink…
- [Low] Documentation/networking/devlink/mxl862xx.rst describes
  ``asic.rev`` as "The chip version read from the same register word" as…

--

net: dsa: mxl862xx: document devlink flash and info support

Adds a new Documentation/networking/devlink/mxl862xx.rst describing the
devlink info versions and the flash update flow of the mxl862xx DSA
driver, including the MCUboot rescue mode recovery. The file is linked
from the devlink index and added to the driver's MAINTAINERS entry.

Two questions about the wording of the new document below.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..5b24d8cb57bc9
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst
> @@ -0,0 +1,74 @@

[ ... ]

> +   * - ``asic.rev``
> +     - fixed
> +     - 0
> +     - The chip version read from the same register word, so it is
> +       omitted whenever ``asic.id`` is.

[Severity: Low]
Is "the same register word" accurate here?  mxl862xx_read_chip_id() in
mxl862xx.c reads two separate words and builds the part number from both:

	reg.addr = cpu_to_le32(MXL862XX_CHIPID_L);
	...
	reg.addr = cpu_to_le32(MXL862XX_CHIPID_M);
	...
	priv->asic_id = FIELD_GET(MXL862XX_CHIPID_L_PNUML, chipid_l) |
			FIELD_GET(MXL862XX_CHIPID_M_PNUMM, chipid_m) << 4;
	priv->asic_rev = FIELD_GET(MXL862XX_CHIPID_M_VERSION, chipid_m);

So the revision comes only from MXL862XX_CHIPID_M, while the part number
spans MXL862XX_CHIPID_L and MXL862XX_CHIPID_M.  The adjacent asic.id row
already says "CHIP ID registers" in the plural.

The row's conclusion still holds, but for a different reason: both puts in
mxl862xx_devlink_info_get() sit behind one gate,

	if (priv->asic_id) {

and a failed read of either word leaves both cached values at zero.  Would
it be clearer to say the revision comes from the CHIP ID registers as well
and that both are omitted because they share that gate?

[ ... ]

> +If the recovery fails, the loader needs a power cycle: ``devlink dev
> +flash`` then returns ``-EIO`` and says so in its extack message. The
> +driver only re-examines the switch when it binds, so on a board where
> +the switch can be power cycled on its own, unbind and rebind the driver
> +afterwards to have the recovered switch recognised.

[Severity: Low]
Does -EIO always mean the loader needs a power cycle?  The only site
producing that errno is mxl862xx_devlink_flash_update() in mxl862xx-fw.c:

	if (READ_ONCE(priv->rescue_failed)) {
		NL_SET_ERR_MSG_MOD(extack,
				   "download recovery failed, power cycle the switch");
		return -EIO;
	}

but mxl862xx_rescue_heal_work_fn() also sets that flag after a drain that
succeeded:

	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
		WRITE_ONCE(priv->rescue_failed, true);

device_schedule_reprobe() in drivers/base/dd.c returns -ENOMEM when its
kzalloc_obj() fails, and -EINVAL when the device raced an unbind.  In that
case the loader is back at READY and only the reprobe hand-off was lost, so
what is actually needed is an unbind/rebind rather than a power cycle -
rescue_ready is only ever set by mxl862xx_rescue_mode_detect() at probe.

The flag is also set when mxl862xx_rescue_drain() aborts on a transient
SMDIO error or -ETIMEDOUT, not just on the loader-stuck verdict from
mxl862xx_rescue_drain_finish().

Could the sentence be softened to say -EIO means the driver gave up on the
recovery and the switch needs a power cycle and/or a driver rebind before it
is re-examined?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788976064.git.daniel%40makrotopia.org
