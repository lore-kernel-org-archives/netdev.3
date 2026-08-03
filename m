Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE314334B5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790554; cv=none; b=pYjPseJjV3gswhXQSklki8lcB6RoYfuvhiONMWU/VFG7zjRAZjJySgtQo3Cb2Nl6jzLh9iBQgZ/QeUC6Jb+VUYKStlpOMdu6gBH0uzc6rC2i8FAZiEHgr0TPZ1dI1/Z/4UtmWfWw4Huwl3q14EFiO568Le1+Dkky86mijWsZPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790554; c=relaxed/simple;
	bh=Am3Qpb/8MiDnIsx3aXYKb/RfHdbN3e7+11RDaxHetMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SagX8rB/RImV8NZGU1A0LOUIYSkqiwaHUjcTDpeD5OkWy2ghqYsG7VETRc4CBpEQ8x5tsX6OktLDD5F4v/Wn5zGUohj2S741W3WgxjlvFyDox/iIddnKZ6RDr0nEXXD6uhkgfNijW9DTITOUzf7ZWX6AyZSWTlBfm581I4g+pM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=j2rxWUOC; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=n8H34Gwl; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="j2rxWUOC";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="n8H34Gwl"
DKIM-Signature: a=rsa-sha256; b=j2rxWUOCYmrNmb0tzg4yngKlaEJNXAizA8ma01qvvecwvvpGLyp09KSfGDnNyKpCMq0V/TJBa27MQI5w+bGHEeraI3Lns1Rfu41ZiFO0auvDcvtqUrpR2hupTW5vS+0NguiuO9LAMDMPL5qxRKOdxQTcP5VDKrJxqFTd+ku18EVFtBFCMXzeZp45dSOX4t1MJJL3p6vG5L1ozLeR+DnHE0Z78+u5MgCt2eUBuSDfG8X4WS442FuLvhs4t0ofNrbusLzLqGxJ4xHX1/f8bvjoNuXFUw1kqNu0+WHnAmV3/cLcrUUSnzzPpGpGbkVdEq8jvd8QhKUBDw6SnMBUuralzw==; s=purelymail1; d=tinyisr.com; v=1; bh=Am3Qpb/8MiDnIsx3aXYKb/RfHdbN3e7+11RDaxHetMo=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=n8H34GwlB6BUlcD6dpV/9IpPV6ZYmmOf7hmtbZ0BBnUXwwd7FEHoYOMpFaGdFaiDHS0BSghxS+ANVwMXL74/eEgBMV5JnOk9xX+ThnKxRl3BXBV2sf83zSzQLAbjpZ92V8Op12kgSIqwkZeoZFwVkHP9DoaK3QvlENBP2CuRzosEQL6K9THOi22m7dmvLYaKPzxJsrfIeWUf7AB0CUr+likusoUaxt4Jum1gscpTNC2rQ8U+0ZHzEcZBfL31DeTt+SdVSKu+7vzv/GNUe+HX3h5R8YJtudOGnb+TuBo+bJjXDzkKWIuCq29h5Sayp0avudMa5Wuy7s7Qd4Hr3BBOGg==; s=purelymail1; d=purelymail.com; v=1; bh=Am3Qpb/8MiDnIsx3aXYKb/RfHdbN3e7+11RDaxHetMo=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1032040423;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 03 Aug 2026 20:55:48 +0000 (UTC)
Date: Mon, 3 Aug 2026 23:55:00 +0300
From: Joris Vaisvila <joey@tinyisr.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, andrew@lunn.ch, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com, 
	sean.wang@mediatek.com, daniel@makrotopia.org
Subject: Re: [PATCH net-next v6 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <anDxMZRFgM-Kgmaf@archlinux>
References: <20260704105659.140970-5-joey@tinyisr.com>
 <20260720235201.466172-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720235201.466172-1-kuba@kernel.org>

On Mon, Jul 20, 2026 at 04:52:01PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: initial support for MT7628 embedded switch
> 
> This patch adds a DSA driver for the MT7628 embedded switch, which has
> five 100Mbps user ports and a 1Gbps CPU port. tag_8021q is used to
> isolate ports via the switch's 16-entry VLAN table, with the double tag
> feature enabled to simulate VLAN-unaware behaviour.
> 
> > diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> > new file mode 100644
> > index 000000000000..eccdb05fce9b
> > --- /dev/null
> > +++ b/drivers/net/dsa/mt7628.c
> 
> [ ... ]
> 
> > +static const struct dsa_switch_ops mt7628_switch_ops = {
> > +	.get_tag_protocol = mt7628_get_tag_proto,
> > +	.setup = mt7628_setup,
> > +	.teardown = mt7628_teardown,
> > +	.port_enable = mt7628_port_enable,
> > +	.port_disable = mt7628_port_disable,
> > +	.phylink_get_caps = mt7628_phylink_get_caps,
> > +	.tag_8021q_vlan_add = mt7628_dsa_8021q_vlan_add,
> > +	.tag_8021q_vlan_del = mt7628_dsa_8021q_vlan_del,
> > +};
> 
> [Medium]
> How is a user expected to place two of the user ports into a Linux bridge?
> 
> The ops table does not implement port_bridge_join or port_bridge_leave,
> so dsa_switch_bridge_join() in net/dsa/switch.c returns -EOPNOTSUPP:
> 
>     if (!ds->ops->port_bridge_join)
>         return -EOPNOTSUPP;
> 
> That makes ip link set swpN master brX fail for every user port, which
> seems to contradict the commit message:
> 
>     The switch hardware has a very limited 16 entry VLAN table.
>     Configuring VLANs is the only way to control switch forwarding.
>     Currently 6 entries are used by tag_8021q to isolate the ports.
> 

It does not contradict the commit message. The driver intentionally does
not implement bridge offloading.

The ports can still be bridged in software without propagating it to
the hardware. This is a deliberate simplification to keep the initial
driver easier to review. It is also a practical initial solution for
this switch, as all of the user ports are 100mbps, while the CPU to
switch link is 1gbps, making it possible to bridge multiple ports at
line rate in software.

> Without a port_bridge_join hook, dsa_tag_8021q_bridge_join() is never
> invoked, so there is no path to migrate a port's tag_8021q VID from its
> standalone VID to a bridge VID.
> 
> Would wiring the tag_8021q helpers directly, similar to what
> vitesse-vsc73xx-core.c does, be sufficient here:
> 
>     .port_bridge_join = dsa_tag_8021q_bridge_join,
>     .port_bridge_leave = dsa_tag_8021q_bridge_leave,
> 
> Related bridge-lifecycle callbacks such as port_stp_state_set,
> port_pre_bridge_flags, port_bridge_flags and port_fast_age also appear
> to be absent, is that intentional for this initial submission?

For the initial submission tag_8021q is only used for the standalone VID
feature and software bridging is used. I intend to work on hardware
bridging after initial support is complete.
