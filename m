Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5833ADB0;
	Tue, 21 Jul 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660848; cv=none; b=pGizuIs+3hc6X60XTfXSrk/wqs4x8mom3ZcGojTDCDBs54vQ1Z6HfggAyQVicxjMol4MHZoWZYfLLj1hwjVw/PyECWQXxRpR7igrgu23LJo164EWh3T7M105galg/Z2KPA1x36zk+X3JWb1c0b8L2IEXvQhk9ulwGQRWYORd988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660848; c=relaxed/simple;
	bh=+KQg+pZwYE4sqraS5TXh46zoyQVmI13i9tpp4N+2JhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osDq5LSLUXrJW8j/YRg8WwLdtAXbHLiEd3CuAoTPnWWBkosRUXLwdvcfaxSQ/6+POQ8ix/7yDeMQkckxLS4OIzQ+P42IDfa1mpyYLu/JzD17CoF/AkDlumKNAEBqbOISAzOO5w3GG22qK3yHIbbqZbDBImAsiihE7pGUN81gMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT2Alvvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT2Alvvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBFE1F000E9;
	Tue, 21 Jul 2026 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660847;
	bh=zcWQu6JFj0Tmgs6mnau/+2f+mu1XCO65n74ilNsKkRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AT2AlvvcAhz6uoW6kWaOvHTaLDIRumenJLIaaoz441E2vob1T5TilK6tY3lGp3ZuA
	 Gf1ize5zyI/MiGV3Jevxl+/jxB6A+687TlZsI/mi/T+bQERhzjJjvG4xnXQod2Yba5
	 3JJC/CFYutrypC3IsF+KRqPL6dMdFpslUkj9EuPoaAEVe+J/ASvGt+Qx3W1qUwQNMC
	 7vGpdouffNEXYhxd//fhUZxXgMiOawFO+xpru1GOfHDVW5mnJlH+mNh8nDEiraYOiD
	 9KO3qQxv3gd5ml6nwIB58+EMa5H0MFXYi2/TUGJKJKB6BBiLpBmSK+G19IY43huD38
	 1sX3li+mlbH4A==
Date: Tue, 21 Jul 2026 12:07:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: microchip: fix bracket
Message-ID: <20260721120726.287f7c81@kernel.org>
In-Reply-To: <20260711134204.472841-7-manuelebner@mailbox.org>
References: <20260711134204.472841-7-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 15:42:09 +0200 Manuel Ebner wrote:
> Remove needless ')'
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
> I send this in a seperate patch, because there's a change the maintainers
> wants a bracked added instead of removed.
> ---
>  Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> index b9c394009040..f4d0929616a5 100644
> --- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> @@ -35,7 +35,7 @@ properties:
>            - usb424,9906   # SMSC9505A USB Ethernet Device (HAL)
>            - usb424,9907   # SMSC9500 USB Ethernet Device (Alternate ID)
>            - usb424,9908   # SMSC9500A USB Ethernet Device (Alternate ID)
> -          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device  ID)
> +          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device ID

This looks like someone left the ID) at the end of a copied line.
The whole "  ID)" should be deleted AFAICT.
-- 
pw-bot: cr
