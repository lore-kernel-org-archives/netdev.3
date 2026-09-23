Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F2345CCA;
	Wed, 23 Sep 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197304; cv=none; b=ihx5S633di5Wk5wU3uowGHfS0Qa+nbupNEcl+T2CigkcNUX+7kELhphP1SYi9pFlgqp5PKSdN41eCrYBTzP3tZ8bwBnUeZXQGizPmXcJGKw8z20GUAcf87QArOJBgU7yhyGdjAE/uOFILaUm4+IAKgoSBv6xAcv+12AOp4+4M8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197304; c=relaxed/simple;
	bh=Dg/aeY7kTlwnOOtiNCmmG0bt1l4X6z/k5ayTLituIJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAp2yYLEzQ5yEpAKMF/xxNTKMfprhF12ty22KGGIVxPTJhef69Xel+k0vuTknfNC+zEKdC6zjLLsZQQPaqiomXdDhFbb2VpDkzgR9i5uYu1T08kehfj2m5A35DvFH+zepLTC3M/ZZZCD86JHOilG6aiRAxBnHBosCJ6wlI13O/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=O73ppuCx; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="O73ppuCx"
Received: from [IPV6:2003:ed:4708:38a0:7b81:aa82:3807:35d8] (p200300ed470838a07b81aa82380735d8.dip0.t-ipconnect.de [IPv6:2003:ed:4708:38a0:7b81:aa82:3807:35d8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id 22C37400AA;
	Wed, 23 Sep 2026 23:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1790197230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iVE5wQUd/v2jDn02ZGJtFFXOibJs/w2KTJJLx/xoKW0=;
	b=O73ppuCx/ainZ7EN1fkGbk7ql0xyhErqO0cle8n/260KkL7uIHMvbyJAMV1UUAhsvFTIL3
	ivS3iyFqRr0ySNP1tL0Xgm9PGOYzpYsfOlJnhxx8VPEelGvaspXqVIXkGbBunm3EgQxiFf
	Gig1CQajtcGb2NqAERT9Pp6lkHmTmmmLR3fKphyJJZQ8zM1k9pK08i8glrHNcINYHTrBzM
	81+veFPcLljGJadUjudedPnYuReQyjch3s7Ya6o2zgwZdfVhJDHm3PDbikFzETyVy2AjG1
	aBe35peHgeEGa/mTtni+ZONUsfIvQ++hH5c4GyauRit3/O7fxbUHujRzKXocDQ==
Message-ID: <8a577d70-6038-45d4-821b-ddc3852feb13@3e8.eu>
Date: Wed, 23 Sep 2026 23:00:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260920192632.72729-2-jan@3e8.eu>
 <b4a42595-295e-456b-82a0-91076f72407d@lunn.ch>
 <64e712bb-4c2a-4738-9f99-7c8496e2d4d9@3e8.eu>
 <640a7c34-38d2-48a9-a647-9298318f7c8e@lunn.ch>
Content-Language: en-US
From: Jan Hoffmann <jan@3e8.eu>
Autocrypt: addr=jan@3e8.eu; keydata=
 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
 AqNjQxfojjo=
In-Reply-To: <640a7c34-38d2-48a9-a647-9298318f7c8e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I assume this PHY does have a valid ID in MMD 1-29?

Yes, MMDs 1, 3, 7, and 31 all report the same same ID (0x001cc849).

On MMD 30, the PHY ID registers return a seemingly random value (or 
0xdead in the broken state). For other MMDs, the PHY ID registers are 
all zero.

> I wounder if we can make use of:
> 
> 	if ((devs_in_pkg & 0x1fffffff) == 0x1fffffff) {
> 		/* If mostly Fs, there is no device there, then let's probe
> 		 * MMD 0, as some 10G PHYs have zero Devices In package,
> 		 * e.g. Cortina CS4315/CS4340 PHY.
> 		 */
> 		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, &devs_in_pkg);
> 		if (phy_reg < 0)
> 			return -EIO;
> 
> 		/* no device there, let's get out of here */
> 		if ((devs_in_pkg & 0x1fffffff) == 0x1fffffff)
> 			return -ENODEV;
> 	}
> 
> I assume this is not hit for this device?

The devices-in-package registers (5/6) have the same value of 0xc000008b 
for all MMDs (0-31). So the variable devs_in_pkg already contains that 
value at this point and the branch is not taken.

> I _guess_ there are ~0 PHYs which probe based on ID values in
> MDIO_MMD_VEND1 or MDIO_MMD_VEND2. So maybe move the code looking for
> device present in MDIO_MMD_VEND1 or MDIO_MMD_VEND2 inside this clause?
> Then in the normal case we never look in these registers.
> 
> If we don't look to see if the MDIO_MMD_VEND1 or MDIO_MMD_VEND2
> devices are present, i assume the next loop:
> 
> 	/* Now probe Device Identifiers for each device present. */
> 	for (i = 1; i < num_ids; i++) {
> 		if (!(devs_in_pkg & (1 << i)))
> 			continue;
> 
> will also leave them alone?

Since bit 30 in devs_in_pkg is set, this loop is actually where the read 
breaking the PHY takes place. Currently, it is phy_c45_probe_present 
which breaks the PHY by reading register 8. But without that, the same 
would happen when reading the PHY ID from registers 2/3.

> But if there is an oddball PHY around which relies on MDIO_MMD_VEND1
> or MDIO_MMD_VEND2 IDs, we still look there, if we failed to find
> anything anywhere else, and so hopefully it does not cause a
> regression?
> 
> 	Andrew

Thanks,
Jan
