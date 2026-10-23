Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786093;
	b=rcLbVVJmLiZJSbOknQhMiLYJ0u25jlyp2LG5C3Pp6PEVUJVlwI6LmYA/hXzn6VUUBuA7
	 wwBgT1Y8wlDz4e9Nwgn98UDblXQ9IC2j9A2030FAZfhavnn8TfXWb2x3kYagzClRlqvVj
	 fqhG5sXrIk+gYCPEPBgeOytFLid9qQzdW8Y/qZPEV4tt+v03ThXMhRhinorZz1p6FfQ8c
	 /lk2YGFuX4lu2n5pI+0UF9No8zfQ7mfWL+lCgFenFIsSpoivba2dSqIv9qu2nuDgG1Bph
	 ZSWbblDirG4Kj5u55l2/u65wEq0QF3WNbOUv3tce+Lk2qZ75gcEpZt/dH7BINkZ/9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786093;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cgOLbH2Bki6NsD6SDMz7gOkkaaZ5+FtQ/PhC4n/dAYo=;
	b=ImKhrKKhp3f+I0lKRr05A3EMOxKrhewbKLak0y544ck8E+zKu8bIneK3ZeOnTu4SVvlN
	 kfA/2CmJAYH959WqA8YHfOZ6MqBec0ZZp//RvDI6VOqEmzK9Ll/njgqU5tbAsRIDXhrrJ
	 4tIvmCaglDVG7KSPpy76zcarw2FY4U9zh+6pOrg2lI8P4YE/tMSBzr2dAHjgAvgqmUoyT
	 CICKGhXFkMXXA2iaQGIpdQzfFQRyKVpRTeisCuCNHoSExigE1CV+vMTCx/FfJfnIUYGFr
	 FK4lGxRK968YKZuUsRKUAMXQn2/RFMqH6Qtuqh7BBu1DbwH9PMEOTRGroSAAWEvWYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYGLg3bg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C6606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYGLg3bg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB721F01825;
	Fri, 23 Oct 2026 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786093;
	bh=cgOLbH2Bki6NsD6SDMz7gOkkaaZ5+FtQ/PhC4n/dAYo=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=BYGLg3bgeYsoQE6H05jMYgtW58c6Njh2yEDrpekYWtx5lo0RJWNjeDL82nxL75LxW
	 hXW8IFGl6+qlondpYe8lULKe49AX6LxLgbCbb0+dP+Bur8LJEZSVfNMljUSeEWiO6i
	 Oy2kp1VneoCsZk4drYWXX6wvYbspoBFll2l02Uc/SaXmlaMu2tUDh66KQ63fARskkR
	 UqHeUElrhgyko9NPN8aktZT+UEIVkCZytUozptR029OyqsqcLJUwyt6SR3HUhqNFG+
	 WVCMo3Z+BnVXhCJw4GDhIW+vbCqkLAxXeeVL0NPgcPAi/6odc8mobwTBevUWu4U2+f
	 HJ7rw3SfAaC9g==
Date: Fri, 23 Oct 2026 13:08:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Tafelmeier <matthias.tafelmeier@gmx.net>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
Message-ID: <20261023130812.1ba2462a@kernel.org>
In-Reply-To: <607851eb-e42b-46bc-928f-91db542fa9c0@gmx.net>
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
	<20261023123102.3c30d01e@kernel.org>
	<607851eb-e42b-46bc-928f-91db542fa9c0@gmx.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 21:32:40 +0200 Matthias Tafelmeier wrote:
> On 10/23/26 21:31, Jakub Kicinski wrote:
> > On Fri, 23 Oct 2026 19:42:25 +0800 Jiayuan Chen wrote:  
> >> proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quota
> >> to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bias.
> >> The three sysctls only have a lower bound of 1, so the products can
> >> overflow int and end up <= 0, e.g. dev_weight=65536 and
> >> dev_weight_rx_bias=65536 give a backlog weight of 0.  
> > Not sure anyone uses these, maybe we could cap them?
> > 1k for dev weight 8 for bias?  
> 
> Capping does not make sense to me.

Please don't email people off list. 

What are the values you know of being used in production?
