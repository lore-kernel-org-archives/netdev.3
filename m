Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2724C6EF3;
	Wed, 21 Jan 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014689; cv=none; b=iOuH6cF6jvtOez7kIrXAyYaw3LB5S7cJFVF1EFipeQbI3nq6LRkBAbhJyITsLW+XFYe0diZElOBNTOxk52vMDINBElQIgERGGt9YqisCq+UYjEYVhp/njQ9O6L/Pu6U2CP03/ahQJTep85AriVe1wQB4Vqz1K2zybe6krBHGRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014689; c=relaxed/simple;
	bh=8mVm4qk4DUumclESly4z3e748Q+xyMOgnnuV9PRkTWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBLYhFQ6KVxrXPLbiphbqvpAG6aDUAqdniZYz8pdItti+npwJsfP773gLZ3JnhI+1iibYvwIqP7d/NeAGM/blyW9TOsnEktsP4hPgaKTVMA2us5hZBrTkNTjcdKUd+tlpd6e8pgfk0Q3EztlrILVbCEmt9qhBubppnR3ORcn4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEaPKSmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEaPKSmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB8C4CEF1;
	Wed, 21 Jan 2026 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014688;
	bh=8mVm4qk4DUumclESly4z3e748Q+xyMOgnnuV9PRkTWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEaPKSmG7mqv4htn3odBzDvoMYxCrf8wG8nuzuGjOj6gVzwHQOhDSB+9e88aTciYT
	 qsu3TFfUeJKMPV2hl7D3ZgJtNrcGc3ooptrzOM5+46CqLcBVgFzEtcYpVfSselbW3v
	 LbPhZb34uOnmEddhlMMgzYgWnb6VlwxQAUQfyU1C84VTklD5wr2PMB6+fqeWS2rnpF
	 tVyEMTiCfVbJqSb/Nyr219PVtkQ8mMUcyHiPRz93Gt8EL+smnmj/pAXj92D3o6x7KN
	 45A+s9l0zPddJwiDwxajKdiJxDbRp923bkhLt2vSVGvtxqRH29uoMNzKIeCPcz7lNm
	 FkCSlEhTfGVIg==
Date: Wed, 21 Jan 2026 10:58:07 -0600
From: Rob Herring <robh@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Message-ID: <20260121165807.GA3453180-robh@kernel.org>
References: <20260121130704.2236452-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121130704.2236452-1-weibu@redadmin.org>

On Wed, Jan 21, 2026 at 10:07:04PM +0900, Akiyoshi Kurita wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/lan9303.txt         | 4 ++--
>  .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml        | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> index 94f4f286cef9..46a732087f5c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> @@ -16,9 +16,9 @@ Optional properties:
>  Subnodes:
>  
>  The integrated switch subnode should be specified according to the binding
> -described in dsa/dsa.txt. The CPU port of this switch is alway port 0.
> +described in dsa/dsa.txt. The CPU port of this switch is always port 0.
>  
> -Note: alway use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
> +Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
>  configured to use 1/2/3 instead. This hardware configuration will be
>  auto-detected and mapped accordingly.

Please don't send further fixes to .txt bindings. If you are interested 
in fixing them, convert them to schema.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
