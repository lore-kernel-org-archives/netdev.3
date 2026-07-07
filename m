Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED73F888C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424256; cv=none; b=KWpqQFhF51RhBxSdeLJYn1zcOSrBm4LN+sWEqxhCaoL9xbJNyNgADzOsoZFrh2exgpe9nFSWcvMZTORFFyI9hkLOKv5QL0twuIh+8wObpQwWslze8hgeRkKWPslLLtuvmrwGFjcN9gEDOdZjTxyG2B2OzSd5aNZ/zQIQZaolwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424256; c=relaxed/simple;
	bh=pEC7ni5BvaU18nJiwHRqi9eXs+4Uf56v5D/Fk9lI1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSmPuRepG5wwdC/lL0g4P8yH5fUKy1qeKcFk58hW2vS3CGhxAIM3QDqOTKrJlTPgPFHNfTGfsipHZNY5fNIX768WGevX8LxNUQML7GjgMoqzKoxR7dFSab50MWw67RGOUCWeRNMWEghIGDGlA+0HQFg3k/8lPKazwWqjzEP9ZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=noIwUguk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="noIwUguk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7455BC8F1EA;
	Tue,  7 Jul 2026 11:37:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0339601A3;
	Tue,  7 Jul 2026 11:37:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D07F811BC15B3;
	Tue,  7 Jul 2026 13:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783424251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oe3bY6f5fTi80f3+Jhgg+BnDGy7fhtzVmRe3YS6HHNQ=;
	b=noIwUguk9xY2PcJRl9sO+XvlR2RlhLvf0kfUpLAy2d1w7s8stfv7La0SZgFovtBHwF/h6j
	w+uxreTyyh7Z1rspi8XWaQzs6aMysc7NZ+LEohM9VCiIAJY2sPG1S8T/JElnxO6l390svT
	Ch5eVRqjuHNYrI9KhtpIKifwBEe0hEx77Y83ogtsEFSUsnb0X3SKK307C+S2pQHN0IqwMm
	Pc4VfBCCQZVNPxc0pl5sad6Qeab+wobHfj2pUyfGubJGM7dzt6D2U4hiDInC29ClJztWCo
	3UiIQNbC+Kj1rteVolSg3XR7zZukCcrHX97luVSkluRZNSPbTcznvcn7PV9eQQ==
Message-ID: <96409687-5752-4ff9-b4ab-2c9ca54d6b15@bootlin.com>
Date: Tue, 7 Jul 2026 13:37:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/8] r8169: add support for phylink
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, linux@armlinux.org.uk, enelsonmoore@gmail.com,
 daniel@thingy.jp
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
 <20260707091637.371-4-javen_xu@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707091637.371-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/7/26 11:16, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Transfer old framework to phylink. Phylink can support fiber mode card
> which can not get link status or link speed from standard phy registers.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - merge patch v1 3/6 and v1 4/6.
>  - add helper rtl_mac_enable_tx_lpi(), rtl_mac_disable_tx_lpi()
>    and rtl8169_get_lpi_caps()
> 
> Changes in v3:
>  - use phylink_ethtool_set_pauseparam to set pause status when change
>    mtu
>  - replace phy_do_ioctl_running with rtl8169_ioctl
>  - recover phy_mode according to tp->supports_gmii for 1G nics
> 
> Changes in v4:
>  - set lpi_interface if support eee
>  - Only if jumbo changes, set pause
> 
> Changes in v5:
>  - no changes
> ---
>  drivers/net/ethernet/realtek/Kconfig      |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c | 279 ++++++++++++++++------
>  2 files changed, 206 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index 9b0f4f9631db..49ac72734225 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -88,6 +88,7 @@ config R8169
>  	select CRC32
>  	select PHYLIB

PHYLINK selects PHYLIB, you can therefore drop this.

Besides this and potential reworks for the pause, this patch looks
pretty good :)

Maxime

