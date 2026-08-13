Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5742E8F4;
	Thu, 13 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604119; cv=none; b=aDM8CMAzFVY+l8QlQ52dKwU1nJqXnuL9URagSJ5QCzM1TpsExzKp0q/gd4BMsi13kAvXelr5qxVLQ/zBzbcmmb7/ZMAGutAA9/wqwrxB58/11MrV2MlZnMqPlqpzILrOnEUGvNDKlkDJ7RtR1g4C7Ku1UWWncmRoYEF/HKbXDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604119; c=relaxed/simple;
	bh=3vwFmrrGCR3YkObOuvhf9Lgers80BsF8rWrvEPONVK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt/wXJ+rjzjPnMgsJRS5ikAu58fDafHXwTOB7a/Y/hFiFXmaQmFobvPC2BqvdBHe+1nZ9/BSC0R+fMpSsFd4F1fhL0iJfZy4Za1nnScfpfy5T0YG3rE3Gng6+yFg2x5PmZF832OIe3V+rXFkkreW6tF36OvLZTI/p33Wfcj42KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0flWSWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0flWSWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB01F000E9;
	Thu, 13 Aug 2026 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604118;
	bh=pxqrLrmBNsHdJvxSaSy4scNxAEUrioq+nbbAEk7sQWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0flWSWE6GoygLu7Ioy2ytjP5WVSZed8iHNrLPD/ptq+ATOBTKZRZX3Bakqct/9uq
	 XZALnjWTH9r9gg5dKxQrgfHXykCYwci51pe96rpVNtD2aqiZ7jKWg2Kl02p1hv4LL2
	 V/+Lp0Tb/IJZ4jMjueDdxuWbgVKs/rl40WgL3+o2+HnsVqBaiPFifVO5LH27jLx4DJ
	 e3yBPcqHCtJWSkvwDh9QqwQtCOE0h0zK0JXF1NTXzVi1yQTnE4HLFSlJ+GTEMy+tMb
	 7cauxKMBH6lgMwoDfvNSNe8yEAmR974+ZTrV/Bc2DtX2kmAyGi3Usoa4dV8aGG8pob
	 1KvQLpjcr9tuw==
Date: Thu, 13 Aug 2026 08:55:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Andre Przywara <andre.przywara@arm.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
Message-ID: <20260813-logical-lovely-fossa-fe1de9@quoll>
References: <20260811-submit-acx00-of-dynamic-v1-v7-0-03f5b91775d5@gmail.com>
 <20260811-submit-acx00-of-dynamic-v1-v7-1-03f5b91775d5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811-submit-acx00-of-dynamic-v1-v7-1-03f5b91775d5@gmail.com>

On Tue, Aug 11, 2026 at 05:28:32PM -0600, James Hilliard wrote:
> The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
> report the same Clause 22 identifier and use the same link-side register
> layout. Their package control paths differ: AC200 control registers are
> accessed through the I2C register interface of the companion IC, while
> the AC300 control range is at a second Clause 22 address fixed at 16 plus
> the link address.
> 
> Describe both variants as Ethernet PHY packages. The package reg value is
> the link PHY base address and the child supplies the documented PHY ID,
> because the identification registers cannot be read until package setup
> has completed. The AC300 driver reaches its control range with the PHY
> package offset helpers. The AC200 package instead references the
> companion IC whose I2C interface provides access to the package controls.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

