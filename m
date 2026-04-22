Received: from mail.mifritscher.de (mifritscher.de [188.40.170.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19683D1CC6;
	Wed, 22 Apr 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.170.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861987; cv=none; b=WxEuxX3F9ZB1lkD5z7Ye2Lg9NDV7miW3T/BDNMUNi0VyWZp/UDvznKDrHawnP5pIJCjKkcO4ChZd/BqIwgqnhAqQvtDPnpSxgDeLWlcozEWhkRW9nRFT36fzs/HN8B5pjoUOJ9jc8KUyZ9EMxUFabWweYyrhtqLaClvBOSdyD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861987; c=relaxed/simple;
	bh=5XDs8cWdZXpGBsh4Aa38JGEB+lFfhkffirPSTw1NeOE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iEuvF5PiSP3tHcMrXMhUviuyF1+MX/qtZYnjmIn6yslaRMA2ps9jVqVYetncAurAa95P1ClEGQI8xLNpwJVNziA+NkOrLQixD5sMxIeXtq7jT601I91Bck5NtQCX0hiSIolLb391+bHt5cNncpSNZ0RkB/GAIpAN/wt1rG8VmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fritscher.net; spf=pass smtp.mailfrom=fritscher.net; arc=none smtp.client-ip=188.40.170.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fritscher.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritscher.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mifritscher.de (Postfix) with ESMTP id 6CE2B3B2728;
	Wed, 22 Apr 2026 14:46:23 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mifritscher.vserverkompetenz.de
Received: from mail.mifritscher.de ([127.0.0.1])
 by localhost (mail.mifritscher.vserverkompetenz.de [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Q2U_6VBKJUms; Wed, 22 Apr 2026 14:46:22 +0200 (CEST)
Received: from mifritscher.de (localhost.localdomain [127.0.0.1])
	by mail.mifritscher.de (Postfix) with ESMTPA id D83063B2618;
	Wed, 22 Apr 2026 14:46:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 14:46:22 +0200
From: michael@fritscher.net
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 14/18] drivers: net: xircom: xirc2ps: Remove this
 driver
In-Reply-To: <408d1987-6ecb-4d3b-afed-8e202c8ff21d@lunn.ch>
References: <73e3a34c-f1dc-403b-b007-18ff85d66ea1@fritscher.net>
 <408d1987-6ecb-4d3b-afed-8e202c8ff21d@lunn.ch>
Message-ID: <e36510873a1909a1bfd9a05cde99fef0@fritscher.net>
X-Sender: michael@fritscher.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2026-04-22 14:15, schrieb Andrew Lunn:
> On Wed, Apr 22, 2026 at 08:21:23AM +0200, Michael Fritscher wrote:
>> Good day,
>> 
>> actually, I do use Xircom PCMCIA network cards (yes, the 16 bit ones) 
>> on
>> Lenovo X60/X61 laptops as a second LAN card for server maintenances 
>> with
>> current 64 bit distros (e.g. Debian Trixie, which I plan to update to
>> Trixie+1 when available). Why? Because I have them and they are 
>> working ;-)
> 
> Hi Michael
> 
> I will drop this from the patchset for the moment.
> 
> Would you be willing to take up the Maintainer role for it?
> 
> 	Andrew

Hello Andrew,

thanks! If someone mentors me I could try... I have experience with C 
programming, esp. in the embedded world, but (almost) no experience with 
the Linux kernel development.
But regression tests etc. can be conducted by me - on 32 and 64 bit 
machines. The oldest being a P120, the newest the mentioned X61 with its 
C2D CPU.

Best regards
Michael
