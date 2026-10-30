Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.238.174.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386025;
	b=pBISSswhSgLYIxN2ImrzAAL5K8T6r9aTD8AUdqr8xvSk4vBfTdrEh6rUeECN2JldJ6u0
	 iI+XpCGOoz/Kdc4bVqbhV84PtcEq8R5IR+1xr7S3SbIuvPKfXuSV6CT9s+fMUWE5HtHNm
	 tYJY8NvBVIpFvJnH6t9dvAGe6imT+Qu8XXNV+Kkq9WUSYdjQM9IyaWAVDEw5Io+j45xD2
	 Ck0iThe+w14vbUziqfvHj4cHRzU1wFtk7lHFb/Asa1ZoczX4xN3mu2WoKZOLM6X9u7HMC
	 xAGcV3HsChQfpPcKz4XEFYfj1xmMQAbifDo7cEnw7sqd9Vju5AiCLXt4NRNFFTOdJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type;
	bh=tmFJTDvtKn4g2hsRLOIIPO6ilZ/8ju1fOi4oViychXk=;
	b=SDlnwjQPYLuplPTAIKUHjD1J8lPN4cyeQvpq5BP5Zkt9t9xp5iYmvFUPx/P3GEu9r/gW
	 9YjJxbcfnykpnXfaa68IzE84nljdRh8lsfB6YrOuRumZgxSIk6RoUcjNnyxGBiXr26wwS
	 BJstaWmaKw8NHTwAaOVYJB7Q4NcgyxuVeXT8/MTMBCRstus/SdCPLS+uQYdKY8S+Bo5Cy
	 1RcDn5Bq22FBDthtCXuP9/fzU2XRJ9nxwl7t0Z28CZsiREqdm6g4Yf21hHWbeJxtlwnCd
	 kSj/p9DWTk6tyc6M7LaLSGCKYTQi87KK9tiZXWQUwpCjjbv4Jg+5G14dmQTrzjD5Y8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ssi.bg;
	spf=pass smtp.mailfrom=ssi.bg;
	dkim=pass header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=6HuVJG3F;
	arc=none smtp.remote-ip=193.238.174.39
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C2606A31A;
	Fri, 30 Oct 2026 18:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=6HuVJG3F
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 9228F21F7C;
	Fri, 30 Oct 2026 20:47:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=tmFJTDvtKn4g2hsRLOIIPO6ilZ/8ju1fOi4oViychXk=; b=6HuVJG3FBfxg
	KJn40TJUZZlKKu48G5zQuzNOPWiPp6hmjwwAuHiA5TIYnrY5KtdHkv7+SSDXqNbJ
	8h74abPZtR7BBgAK9YxjBqJpEDaTktsVO7dVG5oGF5+kYa5gFiEm0mclxFQAQYSa
	XdhwbjMRNeRNh1IZx8vg/LI3SryFHSK3Zm3P0unYHAtgNPLbMWeXmIfwqc/MFI8J
	Dr9cvCQPzXFnFghUK5E88UvPd7+I1dVWNO5G49wniv6TI4tymQQSwjPGB30yswQ8
	73fvhYE6dybh83qY+ElOY62JFB7GFy2iNwmQ6WMjzOFHZtHtbZe+9cyKq7iCYZ4+
	q3oAg8wsBXsIf/CV0CLf/NbihcUkP+3aP6PsiFu6zB6KKOvAz+r4GGEOxuJsO1rK
	K9Kkm8EceUsiRYUFPu+Lwt58J3OR9h38DpeX4KB6H1fjc+Tmgx11+GrFWTFlEHUz
	2clDT/D+CJBovsBFKI/ff0RK36bc8A0nyQEIeYY+yIWmKZsooBWOP+cPWfFGn02i
	CqyQtfMBzC45oJrvxTHxXIc0JjS+xb127WXYSXYMDxUx0D1GuU4nrfCMXbZTu5+R
	wz5KOuVO3OE0IZBwySQEMLOm8c6CTS1YgvD/KrpOj/SZUQ7YPtIiNR7jLRSuug5z
	dEGaMmm8/qkydgCny34h/vir51trkgI=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 30 Oct 2026 20:47:00 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id D2D54609F8;
	Fri, 30 Oct 2026 20:46:59 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 69UIktnU063584;
	Fri, 30 Oct 2026 20:46:56 +0200
Date: Fri, 30 Oct 2026 20:46:55 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Star Chang <starchang@google.com>
cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        wangroger@google.com
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
In-Reply-To: <20261030065258.818406-1-starchang@google.com>
Message-ID: <ed3b982c-ff5f-79e7-6c72-0b2899c84cb6@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com> <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg> <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
 <20261030030715.604215-1-starchang@google.com> <20261030065258.818406-1-starchang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Fri, 30 Oct 2026, Star Chang wrote:

> Hi Julian,
> 
> Thank you! Your point is spot-on: in a shared-key Wi-Fi network, an attacker
> can simply broadcast a forged GARP reply (sip == tip == gateway_ip) to poison
> the gateway MAC for all peers. Giving GARP an exemption indeed leaves a door open.
> 
> We verified the Android / mobile use case and confirmed that completely
> disallowing neighbor learning from L2 BMC is safe:

	The only purpose of neigh_event_ns() is to flood the
cache with NUD_STALE entries that on confirmed traffic avoid the
ARP probing:

1. If entry was missing => create NUD_STALE entry with the hwaddr

2. If entry was present => update it only if hwaddr changes,
if hwaddr is same => do nothing

	Same is for the neigh_update() after arp_accept() for
broadcasts.

	So, if we do not want to keep STALE entries with
wrong address learned from broadcasts, we should not call 
neigh_event_ns() and the neigh_update().

> - Gateway validation: Android relies on NUD (Neighbor Unreachability Detection)
>   unicast probes and unicast replies (PACKET_HOST), never on broadcast replies.
> - Wi-Fi Roaming: Roaming clients *send* GARP to notify the AP/switch; they do
>   not need to receive broadcast GARP.
> - Router failover: NUD naturally detects stale neighbor state and re-probes
>   via unicast, recovering within seconds.
> 
> For v6, following your guidance:
> 1. L2 BMC ARP Replies:
>    Drop all of them unconditionally (including GARP) with
>    SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST.
> 2. L2 BMC ARP Requests:
>    Process and send replies as usual, but suppress updating/creating neighbor
>    cache entries.
> 
> Does this match your vision for v6? If so, I will prepare the patch accordingly.

	I don't know IPv6 well, so I can not help here.

Regards

--
Julian Anastasov <ja@ssi.bg>

