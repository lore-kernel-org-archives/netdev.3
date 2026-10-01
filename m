Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACB3D47A0;
	Thu,  1 Oct 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871946; cv=none; b=XK6eaQkeVcsWYVh0E9TaHrODTv0frjOuMWuWys0PX6X1rQs/2wLHv6Kw7ZNN6qrLqZE6nd7nfCCQAjDj3i10mWfTFW6zeNI03MpcpV34Mm1teVkFOdu5MS5oAkqnxnLZ23zUCR1vdW/VNIiS5vaBlytUyi7n7KQc+atll/bPYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871946; c=relaxed/simple;
	bh=875grvOkdBGnvGuOme3BIQ08plA4Mzm8WzGn/8ixbXg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tGmr4lwqd4CBgXtUxOjxDeRXCm+8nPg4NJ9zUW+FT3uvc6X9QQDzt8AFe7XNbkQ+S/NZftGKlctpPKC/KuDTo1PCXmEZRw9ne6kzIdAZk7PyIHMs0L4uh8UvvtOnWDI79yjmBrjxz1Sx8hszCAuo4zXkfVWAp1mGIE6lb8tHPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM39+Epy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM39+Epy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D91F000FF;
	Thu,  1 Oct 2026 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871945;
	bh=3SyhMfDJvhnI48fc2ca/hNNMn/uco6vms8m7DHNBqZo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=LM39+EpydfTwGmWZMYKdL6rbLKgPhF/Dtz7roU2+Y5nde4/0fn/XLZGTMMtCw+ts7
	 Qg+fF+wcAnqRZgduMk9HTCKa2bvSkZodEZAP9rzBuzRulFGywfKAJ+WxCD4OvH9Bwz
	 Iv6nTt6HU/fFi/923CXjiUM6VQWn4/n533y/gUEElrnltg2xgbZlJ4/KIgTcA4qi3r
	 mV/3lfoAZj2F1ui1RTcSsXifWtj3qDECGLnVb3TODMxxQmk9MRv3Vm3C6xK7DDd2Qo
	 SRsf2LZMDHJjIFvAo+yN9c1pEWE0dBqd4IQB/V3zFNpx7uNSId+SC/X4kWtGOr83Sc
	 3cMYbzdZxoNAQ==
Date: Thu, 01 Oct 2026 11:25:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: luka.perkov@sartura.hr, conor+dt@kernel.org, krzk+dt@kernel.org, 
 hkallweit1@gmail.com, lxu@maxlinear.com, devicetree@vger.kernel.org, 
 davem@davemloft.net, andrew+netdev@lunn.ch, michael@walle.cc, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@kernel.org, 
 pabeni@redhat.com, kuba@kernel.org
To: Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20260930122305.293686-4-robert.marko@sartura.hr>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr>
Message-Id: <179087149240.849224.16132566481274113887.robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support


On Wed, 30 Sep 2026 14:22:16 +0200, Robert Marko wrote:
> Describe the optional lane-to-ASP mapping for the MxL86211C PHY.
> 
> The mapping accounts for board-level swaps between its physical TPI
> lanes and analog signal processing lanes.
> 
> MxL86211C supports per lane mapping.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../bindings/net/maxlinear,gpy2xx.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/maxlinear,gpy2xx.example.dtb: ethernet-phy@0 (ethernet-phy-idc133.5400): maxlinear,lane-asp-map: b'\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260930122305.293686-4-robert.marko@sartura.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

