Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660493;
	b=YaAkE6w6wdHdUVfoDwgbvYcO9/Y0xHz2ajlJokqt+zdEkMXx171O+NCVUGot0jClM5j1
	 GgIGpTATbpm4HU2xWgUeCY8sHwTsUr+Mw40AlvnjjW20qBsJDmAmZe8E2XYDvMGJ81ySz
	 nHHMeFYQlGqToq8CdV8xIwxvHz5bQojzsxs/udj5/KSzhEwGfBoz7vbUkXpoPa/bYWs5S
	 ZwTGgE/Lb1AElPOsljiWPUUBF9vWxcxP8htEBB2+MEgHCf2cawrWRHaMDdqCAgr4PdIdu
	 EZI+teDmEKhkNvpRB19q+tBZTw6GKjM51KkNmFIgBgiNDihtnmuq+3Y+6pejvswIDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
	b=0dhMvy3vHL4w1Fw6LfoBB8iGVu3f87qB4jduETnAKS+qZgvWhMLm4NAPEiqWH4/JwI5W
	 6iypw94efopBYW2S7ILmYG4YlDimGURNlSIn95vPJMvNgjwU0Yfm9K++ECYt6JGUetm9Z
	 MvmjeffphZT6UTmEgooO/cgYKWDR719674zbWiNj0H3ShTSavUzw5cugA7NowO7Kf56JL
	 w+qlhAK9MwMcZyDwr4LdePU8RdJKrMYC0qZsYS17K/tyajzWdnGMfoNEERCGRt+PssosX
	 johwC7RSo79kuJwLD9ZjJYFi9lXbp5f7Rj/lJjPBAPJb3DnsZuo7QjFn/plig1mAJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPLZIOW9;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81D606A327
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F81D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPLZIOW9
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36661f953e4so2991745eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660492; x=1793265292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
        b=OPLZIOW9Y86Du66N6PpGEv2rrXIzo7DC/u9Rtm6Goq4g8e31ID2NCNFY9uCn8zHX5J
         Q3K5fWA5s0/tnaqEN3SpmOPRI6/JUnFxozHd9kPO+KkFLynHq0zP1eQLl4DJPMzNVvGI
         Mlx9R3Q6rQaW3ImGGmJ9TpMeeHMQMsKk73KGnldSxUjjlSp33RHeCqLJsAgzqOBchuTH
         8wO1IKtg55FCfnS4Em09lrDnlxtmQjG25v6RQ8z1EtCIAEowcyPQXycahSZW4h0O+Bv2
         17+tSg8bwfG+Arr+nGReidwwtIJwrsqMN8qXnKZxzXgdOLsVzsPunysI/Tr0mTYbHSmK
         AbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660492; x=1793265292;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
        b=ROYt+M7l/BcOdXc+CXt3El+hKHzQIZDudcqT4rNofhg5n2yt2fx52TcRpANFED5Qj9
         C5kSx2M6QIHR+pBsIs7fhmMgjEH8ZZbCe9Y6IxSiMX8x7c09q0AkZBRSa9M3tcHdn/IM
         +TAgK9KxetZU8N3BSadqSG3mMhCYs3eAlerleenra8ey/VVp9akebIrBRD5kD+HKkEnb
         ZDewx7lE9lkzL95udI9jl/dlMxeoi3lMMOhC0KAzXElYLHfTQk5sZypu3u37NPuum8yT
         5yQKEDklc8OYp17ek8VwxEYVLfUGm0s3z09ec5hOjZMNqQhYU7pC5Klt+jYEI789pjdZ
         0a6w==
X-Forwarded-Encrypted: i=1; AKwUvBzGbtwMef33qNcgOaNLS7bf32+BSnOY4rJE8QBE5TDfS+8hq1DpY9GWD9Z7KtodPwzKbTrooZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0X//5DaAvkYMnI+UiCEzSi+einxRpV7j1COBrcgQSpM1FpdRI
	P8cr40CEubxBkxqgVCiFylRzz8ra1nZRj9dfMRxaASC88cOc9WeHNCcc
X-Gm-Gg: AYBFou2OTUtbbm3cyybo7jjxpwmSVe+P7rBPKDea3eLcaHQWOsVFbsHH87OFGZrYgQG
	mhfmAiks9xeJkt00dUWSUxVv+h0TrlobhSRYGmTM3o5QikRhuvz7wWy7pmDw0/G0V7WTmICcFWL
	Qm0euaivdoePkw12OMhAH67ftxNVaWPkXMFhbca7GG2SdFm++uZNYp0n9kbYcxJaSGgvdx1cDUz
	pFackqzVpMkx3UVVVBOpR5EeIP6uo1IcDjMKHUFuinXpv4FO+KwDLHi+hziXVCxI7SwuTKCU0ou
	ahoDjRZ/dywCXkhdZVFaynZ5LeDxLZcriNhDArwcfE+TOinLYz4jhCTI9mJ8UZ3bq0fXmqCwPvj
	HWjCnF9F3vvjyLeixPO/FvXM9unKEwRQ5wJw9CXZWoIB4BiFDrcp0eawDlGcq5j1pPlDak0kUL8
	fpmeucC8sejhbfwiKbaM41zXAaRvABUwMmJQHBhrvgDXWUe6OoSFAX/wz0IyugyP4MrpfjHAO72
	H9wEXYsDVt4PSOeo3Z7m375PTN9ER7plHmTQeqvvmj7L5rqHfnM7dfYnpNwIjIeP0qCFvAvi1ZQ
	loD3ICl1nmE0V0RXN1Y=
X-Received: by 2002:a05:7022:1608:b0:166:37d2:3b72 with SMTP id a92af1059eb24-190a6add68bmr5187470c88.27.1792660492388;
        Thu, 22 Oct 2026 02:14:52 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903c71421asm13121003c88.16.2026.10.22.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:14:51 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: failed attach leaks slave promiscuity
Date: Thu, 22 Oct 2026 02:14:45 -0700
Message-Id: <20261022091445.3650534-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

br_add_if() can acquire a promiscuity reference for the new slave before
a later error sends it to the err6 unwind.  nbp_vlan_init() allocation
failure is one reachable point.

The successful prefix does:

  list_add_rcu(&p->list, &br->port_list)
  nbp_update_port_count()
  br_manage_promisc()
  br_port_set_promisc()
  dev_set_promiscuity(dev, +1)

The err6 path then removes the port from port_list before the remaining
nbp_update_port_count() call, so the removal path cannot see or clear
the port's promiscuous state.  The later dev_set_allmulti(dev, -1)
balances only the separate allmulti reference.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  Failslab forced an
allocation failure in the first nbp_vlan_init() allocation.  The failed
attach returned an error and left no master, but the slave's
IFLA_PROMISCUITY grew 0 -> 1 -> 2 -> 3 across repeated failures.

A later successful attach/detach moved the counter 3 -> 4 -> 3.  Another
successful cycle returned to 3, proving the first attach/detach pair was
balanced and could not remove the references leaked by failed attaches.

The error path must explicitly release the promiscuous reference before
unlinking the port, or reorder teardown so the normal promiscuous update
still includes the failing port.

The PoC, fault-injection runner, and complete program/serial logs are
available on request.

This was found with a multi-agent workflow; the state
leak was reproduced under KASAN+UBSAN (no crash is expected).

Thanks,
Cheng Yongkang
