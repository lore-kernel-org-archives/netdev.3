Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022733603DB;
	Mon, 19 Oct 2026 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392561; cv=none; b=ssf9ILWjFHRUp7TfdmVjPUs3fD2dHKfS/N5BH6ovts9TqdxSXZQew2O6fKKF+R1Z2tVOsJSIergYF7bhVSJWNWhHuurW3cNcIV3y4rV93Mkd33lPV/XNPNXOePKLH2Q1mPzbldxjjlhYf/9ILVZdDs/tOAMML6E0Cu8e/N+31v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392561; c=relaxed/simple;
	bh=prliaSanfZ9E6za8qzSTgxlKa04qerbY3IyuMA3bw4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0+weZYfQBESGknQgHJo0EBMHyWPWLoRGbeUWX6PRULBlpf8YEm0Hxt/VJmCOhyShlrwjStg+mYc/2FlJxqI48BRNKheVTXs3qQKvU5HJ4Pmn+QrcV3DcYc6BQYLH37wxmTyInbcImimjqHqT1g/fBnqiNzWPl6DvfzB5gXVtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcHtS95v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcHtS95v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0220D1F000C4;
	Mon, 19 Oct 2026 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392560;
	bh=J4OMYiiG3ut7MrExL3jhw5ap4nPHmzyK4fpnY5BaTSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BcHtS95v6TJqYLJjwqZL4FSWE2sJ4aSzOIb7ycKZjpBqYxiSxwHDR6Sk78w/Uk1b3
	 2QYnMlfrCZD9hEY5AS9fzZ3WW32aANmCxrhvjmYGyzwrpbfnm4QKFLl8c9e42vtkuG
	 /PFjgzg1Ejgjz0WPEc8kJ0H2T6wYKP0vGn5AuXpQvBoBmq561PxravxIKN0xL1gL02
	 LaWS9V0GRW8heVBUe9tTZR4v+SAJnnmIrxbNF0FjEg29vrM9jzm5ip9rg9XPJNWrXs
	 xfnUhsGWS7Pr8u8AULwpl/oPbNxSVBX9cDVS33OOQ5W9EGpeIQz49+/DlNI9J9drpe
	 FVKjDx/2XdRKg==
Date: Mon, 19 Oct 2026 08:49:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: net: rfkill-gpio: document
 reset-gpios property
Message-ID: <20261019-aggressive-frigatebird-of-courage-9cc7d6@quoll>
References: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
 <20261016-ok3568-c-v2-1-068d68430e6d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016-ok3568-c-v2-1-068d68430e6d@gmail.com>

On Fri, Oct 16, 2026 at 03:29:33PM +0500, Dmitry Yashin wrote:
> rfkill-gpio driver requiers at-least one of the gpios to be defined:
> shutdown-gpios or reset-gpios. Document missing reset-gpios property.
> Also add example for wwan with both gpios.
> 
> Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
> ---
>  .../devicetree/bindings/net/rfkill-gpio.yaml       | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> index 4a706a41ab38..66f6ad2872ff 100644
> --- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> +++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> @@ -29,7 +29,12 @@ properties:
>        - wlan
>        - wwan
>  
> +  reset-gpios:
> +    description: GPIO connected to device's reset pin (RESET#)
> +    maxItems: 1
> +
>    shutdown-gpios:
> +    description: GPIO connected to device's shutdown pin (W_DISABLE1#, etc.)

That's the same pin. This was sent multiple times, why is this time
different?

Best regards,
Krzysztof

