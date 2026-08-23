Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A1342C80;
	Sun, 23 Aug 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505325; cv=none; b=QQLJ4g3/YFEn8aKNfvfLDUuOzYFrItsroImFaC4LG32Z84Vw9sddpoCZhrsA7y8gOwnuYkQjNhnsb4pG3fNpuVWrLkEiQMoYvwnKheuNMsy5e+U6Er2W8zsGoOchU1BOwCuzTl4N+deru1xWTRd6ehGsbsCw6eexFu2nyfDKKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505325; c=relaxed/simple;
	bh=3A3uh2GpYNNmVXV8sAJaW3BhTwJVG91WKcpfhW012DE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SmKZ+rzdZhJX9rKw7gkv/bZXJXc3V65okGYPGLLaSPUVj9euBrPmUCjMtzShtP1/8GBUY6gbjAuJ3x1//p2cCR0tkgnAbwTANdBtxF7DSgbFArejxF4zS3/8wVlxDoheHqPQBIBtoC6uJOH0B40yCN/Q6JDDo4faZMEOt33LQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HkuVk9PX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HkuVk9PX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787505309; x=1788110109; i=markus.elfring@web.de;
	bh=3A3uh2GpYNNmVXV8sAJaW3BhTwJVG91WKcpfhW012DE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HkuVk9PX7vObQI7au39ixzxRqVs0u4UJMRFtDteK0+LRgjY5t1EGHI1vigR8iRt1
	 Aw0myITMac0lHZ9XUnNQhqZfbDn6WX0HIjgHcGSbIaSUo8h7LDfsS2q87wCK1u/kC
	 0lvk8d99JX7v70p4WABmNhe654Y/IR0AuYQuJg/XfFtGtNXZGhzvQ0u8GjUjwBZGL
	 dr8CdHemYLsgfJtXmVgnyz3DBP+Wdm5WM9WOYSfRfzicmQ6NVlcsIpRFKBOTTXWS8
	 vR0X7aWztsXU8b3qYdGJBT6xeZNaK0vuu5lMS/xuV58HvY78PCLr6VS5uoFqWSzgp
	 7Fu5pVD+HNpRXo2aAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1xGgfo1iyL-00V3Le; Sun, 23
 Aug 2026 19:15:09 +0200
Message-ID: <00ef4774-5155-4c32-a65f-4affcb52b620@web.de>
Date: Sun, 23 Aug 2026 19:15:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: manushprajwal555@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Goutham <sgoutham@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20260823111231.372-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH 1/2] net: thunder_bgx: fix fwnode leak in
 bgx_init_of_phy()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260823111231.372-1-manushprajwal555@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jP22yZpJ6ss1UcZnT8GmjTFwGcSSa59mud7Lmo0P9M8M75JY5dC
 lEGJ1Chr1CgMYVXrEZqIhyIwjQ/d8Thw0ledfb7D+NoSq0dGJR9gkUx0z+ePw26CqrJ56tl
 0XinQ583AePNruVrgkt9zQn8NJxYs6OppbeIg4mZHwDHUOWvp06A4XWWAqzZE4dFFslksaW
 UxvBKvEkxfdApuwxY92/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vl/UPVSX3Ew=;jhc5/EFdxl4b92pa8LX1k50ljTP
 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

> If a child returned by device_for_each_child_node() is not backed by
> a device_node, to_of_node() returns NULL and the loop is aborted with
> a bare break, without releasing the reference on the current fwnode
> that device_for_each_child_node() took. Call fwnode_handle_put()
> before breaking out of the loop, mirroring the existing of_node_put()
> call a few lines below for the "lmac =3D=3D bgx->max_lmac" exit path.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

https://elixir.bootlin.com/linux/v7.2/source/drivers/net/ethernet/cavium/t=
hunder/thunder_bgx.c#L1466-L1531

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/maintainer-netdev.rst?id=3Dv7.2#n3


Would a cover letter be helpful also for the presented small =E2=80=9Cpatc=
h series=E2=80=9D?

Regards,
Markus
