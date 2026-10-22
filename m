Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670030;
	b=0HcO8fIQIpepJM4pKOdAp1NFfp7vJm+yDGUPcZHgSQOuiAcoA/BCYXxD3pRSTr5j53dY
	 9SshuwAbn6ot4IoPbPJhz5G8oPr1d8y9BJx172InR6OAchxGkQmp8HCVoic14TZI4kAy0
	 wqPCtfKpebmKBpP6i3/v3JRxNZLi3BfIa3/B65xKeRgug2oztv+vs4YKi/6viPBaiL2Wu
	 mOmTacTL9e7FQ4VFUAP9TTRn8FYH2LEjvhNHB0Q5R8Y4u/j9ndtDIYhzrI7rHb23c5eC5
	 xRroLo7cOyOZ9q9MuKUB6fLNBVdCT2xsL4Iae+EyhVvYfktQM3ZFzzbILt9H4aThDcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670030;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aFj9EOMMM4ZfmH8lB0SRPQlwHihAc++U7Qmw0rZKtAw=;
	b=dWV/mfPn7DDMoQr1IMIWy/oF0X/k6aB0/rrFOAJnkKSuavZ6jokP+9JV5/MfvnFaeOgT
	 4PN2gqI3bVTgooWtRk1nCG8+xw2UKqsfiv1AZJUdDHb2D+5a04k+6rnQFAPTJFpNMrrUO
	 C5j7Vb2xfxKrgk90wqc1jmg5S0q8+mlUPmTvgOlnWJS3ooPQr/UcxPRqW7vkEJHauifEW
	 UOPIh+bvISNL6fnPUeqDUAg0amjeXImIi2F4sRA/76fIEx22ZzKEIL7j5F8HGkpDmYXaP
	 xpIUhHzuMZFAOS52kQ+yR5/GQO6yc2vjlKteI+yWX9g5ZHGmBzsc9yvLDcMYBFm4m3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwbgQH6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AE606A332;
	Thu, 22 Oct 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwbgQH6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F881F000C5;
	Thu, 22 Oct 2026 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670030;
	bh=aFj9EOMMM4ZfmH8lB0SRPQlwHihAc++U7Qmw0rZKtAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VwbgQH6E6d2EPY7DrOxy0zWCdu18bjOfHPcC7AtxLsjjNoxU2WijAntIipUbau2H6
	 SzyLGawID2D2xB3WFoFCq7890+Ml7u9VNIIQFKdaHdOn0AzB3+kpmeVv4tl5+bTSrE
	 s7Hc4gCSgCjM3DFDo+tNo2WPAyyyP27uW67NO5In8bCrrGOZr3xGMTY38OAM4TqZTM
	 1rdDjXwP1N22vg1dirZduSskhN+vr0TUkKHAwWiiM/zyvFeYxvGSz/3Uz/RTuR/72q
	 d3QMKgthEetIcsCackzdQN4/1kTg0Q1+MqnWnLlXuX2bwFA/g+45JC621rhkLufpoJ
	 T4WYtaaVinzbA==
Date: Thu, 22 Oct 2026 19:33:44 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
Message-ID: <atn0mF-dukVTK6Lh@xhacker>
References: <20260929121025.20821-1-jszhang@kernel.org>
 <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>

On Tue, Sep 29, 2026 at 10:29:14PM +0200, Andrew Lunn wrote:
> On Tue, Sep 29, 2026 at 08:10:25PM +0800, Jisheng Zhang wrote:
> > stmmac enables TX checksum insertion for XDP frames whenever the queue
> > supports it. XDP frames carry no TX checksum offload request, so this
> > can overwrite a checksum already present in the packet.
> > 
> > Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
> > so that the packet is sent with its checksum fields unchanged.
> 
> This seems odd to me.
> 
> If the frame contains a checksum, it is either correct, and the
> hardware calculated one will come out the same, not an issue.  Or the
> checksum in the frame is actually wrong, because the frame has got
> mangled by eBPF before sending it out, and you want the hardware to
> calculate the correct value.
> 
> What an i missing?
> 
Hi Andrew and all,

some discussions happened in below thread
https://lore.kernel.org/netdev/athAoWfW-xesPhFP@xhacker/

Since it has been merged. Let's move the discussion back to my patch.

AIUI, dwmac can only do HW checksum for normal particular packets
layouts, such as TCP, UDP etc. The stmmac_has_ip_ethertype() has
well demostrated this limitation.
Different with normal tx where the common stack supplies the skb->ip_summed
metadata, XDP path doesn't have the necessary metadata. So to make
the XDP always work properly when transmiting tranmist arbitrary Eth
frames, dwmac HW csum needs to be disabled by default currently.

Thanks
