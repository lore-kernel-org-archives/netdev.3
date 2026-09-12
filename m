Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E863B71DA;
	Sat, 12 Sep 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209366; cv=none; b=Gr+FpWZcROCdNppJH9LRXwzFgd1d8uTVv8q8HHZCiu3X6DvTwDAJ8KZZ/D/ZRo80SY92V3MOf+uhKtyamjnhgtzqbejcNX4zRN6eeq7vFx5XgVCwySr4P1rkr0ki2beGwgkjBgDPBwrTqIly2slXEiptdk+kNXGq2H7Y40lObuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209366; c=relaxed/simple;
	bh=WZq+UaHJ6S0SKyG0O+UQc4ALAfsFCz6b1V4xye5q4TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX+KmkrOxhtWuNwKqXRVJQEj1WkzrHAfNTwm4mxmN8suHEEpTTVJgkLyCgx4uyX6b81RW/sM02ayeGEcn6i0WQ3kEBzjxf2nB2CFP78plXVMHFAYkw8g8vY35vh/tTVBYHzGKH2nRMk6sNASPGtW0EPYfQJtmHIvRLanzn3pvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=ln5x3KSO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="ln5x3KSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789209348; x=1789814148; i=f3lix.dev@gmx.de;
	bh=WZq+UaHJ6S0SKyG0O+UQc4ALAfsFCz6b1V4xye5q4TY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ln5x3KSO+HJ1dg+oj/b+vL/GprC8vAwzi9HY//QBSDq037zuEVln+4+t3LqyHwMs
	 UqHN3FEZhmoAK30kPa0El2XUicOEmvu7GPjWhCNs3WF0Ld+7Rpx+SITQojfcDoc0Y
	 a0m3I4tjEksoahWcqjyQ8DTKrS1tDZO+FCJNEz4jiwJQ2RQ5NxHFvtFik74WySPCj
	 KWU03RsCr0fHGAl33sw3PqNjsbXNC/wKd0TjBKFCI6YTG6MNCG3X4erOYiL5abII7
	 jJNkeDHRB77HESqf01TQ88BoU7sNgf1WwcEraqZxrhx1KbMQN6vOXZtJoW0L95GSa
	 faLRyZrGM12AkbFzkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1x3f4b44x0-00AK4p; Sat, 12
 Sep 2026 12:35:48 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kaiyuanz@google.com,
	bobbyeshleman@meta.com,
	dtatulea@nvidia.com,
	uqbarz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix TX binding UAF on netdevice unregister
Date: Sat, 12 Sep 2026 12:35:10 +0200
Message-ID: <20260912103510.57232-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHS8izOJfCCistkyZfMpfvf8jGEgtZ5gB5qROC59qnW43PPC=A@mail.gmail.com>
References: <20260910143652.166683-1-f3lix.dev@gmx.de> <CAHS8izOJfCCistkyZfMpfvf8jGEgtZ5gB5qROC59qnW43PPC=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QURqdzQWvjBdvxpfn+dGYKWlo/wFKArdC95bUCqEKMdk4LLxaiZ
 T/9hZ06azbFVagp6nSv6d/bXVh6RgFDZF7oUUwCk3C4RAP5su8cPpDRzId79kTjdC7s8Hcx
 ZZ8tEacuGzYglJebGo75oejlyAv1vzwvTO++NMaTmbvBMiIRdqk0Cc6PtxJeXK2x2x21GYe
 +V4I7HVC8Jq5JtxJfOVSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c/4EdI/4omo=;B6F/Q10jg6as637n/8cZEczLKfd
 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
 BFqVBNVfR/WmIdYb52kIFgFVkBbcfqs

Thanks for the review, Mina, and for the pointers, Stan.

I removed the RX-versus-TX comment and the added DMA-device field comment.

You were right to question invalidating the entire binding when the
virtual device disappears. The socket destructor uses binding->dev;
binding->vdev is only a cookie for the route comparison in
net_devmem_get_binding(). The revision clears only vdev on virtual-device
unregister and leaves the physical binding intact. Clearing the cookie
still matters because keeping its old address could match a newly
allocated netdevice. Physical-device unregister clears both pointers.

I factored the TX-binding scan into a reference-taking lookup helper. It
holds RCU while finding the binding and taking its reference; invalidation
then takes binding->lock, which also protects the socket destructor's
netdevice reference acquisition. The temporary binding reference covers
the interval outside RCU and is released after invalidation.

I read Dragos's proposed netdev_has_dmabuf_binding() helper. Its boolean
physical-device/DMA-device query is useful for data-direct, but teardown
also needs a binding reference and virtual-cookie matching. The factored
lookup handles those requirements; I have not added an unused exported
boolean API. Dragos, does this separation work for your planned helper?

I added a separate KUnit test patch covering real netdevice unregister
with test-owned binding metadata: physical removal, virtual removal, both
orders, multiple matches, unrelated/RX bindings, and reference balancing.
All five cases pass under KASAN and lockdep. These are kernel unit tests;
they do not replace the hardware DMA/netlink selftest Stan proposed. I
have not included or claimed to run that hardware test.

The current netdev guidance says that a fix and its related test should
go to the same tree as separate commits. I therefore prepared the fix and
KUnit coverage as a two-patch v2 for net. If you prefer the KUnit patch in
net-next, I can split the routing accordingly.

I also added credit and a link to Hengbin's earlier report, and corrected
the missing Cc recipients identified by the submission checks.

I'll send v2 as a fresh thread with a link to v1 once this discussion is
settled, as the netdev submission guidance requests.

Thanks,
Felix
