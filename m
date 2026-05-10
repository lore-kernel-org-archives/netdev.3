Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69D388E72;
	Sun, 10 May 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431672; cv=none; b=j49q//uEjbfhS8YstixXPm980s61t0j5SXFUJX1Nxtunczp6H4ceD+iCBgeBos4pHWQAsECmSq0H37ozn0b5V1DT3WIuKl87mRGAgho6KZflw4qQ/Em8+FNVG4gUz1WivxIFO68mGlenRXCfEuwR/pf3Q4Rvspy5Xf+Di4d4bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431672; c=relaxed/simple;
	bh=zwDJnl84possJqYiSlbVu3PgAwRhCZ9BMi6RKw3HoSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YThdShBPyvuOry7tapzApjI541J6JIEv6T4rAjfwkM27fsTvGlY/o8Qpid6cy9Md7bGEZeb/GARGGbmoQvdBov9Ibmz5bkuc6g9RXRzm2bDTFhIm8HrfX5sUnHtdUInDu49m7TjnWIrLr3bCjOZ8FoY7AmEJpanSv2+YRrGeLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlNoFq9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlNoFq9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD6DC2BCB8;
	Sun, 10 May 2026 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778431671;
	bh=zwDJnl84possJqYiSlbVu3PgAwRhCZ9BMi6RKw3HoSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlNoFq9ciz4frJsng2xJ1DGKqHjpGrWYwtgeLXum0fMOV60QR/PfSfe2a7Df8+Mmd
	 74FjxYnk37ty8I4SORTEF1AIAyAuuWbmxRHY3hqi7fOw/ueGH615e2u2qOa1bNxox7
	 Nw2xy46Si14s2Mjcr0d0mi5QkXf+eAC0GSYDzrYKy/VUdvg96hmWVq/C2XEjQ9Jzmr
	 nfxUDsCqC+MeeA8xTFx444OgTZS6T4qz3vcjBEOG5ciK7rr77YGE4CdKZcIeGw5c9H
	 9HgvkNz+4dd37buL/+fiHGzqbBZ2Hn6kNXoJyLe99rkVoyiWEkftd3a+6OEDgi7XVW
	 OJTTJysWPxQWg==
From: Simon Horman <horms@kernel.org>
To: jelonek.jonas@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no
Subject: Re: [PATCH net-next v7 2/2] net: sfp: extend SMBus support
Date: Sun, 10 May 2026 17:47:41 +0100
Message-ID: <20260510164741.1401430-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507093301.1144740-3-jelonek.jonas@gmail.com>
References: <20260507093301.1144740-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: sfp: extend SMBus support

This commit extends SFP module SMBus support by adding word and I2C
block access capabilities. It implements single read and write helpers
that pick the largest supported transfer per chunk and fall back to smaller
chunks as needed.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index e58e29a1e8d27..16d41d7ee6328 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
[ ... ]
> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
[ ... ]
> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			  size_t len)
> +{
> +	union i2c_smbus_data smbus_data;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
> +	u8 *data = buf;
> +	int ret;
> +
> +	functionality = i2c_get_functionality(sfp->i2c);
> +
> +	while (len) {
> +		this_len = min(len, sfp->i2c_block_size);
> +
> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			memcpy(data, &smbus_data.block[1], this_len);

Can this sequence leak uninitialized kernel stack memory to the output buffer?

When performing an I2C_SMBUS_I2C_BLOCK_DATA transfer, i2c_smbus_xfer()
updates smbus_data.block[0] with the actual number of bytes read from the
bus upon success.

If the adapter or device returns fewer bytes than requested (a short read),
smbus_data.block[0] will be less than this_len. Because memcpy()
unconditionally copies this_len bytes, it appears it would overrun the valid
data and copy uninitialized memory from the smbus_data stack variable.

Since the SFP EEPROM data is accessible to userspace via ethtool, could this
expose uninitialized kernel stack memory to userspace?

Should the code verify that smbus_data.block[0] == this_len, or use
smbus_data.block[0] as the actual transferred length?
