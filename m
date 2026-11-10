Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306621;
	b=PKMJmzVTXj7obvrJzs3nKkXXTrnVs+AGnsjpR39dXDchr0xVsbLORdx3soLdTwsTNjDe
	 /aQQax2xg0oAYWWpo/F5WIT5qpkkRQ3fV9nnK/UXGAFyKe3X1h8eUEpEzNG4U7oacBP+/
	 QQtjWFCW/2EebpMCdgiml01t+y9cYlR8x9Et6HFucV3dsweYHCGSgwiZC7AX4UlkWzopv
	 VIQAiZmpg5kcd8XrjmQX0SaauV0J13bOsAd6+GgaoyJZR4Kj49q68T5LLqc9ylEQWx6IS
	 VNm2cABMw3wiKL7STYz9h7Z+2EOU//JAo28AwS+oCAGKDHBrBsQ5jWL6gWgUGTpdt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H3tlyIivpEQAfTuEdh9TMux42zaoavdQDwL403yp9Q8=;
	b=RUf+GuTCv5ExzMx8TxFskf1G8TshuSoPdo2sSJhSemcMlLYsugyH6/yGEGK8V5GPlGQE
	 UlvrWM2fZ7xRhp1Yrt58nS7ayl3u7vuLmUKpnQ9MDtVTIOG7e5zwvwJLIdfUMgTPnvsoo
	 8e0HspgqrA8EyVuJzjqjt4OS2AHhudNha5e2kM3lZ/HzMGidIosdZVcP/vsbQ5bCWa/sV
	 Y3okQA4CSs88t4LEg344D7Bd1kCiQ99L8L408ZSGFkgDfBbCIrUE8uULn1kjcJKJV00GN
	 YnTOsXuyFFR8fmi0SW0kORRwOFA1mXl8ueHacdZKZWjg3iFdoBjBfvOMHJYIJern9xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOvO45kq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32978606A325;
	Tue, 10 Nov 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOvO45kq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EA21F008A5;
	Tue, 10 Nov 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306620;
	bh=H3tlyIivpEQAfTuEdh9TMux42zaoavdQDwL403yp9Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oOvO45kq67rd3N7RAEDn0rC+QwfiY/USWlX/UZJCTCLnP2Um7V6kANrHdVR+KIwNr
	 5wU/wTnVdN3rl9/vq9DHVgOkjpgz/24pCLMUXojYIBnczHxC6ValM4n1+RiGuD9Jnz
	 uyk2i1s8XKF1u/Kh0gLvzRa4NIaczzb7mpHRTeYIVMKcGA4c7rU7AibN/8BNLCPX+F
	 wVO/nV+kvk5781/R3Q9m+7Ft6Nh76BMkr3mfFbu7zIkQ2+1qPg/vTdalwC5mPMaDNM
	 Zj6JPxrXao9l+JBA4Gz/EyRlchhEq54f2WAN460YKlU8/AfJ4yWTiq/nsbv2dHmHTN
	 ohOVYCvzuoBuw==
Date: Tue, 10 Nov 2026 11:30:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/5] dt-bindings: net: dp83867: Add
 ti,output-impedance-ohms
Message-ID: <20261110-polite-juicy-labradoodle-a939fc@quoll>
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
 <20261106-v7-2-topic-dp83867-v3-4-45e1d3adf1bf@pengutronix.de>
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
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-4-45e1d3adf1bf@pengutronix.de>

On Fri, Nov 06, 2026 at 08:47:28AM +0100, Steffen Trumtrar wrote:
> Currently, the output-impedance can only be set to default, minimum or
> maximum or via a nvmem cell.
> In cases where there is no backend for a nvmem cell, a value can not be
> set.
> 
> Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> output-impedance in ohms, between 35 and 70. Like the existing
> properties, it is mutually exclusive with the nvmem cell and with
> ti,{min,max}-output-impedance.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

