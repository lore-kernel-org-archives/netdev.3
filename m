Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684839;
	b=4Ohfwmml11EQFZE7o/ATFg2qFxxjIqN2DDL0kF8NNIPgG6ooiWHVjEfaJqyF/tONWr2+
	 yAMYZ7povtCUjOXfVKn6WFCyoPzo2qCUrfYe85XK08SX3wl9kV7axRd8yElvd4/pYQvKx
	 hP0k8HhPJQ4dYs9RqFxhCbdzXplFjJnD2lkNC5DSEV0dQRrevFTp2FtMQS8yeHPctNixb
	 SyziE4o1Y7CGRpZsQEpPjPfNAUjTbwiKR4q0YVYKAneUn295v/KZbw8/ipL15XuJ2O0h0
	 4KOKXSAnp2dfGof8Y9tErs4u7uZt/RHO+r4WVYwwdwNqPh7BfHY3mtTTBXDUK+hc0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684839;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=66qA4T0+Y7abbrUKSKY74ogksnhTGqqEnTpzsWYmGqk=;
	b=Uccr90dzGFkCoqLdBP7rjcwYh312zrk3wllEp8ASG4+Sk6/ebiT4K14QV6UPzfG1wB3u
	 tl4wSy3OMNMt+C+O/PXuTKstLyrHjVIR+MvVE9tnOjfYJHY81pF0o8az0z/Ndx4Sr4g3+
	 O6sdJy1UKdLWFZ1oLDABSJ4uCwJ49PMFYkxyvPGH5icd1zPZF3+ooC+61WwZbSCdD0kaU
	 ZzTjU3RxuoN9nI3Mdq5cxPHSwSObsYx32ZY0KpqcGv2LgKZ4I16zdZ15JYTrzGsujhh1g
	 bgA46C5esz6Q+IFroTtraivszhxfTC/0JMeD4tpwH/JJVv7adTfmT9efjiLvY7NQNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=lOJai6zd;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFC606A319;
	Thu, 22 Oct 2026 16:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60EFC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=lOJai6zd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792684829; bh=66qA4T0+Y7abbrUKSKY74ogksnhTGqqEnTpzsWYmGqk=;
	h=From:Message-ID:From;
	b=lOJai6zdCpF8jm0wSYDC4NtmfF4Xk2H0nBOjqY4THZxeKr7g3soaxznwfCQoCbJq6
	 KBxYJZg7HVSHPdTwsB8pSzSrixc/aXjncMNi9LzfDA9uq6k5igFajBM2g1NjYT5nSg
	 PCtut/zS4O1zaSEsOgtmKSZPD2BegirG2qVRcV/Q=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id CCC2AC0944;
	Thu, 22 Oct 2026 18:00:29 +0200 (CEST)
Date: Thu, 22 Oct 2026 18:00:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
        "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
        "security@kernel.org" <security@kernel.org>,
        "maintainer:NETWORKING [GENERAL" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
Message-ID: <atozHXYYSBvz9L_s@1wt.eu>
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <willemdebruijn.kernel.178cac71d218b@gmail.com>

On Thu, Oct 22, 2026 at 11:28:49AM -0400, Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > Le mer. 21 oct. 2026 à 23:47, zdi-disclosures@trendmicro.com
> > <zdi-disclosures@trendmicro.com> a écrit :
> > >
> > > ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership Management Local Privilege Escalation Vulnerability
> > >
> > > -- CVSS -----------------------------------------
> > >
> > > 7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
> > >
> > > -- ABSTRACT -------------------------------------
> > >
> > > Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
> > > Linux - Kernel
> > >
> > > -- VULNERABILITY DETAILS ------------------------
> > > * Version Tested:7.3-rc1
> > > * Platform Tested:debian trixie
> > >
> > 
> > I had to cut this report. Way too long, I could not see a patch in it.
> 
> Right. For future reports: please review the documentation on how to
> share such findings:
> 
> https://docs.kernel.org/process/security-bugs.html

Rest assured that we've been asking for this many times. The situation
has improved a bit, now we no longer receive the report in a password
protected Zip file and maintainers are finally in Cc. But it looks like
having a direct communication channel with the initial reporter to be
able to discuss and test a patch remains way too far stretched for now.

Despite their sincere efforts, I personally think that the ZDI reports
remain by far the worst we're seeing in terms of efficiency, and among
those which generate the most round trips.

Fortunately most reports these days likely come from AI tools so they
also come in parallel from other channels where communication is
direct. Maybe one day this will further improve, I don't know.

Willy
