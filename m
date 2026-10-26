Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024843;
	b=KiEg7twXdDY2X52K20UB4DQhpZhFR3JJNQTfhiumGiLbv33U03m/IXx8SXVRmimPPpcw
	 8fvaSJSG5BwyVgdW+w2+RR36JNiKMaiAQk2+0xPGoNc7LW2ISL5VippTYJSXquT0aTN10
	 S1SJhKfSId+4EFqWqSiRYA11EU6kNPuJCxN3eBWeJecylelXtpkJZNRyjeNMk9wbvb1u1
	 JsqPI3XlL3Y0tpawJz4siEG89MYFA/uPfEAc/1a+6d9coyIoOtujhTTBKVvrsVq47OYuO
	 t5ZvGOjiPRvMpP5q/SyYA+VIGOZbvdZ3NEoSaxS/8YpCEcO9uWWJsUJHDc2T/HnNK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
	b=UnxmhlzZHJ4Y8QDkaSeYqFDTEYESxhjDZLyCqaAAUL2Q3vul7ZLemdgdkruduaZmmuwC
	 clEeq9BxEK0t+LnlQ8T5BC9+VYWAIf+m6NSBmbqqO22Tx0CkDsHZGaAbgM/e0Zghqvqy2
	 OQU3uaVQnTBJLUQCDkGfkMo04O+Sbhl1XDryWUG/eleqeBBiQjGhdTDhJ5rC8RkiDR4zL
	 CsFRI1ifhRt1lhgEGJgEQDZoUw9qX00IiSNbaURm5QU/7bZZBv4oz3KL4dlldjLeMkaHU
	 aeKhUh27qdqO8rytzcqcF77FvN8gDEA2JCLLcdhItbRjCqLTd4LagzyFR6LkF1zzzBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0999606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0999606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so12380495ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024842; x=1793629642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=XhlxvgU1GrMaPNJspEjfRmGarJy5LJYRRhTg1Hq/82/Zw43IZLmp1XR/SVpCsCs05U
         BoGs9OSrt8nbSJESb3b6dLlIhykpaBy28HH8+8wK9xG+vb2OSN/fiGslwFxR/GKZEZ8z
         m19YStf2V0YttCwB+h1Ew2WhtANJutgxfoX0HLvXOn6juDf2bZROzyGtjQ4vvRzF+7XO
         pm4XP+AZgP36L+2ig5rDwJ0P1QJdE8Q0aVP36TEb1uirPl3ZKJ1WrDZOhzgckhWRNmIn
         GkkvbnCuyiz50A6qCwqJCiz9XxLWrqnGx7fqHQfrfdSw5/PXSL0VMpNbQxZQedFvav1G
         +gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024842; x=1793629642;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=eThCOgFIDsMbYQ3AQWGIjvf/cg0H71sKt2zLScz8EjjyAOTo5+/6RHjQJ5oJhJfGkf
         1nO3o3qTbKM4apLvAWGwwNqi7lHEDSWN78K+6OSdZbJFPpdiL/A8/2eqeU2md/vn/zMp
         nS04eHP5sdI+uzcf4ZJ8tPFF/pRJhjigONH26YtylJrHqURF3J4XXCGy1mEgH1lolYTb
         3NxgAwHhRb/NfPPHFdytqRPnbB/87QbP1c0TKOukZygxO2KML5hw7eRMQMfa3LgtGEZo
         eEQnkXDLPaft02pEbOt2ClEX8HB6KpHeRWeo+E9MFWq6E5wu3lyLsbOBylqiNNcMYEDG
         XNiQ==
X-Forwarded-Encrypted: i=1; AKwUvBznfCg8vZLvZFGKWI9zs+09nM+99WZIj2tZgQAtDJZ1Goubtvttqz2YNO1gSaVdIWt1EwRyC5Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQwKf8cjEueVE9Lco+4CJLsxawZcRKjjB4dlkXqrJelEZK8eF7
	fYVsevARcFy+3e9o4mk3+DjPs3q+jJVkTITzbgCkxRLGCBJH7ncQUYjr
X-Gm-Gg: AYBFou3g8kDdh+grR15pUEhuR0uAk7SITKGfUymwgCIylzLj+PTLQyQh94WCHTWh8sH
	pmj4vmnkjmh+/3toTH/o9Klcmo+B8qAw1nPXum1lcFZ9wysnJzPK6msexf41sKI4CYGbH1bu/ai
	VXClH0fZ7yUr4CLoGFyWkbdT22cS/FDsLSefKgSYMmoisw8tz7G1o542dx3VAncU1el455qxZVM
	tCtUPs9QUu4OgmOTQQiE84VWs6UCJv8Tb9xyzzycJ0ZNlPI0VdAco6pPNvJPhvfutUY2v+lTLZC
	iMkp9Owck5d2wGA/J++pnXKassy7gKgRFtF52rJ2cPn6o89J0OOD4jaXBGgvDDolO6DmWc9qMqX
	VaBVnA0Sn3fdIu3yjU/s0JHfWVeYZFghn0geYAzC985o+6MUYNh1PsLuRCUDjU8fqzOZTG9+mHV
	OJtkHE9rkePgusjGZI2lhwadrrY9+c7PC3sUaFhTi9HC0nkkkdozMaoBdwQZ9NtLgmAR2m0PB4r
	MvfAqWxgQ4aAvGgexlcnmMTz7+s8ACwNUCgqAEhajlnPoe/QvUvhS3qt4iYC3wgfBxbJmlGdD5z
	ZdCoR3gbUrH1BfpY
X-Received: by 2002:a17:902:f68d:b0:2e9:a090:dd80 with SMTP id d9443c01a7336-2ea9c69710dmr55298395ad.22.1793024842080;
        Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121725sm17638495ad.14.2026.10.26.07.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:27:20 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Mon, 26 Oct 2026 22:27:05 +0800
Message-Id: <20261026142705.4564-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <at82NLzM7g8HGgum@boxer>
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com> <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
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

Hi Maciej,

Thanks for the review.

Yes. xsk_skb_metadata() is only called for the first descriptor when
skb is NULL; continuation fragments do not call it. So
skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
the checksum.

I'll preserve unlikely() around pool->tx_sw_csum like this:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return skb_checksum_help(skb);

            return 0;
    }

For the drop path: xsk_drop_skb() increments tx_invalid_descs and
consumes the skb; sendto() returns the error from skb_checksum_help().
Since the descriptors are already consumed, retrying is not useful. The
current metadata validation makes the malformed-packet path effectively
unreachable, so this is a defensive drop.

I verified the propagation in a local QEMU test kernel. For the test
only, I temporarily changed xsk_skb_sw_csum() to:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return -EINVAL;

            return 0;
    }

and ran test_xdp_metadata. It failed at the first generate_packet()
sendto:

    generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
    Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
    TEST_RC=1

The normal kernel still passes. The test harness does not print errno,
so I can only state that sendto() returned -1; the injected error was
-EINVAL. I restored the source after the test.

Magnus suggested a distinct counter for malformed packets. I agree that
would be more precise than tx_invalid_descs, but I'd prefer to do that
in a separate patch instead of extending the UAPI in this stable fix.

I'll address the remaining feedback and send v3 as a new thread.

Thanks,
Rongzheng
