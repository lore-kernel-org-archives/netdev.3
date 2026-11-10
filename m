Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324543;
	b=hC8AJTnnqpd/atqW9LBHCIMYRPylJqVlXPRiDeXcqDJ5Tkts0H/VAXQgoS31lJ5tpPoK
	 JFC538964aturNFOnZEvm4L4cG5Rkj7Yu2GfRcXozMNs9/ShZSXAQwOOLyngJ0UTyMYjx
	 SNIBavQ6SvF858kpQ38lQBz6UuZOz+PHnMaA4UL+q7TuLlZzezoa57pgAG3fq+kZbr6ft
	 jETCXQd14I38K+LJHvXSTg0D3N5PwFhCgIudFpzONcw2HujjL06gjIFy43ugY652WsRmv
	 0+kvNRgRqeYMO+F/iV9xqeA6wFmdtev/QVvRBYsE7LE1qieosN9O2iTnr8SS2U6EIRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vor560/tS7f4xQTSZC/NQvv/wsE4NnGBjVHi1jVvZAQ=;
	b=EeBEmtk1V7FA9emOo/mzhhzIi82bBc7U2W2DCjSNDnMbxVLjmWvJqvzqztgXlGFOp1SV
	 B9ONmpN/Dn1nY1bL3RXjoltS+X1BxSzt2vLNzV424ySe9klM7oo8tUX3HgYGaQ1HInyjk
	 XkrK91m9Ama0ijlaUjUQnc7ECM8wHUlYi6X2oIaORk566W/E04xp/CL//LwW0i1Jv9DTp
	 /p3P+pu0DDnL1qEdlzXvLpW97KAqdeEjaeA8pZVRLBL0eYhCxzlYLXqf4YgyZpOoruuDB
	 bPJPvh9ZHZUkZc7holqz7IWYhm8aS5i/WedxjGdv/oPi1/kwYRE1ajhN8cG+LixEafQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wair+eAr;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9F606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wair+eAr
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b244fb7fffso2661047c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324542; x=1794929342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vor560/tS7f4xQTSZC/NQvv/wsE4NnGBjVHi1jVvZAQ=;
        b=wair+eAriSMv583+OYXmCwr/542HEyanDzGHRuT+ms4wUt2aavze/8Z+NC42tFo+F7
         KgdGkR9cAwKWsRQ+DuD0bf6IGu64YjEehq3j+0fRv/CB7t5yMGaDd5PSmSFhQEKffK5V
         iGvwkEJEU7PoK1uZNWhfXNsHYSEmu3U3Wiiq2fTwchnj5MAz1dvfz4RVcNBn0NheoeD4
         0RfFZ/189HvDvmExdQwLDfywl+AKHiLlm2ri54T9W95m4swKRqbVj0n/Nts+DsVVqqla
         d/bIKRXS6OvNhe6UXxp/e7udf/V3oRcldjb/Lo85xenRJV99HFs/C5E1fpi9gT+sKk+5
         FGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324542; x=1794929342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vor560/tS7f4xQTSZC/NQvv/wsE4NnGBjVHi1jVvZAQ=;
        b=aAdpSD3WvzmIYjFk1mVmJKnBv1yyJXsD3oCAu+gYCNsoUJfKzS57SX/BiX1hBZgwbs
         WJwxKfzGMANHAf9Q7EHhzwO+qK+cafXIGqsQmBMcAjFU7uD+LaRHG45FPWql5MyE7cDq
         Yg9SEWnbTZuO8F++bYAfWtYVDp4EQMODfaMEbHq2bLESeWg8YH7wlaFqIJSA6LYMJGD3
         4PvQMVuxYVc8OqHQ+AU6woTTZKEsG4GBafn7S/ffRPqqVYS7I21UpFCRfqw7lZDn/C6q
         wgppsYiPboBE+x4n+m/vThuYwa4sQ86beJXpebCtp3VroryJQE1NK1+nLVyqmyRTHZ8E
         XyDA==
X-Gm-Message-State: APuU4Z8OwzDkr56PjJotlU9fPdn7/GzsepT2hlRfajVbrfyQ+EPM7Qna
	yDYjl9zdfyhyC+Tm5L7du4iCJrfHRqONfiJdiRsOHCFrZ5pSPBnojkJl
X-Gm-Gg: AYBFou3IavIgALH4DRyrEdw8MCgPhCl1fXnr4TR8TaPqB6B7aY/wd7YumMb67Yt7pu8
	jKuGQLib+eOIaduyX0vT9usMddrPAdMNEUcMu5bF8ibX34qb8LFRoLZfYSJLUD7UbfgzhhRb/Nj
	KsRU7m7OXLJL76mlyaUSGwTjDDE3clnn8UnmoGJQnDa19DE1Rjs8n5NSFlxBOBy+h1Swr30ZuX/
	1JvKhojiYsHUh5kyDFGp/Bg81cZQFSqiY9TubgwMwUdYWLUcEyBZUx6PEjS6ggRehhq2LA54HpS
	H2IRBnyPSEroCeOjo/6b/QfDB+L0YJJqQ3a8fIkuAW8qR2Y1E7jJuae9WgNOeCorv8L5x3RXRUO
	CY5bOOsmvfvlmPbXvwGvfiq7CEywcrufsnjwkIqy2siYir6YEsAj1UgQaqomJXU06AMRNSif1Y/
	dNJq1IjoHUTgKK8LDAGuGLuB2PICQAaIMzdhm570EBpYE1ZPxBd0uFlRXW0CHN+An6H1or/Pu0w
	7sbPMuCi74cu+bcvCepTuC4VSWRWHihEblXFw/aiMsu+q0mFuFA3yeLsZabdyO990x5sap81hI6
	RQqQw0je2mTl9mZTUIl2u/rHmm3OWKrGWMcmfZnRwUoGshOebgEA14nB3BqpEVabqAgBM2GV4LB
	R/2g=
X-Received: by 2002:a05:7022:6610:b0:1b3:9b4d:85f3 with SMTP id a92af1059eb24-1b3b5fedf34mr5373206c88.19.1794324541232;
        Tue, 10 Nov 2026 07:29:01 -0800 (PST)
Received: from localhost.localdomain ([116.88.205.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4b90csm7232376c88.14.2026.11.10.07.28.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 07:28:59 -0800 (PST)
From: CMGS <ilskdw@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com
Subject: Re: [PATCH net] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Tue, 10 Nov 2026 23:28:53 +0800
Message-ID: <20261110152853.6223-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179432251224.994134.6565482770882182020@kernel.org>
References: <20261106144406.66035-1-ilskdw@gmail.com> <179432251224.994134.6565482770882182020@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: High]
> Should this branch also update rdst->remote_ifindex and clear
> rdst->offloaded, as vxlan_fdb_replace() does?

Yes. The early return compares remote_ifindex and vxlan_xmit_one()
uses it as the oif, so leaving it stale can refill the cache with a
route for the previous interface, and with this patch every later
packet from that peer would reset the cache. v2 will set
remote_ifindex and clear offloaded in the same branch, as
vxlan_fdb_replace() does.

> [Severity: Low]
> Can a concurrent transmitter still cache a route to the previous remote
> after this reset?

The window exists, but it is the same one vxlan_fdb_replace() and the
other dst_cache users that reset after a parameter change have. Closing
it needs a change to dst_cache invalidation, which is out of scope for
this fix.

pw-bot: cr
