Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81831AF14
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787423986; cv=none; b=jE92esHovVdodyVc4Ey8gKpxuVWYiUcYw7oWcYDJcGkzkXnCOYaIzX5smIwD5yLYUFLGRD2i9rpshJnfHtvTpqjeCGS0mvfrYMUFa3DCVCW0xqa2WnAfnOz7cM6ZZzqGzCnBQDnVXMeng4m+F8+/5UbuX1OzKU3cCS0m0mAAq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787423986; c=relaxed/simple;
	bh=fAIt1Wm/71HoY58jaBdmSMFD4XoDslDn34Q1IewWy90=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b1g7FbMLibkghRES3bkc0/Sd4iu6X7BiJdf8HH7qUjlaWukPYui59qjCW5r8N++BjvjS0ZTTfVK7PVsBBIfr5Dc38i+JEjIHbXb2/XLaN72gmWlsSofX/IUN9F2DtQXcNnm7EbgT9G9OmgPTJVnyJOK49FMK2K6QCbA5GuULtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI4zOMJF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI4zOMJF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80cebd41372so33000547b3.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787423984; x=1788028784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+3Jf88yTHPMpvRIbWTlYW80u5SQWPG5ECMF8C9P+nFk=;
        b=jI4zOMJFlkylo6417XRuzGMdYtDP+/x84cpAncDsE2fC6LpZguVXK8bBcVmI04+kRD
         q4pB1vmvmqMsej+m8vAsb0cloHK1QQJMV2EVbt2g5GKwo/dT+jimatrMkKemVKUXbqKy
         pA0ySvKGZ+TqCb1zM+ruA4cQ4qozmtZvSvwepQh9IBJa1R980vjiyWQBdM3ZjdxE0upo
         H/7j20cL8p+Mjfft4fD1Bq3vJTahwZiR2GWExb0AG5jT+na6kDWgQnDI7/inFybAQR86
         eVMlidLmTPfq5oRNhkBOp8ll5hWk+MPsJ+QtS2wTFiULpFbGTZyADidRqjva4MK3ortC
         fMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787423984; x=1788028784;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3Jf88yTHPMpvRIbWTlYW80u5SQWPG5ECMF8C9P+nFk=;
        b=YcyGbknHaiJskwNDrAoTDb1ivKa5MexzoVz+4AEhd70Kb71ro1d7VzX1HXxblz6N4J
         GKBXjadr0h8YmXR3nG4e9CJn8/chryJoE4ppD9ZnORRGwsrs4VG2zBCpfdhWCQp9lqVp
         ceMjXqvwniJhGkj5xPs/QcSYPsRSAFKGF9L7M4KqSRIug2eYlffT94Ib/kVtPmiSiBc4
         iJEEuGPc8Gk7p9rUd7gkKn7zXhQvFubsg4f78scMgaYYnSKV5oe6auXYgGw6j4B98bU0
         9/jQ7d4p3kXLk4+klCvTa6RqxfsyRlfnR/0n0XBvk1/C0beeyjgnEogA48haDfpkcMn6
         mIPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0tbS6d67ml3vogXHL8i6tYDGoJgkPBYwKbDc/PQyBMMpM6VqUDebIKsk1vb9SMTwawi45lpM=@vger.kernel.org
X-Gm-Message-State: AFuF++lLggJQb0zNnpnXcVgF6L34M9mYAPaXcvvat5QYyRfObZNJYwGZ
	sXIC7FD0Uv+TX5HhoUAyW/hhgWQifOB3PfTfV/dDAUD2oFVdq8K3e5b8
X-Gm-Gg: AR+sD12dblTDLD9Mz/R0xVQrl+Pfhg3j4f16MRW2dxXtcGkW51SpllqAdEVoee9yPSp
	guM5wAVeDWV9LeoayTLclDOSncOYhdpE/xvBxF57ytpCFjvxhgHxSJ8QFEEhkGqOdOpegI/fOa1
	4dAHMWbsjqQm+R5NQmNRm2sxDJ5TqraUtzynol86KEkdUmvKUcztGAZ9btMj8dnz+erev7TEf4l
	M6Pp4XFHrw3Na7yXED5/UVhCu1xUi8xcokAWHNq3vqbT4dC3r8bsEuxYGcHoTqpLeR4p2hJECio
	pg7Sg+bl9f3cgHA1tQGd9N/ZAZLQKH5hD4uF8AxsnEdg2y/PnGVadPTkPJQ6JLgrwl5MEg9Ti3p
	o9mA19QUOIBpEjPpExvXXn6GL8rm1g4FnkFL8cVUeKd+44RP4QTGTWX7VrHwZmyQxdQEuZ6HU+v
	aisYg+jd7M3hGMpjJsVm97WYjW7n426hhyAbGIG9xaho+uS33ufbLzmdkUDLXvekvIBQr/nDTrw
	8sg2XPcVpGAC5cTUueJmRl+GCNBvRHIQDK+5PXiB6HEDTnUHBck8s7Rog==
X-Received: by 2002:a05:690c:8f:b0:82d:aa4d:95cc with SMTP id 00721157ae682-84c93660594mr33819837b3.4.1787423983882;
        Sat, 22 Aug 2026 11:39:43 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb82ecsm13256917b3.30.2026.08.22.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 11:39:43 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:39:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>, 
 syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.2dc1a6c7aa3b@gmail.com>
In-Reply-To: <20260822115717.1161782-3-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
 <20260822115717.1161782-3-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v3 2/4] net: ipv6: Fix UDP length overflow with PMTU
 discover and big MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This commit bounds cork->base.fragsize to IP6_MAX_MTU to avoid a

in v3 it only does so for UDP due to IPv6 jumbograms.

> possible overflow of UDP length that triggers a WARN in
> udp_set_len_short when setsockopt IPV6_MTU_DISCOVER is set to
> IPV6_PMTUDISC_DO or IPV6_PMTUDISC_PROBE, and a large packet is sent over
> a netdev with an unusually large MTU.
> 
> Steps to reproduce (included in the new selftest):
> 
> 1. Set device MTU bigger than IP6_MAX_MTU. cork->base.fragsize will be
>    set to that MTU in ip6_setup_cork.
> 2. Set IPV6_MTU_DISCOVER to IPV6_PMTUDISC_PROBE or IPV6_PMTUDISC_DO. It
>    lets maxnonfragsize be set to device MTU (cork->fragsize) in
>    __ip6_append_data, rather than to IP6_MAX_MTU.
> 3. Send 65528 bytes of payload (+8 bytes of UDP header, +40 bytes of
>    IPv6 header). Device MTU allows it (it's only one byte bigger than
>    IP6_MAX_MTU, and the device MTU is bigger than that).
> 4. The UDP length in the built packet is 65536, which overflows the
>    16-bit length field and triggers the WARN in udp_set_len_short.
> 
> The original overflow bug with IPv6 and IPV6_PMTUDISC_DO seems to
> predate git history (verified reproduction on 2.6.21), was fixed later,
> and then reappeared in commit 427faee167bc ("net: ipv6: introduce
> ip6_dst_mtu_maybe_forward"), which is chosen as the Fixes tag here. The
> overflow with IPV6_PMTUDISC_PROBE reproduces since its introduction in
> commit 628a5c561890 ("[INET]: Add IP(V6)_PMTUDISC_RPOBE").
> 
> Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Assisted-by: Codex:gpt-5.6-sol
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
