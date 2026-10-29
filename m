Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288442;
	b=ImqdbVr8wYcnWU3tHrx998LokExf6aXjUH6K4ZTJcW7HmC/oDKGW4grHTG3OMjq7bf/8
	 fUAIvi9v1g5weakqDsu9rwOBrV5p/+fkNPW9xEEnIwN5Bqj7TEPlDdUomzNQQE5gSj+Sp
	 iRdjQ0hWT7Gm+0s/y5SkpMipCpyl1IU+LkKQtIf2nBD0ls70tp8bCUVEne3xyAgxFHNe8
	 2MTjNED1AQijxabsV9cVgZ3VFVgJawO6h9aB11CBnguhUWhqz2OAms8SdkIYrz4EdLw13
	 LmWwjRhLMF7h6wKkMntRWOTo3XBLbKSxneVuMjdB+lFAPQkH2maVSubniDfB9vLbxqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JZ3b6uOYaWmanMHrxXUHX0LYxPXGkpVXbBJ4GITzGzI=;
	b=1G4TC3AslzsRUAWS51BRaNAMCirPCCjWwlImbyGSJ5FteYIPhc1H/0Necz6B79dSmUNp
	 nWeOFBuVyCjlPt6juXGCVBuN2/H/PbE/VOVXn5P3Qj0aIiR8VFLX5SNJlO/FgE4G01ZRj
	 r5FPyQqO+lS9rfTzf+JyrTSQLcIlIRTZV1bLuNLn9e/GVAGXqeXf+tp5BVUcOEShsS3mm
	 D6MWdAgPWbSTcrb9JwEphe3oAS04c9BE96RzozxJdLyQ2XvfWrZOWcv+0uYaikrhHi/8O
	 OgxErg3ISYIiKpx1YRKt1WZVDtAfXHapUA4cKaIvnI4UkLveDj8bvfPuqiqTzeOiykA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE0zYjef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E72606A31A;
	Thu, 29 Oct 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE0zYjef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664C11F01816;
	Thu, 29 Oct 2026 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288441;
	bh=JZ3b6uOYaWmanMHrxXUHX0LYxPXGkpVXbBJ4GITzGzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OE0zYjef0FwGlZV1Zy9CQPEj+Gyc4C43cEj+ZgdnxHR1Jdgr9nLhV0js/V4mwS6LF
	 bcQkGSjgZse346B1sNIeXb0Xk2T60V9KBU9Yde3s62j2Ubqweguf+76kehcqIfMyiZ
	 OVwHVGgCq6woJSWw0k/nE0QmgCN0temQ8CgyvyVjadB7bzYR7aH7Zez3/J+emgNZJ4
	 7IFbl6uze4xtg4MTbZDTtzrKLvjP8UHOq1Ew4Ue1rcXFS7DOJ9KYNdVmbYzAiWxFv6
	 hnQ2zApi5nIOPVFHV399NuKf8oeSt5MOPeQroy7TUnRPTFdJZfV30cTfrUusPCmsuM
	 6edLvC9SIncGA==
Date: Thu, 29 Oct 2026 08:40:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ding Hui <dinghui1111@163.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, "open list:STMMAC ETHERNET
 DRIVER" <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, dinghui@lixiang.com, xiasanbo@lixiang.com,
 yangchen11@lixiang.com, liuxuanjun@lixiang.com
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: fix DMA descriptor ring
 cleanup issues
Message-ID: <20261029084040.24c85866@kernel.org>
In-Reply-To: <3fdea60e-abe8-4ecc-bce2-672f4e3d6b47@redhat.com>
References: <20261024071319.875921-1-dinghui1111@163.com>
	<3fdea60e-abe8-4ecc-bce2-672f4e3d6b47@redhat.com>
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

On Thu, 29 Oct 2026 11:24:17 +0100 Paolo Abeni wrote:
> The merge window for Linux v7.4 has begun, and the net-next
> tree is now closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.

But these are sort-of-fixes right? Aren't these okay to merge during
the merge window? AI bots will keep reporting the pre-existing issues
on net patches if we merge this to net-next. Dunno.
