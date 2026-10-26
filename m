Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036054;
	b=w1gWTyucyVKbT2fY21VwVYi3v0BVbjC6SdsJq4+JmS0ZL+2xLvedKW9QeFgEFqDGHEmK
	 cFndqtz/ZPr8r2Pulw+TkYmt401SQXy4scd3Hv+KWXnWf3b+2XIG8yjR+GjHxC2k59uur
	 7ZDopYQaFKvlw98Kkiw6A6Y7v1Ogor4RmZJL3tdD+9aMv+N5oC8ZX4V6fdUWPczLcMHj6
	 7Tzz20KxK+Ieh9cyu8H4McedFtWFeNqjWPyg7uF9cd05Fm0xboCbYfiTxMZgwbMDpbG7r
	 HoxxuwHId0Pet6Kk/M4hWqUFC5w2J7K3MN9Ew27UXdAbjEAaqcRBM4A/5QqRoT761VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q1ej1nI921zqZTetq4Op+sq0CAILM6bRn6dONLYm9t8=;
	b=hQ+Kn2DjVc0UhPoDmBup/ledOEtP8tCpAHZ0erd8O5qHPqk3MdF2PEHIot0vy5RQugTJ
	 v4XKRF/0E2GEdQLnDVdmDZYu5rQcAFMmevK9a0WuvFTSI5Ir+adr2MmwzRcI0JS4k4zAP
	 yffATd3ULbOJcseQ64ouxQhq3f5Mm+/kJUWB/4/SO3LAuzx51gW6O/Mm0fpgpfMTsWBIy
	 n1HVZO8UXwuTns3qlbeXb51NxOsheCoPilbh3pdpeBQ1lC7Z2oIYai5Y/7KXFfhNGaH+n
	 w5kWOXXFktUBC3G8DBKfsLMHqW/dHu49MTKcYKxVc0dLmBdkWJs2XUlajRIdipplcmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEmSR2UH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E200606A31A;
	Mon, 26 Oct 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEmSR2UH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9863A1F01825;
	Mon, 26 Oct 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036053;
	bh=Q1ej1nI921zqZTetq4Op+sq0CAILM6bRn6dONLYm9t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kEmSR2UHhYustbnAJvsaPyqu6tDSR1d4mUrs9X7HWio2O0Y4pZROm6WSmEhbdpto9
	 TtxWw1JhuQ3x5iuM/rWNPSxH5JNwT2zdQRevQgFtrg8Ky1CbzZ5etC5h1jogvlHgTj
	 CdySO2jlhgMNgGkdjSNq6V6LH7ibs6aUPghWDJzdy5n1chIqnEXK8RpRXI9a3lz8vb
	 C4ZTPzpDzFn6RHdNzIebh4veTGfw/eSCxvoIk2Xgad6XjDn7mW6w+dK6KRqBwZDkCi
	 5SrliKY/wzhXdvePY9cjwRbtU8D4d1nFCA3aWFgAMI+qtebsyVc/u0vsck0BvctO2i
	 TEbngqPKmAlKA==
Date: Mon, 26 Oct 2026 17:34:09 +0000
From: Simon Horman <horms@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] pppoe: drop discovery frames with no MAC header
Message-ID: <20261026173409.GL257209@horms.kernel.org>
References: <20261023080002.221332-1-qingfang.deng@linux.dev>
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
In-Reply-To: <20261023080002.221332-1-qingfang.deng@linux.dev>

On Fri, Oct 23, 2026 at 04:00:00PM +0800, Qingfang Deng wrote:
> Commit 8540827ebac6 ("pppoe: fix reception of frames with no mac
> header") drops PPPoE session frames with no MAC header to avoid reading
> uninitialized memory.
> 
> Apply the same to PPPoE discovery frames, as both functions read
> eth_hdr(skb)->h_source.
> 
> Found by LLM static analysis, and reproduced using the same TUN
> injection as described in the mentioned commit.
> 
> Fixes: 8540827ebac6 ("pppoe: fix reception of frames with no mac header")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>

