Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111636308E;
	Mon, 24 Aug 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594372; cv=none; b=gAoZs5hDZgQysogpmg5gIziBZNmIYk/LuvuDVZVgu/PQiAqEuKDF4VqGyRQxCgfDRKkLt6jPPVl1zqOSMRufp+NqdgecDCuiX+IfuYGA1Nc7eUZIEXgzN8bbIYjMCn2vY2ox6bqKZxrvkx6GvtvuVNRQIbxI887/xp5hM5efpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594372; c=relaxed/simple;
	bh=HGfADrgA0cOQudrSYtpKfFAdR88QFLV7+CV5qK5AFQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv8Rk3+W3y2vaCPcPcJSrVCpX2spMZpadbIEMMzXx0e18EgbDa1EAxoqGvCrBRWoslAl/w8h3VoPu59BLwxfm8gnLTfyZ92OWNNgZfQLJKPiGCaIoK1J1PAKJiJJY5ONTlnTq2jhkrJmHouaPZmFqIC/6STjoVtiGcrBZTuxH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4qyOyJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4qyOyJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7959E1F000E9;
	Mon, 24 Aug 2026 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594370;
	bh=xSkf7BWY11H3ovY75d1C8mIncglAKlyifoP75WF3GW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c4qyOyJOgCGXiQzCUHKP0n9X/0LfKlHd6dpNhNrWwHMjdfrSb1h2I87JuEK9HbEnb
	 cmpY1HTGM1RVkKv0hilrknBahIQD+1BqBKNZyXTnMZpCyAocGW4UJvFuoZFsCTei/1
	 kOuMsYZAUHLBglCHc91OwA7N1UonkChIDrcU8PDAmRm+gZL4Qw8rsQRsxnJ+ZH/f5y
	 ZT15xYxiIEuuLiQrWF5GyPbCRFMkFS8l/VWMVgWZk6RkUL44CJ8aFHjN2LfFxCMClZ
	 bvUe7/yoOXAd9HVYehVyJXzlHprA7xbqs5xafXhRuf01D2UAnjAXvkrGN08uxY0hRf
	 5Ny4DuTkvJtzA==
Date: Mon, 24 Aug 2026 10:59:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260824105929.57f8dc41@kernel.org>
In-Reply-To: <f68c123f-12d2-4704-b9f0-a26d17ae87de@auroraos.dev>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
	<46bc8a60-8979-4b0c-ba43-f99256561a48@auroraos.dev>
	<20260822135832.274fe2a4@kernel.org>
	<f68c123f-12d2-4704-b9f0-a26d17ae87de@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 11:37:11 +0300 Sergey Shtylyov wrote:
> > And to check if it's open ;)
> > https://netdev.bots.linux.dev/net-next.html  
> 
>    I don't do much netdev these days, so I just forgot the usual
> routine (and I couldn't wait so much with posting the patch anyway).
> Is it still possible to send net-next stuff with [RFC] added to
> the subject while net-next is closed?

Yup, RFC is fine (tho FWIW CI coverage of RFCs is limited for cost
reasons)
