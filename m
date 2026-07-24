Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8E43C045;
	Fri, 24 Jul 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905575; cv=none; b=KmE2FzoC304L6xmvFWhxoabCeV/6sq6guaUll+cEVRu1uUAcujufidXRdcmsDDtRIpXOpY1MH50i/2GDdUcm7wB/XWE5bPvvnjJ+IVEjZdMp09cuBQvNArUMPDVWj16rK/uBkWVRXkIImLtoOSHj95CIVy4/FEMXlDsODPhMo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905575; c=relaxed/simple;
	bh=lOhKWl3vaCvNrTXzv/BPCXUTZ7yCtZDJM3Ldey4Cruo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AF2ZSVABns8wN75NOvnj0Gybv8c0nyP91i440xKl7X0lEdCXAYrfnxvXmYW4fzS6fzXcP/SVLOMVCAZnyetlE2ehNR0ZE/uv8nOiDdy5gX6Y6bhtK3YkvAK9gKrlF0x74ER/5QeEvbkD6m+Yd7N0ll/wGaOYUicvLZAdveI/qhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=o+dO10Yd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BwBiQSWd; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="o+dO10Yd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BwBiQSWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784905571;
	bh=lOhKWl3vaCvNrTXzv/BPCXUTZ7yCtZDJM3Ldey4Cruo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+dO10YdH8oi/IFrg8T7/GmRiBW5mEPgriH3A3mZRhOmS0lQFAx4ctxnnEebVwweJ
	 GDpWdOgHYNnPAail2jnR9ZzF4R9KOdW7S0GBWTVOTbmRWes1KpW6MabvPtCrF3G2nA
	 6yPO/hFaocrVIojqxce+I9c1GoshdSMwlTydFmY6sr02xJ05zkvZ7jzUjHxUsflIMo
	 FCf35fOE2wneDTiuarK6G6oCwpsX6II6VDbbYHY4TenWwcdy8GBDOqgdW05cSi/fk+
	 29U0DJjK1O+7+CAeHrU/+0fWk5JuXgak/3w93SazmeK+jklRVglCRttwAciigNMOfL
	 7G1yjAyltCggQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 02F5B493DE; Fri, 24 Jul 2026 15:06:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784905568;
	bh=lOhKWl3vaCvNrTXzv/BPCXUTZ7yCtZDJM3Ldey4Cruo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BwBiQSWdbuQDUA0apwpv+YfoV0um7eERZI0zNj767ytdZvivpL+N1gp0CM47EZDt1
	 lmTVfEY6KgWT09RunLN2rBxH2d3Azz2+kNuETWyLJ7zpFJab43TVvY49yuLkPhRhjL
	 OzEKIUsHXuXKSwmA9HMT8PqkHPO38xGUKlwTvBZ1+chrYLEMQS5Vj6/iJiLQ3uE72I
	 SMTpALlcbKJHgArxxNYBVyz1UQSxku+f+edkSTyv3NvjPQt1vPBSS9HUisQwelU7yM
	 rMay6wU6qN62Mkff5nw8k+cGieYNhICxXxCTELjw/rMGfUXI6oW8i/ajSRVNW1FC3M
	 bJ4IGFlBQUTNA==
Received: from [IPV6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258] (p200300c69f1c3c0011126ccacd9ab258.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 947D648EAF;
	Fri, 24 Jul 2026 15:06:08 +0000 (UTC)
Message-ID: <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>
Date: Fri, 24 Jul 2026 17:06:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
 <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Thanks for reviewing the patch-series, Andrew!
On 7/24/26 15:38, Andrew Lunn wrote:
>> +	if (data->phylink)
> 
> When did this appear? Am i missing a patch somewhere?
> 

In [PATCH net-next v3 02/13] ax88179_178a: Add HW support for AX179A-based chips:+	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
But admittedly, this is a rather big patch, which I was unable to break apart
due to in particular int ax88179a_bind() referencing most of the rest.

Birger
