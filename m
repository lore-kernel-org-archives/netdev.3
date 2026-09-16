Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892950EBE1;
	Wed, 16 Sep 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572136; cv=none; b=d0pfVJumYaVOuaFME4P4OptxQZ3vdUbwmdGyszaPP4gzMdB+dR00bxNvgywI0t/iGKBe22vZvuzNJI+jK69GFbGcp6YyOor9nVd9yAk6yGUtfuSTocO1En/avU+ADjXZemLhHuRr2j9Bm2jQa7ZzF36mnL6+1np/ONH21pr+FjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572136; c=relaxed/simple;
	bh=/74fbriUjnNYQSIL/TkwoUOLa18GcCBPLdSkiQqjEyU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Co/dz/o+0E8XQ6+sCKnoiGluPEhocMZ0QGGVanjbqOZoS2dOoPhK6PrMm78c93Ds0tBMuYBSPKQTWAEsCQOBGWwJDdjq9/3nsJzhJB2zS0JDdeum5osjfTcWLgXjdgAxvphuy1TRdibAb7LAxrO2xGPNnJu9DXe6soqB8j8Dnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffuR7+/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffuR7+/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67061F00898;
	Wed, 16 Sep 2026 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572129;
	bh=YBWDwJQR8wUTVKxZlLHIc0nrXkBF14Uq3ojJa3l7PDs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=ffuR7+/yGysUibXuulYHQ0R8B2p31GzrCYIsHW6Vm+ohY7O1YyuMbUogYOyp/QUdw
	 IpDVRDq1PPqO5NuCdQ1BBRATgbu44wbIB7l94r+0e0mTmfGSA2RVFX3W0PH8Jm43kB
	 oxltHTOo+tGxZFcY65WEwfx8YRXFczyaZAxgFHnU2qEM7vFckSqrLJvEb/unak0Id/
	 wcJ8C8rskEi/IryIAJOJ5hHedf6B7CdiVs3cMBOrMz9NP9hauWqQfjxZgMvinuYtu4
	 nn5374NuW6pu+tpU7F/2ChKgH3au8e59tsV3fgScOB8DwuH9IbREKMrrgwDw+yICDT
	 Wova5UPIMhUSQ==
Date: Wed, 16 Sep 2026 10:22:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: pabeni@redhat.com, andrew@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
 conor+dt@kernel.org, linux@armlinux.org.uk, jianmin.wang@motor-comm.com, 
 hkallweit1@gmail.com, Frank.Sae@motor-comm.com, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
 devicetree@vger.kernel.org, jie.han@motor-comm.com, krzk+dt@kernel.org, 
 edumazet@google.com, andrew+netdev@lunn.ch
To: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260916105504.3262767-2-kyle.switch@motor-comm.com>
References: <20260916105504.3262767-1-kyle.switch@motor-comm.com>
 <20260916105504.3262767-2-kyle.switch@motor-comm.com>
Message-Id: <178957207169.229437.1349790786679674746.robh@kernel.org>
Subject: Re: [PATCH net-next v19 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package


On Wed, 16 Sep 2026 18:55:02 +0800, Kyle Switch wrote:
> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
>  .../bindings/net/motorcomm,yt8824.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/motorcomm,yt8824.example.dtb: ethernet-phy-package@0 (motorcomm,yt8824-package): Unevaluated properties are not allowed ('phy-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260916105504.3262767-2-kyle.switch@motor-comm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

