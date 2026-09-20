Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772333BBFD8;
	Sun, 20 Sep 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893549; cv=none; b=MAX2iiaOef/C6PRfcoU8DMWAQ6HL58R26Ecj0HBZ5PdgOmNp4ed2dxSELSfmmKFOMI51WJi+KaEjROTnWvei9nrDMTNgIiqGgFf6SEQEFvPjLIDym+8QiK0WxGVGVHthPlHI22n5zp99bJW4GnWLKoeg4AbKQkN083ihIY/lbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893549; c=relaxed/simple;
	bh=FLFruPTIkCnUFLRGPiHiEEhwHCOreI2qibS5STHvsuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqhV65r/QdoPNtU0GKw9sNbkMpleyktfpEzXjtG0ItXy2nOMohVkQu4E41GqKfcVfG42tEv1X5tnAGUcawXFbZNeuhuhsiimVf6GdzO8ryGKm6MwsUvqfFYpM+oaBjMWhwvXJQx/7VufPSArwQ/RlS4CynQEx2obWZE7/HJXZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dZT5KEFg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dZT5KEFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1789893538;
	bh=FLFruPTIkCnUFLRGPiHiEEhwHCOreI2qibS5STHvsuk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dZT5KEFgpW+Vkl9qggpMIY9atif4hClNXiS9BB+dpljNi6s9vlvlqgSYLsV4uEn9U
	 WlLTdhGcSa+fEVQOCZm3NIdXd/LNg4/hhH1Zlx+BwrXiDcZr7QUfcG0+pr9dL3C8CT
	 jAKuakd3lbH2xLIJVxIdEJaXEwpnQnqx3enCkN5yyRHrFweuGPoUI7v/v4hqMBw1CX
	 CXWbkKcECOCKcHqyFGNa1WZm29d6CqCNqEZIrKV4YproOpLvp6Z3Uvo2Vbn/W+KRrv
	 1Kc0VC/85yot0op02QoCK1BfaFxbEmg/dklwGgPDzkQr4B/quac17ULY/anzWgppnh
	 rcycCp1mVhSwA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2B11A6B3F7;
	Sun, 20 Sep 2026 16:38:58 +0800 (AWST)
Message-ID: <159f68ef9444f8b44a6d5764de8696f094fa889d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp: route: verify socket ownership in
 mctp_lookup_prealloc_tag()
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Hui Peng <benquike@gmail.com>, matt@codeconstruct.com.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 16:38:58 +0800
In-Reply-To: <20260919212851.3240598-1-benquike@gmail.com>
References: <20260919212851.3240598-1-benquike@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Hui,

> When a socket transmits a packet with `MCTP_TAG_PREALLOC` set,
> mctp_lookup_prealloc_tag() iterates over the per-netns `&mns->keys`
> list and matches `netid`, `req_tag`, `peer_addr`, and `manual_alloc`,
> but omits checking whether `tmp->sk =3D=3D &msk->sk`.

OK, good catch.


> Verify `tmp->sk =3D=3D &msk->sk` in `mctp_lookup_prealloc_tag()`.

Or we could instead iterate the socket's tag list?

Cheers,


Jeremy

