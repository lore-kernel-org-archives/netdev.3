Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CD56E05E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087668; cv=none; b=p6IToDZYBn8nsp21bHMPKfypD4O/3oFINHsGoqM9hn8IBjK32XOH440FrtwF3ZC/YloTTXCfr9+bUcAykF3TkHms3TdGwxs7j1fEZFMlyYwzu89ySVdpcTs9RK47yixna59uiy24JOqf2xAIamnfZHdwGyjVfDVRBc/2NZD15/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087668; c=relaxed/simple;
	bh=xAk9jUZ4tHEIPjhowarDu1pLkojlKzRtPIaVJYJ41As=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fCnvD0sftR+/iMkJhC+XQtE1oW/bQBjNQSXRlJWeTe3qwozzzOmn9WcLK4t/7W+Cax6tM8kHR9fnbcIjMpLRofnf/MX7OEHzqJNaCaiGvYGGvjrl/u8AYa/8cRlQzQ5G3WE5t0JY46ORpAnwbw+SaSmok+MAEqckdLjrJTzUycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4z1QMg3; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4z1QMg3"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e94120191cso3559049e0c.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087659; x=1792692459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nq2p8yOce4bNMEA6ygRhHxutRNrExZqu0Cd/fcqSm44=;
        b=a4z1QMg3lpDADkHZ0FctIrivV63CKx3EReOyWjA5oQvTVEfkTbINiZ0ckZZLvlXeD3
         SU0Iy5oiPGh4EP+3rxENFq1QGaz5JQjhi3fscWCJhcN5UzhtNFAQvH6mJbvzFa6feFUI
         PS4HZKyROvXdIGQ98gwjmL17bfLtiXCG7iqnc17e5zBBGQ9P3DGRUR6mvz0frntzWF2E
         u8NjnM175NdKh4jhI0Ss/32vLg2bMJBImwVa4Mem0eu83UDTuc3A12iiWy2uKqG82muf
         ZQIIFxHAjdmihHYPgvT1Sykr/GKoKvLGXkFFTf49z3fl4R2ScO9KLUE1HGeUIB6+KoEA
         keow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087659; x=1792692459;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nq2p8yOce4bNMEA6ygRhHxutRNrExZqu0Cd/fcqSm44=;
        b=gMYCG88Ucwv6ipiNGDtn/WmZZhLUxDMTu1c/n69trhPp2BBqXP4OFxPd2Ic1rSpYwD
         NNYMjuSoEnqFJX1GOS10QSK5AueGjhdg+NL4n/6s7UXZKiocJop7/bgS/ZTQv+/K6OOs
         x71Nfo0lDeM9copXqBfCEkJE2YMHbNPQezfSwvO7WLQIGm9H32cf6XjbW6ZzJFKbxT4i
         uXG0zKdMCYXznmFP1nexei1OOCL9jbtBZKkAeX/BnM2j3OV/7bSfLy7P84Fj1QzyXaFC
         FK8nB9b7o5DsxWIsoqFGy4NUUFpC8r49Q3QVR8QiXFWtFgm1dyRxd4BFrNhZTkeOJZ5q
         qHhw==
X-Forwarded-Encrypted: i=1; AKwUvBznyPmf6KwbMRtWFwKmp1vjNCgYzQNdCx9OoYnxJ0EFe/S90rtMjEQ2Q+1PJOYa+rcGbl0W0q0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT6ju5kyP6ODYJSHkdgiewXw+OyfwpXuqDpnXF7E4cq6LS8kYn
	9BtmSwCXw2qJrszIUNahKvj8D1F8Ri+1Rs/6yvXLCC6FihgD0e1tFgqX
X-Gm-Gg: AYBFou1Sot3YZj01cbRRD6vBSnmuZR8I1OnS2h09uK6gmeNO/C3kfdbOH9FvvLRMOGw
	568Agl5FvKPtY7k3kRcOb/McpHB8wQQ3kP+wlqq0CFQXIGqvoR1k//UbblINNG86BZYmSUHA71q
	kEP/0Y92ksBKjmAEF+yTogGygkCZ0fl7fwx6Iqs7X7pEh9E11t1u+yEJ2rQ+KRiWleazIDmB6U2
	kDuO4FOUzMEcz4MpXItQBH5HjH5M4mFRihsAz9lYlIIUp7feR0bf3Y9l8ZuwOklk64TgYKPolFV
	LgqkgYJCUzDKvIhJFSlGZwP6jgJcdgq85Uc3TxoPl6ToORNjgZF9GyQ3UQuxQYeGBVNT0Rxc7DI
	py0RYeXlLcX+GZ3K98KAqxgK5daj8H4KFaO+mEBhdxj7667W6Ltbf0Q2GNi5Tye8UAy84jje2Zq
	TaKfnlGvYgy2bwKTErYlJbK1414vTYSlS2ebiiHPYV1FpGXqLpP/fl7Z/QtTdAlBc7rHPC/gobd
	p9vUdgSfeBeDnyPBl2TLDDGQxYRhWnwBKlV4+yRDfNl6fYXl7ku+UqLXyOjKH8xYOZe96VSZ7Cv
	IW+eZxkOnJuX9OloJqV19YVmFPUXeATAtkx6rQ==
X-Received: by 2002:a05:6122:8b83:b0:5ea:389c:51e4 with SMTP id 71dfb90a1353d-5ea389c5604mr1033114e0c.2.1792087659373;
        Thu, 15 Oct 2026 11:07:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea99491db7sm304799e0c.10.2026.10.15.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:07:38 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:07:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 Chris Arges <carges@cloudflare.com>
Message-ID: <willemdebruijn.kernel.18c52b086550a@gmail.com>
In-Reply-To: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped

The biggest risk I see of valid packets reaching this path is packet
sockets that are not bound to a specific protocol (ETH_P_ALL) over a
non Ethernet device.

Iff proto is 0 we could try to infer from the first nibble at the
network header:

+	iph = (const void *)(skb->data + nhoff);
+	if (!proto) {
+		if (iph->version == 4)
+			proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			proto = htons(ETH_P_IPV6);
+	}

