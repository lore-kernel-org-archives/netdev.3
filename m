Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2094F4D04
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775957; cv=none; b=nJuBM3q5z8CZQQuxQN0eIag2qt4NUXUfoiECukU9apd3R4hd6nGsLX6xkhebE5Jvo9EioZx6RREdaU6HK7pGsXkY3qNt2Tgg08kypC8jLJlvlKwsEohzKXThfVDvpvFK5SxyKf454R4RHnBRyhD5NS6dyacr9CfdFFSmDY92UbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775957; c=relaxed/simple;
	bh=hcWjM85x8CPd7ME0/JQ+76R/DqIP+XLtBSXnzE/2Ocg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TxoXbkU9qzGJuoN8poyV34YVqKbCV0lOhI3bMpLhe9lZIqsv4LphHDffZh7+A0SiPh/3TSvvvXzCJYoWMa0xvD7FILIaavYIHS8vs7DPSzD1LdHVnqP4qwSt1iOwvc5DKvNFyNWWicrMoIrwDcLYSZNyQ9Oq8wEhiuqOFTQSRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp/TBzHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp/TBzHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399161F00898;
	Wed, 30 Sep 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775944;
	bh=a53uR9AnILgC/n4mpY9Whmn3IblyUXb8/5JxQvKO4t0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dp/TBzHn3FNMu0E+91vLuvusux4IpUd5M+b10+x9Qm9O5R9w9dZ9vNtjy8oPntKHi
	 JltEY2j2zGZ3YfbC2hDCFdA7ArorQwKx7BQc/r0F18evITRPG0+lnrrZjJcarBL4zk
	 MRjLkSSV+pODttQAt6SX2Mbb489UDGN1JMM63wtlPmXOZW33Prc6uYn0fHF0cdUbuf
	 5RUoKvLbqPd7t07ynJPwibMJI9A0j75USe2i7aQ+e3tchnY+S0Kvd84lB7nackUK4X
	 B7oX2N9QSQ61fzPq/juP6+MuSiqOxcBn6guTddjUTtvEjdv2TBtzd0E5zoH7A9bCMO
	 ZlwruWtUz+VMg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 61B7AF40068;
	Wed, 30 Sep 2026 09:45:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 09:45:43 -0400
X-ME-Sender: <xms:hxK9aoh5PhwyqRhDB812w0r9VRFMBeNd_349LAbf490EvqpgzkBUmw>
    <xme:hxK9ar3CuPx_zIu5ENYbEVLLEKwljG2mLDYRH_9FU5fUU5MlLj39_WzI248yrbu9-
    55hFtUhJA8zatkXBwPoyefGm2gl65_4Gd8Mf7Svq17Lw96ZCIjqoaTd>
X-ME-Proxy-Cause: dmFkZTE8usJ4un66rRQn0aBQATQkD0km4he4e7n0YUe+34BC8X4IO8333xHOiLZwdn7+nw
    7wrXYVwTgMiIfR5JPjtw2z7EwZKV8Vb93TCaRGzBOgC6wnfk+zfF2A6oHJIrsMqS6nT6wT
    MZW2/MWK/tidN7qGXWGlHLyht3t/N7UQ3Y0VF3hqwIjgEeDqgWh7BgU3eKDl8SQUN4Igib
    8UXnrKLXW8IpZyqMpGpjStKaHbxmFpnsV/wme/CZ+cHXumLl/4o2guN6z+Taq7qGTLVWuM
    SRjAUphFpjq1BWs6SEA+dVygW4L1GPfyf1IRRumW8m4wtHJMgcLEhfAu6gEUspZELlYQs8
    tk9hE0i6ABqEzeks0nAO7cghJVsJCpvVKUQTxNR3fHMsBMLAz8KHaikdNmjEirJBcVUQyC
    RiUa2sCLh3bM10XI565HKkUVWpG+RmxN/5azO1JlSEPKQVHCWnV9aCRIYHNF0FzMXc5q6h
    uLw+z8j8681YJNYACoSKI48rZSUXL9GKfYlm29Wn7TUV3AViOOmIXMXTiMbZRzOmDqhYqF
    mmSw2WnGNmKKg2Rqdm9FxwxjQCe4XDOso5SpJ4usqAe3LbObjzu0+zmCKyDecHVfH3x08T
    uuWN13FBYkjcPdubl8Ic6ck045ItZeluCBGwC19gxATQtvzv/d8bZR3wbg3A
X-ME-Proxy: <xmx:hxK9amGnYD1OBN2B2l0j99RX7qpWnDFLwWdwfP6-ZmEJrHOXZ9wJrg>
    <xmx:hxK9ajM92VpUVoHnJhhuxb3PPEmVfRSA5hxtn7WZAQM4hkdh1AF3Pg>
    <xmx:hxK9atL7SVB9D7h7zoqNEwQ5plb6vDNA57oPTopJziO36euBYbk7zw>
    <xmx:hxK9ak9PiKZ3INyvag6IHHJKhQNxvkL5waQcgxUw40AqM80SO3e6JQ>
    <xmx:hxK9ahH4b8ZJmCCM-dTL5q_alQxuOyjMdy5kdanmYZmYzwQuN7p3aD_G>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C264780070; Wed, 30 Sep 2026 09:45:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARQcub8KHhRJ
Date: Wed, 30 Sep 2026 06:45:23 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>,
 "Qingfang Deng" <qingfang.deng@linux.dev>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Dave Watson" <davejwatson@fb.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <415fb6f4-7ecd-4d04-a3c2-56c186a5628b@app.fastmail.com>
In-Reply-To: <arzawlad0OQ9pnBQ@krikkit>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <arzStIrdizPp_vbI@krikkit> <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>
 <arzawlad0OQ9pnBQ@krikkit>
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Sep 30, 2026, at 2:47 AM, Sabrina Dubroca wrote:
> 2026-09-30, 17:24:18 +0800, Qingfang Deng wrote:
>> On 2026/9/30 17:13, Sabrina Dubroca wrote:
>> > 2026-09-30, 13:26:36 +0800, Qingfang Deng wrote:
>> > > tls_sw_splice_read() returns 0 after receiving an empty application
>> > > record. This looks like EOF for splice(), even though the connection
>> > > remains open and more data may be available.
>> > > 
>> > > Consume empty application records and retry the receive path instead,
>> > > following the approach used in tls_sw_read_sock() since commit
>> > > 3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").
>> > This is similar to what Chuck proposed in July:
>> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org
>> > 
>> > but Chuck's patch had some extra bits (handling of the "released" flag
>> > and of signal_pending).
>> > 
>> > His series also had a selftest which should be included too
>> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-6-99bf4cc1c729@kernel.org/
>> 
>> Thanks for the information. I prefer his series.
>
> Let's see if he has the time/interest to continue work on this (since
> he didn't send a v2, I'm guessing not).
>
> Chuck, do you want to pick up that TLS fixes series again, or would
> you rather let Qingfang finish off the "splice vs empty record"
> patch+selftest based on what you had sent?

History: I stopped working on that since Jakub seemed to think the
fixes were not worth the trouble, and my objective is to get kTLS
and its kernel consumers in shape to support KeyUpdate.

If you think cleaning up and reposting an old series would be
received well, I can take it up again. (And forgive me, but can
you send along a lore URL so I'm sure I'm working on the correct
one?)


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
