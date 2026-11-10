Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348722;
	b=n6RoXCyqgJbwup7ulRjfr8E5eiMEJNkR3vsIbLNViM1J7VGKH/5NSvzpmk8a0wTdtDua
	 lIKs4m7+A8fmJRjRSb+PkK/736dSR8v5rH1FGZPRKKdiap4ZjT0C1jRuuOLwomhiavKM8
	 Pz5RC3YkEJyFVa4VC0WzUe09ttrv3tO0kSaxSweMn9jqvblEgo27hCNof7Kzg6uTEJvrp
	 skzFG9KnmIEQnusr8x/o73SCcT2pu8kEz5SFnSVgSMS3uC/Fd5HgOM2obK2u95rPyP95J
	 /Ai3lcRXne914eYY4sxK0wu0o8G3zLp8qvKtqy7TFaBpD2DMZo/z+6cv9itJYiUoluA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348722;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JGa1Oj4p0o0q83dr7aZpo7ORI/BHrVMnyGgD2LyRVvI=;
	b=scuyMKBRIJXaIXbuiXf930t4K/5OnirBr0w9zfgEAyu9JKBX4nQ/NOsQOSEurTztr5hR
	 fWp1z97eES2HuG5fy5t25tCjlveA96TL5s2MJU5J9Cu/CFRQrLs0A7fchrOh8cedXaNj5
	 yQB6PPIULenhZUIc0WPe90gD5J/AsfS/bY4f35evOfUZNC+tghfMumByN8F5Gzbf7V85e
	 k2p9Vs9+Hzm4DCx/4veO84kyJ26WqRONBKGg9DfvE1U7HohWvi0q1EvwD3mVTQqHNA5iN
	 G8f50wzO4cx/TY/GfqaY5s2tUGxIBDIOfJ32YOnszrUwQoUZW2CM4g9FxkFbNkzlsVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRUuMu6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D1606A321;
	Tue, 10 Nov 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRUuMu6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855261F008A3;
	Tue, 10 Nov 2026 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348721;
	bh=JGa1Oj4p0o0q83dr7aZpo7ORI/BHrVMnyGgD2LyRVvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eRUuMu6Vh+BKJKhbBcdGDkIlLLU0t+B9x/iqSenDcXKLoz+CBcqqpcFml7Bme/Wg4
	 jvhwcLJYRmArAu87U8B9mQSi9wgdr6+RWfS0YE3igRKllbAgCPatdLfeVYXRz6DYIk
	 sdAQK9fk3rXjFlZXnLJeGqxRRXutwEyExT9qP3T3tYowSnLuihlqW11xQd9hrV5tD9
	 MUZiCWTFSk7/pAW3keLatIJ8neG/sNwah6pOfnrqFSdUUMuZ+RRF9v42VIpwbTA1LG
	 ZCHGBjYqFvJELKE73gxgT71SYyf26QQUoaJqfiLvfaJmwRJgC+3EQw0/R3pKoT9goU
	 5JG09z2nuK53w==
Date: Tue, 10 Nov 2026 14:11:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, macro@orcam.me.uk
Subject: Re: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX
 checksum offload
Message-ID: <20261110141159.100d1028@kernel.org>
In-Reply-To: <0f3510a1-a22d-409d-ac3a-854c9746eb81@gmail.com>
References: <20261105193435.2050321-3-f.fainelli@gmail.com>
	<179422063443.994134.7898125324608942943@kernel.org>
	<0f3510a1-a22d-409d-ac3a-854c9746eb81@gmail.com>
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

On Mon, 9 Nov 2026 09:52:30 -0800 Florian Fainelli wrote:
> Both issues are valid and predate this series. I=E2=80=99ll send separate=
 fixes=20
> for the descriptor word and IP header offset programming.

The High one really looks like something that should be fixed _first_
--=20
pw-bot: defer
