Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E9331EC7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135738; cv=none; b=T8e9B1CCUGxe9lY5zlug/fUQjKALjdzQJXmWnzYH8tacgse6geaKlwCh7i748nWe2AGDejU46KrSMWgjTvNUl7LNqkZjggFCj9iQRNuWW+l9vIb1wrKUUeMzEu3uDHlqTwCmQSjSoE8hPO08qZH6/rdNFY5D4Qwlkv97GQ/+EBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135738; c=relaxed/simple;
	bh=a+b/AeI8VbR8U7ywZt8JZDGcD2L2EIL+pzZQSn0K4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGoO6ImOQJDOvvr1cWOon0QA3nelNMWTZPzUAa1+MwYvZCaVTQcy8Zs882i/a+mEduViqtZ75cnF7R9TMLOOEntZnsSX1e47uVh36SD7xE5HuIAJmE67V7A2GqM6ca17GgS/r1ui/fbMN8rjeGxdv4ZuF7R3egImH0tvEO/D3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1theoR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1theoR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42001F00893;
	Wed, 10 Jun 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781135737;
	bh=fu+irVX7FI/0Lx6+pKK2gmdllICtVtn2Y09Kti2xd1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E1theoR0O9+c0iEw7d4P6kTApB+6Y8huc2JNKb70/mdqkPvUKm/UDH+LARkzi5rNH
	 MaiEEcxibWLVCdO056uKxvE0n0FpigkfQiZicZ5c4Pbx0HvXSmWAPlEnvDQYdp+/Ww
	 MyoNPnQiiO4SdtKolC6vCEp67wc8OVgh0audue+kuNpCBZzwToa3YbNj22Z0hz0+rP
	 tMwPetjRdgkveOTunofU8/xStD8Tf/As02+dLbG3cVK1darSlzDkH2OCgZIDy9uEOs
	 WTsOCFu+LDYf2KakdIfdUaLC75qKLUbFMwpoJG6JFtjNucxnoBYKdI/ha43TzthnsW
	 uxuxq8b7Gs89A==
Date: Wed, 10 Jun 2026 16:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, John
 Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: remove tls_toe
Message-ID: <20260610165536.21ce4be4@kernel.org>
In-Reply-To: <aimaArGsuD6Evobp@krikkit>
References: <cover.1781013810.git.sd@queasysnail.net>
	<aimaArGsuD6Evobp@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 19:08:18 +0200 Sabrina Dubroca wrote:
>  - do some more cleanups in the cxgb4 driver (CXGB4_ULD_TLS is now
>    unused, but then if I remove that I should probably remove some
>    other things)
>      I'd prefer not to mess more with the driver, as I don't know
>      the code and I don't have the HW to test any changes.

SGTM, FWIW
