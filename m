Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143298;
	b=UbWtJv9Bj7QWplJSoyz5VptRuXcK7VuMfgNg1AEBxEWec6jq+JDyANwbijcyNwZ9Kgav
	 f+voqOFh1hJRVjwzUxHF1ht6yx3vXK1AwSj4VNZ+IIGhrv8N18AmJOO9dBupk8vYzcAgo
	 cpD5z4orxn4m4EyihNd2ZIfCft5pbqVKch+OddFpP0YxshBNQo5hQqo8G4uj1jdjN5epQ
	 5m/eRWv2Bu0I8DtkrWHzmqB5eRpySw6L8mCj70pS5zAoDxterxvTEi7HtjBr/sHlaTKa7
	 4KTJcgxqX9y14BmbVnv7xLZGuEPfFI+UPETJ30KqUKepk/mANQ90M70IyTz372G9yMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143298;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SrD/M17uVZh4fl1VmbcAQCw+h/iXnJ2qTWHwAIdmi8g=;
	b=aFQn9+b7EmtZfNGMzoOf6AZCRTOoGCNaoH3kHulp6qcPv9RMZyZo63y2M2gzmzhiDvbQ
	 GtNv2lbaBRHuvSvQ2mgZ5i3ij/Oqjg3MeSaQnzfGsF7RRCMqgL5JTykNQ4A2uIzKQsuT7
	 xSxLarKjpcU1tSJkQv6xVLOidO0OJkmalXzvoHz6R835rpL8Ej+xgiHqA3FL01QGIafb6
	 wybJwu+LkPho+fvGD9MsyXERvmulUUPH8auovTaGtHKDAZEPzDjCr68fsnhtoiYrw4g/m
	 iP6ThOWCvdirItfPtwInIMbjmgsI7y/TyBObmhEe8APNHklt/Q3aOLleU8o6tMwaw2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkIGa98U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9A606A31A;
	Tue, 27 Oct 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkIGa98U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209C21F01825;
	Tue, 27 Oct 2026 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143297;
	bh=SrD/M17uVZh4fl1VmbcAQCw+h/iXnJ2qTWHwAIdmi8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FkIGa98UKUL3X5rNbe/72DR9eGNR271k0066xHssnnDiArXHqfytkxy3Wja6km5lY
	 ZWU0SqW5Uyn4sX6JKLbJWTqkinLe2AX5P1b3zTQnA4vAuw2X6GHTwjMorg75qI27y0
	 4QWsGhfgvErE+ZXlL5EoyisRH1EORgo1XqP2xwjxiONJMhd2LLzSrTEM3/hBJB4cef
	 3faBhy7+PwSc0DSg+/J+DOUYyD2wxWiigytm8lfRQ04f9AlOmuG+olmxN2TmsmPcSw
	 4ekZR+OgBb2ixU8usqjadujfj+tLVrohfklIJwQVYDgDsnsUCb5z1kMsFZZYkSfwex
	 4cEDvTUb59HdA==
Date: Tue, 27 Oct 2026 16:21:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Jijie Shao <shaojijie@huawei.com>, Simon
 Horman <horms@kernel.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>, David Yang
 <mmyangfl@gmail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Jeff Garzik
 <jeff@garzik.org>, Danny Kukawka <danny.kukawka@bisect.de>, Mugunthan V N
 <mugunthanvnm@ti.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, linux-kernel@vger.kernel.org (open
 list), Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH net 00/11] net: au1000: Bug fixes
Message-ID: <20261027162136.301932d4@kernel.org>
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 15:31:29 -0700 Florian Fainelli wrote:
> This patch series contains bug fixes that were found during code
> inspection and also during fixing the open/close/open issue that was met
> on the MTX-1 platform.

Are you trying to bypass the 15 patch limit by using 2 email addrs? =F0=9F=
=A4=94=EF=B8=8F
