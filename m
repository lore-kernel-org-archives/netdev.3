Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AA3546DE;
	Mon, 28 Sep 2026 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570476; cv=none; b=G7sh0sjc5qOri6rzmVWSbAstLL4+98TB3e8LlIFiowzAzvDXys0VGrCE+lkPy4VjIza4wm+9E9wZFFrAXjkXzQWcM5XK9cObKvA+Zlw64Nhz3m3dsEYTKJAOCljx6T0GaCj9z7m1gfzbdvPAfMzL149072BMzremL+/R8ghM6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570476; c=relaxed/simple;
	bh=Qtn38T9yEm5zd4cKcGAxVCPnrnB+1QUYJYVJUF8RNUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3XxWXeCBN73lpA0uRPNaKIWiVbTB48BSwc4TAK92fsdf87zqoC6XLL3Gm3pSjv41ZWY7lgyiQwuebaAtPYvrhfUK+37j8COJ8YNKOf4SELFIetLrgaUFwWm61XrC9LIZavdKu3gql7LuoDxXbGwIIPCn3qfxwcgS1DmEs5kTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NJYk3YZ0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Pmaf/QmK; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NJYk3YZ0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Pmaf/QmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790570472;
	bh=Qtn38T9yEm5zd4cKcGAxVCPnrnB+1QUYJYVJUF8RNUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJYk3YZ03pCVnUJyC7PItYfgm9nW2isvvAhRjdjKgkLGKw2qs/GnJHQi1bJFXU32a
	 bZi28NHiubbFJSdDRrlC1KsjgNbv1j0iL8js4D+6SBdzLRjTIOxWnyJs2sXs83XYdn
	 DwcuAs9hAMYHxmdb0+ACwvn5kAZNs1uLv76+ltS4jtbx4Q5MXgqnhspW9p975a98zo
	 /OvMshWRAC2AHpCRgDxHQuzJHAimRpFWmn+02ka4NPiF3+XYuQ7VbwenTqqYHase1i
	 Gis9pziGrS+/pljKqj4PTv5LUOIGdt1mYOWOwO+2FJ0iA0EbtKG4l2SvsDuYKkJ4BV
	 GXmAo58CA7X/A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B781E421D2; Mon, 28 Sep 2026 04:41:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790570470;
	bh=Qtn38T9yEm5zd4cKcGAxVCPnrnB+1QUYJYVJUF8RNUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pmaf/QmKTVYA0EVXeWt6AamRtSfRiRtS7uDPJJ1ikgI7moYOTpC45swCb8JKrXSAX
	 N+eYTumNEkjOFfCJEWQH0L455DNd+Ml8keaywQuO9fJ+CdD6IAO2zxlDtJd4tQChRa
	 pzTdDbqq/ZQUm5H1u3RGgMimmlQsXHd42nv+FbexapOl+gDUO8m/kTLcdd2JBsg29h
	 d6bOZamDk4X3RCy1Yyc4vRW+CwCBNttL7XeaSw6DrG2s8XEsUZO0shGQReVbaRJgA2
	 DuW2f3QPlntRatjkmbe37lAkn9FwNFbpSHPgdaxGF5cqwK1sLxp7N7i5DSSeYvnBE/
	 TySmDtwyAS9fQ==
Received: from [192.168.2.51] (p5dd1e959.dip0.t-ipconnect.de [93.209.233.89])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2A5593F52D;
	Mon, 28 Sep 2026 04:41:10 +0000 (UTC)
Message-ID: <074fb937-52fd-4806-b225-c495e874baeb@birger-koblitz.de>
Date: Mon, 28 Sep 2026 06:41:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
 <178968030096.22033.824447734953057557@kernel.org>
 <289700c4-8569-4160-97c5-2fc37a901a9d@birger-koblitz.de>
 <f27b2a1c-afb7-48db-9682-acf6c0a83479@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <f27b2a1c-afb7-48db-9682-acf6c0a83479@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2026 4:24 pm, Andrew Lunn wrote:
>> You ask: On a busy bus, or when a transfer stalls and hits the timeout, this
>> blocks
>>    all other network configuration in the system for a long time.  Could the
>>    clear be limited to rows actually in use, batched, or moved out of the
>> RTNL
>>    section?
> 
> How long does this typically take?
> 
> And what is the worst case, if the device is hot-unplugged?
> 
> If these values are small, i don't think it is an issue.
> 

I tested this on an AX88279 with SS and AX88772D with FS.
In both cases the time to update the VLAN offload table is 165ms, there 
is very little statistical variation, since 768 transfers are made, 
averaging out the individual transfer times.

I then did
sudo ethtool -K enx6c6e07090001 rx-vlan-filter on
and unplugged immediately the device. This is not an issue at all, since 
now all transfers fail immediately, so the whole table setting takes 2ms
and then the device disappears.

Finally, I started iperf transferring 2.5GBit/s and only then changed 
rx-vlan-filter. The time to completion was now 173ms.

I really do not believe this to be a problem. bind() takes much longer 
because of the wait-time for the PHY (phy-wait: 250ms, total: 320ms), 
which is also seen e.g. on the r8152 driver (total 400ms). And bind() is 
the much more common operation in practice compared to initializing VLAN 
filtering.

That said, I actually managed to introduce a bug when adding return 
value checking in v13 for the vlan-offload function, as the positive 
length value of the last read was returned as an error. Will need to fix 
that in the next round.

Birger
