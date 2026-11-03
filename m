Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713856;
	b=WsRXNqRDZYket2meQbSl4CiJsMxATq42VF2g7XVaNOAVJ3smDlIYyiYe33ISJ9Ly5dVh
	 s8PC5CEz7Rm9JD84t8hdUVlk6PC9+RFnYTt6hw1w+WdaQUSTqp7N6JosChGWIklq3uJwr
	 ZC/FzyoyBFfdi843rYuN/qBC60jwbaJjYkBXf8xdORex4M3CpTG81JlUDJcIejZwLuxKX
	 bVeKceHSS+CF97RMAkeCzrURPoLbya7Ae7ZUvEBp1Zd2bvL9Wq6M5gtqpw6K1o8QgRu4U
	 DrrJK4B9JuLWdWALEm60q/QSLVA3AKMyb4y9BSwoT7WZeuzMLucQejsRSE2SaMc0XJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713856;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GDNcNC3AhQlf0hAoy/6nNkz+jJ+YBSU86MsQYtwD23Q=;
	b=OxtckYQ4xjEurNUybGYqNQYOKb/UcaPmzLRxk9AJ/vJ+z+6fM2wstAMeonpQxmjRjjGG
	 PMVnqAoKQYZDXxGSW7PeV7CQjNhYJ3GqowXnyt/oiIzYzNa2eUrvS5TTwwI15PBuaP/G/
	 q91xl9MTxoXDVvO6py0X+QwKOx0T8nCAbjVFcoXkipYrLBfaGrFjagWy4BMpqdV1FoOIk
	 G/ba57sQZGAzTIr1e4GqsgArPWrNXfoiHfu1dx8j7DGkwaB8lMgtX4STTfy/nsb95UD6I
	 d8KgPiSv1V4H3uXkMoKVGPipoNSxHcrCrCzDrVyKWwnyMkNho0lk9JmvJWwmzot4B3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=umQl8pri;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E5606EE86;
	Tue,  3 Nov 2026 13:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692E5606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=umQl8pri
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GDNcNC3AhQlf0hAoy/6nNkz+jJ+YBSU86MsQYtwD23Q=; b=umQl8priBMMRCgcPuDSD3UKeH6
	vSZRzpTPmnaucDFmasy3DXPCGRjm8t+7gL5xVAvJUPfrAEkiH/zM/RoAM9ujqF6tIQDmpswoKpq1u
	awL744svSvpXj5DpWOf6JBR0yd7VF5WtlEUMRI+VzbDo8w3ic6JoI37OhNIefyrkp2SU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEuU-00E4Sq-BW; Tue, 03 Nov 2026 14:50:46 +0100
Date: Tue, 3 Nov 2026 14:50:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH v2] net: wwan: iosm: drop redundant skb->data check in
 MUX DL decode
Message-ID: <d225d4ad-5ee2-4e48-8eba-99eca3b96283@lunn.ch>
References: <20261102081920.50288-1-fangxy@xiaopeng.com>
 <20261103111101.39235-1-fangxy@xiaopeng.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103111101.39235-1-fangxy@xiaopeng.com>

On Tue, Nov 03, 2026 at 07:11:01PM +0800, Fang Xieyan wrote:
> The skb passed to ipc_mux_dl_decode() through the current RX path
> always has a valid data pointer.
> 
> The only caller, ipc_imem_dl_skb_process(), checks for a NULL skb
> before calling ipc_mux_dl_decode(). The skb is allocated through
> ipc_pcie_alloc_skb() -> ipc_pcie_alloc_local_skb() ->
> __netdev_alloc_skb(), which provides a valid data buffer on
> successful allocation. Allocation or DMA mapping failures return
> a NULL skb instead.
> 
> Remove the redundant skb->data check.
> 
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
> Changes in v2:

Please always start a new thread for a new version of the patch. The
CI system does not always pick up the patch and run it.

Please also read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr
