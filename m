Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957970;
	b=coS3KeFclmANkU/WR5rFnxOkI4dThaDUR+scDMTZZzCSuvy6/GDr6/U8+D1nULX7eReP
	 WUg9OuktAUVI5QkBtzPerkzZUV7r+3t8t+J3l9zE2HckxUKXvWuLC5/pNHQrxa+mZhb4e
	 Goufvy1Cn5WROY5x6LooraEfq5mYdUeBEzgneGtvIDTx8g0bvT3u13gM7AjbWFnNp37a/
	 ZPnJkasZ5R/QxIzB5NjnoHZm9Sa276mewTJMl2eg+eDjx3biD3OnJpHzqQ16yGG3c2Ypl
	 chWKXrZ1ob/nbFQw1sZd4g/eLVHCMJ13vBSvJORHDiplpsO4wqQLCl71IOwzLWJxlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957970;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=yhON3tW44fU5t4y/jeOWzoOXS3rC7qPP8yVNNJLOJKQ=;
	b=aBHjFBHnXc0SBj/rfG0qM0VXHpr8DHGgL+1LfhD2Yo/7uVvqtnx5Tf8jvf1mEylr7nuL
	 XSDPVlNDFVhIFyEU6ru51yFeA/yLt1D4jgGLl5Sb7jMcCC4qknKqHDg1HFLNhHCa3Zqmh
	 ez4nyRq76rs2WSTGybSITjK4mwMsNSYnBcqw1GtcdRNy/ufmY0naUhqvx+ETTQwjK0pQA
	 ipAK+5KaCaPFR6VVuWZtiIegJRr/6S5iJAL8hyMcLURalaLJT+XByTRYKi3eyueAIL0NC
	 ZRBb1AGBLbTjcu81zWsiLI0bnlHD405JxPB8UgQiZEu8HvUn90br0GK0Rg+qZ91LknA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwP0Mu4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74418606A326;
	Fri,  6 Nov 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwP0Mu4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C473D1F0089F;
	Fri,  6 Nov 2026 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957969;
	bh=yhON3tW44fU5t4y/jeOWzoOXS3rC7qPP8yVNNJLOJKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jwP0Mu4M5SGZwM6SiSlf8StkmvsDIlT7a/5UuEjKZ9csUQHrs8CB3I/aU/LhbTP9N
	 VrQm4g8gV/friy+55NpC6OCypJ9btNaFo9y0SuPVyYl/EoaZCdFqgv/CLeQVal2F3e
	 DT7AXajX5jU/PeOGIGA1j/GGxuZzQDYZwtmtiJ++gB5idfAS1az9vvK4WEWtm0wFbZ
	 VNEMGOm1xEkBLyGHtwPqA19VRMhGFG1SPXHrRQDWDo7nr0WOxw2Sj5c3o5y2hKEVP3
	 S/p46J7UEh44Wn/GH2kTR2SLQiJ9RPcl0L7E9okkG6wH5lJzxdSiBjXgIbh4NmuHL2
	 RVCV+Vc76qWqQ==
Date: Fri, 6 Nov 2026 09:39:25 +0000
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
Message-ID: <20261106093925.GC865646@horms.kernel.org>
References: <20261102215806.13723-1-rosenp@gmail.com>
 <225a66e4-e1a7-422b-8546-5cf7a027e063@web.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225a66e4-e1a7-422b-8546-5cf7a027e063@web.de>

On Tue, Nov 03, 2026 at 10:26:21AM +0100, Markus Elfring wrote:
> …
> > Remove the feature flags and the fallback. The stack then computes the
> > checksum before handing the skb to the driver.
> …
> 
> How can a “stack” compute anything?

Perhaps your assumption is that stack refers to stack memory.
But my assumption is that stack refers to the software stack,
or slightly more specifically, core parts of the Linux
implementation of networking.
