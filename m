Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265690;
	b=QGTt+utCUqw2eSlC1GLxEQ1Y7I33zGGDOm1yFalp92BLi5NpixA2ERrPpdjG/qVRrs2c
	 0pe/P8xPWwHOW2go3EAcSPhjM1AYY9IBqoqgD/PtgwDHM8pF61/MPEBy15B2LrQ6CToZs
	 g/dgb+3PHmKfxOYIT8ACXEJbB3lWQMBUpcH69aGpr7XDxvFqI1+me9EYvXWL/y8SSWPNP
	 X3crUwGaCGUVBubg/TgeOmrXzwiJ2CHPmTIGhCeyA53K4Z+BrKlp205LLRhrimiHXFrrM
	 k1BL7x2Zdm6Zl03EFWGFmgQiCc3fD2+gmUgCjHEOSbrQ1AkrljQ2oVnopqrg5c07aQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E7jFmIFrIh+Py/sNWf0CgvwEQngMIkHAiYLSPl55KfM=;
	b=jcgSQuaSlqBIheYDZq9klzGulPvvq/UPu1KPJGUucodlU99fhO9F9XJd5snBWMG2hu/1
	 0JVQVl1e2XHMM9C/4YHRM5B4VT9kBLaozRQkJqvgt9Cmmfv5tMgWMpuwwy5okgQ+9KDMw
	 8UaP6Z8y1eLqkeh6hRA1i1qKFpfbao80eKE/z5L6dNicsF2up9IsBGO36eGe94OkmkCRw
	 VWDMbwCG1ze+X5dqglFv5GgFJDIb5SnhYsWwotLm06E9IZfmrDtVJaTUVrcOWuKx1qdwj
	 lGd59kpLIHuZf/yYBzgTx2lB+mNRtFBlYbRk3YiEMxVbiKvNZYz4T/SFrLvrf1IXOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAHDYrW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA846606A31C;
	Mon,  9 Nov 2026 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAHDYrW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F4C1F0089F;
	Mon,  9 Nov 2026 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265689;
	bh=E7jFmIFrIh+Py/sNWf0CgvwEQngMIkHAiYLSPl55KfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jAHDYrW6bHdLXGJGnHOyvjD31+RRG2f7OYs0aN7KpZIwod08JJbnyFk2EPMghXIlR
	 XqG6VH/XpkWpWPKS39I29/V0tPPelqXYJZa0J6e0a3MzxY4qe7Eu+ydzi93HwFJhUe
	 joBU5qbAYsZvCbnfPcFyPT+EtULY8XS95Wg4JleVfh3Qp3zxxXp9JRW8n95h7eZKJK
	 Apjo5Av9bEdi14kN6Wgb4cCXMvWmD3O70eC2U6wZ2JB0H5Cev2mFVXFvje8WFWg5oI
	 Ik0ZRHjKBc7bOj+J0x1BWZuYItY9JQ/fB4BD/IayuDIUm+954jokwRxlQggfcyAvey
	 ghoEBAc4UwXfA==
Date: Mon, 9 Nov 2026 15:08:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] mpls: reject headroom that overflows skb header offsets
Message-ID: <20261109150808.32b625f3@kernel.org>
In-Reply-To: <20261030042246.74144-1-kylebot@openai.com>
References: <20261030042246.74144-1-kylebot@openai.com>
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

On Thu, 29 Oct 2026 21:22:46 -0700 Kyle Zeng wrote:
> For example, a netkit device with needed_headroom 65488 gives an initial
> network offset of 65504.

We should probably cap the needed_headroom at something reasonable,
then? Also AI review suggests the fix is incomplete. 
-- 
pw-bot: cr
