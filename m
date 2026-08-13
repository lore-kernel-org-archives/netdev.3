Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33C36C5B2;
	Thu, 13 Aug 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610896; cv=none; b=amugYRIgNryYtqyhOdb/M57Xsh5OjAQwlhJ4fcTI9PvB489rPPxsWEdltYtvFhOnhFXk7ceVT+PWfwe1deTXOB17MFqhF3uCO8G+tH5anYZ6mCNcPakFjAAa5sGNrVMhqWtI82V3ArcO9szFhmrqSDVZNk6Wji/MF6G9jzR/GRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610896; c=relaxed/simple;
	bh=XAFUsvM9KLQRsbSZjor8IO1GV0DO/DzvU1mDciow/XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZxtUvH7wwtMQHbSxtRH5srNS204h5V3nUoWdz/U38lswZQ6EMr7UbxoZvXm9MS7+LGzPlelvVZ0yH/aAuiXDgQMMSD3jN+IDdemVkLmNaT3SzYYG2WgRwuTRgVecUzXYqfrn5VoBvcBOMWm3IngJKKvcJaWxsN6hH7aFUJb1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIZJBsVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIZJBsVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B3B1F000E9;
	Thu, 13 Aug 2026 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610894;
	bh=/pXRHJFv5yyGvTKAROpWEDBSGFZav+hoP3t35SjsQIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIZJBsVKwZKfl9VFLExCNWjAjBP37DQkZivek2wpSU7wDRpl04aJV+3UW48qjZ68N
	 tASiwN71caz27Vp0A2nE0yhh9ijY+U2eP+9iSHO7dbzBZfEGpzHn7IVzrT3JtZqF5T
	 DLRjIei3Qw6iPESXa1q7IxPwF1nHwxBiPbmYVORZtwWI063T3QJixpOSHCoKaZQeXV
	 4YOiP8hTXVtRiCPD4ukHVpZwwi8qkKNopkNyaRG6Hwg/OK9De+wro4Bf8L3kxaEIAM
	 guZJGBupxDwU3u8g4XPs5JQqDOLpS1bJA2vV2HEHU3xiKQXxr2kwNuQjCxO8myhAPX
	 jEmhlCDyk+mpw==
Date: Thu, 13 Aug 2026 10:48:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"DavidS. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Sergey Shtylyov <sergei.shtylyov@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/10] dt-bindings: net: renesas,etheravb:
 Add optional gPTP phandle for Gen4
Message-ID: <20260813-rich-responsible-ape-5fe69a@quoll>
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
 <20260811160200.2049987-10-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260811160200.2049987-10-niklas.soderlund+renesas@ragnatech.se>

On Tue, Aug 11, 2026 at 06:01:59PM +0200, Niklas S=C3=B6derlund wrote:
> The RAVB module on Gen4 have no gPTP clock as part of the RAVB module
> itself, instead it relies on an external system wide gPTP clock. The
> gPTP clock is shared with RTSN on V4H and RSWITCH on S4.
>=20
> Add an optional phandle so that the RAVB driver can find and use the
> gPTP clock. Ideally this should have been a mandatory property but for
> backward compatible it is optional. The RAVB module is capable of
> functioning without it, but can in such cases not provided PTP
> functionality.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
> ---
> * Changes since v1
> - Use generic ptp-timer property instead of vendor specific one.
> - Improve spelling in commit message.
> ---
>  .../devicetree/bindings/net/renesas,etheravb.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

