Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B91F2380;
	Fri,  6 Feb 2026 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.79.90.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374399; cv=none; b=Zoz9DWiy7QRewJnhMH793FzxKenpNAoWfExXslgtKI6tnoUpH/3LVdDGJWtaFD4H41mJAzxvZI7Si5wtRM/tKS862+JxTRJ9C4KepqkT1LAh6Bzu4C9YgcJwSA5xoAhZh5OmbKP7hVmyuRiZA5gGTbJCSawSubpwzgOypGG1MHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374399; c=relaxed/simple;
	bh=6OnxLe8EyUUzTBtYYOFz/C0thedtH48VjMALAeoKO+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7Wsg/FXd4l37o7y1YgRkVKqCmpwzylG7w2U71dbnpwXLBVSjADQTauQIT/Bcrl79zJTIYT+z/syq0a9T1bWq6OGV7p9b0SXwph3JZJvhot8vchISWszmmBDVzGfZhwzyNmq3U/uq5DDPZ2Ad/9g4oa3eE8tnvZeUgY9UBgCb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dev.rtsoft.ru; spf=pass smtp.mailfrom=dev.rtsoft.ru; dkim=pass (1024-bit key) header.d=dev.rtsoft.ru header.i=@dev.rtsoft.ru header.b=GN5GYebX; arc=none smtp.client-ip=213.79.90.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dev.rtsoft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.rtsoft.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.rtsoft.ru header.i=@dev.rtsoft.ru header.b="GN5GYebX"
Received: from mail.dev.rtsoft.ru (localhost [127.0.0.1])
	by mail.dev.rtsoft.ru (Postfix) with ESMTP id 6193583FE6;
	Fri,  6 Feb 2026 13:31:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.dev.rtsoft.ru 6193583FE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.rtsoft.ru;
	s=mail; t=1770373918;
	bh=LHMkTXnKnNt0ryQWtQStRCNfgK5XQzWzGDoLk6H5Ljo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GN5GYebXZ5yR4T7zQ1cn8lpIWBDvU0P2YxOg+XMi/2YO/pKvXyjtz7LWzVjgQ3zPu
	 gLzuSQPCMpJvi2UxEFQJ77gLEne1Y5UqmTUXkcDg1Ku7Kraro1roBbaUryp0E+sbih
	 8N3EzjaYFN68n3uhi7pc7bOW8jN0HaS/LXaKRRw8=
Received: from [192.168.1.2] (ip2504fb9f.dynamic.kabel-deutschland.de [37.4.251.159])
	by mail.dev.rtsoft.ru (Postfix) with ESMTPSA id 668B783FC0;
	Fri,  6 Feb 2026 13:31:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.dev.rtsoft.ru 668B783FC0
Message-ID: <0299e7dd-e3e1-4514-b335-6b6712d31713@dev.rtsoft.ru>
Date: Fri, 6 Feb 2026 11:31:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
 <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
 <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
 <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
 <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
 <5b8bcf37-5cd0-4c32-b0ba-3386142b7795@cogentembedded.com>
 <TY4PR01MB142820FC29E751D8C7F0B7C348266A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Organization: RTSoft Software Development Center
In-Reply-To: <TY4PR01MB142820FC29E751D8C7F0B7C348266A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

> Unfortunately, your argumentation is very _academic_. There is _no_practical_reason_, not to
> forward the traffic to the SW bridge via the HW bridge, even if only one link is currently up.

The very practical reason not to forward packet to SW when it can be handled in HW is - reduce SW load. 
SW cores have no chance to handle the load if you forward everything to SW at the channel speed.

The very thing I was trying to achieve when working on this offload support was - detect the case when a 
frame can be processed correctly in HW, and let it process it in HW, without notifying SW. And send 
frame to SW if and only if it is not possible to provide correct processing without that.

But this does not directly affect the case being discussed.

When there is only one port with enabled HW forwarding, there is no effect of keeping HW forwarding 
enabled, because the allowed destination mask computed nearby does not contain any destinations. 
Forwarding to CPU port was never handled via L2 forwarding (*), because L2 forwarding on rswitch 
requires explicit adding any possible destination MAC to the L2 table - which is problematic for CPU 
port, in generic case your software bridge device can be a part of a higher level construct, and you 
will have hard times to dynamically catch and process any changes in the list of possible destination 
MACs for the CPU port. For exact this reason, I implemented forwarding to SW port using "port based" 
thing, that is actually a fallback that rswitch uses when L3/L2 forwarding fails due to no table match.

(*) when virtual ports come into scope, a case for L2 forwarding to CPU port appears.  But still, 
"default" forwarding to SW is never handled as L2 forwarding.

Nikita
