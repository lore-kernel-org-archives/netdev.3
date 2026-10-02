Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F425B092;
	Fri,  2 Oct 2026 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916564; cv=none; b=I0jJhnnBtnkXLOR90xL/e4oaLQXzBHHsMFxwoRUW968CEwe08SQQCAw/WPsVDiqknMwbpUITKpszO62WTytcMxFsaEPZrLHgaTFWGE7nJnaw8ZnhSDlXx2wOh7AVJulox1quVjAY81RsK0T346Dt/1tgBv/vLqHjI1oZ7wpXGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916564; c=relaxed/simple;
	bh=hkHEJ/KbLAFH2RSOTU5YuMNrwvUynjCdQMMVOofwJ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEUUHSPz9N/WKoBNiMC4a+uQrc373chpuNjkCFXrJRhdo1gyNBP9PVv462rvUg8bPUakViLnwYGGBUVdrSvaTkGifA/KUisE7DciApeJQEkNDBTw7YU/YD2uYoD6BH6Fu4cgkEjWStWhg6M/thZeVTKqUwXAB3+LSoVWrnZWvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BDif7HSH; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BDif7HSH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BDif7HSH";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BDif7HSH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916561;
	bh=hkHEJ/KbLAFH2RSOTU5YuMNrwvUynjCdQMMVOofwJ2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDif7HSH2BiqHESLEGzE+9fAijpx7HGafLC2IChf8wHQWcIiCaZc71et97lE9UXqZ
	 GGRJReZudANu4w7bmvOITZgRWJrPqP659E/1Nye1/DJ7ay1dOYwbjo/aIWA7K+7nG3
	 jpWZRWFVHirIsFoH7vRWumP+R6Dc1gk4FTfXTUuNB+TxDC9AgsVQhYa7Q8HVlqvaEm
	 DcjcaUO5gos9rbTrny0yMKscuRZKG24KYohjcmineRqtkDSArv/BlSPs3YtpslVs1w
	 Wh447YMXRHBNuyQZ+N189wtgzbncPQrZ6GYSYkIz5l45GBgaj49jJd29CDWxbKhRTT
	 tZXbYL+1g0pIw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7258F47E04; Fri,  2 Oct 2026 04:49:21 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916561;
	bh=hkHEJ/KbLAFH2RSOTU5YuMNrwvUynjCdQMMVOofwJ2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDif7HSH2BiqHESLEGzE+9fAijpx7HGafLC2IChf8wHQWcIiCaZc71et97lE9UXqZ
	 GGRJReZudANu4w7bmvOITZgRWJrPqP659E/1Nye1/DJ7ay1dOYwbjo/aIWA7K+7nG3
	 jpWZRWFVHirIsFoH7vRWumP+R6Dc1gk4FTfXTUuNB+TxDC9AgsVQhYa7Q8HVlqvaEm
	 DcjcaUO5gos9rbTrny0yMKscuRZKG24KYohjcmineRqtkDSArv/BlSPs3YtpslVs1w
	 Wh447YMXRHBNuyQZ+N189wtgzbncPQrZ6GYSYkIz5l45GBgaj49jJd29CDWxbKhRTT
	 tZXbYL+1g0pIw==
Received: from [192.168.2.51] (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D221D47DD5;
	Fri,  2 Oct 2026 04:49:20 +0000 (UTC)
Message-ID: <24c530bc-e6a8-4f38-ba9a-0370acac6fdf@birger-koblitz.de>
Date: Fri, 2 Oct 2026 06:49:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 03/14] ax88179_178a: Fix endianness of pause
 watermark register
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Jianhui Xu <neuromoments@gmail.com>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
 <20260929-ax88179a-v14-3-a1f2249e42ea@birger-koblitz.de>
 <20261001181453.23ffac71@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261001181453.23ffac71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2026 3:14 am, Jakub Kicinski wrote:
> On Tue, 29 Sep 2026 05:18:51 +0200 Birger Koblitz wrote:
>> The 16-bit pause watermark register is little endian as
>> described in the ASIX 4.1.0 out-of-tree driver. Correct the
>> register byte sequence but also swap the configuration values
>> used in the code in order to keep the current behaviour.
>>
> Looks like I already applied this as commit a4e22e9253e7ed ?
> Please rebase on latest net-next it should drop you, and then repost
Sorry about that, overlooked the obvious.
Resending.

Birger

