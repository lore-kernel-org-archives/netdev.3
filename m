Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C636A37F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203003; cv=none; b=AjDD14jCIN5m7drfCOrcqMf57S9GCxKgauaStXII8QGNKr+yRLq34QrCwnyIEsk1P6u00iC17N1j26sr0dh9SIJWF5/PUTPHtYExU1FTDuR3KhKg+dCVi6hBeICUd53fPS/I2fFOseZPnlnXpAnQ8yugVb9sGqcnadz+XQPOA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203003; c=relaxed/simple;
	bh=KefP+qA5hud1luOviTA4eg5Uxtw50e9F0Uh9thm9lp4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzkVPiPujqMpXyzDbBEGtxW809Jpx+/IfxYZEYes4cdLyRlNjcyR7nzHDkhWfeCNdk+KPVb6bnbwJhIp+/3YW8+ZlamoxSQwQGNZyfPFKx9VssncMOSgy0NfrrpiGE8l3QH1aC8q05GJs+3U3L+7jlWhlYXQawOviciM7kMprjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bsgJA6Se; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bsgJA6Se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791202993; x=1791462193;
	bh=rlThywjyebgmdMMYOSCOBBh7IXfkT7Zoqqpj3w6jndQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bsgJA6SevpwZyXaw6aD3GYAyc96l+YEr+WC7k8Y5hh/5cZ/LuP8kunSgmfYhD05N0
	 MiUPTu+7tIP45oyhYsOlFsQYEmJC999nLUR3n8dYFl0oDNKUtgLc5aLZ9gXPP8akDh
	 VOBIk360XTugIWj0vuBJqXzgSjN9+xTxz0tMiR5+iw6BJal2/czgyYK3Wi6fbULw/W
	 efXH+qkfNaz2PNv+VXw3yIqMfuI47QPL8IGkm3ckXowwUTl1MbdzzWGnERCZXdgHkZ
	 OjcSBhFUK0uYnV94OJq1rys3qogU0XrhvJYAdXdP4BFpUuDs40cUzc2oZosBpIvGgE
	 6fiJ4lUo0cu+g==
Date: Mon, 05 Oct 2026 12:23:08 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
From: quantumvoid0 <quantumvoid0@proton.me>
Cc: netdev-bot+sashiko@kernel.org, wireguard@lists.zx2c4.com, netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] wireguard: allowedips: prevent stack overflow without DEBUG
Message-ID: <J3FhBqGm5xM550mTZHy9x-YSafy3ThxZgEkM-QOIfVTyC21TBnH0l6Mnmt5Suar61dhuBpv9QLNns4zdDIvaDK_Uvs54MF1uW4n09XAmVro=@proton.me>
In-Reply-To: <CAHmME9qod-kW93qUPE14ABA3sKnoGjtxwpa2m-fXh1PwKXSOJg@mail.gmail.com>
References: <TaZxFNfdnpo-3szeC-LoWZBxj-6XGhXkdEqnQi6yyaOHXp8cw4Xtksw07sYrIpludwvJQrukFoCGw3r9rXDcInkdB5QD2EswKPNsXMU3qMQ=@proton.me> <179117435281.434549.17747961185403870914@kernel.org> <9NzB3VmT-7cBBfdx9sREmRkFb_gOAmI78VheKlX2Mdiqjl3B3N0OCZ5DT8C1SpEJuM5O3TzLltSpGh9ptxni28Lnq4ATz8u86R-f-jdcKPE=@proton.me> <CAHmME9qod-kW93qUPE14ABA3sKnoGjtxwpa2m-fXh1PwKXSOJg@mail.gmail.com>
Feedback-ID: 175132216:user:proton
X-Pm-Message-ID: 5cfc955f16f15cf58728799d9121e0660cd3b84f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Understood, thanks for explaining. Ill drop this.

quantumvoid0

On Monday, October 5th, 2026 at 12:19 PM, Jason A. Donenfeld <Jason@zx2c4.c=
om> wrote:

> This is not reachable. The DEBUG is there because the point of the
> selftests is to reach it, but not for this to run in production. I
> coded it this way intentionally. I don't want to remove the DEBUG
> test.
>=20
> Jason
> 
