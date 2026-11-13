Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582681;
	b=NXNHyh0lJdU3UHtsMFzTPwJ65f8gG+rE/ijD6wEKNAsQiBlkSx1lLipTuhuXwdWtalJv
	 t9js3nX5WIbszLT8ofdz3wLtHYkpcP5k/p+9AUhXb5zc3JXwi/llUpdkJgb8I6j6Tjvbm
	 sXciW/vQjzRZAqeEvSgd7yFn0L3YjCC0MiaCeImFpMeVZX4JWMoMKfquV3tqc6ML3boFj
	 Ew3/bEFTBxGFA0DKjw6FD5RW2Ul1lILDe6NKw9AvR9Hkk2FOXPbJe9qFQN4UjliBtLrAI
	 L1JiPtra5LhGaFxILkx8RRNMPyaISG62HDOCRvBjxa+mh2nW2axZvbljIjRyWDdLoDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582681;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vDzDjk5wOPRNTyrCu+qywdWe1gP/ssS390KRH683Jh8=;
	b=VBByXnOQRpVEYkzY6Ggg5tXq13Rim6ufaRountvk5XGHtvmlVzPo7ZRUzNfljp6fDEvH
	 2RAQAx1xpvTT+LG/7VSuQSO8z2Q9yuXY7LuMh3fDqm7Hd+g5pFPJ3pcpbKV58ELRofHmO
	 nAFXob+XmVlUj5DCEtlz4K6L22Lk7wCcNFvzehP4nKMfDgTVrq0iwmc9ET22bN8Qk1gZ2
	 cV/xm6FQN/ai8lAt6ZGXBQza9rqHu1OVS+mMyJjU+C/945dqDtUPhD5DnTy7oAHKCVAjo
	 KVi327jnHezwgYuvkMN0w6peJFEvcDJjw3qAX2E1BzsAI/Fy2Cyxf/x37d02/eRIUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64A606A330;
	Fri, 13 Nov 2026 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F64A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xRsvk-000000004Px-1vle;
	Fri, 13 Nov 2026 15:11:08 +0000
Date: Fri, 13 Nov 2026 15:10:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: joseph@telaak.dev, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Message-ID: <avcoghKd4CU13QI_@makrotopia.org>
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
 <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch>
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
In-Reply-To: <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch>

On Fri, Nov 13, 2026 at 03:08:10PM +0100, Andrew Lunn wrote:
> > This is separate from commit 82e2c7db0830 ("net: dsa: mxl-gsw1xx: force
> > internal PHYs into a known reset state"), which only programs the PHY
> > bits of RST_REQ. On this board that commit is applied, and the PHYs still
> > sit at the shifted addresses; only a hardware reset of the switch moves
> > them back.
> 
> I don't think 82e2c7db0830 is relevant here. The commit message says
> nothing about the address of the PHY.
> 
> How does the bootloader change the address? I assume there is a
> register it writes?

Yes.

PHY_ADDR_{0,1,2,3,4,5} at offsets 0xF415, 0xF414, 0xF413, 0xF412,
0xF411, 0xF410 (ie. reverse order). Bits 4:0 are the address of the
respective built-in PHY.

> 
> Is there a comment about why it changes the address?

I *guess* that in this case the vendor wants to avoid using PHY
address 0 which is widely misunderstood as being the "broadcast
address" (which it is, but only in scope of AUI attachments and SFP
modules). I know many people who get upset about using PHY address 0
for an actual PHY rather than reserving it as a broadcast address all
PHYs on the bus are listening on...

The switch also has it's own MDIO master interface exposed on external
pins which is shared with the internal PHYs. Hence programming the
addresses of the built-in PHYs can be done in order to accomodate
external PHYs on the same bus which may not be free to use arbitrary
addresses.

> 
> Does the driver have an implicit assumption about the addresses of the
> PHYs? Should the driver actually be writing this register to put the
> PHYs at the expected address?

The driver does what is described in the device tree. Ie. boot firmware
applying a non-default PHY addresses should just say so in the DT passed
to Linux imho.

See also Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
