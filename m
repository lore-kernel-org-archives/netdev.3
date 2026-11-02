Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.238.174.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654887;
	b=iaDEBwprcF5zL2A2oQbh8rCxdkkB4lJiIOG7+uao7dfOxHHkMlH+JnP50YxFuTm0GV/a
	 Y5W1sUKAqAXd3dlYLQi5Rcu/HZlBBrDiJo+JYsNAGDKF4igNYCOf4ZXTJDrLn57NvUhQ4
	 lp2EPWGheuZPqtuqS3qUPFkVW023EeR7MijFR7GX8xFk6ma52asTROq+p0t0abhXTzaBw
	 m/vNhJlhP8NV+zPhQLR+zfENaJ+qirPesYIbTZEd/pWqanY9TTboBe+r8bR9FgLyYgiRD
	 OkYvNSou2qH78o9qW0QffK1Dy32WOPxHQGKWZFZBWxum9CX1bNm6z9yZjhLjGSoCABQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type;
	bh=NCltCAZ55I+rnPadfIItMefAN7VtIwIpWZXQP+ldr0c=;
	b=yYkHIBn6spSkifEgcO5XVtNeNfKfIa0lnAcRZ9pl6Fi9vQ7ekAvLM1ai+ANM4/jHBnd9
	 kOOOuX9D32DAIj/hZY+baU0O3FFY+fQrXcz5pWpfJag9t2GgdTUQsz7gOk0/6iV77LPPC
	 vRCM/W7i/a68cjVpAM/d3AO/CNc2rvkV9PIZkwXFN/JVoFnZpdHq7EXmO7sy4nAjfUvK+
	 7b/kbCjf3HmQ29OtwoUI7TLGVSokA2oNyqFytYJjcHv47u6q9JM5cEBYzbWhA8zKOMVDL
	 bHYAYnC+l5zAFRd4pN/ADhYpJTAZUYpT88eaUnMiQBe2wRVXOTrAVsN8fnw9O9opJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ssi.bg;
	spf=pass smtp.mailfrom=ssi.bg;
	dkim=pass header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=FO3VU9rf;
	arc=none smtp.remote-ip=193.238.174.39
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BA606A326;
	Mon,  2 Nov 2026 21:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=FO3VU9rf
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 94C13212A9;
	Mon, 02 Nov 2026 23:28:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=NCltCAZ55I+rnPadfIItMefAN7VtIwIpWZXQP+ldr0c=; b=FO3VU9rfZYUb
	es20i4d1bQHHN5QXCH3FbEj6yDzuu5chZ43YlVP9/DUdgA9PRcCRk7l3KJQRDF/c
	kyQWb2IZoNp3+elObjoW2E1mrEn3CSw005kJQQjcGJ/k13wlzeIqWYI2XelImHUj
	tCpv4ojIdr4tsne4x3LmlfFX6Iv3NO+fiLKg8g18O/AIKYyoHIsLEfO/jT4XldMj
	w7pRaCh1bMLxUt3WJWhWB044WIv0PrNNr3G25gZS70jQTWUDkpfaEBI+zeDWfWMl
	Ayt6sK2iU6Zw2fYzFnHS4a0u+EskTmfySRjnFdSd3ARmnO8kfOi6g3OXMfBEq5Lc
	gnGnifHOmAF+HZ2nli9nANUb8JWFAZynUiIXTK1EW4sLieefrlmVIGJrsF4aNbkY
	LIxxE8vUjTCyFupbDKqQskl8kj7DjAvQ4UWBeE4OiOZ41hXZ0RZ6z/BhCVa6SzYi
	b2VOL+FcqYaS/Dw3C8sNStb6xN71D2GLjGIM7G3egE646szgwf5Zfc6Q/GwxYMWD
	B45+rrduPbCfAVETKkMju+gvWOeAYYMf2p+7II3uAiPgc5tHGV6kzCQtCFsfHz6+
	dQ1MCzaja9ScihE46Gi7uDNKA1WGPc+htK4ACMpAGy0VH3n6cootRtrDZfUlkGCW
	6gayIY0e4QdcSs1ZLUbFr287qyPr/n0=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Mon, 02 Nov 2026 23:28:02 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id D94FF60538;
	Mon,  2 Nov 2026 23:28:01 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 6A2LRwG0120648;
	Mon, 2 Nov 2026 23:27:59 +0200
Date: Mon, 2 Nov 2026 23:27:58 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Star Chang <starchang@google.com>
cc: johannes@sipsolutions.net, netdev@vger.kernel.org, dsahern@kernel.org,
        idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, wangroger@google.com
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
In-Reply-To: <20261102070552.3516567-1-starchang@google.com>
Message-ID: <0f9ce5de-4e1c-52a3-1bee-aecb1cd836db@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com> <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg> <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
 <20261030030715.604215-1-starchang@google.com> <65cf2338-7bb4-3151-f3b1-ef171bb5723b@ssi.bg> <c2780bb291244cf32c1dbda63f0dcf594d22da30.camel@sipsolutions.net> <20261102070552.3516567-1-starchang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-919739469-1793654879=:61730"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-919739469-1793654879=:61730
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Mon, 2 Nov 2026, Star Chang wrote:

> Hi Julian, Johannes,
> 
> Thank you both for the great discussion and perspectives!
> 
> Putting the two points together gives a very clear and coherent picture:
> 
> 1. Julian correctly pointed out the real security risk with Hole-196:
>    Attackers can abuse not only unicast ARP replies, but also broadcast GARP
>    announcements (sip == tip == gateway_ip) to poison peer caches in a
>    shared-key network.

	The GARP request is one of the possibilities, the problem
is that any broadcast request (not just GARP) can poison the cache,
so by setting the flag and skipping the neigh_event_ns and neigh_update
we will ignore any changes of the hw addr.

> 2. At the same time, as Johannes reminded, Linux already has a dedicated knob
>    for that specific broadcast behavior: `drop_gratuitous_arp`.
> 
> Looking at the existing architecture, the two knobs complement each other
> naturally:
> - `drop_unicast_in_l2_multicast`: strictly enforces the L3/L2 boundary by
>   dropping unicast IP and unicast ARP replies (sip != tip) inside L2 BMC.
> - `drop_gratuitous_arp`: drops broadcast GARP (sip == tip) without tangling
>   broadcast filtering logic into the unicast knob.
> 
> This means users defending against Hole-196 can achieve complete coverage
> by enabling both knobs on the wireless interface, without needing to overload
> `drop_unicast_in_l2_multicast` or change core neighbor learning behavior.

	The DROP_GRATUITOUS_ARP check catches sip == tip = GWIP but
not sip = GWIP, tip=VICTIM_OR_OTHER_IP broadcast request.

> 
> This also means [PATCH net v5] (which dropped IP changes and strictly filtered
> non-GARP replies) is architecturally aligned. We can document this dual-knob
> recommendation in ip-sysctl.rst so administrators know how to fully secure
> shared wireless links.
> 
> Julian, Johannes — what do you think about this unified direction?
> 
> Best regards,
> Star Chang

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-919739469-1793654879=:61730--

