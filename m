Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA5921F4;
	Wed,  9 Sep 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986662; cv=none; b=UZN4UBmZ8l33LWDjyBlPycuQnSMRSuuaDtbxphh9eEYIR1liKa7VPX7MFjCN4WEtWGkngit81OVSlegzQZ95BuvCrzxoKUjr8MMaiAkFgciaTIKA6SIHPCmDukkysAwUs7VsE06TZwBSgV6xmfZ9jwBoX2/Ecsphlb1PwzHAnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986662; c=relaxed/simple;
	bh=ahl0fbg5/UFqv3zZP4WxlKs1WWBhs8EcWi6LeYjxnnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+/kgW4W2MH8u/SE/qXRmgmda9g6pQo+CjS4gSg4Ql2NP3xG261NQ/E1rV6RhUKGw/UW+C3hpLLZ3GRvWAVQdv6NqSonhG5SohpKQc2IfcjUz2gM3lwhosrmoPzCOEidatXaqsr4JUgK4YJuCu17SfjgzFN+0mXD2OAyvbJCeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=yfZz9SDh; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="yfZz9SDh"
Received: from email.seznam.cz
	by smtpc-mxd-7df9bfcc5f-xt28s
	(smtpc-mxd-7df9bfcc5f-xt28s [2a02:598:96:8a00::1200:70c])
	id 586156b6d8863c2b5a1568d8;
	Wed, 09 Sep 2026 22:43:27 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788986607; bh=e/HkKfN6iwJPRcF2XF8+TGEfrSl8EEtM0P3MJRJiMZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=yfZz9SDhDASJjvQcZRY02jVG5fiVKRUF1vIQgWkgr6L+Q5/NsXgwVFgTIlLnd/yoA
	 8aNlzTjYQx+hPaArtBDG1J+7jleBfUDWei3/jlESrOF6E8yWPtB0WuN+Ahx4fSxhv7
	 1l1Lij6Nqxk1ezn+mg/VbeW2VF3ZjaH8XIm1rpUkRqp+ePr5DYsFBHPHwugTD6EnTW
	 ICXo1T+ERyM6ERFp7bKu7jbuPTdbbt+H7IkbcpV6Q71yF3zqwgkXxN2SD7x6ogV6iC
	 qnYVCEUh2FzeU7wyqTw4KPBMhMiZB3UOxpcCwmNWNmq9HhwqisDc7ub0PEGFV7f0e7
	 AaKXVpJLuq2Vg==
Received: from arch-zen.localdomain ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-6ffbffc97b-d7f5l (szn-email-smtpd/2.0.82) with ESMTPA
	id bb405cae-3d22-42ff-830c-8034b149c070;
	Wed, 09 Sep 2026 22:43:12 +0200
Date: Wed, 9 Sep 2026 22:43:11 +0200
From: Jan Havran <havran.jan@email.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: lantiq_gswip: fix
 GSWIP_MDIO_PHY_FCONTX_EN value
Message-ID: <aqHE37RDmQNlA35W@arch-zen.localdomain>
References: <20260907134818.16670-1-havran.jan@email.cz>
 <20260907134818.16670-4-havran.jan@email.cz>
 <b7d56704-2aed-464f-8295-2ad70e4afa2c@bootlin.com>
 <20260908174322.61223934@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908174322.61223934@kernel.org>

V Tue, Sep 08, 2026 at 05:43:22PM -0700, Jakub Kicinski napsal(a):
> On Mon, 7 Sep 2026 18:28:32 +0200 Maxime Chevallier wrote:
> > On 9/7/26 15:48, Jan Havran (Advantech Czech) wrote:
> > > Per the GSW145 data sheet, the FCONTX (bits 8:7) and FCONRX (bits 6:5)
> > > flow-control fields of the PHY_ADDR_n register both encode 00 = AUTO,
> > > 01 = EN, 10 = reserved, 11 = DIS. GSWIP_MDIO_PHY_FCONTX_EN was 0x0100,
> > > i.e. field value 10 (the reserved encoding), instead of 0x0080 (01 = EN);
> > > FCONRX_EN is already 0x0020 (01). Enabling tx flow control therefore wrote
> > > the reserved value.
> > > 
> > > Set FCONTX_EN to 0x0080. The register is shared by all supported parts.
> > > 
> > > Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> > > Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>  
> > 
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Other than this last patch the series reads like net-next material 
> to me TBH. New board enablement. Is that fair?
> 
> No need to repost either way.
> 
> And thanks for quick reviews!

Hi Jakub,
it makes sense to me. If there is no other board using different speed than the one
defined by the straps and also there is no other board running it at 2.5G speed,
then yes, it is new board enablement.

Sorry for the trouble. I had not thought about looking at it from this perspective.

Regards,
Jan
