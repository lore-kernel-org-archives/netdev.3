Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376442;
	b=oA/t2YwJxOB6FS+FjQSLEKtsfUl8GhGhE2RiCItSl2HEDx4hndRg8qs6DqiI54KNIvuG
	 6YZRG6fqPlLSnDQGi6YyXRQ3EboWQ0kU6vUjUOmDxHN3AtB+LoD4TVOagF1B1j30d2nMO
	 pUpFJ/TqtqQ/zKZhcb+nFqSA73P+JgzHLFH402AKMmJ3h8il4UQiycWeJBv34m9P8FB1L
	 8IS+EWI758O6GEdwXTBawetzmGA1WZ/Rl3f0dg1G6qhhXJWcHG3uHbu633Z+pWV7F+HJu
	 pE39VSbTpGGY903AcMYjc82uVh3JP+/9/xdWt4b38SA6XQf/8GsnxInGwHFYKDVLaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nPpHLJ4qd9XxaPO/9JWF3hf75s/PqPCDv9wRHXposPc=;
	b=v+G7zsVRre3xp/sccChEGddzS+iz/+NlCN4OfLgZjwBwR+oAau+CZmOa3pGUoR20D/IW
	 f3pohEin40PSUek5afjdHrNh8QuT5cWPNZyT0RoAk+z3uwD7+QiM4BX42rSmZcXvEzwF4
	 +/7lT7eFq/BQu86pqoMWILEaRXV9hyV2pG4quogQaUVsJMQ8VRLbEK8LlCofdDVt0qdef
	 5YzeNUQBpnQ4HhFuXaozYatgbVjU6DKJ2atU+DYb2b2d8LU1tXPsH2Rlcf/VrGPDB+BnI
	 RNv0XrXM5BIpWtxUZVnDo0FudBcFGAfY0zhbuAYgvR2PCXTp4IP4Cj1EZA/2mE7oomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAHAhC+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C4606A31C;
	Fri, 30 Oct 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAHAhC+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6F1F000C1;
	Fri, 30 Oct 2026 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376442;
	bh=nPpHLJ4qd9XxaPO/9JWF3hf75s/PqPCDv9wRHXposPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IAHAhC+5ab8Be4EWDzIFytdPwcaO2BaKu768QtsliGZlbfObKsSfIRBXjTDkET0M6
	 iUil1qIYysMUup4ePLhGR8XfOYpACqcufxv8kn7tJhaDk9/T5IVQ5sB1bJqLx1Fo07
	 Z8tQetHwfx8hl5yWGB5juoop6+VypS/puGs8uaD1D1PwYIkexQpckf0djM2yBegYf4
	 PGCZLtPkZxjght3+4EaSufQ6S7fj/HuZ2qbub9ZLW4AlHoksJpmRm6eMqwflq8qLBR
	 ZQsTWOp8krs9ubrAx4HwS1TAx1qSbB2qSFdExulqVxS77VCV9f4yZHOamE964ChxE3
	 rwv6CRdF9WN0g==
Date: Fri, 30 Oct 2026 11:07:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
	linux@armlinux.org.uk, lgirdwood@gmail.com, luka.perkov@sartura.hr,
	broonie@kernel.org, lxu@maxlinear.com, michael@walle.cc,
	edumazet@kernel.org, netdev@vger.kernel.org, lrosu@maxlinear.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH net-next v3 4/5] dt-bindings: net: maxlinear: add
 MxL86211C lane mapping support
Message-ID: <179337643788.258893.14486775212331901455.robh@kernel.org>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-4-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020093655.344585-4-robert.marko@sartura.hr>


On Tue, 20 Oct 2026 11:35:37 +0200, Robert Marko wrote:
> Describe the optional board-level mapping from physical TPI lanes to the
> MxL86211C analog front ends (ASPs). This allows DTS to describe wiring
> that differs from the hardware reset mapping.
> 
> Select nodes using the new property so invalid uses are checked even
> without the MxL86211C compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> - Select nodes using the lane-map property so misuse is validated.
> - Restrict the property through the negated compatible condition.
> 
> Changes in v2:
> - Define the lane-map property at the top level for type checking.
> - Describe ASPs as analog front ends.
> 
>  .../bindings/net/maxlinear,gpy2xx.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

