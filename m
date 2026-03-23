Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCE383C64
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255175; cv=none; b=Qk1H18+Ya0x+6DUgi05is1JzH87n4Sto2Z4lR90tWurNFMZFT1BPTAzXRHaF1NZOCF0exJ7LLrlBNt3u+XpQcBdFO7K6r6vBmnq2TZHtrPVlbCmQp2DhZFbM+WIdkuyuZfOsp3gmsN3J/8cRIgeEbroRI+I0BT7Y5M+S9YqETlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255175; c=relaxed/simple;
	bh=xUDeTHiy2lJ5rZF17C4/ObQIXmEost4w/o29DkPw/Gk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q2xfaxFmUCviHFg8XYPBIMgs5mPyGRJjYHglYxUNytW7oa/EmScEOQsoXPL54Qfz2dXHzit6IWJF3G9zekHszliqu5/PXnx1Rm1A6RnZapNcNfFK+drkAIolZxcgGGweYynnTgWyOOnxtPHtCGf7FPhbk09tbKj88y3nC50UT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 6B3521003C5495; Mon, 23 Mar 2026 09:39:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 6920C1100B1486;
	Mon, 23 Mar 2026 09:39:21 +0100 (CET)
Date: Mon, 23 Mar 2026 09:39:21 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: David Ahern <dsahern@kernel.org>
cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: print IPv6 zone identifier within the square
 backets
In-Reply-To: <2fd3d4bd-afad-42f3-8a2e-805940e078cd@kernel.org>
Message-ID: <5098232p-84s5-9298-019q-nn5718335ps8@vanv.qr>
References: <20260317182245.87996-1-jengelh@inai.de> <2fd3d4bd-afad-42f3-8a2e-805940e078cd@kernel.org>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Monday 2026-03-23 01:22, David Ahern wrote:
>On 3/17/26 12:22 PM, Jan Engelhardt wrote:
>> ss was printing the zone identifier in the wrong place.
>> The zone identifier belongs to the address [1][2][3], and should thus
>> be enclosed within the square brackets, not outside of it.
>> 
>> [1] glibc (since about 2000) accepts "fe80::1%eth0" as an input to
>>     the `getaddrinfo` function.
>
>This change is definitely going to break existing scripts handling ipv6
>addresses. I do not see how this can be applied.

ss output is not reliably parsable at present anyway, so I think the
point is moot.
Unlike `lsblk -r`/`lsblk -P`, ss does not restrain what characters it
uses in column headers, does not to use a consistent character
separating address and port, and fails to do escaping of paths e.g.
in the case of AF_LOCAL socket. At the will of an unprivileged user,
any parser is immediately thrown off.

$ perl -e 'use Socket qw(:all);socket(my $s, AF_UNIX,SOCK_DGRAM,0);
  bind($s,sockaddr_un("/tmp/foo\x20"."bar\x3a"."13\x20"."49\x0a".
  "u_str ESTAB 0 0 ..."));sleep(600);'

# ss -x
Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port    
u_dgr UNCONN 0 0 /tmp/foo bar:13 49
u_str ESTAB 0 0 ... 31267391 * 0       
