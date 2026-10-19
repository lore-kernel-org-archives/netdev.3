Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375344534B7;
	Mon, 19 Oct 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392998; cv=none; b=QDFT7R9E7D7dcv9cnaC/Kj+BfJp4C9P/V8MylIxuK/0W2eSGHQxXxHQfmQbeUmlc2JLthQfKm2XsU1/p+Lxgb7ej7M/7rF5qFThFjo4/QdfCqUYVvFAP/iKXqAi7vHHwb/yUM3jsFHVIvwQSN9aTH3rlrFK3ZgvLbFkphpCNsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392998; c=relaxed/simple;
	bh=hsvwtCSKB+JctpL+L0TNRt3C/hGiQHXGwKtsDRo3E3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZPcNyJ6ybM3EobfdjEtYsY5Xh6ZvpqASKnNtNZiGB2vqD6Llicg3+lnRefpC9VADW5FGeKtAsCdLIX3xZuzRC6BMZr9T6VLurbRR963udODGFCsw11CxIDmMxJCK3/dP1QmWJCV7AQ/cmY64E0ASgBiFSvQsOM0hsib6h1McKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de; spf=pass smtp.mailfrom=jonasjelonek.de; dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b=A3iAiLpq; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b="A3iAiLpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1792392987; x=1792997787; i=jonas@jonasjelonek.de;
	bh=hsvwtCSKB+JctpL+L0TNRt3C/hGiQHXGwKtsDRo3E3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A3iAiLpqHi7cyLXG3PG9yJy706tPOf6At0qxv0m7qgM1S9jE8A1SpDxmdgQnug8K
	 ruZuW5Ubjz9kg9JblweSfbuoTHHVIh0vevOTpRj3R5Srf1wuGE5TILHhRAyoUsRrD
	 /RkGwfZ2500EoFHx6y5RJBTfAJYIe6vgRyrHGIQtD3j9WUzJXe3rHb+Vy1MR0EufR
	 znzckgnOfbj1U4O6DqFWOkug2kD6E0CyB0JybE14fzU2BUjFIBt1xPeKxZlHhlagq
	 koBFqr+3Hc6Galt0yPnpS+yfCEj+lQ8pGm44DIE1y4Kfm1fg36E9V5XeeqMPRTs4E
	 GtgSM29YMvGU3XbGog==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MEF87-1xQ59z3ZNV-0064lT; Mon, 19
 Oct 2026 08:56:27 +0200
Message-ID: <2e3a8f8c-d415-497b-ae37-d736a77ad2e9@jonasjelonek.de>
Date: Mon, 19 Oct 2026 08:56:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: pse-pd: realtek-pse-mcu: add gen1 I2C
 transport
Content-Language: en-US
To: Sander Vanheule <sander@svanheule.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261018161248.376205-1-sander@svanheule.net>
 <20261018161248.376205-3-sander@svanheule.net>
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <20261018161248.376205-3-sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:U67j7Q4+Mqgy/EcIWchk2ozDOBWljjfv8EhqhvjKV0QzI++5wF1
 iVSRsWqKtLJObDr6DzUiCUU5LWzP/qOyhqGugA4sXsWWGfpj+a9Kl2Wiz6xnCIHZbIQmS8G
 Hz+a6xWg3HOtID/c5O6IMtK+mQADSwo8a4LnhaVSRSyuI+sFBbiamx0UND8w80mg7sNL/i6
 JzPW0GRmj1ntU82cCm9vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P0DXO2GqazI=;NqocGcpg8hXldB0ub+dAPfxb6Ra
 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


On 18.10.26 18:12, Sander Vanheule wrote:
> Provide the required data for the gen1 raw I2C binding, which like for
> gen2 is simply the gen1 protocol data with the native_i2c flag set.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
>

Acked-by: Jonas Jelonek <jonas@jonasjelonek.de>

Best,
Jonas
