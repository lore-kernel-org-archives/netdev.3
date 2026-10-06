Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233349E13F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303724; cv=none; b=P8plZqmKGNp25cnMCMZ1a0FdJkaM9/2jkMRQ4g2+EkCLljEYXHkFToBirkSGK5K3OAIymsReETR0yzNlWCmGl5TCSsf6cziiJf/aOjfXxhWz4UUnI9CLhxWF3xZGu9RSGxlK4Y+U/vllb39t2uPswlI6GT8t0v53AcCMUYbKt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303724; c=relaxed/simple;
	bh=/5K6FCyCZyI2h2cDIhsGGRqSHDPsga71tJatPBze9bI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fkpIH3tJOoRAKwitqLDe3gNjaCACqVbw3bHaIi4c2Tug2PXxBBL+2pbH2OD32mCspK4+rP2WiMvQ3sb9IUSIVwsjb686mF0U+sCivA60sWh5fnnMxMVE9iyTR3sWobkD9A7Li0eJJq6eZuJEQHb2cMV232e2S4VGcgIeBpuSWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=NQPC7TtY; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="NQPC7TtY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 548A6A0919;
	Tue,  6 Oct 2026 18:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791303716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ue1oBzLO8CMbnKTSj9gF4aRo702XwrVTvsiQMXQbTos=;
	b=NQPC7TtY/O3lNQcme6jSkOJTeVgqk0hQvAyiXM6i0ELgZHKcxDAiKhHjNSroZ+9CWTKLz1
	Ao6SfHgifOHBwJP9LwITtAPN1vDmkxW/bc7Nip67tcf0nVBtl72LY4e02HOeqLql4jAhKd
	CU9IR0AGFX/Bwht7d2aJ7E6uHrr1hn6017KjbV1NqBWYXdS338VxMGvI8113tTcoFXCZCc
	7ke1kFveDXaaE4d70q4xsuncSVr0skB6g9zyatx7nXOj08O4PeznDDn29gCk6F/ifL4AV/
	gES5WybOAP37yN7zdgufRci1OCKAF33C8hexP0QAbo+NVNH8GVc+XHfnDqZwtQ==
Date: Tue, 06 Oct 2026 18:21:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>,
 =?ISO-8859-1?Q?S=E9bastien_Royen?= <sebastien.royen@armadeus.com>
CC: netdev-bot+sinfo@kernel.org, Woojung Huh <woojung.huh@microchip.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
User-Agent: Thunderbird for Android
In-Reply-To: <027573f7-b768-45df-8368-6dcd4700e999@lunn.ch>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com> <179129640372.2231598.1056441247005614175@kernel.org> <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com> <027573f7-b768-45df-8368-6dcd4700e999@lunn.ch>
Message-ID: <317F33BB-1739-47AE-9107-F8FF3AE8B370@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew

On October 6, 2026 6:16:02 PM GMT+02:00, Andrew Lunn <andrew@lunn=2Ech> wr=
ote:
>> This issue was discovered when upgrading an embedded device from kernel=
 5=2E10 to 6=2E16=2E
>
>So is this a regression?
>
>If it is, please take a read of:
>
>https://www=2Ekernel=2Eorg/doc/html/latest/process/stable-kernel-rules=2E=
html
>
>and consider if this should be backported to stable=2E
>
>You then need to set the tree as 'net'

I might be overlooking something,  but the target tree is already net?

>
>https://www=2Ekernel=2Eorg/doc/html/latest/process/maintainer-netdev=2Eht=
ml
>
>	Andrew
>

Regards=20
Nicolai
