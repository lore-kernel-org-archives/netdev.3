Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62943802B;
	Mon, 10 Aug 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386935; cv=none; b=pY36XyZE4SoFN8C85porNq+KjS29CBZ6wLcxuDZ5uWSO5s4TzAd5l9bAadGYngHHvQ3p6e5/m+4NhFfXOhZGpDZOO2vxse9FMrgit8DYJfx1efO8sDLUdhv+XOt6MpHsXV76qR+/lbttMydpi+8tPxJ9pjzUAOtLXvPE3zefQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386935; c=relaxed/simple;
	bh=nvuI13/LGBv0RGYETa+J5+rfACdZHAHlV+Vu4HnaQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHJG3YOd6k3crOxMsznl785u0VAgaj5BsnwodO37iICpyhjBPsqCzFS3qevga1eXLUeei8yPd4ai8Jr4gLbLlx5wfO5ajkMm1MyBNrMWbiC/oR9PJUbCvj/eaH54SawKU6DL5uay9b3kXbfXle1ccR2r+NieRv7wHehI6KASNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYmWygaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYmWygaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757FF1F000E9;
	Mon, 10 Aug 2026 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386933;
	bh=tnho4rrrB5eB1gkI1817NuCvPB/07wS2vcTVe6IMdjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYmWygaBYAucXKZxr787sYh3qGARvpJY86Je5DMJbNxZnDYa7l4yTzD28oj2EN7My
	 o16ZB4rA22AlKYA1iX9FaZmrfdsNTTCRTV/WPlPJ+6NU/tSdl9trogupy27ac8akVw
	 W1jOqDlWA8sH77vJPHLrtw6E86dVQl2szMWzkz/N+Pn21+3nd0BYPRu0vrADgp1aZR
	 mXeB39csRtttxUctgTLpcq4/b+87TcJ/JiL/l+vE1aoILzVQeZ/fJMzc9+zpd+N2bC
	 1U/Rz+ddRw9ycDmW3gcRoKL/nZYv4fIDIb3qawaUhEkTHEwMD8kW9Lya/1AXaY6amD
	 XXQqwkfHzAXJw==
Date: Mon, 10 Aug 2026 13:35:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: conor+dt@kernel.org, mwalle@kernel.org, richardcochran@gmail.com,
	richard@nod.at, linux-mtd@lists.infradead.org, pratyush@kernel.org,
	nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	takahiro.kuwano@infineon.com, miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linusw@kernel.org, vigneshr@ti.com, srini@kernel.org,
	linux-arm-kernel@lists.infradead.org, michael@walle.cc,
	krzk+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de
Subject: Re: [PATCH v6 2/7] dt-bindings: nvmem: layouts: add Microchip/SST
 SFDP EUI layout
Message-ID: <178638693216.2623305.17648873474456731679.robh@kernel.org>
References: <20260729043026.1811147-1-manikandan.m@microchip.com>
 <20260729043026.1811147-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729043026.1811147-3-manikandan.m@microchip.com>


On Wed, 29 Jul 2026 10:00:21 +0530, Manikandan Muralidharan wrote:
> Add a binding for the NVMEM layout that exposes the factory-programmed
> EUI-48 identifier from the Microchip/SST vendor-specific SFDP parameter
> table (e.g. SST26VF064BEUI) as a "mac-address" NVMEM cell, and reference
> it from nvmem-layout.yaml.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../layouts/microchip,sst26vf-sfdp-eui.yaml   | 60 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

