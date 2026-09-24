Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F32C924
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275433; cv=none; b=WTTfY1nCJTNOuJ43tpfb9K5zvoXLWwXOYmF+JhFuXsTjkCnKRy1Kzv15o5mXXbNB6VKfC2Yuol0CGuribwH/DkC+vVQc2I+htU5rmeaYRo4p6yukXVuhD6L0fc5DDVE2l6qTgRu7XaQkop/YoNGPVid87PqRmNc4SmRxZ2pZt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275433; c=relaxed/simple;
	bh=Hjx/sgWEVYh1okXrYg2KqiJ/ZTSCZPFWtVGIwsEMAYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uy7iqZePOwDl93KY7R39FU0o+XZLWI897cCpNDE0nZXdHrpUgh2gZSKQYfjJTrcZ7REX8cjr0mnGU+bjL5KPzo7avPYjytlkB+ZfDztRwedNRWaf8XYQd7GupJ8ljcJglq5HGpkWwiYUOs5cJf29GTRlizxMOBafkBSRCrRStsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=BZBwKGEu; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="BZBwKGEu"
Received: (wp-smtpd smtp.wp.pl 8094 invoked from network); 24 Sep 2026 20:43:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1790275416; bh=Hjx/sgWEVYh1okXrYg2KqiJ/ZTSCZPFWtVGIwsEMAYg=;
          h=Subject:To:Cc:From;
          b=BZBwKGEuYq/514zPgVEURzzakm+CWJbmVMiCnjcYp0ZEix8PaE0kvM4Y5Fg8pn4i1
           RV58E9Mg0urwJgRJh/XCa42WLz4x5bAHtFxatKCXY3z9Tfdxmuc4U5EUZr6QmN4XsJ
           iuIfU/qKUFvnewDVL9wBMYrxBtKwCQPMvAzuW+bd86zhzFAkhX0Sgd50pxGYIQKxVS
           7mthz86NMZGafW0d4J/bJYQ1vUffsSWkDzGawAn4F8SqdAZ6qoandfu7mUbhIRBhak
           1xTjs55jCermmKwk7PTeWlPby/cLAZHJlwCcH9asZ/NqB2Kr9BAbLkVUg+2Qm/LkRZ
           cnD0p9IDin0Ew==
Received: from [192.168.3.224] (83.5.247.11.ipv4.supernova.orange.pl [83.5.247.11])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 24 Sep 2026 20:43:36 +0200
Message-ID: <faa87607-4be0-49f6-aafc-a37b3d9a237b@wp.pl>
Date: Thu, 24 Sep 2026 20:43:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260923204614.471409-1-olek2@wp.pl>
 <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
 <a174b2c7-3778-4f8c-be5a-2bd94bfe09ed@wp.pl>
 <c9c0e770-6bea-4acb-aca2-ac56f044ddef@lunn.ch>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <c9c0e770-6bea-4acb-aca2-ac56f044ddef@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 978138af27d019b3689ac8b2779759ca
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [AdLs]                               

Hi Andrew,

On 24/09/2026 00:54, Andrew Lunn wrote:
>> The number of LEDs depends on the PHY variant:
>> 88E1112 -> 4
>> 88E1116R -> 3
>> 88E1240 -> 4
>> 88E1318S -> 3
>> 88E1510 -> 3
>> 88E1545 -> 4
>> 88E1548P -> 4
> Ah, i had a quick look at the current code, and all the functions have
> a switch statement with case 0, 1, 2. So i assumed that all PHYs have
> the same number of LEDs.
>
> So any PHY which does have 4 is currently not supported?
Correct. Although some PHY variants support 4 LEDs, only three can be
configured via the LED API. The fourth LED can only be configured via
the 'marvell,reg-init' property.

Best regards,
Aleksander
