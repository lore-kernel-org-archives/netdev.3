Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2437A836;
	Mon,  6 Jul 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347472; cv=none; b=kGiNE5/WMmLbVHu+WyJRBzzUOTFnd8Wf/lAJ9GRUiyAsE5JOBWHf+hV1BM4b47SQ2TsRTr4AHwBEwK95rgYTPq91gvwl8Dxfk/cmvyF+0dSxkEHddku/mFxf75F/RYaF6pjEcgizuMOmNqP4Zm6jLQA32sKX6b7rVCrPTQO1Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347472; c=relaxed/simple;
	bh=gqEN4yEuJqeft4O65ZWqzzQPhS7Hu0z60urTWCiy4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad3Web+TyO+yr8g2zqTLB+rcBD1KzGBnm/SMqTCiupZTHDT5rIQvpmv4dRjnTK4Fj3HduoHtFibd/gGB94rUky69K5qByPAX7tlCJclIaBRDdpQANSPXa+ITGbBT2JquGjAtYb3FFLDIlCCsovXqQPDpIq1mZ9Z439KXCLqnLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NXewQB/V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NXewQB/V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=t4Z7cgDJ+ry2IcOlaM3iFiga27Hfw0yB/aOf5j/AC4g=; b=NX
	ewQB/Vv8AFQa10aeCRPRDbnFxBVli6C1SNio4DmFtJOgiwCr5RRiIe61CVHrjJZG3psEs4DNahD7G
	dGlqWPwMmtNSdAQEGIewGcAB+uBBD/hFcRiT7jbJIaMJOEv1xzuxV2NhDPjfdJtqdHa3FfSQeaZ9Z
	qp+g7Opf1ZQavg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgk8p-00B0D2-HJ; Mon, 06 Jul 2026 16:17:47 +0200
Date: Mon, 6 Jul 2026 16:17:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>

On Mon, Jul 06, 2026 at 11:29:19AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> <linux/mdio.h> itself doesn't use any of the device id structures. The
> files #including <linux/mdio.h> use a variety of them:
> 
> 	$ git grep -l '<linux/mdio.h>' | xargs grep --color  -E '\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>'
> 	...
> 
> but none of them relies on <linux/mdio.h>'s #include.
> 
> <linux/mod_devicetable.h> is a bad header mixing many different device
> id structures and thus is an unfortunate dependency because if e.g.
> struct wmi_device_id is modified all users of <linux/mdio.h> need to be
> recompiled despite none of them using struct wmi_device_id.
> 
> So drop the unused header.

While i agree that there are lots of unneeded dependencies here, does
this change actually solve anything? Pretty much every PHY driver
needs mdio_device_id, which is part of mod_devicetable.h. So it must
be getting included somehow.

I assume the long term plan is to move all the structure definitions
out of mod_devicetable.h, so a driver can include just the ones it
needs? Is this patch somehow a step along that path? Why not move
mdio_device_id into mod_devicetable_mdio.h and include that? It seems
like the more obvious fix.

	Andrew

