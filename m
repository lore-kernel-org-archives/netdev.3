Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C53AA4EF;
	Tue,  5 May 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997003; cv=none; b=VERHppxAorYJxOZp1Ysmf9TfsNevUoRElB85QESF4y7TgjAsaYxxsEDNv/O3zNtevt5e7tTPh2QWeLLUtHixBULqdpmkDNBgwq2DSf1u9kgi098/sGZ87mb2oE/YoAF0Hzu5gGmyMNhsbTxoccclHCVk1wZnualbpzaDAAl29jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997003; c=relaxed/simple;
	bh=iO74e8yY971Bi/nhnTRes6jMSc+fYUf60PWJD9fCwK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvFmOaIwvJA/m5pqI3RpwYKL89BGlD3doQNRW3bIZtVBwthXuHVWE9kesLAwd+rGXWzOqn0pV66LJWIzB7FsJf7C4GLB5Q8iZmQwQDXIGI2tjvwhNXpz9yZxgfSfxVbEPPUZioahmKz6Qp9BykQatfNO6ObrkFG5UI4cDxMjcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wKIEm-000000000lR-04fy;
	Tue, 05 May 2026 16:03:08 +0000
Date: Tue, 5 May 2026 17:03:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 2/5] net: dsa: mt7530: preserve VLAN tags on trapped
 link-local frames
Message-ID: <afoUt46gGwAC33ZU@makrotopia.org>
References: <cover.1777986341.git.daniel@makrotopia.org>
 <3ad4b724d7ae6250b8429d50fe913d2dca07a3f9.1777986341.git.daniel@makrotopia.org>
 <46071c08-d85f-4157-9d61-6a0feef56747@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46071c08-d85f-4157-9d61-6a0feef56747@arinc9.com>

On Tue, May 05, 2026 at 03:37:29PM +0000, Chester A. Unal wrote:
> Hey Daniel.
> 
> On 05/05/2026 15:16, Daniel Golle wrote:
> > The BPC, RGAC1 and RGAC2 registers control the handling of link-local
> > frames with reserved MAC DAs (01:80:C2:00:00:0x). These frames are
> > correctly trapped to the CPU port, but the egress VLAN tag attribute was
> > set to MT7530_VLAN_EG_UNTAGGED which causes the switch to strip any
> > VLAN tags from trapped frames before they reach the CPU.
> > 
> > This causes VLAN-tagged link-local frames (STP BPDUs, LLDP, PTP Peer
> > Delay Requests) to arrive at the CPU without their VLAN tag, so they
> > are delivered to the base network interface instead of the VLAN
> > sub-interface. The DSA local_termination selftest confirms this: all
> > link-local protocol tests on VLAN upper interfaces fail.
> > 
> > Set the EG_TAG attribute to MT7530_VLAN_EG_DISABLED (system default)
> > so that the switch does not modify VLAN tags in trapped frames. This
> > way VLAN-tagged frames retain their original tag and are delivered to
> > the correct VLAN sub-interface, matching the behavior of non-trapped
> > frames which pass through without VLAN tag modification.
> > 
> > Fixes: 69ddba9d170b ("net: dsa: mt7530: fix handling of all link-local frames")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Thank you for this patch. Could you please confirm that it conforms to the
> findings documented on this patch log?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=e8bf353577f382c7066c661fed41b2adc0fc7c40

Yes. Combining VLAN CTAG and DSA tag into single "mess" tag is what the
MT7530 hardware does, and also what tag_mtk.c expects, and mtk_eth_soc
"special tag" feature handles well.

I've found, addressed and verified all the issues in the series using
the DSA selftests in tools/testing/selftest/drivers/net/dsa, ie. running
bridge_vlan_aware.sh, bridge_vlan_unaware.sh and local_termination.sh
in a loop, and random order, on BPi-R3 (MT7531) and BPi-R4 (MT7988).

With the series applied many of the previously failing tests are now
passing.
