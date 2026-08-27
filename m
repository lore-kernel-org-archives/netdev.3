Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709F3DD50D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819664; cv=pass; b=upb+excnoxFe02DiXcDTcN1I4ebOzxfzjGXfFot2x9J7cnvkbozEhTwN8eu4Ff5chKp3ejX+IEXl+NORtvLuos+115Oc4IWDzGnfMt1BWNGQ7EEWVzZg6uoRVluXbe9KpQkA+SMElDthXyQX60H/AlyIf9VLBSCryS34eUqOr2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819664; c=relaxed/simple;
	bh=zkWu1QXsO5BhUtx/uaZDapNCFP9r1lgNqeSZMQRg/68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehPwq+sUcziWKWPby/pYtcEeIX927x7N8Lkb6hLRNaSbzjLn7L2R1th99sVV+N9i8/dhs6HKH7dYWgMHyBr84McBDli28P5dz+AXbuTuOGV3nDSvzI4HiAHQLYxpJTRYKh+uP3Yp0QpOqHS80mxE6XUh+V3MTZNRt5ZStgcf1DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bfVhzx5i; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3K3HLdK6; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bfVhzx5i";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3K3HLdK6"
ARC-Seal: i=1; a=rsa-sha256; t=1787819657; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OFzt9+dftmWkApd6VNZMG59q0AB6ijHKq6lQLs+b8iMyu+3aTFW90wkfSHSVRhYxMQ
    lXQ1DE6I61GPsElLVV9i5avFQZ5Y6eizarT8oAEmGfwGFfLYSIMGGfFJ7mmRlbFg8Kv3
    J7tWnZH5npWPtMd87CsX7q7NDKvQHF4lMtL3zI9QztunBb0uqkCi7hbsSz3wX8ZyYZ5o
    BHTgwNzscWeFjGgMDM91Ng8XlIkV/7eZbz0icWJs59XyUeEChzVglbG02fHI9B0veRQA
    IEvZu2cZReEHpivscQbu2xLHd+wj03dZD6Mqy1tDg8gxswtZVnKUlXa36/dVDmNkuvA/
    89iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787819657;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=chJ3Mwc0RJU1vBvaq4a+2hTBNOZsgq4lgTnTn1JJd/4=;
    b=PuBkFHykl0MWeNDnGY6YEXm5Rsb0he7ZDxg4TRF5NvqdDUEy/N81LAp9jIZ6+wz8wg
    k2T4Til23nY2WwHiTtc2pEyptQFqsAp3vqPK2SMv77U+AbJuUleTU2kRkw6zLj/BuJBh
    QqganfeCYyhTs8FibYMCnxynvaI5L4WNJ5Kr9EvDuERXh0abIkA1BbIJ3BFXvUhdetvX
    N/EcsN+Q7tOHccBpXFbX/jLxg4Xw3BW+vbAnqezC/W632omUIR52mqorbHpavoqV0n6n
    sE7CsZoSxApci2Su4asQViSGe9QEHjVg4Z2YCRt+8nFDRXjGgmTyXAzVoFr00u31a3os
    ZIwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787819657;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=chJ3Mwc0RJU1vBvaq4a+2hTBNOZsgq4lgTnTn1JJd/4=;
    b=bfVhzx5iitUfrRquWoj/BwaKLo6swTagzWZsYLBJ6luZi9jOM4UlVTD8MB0Dm5j+QC
    yVCrwJ8mn3KHUVJLe2XqzE82350b9iGUtbe+06LjOYi9bPyUs5BytkjVuR2FG7HHH1E3
    H3Guouf8n2qKeuCAo1FJ1XszPTartsOA/VHoeLAC3aSB9lRi3rKsFKTwRUavj/vSgeie
    s506xrK2yIjT2gbMhB5NKRbzXw0E5mVIe4RC16Z7nwD33RiVmwunfpDIuUQPqoTwARDl
    O1FlYxDOWug9gxbH1WuGQyog9aykiMN+2t+J7wRU7Fo/UpO+pHYTn1UjKG0/F8bVyzp5
    y7iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787819657;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=chJ3Mwc0RJU1vBvaq4a+2hTBNOZsgq4lgTnTn1JJd/4=;
    b=3K3HLdK6zT6wslL+S+tioH60FpyYG77RE68HTO9C2UBUSFc33bgxAIsYPZZiDVeZAK
    hb8R4QOyJJTSY++xpkCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727R8YGyHB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Aug 2026 10:34:16 +0200 (CEST)
Message-ID: <bea8bbbc-d96e-4c87-b935-8f4e12a6916f@hartkopp.net>
Date: Thu, 27 Aug 2026 10:34:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 kernel-team@cloudflare.com
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
 <ao9UV9S7rUkyQ8jv@strlen.de>
 <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.26 09:42, Paolo Abeni wrote:
> On 8/26/26 11:02 PM, Florian Westphal wrote:
>> Jakub Sitnicki <jakub@cloudflare.com> wrote:

> Still WRT optimizing skb_ext size, I think that it should be feasible to
> optimize the layout proposed by Florian by taking in account that some
> exts are 'mutually exclusive' i.e. on top of my head mptcp and bridge
> should never be attached to the same skb, and I *guess* can_skb_ext is
> mutually exclusive with most of the others.

I would say with *all* of the others. CAN skbs only interact with 
ARPHDR_CAN netdevs containing a special ml_priv reference. And 
routing/forwarding is done by a CAN specific net/can/gw.c code.

The only code outside net/can that looks into CAN skbs is:
em_canid.c  Ematch rule to match CAN frames according to their CAN IDs

But I think this is not even relevant for CONFIG_NET_TC_SKB_EXT.

> The layout could be adapted to such constraints, and there could be
> run-time checks (under DEBUG_NET) to verify such constrains at skb_add
> time leveraging `present_extensions` and a static matrix describing the
> mutual exclusive status for all extensions.

+1

Best regards,
Oliver

