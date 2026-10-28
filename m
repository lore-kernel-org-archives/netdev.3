Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190923;
	b=I0D7DYokMvH/JqC++UwGF/gkVEecn7Edd1SMakP0Pp7igwK8n00BgKT7S6Wqi/OjHS7s
	 dNvU2qKcfuZU+C67OMjCStJvJidr2mlwGtxk+Kbh4CgCE3ZLc/TzSENht9ILw6qr5FPcx
	 mrPCp/IqF6iYdhaJq+/v0i6ClZMJOSPCrbapz4MRQq1seb07VZAJE8YlfmpTeD2XS9j2y
	 nYMq0W0FOb5Co6dL9F0JRIpu9gyN2JVKVka5tGgCNrjzYCAGz7/8irE2QmPRlVBhFyzNA
	 SMG6bNS1nYRjtILLndcrBkcuItED05+UatRFRLBNMkOO4u5HlgnyCqxScyDD2tU1VGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190923;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=mIpHk6iOWjpGN9O5FHmkorJ2iYcIvsqGrTEb77wuOHQ=;
	b=1l1kQeYFYDgwOhcjH4hVFF46pmXPdB3x3g54RRBafGmn6QvcokGDlr6ydaal3U33Z7/o
	 EmO116KgIoTNBXLo513dAwV4BIK134RSrbtfIXkxupt91uMvoa3YTotusUgFIQwKAQ7+R
	 F/08EAGxLEVD873xSVhm/k5VrYdXCpc4U02B1xvoBx2r0hz+qJZOIscf1UgGGveDAsNhQ
	 b4fNTg1gVhRByBAO9mFIWOOLC53hB8FpMpn3RMqj9jjBEJ2WEUUyrpVB0rBOA7sAoUiQS
	 bCo+JjDibNjvoIZqSk69jeP10pKy8UZ1ghzf7ZKn76+egPawztkJLPSlKHw2CZr2O/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Udr6XEpf;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CB606A329;
	Wed, 28 Oct 2026 12:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 828CB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Udr6XEpf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mIpHk6iOWjpGN9O5FHmkorJ2iYcIvsqGrTEb77wuOHQ=; b=Ud
	r6XEpfROX2s6rx/8r4fyxYUiLEnQP3mvrte9VsMJOGTUrS5vNKvMBluJWZ7nI3dTkepfI9xi4JyPE
	SjplqAo1pGuJgEeUiU806lu0j4JBl6o+7YAQ3LJL8HO32XgW0L4weh+kItNH4nPxUukinfStE1LRP
	yo7W+eseJeaWFYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xM2ru-00D6jH-Dl; Wed, 28 Oct 2026 13:35:02 +0100
Date: Wed, 28 Oct 2026 13:35:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
Message-ID: <2b406479-8c3d-40e6-93e2-e7ad01d5f432@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
 <734d4f06-26af-4bea-9c83-eb92c1b3b894@lunn.ch>
 <18472c61-efe2-4529-971b-82d877df6b15@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18472c61-efe2-4529-971b-82d877df6b15@cjdns.fr>

> > What is actually left?
> 
> 
> In v2 I was using special switch ops, and it looked like this:

Sorry, i did not look at v2.

> /* No manipulation of forwarding rules allowed in passthrough mode */
> static const struct dsa_switch_ops mt7530_passthrough_switch_ops = {
>        .get_tag_protocol       = mtk_get_tag_protocol,
>        .setup                  = mt753x_setup,
>        .teardown               = mt753x_teardown,
>        .preferred_default_local_cpu_port =
> mt753x_preferred_default_local_cpu_port,
>        .get_strings            = mt7530_get_strings,
>        .get_ethtool_stats      = mt7530_get_ethtool_stats,
>        .get_sset_count         = mt7530_get_sset_count,
>        .get_eth_mac_stats      = mt7530_get_eth_mac_stats,
>        .get_rmon_stats         = mt7530_get_rmon_stats,
>        .get_eth_ctrl_stats     = mt7530_get_eth_ctrl_stats,
>        .get_stats64            = mt7530_get_stats64,
>        .port_enable            = mt7530_port_enable,
>        .port_disable           = mt7530_port_disable,
>        .phylink_get_caps       = mt753x_phylink_get_caps,
>        .support_eee            = dsa_supports_eee,
>        .set_mac_eee            = mt753x_set_mac_eee,
>        .conduit_state_change   = mt753x_conduit_state_change,
> };

I think you should be doing something like this. Either two
dsa_switch_ops, or you add generic implementations for all the ops,
which then call device specific implementations dependent on the
compatible. This is how many DSA drivers handle different families of
devices in one driver.

I would avoid putting "if (priv->passthrough)" everywhere.

	Andrew
