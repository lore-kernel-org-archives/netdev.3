Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253A34F46F;
	Wed, 29 Jul 2026 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342568; cv=none; b=bGafd48bT9AxrjRtmnlTh4/6dV+WWveiqXATRalpCoKdhZQUqxoORdbYs4i591PdinhNSyEeyzjOWlwNHAf0hzfq2QIgWHobcVQUoC5sLH5wjAQTvReKqTenGolrmUWZR8Tg11Rkvp1ZOMQTvX0lbF6AHXol6fZDc2+JQbPnFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342568; c=relaxed/simple;
	bh=EHE6NWsFz625+lBO1lgcGR0qJ7OfMlIMH9SUBM2vfFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrEdHH8SYkn7lvH+Rdrw5oDGib+W/NEMfiCpDyIefX9wj8MOHLi3mjmyKpFLg3Z/0VilLo2Q3u68E+4X+KJ9oo/o3BcTQ6zZ5e7qDHDXrpV0DaXj8YRoj4+SLb41BgwpsQo6CI0UuTx5pCrw1c5yv1bjy03QNhJzupjXS9EBONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U2nC0qZh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U2nC0qZh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=07zzg4tyQn68vbdlszr3ligpYW8XEoNE156+JLLXuMM=; b=U2nC0qZh5fjvgMxsARqJR3miYA
	gmgfYHrXlKqsCJQzQBBUsnlfh2NSbE8L78Z7Kbd6EtY2BxkGkvfdWqG8ITgb6TbR7q5qWV6TcgBqW
	Y0wKN2EcMGFWlxqgZe8oYDeX4Qjdp5nLJn2UrUrEVL4jQQ7/bLNcbm6VO2xgOml8xjNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp79U-00Eqcw-Nc; Wed, 29 Jul 2026 18:29:04 +0200
Date: Wed, 29 Jul 2026 18:29:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	jun.ann.lai@intel.com, yi.fang.gan@intel.com,
	boon.khai.ng@altera.com, matthew.gerlach@altera.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Message-ID: <d39c7b4c-04b4-4bfd-8a4b-821a8a32a885@lunn.ch>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>

On Wed, Jul 29, 2026 at 09:51:04AM +0000, Ovidiu Panait wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain an 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag.
> 
> This issue was observed on the Renesas RZ/V2H platform (which has a dwmac4
> IP), when testing QinQ ping:
> 
>   # DUT
>   ip link add link end0 name end0.100 type vlan proto 802.1ad id 100
>   ip link add link end0.100 name end0.100.200 type vlan proto 802.1q id 200
>   ip addr add 172.16.3.2/24 dev end0.100.200
>   ip link set end0 up
>   ip link set end0.100 up
>   ip link set end0.100.200 up
> 
>   # Peer
>   ip link add link eth0 name eth0.100 type vlan proto 802.1ad id 100
>   ip link add link eth0.100 name eth0.100.200 type vlan proto 802.1q id 200
>   ip addr add 172.16.3.1/24 dev eth0.100.200
>   ip link set eth0 up
>   ip link set eth0.100 up
>   ip link set eth0.100.200 up
>   ping 172.16.3.2
>     -- FAIL --

I stretch goal, if you are interested and have time. Can you turn this
into a test somewhere in tools/testing/selftests/net ? If one MAC
driver has it wrong, there are probably other MAC drivers which are
also wrong.

	Andrew
