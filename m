Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBA46DFFC;
	Tue, 21 Jul 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651048; cv=none; b=J7IifE1PhlBaRlhoT2st6DRuDwJaVgMhrKOvUYhUOi4a0xiHubJHnAt3yiQ5neKmPthO2+kmdR4sINYjNtjwuaP+7MokBRYJPKLw2O1noxLjg/I4bi3OlSkkS0e2+FEv7tkfT0uhIrLU72xzH/orTrmgElobCKc0CCKr/Q/KA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651048; c=relaxed/simple;
	bh=pkC/EPtC6dmaa8Iy9cYbPWRO3F0g43wCfR/BxDR56WU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mX2zlYoUiAkKGy+f32HsHg3OZASsROmc5ihUFEROrPi4lJEmOMyOwV19bEvVj6TEFnhShcwtt8pKFcPkxLK6Ev4gylKf4k0bdkH1546/2vVlwpeJdC92XMbgUgD1upDutq9iBBWjxfyw0isvE77AT7/oDooUVao89+m4zlWYTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWL1LxLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWL1LxLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A26E1F00A3A;
	Tue, 21 Jul 2026 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651047;
	bh=L40TZbrm85Gv/POqF8y05yduPM9W3eoBoNRB+CSuKkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gWL1LxLu/+0jYZavld98GNjHJCXVKFyq8jP6Fn9S9OSJk1y2WyZYTeC/6STzlnJ4d
	 RX3X4n12CUDyEsUR0cCV5oPexEpeAZSuZuf30Ub6UrVCZW7HYXJAgEer8DT0fj49q8
	 T1Jrtj6CGNtKQHZmcYvgWeDRXfYaG8sKAsSSt87Gu5jkHLjNIbhskEsJw/G1X88F8e
	 ZiFxHwlkpdQb8DOQLEfwUdLm7g9uNWXRvpST42SdbyvHnDiX6O684V5EOiwJrFwi3K
	 rgTC08cAfZL8TwTMIjylG3Dj4YdDFTWT9RR7iXc+WuXlnz3ZoUngGMN8U/TezsI3YO
	 NrMwiGyx3wNwQ==
Date: Tue, 21 Jul 2026 09:24:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, manuelebner@mailbox.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net-next 6/9] net: usb: move exported symbols from
 cdc_ether to usbnet
Message-ID: <20260721092406.37ea770c@kernel.org>
In-Reply-To: <20260714114429.1073434-6-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
	<20260714114429.1073434-6-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 13:44:26 +0200 Oliver Neukum wrote:
> --- a/include/linux/usb/usbnet.h
> +++ b/include/linux/usb/usbnet.h
> @@ -16,6 +16,11 @@
>  #include <linux/usb.h>
>  #include <linux/spinlock.h>
>  
> +static const u8 mbm_guid[16] = {
> +	0xa3, 0x17, 0xa8, 0x8b, 0x04, 0x5e, 0x4f, 0x01,
> +	0xa6, 0x07, 0xc0, 0xff, 0xcb, 0x7e, 0x39, 0x2a,
> +};
> +
>  struct cdc_state {
>  	struct usb_cdc_header_desc      *header;
>  	struct usb_cdc_union_desc       *u;
> @@ -304,4 +309,16 @@ extern void usbnet_status_stop(struct usbnet *dev);
>  
>  extern void usbnet_update_max_qlen(struct usbnet *dev);
>  
> +/* We need to override usbnet_*_link_ksettings in bind() */
> +static const struct ethtool_ops cdc_ether_ethtool_ops = {
> +	.get_link		= usbnet_get_link,
> +	.nway_reset		= usbnet_nway_reset,
> +	.get_drvinfo		= usbnet_get_drvinfo,
> +	.get_msglevel		= usbnet_get_msglevel,
> +	.set_msglevel		= usbnet_set_msglevel,
> +	.get_ts_info		= ethtool_op_get_ts_info,
> +	.get_link_ksettings	= usbnet_get_link_ksettings_internal,
> +	.set_link_ksettings	= NULL,
> +};

spews a ton of defined but not used warnings
