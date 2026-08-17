Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99543C0A10;
	Mon, 17 Aug 2026 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006746; cv=none; b=OsTeT96JAjcm3wCHFPw0D/yzPdTQhVkSjSnPpSkCrCAhIxh6MaNcQSzjf0AGShk6F/1jBfJIwVHCnQBq2iRZEKULQnPowQ6LR0J7ECgW3ITBiZ0Kd56U4sbp4i01W4Oi7cSsyBxXUFAfIHpiL6cf/nHO62A+mB8qm686BZcMfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006746; c=relaxed/simple;
	bh=Ze6drWtCN2h5zBujmaR+ATp5UruBwVA6XFFtHprSFvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Owmw8Lej4Pa0bzkeYS+qTaoMy6pP8SoMIZusurp9YkxEPeqXeTeRhX1zOZn827AvaLWGu70hzpr0kF83YTZXe5rzVxROI4nHMqTzJqLp17IXwu+iEOVgG1wJTK2nYGAz/PE6L1UaQ27CKwQ+ehAl4FXIYnjWTSwfixAD228Cp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNMN1ho2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNMN1ho2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A911F000E9;
	Mon, 17 Aug 2026 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006745;
	bh=cXBXrwsk7HfFqr/xHtftG3g65WJsorENQsG2Ioyxr7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BNMN1ho2jY/pviuKkh/densKkPpFgfLAFSqnyYjwYz0+F6ehzh/2uegBwHPRTHBmy
	 oAF1CUz52YczM/HHMk67v22gX2TIft2+A7Dp1AgnS4yzHpACi99qL+jViVe7HTZjOu
	 Yypsd7g0WLR2hLaRQFh2dFY/gWFCRUPibMpIxYgWqB113bq8A3ec/3FEsMI0OCTu6l
	 NodrDaTACfmFoh6qsgmWKvuF9MxxGoE3W31Q2Nl+W0H+ZIgxkJdib8SKsYmdAi82g3
	 AnY71XAM8IZ9vU2+7kTdgl4uUmdbU9RQeea05stoRL7paDHJbzpn51n8n7RrQ0bq4U
	 kAW/fgHij2jbw==
Date: Mon, 17 Aug 2026 15:45:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Luiz Angelo Daros de Luca
 <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?=
 <alvin.sipraga@analog.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: realtek: add
 RTL8365MB power supplies
Message-ID: <20260817154544.622c0fd0@kernel.org>
In-Reply-To: <20260811113901.3114169-2-o.rempel@pengutronix.de>
References: <20260811113901.3114169-1-o.rempel@pengutronix.de>
	<20260811113901.3114169-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 13:39:00 +0200 Oleksij Rempel wrote:
> Document the RTL8365MB power rails as optional supplies. They are optional
> because the rails are often always-on; some designs break them out for
> granular hwmon monitoring and regulator control.
> 
> They are scoped to realtek,rtl8365mb: different Realtek switch families use
> different power-rail naming schemes, so these rails do not apply to other
> families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).

Unfortunately patch 1 did not get an ack in time for 7.3
Please repost after the merge window
-- 
pw-bot: defer
