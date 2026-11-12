Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503682;
	b=K7/1JcQi0DIUfbJmaWZtXJhONCfslSGbfqhCnDeH8rPqqFs59ZXp8z5U6UXRb0SPMeBF
	 SQ4dQQ1Qs9k3pGaAgTqWS+7Ad0lbcvfr1SxRkvW7BxbTVWTIllojChlKlaZMgORalLuI2
	 +E+o2P/TOmOx1Vxhj9yUwSqKII6UVRrAj3izUKr/mkWd3PcyRLfqspZt5K2uXEd/B6uar
	 GzB1LMho5vqyQ14Frj2578l5YsCojewH8VM3Q5seEfokHbI23k+st8v0hSDsU9GcFIjXY
	 CwHKeAduzHpotH4iY6HtbiHhRS+xNQR0sarcd1UzPItBvK7v4YjYfh+uMVAbyE+JC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503682;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q/PxZ8lZaAVCqma1b/zhvt+uLwWkqil2Tw0SQ+kAD0I=;
	b=WjnZg3NC1R1T+Vaxafb2Mlc42mgeHTyrGu29LA0tJSPEbvhy3xCgFQh9pfVYZkBtDHGK
	 CJubMGQsFQMQy9BDov+YPz/En40kiRcCJzsLnJV/NKchyAsi6uimTMdJcpIjxGLmwbdyS
	 BOHkkiEmMwNwVJeEBYXUWUZZ0xtuo5Ui5HRgSevXI7yunE0dU6NyDAUY1jubY2EunsUvn
	 k+ciJJJIBNhTZSWxe2T5zOycQGB0dc2QktIuU2GU4ptToey8HZYd4YXGJIrCyWjz5F2cp
	 Qgum6vud4UNjZjj5mQ1c1Ju9pFZ6069e2v6CyNO/OsSKrTz0aJMasxrvEvs3yQIwNKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYgCdCDV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15165606A331;
	Thu, 12 Nov 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYgCdCDV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947B11F000CA;
	Thu, 12 Nov 2026 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503681;
	bh=q/PxZ8lZaAVCqma1b/zhvt+uLwWkqil2Tw0SQ+kAD0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CYgCdCDVWwGa5g/5Oior9QtHAIJklNbvdRcCcnTDaPOQggkYyZa9ybxivdZDYx4ca
	 YC/UGnYebVlrMe4AYSkaPMRpd00yA4gdxBW2bCZ15HN6lpH2wt22bboNCuWsQpIaS8
	 9X5djGDLqgEt+wv/lqW21Q7+2trlmJJyHQ9xT5flPAN+qefBaPvPIRNb+ArLgl5aQU
	 XwkqDmigicPRoY3VcuLbd1pebqFbxx0rvmoLOCVUtBMFogs0DD0b/KJWbJIZ/J9m42
	 8DkG0x9aoXNn9okr9XrMUJ5TLfUiaweYJuHU+5HL9utZZxELxV69lDX0WA0ZmDqB4+
	 cabS+awA6knDw==
Date: Thu, 12 Nov 2026 09:14:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] net: bcm4908_enet: TX ring and DMA fixes
Message-ID: <20261112091441.5af5aaf8@kernel.org>
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
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

On Tue, 10 Nov 2026 00:56:53 +0100 Kordian Chmielewski (mlody1212)
wrote:
> Kordian Chmielewski (mlody1212)

Per kernel process docs the stuff in the round brackets is supposed to
be a sponsor of your work or your employer, please drop the nick name.
