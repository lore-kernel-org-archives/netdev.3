Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391011;
	b=KDPIMtjxBc5E2GykIZR66P23M7d6pZUw1oIWLsgM7HxOyU/wR8OqGatLZg9OacNJBULc
	 nEJRNAQuXURULot5yHlPeUyOv4RJJlI7YPLN+lMuo8RJ4Gdo5IOg2VLW9o6J5Px1l80/p
	 IQRqhV/iLI74qJRrpVxdcVyGCUqqFZet7s/uE9TRak4hveJ4Btj+d2mLrQCADEW2TQmkc
	 HJqblVeUAAtpLquNVRhnIdKZLWJ77J4pgv7RWV9wSIxMSkcDsA1t0FmYzQE7u1DwLxBqY
	 rHoD2/UjPdj78n4ap/aneTx78SR6yXYAobwyOzko7r1xM6xBLRAZaBVIBUni+A9Ylhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=l4mDNG1b4svkZ7F+GHjnP/+ecm+ALKz0+YL4TvDKcAZ40GfwUejre0YTbpIeYe0I0sz7
	 +v1qBIiHKI0c2EA8d/u22bW2cuLHvJfEzWufTMVu8TjL1ZCEU8wWsxl6gy0SMNl4WlJMO
	 ofnEg098BGCRCa96XJrxcYG2ZviEIGMM8yC679rhUyzYb0k6aUeTI/poBqAANuFAtfZ76
	 DbikMXE/5sZsJmh77hg1Ayq5Jaitha0EqvaLG30oDXOhsc7+NL19yceCeECCoRMfJhvfw
	 ZX98eTdSHKMS52u836GJ90LqbQsaGajPaUnBK6cUIheVdPH1OW1CHvUFh04c7OnQfbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q28wG+rV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B5606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q28wG+rV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB51F00A06;
	Wed, 11 Nov 2026 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391011;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q28wG+rVnK37D+bf9oD/0h2t32bRq7JyQmNlAlYWnS6skH4B8H9/ZX5/rfSsgjfqL
	 ydTH95a8q8glSUP35uBu79wjkAVMAH8PA50wgkzc8d8YyZNyDT+bmYZf89fu8QTxpG
	 uAKWFe7LLiIEm+vp9udHW1WcXLE1pzbrnQBf5tH6KioeFMFnTP+vf+fHaWNUDqfscD
	 Z8qVDUcXiMTUoSqlTOlYKbDi6FGgbUpzTMMk8ImoNeI4o2AnGvD8iM9B+73M4ccNsG
	 7ZPsc2pVurdRwU3XSVkZ8oJOngY8XXV9SJxLEcnxKll1OZ1pvmVd/YzOwBbjFknV3+
	 YVHPgI2ag6AHQ==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
Date: Wed, 11 Nov 2026 09:56:50 +0000
Message-ID: <179439101012.2168702.7084889683086505686@kernel.org>
In-Reply-To:
 <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
References:
 <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
