Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACA2D94B5;
	Wed,  2 Sep 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353643; cv=none; b=bs6qFxjJLF54m/V0mkdn+uiEKOFWHQ4yuR+rMogTGsFWvTvw8cM+VXfOZZPSVkc/kNuLPSEFiMiRI96Aj5d6k1jbryRBX4OvB4T0kPseoPp1Jqt3YIYpBNIwyiQOJJeKuqxbykKlRHPI8xiog7EYY7uY+NtvrlxvcuOreHm6Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353643; c=relaxed/simple;
	bh=eORvn0t45Re9ukeHl7L+yr38pSs2SJAs48Ak3IpwdmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLt+oli+9FAjwYNNB41zNfs9qBgFrqSI84fyAy+rhfPY5AMqo+1KfPMyxlYKkhQcHgc/bmW/nEjvz6qISrTvriIE26e1ci7RaqglXb9S+CLNHJUdQvurLPcXkGpOL8Hm2kWYO5F9yaPENceWZ9rEUrHLoSq9s83G5BtgH681qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0x30AaBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0x30AaBY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NXZRfozIgeVdTdoSrpQDZ/nZ7JGjGqwD3d2O4WMrIWg=; b=0x30AaBYc+66u3W1k8C4FW++RY
	RDbNiS3BZz7Na2j8hbQZdIygEBBG5zdb/k9GhXgBa8BpmrAB3ALiPEwQxRN/FjD0DDVR88fUClrD/
	ksOa7QM8sgOMifuk5f/DS1g+6kV4P/aJ8jRooAt99w0jEywdsYJBI3eyJC6cIPWXmhw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1kTU-002WLV-Dp; Wed, 02 Sep 2026 14:53:56 +0200
Date: Wed, 2 Sep 2026 14:53:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next 1/8] r8152: refactor r8156_init
Message-ID: <9a90f05a-ce9e-4f90-9a0d-19242f57f225@lunn.ch>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-2-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902090632.41844-2-nic_swsd@realtek.com>

> -static int r8159_wait_backup_restore(struct r8152 *tp)
> +static void r8156_init(struct r8152 *tp)
>  {
> -	u32 ocp_data;
> +	u16 data;
> +	int i;
>  
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> -	if (!(ocp_data & PCUT_STATUS))
> -		return 0;
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
>  
> -	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> -			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
> +
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
> +
> +	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
> +
> +	r8153b_u1u2en(tp, false);
> +
> +	for (i = 0; i < 500; i++) {
> +		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> +		    AUTOLOAD_DONE)
> +			break;
> +
> +		msleep(20);
> +		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +			return;
> +	}

Please use one of the macros from iopoll.h. And return ETIMEDOUT on
error.

	Andrew
