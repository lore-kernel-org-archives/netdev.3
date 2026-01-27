Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F723187FE4;
	Tue, 27 Jan 2026 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483521; cv=none; b=Wu46dK1qNwIe1/uo9KshcAR9OCKzbEIosFLacqvx7OwHl3VGbFSKMCZHRpQFhU1FHrQIH8qHZ7sDwWAv3ecO3EjQYjOgUaa/uJbGYQy4sEcPMjcyFTZWkMR9R5rSCbW/BHAi+/VgBoPq5bQUSYbbue+Kca6khIIvIOz6TbofxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483521; c=relaxed/simple;
	bh=yUD4rZQgtNsdI6Yn488Qs5CLgJCqlAjCfXJ2v7y+RIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEA4jcH/Y/4sThsngbhBFCJWqOH1BUtIeBajR9/KLhukX8L+qca2Hw6QYSbvAADi7aWOLPQtfKIeX3+qQm7Qku4b5jrU+fTrd+BLzF68aVhtmyhfN8JfEZijUd/XhY4BeWN/vxrCfN2ofkPMeFU+S7SeN1D66nwIRfcU1znKcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrqzeG+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrqzeG+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03B6C116C6;
	Tue, 27 Jan 2026 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483521;
	bh=yUD4rZQgtNsdI6Yn488Qs5CLgJCqlAjCfXJ2v7y+RIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GrqzeG+0agZmusNDpcWTqXPFVIup9zuzKwJfwXYdu466vt/8kEe1iXgnEuM9Lw0ar
	 cxU00Y7+dw/2CLEjdnqsm3crh9d902nSQrn6kI54f1rLPqkxtpbljLnGGjjUkh9gi0
	 lHDSEyWGhxEQP3o1KBUDGAmhTwod8Etnivv7ZFdWxZgIfhcij8OFNHYyW9SQ3a/46X
	 wx7W4mYP91IUFm8x720eyMEk2zQr9FukK2Xia0swHPEO95yY25bjI5LePDbvN9yAIw
	 sQqsHqVb8qAaXigklT++ufxBAP1sunmX1tV1oXUvs/vtJz4gxrRRwPYpWMvOcSksl6
	 uUyv42dpd7upg==
Date: Mon, 26 Jan 2026 19:11:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel
 Golle <daniel@makrotopia.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
Message-ID: <20260126191159.05b57b91@kernel.org>
In-Reply-To: <20260126065749.1334867-3-bjorn@mork.no>
References: <20260126065749.1334867-1-bjorn@mork.no>
	<20260126065749.1334867-3-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 07:57:48 +0100 Bj=C3=B8rn Mork wrote:
> The Airoha AN8811HB is mostly compatible with the EN8811H, adding 10Base-T
> support and reducing power consumption.
>=20
> This driver is based on the air_an8811hb v0.0.4 out-of-tree driver
> written by "Lucien.Jheng <lucien.jheng@airoha.com>"
>=20
> Firmware is available in linux-firmware. The driver has been tested with
> firmware version 25110702

> +static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
> +			      u32 mon2, u32 mon3)
> +{
> +	u32 pbus_value;
> +	int retry =3D 25;
> +	int ret;
> +
> +	/* Configure CRC */
> +	ret =3D air_buckpbus_reg_modify(phydev, set1,
> +				      AN8811HB_CRC_RD_EN,
> +				      AN8811HB_CRC_RD_EN);
> +	if (ret < 0)
> +		return ret;
> +	air_buckpbus_reg_read(phydev, set1, &pbus_value);
> +
> +	do {
> +		mdelay(300);

Did you mean msleep()? mdelay(300) is a lot of spinning.

> +		air_buckpbus_reg_read(phydev, mon2, &pbus_value);
> +
> +		if (pbus_value & AN8811HB_CRC_ST) {
> +			air_buckpbus_reg_read(phydev, mon3, &pbus_value);
> +			phydev_dbg(phydev, "CRC Check %s!\n",
> +				   pbus_value & AN8811HB_CRC_CHECK_PASS ?
> +					"PASS" : "FAIL");

AI code review points out on failure you just print a FAIL and carry on.
Is this because this is what the vendor driver does? Or we know bad CRC
FWs exist in the wild? A comment would be useful here..

> +			return air_buckpbus_reg_modify(phydev, set1,
> +						       AN8811HB_CRC_RD_EN, 0);
> +		}
> +	} while (--retry);
> +

> +static int an8811hb_load_firmware(struct phy_device *phydev)
> +{
> +	struct device *dev =3D &phydev->mdio.dev;
> +	const struct firmware *fw1, *fw2;
> +	int ret;
> +
> +	ret =3D request_firmware_direct(&fw1, AN8811HB_MD32_DM, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D request_firmware_direct(&fw2, AN8811HB_MD32_DSP, dev);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_rel1;

Please name labels after what they jump to. Per CodingStyle..

> +	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;
> +
> +	ret =3D air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;
> +
> +	ret =3D an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
> +				 AN8811HB_CRC_DM_MON2,
> +				 AN8811HB_CRC_DM_MON3);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;
> +
> +	ret =3D air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;
> +
> +	ret =3D an8811hb_check_crc(phydev, AN8811HB_CRC_PM_SET1,
> +				 AN8811HB_CRC_PM_MON2,
> +				 AN8811HB_CRC_PM_MON3);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;
> +
> +	ret =3D en8811h_wait_mcu_ready(phydev);
> +	if (ret < 0)
> +		goto an8811hb_load_firmware_out;

TBH the gotos are a bit hard to read, maybe factor out the logic that
can fail to a separate function? Then we can just capture ret here and
fall thru; and the helper itself can return ret; directly.
--=20
pw-bot: cr
