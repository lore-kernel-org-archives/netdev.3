Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089243AE713;
	Sat, 17 Oct 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256071; cv=none; b=LDovXbduIWkkQNuZWXGfGDipI9dqRNY7omogZCqk/R0RWHU4E8ShH0qdElpFw4Zl8SA7wIet/bkWlOorn9zDJOc4cCD0PCnkrBw6zGGviRfplVmv3sPzbMbGzr+ESOkJxOLnZi8PDeyIF6rgADg8vIb7ruKv0ZqBPh9Gnjaq8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256071; c=relaxed/simple;
	bh=prHb9vyOXM9CQ0PAUZeh6pp1lsrc34WVhzENWtq6vsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHzIyzdKHRLDrwMrKEEy4OzJF/zlDXuQJ8bfC7xRYc8K4x3zFZR+/GFkB6MO5hEeui9uIDeiX2L7EVK/AJ9WQc32T3A0de8EZexxrwd3QvJ12c41E0vV6E1OoCVZcVJOB9Vg8SG1Xo82X5QEpvJYIENa0GW3oUc0cCDPYl7r+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHxmOz0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHxmOz0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4081F000C5;
	Sat, 17 Oct 2026 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256069;
	bh=qAvXa38tDPd84+C7lkRfogwkk8A6w33K16GNtLiWPyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHxmOz0Oz5sJvxsY+UwCtg9fB1wneDLkCkHoS15N91kfJA0q0HYpfWAIzIDUWXDYw
	 q+U0GrhdV/5PE7OtGvanN7VsS/k4wws1sWuDF3OBRT4W+UaGEx8Nwt8LxmE0kqQ5tC
	 4qISUcrg/kr6qXFwZQVmBoaqjHo5WW26Me+Aw9btbs/OQrl3daH0svlW+WuItK76tz
	 ie9/otyxylhM3/lFgHt6JmAhKSb/0QGYabxID1oC4OR2sdaePgpf2u/MceNvWC8dfX
	 6eZm0QNg+h0Y/UlyzZ0Q2gC0Tp+r3GXlwII59MuV2uay9toJYXeQRyTq09cwa5s17M
	 TcxMJfqnNY3kQ==
Date: Sat, 17 Oct 2026 18:54:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	Daniel Thompson <daniel@riscstar.com>, ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com, 
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: qca,qca808x: Add
 regulator properties
Message-ID: <20261017-invisible-predictable-oriole-80d663@quoll>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015143849.483339-2-elder@riscstar.com>

On Thu, Oct 15, 2026 at 09:38:46AM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> QCA808x has four different power rails (although in many board designs
> the different rails share a regulator). Add each of these to the
> corresponding DT binding as optional supplies.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../devicetree/bindings/net/qca,qca808x.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

