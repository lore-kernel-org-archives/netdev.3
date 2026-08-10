Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022E37C900;
	Mon, 10 Aug 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348872; cv=none; b=bnmVUiMhlXU9bP42koxLT51VgXBO8RbvSl03RrVb1PNvoPswvahxLMRoSVQEFMsUzAgIHjoWckX1V4AIEBjPdSppclm3xMhonnaO0AchcC9oKjND7Fz47BQPK180ViUxi/xkJ7UNzRgurQkzp07bBr7GbyC7SFR3ttiOh4VK/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348872; c=relaxed/simple;
	bh=MQgZ6qYvB49t+7+YYCJGgcNvepS7+xoZ7fKBM6lNzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaGg4AX6pbrXa2DfToLcm35zbkQAx75oOA6VaxOpZNRE0MCOw18AXh3GJ5wOhpwIXFLfSrOf0fN/3/5eLA//QlkbllK95ILHKa1PaLm3G0FZxOnzhaZExbvI+fS8pN7aDsBlnOLyef983ILXozrABHf1yKvrH3VtQm1QfwXSoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=i5tLCJZM; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="i5tLCJZM"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 84C2C58151B;
	Mon, 10 Aug 2026 07:50:28 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A7EA3EB1D;
	Mon, 10 Aug 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786348220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQgZ6qYvB49t+7+YYCJGgcNvepS7+xoZ7fKBM6lNzLY=;
	b=i5tLCJZMfIwDwhN3HoS08GcZakWL5i/sTY+1DH3QUTGmy9Ds287uic86Fjyr02XSV4ak4I
	UOm7fCpdNIPQWEDnLp6te6WaWtuw07OQSewoa3OqGMuK/u8XSbEgKet5ZVX1ut+MbHQ8TX
	pq9WtsNB9pS3Tign7FvhUnueRMFOs1d6D0/lQjNHnEDN4qnd2ymY+s9UuruYRdL0q9BlQV
	nULyvEJOZz9PJlmJcVQtoe2ow7qUBgOXHib+stqk2R9SpplFl3SImpWVW1g5qXIKIswUKz
	kXLPUegIPlMxmIKavKMYOCrp0E/s8tMjTNs9pSUaPYfHse3IEtZ1/5CeoJ2Mmg==
Date: Mon, 10 Aug 2026 09:50:11 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
Message-ID: <anmCs5tld5qMxyza@pc-du-fromage>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810-arrogant-anteater-of-economy-ef2078@quoll>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTFSnS5kAs9pSLL+ecXo24vhCBLycYFoCUboiCCFmaskT7MEj1xd9brI8v0zdaTP2sTyJ5SJqKMFmcIyM4YI3y0N1hHHDytR7UHfNTo9CoBzfEWdjpnrBDDx7wVzWOS3ylhkQiCHFe3u6AXkrZyQCoQI/PQuMqUpPRXH0v3aP+hR34HH4i0MbMSwyqM7pT9DKcynMgQF09TPHSjE84qxQb2z+Okvqx6+q+FRr3sct5cSX2clO8R3v4tQMWpgh4W9RvmlHymkiUUDwtsqDUtCKAPOsxT3npvsha+MMEOkPWQbbJy3F1RduDM9DbuROFRwYSPJ9WZz5gwBKBrCTsHMhZG6r+Vrc3Bsw7cfGkaKDaChH94tJfwI9k7/rMpKOXeyxgZ6lbqN7O1H4Uhn5beIMd0IHS8qgcpNHb7ZPUOiLBywn1AGUSpP+uaMnXFjEhFsAnre2KJP8OER09BXLjHAMeQGysIYBOBxOK6xDOCldnUaP8IGbZbkGjUp7Kjxgd5gzBz2ntyvEFKpKA2PYKvGdMYgkXYBWyYtkYclYT9QEuTqWfAGCRyY+Cz7A+sX+HGfB32CXx0nxZocJobpN6qyt5S89M1u/latLoF36Hp7s8+ofFm60sNVPSD5CdFPZuJS8iQTaeNMJP+Sv8Dpgr/+Srx+PDGHfEuJWmgWSgvXSaUZGA
X-GND-State: clean
X-GND-Score: -100

On Mon, Aug 10, 2026 at 09:43:21AM +0200, Krzysztof Kozlowski wrote:
>The message is confusing. If you describe it from the host (system point
>of view), then interrupts are not GPIOs but "interrupts".
>
>But maybe this is OUT GPIO from the system to the device?
>
>Best regards,
>Krzysztof
>

It's an input on the host that triggers an interrupt on the host.
So, yes, you are right I will change the description.

Thanks

Arthur
