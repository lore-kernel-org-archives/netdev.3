Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01436B90C;
	Mon, 10 Aug 2026 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347807; cv=none; b=uLz+IhyFcFaB0l+C0tiHtvgID/4FcIafr7gKZvcKawDMVWS/PJw0ommRWkFi56kdnuLX6H9VVXNOCSccFBByX4T/yRYK0UFsloufbWIdyYm6oYWuPOvwhCUTogmqbbS5xdEs0ZhNL2BKWGH9czphTTPF1SeI47ZWFvwKj8A1ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347807; c=relaxed/simple;
	bh=4MagS9iisHzl/4qdqTszR1iBWSX/MBhQQU6tEBmzPWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J35yr2OkWp84vfj8g3bjedpzfv8r7rpHqHOZF0vxf2QNTQR8gmQBauoGh2iRx53U3j2pXqVPvuxF2uge64pZyPMwN26toKTf98UVmo5RXtlGytXEqRBzOvOTmkeiWLnAvjzu/MTKTQQmQqXvvL8YJAW2mUfQG3tU3+LRJcANZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdiAAuio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdiAAuio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A01F000E9;
	Mon, 10 Aug 2026 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786347805;
	bh=iSpgfwWFuV2LWLb4OwQdWzuS5dQxVgbxFzrJVmhNvVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kdiAAuioFX/H1cgjVRsCUXbHrnp+bBuPNw7tOOF4YK3cuAP9CfKb58qSDHwOnKG4R
	 FXN3aR51riXYyK6CKicSMauujLHgdyuUQxaBugHgSG8LxoW8WCjl3R+XuJqJTVBvvA
	 EnaPjzjLNcLAA6PuphK9Vr2kCWF4Ys7lL19CPz0Vl4F6QKVPwoxE16DtveTaZor1xr
	 N5Q3RBgSaH3yXpYRVGgnZorhEhDr9N0JoZU8tv7N9kXSDQMbIgd1XXGpqsrABfRR9D
	 /9hxYzv0m+4RGI8ZFBPAsux9TpNYPnK3r5dfsoNg+VOrrYJ4as0yyLiV2Pwc3VwKHI
	 KWatEI/2nfL0A==
Date: Mon, 10 Aug 2026 09:43:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
Message-ID: <20260810-arrogant-anteater-of-economy-ef2078@quoll>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>

On Thu, Aug 06, 2026 at 05:00:01PM +0200, Arthur Cr=C3=A9pin Leblond wrote:
> Add the link-gpios property which describes an optional GPIO line that
> can be wired to the LINKLED pin of the w5500 as an interrupt to detect
> link status changes.
>=20
> Signed-off-by: Arthur Cr=C3=A9pin Leblond <arthur@marmottus.net>
> ---
>  Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Do=
cumentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 641c9ddbde9e..cebf437ad3c4 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -35,6 +35,12 @@ properties:
>        however, board designs may need to limit this value.
>      maximum: 80000000
> =20
> +  link-gpios:
> +    description:
> +      An optional GPIO line that can be wired to the LINKLED pin of the =
w5500
> +      as an interrupt to detect link status changes.

The message is confusing. If you describe it from the host (system point
of view), then interrupts are not GPIOs but "interrupts".

But maybe this is OUT GPIO from the system to the device?

Best regards,
Krzysztof

