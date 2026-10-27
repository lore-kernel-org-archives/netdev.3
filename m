Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066474;
	b=J3kZoIrYO8D7rh8+rpGCQ2PPoP5TawEWJceT9YCnqKj/A4kiq8SaT1F/8UUhfB4Vn2S5
	 3ox9V5zLVFo4xPCRjL0nLvqSX5JFAjtM9lG8ItRfkRtuI2WGi57y6tctVyNzSUoOn2+6k
	 /j0CmyaNTC6wx0wq0V30YVIYL+P8cR3jDuk2ivaHyddSyK2lcbr4pzABmEaXcf+7I4nn5
	 WAQOlNKIv1q67xNHx4eVYWMId+GkrpkICT/0nji9bO41U7lsTm9DPB1LVg3OD3dxFQYP9
	 E8Op/V3jAgerJl2dVb/aPgYYL+Jc2SkSCHtJMAV/FbtqBlVZd+W+nV0ZDmzg1Ij7i1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ILpHxFRhbHQUqgfLQdu6bP24Wd5BWfFHmPEKysq9O0A=;
	b=rxY8B3atHvu+6r8E0tQ7wXGHGt0qoO5Cw2pm0PzeQkrqrP2FFyEKzBLTpQOqasn69WyL
	 JY446V81aG4/VWl34robyYhv3omSMjHcktwDh8eaf51owrLY9OXpFpGxUrmZCFtO5t7qC
	 RGzqiOSr5M5tt2Onil1eWPO31uBzZp+W3N5V4baKH/ViTWIdflFIFKsHUbMy8zHYs2zy6
	 0lke69xKHVFpdU2aylisratfynxUcGbgRD075OZpvld8m7t6HgpLSihEcF/t/CWyGuuxI
	 8+iPE3ef7foArRpNxH1goaZoloCPO+nPEXGmKiFJRxV4W58o9d7SsHspTUt5jNuuHBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ozXcZo2m;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFD606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DFD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ozXcZo2m
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso5092103b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793066473; x=1793671273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILpHxFRhbHQUqgfLQdu6bP24Wd5BWfFHmPEKysq9O0A=;
        b=ozXcZo2m+3uCrn1xmYp0nUqxjRbqTdfUnuXy6B6CgN6CfqwnQza8kt5Z1uVCskmsJE
         xV0hGYtJw4f3wU7xxonDfd0FlUcUbfDOGM69m2N5Z+bPuGz03YSeH5RVMfaJs/bFInSs
         yAaOc+Gw54GroWEkeFmxPcDwNvyttJhcnzoOeZoJIelg1MKwi6fq71ZleT3sZpdymS+c
         x5EkMPn3nl0bRCBu9VYY1OEaqDqmDVqvjbCZbTmdSqAgDzH0z1IkFMyF45mV9AZy0997
         Mz8qcrJgXQSebLwgC4gu/FBPDSkEDRSOlY5kr7r4KG0Nzt5F5n9sX5V1HA55RDYxO4SG
         Trag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793066473; x=1793671273;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILpHxFRhbHQUqgfLQdu6bP24Wd5BWfFHmPEKysq9O0A=;
        b=JtiqAttK34oZP+aGMiFoiPRsNn0Z7gSnmu/JgsLJJJjjr8gzr0tt/mPzei6iPszN64
         wPQafY5S3g3Igqs9rIyMr7BEiczF31qj4rlLO2PYQTTdsg895uDSHZ/8Da9vcqzo+7wq
         qVacT4miS8OtNm+03jzLCWR2UkXkOl4W2RssW457nEfwr8VhXd/HNRgkrhvWf2RXc+GS
         POeDwuZHtr1X0DjHsNytG6aRmz4kkNRr86jLLANv8UaQQxEri/tLfoSYAgypoJjfLB6U
         zDsDUQ1voytTKNQL5RX4Fx/daqMjQgDRovib180WJvSkCLn3vRcqN3WSQtnj64Yck7XS
         JPTg==
X-Gm-Message-State: AFq9FYIgbmzHiEQJhqL3+Va/rwzywnI8GFpL9c6UqvjkftSx9Q+gJ3eZ
	IVWmkXSnZRKXnGjn6frWaEkYRXdfDs2VroKOin34h3/jrKMQFvUHqoht5pOZWLGRykapTiCfHJZ
	jzx5/RA==
X-Received: from pfnu20.prod.google.com ([2002:aa7:8494:0:b0:89d:4e13:90d1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4196:b0:899:74d0:8a58
 with SMTP id d2e1a72fcca58-8a369c1f7bdmr6652440b3a.55.1793066472760; Mon, 26
 Oct 2026 19:01:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:01:12 +0000
In-Reply-To: <20261026095208.58504-1-yzwlhm@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026095208.58504-1-yzwlhm@gmail.com>
Message-ID: <auAFN8CJvmXdO0Zu@google.com>
Subject: Re: [PATCH net v2] tcp: Fix fastreuse cache initialization on first bind
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhewei Yuan <yzwlhm@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, 26 Oct 2026 09:52:07 +0000, Zhewei Yuan wrote:
> inet_csk_update_fastreuse() initializes the reuse caches only when
> tb->bhash2 is empty, but both inet_csk_get_port() and
> __inet_inherit_port() link tb2 before calling it, so the first-bind
> branch is never taken.
> 
> As a result, SO_REUSEADDR binds never get fastreuse=1 and keep
> scanning existing owners, and SO_REUSEPORT starts in STRICT instead
> of ANY.
> 
> Initialize the caches when tb2 is the only entry in tb->bhash2 and has
> no owners. Timewait sockets are also linked on tb2->owners, so this is
> equivalent to the old hlist_empty(&tb->owners) test.
> 
> Found by manual code inspection and confirmed with GDB. Binding 16000
> SO_REUSEADDR sockets to one address/port in a KVM guest takes 4.18 s
> before and 19.4 ms after this patch. Existing bind/reuse selftests
> pass. Analysis and testing were assisted by an AI tool (Codex).
> 
> Fixes: 8002d44fe84d ("tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).")
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>

Good catch, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
