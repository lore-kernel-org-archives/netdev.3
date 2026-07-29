Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621942264C0;
	Wed, 29 Jul 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348434; cv=none; b=Fh70d1jIniiUtj18oJai7pZwC44Z8ZGCP2j30Tn7Jv+p3LZ0f0R8/zpGjff1f+ztSjBLIMSA/4+oz5kdSCSUwFRpuhnJP5EbkuTI95RXYUHfuhdsY6ZdLA1JrbsmnFvl8oWUGWWfvBIK9Lcp2mgaFOrq+sYiCplavghrBCai0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348434; c=relaxed/simple;
	bh=nHnPXLDaCa4Lt62WW6923t423XXWLdDqRKugD1X7RUs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=h8lXe27+oFhX2lwpdO3gYPHccd2sf+15kQEYwjmvzYUOnDp4LwEjKihDri4crGEasZGzsaxQwy8GXpRpVRZV7Swa+fNYs+eNvuc7DeCGjEoZ4fFTXtKA6tCJhxG1NFU9278u/ywhX21/eY+XIqo0ip0q9EBEsbGnbd7xFxgNqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR7FJnPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR7FJnPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5861B1F00A3D;
	Wed, 29 Jul 2026 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348422;
	bh=2FX4VAzunLlvP4EmFN8MkUWYq3P348kKelyXyud6OO4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=aR7FJnPBlssHNB2OHUB4ACC02xlJgQE79wgQhyW/0EwvqKQ5yCHXWYPRtZTJvhYH6
	 QNJsoup9kXjfXNGBEG8d+IKywdRpo53dzjytjB032WxbZunGiq8Iw/H7/Gysloxm5I
	 YgDNZpRCzX0NFEyu2ckFPxuJsrcLqvLeS2fh1/CNxwDZkTXXfawiC/iCAlbKjniA1q
	 xID8YJEffiSl5h+W8yknGS8LisvPuKNTrL8Kn7RCLf7wCpvxY+CAuK8y5me53oh4Uh
	 2Hpojn/SdZ1Lf8OUf8CRu2/9or64urUKU+OZ5cW9f3hxh2oDl5nSgEo0kbil6NaudT
	 AjCdWXGAX/VtA==
Date: Wed, 29 Jul 2026 13:07:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Martin Kaistra <martin.kaistra@linutronix.de>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
Message-Id: <178534841981.3259959.17483842007790222848.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings


On Wed, 29 Jul 2026 18:36:55 +0200, Vasilij Strassheim wrote:
> Add DT schema documentation for SoC-e FPGA switch devices.
> The binding is split into:
>  - a switch IP node describing the MMIO register block
>  - a DSA MDIO node describing the DSA-facing switch instance
> Both nodes are linked through the soce,switch-ip phandle.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++++++++++
>  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
>  2 files changed, 249 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/dsa/soce,switch-ip.example.dtb: switch@80020000 (soce,mrs-24-01): reg: [[0, 2147614720], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/net/dsa/soce,switch-ip.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

