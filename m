Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466B446065;
	Tue, 11 Aug 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459737; cv=none; b=XCzgjUUFP00ElDch+JBa9QU4DS9DxojFWlgBC03s1Dxg1eERpwHLMgbSnPX4jWepuxpddws1mYkMMawyqFtG/AFvbO+wGRORZSj7TK5yw+ltIXuLVQQToaF5A8J8kucgdpOj8759CjqbjcOlHitKauXDYJf6VCcN64a3UfcefYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459737; c=relaxed/simple;
	bh=lrk+mF7KaPfvh3uUnolAJfci5ewJ176APG9ub9ZL3TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4eYCcNf6SuDmHTYj6Pjz/L3fnpCec+R71/NJBDqG88/kJYtJrFs3AcYuBGGX/LqFv8dsdxlerAwcdOUzaCODurzMR+NEbkaiohCB4RDFH0cUWOoRyqXlF79S0vfhvrhcgG64tnTlUDgSMGHQojLkZmX1RcGDirbKIdBnKcQ6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2B8POUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2B8POUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBD81F000E9;
	Tue, 11 Aug 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786459735;
	bh=9BPOsI147KKSBgGuQPMMF7lc4hegsDC1mlohi2X0bIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X2B8POUrpcdjcrZz34/9bfUO35PKtzlcOmnjkMTGRAcq/gjbpnx4MNYQ7dzqK+jYe
	 ZC/9rq9IREIvjjO1dIAIE6Dphc6tGfvCwfiYn5QtfBut5hBAPKJJcyYQGrPEDK2Uo0
	 1Ii2v5N3ae73ipeh4D7n634rCeCVJT7wUoH0e7DyrcEXgTBcG/eLRumjZzMldradOG
	 tdIKb+QrRmrx0rXu0hcuOl+aIyFCcSZnvX+bHV7Ar6ABT7fwE16QwCd9dsn/7jpmZ/
	 lfXeVZxKNUAtbYgsZNC0spz2nN7bFqKpd8VGxdWeICYfX39AblebkEU0PYbpD6LRte
	 qrCdo33L9eMyw==
Date: Tue, 11 Aug 2026 07:48:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: calxeda: xgmac: Fix use-after-free in xgmac_remove
 due to race condition
Message-ID: <20260811074854.209cc69e@kernel.org>
In-Reply-To: <4f91fe40-f52b-4939-9ad4-101091f31f30@kylinos.cn>
References: <e556148b7a938f83f8470bb3bde5b856eb9ba271.1785809990.git.xiaopei01@kylinos.cn>
	<20260810144359.6e609a22@kernel.org>
	<4f91fe40-f52b-4939-9ad4-101091f31f30@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 09:33:42 +0800 Pei Xiao wrote:
> =E5=9C=A8 2026/8/11 05:43, Jakub Kicinski =E5=86=99=E9=81=93:
> > On Tue,  4 Aug 2026 10:21:26 +0800 Pei Xiao wrote: =20
> >> In xgmac_probe, &priv->tx_timeout_work is bound with
> >> xgmac_tx_timeout_work, and xgmac_interrupt and xgmac_tx_timeout can
> >> both schedule this work on system_wq. =20
> >=20
> > AI reviewer reports that this can add a deadlock.
> >=20
> > Looks like we're trading one bug for another.
> >=20
> > If you don't have access to this HW or ability to test your patches
> > in general - please don't try to send such superficial fixes. =20
> Sorry for making noise. Does this issue exist, and does it need to be
> fixed? If it needs to be fixed, I'd like to learn how it ends up being fi=
xed

Your 3 recent submissions were all inadequate. Please leave networking
drivers be. It will take us more time to review your code than fix
these. And you're touching drivers which nobody worked on for=20
_15 years_!
