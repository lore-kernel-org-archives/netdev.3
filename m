Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828984;
	b=YdZ0kZk+1fU7YVO6QbcnuKjgqQdKiB7x04t8nLLoLuQXbBqsmyvlfAYrchWiOofHaX0y
	 3hC5mCFIFzW5bmB/CD55sfiEVDhmW8FQ7e35EXh5XhHuEU61QbbmvVOlOZwGh0lD5dBuz
	 /RNQ/6JloMqOSMEbdtNRFNPhibZ+pWYoEiYdQEe+lqN7BJex3RV6YR0ahIXBO+WKBF1+k
	 XxUCyKe4OG211Sujgp20c4Xevtfv+ZTyr2//s2pE/jGgyGjwC3gFZXpXzH+qBZBQFqsfo
	 FZiRGsZ1+irkb80xYTX994QBxMvUv1ef1LtSc3ODZSEmhaR1EHgyBPKLTadCqywqshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828984;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RinK2DTX0zCufv7dIR25sE/5ixQgGujYjwaK0erONYI=;
	b=3Sl6kLuTxvoKcSc6+WtJjEUq6YTXz/8bWCtv/TISfyESgItVdAWRk/+uF5Y0fr6Fgs1U
	 5dV3YsSH3PIuLkuf1K8WlFhtfAKJ9LbC+IFP6+7JTpK+ZHqL9p1hziV9fu1IGtMf5xMBk
	 4G+r+eNTTkSD2wc4aRI3ZvzEBzWJX8uJUdk5RMIc9biDmFMQbnP/p5KKJIczFb8xFaJiQ
	 604qFJXfXj65la0B8fIk7Dqhd99jY7gEg/7TPTttbVBZqmaHaHJSUhyRMlXdSy+/QeCSx
	 SYFiN4ygVQRepIjxAcmKDEmc6c5gP0I+Zzj4nC2jlmRXHED/sboWYFnbmu+/dcDbjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNQ6vUL3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AA6070753;
	Wed,  4 Nov 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNQ6vUL3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75AA1F0093A;
	Wed,  4 Nov 2026 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828984;
	bh=RinK2DTX0zCufv7dIR25sE/5ixQgGujYjwaK0erONYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YNQ6vUL3MV8yghkVxSfC6S/qwKZDwCihc4OskGx/Z2L1Z/IBHFp34De/yDbKN8FLw
	 vBIP91IcF/OEkuPRVBDIRtswEVVoDwdOKEbrT7mBTRvBwT86fjQiqpvNQzBPm9uhUv
	 bmE57/nk/jMY993Tu181PsmCU/oZwAm1WIW2PJJl9jNmuwA+gGWPgrqtYB/ubxzaHX
	 dGK//672vugxtQqwyRKv5e9xcgyt5DYcS9RmdkmpSQdXnJvYqNH5siAaXEfYWbbvjF
	 9RcbWBF8p3vdMNmK0em9ieAe+kbPMQmb7qLl/hkGb/S+38WNsCTZ3xNMyKsYDMzGTE
	 NzKF7HLbPY70g==
Date: Wed, 4 Nov 2026 15:49:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 reset-gpios
Message-ID: <179382898210.502893.8721462307288531503.robh@kernel.org>
References: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
 <20261104-mxl-gsw1xx-reset-v1-1-53839bf5c88e@telaak.dev>
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
In-Reply-To: <20261104-mxl-gsw1xx-reset-v1-1-53839bf5c88e@telaak.dev>


On Wed, 04 Nov 2026 02:15:47 -0500, Joseph Telaak wrote:
> The standalone GSW1xx switches have a hardware reset input, and boards
> wire it to a SoC GPIO. Allow describing it. The SoC-integrated GSWIP
> variants have no such pin.
> 
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

