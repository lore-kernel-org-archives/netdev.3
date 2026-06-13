Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560A3C0A09;
	Sat, 13 Jun 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338271; cv=none; b=YjsD4hpUuNs/XvwC1NnGkDhx7S3+/5IIO0h9BorLJiOQME/M45weG8mIOLX8uHFKuxp368Uu0WsWpRkiRdkseJMq6TLgBkyKL7gQ2q82+yDS5IsCJ01cutqteXXsqAPt64rSv/nUJwLJLdv7d1+whBeMNseG7B+3d057z1gReV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338271; c=relaxed/simple;
	bh=jNZaWQ7iNWumdWSuXmv/iP8Sz5qHZ6N8IQYXSpab9WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn/7Dn1tB4Xi3SX27JDNNKxTRBActztH9NJhUAOk/nyWTfV/x5s6beeljOAKSh439DgmHohjtqF7p2bYaErGDufLML91/9H6k862PQN5iMNfOv0eGleEr+TOn6ZxNZCOYK2Izv4hMF3HAODV2nfR8EfFdMcRhj7TRA4faGS8GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJt2K1Sw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJt2K1Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A382D1F000E9;
	Sat, 13 Jun 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781338270;
	bh=E7A+My7ush8hFIKJNcnfzu6zRqD8QP4Sm/86FcSKN9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJt2K1SwTu9DdwrsIbA05RNEHePIk1X7wEc9KpfKHsyf2PfNp2T4dEipBU7q0Fwzw
	 xqT8iSQXdqJehmK3ZwSl4Lm33tWn9vVzMxrUoHe1hbDvl24bBvt0BzaQJvMwqFAJ/A
	 EgEPTnWKu8hWSdSjgpwLmzvK6xbFJRwWeOqrd3A7fW7gqwumr20/RHEHjd8QDdKFBW
	 Go9FWI2OGPth2WnBvUMEeWdgISzSMyK9Neg85AcXV3NlGIl8yuW8PKVkMD1Al+JUm3
	 sBk3qsLkp6CWAFKpPpjkfH+eGL5v+5uOaDR556gO9XgBk0JdX8+l/LszPVPRDsdgGV
	 SUyINa6/nu3UA==
Date: Sat, 13 Jun 2026 10:11:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"DavidS. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: ptp:
 renesas,rcar-gen4-gptp: Add R-Car Gen4
Message-ID: <20260613-perky-omniscient-buzzard-c3b4da@quoll>
References: <20260612092851.2141782-1-niklas.soderlund+renesas@ragnatech.se>
 <20260612092851.2141782-2-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260612092851.2141782-2-niklas.soderlund+renesas@ragnatech.se>

On Fri, Jun 12, 2026 at 11:28:49AM +0200, Niklas S=C3=B6derlund wrote:
> Add bindings for the R-Car Gen4 gPTP timer. The timer enables accurate
> synchronization of the clock in the control system. The timer is
> system-wide and used by different Ethernet devices on each Gen4 platform.
>=20
>   - On R-Car S4 it is shared between RSWITCH and RAVB.
>=20
>   - On R-Car V4H it is shared between RTSN and RAVB.
>=20
>   - On R-Car V4M it is only used by RAVB.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

