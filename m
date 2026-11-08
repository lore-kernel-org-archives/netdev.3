Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176583;
	b=jLyFKZdc5VdF4OKLzEoqdSUwbC0kM3c3Eajv80nAYUozY80DWlbbwvWDoxDq9ulaIBem
	 prm0auw1F7I8IxO8bY7PzlRiS9Q++JXezDT6ns6ObfypyzC9+4Q/sTALKaxQt34w9Hrd5
	 kSmkqgnTqFYjQXJNrS13gNw5xkCVzimV6z2XWetPmcYwBECfkrLmWBgNqMRmRmCiy1RmA
	 xupetDpe7AUWjAY7n46NhmABIN1Ejnz+YxKWvGGSHgDYvAJ7mvzCbLml+wP/rg8fq4eDZ
	 q9sEFVrn4XizrWjZacpsoWm4JtGeJZ+1fcUGZ1blcDziHrSlCFRh5xAGuZUBWjQ7W6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
	b=wbQvRLenbs65VpNNQAclhQZy9tzrkevQ/SeRIUkod/YHMDZmDNY7EeC+cflCdwITuXz2
	 dCzP6Slq65zH/H+sDMteia4n6EV7pcIIdbmdVmUZNPjb4fMP7Kb7MBNPFeWIu0i/L0x7o
	 xlpjOMovURAtIZAdrX3WVdaJEYaulcJI1QvT1sk99jNLzk5FadN+FGUw8D+hlN4vmXhmE
	 5YCCf2fAQt6s5QlEsBewWDaX0i9IsEZg7igM4YkmBBPhEk+M3DdjBTRWlL3yw4U0iOPAh
	 wQOH/+3/V6Xrv629SlPkHLM7wA//YMKEsMZUBsfjLj5VOsDhXflf5fYXyOyuB3y6THg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SfY25uKn;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53477606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 22:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53477606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SfY25uKn
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so38109766b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794176582; x=1794781382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
        b=SfY25uKn/JBcQ+d70yTpWO8LSHxIsd/H5CYD830kg4drEdlZ0hGlP7YMe0fNbqiIqz
         7siZ0gKKHa94RYOiPYJFCHHXhmOqQ8tUabYy2eJH+GZeV21o7BXukP4wXupvHBYMf/nm
         ZPHT7DuccVIu2E4NqpN592jLlTAjRhvGCml38LdAXXAv14dX2MmQyiHpqwmfY/Q3oaWA
         eaSFpnmKORAPFbl7025cVpX2Ya9GXha1mu34UtmopeXodOBUkw8it+uBjkIe1jIHf3pi
         x3aP6z8T6QbVF6IX2j1UgdJKNme5qt9gd+TVjbEWj4VQWbiWAFeCA/jdj9bQyAv4WywB
         VJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176582; x=1794781382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
        b=gMHw4BFiedbzHnrlG7oZ5HZvICwH/oSzNiEwu1IBo0Ox5aUOXlJ2G6GUqhHk66G9M3
         dR9sKKnYJO9bFJ6LyLMfYHrvG44X0kTzSUb4mSeuS1BnIPypD61PEgNmjeXvV/M0b/oQ
         7RWYyRtNzvZCme3BRKDLn6GIiVWX+afY8IwNGWy/PWiwEs40LVJgm8VE8zZ3gBO7xVL6
         DgPrgnNJ6CY2+4azoR67oQjLeb9iFV846eJpLiuNzmP4YMtQLReJ2+qADxuBD+Tf7M6S
         VmRPoHPMrqjaseA7By69DLJd14AysJDeYg34tNkkiEqMgXtIZAOkCoPwkC/vkgVubGIk
         Nllw==
X-Forwarded-Encrypted: i=1; AL+hErFV9UAzemLvxsLRSir0WV8MUru5SF90gM0jxHWUMRNmawBk5fP2ZEBJJPTWbsnehwLGhkWYzII=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zKx00hu4m9QayOYB5+cFxnv72Likju5AmcxQkvBHwu6MrIzo4
	hPayqY9/l1i+zurSGVfW5ePA59Fx45A9F80nkpquqmisCx8dRK7TPOyITWZaJMQrqMjHePgy11u
	QdEdU0HM=
X-Gm-Gg: AYBFou0lqzaHQU3CHYg5KFBY7h/1lmP3SLIX/tJrUud4lugtNYuy1zps1fIWJkIOBiO
	5nHW001SUTipBsCizY3/0d/u4tc2zlkYPiWHS/qc+Ok714NyCPpZlcM+k08ZrZ2iROtAW+Hnr4X
	0gy9Wv+ciIDDTyqYGFCV5JMGVzFudN163Hbfnwlc0ZM91OD9njExf/E8wQeKu/gwWtVk2Z74ArN
	c1uo7at4AWxsGVnwCFzvMq+n2RAv8NIfQwWRLf+wf1NKsgmZrsd7Ydz89Fuaf7731rAZlG0EqMA
	8doKzx8cJ56F6k/7Ot5LWEWVVSgVdm2cibldHSoadKf+mhDHFMp00J9iwwL2r2lBAvlUj6QPPz1
	EHYqgG228tZk2wZ+UzmmMxk4xoug7mVQ1bnywGcxQzYejHPdL4rxdB0di5qzEcQwEqWCl8hGSsQ
	/kcWJfmpNgHQFFjFvHqNrcams0yjthQ6ZZ/bHeK8Hy2mrsRaZKPTTh3Puv+ns5s5RIDY/rTdaqv
	uSdjsOxVnU4Rt6xOOUHviahyr6FBHKarRe9vYmwDD5PTpzrKYlp85YTVMuiXT4OFaMHhx9KYOd0
	lpZ5ILG50skkpQKh9LCwFKH3huFF4WyTFLkt9efZCXNzq8dE93y+M2nPJk/b64g=
X-Received: by 2002:a17:907:1b18:b0:c3f:c856:fb7a with SMTP id a640c23a62f3a-c4d6d166840mr164389566b.3.1794176581779;
        Sun, 08 Nov 2026 14:23:01 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f944a1sm91809566b.14.2026.11.08.14.22.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 14:23:00 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: sashiko-bot@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 2/8] net: reserve extra TX headroom for local egress
Date: Sun,  8 Nov 2026 22:22:56 +0000
Message-ID: <20261108222257.16997-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-203545@kernel.org>
References: <cover.1794020868.git.tianyi@cloudflare.com> <4b2f20b9a7bcca58fced690d20916efab55ad31a.1794020868.git.tianyi@cloudflare.com> <sashiko-outbox-203545@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Sun, Nov 08, 2026 at 03:35:12AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This problem wasn't introduced by this patch, but can hr + csum_start
> overflow the u16 skb->csum_start field in xsk_skb_metadata() [1]?

[ ... ]

> When a UMEM is registered with chunk_size equal to PAGE_SIZE on a 64KB
> page kernel (or with a large headroom reservation), desc->len can be up to
> 65536 and hr + csum_start can exceed U16_MAX while still passing the
> desc->len check.  Truncating the sum into skb->csum_start wraps it below
> skb_headroom(skb), making skb_checksum_start_offset() negative and
> triggering skb_dump() and WARN_ONCE() in skb_checksum_help() or passing a
> malformed skb to the driver in validate_xmit_skb().

This is a pre-existing issue, not introduced by this series.

Jason already planned to fix it [2][3], but it has been five months.

Jason, are you still planning to send the fix? If not, I can send it
to net.

[2] https://lore.kernel.org/all/CAL+tcoCp19F2rNxYL_LoGsY5MuBZ6cGKSZsj6D7kvQZcYp0wJg@mail.gmail.com/
[3] https://lore.kernel.org/all/CAL+tcoCgXG5MdPVzXavwMwk=jmPXgcB5aKpLK+TNXMVrsGmS9w@mail.gmail.com/
