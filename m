Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A214499BB;
	Fri, 31 Jul 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514344; cv=none; b=mi/epa/3bNePiNGsC6atrJlAG6cJ7jVxN+MT9FP5koEElZjmPLH0D+gv9sLEpyvkyZQgoASH+VIZQyPLbmxRI36jU42uNsK0YDAVmixIAqyIz/GKoGg8WNmcCzxAIKVX8NyY4M5B95LiwluhYsbcYtSttXDR+MQ0XGK5bUW9eQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514344; c=relaxed/simple;
	bh=kcZ+RNr7XdnGnY+wFRtrg4jim/4yt6hYdbLxw79pNbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6JCZYckCqOQw67U/7jhLvq4Hp4xZe13Nozgydk3SMwCEbTy5Cdhw4NxAT2rrj7LL18/xEunzYNQHNDSQr3kDh+R3ykFUKGeoD+nvWLbBTq2Bl/mEEwF6Z15GYgx3mS3Z+159HBzfnjlbd7s6lZw2L91BnQwJ5u5Tnm3oigULy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eQVRQIO5; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Pvt0s9Ob; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eQVRQIO5";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Pvt0s9Ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514340;
	bh=kcZ+RNr7XdnGnY+wFRtrg4jim/4yt6hYdbLxw79pNbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQVRQIO5V6ZaYuTlKoMNWPTkNlSAlN1HsH0UeKMPgFLH9MzYM9F3bIbGMVy+tBy05
	 LAt4RnT/plNCp2/mxDhdg53doOGlal6JhpDvvuYleUCsHO0HyVpXPHGauKLIkmOrce
	 atV8wkT1IHYMwdtsJzwpDe5RQtUbR+9Fn3FabBQg5hDLYYTNO7BD0GBT6CxCh2tqfZ
	 vKbtXH1R155sa1UsTTMyrqXsoQaxypClTz0zCXTbr+hPA44NzZO+xcV+vwTA2RhAxr
	 CETDZXxiV3ICnc+g5wQbXnJ8xooQsa2o1mwtkARxll5RmuCpuZOG4/zHZhgFUxz2Rg
	 7pqFx8tAHyH+g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 54B62494F6; Fri, 31 Jul 2026 16:12:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514335;
	bh=kcZ+RNr7XdnGnY+wFRtrg4jim/4yt6hYdbLxw79pNbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pvt0s9ObYbz1lbPY4LM5KCAiJfqo8CNrvZiMl3PUwi1G0okKasIBmlTwQyb8tQ6GV
	 qrIhCTfuODQmCkB7ISm0XN3ZE5aGMeS7KyQJzytk1jPIlaqajPxD3OWaH5njwhNtVw
	 +qUINukqWxS8acm7DaEn5TvNwoIwGGOy8wKNzwrrULvbQpyDILZsVvtXl+DW3K0AUt
	 dJr7lnNlDYLLgo2ye2u0fmM/6fEeQJd5vjDq7DI+NRGCq+noJhPkTLGV7e8sJnGXpn
	 RKNpk2f0hOZcAAeciiJBlMb0NrfkdQB6vU06pd5v90Ym+yXcG4cIYgVDp3WDPcqq1F
	 eW7AAWKumnxug==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B6AA7494ED;
	Fri, 31 Jul 2026 16:12:14 +0000 (UTC)
Message-ID: <c0848394-d29f-4709-81f7-a2b58e5a3449@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:12:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/13] ax88179_178a: Obtain speed and duplex
 from Interrupt URB
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-7-bdde4f905883@birger-koblitz.de>
 <434f6f0b-40ce-4f2c-95ac-1fe24ce38366@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <434f6f0b-40ce-4f2c-95ac-1fe24ce38366@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 19:01, Andrew Lunn wrote:
>> @@ -506,6 +507,9 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
>>   	le32_to_cpus((void *)&event->intdata1);
>>   

> The phylink link up callback will however tell you the truth. I would
> trust it over firmware.
>
x88179_status() has been dropped in v4.

Birger


