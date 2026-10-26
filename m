Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025128;
	b=oaonnJ1hc6eUJyOzdlLr+cekjKli1RG5yuGDVPX7axJA5po8hhERoqtoKAo2tGAABtMY
	 2s+Hv5FcVkj1vo92EvK50o6FWTwQIeBQ0AqinYjanYuF1gioom1k4eh999kY6nHS2lWzi
	 P3PwiFBINE7Kdk9o9x/m5T0Z9L9n2MqxZHCc+4f83xlCA46mAyKRwvTWEOFiquFWNk0RH
	 /QEjX1BH+8sBAs8MmWxWSVaRnYaWntiVDmFKopmGKa60GiCGVOn8/Ihg3Bl13lbaplHzd
	 +TQhNYg7Rkt4riry5HZYE28DEnXHOY6ucLyxXvpRubG1kGHomBFbzfOWjmKTsHh4F6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
	b=aP33dqpceXVY8h/TAAyRdsWec5/7/T+Bw37cmLTB8lKBVd/zCiCUas59H6E7/M2/aHn2
	 jvGv3Djcks871L99gTkjt0okHEEkQI/s2TS3/kaV7NNNE13lCRJW+5cxIppE8mqhYv5oH
	 HlZ43Tp0ZT/4mDuN8dlwd/djWO0Hf7aZLdpU7juIPkHbWDegzGFaurL9FwilYxITh0keb
	 RjuANJ/qSNqDP+KvcYz8Jx7w4GMyUYH2i8VLJAcT97WiWWbtBppocNnURRCE84j5Z5Aik
	 4pylesSsBIGdOLlRO/ewFcYSy3wCINLk4+ZeG648rGvGaNTa58IDfvgn8XIKCfCic2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B1606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E46B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1585017a12.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025127; cv=none;
        d=google.com; s=arc-20260327;
        b=TmRmxNuNWzIlO5/FXTrfB6ViVdAAS5pnW21v8Epi552e2OfWLARCJIF8WdgHP0caYs
         5ExjeKd3tv1BQGAx0jLXCxvZhXkrbeE/h3k+PYZd+50AUFJ3ieJl7J69hEmaLoCnLCWx
         fCJNjrS0NM4rPHPuji7V8nM58pduymzC65gQXpEqRylb6RyYw/nTd/1Kk6odRcZ/iwRw
         aREKH1KpsNXiljXQcHeB3OEHHyd0bgrLWM9RDEDJ1wyXoflr+JRtiegOyZdfptSknTtu
         WYp1R9BqIeZhOYFlcRn2r4Xk7ta3dm/6EpcBUAJv5Wl+dWvdkA4ra6ipH/ORcHytCDHq
         b1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        fh=bQJPt53OAh/loudl63KpS8vvvspIiPKhY16rvqZzPFQ=;
        b=VR6TV9q+kw9AyJ13874fshe3w2wH+fGOPIzjGdO+2Wy0CWFvgVEHtNYa2jERJfV/Gq
         27+KBj6CWaAXkjJmnsjkLbtU2A1xUkSq2Kh3TJocSMQ2gl4YfEw4T2/yqfEJz1tUPaBt
         +5bB3L+ZSjd5QEAa2D0ImeFZQ0bqGnDz50IzE4aHI+O5nrx5xB53tfeQP8MDJO9wxApR
         KxXijXH/XUR+p9eZeapTLIPdDge2qFP2BNLT7N2SbM7+hH6kDzZtfkL/1y0ieKe/WJDq
         Btzr33JWNV3kgmPA2zxLY/OciqbhlegDFlkimLOkcbtfHs0wKKH0EBZiQjrpd7L13iS1
         5udw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025127; x=1793629927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=fvFl2JqYiK++L9Zn0vfo8qjsAtt8ULXmy4jRMsZWyhMJnRIQKO5Rgi7jeprM6MVIy4
         /gpHjU/ILM64eE/DWyLU9CpYZROq10UOYB88q2H+bNRGWt/4itLRlgb7IHZmz254KEUJ
         uyBnRxmPFfHjF2N0bUVo2B5byPKdjvv7n7yrws+I97JBI3bkCFzeSNxO5vtbSRwE8MiE
         0HiZelCG6u9CtDzypVlb7C/Us/VsX4+woXWZYwOacQWphQIEBAJvEiYJ4K0eVNFK4BwU
         YE9lJnKghkc2gPV7RauLtKpoQWBEQz+XeynSq1pXEe+p1iupFPzxs9UqunTA7XvO5dcC
         ZFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025127; x=1793629927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=2S0vDJaoE1yljaKF0fKCtJthmtxmIuNtqyQ9YbjpuvZx245iKDJjstNfaSwK/yfV8K
         CGUugsPwxrJrN3ercSreXjkcH97CELyuwOe1Yxr8H2BB5n01IMj3aGfkWtAPnJ+RmW62
         YQMrWjFCA9avU0MlSsQdwTvMMvz6AnEcFkKHZ47MaCc4N2UiHE2BnbeQfJh8apqOeZ3X
         rJA5s/gG6ka22Q4gB8iOUKIcHShyRUWW85Fj5kgPirBZJThpvJoLAgIwRbc4p7anW4dz
         QzS3NWUojgNbleI5R1Hf7xTkGy5eL+0NyPt4XtFM5lIPj4SMsU+HekLCqQZRWkVEGF3Q
         MuWA==
X-Forwarded-Encrypted: i=1; AKwUvBxLOhNG7izKE0RKMRHRFPPHPCSw7kn2K7FJaxNUvmmjVbpgjmi6kVZqRAv1Hf39+FUZwOfwkD4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPCvepTfQ1c94i4JzmVzIxPG5rXG8Sbeipbg8p6jP0iBidLRSM
	ytXKexhoukBIeOeGVwI2SQbRfZGs/OK/phCMB1+b7vNH258M4HuwV+DSpKXa52wNLTQiMJr4W1j
	26LrW7uxr5TOTgMTsoWKIW8ENXVzbmLU=
X-Gm-Gg: AYBFou0Q1qBxhyIP/lp0+De6Vvk8RllVRf8Y09Oz+EEiS3oyoQ4PNyMFu4hCVmdU1Ov
	RAf6De4NtqNkql+sTvUDrv8bm63v5S94KsdTtCRoEck692482JCMqwp0nek2XKBred9j4sHzTt4
	9xRHZwpWigswf3Y3SwThE9PFbrNknmIHGc4F8FrJj29RFDuFZ/VBJvQ7AP8dt+14p6vXAX5sc8e
	KEkuD7qgO+6FF4frTflDavA6pW2zcdSif/u+ojPmhbfOcwqskOCEAT6BfJRWkFgnFva4R33wIxj
	kQkEtxzkw2+8eY0eFySYxUiiOJpnc8pEY5Gw4oFyyDRkymwNKvcOClAnkkmYsw5pNydxTn46Le+
	/Xlm7yz1sJ9tU7IiribjLtNVUSyK/If/nuhc7eHs=
X-Received: by 2002:a17:90b:5644:b0:3ab:d45c:59da with SMTP id
 98e67ed59e1d1-3adeafd21a8mr5767380a91.40.1793025126904; Mon, 26 Oct 2026
 07:32:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer> <20261026142705.4564-1-testwrzwrz@gmail.com>
In-Reply-To: <20261026142705.4564-1-testwrzwrz@gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 16:31:54 +0200
X-Gm-Features: AclHuK89CEpPcFuQ9Zkf80L7rIP62d6arcQxEpIyB7BJW5pfRLgwLFs5gMXbiL8
Message-ID: <CAJ8uoz0XZg8K2g3eBXOajV3TsA-1Sz3D6t-G2+BYw2YX7A4K=Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 16:30, Rongzheng Wang <testwrzwrz@gmail.com> wrote:
>
> Hi Maciej,
>
> Thanks for the review.
>
> Yes. xsk_skb_metadata() is only called for the first descriptor when
> skb is NULL; continuation fragments do not call it. So
> skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
> the checksum.
>
> I'll preserve unlikely() around pool->tx_sw_csum like this:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return skb_checksum_help(skb);
>
>             return 0;
>     }
>
> For the drop path: xsk_drop_skb() increments tx_invalid_descs and
> consumes the skb; sendto() returns the error from skb_checksum_help().
> Since the descriptors are already consumed, retrying is not useful. The
> current metadata validation makes the malformed-packet path effectively
> unreachable, so this is a defensive drop.
>
> I verified the propagation in a local QEMU test kernel. For the test
> only, I temporarily changed xsk_skb_sw_csum() to:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return -EINVAL;
>
>             return 0;
>     }
>
> and ran test_xdp_metadata. It failed at the first generate_packet()
> sendto:
>
>     generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
>     Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
>     TEST_RC=1
>
> The normal kernel still passes. The test harness does not print errno,
> so I can only state that sendto() returned -1; the injected error was
> -EINVAL. I restored the source after the test.
>
> Magnus suggested a distinct counter for malformed packets. I agree that
> would be more precise than tx_invalid_descs, but I'd prefer to do that
> in a separate patch instead of extending the UAPI in this stable fix.

Correct. If we decide to do anything like that, it should be a
separate patch for net-next at some later point in time.

Thanks: Magnus

> I'll address the remaining feedback and send v3 as a new thread.
>
> Thanks,
> Rongzheng
>
