Received: from linode.cmadams.net (linode.cmadams.net [45.33.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EB3DB62E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.75.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371598; cv=none; b=AqrZbFck5v4JoXypMc6JY3KWqAFXqimQ/aaQHTvqDiRT10GjD9w4eQwnA64F/IrBe+Rkqw9q+KSEvOId/qQZ7Pg57+HK+MKRgU33MVfa49svxEhT/7wLEqEiKA16sjs3OekGRdLqOn8RlJnra2N2HlUYGWPOiFG4PWOVzuUOo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371598; c=relaxed/simple;
	bh=vTuWy5m4Stt6ukJzKt6PfNvI8u3+uksEa6chojF9C5M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXbZr2puES2+s6fMJ8zop0fm/8nt4LpZqIPpslBe+1q8oSu+MPhOYBzRhlJJ+Lpjk6aLZccC82fVYLQUXB87ZH5/FTsA+kfoHm8HuovjTL1dQc0U1bSsV7j5Mf57dn4r3JWS/2dzwkwETehkomf13FYUIaM9fAoQ5Hj35xm4rAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net; spf=pass smtp.mailfrom=cmadams.net; dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b=oAkSOZ2N; arc=none smtp.client-ip=45.33.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmadams.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b="oAkSOZ2N"
Received: from localhost (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gLqcQ5VTMz75N4
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:53:10 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cmadams.net; h=
	user-agent:content-disposition:content-type:content-type
	:mime-version:message-id:subject:subject:from:from:date:date
	:received:received; s=20220404; t=1779371590; x=1780235591; bh=v
	TuWy5m4Stt6ukJzKt6PfNvI8u3+uksEa6chojF9C5M=; b=oAkSOZ2N03uoOGEol
	GsaveZwBMTezsRHaCjCx9Gq0/iNAlwABTCMLO1E2ylaIgCEDwccPDrHCTxKjnWXc
	fyLRmgcCI1WF9yhDHWMlfQaYwwJdRnHZZTDSvCI/r9yaT24aUI2BIRy2gR02SREg
	9OCFpUHNEj2dofmfpRNUk84NgEoO3LousOrm9aesUdEF2J+gONnn4lJwL4nwG+O3
	D24SbCHm1gB6Ifw2EFuNI25cb/he02wRmIH3F7X4yv4IBciAMkx5dFJw69QEyZ69
	Cha166CBkk5rrSD+pVyAX80b1oRlD/daJ07cMTm7T+8OVOinN00rDA737IsO7X1g
	WHm9Q==
X-Virus-Scanned: amavisd-new at cmadams.net
Received: from linode.cmadams.net ([127.0.0.1])
 by localhost (linode.cmadams.net [127.0.0.1]) (amavisd-new, port 10031)
 with ESMTP id vPH6qdibi4Lr for <netdev@vger.kernel.org>;
 Thu, 21 May 2026 08:53:10 -0500 (CDT)
Received: from cmadams.net (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gLqcQ1TbMz6wvd
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:53:10 -0500 (CDT)
Date: Thu, 21 May 2026 08:53:10 -0500
From: Chris Adams <linux@cmadams.net>
To: netdev@vger.kernel.org
Subject: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260521135310.GC977@cmadams.net>
Mail-Followup-To: netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

My normal use of my desktop system (Fedora 43) is to suspend at night
and wake in the morning, and then immediately SSH to my remote server,
where I stay logged in.  I use NetworkManager and have ipv6.ip6-privacy
set to prefer-temp-addr, and SSH configured to use SSH keepalives.

When I upgraded to kernel 7.0, I started having an issue with this - my
SSH session gets dropped, usually several times, in the first hour or
so, then I usually don't have any problem the rest of the day.  If I run
an IPv4 session at the same time, that seems to be fine, so I don't
think it's a network issue (I know that dual-stack doesn't always take
the same path).

What seems to be happening is that privacy addresses are removed while
the SSH session is still using them, before the timeout even.  I wrote a
script to watch public v6 addresses being added and removed, and this is
what I've seen so far today (the number at the end is the valid_lft
seconds), with the public prefix masked:

2026-05-21 07:39:17 removed xx::f4f/128 4673
2026-05-21 07:39:20 added xx::f4f/128 5400
2026-05-21 07:41:20 removed xx:3e8c:f8ff:fe60:1d5a/64 4922
2026-05-21 07:41:20 removed xx:7cb1:c518:1be0:d81d/64 4922
2026-05-21 07:41:23 added xx:3e8c:f8ff:fe60:1d5a/64 5398
2026-05-21 07:41:23 added xx:596a:f6f5:67b2:1d8f/64 5398
2026-05-21 08:14:43 added xx:fac3:61f6:ad18:d712/64 4987
2026-05-21 08:14:43 removed xx:596a:f6f5:67b2:1d8f/64 4991
2026-05-21 08:30:26 added xx:84b4:244e:bb14:94fd/64 5398
2026-05-21 08:30:26 removed xx:fac3:61f6:ad18:d712/64 5120

I woke the system at 07:39:08 and SSHed at 07:39:39, which used the d81d
source address.  That dropped in 2 minutes and I reconnected, which used
the 1d8f address.  That dropped at 08:14:43, I didn't notice right away,
I reconnected at 08:31:28 which used the 94fd address.

-- 
Chris Adams <linux@cmadams.net>
