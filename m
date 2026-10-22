Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685018;
	b=lkNZZxkqaEX9v9QP441R6sBRve1qVJWTnZ1Hs3gcuqOSWj6FMm/1ZQX+HUhfcem7qb5b
	 BC9PA+mqUPaP41LwxePegBPBa03TB6CKuVdEJMFlZdchp9ndIrjzR4SW65k25EW9va0Dh
	 +F64yZMhIpMGeY8Krx3nPfWdoHlVaZo05sGuTAGpooFO6L30zQqFHqk3fCxTNlreRaDg0
	 R0sRWfzJrEs5OSroVBPzyuPS8hbcZnz592MKVsHlfLZ1jZJ8+L0G4JqFQjX9vOhqS7gA3
	 kQvejw1ttsGtG1rT69DCQrt3mQmIZExx/2HbArezk3Emj3jodiWMx1Ev5tV7zB0Uzkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=W//HuNQsmgBHAC4FJ+Qb0HXpj0Do6P+gozxhDR29kxLHjnRfA5bgOqx5ugFA3QFy0T9O
	 BOUsJAQqlhi/98DvcR4l21xnvRgKunjRcZQ273bhrXiO42e6xqpj4AOz83QwpUntimvDM
	 ndndGw7yMlGH7Yqs1OZrv/7fzUduccCrVTepo/E2WkUDH+5BPE4ydJJ+sBLx3LuSo5ke0
	 alu9u3nMe1Qt9rB+WDDykebnPW8So16KQQCK5IbZsTB80y5cOYx64PMIdHq0eo1dEpHvt
	 V28U7eV0D7dJBXQPfcfHBj8fmfTY3imSC21DpXYlM8fx08KBEijOHB3jnuxJGlv54Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJQ7y6SR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B64606A319;
	Thu, 22 Oct 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJQ7y6SR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB461F01825;
	Thu, 22 Oct 2026 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685018;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJQ7y6SRlYVRbxnLkeRZuce8f45fUHVEACV9An878eMFr9arXvVw5gMGsFNaLxpQx
	 UMlQs0ac/KXsTEzq3iHI3zM5kkLNQroqNfIG5XHnWpkqCnYNCleqHIPipQ2Kpm4cAu
	 PHIvfrP7V4sIGWb0aP9oAB3p5Jgo72H3nhiu3UcP5u51YcPjwkjFMWOylPzzjRoQ9G
	 2RbQRoqfY4Ip2ppPI8CGoiAkX/02X46HYV8vhox2p169F6Zzo3ouGUDmkKxWT8Noef
	 fQe8TBrTnwdXXKCjX6z6DR7dmrbpJWh0xhH0iNxweA+sNzQIYzByvJGC/Y853CGR5T
	 VwdCFN/aHQMKA==
From: netdev-bot+sinfo@kernel.org
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: 
 Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
Date: Thu, 22 Oct 2026 16:03:36 +0000
Message-ID: <179268501671.3290.6623232109527554630@kernel.org>
In-Reply-To: <20261022155837.760-1-yongzhao.derek@gmail.com>
References: <20261022155837.760-1-yongzhao.derek@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
