Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326341E6C0
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578418; cv=none; b=YGe2oeYjKxO1Sv550gmV00FK8eX0Hr+PHFZdK78t9kXIKr1YoOC24kL8XdlEtvKikPrFTS1TaoiHxDtA/0BIMPdu6ljKUJnIGQDYQDqR4i7+roWy3FtyzpZ/0VnDp2qUM9eSg6QA2xkqEfc2EzgiQagclw1hWhZ2SeeOC788VX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578418; c=relaxed/simple;
	bh=zKUwciwhQ83G4tAeptftzEwAkMXN+6+XBxt889N0S2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAI+Fezb/sBbP9sAMkkEO98uqoOazuI/alxiWA4cJ0stZs08NG2hKXw5VMYUhZxrgTQNXRUs+6C2f3rerfPrnMW3YVjCK8tQ+zds1ZMYpy+8BZ32XlUyfBncsdTSrPW+Xyc2XliT/Zm7WM7m7dgA9XcQ7plzMoercwFIbWhtXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=inr3Uboq; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="inr3Uboq"
Received: (wp-smtpd smtp.wp.pl 32686 invoked from network); 9 Oct 2026 22:40:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1791578408; bh=zKUwciwhQ83G4tAeptftzEwAkMXN+6+XBxt889N0S2M=;
          h=Subject:To:Cc:From;
          b=inr3Uboq1a5sDG5PtFrP9qLUH8h6zug0tMKSJnHNHDPwn7Fjg58lf3RDA8W6uc5+4
           SVeX3Q2genPHC9ktJz03hP3sCe3hKBzuJuvZWK/uAh6tqshRslcMrAPMEs4MjG5unP
           embykIzWhkJqY6MAvYl+h6qKNllxRAO3iohnaN+HhIgCXy6UamfTYUlCPs35lp19QD
           VuOKgN0FGUCUhAdxLvgRkN2kKu+MUAn5ezwlTByKyzA+E4QkihfW3tdJlPCwBaeQ2i
           /XKgKRiMlLsHZ13d1AfU+T1tp0h+R43tm9EQIA/n1Now2Sw013aic++gXJBFPk10HX
           M5J+MATC8f4Pw==
Received: from [192.168.3.224] (83.5.180.159.ipv4.supernova.orange.pl [83.5.180.159])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 9 Oct 2026 22:40:08 +0200
Message-ID: <f3d2f5e0-f9a8-42a5-ad83-07be215ca690@wp.pl>
Date: Fri, 9 Oct 2026 22:40:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R
 PHY
To: Andrew Lunn <andrew@lunn.ch>, Konstantin Meshkov <skyline@mail.ru>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org
References: <179152610952.2918676.6625057760354797023@mail.ru>
 <1bef1633-8213-476f-a019-f29a71553e09@lunn.ch>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <1bef1633-8213-476f-a019-f29a71553e09@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: f1432442553b9cbb8beb52948a4aeb53
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [keNc]                               

Hi Andrew,

On 09/10/2026 14:15, Andrew Lunn wrote:
> On Fri, Oct 09, 2026 at 09:08:29AM +0300, Konstantin Meshkov wrote:
>> The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
>> through the same page 3 register 0x10 LED control layout as the 88E1318S.
>> Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
>> so the PHY LEDs can be described in the device tree and driven through
>> the LED trigger API with hardware offload.
>>
>> The LED polarity is configured through the led_polarity_set() callback
>> shared with the 88E1318S family.
>>
>> Signed-off-by: Konstantin Meshkov <skyline@mail.ru>
>> ---
>> This patch depends on:
>> [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs polarity modes
> I've not be tracking. Is this merged already? If not, please resubmit
> once it has been.

I was expecting that Konstantin will send a patch that only adds support
for LED triggers. This patch should be simple and I expect it to be quickly
merged. Then I'm planning to include LED polarity settings for the 88e1116r
in the next iteration of my patch.

Best regards,
Aleksander
