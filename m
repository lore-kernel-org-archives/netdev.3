Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F52384CCE
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381756; cv=none; b=eyigr3YzWpmYbckcj9zckq+etGNaAN7F7CwNnmN0t/Png+S2YxKAaUlJ0ng+ItoXSDhSohm3H2By+RVpKUT2sgjRsDU+JUUaa91XxTmVn/L2qh31heJBUSXo7B0pElC9D3YsMko5LN4esCT2Yx9QqcCg1PM9Ct9uDmleCfcdaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381756; c=relaxed/simple;
	bh=rRTrySV9yA+xCHLUqvVcKeYYsa143+FfetzEjN7PA/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWyzLxKLN1sVd8VaAy72QgTCDSIENTTK2Y8wxUVavGk0tVRBjO4O23u/plVJ6T651T2Fpwh5fl6LKzZ1kBecPBLpWJ0BxwB+kpcs8oJ3iRfEASuOnqCLteNKa/F6Dix3CU7g3JX7tJbyoQ/1eSl0kinUC7zjZ6BFV/d7a1U0Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgUqkyKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgUqkyKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D81F000E9;
	Sat, 13 Jun 2026 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381753;
	bh=WxlDaEHrnY/6JpLw+e+NURKreiTOAGVQZU7Q0fzZ2rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgUqkyKsJvlAKY2uqdo90cEAFV4syPBT72UjAZAGJFluOga3/Mow9/XZNfE+jECx5
	 G6laIXnqgOc4ggUvvwSmRTwvTel60ZNLNhrC5Q4GCBr76+nHOV9IcOjTS/GZcHgfu9
	 UbVrQrHGORWwzFQINPCCQlCP1bhoSKP6hxJjAXEhGOAth+J+QYlEgHQ89snkBb5tn6
	 xmYpxSkz/fE5/AdUGlc6V4amVf/eNW8IXvPvWT9oAXTlcRe+VWVaGp1oDw3xDXzA9J
	 erJI1AU8QP1Z4vi4aemjvUNw0YvB3Ktf9uS55mzDx/bJd9ZHOFGUwbT0yptIxGWox2
	 qXr472M3lKFNA==
Date: Sat, 13 Jun 2026 13:15:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>, Antony Antony
 <antony.antony@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <20260613131552.2562d433@kernel.org>
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 09:46:16 +0200 Steffen Klassert wrote:
> 3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
>    allows migrating individual IPsec SAs independently of
>    their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
>    to policy+SA migration, lacks SPI for unique SA identification,
>    and cannot express reqid changes or migrate Transport mode
>    selectors. The new interface identifies the SA via SPI and mark,
>    supports reqid changes, address family changes, encap removal,
>    and uses an atomic create+install flow under x->lock to prevent
>    SN/IV reuse during AEAD SA migration.
>    From Antony Antony.

Hi! There are some Sashiko comments here, please follow up:

https://sashiko.dev/#/patchset/20260612074725.1760473-8-steffen.klassert@secunet.com
