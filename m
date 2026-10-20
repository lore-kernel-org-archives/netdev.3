Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519652;
	b=Ibwb04D+WsNfzHqfEoB9aBXBNk+D0/IwF8X6zOWgTvKPd4UR9ZarMoAHi91bz/k4Krft
	 O4pykECv3Dv/g/0Uu3LELripQuYKmWmiK0TDFA9Epdqu5LHFLhYVeC2bDbu5PM82Amo6l
	 XfC8HawDilpL+XonDCgbqVG7kKlulZa58wPEIfXl7cZPMSHwdKhh6dwBbcOAO1ZP3QUtB
	 GN3N9To/Zwi+l88QPvc7QgI76iZdnKV9/MroxK1D3wn/+HM27FnJwPwl2zuR5eEri+/ab
	 +67RGaxotxv/fwWJSa/oc5gYJ3fnhKMslt5MhgoryKpMbKqdzovP28+AUD0zXIBPyJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519652;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0wL42oJlkd6LnR8QJChHQvUi5wrtsmNUz8+16XbcaZ8=;
	b=NIMzOIjoFXqhOVx3IjYIskHhRxUBufeM4uCJkH3yxHoZeIG23VumW69dZoiE+nrM+HF4
	 c/rZjBGQ5XVBU6itRypsuvvNLw+BHLOnSCCQN72ucTxFkliDY5IeGz38bNjC1GQzzrhmF
	 YUpZnNCkh98eEvFGwd2xsRjGlKj3b7arag1CXc66Tpw+A6lbgKSWDzZ2x+To7tPbCXURu
	 OQOX4gH/r8Ez1GmLBiGuhd00m40Y5dbvBTBFDcI7KRiA/W9fumqp4uKGFngFHS1Unt1FK
	 +LrmIsZAhjoiSy3qylBJ/vQFMCkgwPI1YA4Wh6qSvoZfHOwtH2DQTHhfcXEr4/sVEVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUg2y6iR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009D606A31D;
	Tue, 20 Oct 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUg2y6iR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E41F000C9;
	Tue, 20 Oct 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792519651;
	bh=0wL42oJlkd6LnR8QJChHQvUi5wrtsmNUz8+16XbcaZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZUg2y6iRWbGZTWLwvluH2j7NQgWFR/T9Gz8Ahm7gYuE+sp3BRPNk/Cl3yIGkcQxJl
	 16jnQllS6AzbdLjK+3/l9tIb+tOXKmM/m/OvLQViqpe/YzMj/nL8RpHpNaHYU7InmB
	 ibgNQzvAV/f3QkSjYASofwOzCuRx5qVsB14Be0Hnlu/9cZ3IfiWDlL2ah8RmscFJq1
	 21Ob0BhuMQ5OLigQNvnm0Qrs+pxIpvB98zMEcj53g93BkwvuIP5p59REdVUkuN82f8
	 lxT90peBNN5Cl3aJjlJ1xGsGLl+TOoRoWqepAyh3R57VFIz8ubZPEqP0eKEHOxg73V
	 A9IBk42ObH3yA==
Date: Tue, 20 Oct 2026 11:07:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out
 of the packet ready window
Message-ID: <20261020110727.472c0c05@kernel.org>
In-Reply-To: <dfbf28fcdac98687ab0bb49377657ed3@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
	<20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
	<20261016182508.1100f391@kernel.org>
	<dfbf28fcdac98687ab0bb49377657ed3@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 08:29:46 +0200 Nicolai Buchwitz wrote:
> In v6 I will do that and drop the padding.

Ah, much better if that works.
