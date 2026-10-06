Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425913E40FF
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322140; cv=none; b=kPbLDr+QkIXpWjrY2n8rfVqP5luiU63igFZwAdnaPp0mHhMPUtDVlA855QupKjMR7GckEfkHMhDU1JRX2j5wO/wyxiS9SLROgujrf7xdu2bXmbjgQHbhVPRodMZjxdn8J7XbtG2vmpaHZBP2s5rDLZ749YQTJKiZGveutA2Vn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322140; c=relaxed/simple;
	bh=Nl6+n6OisRQvx7AOxooCkQj8uwGqHMXXdmGU8ZyUHuc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=slKfMM0a0xjyE9m93KOEYTDpO1Ii4FXXSHCsgKSLV/Czrh621rXblBU83l2w/XtxNfAsGEJh/J/KVf1D9DuEzNaEW96ItEL/mxHRgq0dIi8VgpjA0kRoKT+wlqg3vRLIf6GCFahJ0WR6n8d+i2l6tGdmc8q5brmnvoDa+c0IMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pO4ft9Ey; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pO4ft9Ey"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5853CA0919;
	Tue,  6 Oct 2026 23:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791322131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kbxQ0OO+7af7AK8EfkEUU9e0IBOGHXMuIONIwF2Ti1c=;
	b=pO4ft9Eyeh5BSw88/21bB19G4pSig3hqwJHaT6wh5L9V/Ql/bvp8iVcPnp0ff9oro96Q+Y
	8cxFs2mXkLHIe2OIqh9tdysF03I1MLGdPGwaHbKPG5dcmLSCRJdvu1G2QbzCzWIiaFHUn/
	FsBCYvgXZu/uWEQtSkPqG3zb0QkuIRO5AKo9K4zJ7GLpNmku/bmDzme83rVEjWTv9OfJUt
	Bm2aJm/znLVilMpiFPvpugKGxRy1Bn1kr2CEp7zXLCu/9jrPQ+TLI2VP3vbI9PzOGGm49B
	8X6CE/acHZlqJA5S17POWzRxyO56T6P/8jH3QsgDmKpzG3DCcJyYkDz2Ylu2mg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 23:28:50 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?S=C3=A9bastien_Royen?=
 <sebastien.royen@armadeus.com>
Cc: netdev-bot+sinfo@kernel.org, Woojung Huh <woojung.huh@microchip.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
In-Reply-To: <b20c5ba4-08ed-49c0-af9a-2a81a45a3ce5@lunn.ch>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <179129640372.2231598.1056441247005614175@kernel.org>
 <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com>
 <027573f7-b768-45df-8368-6dcd4700e999@lunn.ch>
 <317F33BB-1739-47AE-9107-F8FF3AE8B370@tipi-net.de>
 <b20c5ba4-08ed-49c0-af9a-2a81a45a3ce5@lunn.ch>
Message-ID: <8767dcf1eddd3b8d8dc2ec5bc82f8515@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 6.10.2026 20:24, Andrew Lunn wrote:
> On Tue, Oct 06, 2026 at 06:21:52PM +0200, Nicolai Buchwitz wrote:
>> Hi Andrew
>> 
>> On October 6, 2026 6:16:02 PM GMT+02:00, Andrew Lunn <andrew@lunn.ch> 
>> wrote:
>> >> This issue was discovered when upgrading an embedded device from kernel 5.10 to 6.16.
>> >
>> >So is this a regression?
>> >
>> >If it is, please take a read of:
>> >
>> >https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>> >
>> >and consider if this should be backported to stable.
>> >
>> >You then need to set the tree as 'net'
>> 
>> I might be overlooking something,  but the target tree is already net?
> 
> Oh, yes. Was it a missing Fixes tag which made me think something was
> wrong?

Yes. It should be

   Fixes: 91a98917a883 ("net: dsa: microchip: move switch chip_id 
detection to ksz_common")

Sébastien, can you please resend the patch with the Fixes tag? With this 
change:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
