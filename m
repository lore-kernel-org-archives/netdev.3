Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892C2C3257
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594628; cv=none; b=Fz2c7TWUWUzxgX+DVwMaryLZTzR4urePPu20ArIn6zrAS8CRPrhnzFPze52eP+Oohd89OGnNA1BPIhmV+lnQmqq79fZEZMiRLsFuE7eUotm4UAflKsQayg2St7h7rYgPqNy/MV96q/BTtw5ONjKaOrVOgOXUqG5IIK1X65Xu9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594628; c=relaxed/simple;
	bh=wHf/q6POZNSNARHurPBSCBRt+/FARjYt64rvsdOIcvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgU9L9kM7SMATwjfCTJrcJmqmfa2xpB+6RYjczrEjxv0a1kYK/ko3OcnYEZZxnKhQ6zXN/GcTXNc8c/jvECBCfUFDCN7rBbEQRhVuIbqSSk4VApsMJbyQpvh/XY7cpW/JhmvNzi+yjQoZdDf2UdiaY1ragtwA+jbUm4jONoDlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P3LLbll6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P3LLbll6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F3591A2ABB;
	Wed, 28 Jan 2026 10:03:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0EE236071A;
	Wed, 28 Jan 2026 10:03:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9CE1119A8695;
	Wed, 28 Jan 2026 11:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769594624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fW1rz+jrI+rToURQhzvWdjua5v+hNnJ7D6YuU7kHAB8=;
	b=P3LLbll6pvr6IJdtWr85zlavVdk4hgUKknA4DPbZO34RvxJAQ6r4dk1GTdCT5Gjn2xtS+J
	biG0/biR7JOhq4yU4GTVuH8rXeS0I4ABXdo4p4oloydL64MecjeisD+ruDC/HXU1DYV4Jz
	aqsXzkw/F6ZTzPjbxELxCu0V2uTYIZAZwkYvkT0hO95YXDPzUOn9TDyeH9MqbgAhnag3EB
	LjUFzYGotmlxMF7+lgMUJESfvAymmY+xiWDZJbxS0NIA++Dmpj71BEN0G6r6YQiv0XjxgZ
	V4u/LLopQGciyelNTkcZm/gq25bVYMZvQCWmf1jzydzXyhKwxffFsK7/YNYhaA==
Message-ID: <a84cb1e7-0782-49a0-9d61-f4b693788e6b@bootlin.com>
Date: Wed, 28 Jan 2026 11:03:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126081544.983517-1-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260126081544.983517-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 26/01/2026 09:15, Wei Fang wrote:
> Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
> external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
> by phy_driver::resume() and disabled by phy_driver::suspend(). However,
> devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
> will automatically be disabled when the device is unbound from the bus.
> Therefore, this could cause the clock to be disabled twice, resulting
> in clk driver warnings.
> 
> For example, this issue can be reproduced on i.MX6ULL platform, and we
> can see the following logs when removing the FEC MAC drivers.
> 
> $ echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
> $ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
> [  109.758207] ------------[ cut here ]------------
> [  109.758240] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0xb4/0xd0, CPU#0: sh/639
> [  109.771011] enet2_ref already disabled
> [  109.793359] Call trace:
> [  109.822006]  clk_core_disable from clk_disable+0x28/0x34
> [  109.827340]  clk_disable from clk_disable_unprepare+0xc/0x18
> [  109.833029]  clk_disable_unprepare from devm_clk_release+0x1c/0x28
> [  109.839241]  devm_clk_release from devres_release_all+0x98/0x100
> [  109.845278]  devres_release_all from device_unbind_cleanup+0xc/0x70
> [  109.851571]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
> [  109.859170]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
> [  109.866243]  bus_remove_device from device_del+0x140/0x458
> [  109.871757]  device_del from phy_mdio_device_remove+0xc/0x24
> [  109.877452]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
> [  109.883918]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
> [  109.890125]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> [  109.896076]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4
> [  109.962748] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0xfc/0x13c, CPU#0: sh/639
> [  109.975805] enet2_ref already unprepared
> [  110.002866] Call trace:
> [  110.031758]  clk_core_unprepare from clk_unprepare+0x24/0x2c
> [  110.037440]  clk_unprepare from devm_clk_release+0x1c/0x28
> [  110.042957]  devm_clk_release from devres_release_all+0x98/0x100
> [  110.048989]  devres_release_all from device_unbind_cleanup+0xc/0x70
> [  110.055280]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
> [  110.062877]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
> [  110.069950]  bus_remove_device from device_del+0x140/0x458
> [  110.075469]  device_del from phy_mdio_device_remove+0xc/0x24
> [  110.081165]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
> [  110.087632]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
> [  110.093836]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> [  110.099782]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4
> 
> After analyzing the process of removing the FEC driver, as shown below,
> it can be seen that the clock was disabled twice by the PHY driver.
> 
> fec_drv_remove()
>   --> fec_enet_close()
>     --> phy_stop()
>       --> phy_suspend()
>         --> kszphy_suspend() #1 The clock is disabled
>   --> fec_enet_mii_remove()
>     --> mdiobus_unregister()
>       --> phy_mdio_device_remove()
>         --> device_del()
>           --> devm_clk_release() #2 The clock is disabled again
> 
> Therefore, devm_clk_get_optional() is used to fix the above issue. And
> to avoid the issue mentioned by the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> clock is enabled by clk_prepare_enable() to get the correct clock rate.
> 
> Fixes: 25c6a5ab151f ("net: phy: micrel: Dynamically control external clock of KSZ PHY")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


