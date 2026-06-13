Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6134844C;
	Sat, 13 Jun 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345052; cv=none; b=gg2Sq9evQe+fKnqMXY6f3JNiBHYmP5OhiWT+lXM9jy1zk2PSh422bxL9AYFcT0/wlwlbbgr1+5ylsNiHkZoc/sD5Gvpzm25EMgL06DjwQh3WTEoi6Z4NAnonByj52x4WKsT297PKNJ1O1aYzeFLQvL6IQhEWdu3hrzotd/8lN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345052; c=relaxed/simple;
	bh=qVfH7sjHiXBPZfKhBycuOUwn7G30k89gay6FUdpZfHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u34gWxzb6fEYE+ehdOZyCZonw1nYsxNMaPg5EQhoDGdvbgD1hdw1qtVVfLvO1hQmDJu0GJodDHnQAgohE37oA16Q+R8mMlkd3w9Qwag7VXMdAByqhYAWQG9AapIVApnCI2apSeRsjWlv4CRiDupofmZzp28QgFYLubPAatoVE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpYqPm1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpYqPm1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0C1F000E9;
	Sat, 13 Jun 2026 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781345051;
	bh=sKRZz3eM03GN/xOHuGAmYoueXVkDL+zi44HtnJjU/Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TpYqPm1yq0AvhRNInIy+ThIUmvw5H8qA0W4P+wMOj8h1MSw9qTRAhyvtqdsL6EJ41
	 KDqZjc3NzcpHKOOWyESqmosBIx6mZZvOkQdkOI6qJ6mneSrHrQVfaI4yDRX9LO8xyS
	 tYkoveCL3MaCo6iOkmHKO9Q1nA+dCcMo/9Vh9LqRT9R12VyQFHDwmwqMY8JEJNEsWl
	 nvW5ImRlfRUT0uy06/snjM5+QrhMr0inqgwX6U4dkkCvCh+gDAzFBrVj34cZoplq+n
	 FRZHsib//EQIPGLmT5xE0TEINLhpqbW+RdE0RC99TNXe8/0AUnpDCiXvHaqhEFBe2X
	 BwlJWTOubQGnw==
Date: Sat, 13 Jun 2026 12:04:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@gmail.com>, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [net-next 8/9] dt-bindings: net: renesas,etheravb: Add optional
 gPTP phandle for Gen4
Message-ID: <20260613-caped-ferret-of-philosophy-acae13@quoll>
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-9-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260610102432.3538432-9-niklas.soderlund+renesas@ragnatech.se>

On Wed, Jun 10, 2026 at 12:24:31PM +0200, Niklas S=C3=B6derlund wrote:
> The RAVB module on Gen4 have no gPTP clock as part of the RAVB module
> itself, instead it relies on an external system wide gPTP clock. The
> gPTP clock is shared with RTSN on V4H and RSWITCH on S4.
>=20
> Add an optional phandle so that the RAVB driver can find and use the
> gPTP clock. Ideally this should have been an mandatory property but for
> backward compatible it is optional. The RAVB module is capable of
> functioning without it, but can in such cases not provided PTP
> functionality.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  .../bindings/net/renesas,etheravb.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml =
b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> index 1e00ef5b3acd..7bc910ab3ae0 100644
> --- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> @@ -122,6 +122,13 @@ properties:
>        Specify when the AVB_LINK signal is active-low instead of normal
>        active-high.
> =20
> +  renesas,gptp:

Aren't you duplicating existing timestamper property? Aren't purpose of
both the same?

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to an external gPTP clock for Gen4 platforms. The proper=
ty is

Explain the purpose of this in the hardware.

> +      optional for backwards compatibility, but without it gPTP timestam=
ps are
> +      disabled as Gen4 have no gPTP as part of the RAVB module itself.
> +

Best regards,
Krzysztof

