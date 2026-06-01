Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512F3DFC80;
	Mon,  1 Jun 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346967; cv=none; b=YOKg7ejWk/3NL9gc3dsqpFz/y3kkO8EwqWYQvongrEpvcfkmGmNdgHIMLqx+lIqc1i1q/p6JQp/3dk1lb+Ojw5qCJP/E6MTqHp9AlQLCnmGPcMHPjEE5Mcteo3UEVtbc+wUcCeb+fGisVx/1qycGYMAPARxtqEgMS4Q+6xSPrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346967; c=relaxed/simple;
	bh=BK2YJnNawqh+NLgg8Srzx+aDkFgs44fvkyfUqUbQZZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxZdwsMHexTlMNUBfiN2JEIOGwnjMB4Lh2ZkQlGIEIqmF704UUT37Xi5vy2buCjJiun2mjUPxnDH25wHr/I0Ei+EgbygLKQFA2pEuyKW7xyQBJmTOdR6slTAa10sfFp0M3BTt+HeM7Rk/b7nxO+vLZGEhBTI6Ybz9lTJTWfMuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIdpZfLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIdpZfLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6EA1F00893;
	Mon,  1 Jun 2026 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346966;
	bh=V0GxQtKPGi3kWe/Wbl8JqBVlQ2w58REmREm7T00tv9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KIdpZfLXMaB0usR/CM8uvtd7GOrP9K4gFtmZwU4SIbL6yXUYHL7HGL2cYa5YvBwup
	 COWyYTNNlav1QjSFvsWVojFeGPmxs61QE7v5sLJrWE0ShlcQFCJEFAIAn5eEzpl0QX
	 Bg2hwchpdEp/a0PgcYI9BbqRJM2fNVD4mG1U8fXUEmTBm9QA+TEynvto6LfRcp4o3z
	 tCmHzjeFfmSlMDhdvuHUEVBeizuo2yBaW/NjUzkOTiCRhfze43nG8FGm1GHtT5JiFI
	 LhWKLxNyl9GWuqmU0Pl9QPa7yk5Yd85gO0LnH0mTiCixjfjhMbSRIf5SGZ96MQvojP
	 vQR/d/bm+m8QQ==
Date: Mon, 1 Jun 2026 15:49:25 -0500
From: Rob Herring <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: qca,ipq5018: Split IPQ5018 PHY
 bindings from ar803x
Message-ID: <20260601204925.GA4132990-robh@kernel.org>
References: <20260601-ipq5018-gephy-clocks-v1-0-2df8287712c3@outlook.com>
 <20260601-ipq5018-gephy-clocks-v1-1-2df8287712c3@outlook.com>
 <178033592356.3996739.1050010038980629699.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178033592356.3996739.1050010038980629699.robh@kernel.org>

On Mon, Jun 01, 2026 at 12:45:25PM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 01 Jun 2026 17:19:08 +0400, George Moussalem wrote:
> > Move the definition for the Qualcomm IPQ5018 Internal PHY out of the
> > qca,ar803x.yaml binding file and isolate them in a dedicated
> > qca,ipq5018.yaml file. This is necessary due to the restriction of max
> > one clock in ethernet-phy.yaml which ar803x references as further
> > testing revealed that the RX and TX clocks of the IPQ5018 PHY need to
> > be explicitly enabled.

Just splitting does not solve this problem as you can see with the 
error. You will need to drop this constraint from ethernet-phy.yaml and 
add it (1 clock) to every specific phy binding (that uses 'clocks').

> > 
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> >  .../devicetree/bindings/net/qca,ar803x.yaml        | 43 -------------
> >  .../devicetree/bindings/net/qca,ipq5018.yaml       | 75 ++++++++++++++++++++++
> >  2 files changed, 75 insertions(+), 43 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qca,ipq5018.example.dtb: ethernet-phy@7 (ethernet-phy-id004d.d0c0): clocks: [[4294967295, 36], [4294967295, 37]] is too long
> 	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260601-ipq5018-gephy-clocks-v1-1-2df8287712c3@outlook.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
> 
