Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477354;
	b=QIOtophuMD3OimBQzpQ9uLtUN2cpWnKk0+UWQ5ihIozFXMfvsbTITSRe9o3hoj63/GaB
	 V+S9QcaFz0/WUMoqqLyIKpBxN0Ikjkke1GG1cBgD/EkEQzFiZgn1GGSa0NTRhSlIYfIss
	 sB+T0yNknI69SUwKKEYwbUTKxAgTTPi221X3EEKnkD6qVJXdZNfMct3f7R1hYL2ti/P4q
	 rJUKHrOIp6RjFhk4ORB0tZvQeNg7WsBeRMQB0YK7re5FrUSXr1+w+QRKjXAW7qdngx7wg
	 e+JahXBWtXipzXvtj+bPLDlWmEG50gsRbFQI8dNSmzolw3vnQ8o4kKCg3sUkBGEqueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477354;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=yEC/vZNOKTkAFWLkMBKlCC1dHTq3fXauXlYSOK1PQyw=;
	b=OstzSJrdJG4LfOH5OqbddRkq86SE7eWn1VJ7fZekeOD9DmwBG+P2RHTIC/HXiXCnMNLX
	 gNY7i85frko4TJRGzieOm5hZIFVl1v/6t/eizhtPBA1XjLJ7GYB6rFFTM4gytsmgtqWIY
	 KMPaHuGQLLY2WWUZ3ZcvkJlXTxZgkn6jukic/Ak+0X1O17qjXkmHOnLgNF76Q8v82SdyJ
	 9fArNVRo9g27PtSXiiboiyAmuE/uormIBn1Q+x/sGjZ9CG3VODMf1H/38qnmZIBu1dCV4
	 ugiirFSTHInOb2ncr1zU3fIPQKM5Cp8K0bSAKHPO+0/M0/qrdm+Fg3Nq/Al03lsetsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZrNPvQFC;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940F606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A940F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZrNPvQFC
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC880A166C;
	Thu, 12 Nov 2026 10:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794477351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yEC/vZNOKTkAFWLkMBKlCC1dHTq3fXauXlYSOK1PQyw=;
	b=ZrNPvQFCjsKZS7uA10pKE5Ip5QJMXl7RtmjRFs5ZpJwi4sQNluDjt2qSC7fH+oUYwvcC9t
	cqo3Ws0M/ab44x9I7FmHdrzIG6HsXHXWY6nQwOd/kKqZvLWO+yMCabcflpxOXgz0gP3NPu
	7QdvnVxkgVAbBVUUAxBh5GDCi0+AbkI7alCvyXUKLmOMccEyvtGbf2y1m8H/9oER8+3X3q
	gkTUN+1qv0cnZvoWOtZtBqx0m/i9Mkb46zs9vmFOuL6nC/VdOgY9vR8TxKEaeIWqyZysyU
	Wfqwdt14wRUuwQlAjbdeOWgJ693cGtodKUTQlnB6YJeTO3GbMH5DpZMVcQSO9g==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:55:49 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
In-Reply-To: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
References: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
Message-ID: <6fcb41af4802e0d5b9d759b5e2d3ecd6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo

On 11.11.2026 10:54, Lorenzo Bianconi wrote:
> stmmac_set_time() initializes the PTP clock through
> stmmac_init_systime() (TSINIT) while holding only ptp_lock.  It neither
> takes est_lock nor disables and re-bases EST around the step, unlike
> stmmac_adjust_time(), which performs TSUPDT through
> stmmac_adjust_systime() under est_lock.

adjust_time() drops est_lock around the step, so this isn't quite right.
Same for "as stmmac_adjust_time() does" below. Please reword this if 
there
is a v2.

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
