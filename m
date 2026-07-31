Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DF3128D7
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530799; cv=none; b=prxFX3M9RTzD0FQfJqYY5+YjY3er53zx0HWFXBPQEgDu+T8lSawp226BjmViJxtdU1o3Y3d2YVvvpaK/nOuVUUnWsUa8Pml4CvLtNtAPsFls6hMFVZ7tkHhCRw28VkxL6VvMUXLGyOGq6Srdrf4N11J1ODNtVyxg8ey3MUdiUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530799; c=relaxed/simple;
	bh=yebtGUa2uL7h2MtOfCtXvRl825pwJqmlyhUE+Wjb6EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGiJaIKRR6kIxPJJpaOI9noaH9sGYDKoXNG3Imm9tJ2RqFWgg9GIAMPLs7Vbf8TFkYrxsyE7dbQuAUWstnPnE7W3L4neHiX5Qg29XEtQhs/ZerlPcr0Z/bdsmyUUbGv7aIuJT2GllvW/Vfp87lMcI2uIsOkdUh+r0yWfV9HBOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=Fen9wKt5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fhOQSsTD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="Fen9wKt5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fhOQSsTD"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Fen9wKt55bvlJ6YwZALJLAh1T0TNrU2GbVmVG/BJvOY2xjajJZ4w+1EqBrRH8igeoV+7iV+UJmnV4yHTm11oHNuXI7KVVIlhQIk45UBpRVaP6drMBS6PEaYiS/nLJw2VdPd9XXuYjxERW3oBOcJnNyn/Hmz23RmoendTlSQh7VuB0gKvnf4x8txxefH5VEqFJiev/oe71RiVYwFMU/NXFogIfZKOODk19ys4zdjN60NgXDaaIzDGIonRertmu6biu5bezrPSIvfGg6NuKmMzdtXyw5DKlWWtMIMpoYnirI8tmE4yvVqf8dDzCqnZdY48F0GyRUqCLD5AlLgf9La4zA==; s=purelymail1; d=c127.dev; v=1; bh=yebtGUa2uL7h2MtOfCtXvRl825pwJqmlyhUE+Wjb6EY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fhOQSsTDbK4PMqvXrBFp2EAPGjpy5I4Z7yH7u83e/c0hfPTYYropER4VOX/eWuYsdtf9jzYMIDoqeQZwyDPrsUT8XHq4KLPcZjjrR+OuHn1djVLzItqY4cZjgcR9v6GX4YQqaIvV/EBJHPoU2XH6m1338OezIakMMT3n0rWhLYjKkDWLaE0IWknBZrJRuDS3G86x5Phh7icBARQ19LbxhR+ColyBAkhDtYYmRsVXEaI385AdUhfr7GW9e7domi+DgdVnIlQCgiEIuYxDbz6f9mecArVKddpC5cI/fXGwptEMqWNrPkvJ23DXm0/BGU+90yTEDSNSvlEF0vuvYjsm6Q==; s=purelymail1; d=purelymail.com; v=1; bh=yebtGUa2uL7h2MtOfCtXvRl825pwJqmlyhUE+Wjb6EY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1250848215;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 31 Jul 2026 20:46:27 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Johan Alvarado <contact@c127.dev>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk,
	pavel@ucw.cz,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net RESEND] net: stmmac: raise TX completion interrupt at the end of an xmit burst
Date: Fri, 31 Jul 2026 15:44:44 -0500
Message-ID: <20260731204444.65925-1-contact@c127.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731194522.55069-1-contact@c127.dev>
References: <20260731194522.55069-1-contact@c127.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

+Cc Maxime Chevallier, who now maintains stmmac; the MAINTAINERS
handover postdates the CC list of the original posting, sorry for the
omission.

Maxime: this is a repost of a fix originally sent on 2026-07-06,
reposted at Jakub's request after the netdev patch queue overflowed.
The previous posting, including the review discussion with Maciej
Fijalkowski on whether frame-based coalescing could be dropped
entirely, is here:

https://lore.kernel.org/netdev/0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa6=
5fbacae5c-000000@email.amazonses.com/

Best regards,
Johan
