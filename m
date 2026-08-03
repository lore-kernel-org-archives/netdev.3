Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646C33FE33
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774841; cv=none; b=rsKED7CtO45hLQEuXWt1RjfykMj0GLN9OVsJYcfcSlPb7qRzADUAW1nsLnHwLzh0vrnnuAN4jUJegCrAsPloisE5bEQ4lmrnl05xfpDUj5iBoE6h6DbIJsmO7OegMKdkZ7LYMF7ASIsKgAC+BUhRQay1EoyXkwarZUhe4qMK3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774841; c=relaxed/simple;
	bh=zwJkxw5SudIgtnf2MpOiC10lmmubakIEO3yoEutMqHc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oh5vR6lxNh8GMllL7b8JnecfsdhbDMZJRPp7EjnOjhgIjMOIMsmALhxX6ctQ5rBXEgnxJ2zgkZ43GoTODGafuAd3+c7ZWSMBmTcIZ8yqIVZ+/UmUILRXJOrKm1Y6QkJ8LvzFPZXsA6LNycUZOiSm880bkiApKGuZ4i2M2RVd+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeLdqplP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeLdqplP"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81e9d8f3289so49897197b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785774838; x=1786379638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gNLoWo+P8qlCakR2WJ5f3wyWMq+03u9r4rMGFyhRsCo=;
        b=UeLdqplPrPnEIkhyn9eqinBBjIdJU5J14AD+604rqx3a8RsKfmEmy5tX93+rQ36Lkb
         k+Y1AnDuvn+6UTmbykLzRI43+wDwkYuILWqX2KyYqiStVlVCTy4KNKEpYv2lN8ciRjck
         ZwOx7nT1f8YFHvQqjhOVELpau7TQp0i9epjNqu0IkhNMwxRXpN63JfU4Nn5XMO83EEVB
         x3k6dWcIjs1q14Cc1FayDOsOU3vF2Q2Qo9jVDk18ihYPy1VQwa3o/fGHMyr7OvUbR9Ur
         TRcP31gO/TrlcrYLFdJkKhe790fVYYaqFMcyyaMGIAQKbM/EVoXWoOk23gCIe26pq4uU
         s+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774838; x=1786379638;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNLoWo+P8qlCakR2WJ5f3wyWMq+03u9r4rMGFyhRsCo=;
        b=YXlYvrzrOZ3UkQrwuPMaziBzaG9oPhoyrNwy+to8Qk4c4v1WSKL1dI0ReMCdF7Q9XA
         ia84gYpvSF4b7U4QYzgUhUJk1sAhOLs570bMK2ooUVsZIcFWYIm2/f3tRq6mT6Dk0VSR
         jyrzZ83o6lQ2x7vOxY6ztOSgi8b/ZV31nzEATuAkLg12AIGUy8MRMgzz0SGxWoiY75aL
         GW/XzKXHY1A0V8wKWVZgC+iyvmU+jUj0NaeF26NRQpV1badJ/fK7sVyKAo6YIzxPQBj0
         poUsgwWGaSrt6zAOKbhif4x38qE0AoebnpIQlglPNaqJwcyjB5KTgCzBz4HlLal14dEE
         0KZA==
X-Forwarded-Encrypted: i=1; AHgh+RrBs//3kc7skd3tvqD60KmIXrj+QYTtkRwebGmjcv1VVyInVQJUFFObbRGrvSsXBQURZwyoCn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIftLl+i+BzBwIp8Leqt4h+D4h6fwBve0zzyzD4czmBLA07x8
	FXV4UYMHhbnwj6iASFsJGomi4C9DEFfkn9o8s1jNP2GvhJ2T8ogC67C0
X-Gm-Gg: AR+sD11nN0rMDYXswxWkgDtUiLENuUSsyatp1IvliLQnkGErTGVFHpkTsX9HoZaP18a
	xSHDSLedprHrkWR/RjNSv/qTJynhU0tHqbawJ5vkNZeL7yG74hBFdnsBFdb0BDsZTv3AFzY+EO5
	j29wcLPei8909sM7xcuR09KK3lZ+ZPOg04VTPgHukJVQtnkIgcqm5Y5Paehq892m1tmRE15l8YN
	GUz1E0kyn/4lLDqP/5jjCeB2b5NFtb0j6Vgh9piFeXbQqUvsk9Pq0ZH2QcdAFLzOpdPgpvaZ5uK
	/eGEvrRJmZQKGU6YvLK5TsJVk2mWiMxWy7r+nQ+K84UZDG3CurNH+OOQr4dkLNyRVA2kqgcby8N
	MtFMa/GmYXq6ouSl7MNRmAyojp/FRcPRug8Nb3zNaZ9Shu+8PwVMNrL/5v+Pag2TtEDR2cp2kZY
	4U5/S7oKRBbk/oxUwZXMcjtfJX/Tb+q29uElz9SW4TL3Pxb8ek+n62mMeiTWtURyeC4Px2VpD8M
	VUmyg2C8WnbUuppGU6ayb7H1PihouD4wnXi
X-Received: by 2002:a05:690c:698f:b0:81f:3969:4abb with SMTP id 00721157ae682-81fd4c36a90mr143333377b3.29.1785774837548;
        Mon, 03 Aug 2026 09:33:57 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf9555dsm59001807b3.20.2026.08.03.09.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:33:55 -0700 (PDT)
Date: Mon, 03 Aug 2026 12:33:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 denis.pilipchuk@oracle.com, 
 joe.jin@oracle.com
Message-ID: <willemdebruijn.kernel.4208e597bdf7@gmail.com>
In-Reply-To: <20260802224612.264563-1-dongli.zhang@oracle.com>
References: <20260802224612.264563-1-dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] net: tap: set skb->dev before parsing virtio net
 header in tap_get_user_xdp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dongli Zhang wrote:
> The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
> dev_parse_header_protocol when skb->dev is null") fixed a crash in
> tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
> This is required because virtio_net_hdr_to_skb() may invoke
> dev_parse_header_protocol(), which dereferences skb->dev. Without the
> assignment, a NULL pointer dereference can occur.
> 
> However, tap_get_user_xdp() still parses the virtio-net header before
> assigning skb->dev. When the vhost TX path passes an XDP buffer containing
> a GSO virtio-net header but the protocol is set to zero on purpose,
> tun_vnet_hdr_to_skb() can reach dev_parse_header_protocol() while skb->dev
> is still NULL, resulting in a crash.
> 
> Fix this by looking up the tap device and assigning skb->dev before calling
> tun_vnet_hdr_to_skb(), matching the ordering already used in
> tap_get_user(). Preserve the existing RCU read-side critical section across
> dev_queue_xmit().
> 
> Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
