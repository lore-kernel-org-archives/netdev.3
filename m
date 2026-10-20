Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.131.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489480;
	b=WHMmsX7y82G92bogQHgdKHXuyatOFMbMZH++TZ9C0fIZupGjA2a1XCe0S10fyv+kk7pJ
	 seb9YWqAg78zJgs7HRvEhF9EL7CdpYa5h0/SV8G55VKPfMYLj4PmpwA5KOCkJ02QGPzME
	 YK6c3yQLB6HsFq0gpR1yHVICLbn/0uI9jiWGyLq1A1GnnpeLcotaDPDhd+VROZEeovwnu
	 iEMlJIqlSXYw8J9VQv87YcDXA8RtUm0ciSVp3QrgfggegHJIM3RyGLm3zSUeTM/M2j5Tj
	 cKMucE0OqeSiUacTfH7isZqWeqWVWodh6vk4RZDOOChJeb/7+z+6cP//35HCF1aVbGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489480;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 MIME-Version:Content-Type:X-Spamd-Bar;
	bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
	b=JxdFhwJz4QzqpA3DUFIsW77ClwVwHiQdTec8ievqeAjbIwqCLlDq8jQ3f87PfVHcW4VD
	 uc99tb3zFFKNFL3mXy85SQXWwzEQ42FhnXpWsHgGVVb4omDwZVCFlaBeMysa+kP7yksoe
	 mPlVGr8ZQbT32fKSe7QGBqSLtm46KsHxY+9SVh74cbiOCV52YDGFBcTpY5xH7M2zJtrLJ
	 4M/VHQtLP8iAHvsQpZ9pc5BXeMtBAW5jg1Ec8+EMIWGgsIHo9AbuKpDkT6l/7If26sEzg
	 IEW2JFqN3tXTAj0kI1c7P4I00IjQzc9KDzY/6kn/0cTVL75HARGXxdmev4UYuqMXSXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mser.at;
	spf=pass smtp.mailfrom=mser.at;
	dkim=pass header.d=mser.at header.i=@mser.at header.a=rsa-sha256 header.s=kas202607210106 header.b=WGk9Kcnc;
	arc=none smtp.remote-ip=85.13.131.59
Received: from dd30414.kasserver.com (dd30414.kasserver.com [85.13.131.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75B606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA75B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mser.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mser.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mser.at header.i=@mser.at header.a=rsa-sha256 header.s=kas202607210106 header.b=WGk9Kcnc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mser.at;
	s=kas202607210106; t=1792489470;
	bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=WGk9KcncuXE9JhYfRJZILv9hMj5KMTvYUfIq3sVZRRolk85NIPBqEWKvwZJOhCxcI
	 eTyvzucfgOhbeg0uWTYS7Myd4e8WsjIjHLxMycywppifxLxiobubdLSb+CnXiLS1Io
	 BjoUehooMUj1PA61tl3J/tOslgsow9upPM0X9u1R0SiIIYr6vraIyaP66DJIGlYS+u
	 EDvLTABHpAKOELB0iUbSYrvOJlCO/PbnoCXAHVT5lbtJDcKKD/7kvdy7tTDJAsNHK+
	 1+ebcvZ/gOsGM1cm9Sg5IJhz1noy1GRcf522BB2bKsYHzVI5G5OtwBOZnlFlHzcXf6
	 ic+FOgOBdGdwg==
X-KAS-Sym: v3:f51bdf72230551df:mPSmZyQeUU0hJ48cRNQO5WGMsDcTp+Gkxgw+MI5OoCBem
	P6WJ6UYsjuIfF9+V+PveSBmh11gxrS8WF0mkn0tqtj9K8h+Nf/DfOsu052Zo2q/22d0e6N/+cDZ
	JJyteODSDeneN9OMHCVWVRAmxkVF04QFIuY7qFaxsHobvUCVkvgM7sG75b/ZzbdeAool5VTxldO
	KDgV/ylY8R4WsZhTepVcYjGCl9eHaTAgI1jWQXFaynzA+fbW8GXj1F5/7uYnfLl1SA/TzkKJYx8
	r4fwQj04N0ux19yrJjgX/PtV+GNpD+NfdlDK4HoIfx6sFYnE2fBKu3Sqc5sbgXlAj33Z8hRA==:
	Jo6itHlrlMQ+M64S2A8WL+7l3j3DrwE++rng/IGS2DBSj3qeDrSFnvqfjWq48OIodXzKCYL1cWi
	A+J/9avnkLmKfFk99uigi8m4tjtBR6CwtOUY/ehTot7DdR8zSnDsOM+KyITxP8Kgkk3LWX+3CAA
	O9MNh8y3pkjiM0IzxzVNOs5M+R1LvnLqn5YAVETdoXJPwTd5io5AdBlnIMhxXL13alU8Y5OBHlU
	mxu5pMDQrTApsf6V6wQ1HPp5iWe6Sjedib9eRxUy0U4A1vwWm31lezqqco2u3fofheysBOSSksY
	z3lCb3Jyd758vd6ZTlkIKDvZqEWgZ3QQWbP9nZiYEsVX1U8muK6v94kb30Qll7xAT1BkXcRBwRL
	cZ5fJNsr2dbYf2oPi8QjtjDf9QMAq9FHHSbKQXO5ZBHueZ9KsG7TLqm0H1dC6tv8GemlzvWxMpn
	H3jFlhTFlq+lZJyheGoHUmApIJnCru+40X7qJNXkk0peb7s0o0qosBMOmDHjx2jp+rpRdgfrhf3
	HxPvhJa2dmteviagDh88W+2Wq0ZVrKVg6Rj6h8m2NP+kQ==
Received: from mser.at (178.113.74.246.wireless.dyn.drei.com [178.113.74.246])
	by dd30414.kasserver.com (Postfix) with ESMTPSA id 279BC7F04AFE;
	Tue, 20 Oct 2026 11:44:30 +0200 (CEST)
From: Michael Serajnik <dev@mser.at>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: igc: I226-V does not wake from S5, PHPM D3 link-disable bits never cleared
Date: Tue, 20 Oct 2026 11:40:57 +0200
Message-ID: <179248925768.53035.1880576110074374844@mser.at>
In-Reply-To: <1562f299-bb3e-4fe6-81d9-e11f67606737@intel.com>
References: <179223208565.28107.1987245697366860479@mser.at> <1562f299-bb3e-4fe6-81d9-e11f67606737@intel.com>
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="fixed"
X-Spamd-Bar: ----

Hi Dima,

Thanks for looking into this.

On 20/10/2026 09:55, Ruinskiy, Dima wrote:
> I think I can fix it in the driver, but to double-check that the problem
> is indeed this, and not something else in the wake-from-shutdown path,
> could you try to reproduce with a different link partner (switch or
> back-to-back) that is known to support 10Mbps link speed?

I can't easily swap the link partner. The PC is connected directly to an
ASUS RT-AX88U Pro router, on its 2.5G LAN port, and I have no other
switch to put in between. The cables are clamped down tightly along the
furniture with no slack to reach another port, so trying a different
port would mean moving the furniture and re-running the cables. Since
this is mostly an annoyance and does not break anything, I would rather
not do that at this point. It is also unclear whether it would help:
ASUS labels the 2.5G port "2.5G/1G LAN" and lists the four other LAN
ports as gigabit, without saying whether any of them supports 10 or
100 Mbps.

Instead, I restricted the I226-V's advertisement while the system was
running and waited 30 seconds each time:

  ethtool -s eno1 advertise 0x003   (10baseT only)
    no link (Speed: Unknown!, Link detected: no)

  ethtool -s eno1 advertise 0x00c   (100baseT only)
    "NIC Link is Up 100 Mbps Full Duplex" after about 3 seconds,
    stable for the whole 30 seconds

After restoring the default advertisement (0x80000000002f), the link came
back at 2500 Mbps Full Duplex both times. So this port supports 100 Mbps
but not 10 Mbps, which matches your explanation.

I also need to correct my report: I cited FreeBSD bug 282140 as the same
problem. Looking at it again, FreeBSD fixed a different bug there (the
wake filters were never armed), and the PHPM change was dropped after
the reporter's switch turned out to support 10 Mbps. So the bits are the
same, but FreeBSD kept the 10 Mbps behavior.

> In recent years, an increasing number of switches stopped supporting
> 10Mbps, so we have been receiving reports of similar problems from time
> to time.

I think this is still worth addressing in the driver, if possible. As
you said, more and more network hardware no longer supports 10 Mbps, and
with such hardware Wake-on-LAN fails even when it would link at
100 Mbps. If I understand the issue correctly, keeping 100 Mbps
available in D3 as well would make it work with this router, and likely
with others like it.

Thanks,
Michael
