Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979602;
	b=VNkQ8aIbnyY3YKwz9cBrFlFo4/03i/M1NrySLYlMHfjg4gecueG0nBQ3vvcDKyc3gnZd
	 McxgVPrXaUJ5y3tv79nDoWtziwIu6VDjmw5Hens2HlKaszmBdfzuEGhyfZ6f4F0CclmzC
	 +6YRIix50NS37c+hDIdHOdylwsIYL7od1guYxxDhSpxyVEY7aGyUO1SUZMnrKIt0iNPAf
	 rPwoBt4qixZwR8QNRPrm+tz6L2had3PSS2Hi6gqWaYEJzEToa3vRC6AIzqWIeSDyxoTM+
	 Q89kqA5HySzIWGxWhJW/b3lUyYqfmCnEPbBvUNDZ4AktcZE1P/vn5tYU4uyIFMzlEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979602;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iwdgIx7J6utbByu/tzJEP9ao97I1VYFNIdA8k+gEW20=;
	b=bntHNeEjgAUeVUZZGaY76frRpoSonTaAb2Dy5Crb82NLbG7EVEXW7IMBLasrN1g4kSWk
	 nKSPQZoaAvqwCMU66lVRUnXwiye/u9Xv/xAR5RmPTfayVhhyv2jJBFnwvFPh9wsbfSzpu
	 JrXNgfUNQNONoSIjQQerQL1wmADOU98Lk5oavf04QK0yeJdu9E2HgreHjnnabMh5VWAOH
	 xFSNgDhucYFAGSz3t2IzH1JUtEFXY0/9AoPRdUp6sdQ4xnzic8g9J6wBWnDDRVx90ZABv
	 U0qP/matkCFs8hf7z8GEjpvt6otWpyuAl7XD4PgyOE4viJQDSMsYbhQvNZV/1yI6L/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkmrKgmt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1D606A326;
	Fri,  6 Nov 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkmrKgmt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9401F0089F;
	Fri,  6 Nov 2026 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979601;
	bh=iwdgIx7J6utbByu/tzJEP9ao97I1VYFNIdA8k+gEW20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HkmrKgmtbPBSt9+Z2ispkTiD9HJedXlXgRPSQiLFHJh/MrwPBYT87kZHP12AThWm6
	 3pDrg8tOhv8lqJl0YrS4Il6XoIIWxOMkMArX+ezirArZObQk79PbZt0Bi5SuYgGLIK
	 MpWg9ldrPoSJTWV9FinBwe8k22iBq85JJ0ZO2UxkYNmI340M3nuauhgm5B8LEecW6B
	 d1g3T0TTPJ3asOHDbj0kczIdn5o7q9XuXf7kYshJqb1Ib9euX9JFNshYbHStucNSlG
	 ptdNnujdOBtUFZAtL88aUNvw8SNDvgiMgSEoLH8WfVK+O6lnNfFoU7/8zsIDwVCn2A
	 DswxFREztQkoQ==
Date: Fri, 6 Nov 2026 09:39:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@linux.dev>,
	linux-renesas-soc@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/14] dt-bindings: net: dsa:
 renesas,rzn1-a5psw: Reject the "ports" node
Message-ID: <179397959710.3654179.6885625518665577929.robh@kernel.org>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261104182105.1102555-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261104182105.1102555-5-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Wed, 04 Nov 2026 18:20:52 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> dsa.yaml accepts either a "ports" or an "ethernet-ports" property. A
> devicetree using "ports" therefore passes validation.
> 
> Replace the top-level unevaluatedProperties with additionalProperties
> to reject the unsupported "ports". Also explicitly declare dsa,member
> to keep existing devicetrees validating.
> 
> Also Add ethernet-ports to the required list.
> 
> Existing in-tree device trees use ethernet-ports, so they are unaffected.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - New patch
> ---
>  .../devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml      | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

