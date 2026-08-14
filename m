Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381EF3A874D;
	Fri, 14 Aug 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703575; cv=none; b=tP9TzItcHWlrXhMIeZZmdNNQQGES4U8wcyl4D6S0SOAP0tUjj5mbIUAvQbzQdxhJAPrqCxKG5Q2/ko1UxQgmXIXcBaHPeCbXYS7+n16aYaZs1FaZI1uhF6/sSxbeerqs3O0zkA5M45nZcTt67rX3ZzQH0nt/rrq+nr+dZMFUM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703575; c=relaxed/simple;
	bh=YVKfJkEmhEBY2ZixU/EKQfOZB2OvWex9FXCEwRtir/w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LGFKIPTrpApOJg+rrymQuwuqAvJ1UMB4n9lE9HWtUAnnWxD49y+iD/2WthWBbDYixKF7u+mkzSXYwsK9QPvAef4Qo1vpBn2YMkj0OR8p4krrHbU/IzFlNtgUIO0JSPm7pShb0HoQlTBr5x7f28/f97gllVfoIz8olLl+mWVPL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=cownlQAU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="cownlQAU"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB4EC3EBD9;
	Fri, 14 Aug 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786703556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgawlBX9Lnoo774oQSAS2j9ow5Dx0wAgHiOuNqve2GU=;
	b=cownlQAU137Y8F+DcWvvD+6laWc2zqF6GbVi4g7MMltvRDZaJ1LqmKqx3z9QR5KQJLsEBe
	KBmcIZ57XSwgX2W2bKN2gz4LA5BIUY4BNaE/gMUCZK0ETzp9jygwMeg2czpi8e71//pEPH
	btibkBZZPbK51Op2migAPQpRa+BmRlUYhZjrQyzSXlVFypHEKwti+1CkPyPkq7ZVxit6e+
	E8jm7ggsa0mJzi0vzmzIDzNB7arihQkWNZHOLoLTi3hlLdX5GVtQGajOEw/swALZV8OYYC
	mcNzXOprjRaB9YBOQ49REFKC/r15K6aKZAvo2FV4vwNBuilP/Qtywcj6I7Ebtw==
Date: Fri, 14 Aug 2026 12:32:33 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v5_1/3=5D_dt-bindings=3A?=
 =?US-ASCII?Q?_net=3A_wiznet=2Cw5100=3A_convert_to_DT_schema?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260814-violet-condor-of-expression-c491ed@quoll>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net> <20260813-wiznet-link-gpio-v5-1-ac8046f24413@marmottus.net> <20260814-violet-condor-of-expression-c491ed@quoll>
Message-ID: <C9FB7BBB-9E55-44CE-8E9A-2C827E2B8070@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTGN/cT0JjojJWfPg5GFRPZBWitIMu4DmlreldVHaSzqSlFBTwGubqlGUyN28v/mAgpBYDIorspQ/BrN+IakmiC8besX35C3gcU6w9rDaTH7r6w5J0saKhNNl8HxkBxo+iCdjUDezathGQOoN9fJUUAtnyqJfo5GQFlnygUWltKStgkjXrBjJIjvCM8PpPhtFQei1ghq3ZwcS4G8eeBMwNggYlxkAObuT1Tc8ukh0+2DxwnTpKi2zmNxREYxwJsr9snMBlQa0m9ZvYLql96xjCd+fB1llYeJcy+YPRjeH2T056GDjufL6tMsTcgc7DSy56b6IZ3WfZkwNggL74Ce3DmjUqpHVP0fbm+u9k+0tYevmH9KGzuXcw373LP9LECYTCeaT4214UTrnRqzzcNhUUoZTjkk6Wv3YPYBGeKHNOsjKfhepbgvxDTQM+Nig07mkdGPtdkQCFaTy0Vl/1ncJ+kXSrk3NKsUrmtJruCsTLyae5WdZMgQXJiYaRnLOyEtPHlHbO8/29ZDZzppl/bXFXckq/3mSQ/8gugnSimfy9eiF1TYJTfPmqZ5sELX0WeBUnhBMm7JSiGyGOtLtIZDACJIfPh5E7RDSWgd9Jf3hK86ssVFZPY1mMVyhuAAX0Fvw8tWp1ba/1mSjvuP8xYr4Yz8vPDZ7r+OGk5gAMp0cQjDwQ
X-GND-State: clean
X-GND-Score: -100

On 14 August 2026 09:15:27 CEST, Krzysztof Kozlowski <krzk@kernel=2Eorg> wr=
ote:
>On Thu, Aug 13, 2026 at 10:58:14AM +0200, Arthur Crepin Leblond wrote:
>> Convert the Wiznet w5x00 SPI Ethernet controller binding from
>> plain text to DT schema=2E
>>=20
>> Signed-off-by: Arthur Crepin Leblond <arthur@marmottus=2Enet>
>> ---
>>  =2E=2E=2E/devicetree/bindings/net/wiznet,w5100=2Eyaml      | 67 ++++++=
++++++++++++++++
>>  =2E=2E=2E/devicetree/bindings/net/wiznet,w5x00=2Etxt       | 50 ------=
----------
>>  2 files changed, 67 insertions(+), 50 deletions(-)
>
>Where did you explain reasons of dropping tags? Why would I need to do
>the work twice?
>
Hi,

I did remove the tag as I made a small change by removing the unused
gpio/gpio=2Eh include and commented in the cover letter changelog=2E

Apologies, I found it fair to request a new review not to go behind
your back but it was indeed a very insignificant change and I did not
give enough context in the changelog=2E

Arthur
