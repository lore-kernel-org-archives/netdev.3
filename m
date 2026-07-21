Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0F318EC7;
	Tue, 21 Jul 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593510; cv=none; b=A1pA+tuxTWmxSDZHW9OogvFIhc0VfXgpOiS98HqVCee4H7iMJKEk3tI3Jit04nHRI0B4aFz0riiAh0qRUZYKzjWbF6D3vlgOcj57FJGiBFc08z+ngwDhleIvyjbgDskGq2a8BmlRv6bOK3oT0YKeqUiZjl75eiiGaD+SbWL6wQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593510; c=relaxed/simple;
	bh=6eXs6G6gkEkzEyNGMi584xQR5ev8lmYnIwlJeA6DiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnqkBXP+H499S6A8AMpWg3TihF1kP9tr+LY9NEO5R6fTil5fRN26q7xhzl2MEUlr5efYy+4i48iFtlYC0DXNeYpnzXdFg+RrRsx+F0G2F+vXNQVu4DiPL84V1TUHl6ccd7loJyTaOiHCNx5d2SoyPEOGo4r3kquA64bOWij9wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue2nqqKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue2nqqKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977201F000E9;
	Tue, 21 Jul 2026 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593509;
	bh=uXs4HxOpOEcxFtpQtGxbHyfqz3LtV9uXOZu7OKYdnjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ue2nqqKmpFEJXEgUwDqOo82telPHwhvwMljcSeCISxKkeDvK4ayU550+GmrqQ+PCJ
	 NtDGKgIyfLXB3GCJlsemaDViRW4tW92hNyouLRjO8HScYGFLUIktBDX6/b0aHBZtrD
	 aKshypz7434mEpZqwdf4i5BLZs0gq7Fsm/NjrtluKLbi3EDPalhz8SUQJSc0rWlC94
	 QVCq2ONk5sPgAkypPJG/fqjnBD86ChlY0xYHxKLJJc1Kt7rV0sUZFvGKnn7pFp8dhK
	 uNA95x/5OY1lOcy+rPMnPW0jYGEYGnlSuFy1b9yYj0HcaDt+llPRjTehHoaZJs37WL
	 9L433w6gj41Qw==
Date: Mon, 20 Jul 2026 17:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Machata
 <petrm@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, David Yang
 <mmyangfl@gmail.com>, Kees Cook <kees@kernel.org>, Weiming Shi
 <bestswngs@gmail.com>
Subject: Re: [PATCH net] vxlan: vnifilter: enforce exact length of
 GROUP/GROUP6 attributes
Message-ID: <20260720172508.6063f433@kernel.org>
In-Reply-To: <20260704222254.914567-1-xmei5@asu.edu>
References: <20260704222254.914567-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jul 2026 15:22:54 -0700 Xiang Mei wrote:
> The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
> attributes as NLA_BINARY with only a maximum length, so validate_nla()
> accepts a payload shorter than the address. The GROUP consumer reads it
> with nla_get_in_addr(), an unconditional 4-byte load, so a short
> attribute over-reads up to 3 bytes of uninitialised slab data, which are
> stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
> kernel memory.
> 
> Switch both entries to NLA_POLICY_EXACT_LEN() so the validator rejects
> any GROUP/GROUP6 that is not exactly 4 / 16 bytes; a valid address is
> always sent at full width.

The netdev patch queue has overflown, if the patch is still needed
you'll have to repost, sorry.
