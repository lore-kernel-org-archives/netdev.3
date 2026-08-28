Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017C3D34BC;
	Fri, 28 Aug 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904636; cv=none; b=t6IMufae9cPLde2ognDEemK5fy9uMZ4HtwerwQuVk3UBOMGuH5zGrkmEONpBMIZy9Xt48YJT4zcr6DT9HoEMVe0bNLNGAUXBBONOOr+DkIHGP2eNalicSzntIvkFsmJTRg9r4KsJM4NnH9jLiiky0tG5tbsb7LmztpqEG7Sgaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904636; c=relaxed/simple;
	bh=dfV45/0HBPqVPTtl309C75P9WX68Ts2y1HgGfbXlWk0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HGK47ezoI0ACXZYJn8jRw4MK7oT+z1bL4vmU0x3/I7cyMyU6UlavyYTfqKSwyf0noOhs8jrm3Z0Eb/oFUBBIy8Vz9Ua73FLhZ4NtdHCOI/sBqlL0feFQdWR93SVVw+wFzxzRnJ+rqjMpfm+/zXaZ5DegXv3YB/eIADKNQ8BXuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AqjLzBT6; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AqjLzBT6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FD7CA2318;
	Fri, 28 Aug 2026 10:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787904622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BdZjAvvxhSYvULCYkGCbYxYuZJAagk/QGRUpjqaL1vY=;
	b=AqjLzBT6Ltv6D3qgYS0HeKaMssn1CYGejthV0/IUE90RUA0MC9sK/PS2vTQTRhJxqnocw8
	ChJuSZCvrhyYDjh2GupmwBs/hqQfp81iiHLlJcMlgyZvdzRJhDp1nG576ic6TSThxOHCns
	AmWWEx8NpUcjQVdJVwDjBnH39yLUDxSgmCjb4ACDywKzrrTDiWrEApnvVxA7jZTknK233y
	ZCC8KVbGK/k6fMVHywdvY+z3kNn4KbVgvcTba1nPFno/ogoT5478XIvfrD1uHUIrLyq4or
	ARXxjVPkwrAMe4mPlFo1F4Up4vAL71oldVaV/3X5ntogd+gfTsWKP+p1s4MkMw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 10:10:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jonathan Bell <jonathan@raspberrypi.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
In-Reply-To: <18d43f38-ad3c-4e1e-b313-dd3b64fe02c3@redhat.com>
References: <20260824134703.766708-1-nb@tipi-net.de>
 <20260824134703.766708-2-nb@tipi-net.de>
 <d1f02ab923c0464fa73cafa75a21943d@tipi-net.de>
 <18d43f38-ad3c-4e1e-b313-dd3b64fe02c3@redhat.com>
Message-ID: <7612190788cebe8538242c039a332644@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo

On 27.8.2026 10:52, Paolo Abeni wrote:
> On 8/25/26 5:04 PM, Nicolai Buchwitz wrote:
>> Replying to netdev's sashiko
>> https://netdev-ai.bots.linux.dev/sashiko/#/message/20260824134703.766708-2-nb%40tipi-net.de:
> 
> It looks like you instead replied to the comments from:
> 
> https://sashiko.dev/#/patchset/20260824134703.766708-1-nb%40tipi-net.de
> 
> Note that our reference saskiko instance is actually the one you
> pointed to above, even if the comments are at as slightly different
> URL:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824134703.766708-1-nb%40tipi-net.de

Thanks for the pointer. I'll have another look and check the findings.

Only partially related, but is there a good way to c&p the sashiko 
review already quoted, so
it is easier to respond inline via email? I saw the discussion about 
sending feedback via email
and also the note from Jakub in the 7.2 stats that the current false 
positive rate _might_
be stable enough to do this in the future, but until then this would 
help a lot!

> 
> Also note that pre-existing issue should (usually) not be addressed
> in the same patchset (unless really bad/exploitable).

I've bundled patch 1 because patch 2 makes it far more visible. Happy to 
split out if you'd rather.

> 
> Finally I have some concerns WRT patch 2/2: it should bring a
> significant performance regression, and the frames transmitted ATM are
> still valid (even if 'downgraded' csum wise). It would probably be good
> to provide some priv flag to enable/disable such behavior.

Agreed. I'm currently testing another approach that checks whether the 
checksum would be 0 and
only does the sw checksum calculation for those packets. Also, the 
testing from Alexander showed that
maybe not all revisions are affected. Théo can probably check Mobileye 
silicon so we can pin this down further.

> 
> I guess some/most users would prefer send 1 frame out of 64K with csum
> validation unexpectedly disabled than hit a huge slowdown.

Agreed, lets see if the different approach might save us this at all.

> 
> /P

Cheers
Nicolai
