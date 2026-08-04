Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB340FDB9;
	Tue,  4 Aug 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877089; cv=none; b=RtUr3jXqS8gbVD4TA7tu/c4pIIJPIpLvjsgeQXdi4BZ4W93ff0lZ2qo57j9J07+ZeT9QOhMaZv30mxLTc8jU39oOYdKKGEaJ0lz4rrU98qgKTl+f9dPvbPPVe3eOuNZUAwyz10XxDofcOKLjgKM5oi11rCAuhrlViGubEKB0WsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877089; c=relaxed/simple;
	bh=XQzRlRxxTYQMWBTVWBrMnb3CShw2CulcLv9XHnxMp+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loQFzwewhfz9TJOAFLqKP7PNiZEcDazbAbXfVPHWn0qUY0flFtFnwGTnBbGQkQqi936I6Yy6p0ZRJpCoCcHviRAHLu/TXZNsWHYHyroXODe6WKI9/dTukkGfrtd85DeKFbuONQMKqHmoeAfbsWKYYXG3GI8xa1mPgyNzKoJYkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ors44C+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ors44C+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD741F000E9;
	Tue,  4 Aug 2026 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877088;
	bh=XQzRlRxxTYQMWBTVWBrMnb3CShw2CulcLv9XHnxMp+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ors44C+Y2B9D15dGCNZamm7FgcNkTtklShlRCeSmdBmNjnFN9YSfXPp5HeCA8teZH
	 zRlSSQ2BHYTifGmE5Ad0LYRn+RA5XxI8I4Jlo0YVXHmsY+la76s+Hgx2KOqh1qGFkn
	 ZAwbP/fg0ZSmWDg6+RWoaNp61s94IvvP+hl443xR04iR85jdjBDeoudnMeFIsy67kC
	 pJcUBjAufTbX3qjsBtGzAiivU3IEHA4eApo7YMC6fhi0gcjAQ+mQQWqzgXK01HiDHM
	 dQAefdJAm3P8dh7L4SUVnZT5X9hWDirEDLT8Ljhh5M9s5M9iot0In9l55cqLY2W21n
	 0hNg8EuzGW/ZQ==
Date: Tue, 4 Aug 2026 13:58:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arthur =?UTF-8?B?Q3LDqXBpbg==?= Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] w5100: restore GPIO-based link detection
Message-ID: <20260804135807.0912ddf9@kernel.org>
In-Reply-To: <20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
	<20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Aug 2026 19:40:56 +0200 Arthur Cr=C3=A9pin Leblond wrote:
> Commit dacf281771a9 ("w5100: remove unused gpio link detection")

Sounds like a fix, so the two patches should probably travel separately,
the fix with a Fixes tag and more explanation (what you have in the
cover letter and more) in the message.

And the conversion should travel via net-next.
