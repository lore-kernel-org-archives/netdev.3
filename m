Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462674;
	b=Vt9eqEycr4bZAMfQwBArGTv2xxPpArZkDhydoVkgy7AZFqVxFzBxDOHH0P5ALeMBsjEZ
	 87MGL7E/Ze485tLiMRx9ba1HSY9w1cHcRE6j8jX6MkX6/vkY2xA3V/V6GdQISqicZDHRp
	 EfyumXfstJ+3o0OzQQG2Hy04kFz2BHtamZSi3CmPccxu2oQtvQ3tWpQbP1xKuzSouNT1u
	 0ABAok5bjU86LrOfDx4z83+0AptYA7TwEAdPTEzDIb4lJfoShncq7eAlxYihsPCOXBR4M
	 n2254OQlJkSkLzCSAERV+B2MZP5oYcS/SBVX9WJ5kOJ6cnJisYG7qGRV/sYoBKG1SYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462674;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UVmOWR3sXmNeGfQDmakOGkm81Or8nnQv9CRnOxmTxiw=;
	b=DzMgo5phb9EHk7apSi5tX7zVFrTginGC/2aTNTgPGtirW/J8cPuv4FWLFdvqsf7U1+a1
	 G5aajRMlMshFrhtESrQn60NZNhxFNhbfMt81l2dsFQVjGev5Ax+xfVc6leiOg4m+pNiHq
	 KfDbnZXgNKN6lvyN+AhFwkIuvZqOshVCHTg7vpPiZRKQwVEkkPElCYWGWy6rP0yYTCpsQ
	 R/ssBb1ZRnU1I8jeGCdsn+CHhe/MXYDq8u7D8pl4RfW157793kROtEPf5LqV45ZB5eS/p
	 v3Is9q4gDzftcK1nDfkdpimHx1xcMaMRmF/JitHyX3ukvb/zYJe/r1y43qS2vLqWdCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB8NtbY8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACE606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB8NtbY8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6041F000C9;
	Tue, 20 Oct 2026 02:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462673;
	bh=UVmOWR3sXmNeGfQDmakOGkm81Or8nnQv9CRnOxmTxiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hB8NtbY8WvrVBLbwcOwuXlNYU/SRYzasSeIKTNUslPiJX+PyL7fP7scvHnmUaCTqj
	 KqQwniRKQplH+OUs4V/tJVxV0TCWuI8RWilgP36o9JI16gsEeErZwwRSN8weXvq8RW
	 4eRiOjl32EzWnt0mkV8mkCZpQ7ifs1C8ft/v15O4UXBIiWiZQXZGdcJLVKqfgSuyQa
	 zF8uMRAE3pCuMBmIghMM3QG9CKNfi2e4jA54yAiN10fkV08QbeZZZ9VSaWDLt1FJuC
	 UjBhLfODksNchjWCZZveXQtL2+/2wTInRzF0gOrzoJOVW2Qnr4Sc7AIsy8f4eXC55H
	 eMj2gZB7pbCyw==
Date: Mon, 19 Oct 2026 19:17:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 0/6] pull request: ovpn 2026-10-12
Message-ID: <20261019191752.14aa52e3@kernel.org>
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
References: <20261012133809.2477063-1-antonio@openvpn.net>
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

On Mon, 12 Oct 2026 15:37:57 +0200 Antonio Quartulli wrote:
> --

sorry for the delay, please make sure you don't end up with the pull
request info under the -- trailer separator. Patchwork didn't realize
this is a PR.
