Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AB4BC017;
	Fri,  5 Jun 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650715; cv=none; b=cGzIlGESDlr3fzijbB1jmpSeb1Ov9lvINKl7YYKEoT/vryv8xEQUymyTnDd06rXt11jNrl6Z3v50hoxCd31UbXYuC6Y8RDAGrBCR9OKR5zcUHXe+gamfSyvccIaRIcRLximEvgG0W9cLXzCsD8SaooU4w0jf60+/kF2dXb8ZQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650715; c=relaxed/simple;
	bh=MuGBut1FtJQzdAFLjx87BgB6LjFUv77fDZHP6Wq9/0k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O4TVyK5agBnOhP8xvoXGq56OSoxvmOu23rQh0aLmvU/54OHNCFj119Ur76Qx6kz6zgsbgrDUKMNytpM49jDUwCWWLD4ojs44Eb/epEpPZbB4EXus0xH9GpGHMcZhkIP3Oly2WBfQIHgKXrk/3aF0QlMWOO/YdxWXropQOR/fznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ik9ET4at; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ik9ET4at"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EE7EA002F;
	Fri,  5 Jun 2026 11:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780650711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6hHGKFoipsvu3O3524CdwJVZxf1JZmWhoR13aqgMWMM=;
	b=Ik9ET4at6vndL44P3/i9Q/eTVu4//4RT4RE2lXlJEguSW2rtsY/vep5/xMS7RbZ8uS5kz6
	p9Q3V+CPgUeaESV1yprPmhj27OnvV+bU/xI2Uy8YhAb7CuoggqvX3pVzsSV/cu0CjwSOv5
	RL72i/P9zYR/8E1CFyZwQtaTQ8qUhBNDR2KDg26+GRN07SC9DUjLZxKPP4wj0R1qjZtDex
	SCk5ccjUb+0CQrj0zt+wlmMqbymzoVtaPgZromPyagrQuNuY9TWEg+BHP5Fceh9+lF3yoj
	nUIKiMzcwUfceCb/AAmbjfTUAhcDzU2RTRJRVXIJTLUl/N5BKOnF9/joxXjJBg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 11:11:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
In-Reply-To: <20260605074328.1800-5-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
Message-ID: <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will 
> not pad
>  - reverse xmas tree for some definition
>  - add explanation on rtl_phy_write_mmd_bits()
> 
> Changes in v3:
>  - add struct rtl8261x_priv
> ---

> [...]

> +static int rtl8261x_config_init(struct phy_device *phydev)
> +{
> +	struct rtl8261x_priv *priv = phydev->priv;
> +	int ret = 0;
> +
> +	if (priv->fw_name && !priv->fw_loaded) {
> +		ret = rtl8261x_fw_load(phydev);
> +		if (ret) {
> +			phydev_err(phydev, "Firmware loading failed: %d\n", ret);
> +			return ret;
> +		}
> +	}

fw_loaded loads once per lifetime, phy_init_hw() does soft_reset before 
config_init.
So after a reset (e.g. resume), aren't the patches gone and never 
re-applied?
en8811h for example re-runs every config_init - but just guessing as I 
don't know
the internals of your fw.

> [...]

Thanks,
Nicolai
