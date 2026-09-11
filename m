Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479945FFA9;
	Fri, 11 Sep 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126997; cv=none; b=rNENklXKTBhYA6oXktKTwLB9lVuPqsdNhzL8IfQNhZdUDwEHulmYcpuIDhL6iV4GbiGVu26AcUah8nh+9nBgoEfqqsrMIUBRNiQP+SNwrqeLYpsSyM4u8jjrWCpLG189ovSBXlJkgDf9GcYGubK/CcBdCFDtTyFsZHZeqHtqjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126997; c=relaxed/simple;
	bh=RWcNf8c5pUNhvNxR9inmOOvI+aKwiiexGgnsNSeiXIA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h5hzTrRphzxi/GbOd56Fx4vyaCAtIbqrWMWzUCth6VhQBy/L2fcNJ6/DtQTf1JWJKgHcFU1kzOppQLb7HfFxniQj7+po+Un3dujPniC8d+HqiSrzHARLB2fKFI7zMTt8bR941y11bHaWzA28ngRRxANIy9ocJ13OzkdJFjRYkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=tOl30TH8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="tOl30TH8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EC4BA02B3;
	Fri, 11 Sep 2026 13:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789126985; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YW+OXBf0uX4r8M69V0sG62JqDT1iej1OFCa/nZTJhic=;
	b=tOl30TH8QfgVYFHXJkZOnMfV3jnXO7/Dk2goTj34VH/69kmP0jJlLFxGWvTx5VReO8vAGO
	7rzMP2VtMdsCH2m3TxIJWNpSByNPPcE73SUpZrGVRNkSu63uRANBAl916JRALh5Xh/LKrK
	cT/QrhcY5i4V5IhUMjM79aHywsYzoWAuKKgl19Gc/4eKCjAoDf041WnsuZl6AmT/+5Sa0e
	INvwY5CvKJSz9awuQCVl9gKJCgqwwjWRDJVRi8vuFI7E/qI223quO7Ql3VKj1hZfCPsl1a
	Iruw/JtrUM7vsXSEOHHID4UyR6L6usszPU8Qd7OcwGh3OvtUl/SC2UgCbGYvPA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 13:43:01 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH net-next v12 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
In-Reply-To: <20260911-ks8995-to-ksz8-v12-1-5c3422d0d72e@kernel.org>
References: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
 <20260911-ks8995-to-ksz8-v12-1-5c3422d0d72e@kernel.org>
Message-ID: <9e08bb3a73888a05d47542948cfe7dd5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus

On 11.9.2026 11:09, Linus Walleij wrote:
> The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
> product. It was renamed from KS8995XA to KSZ8995XA at some point,
> but it has the same properties as the KS8995XA.
> 
> Be careful to use the full product name in this new compatible:
> there is also KSZ8995MA and KSZ8995E which are not compatible
> with the KS8995XA.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git 
> a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml 
> b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fc..4ed13870ed3a 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa
>        - microchip,ksz9477
>        - microchip,ksz9897
>        - microchip,ksz9896

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
