Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811144;
	b=qDAwXeGq0M8LnoGj/3UgoOQeIRCLf2REBmT6JETxbxUl0JgBrxQlP1NzH+4/0EJePJvB
	 HvwtWGz8G4opZrcH2mgqDzy0dQOYu/w4kNi7Wj/UwQUpw1D9c1yqhE6qeWGK2bZ6Xejcv
	 1QR80HJgZqv0KqLeSRBxM3cGagkSiDB1okSyEog5uiN5t/80Q1yPBtPYy2Pb0Ffj/HpFc
	 LjO1QXI1uFNnuyly2iw4QGF224W6LfmR4z4TOM4tq4yuT8b2CTgQ2MEzKYUh4sRi5cCHy
	 e0AgpoTG5dPMCv4cIP8Kv5fiid4t3wYFCAYqSQwMAMbH88AEpXWQ8fExFao8y9i3YOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
	b=vfutptBcigkTVSo2Vz0TnfZYKXI6lz3hu2vKJ5kysdhhR7RWCE7K2xZzgH8Mmf325wVE
	 7ZB43TucHP5MGkdU+b4XBU4CcL6qM9AkLz79MG3vwDaFxEYqHcArhZdbxIw0BAqN20IzW
	 Kok/bdR53+kTzeRArLwYuwUdm+pfevgEk+GjH5twg22uizY8rC3aK/cCwEsNCHfzWvBGR
	 FVk1m2wmTrXHzMAFNJeO8HIQ+WlhUo98scr3bQxXRGK33djtXHXCnZPMwFiVQmkT1qPwK
	 SIotmWe3ukHqX6gsRTjJqEUptLKEWJaz2BPyDEberYPPCwL0KBnpRHU+y2H7/o7Q11Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvAlMHA9;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0E606D81F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D0E606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvAlMHA9
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso397167a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811144; x=1794415944; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
        b=kvAlMHA9YpLVp95q/S6+rfIKB0rxBFrfLZZgcxl9tkXcKRkQztUBTwOrAwv1bYnEZh
         qDB1aza7sd7sCkFjHBgbTr5ONi7xasnnWnCMi3ZChAbqAIz43AtJgQH3k5eE7vHhu81s
         a/gxOxiNC2yAXPRow31/dN3IIgNd3T99tw940mkHjn4kRm7FfmfUBHFenV0rEbEQyWQL
         FhiKhaB64QHMEzInvtZs2J9qRFs2LQzbdCgHc3iKCCKThQI3QIo4EmxmOra02M2gpiiQ
         rfTN9Xgt5EltN0laDIAcJhL3bE61iNfw35jRRqPFxcu2WlCzSTaKzJ7BnZOYk1NW8jyC
         2NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811144; x=1794415944;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
        b=x/eFAmLbgn6idJOmlibVZNGnS5Ez4YckoLMItDK3tv9L/Ps2GiiP72b3LmbMMkBvAi
         qfsLzFvGwXE1NwiTL2+UL/F3kmEX0UFXl7WD8HxOvd7GSvbop4BZCbLfvXs6D3j0gqPG
         0ZBwpMCkIKOBETacqhnDJAnm+D5IJK7L46Jta5hDPcJCB7yRn7GT04ggQ69MemkFjpV9
         MRvbgRkMiOiDqcFJaVNt3tZRVlWVV6w1zuOlkrJPp/0HIS94Nyd2lLveIeh/24xHyb7+
         UqYgNvJtAM2H8s4Ix49jaSFy/LQYHHS0T6H5sAHvAnbgBKjHCfTB02V1SpsJcRvU85oW
         bwIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm63fSxLq9btjMB9EZj5q1ROIBKisl1kEeHwcGouOJT4t3rYc2yd+Ucjcd+6NbR/kFVosleys=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wu2PiQP2f0gbUAhI3/jl//SaxbrAWG3rAflIjeYwwt9xa9n4O
	ZYwyqbogfqUZ4TSK+73jCZHuHa8aLvJSZtAm2hudjgtEPFRtgImMokS6
X-Gm-Gg: AYBFou3UOTgqf3VdPKZYoeGiqv/QpqChpD0Kr3urKBczGHO7EAFyqduAmWBLLAbhh0a
	whdRifgHk+h33jNFXfie7b0bsqjnX/kvISxQ+2QlRN8itRIglCSkjGUacNcCws67KGgchtNdICf
	Ccd3jnUPKbOj9bsanavMBWySjjI2CJn18QZtjqkFbAgQeYhneIqoKrS8mTCA4UlVI6J1GtTtJ4K
	B2uSToFr7wegONoE5Hu/8O3YyBq28Hy7iThFHA4n4Z+8eYi34JditClraNeDN8I2nG0SdoB2hSC
	6G0G6eAMUBJLW+TrOW2jyXnxVIUjza0oOnyjP31LZjuZS9AWqEPJrJ0M3sUfjKXpflrNZeED7zW
	e6/OTm5vQV1D91BRvmqoLOlf+QmMw6/f+nUTLuiPEBKMZeePRI8yRmSn96b4kJRCvz6tD7vw+UV
	1K0VxOlBs3thIiDXjhovHvfMx530o8jvkB/wzW7nUhGJxGj49ZMuOjbRgyUs/SD3TCeRruP5w4G
	mudHEuPIFXxni6ok4ZMGzheGDMG7VslqK9lDFPR8SzkgLsCdTsF2aR9y0NOj4Q6uF3HNzc6Wi+a
	lZudbjxarSzBQhvJD5J2bKtzwVeUcJ9Ar60awPkcYKRJliLrEf9dxhKCffdDBkjyZivzzhFAzNv
	cfhotJpmWiRzYvMiWIht2km0DccUo8yyW8g==
X-Received: by 2002:a17:90a:fc4d:b0:3b0:ac2c:1619 with SMTP id 98e67ed59e1d1-3b0ac2c19c0mr685175a91.39.1793811143452;
        Wed, 04 Nov 2026 08:52:23 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445a7f6sm4685568a91.6.2026.11.04.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:52:22 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 16:52:22 +0000
Message-Id: <DMMKZAEHX53I.49LHFPRSGLX4@gmail.com>
Cc: <bpf@vger.kernel.org>, "network dev" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paolo Abeni" <pabeni@redhat.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
 <sashiko-outbox-194018@kernel.org> <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
 <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>
In-Reply-To: <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>

On Wed Nov 4, 2026 at 8:41 AM UTC, Paolo Abeni wrote:
> On 11/2/26 23:46, Alexei Starovoitov wrote:
>> On Mon, Nov 02, 2026 at 11:44 AM sashiko-bot@kernel.org <sashiko-bot@ker=
nel.org> wrote:
>>>> +		/* A header in front of skb->data gives a negative offset. */
>>>> +		if ((int)hdr_len < 0 ||
>>>> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>>>>   			return SKB_DROP_REASON_SKB_BAD_GSO;
>>>
>>> [Severity: High]
>>> Should the (int)hdr_len < 0 check be placed immediately after hdr_len i=
s
>>> computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 bran=
ch?
>>=20
>> No. It's already explained in the commit log.
>>=20
>>> When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
>>> unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
>>> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
>>> include/linux/skbuff.h:pskb_may_pull_reason() before returning
>>> SKB_DROP_REASON_SKB_BAD_GSO.
>>=20
>> Not a bug. That's CONFIG_DEBUG_NET only and the warn is right:
>> the header is stale.
>>=20
>>> Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
>>> enetc_tso_hdr_csum()) before the start of the header buffer when
>>> skb_transport_offset(skb) < -4?
>>=20
>> No. The driver doesn't see this offset.
>>=20
>>> Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
>>> SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the e=
nd
>>> of qdisc_pkt_len_segs_init():
>>>
>>> When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_l=
en
>>> underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
>>> QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeu=
e()
>>> and ets_dequeue() to spin in their deficit-refill loops?
>>=20
>> No.
>
> FTR the nipa sashiko instance dismissed the above concerns autonomously:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101194433.263711=
3-1-alexei.starovoitov@gmail.com
>
> you can reasonably safely refer only to such instance when submitting
> patches to net/net-next.

Nice. I'll borrow your mechanism.

