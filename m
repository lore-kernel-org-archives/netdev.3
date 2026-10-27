Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101360;
	b=jEBbyWCdn30tpbNNTh/pZkIjROI2205TBz6fUMH9yMtNJhlkdUh/uXUGb/IZxZeU8J+x
	 if4twtrmEYfq7Qavq56YJOy1mL/hZpWS+UsEHt4kYQWT9rD/UtnFXvd7cWl8Ka7hA20LD
	 jFEVwW06O0FspVx8pys9306gl1KhJ4+QGOuZEZ9+U8gPJC7qHIm/a3u2reHb29Fuo5Vdj
	 XYCzehNkZa8H4rUWXNQZC+8nLCCxB4D2LeZfZJQFq3em2/Qb5J7wMvvri4prRhIipwmXh
	 HK/SZ69+p0ZYJYntPNft0SNFRSLbDw3iNrGigzNO4i2i538rTMKONTGqNdozLK0LsWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kIGxSMRs8lOS9jTEq5OXrekdNV6jhsXUHuQOcYMLGxs=;
	b=kCOXVx83+xjc9UiF7HzTQnN1hYYEzGoJs7zGExEKPgRe/bPyu0eBtgMhREvuh/scoBGD
	 VWV4/P4AOIA9BoCG8raWxyVmUzkgDG5TDegcfjqUxbFNBoqjJWcQcw749IwTp1rC3M/ol
	 2T9C1o+zuBQLllEuE3tkuVYd47yvNOEuVkXrFS87NYsf5qwLBFv3HZMZMEWesUhIVouu3
	 RaRh73v5xCcTfy6XlMWk+9OuMUPPDWTgS4pzdchXWBeZAV7XITrLOgYAWn9k+FltXyb/C
	 tu/tzo6C8hi0VuZZP8ZI4zKDCL2er8ikIGUrazNsttUk7MluL72SqLfnLwiIUtkJgEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b5IxZf3y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EF606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 081EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b5IxZf3y
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05b210703so1616380b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101359; cv=none;
        d=google.com; s=arc-20260327;
        b=sWpcWJftb/hoanoKuOjX/QXc/JeOiPCmqIFIIfSQvVd3gft1UFHzSwt5uNjXtwO/4O
         HBQ8fTzkwoyIilmQ+m41QLruKppEqZf/6rEGXragsbFejA+IYEFdDTWetkIQHOrAaJWV
         HGTyA4Ef3RBGF6b9c66yX54Xpy0SSJEDvKoLn9NVCiJABqmsWGR0obxFgWAjY5xU/xg0
         0Wk6v+Yc72t4+/rL9I3ip5Wq5JY1MbdGoQ2EUre6NV9ZbNH8nO5y3NHewtGeDRnUYG6R
         VaNv3RzE3oK+brM7/S/WysQM8qbbJLw/IQomrs9wYcgUaAu0xt6l0eRtAspV5oH69wYG
         0CyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kIGxSMRs8lOS9jTEq5OXrekdNV6jhsXUHuQOcYMLGxs=;
        fh=GZsm+tQkF08PEtTDoIOdbHXVRqcCkwX87RGbG7kzD8o=;
        b=MCAAfE+HVCxh/9XvfwpNjUnnFh74XwOZ9ULoyGnfoHm8ZGPVAe+KRCYEOfoXpAlEBn
         /oP8D230UoCWJb5jVp19F1yjwgKIb1YD0ycqxz2XLbJrAFqxPh6OfU906mzMYrnGg1u+
         Vt0FsHFtkj3uR0nXogLb/5VruyrxpFrxY5u8WQWO97bY2xJVrIvIN3rJa4sn7qeM9ANX
         mCJuITMEdm4w6SPe9oVoyStc9TlnPcA52hV4LuGHbOLzyclAnFPXvJjfWPejYh6mgE30
         OziVOWZeImqm12u7TnROXiorG/xhDwATMpsUiksi9cioyuqRYJTgC3b5kb0V/DTuhl+/
         0zUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793101359; x=1793706159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kIGxSMRs8lOS9jTEq5OXrekdNV6jhsXUHuQOcYMLGxs=;
        b=b5IxZf3ygbCMgl2a3I4IuUWfHb8YDB5W5CFXm9rHbISpo/YG/8T3+fl7GC6vf0Y9uE
         U4ekaw61S0lzJO6yAXYsMt+SpepYPQt91pCIrMJe/q8PWEEwXivKHOsUmkncz/3/aT6k
         Jvvf5T2PLDxwEz98OEREYlwpaOFZa1pBIzLGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101359; x=1793706159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIGxSMRs8lOS9jTEq5OXrekdNV6jhsXUHuQOcYMLGxs=;
        b=LDE38/Khvy1MXs7e1Ut36GoiJPlRgKWb/6NJLl6a9yjnt7qg+u3P4q5ZKvPJvbGzPd
         xnFbJKgFpkQVxwC+qK8sl7OMKz7rCD4PaavK3gDN3ywYm3zEgqcWR275ay0ehnzNGJle
         xG/rOcorHZbTy6ZvWcuLCgBePdZnWYNstAlLQYqq2JA+UjZ5sT+IKWOOobyPuUoiiuVx
         eaLLNOKjc1sxHsuH9oM5syXqmimj6W+Rq/t+9P+2BbupSm9d7pbbKmz1R7WhJyqWOVRR
         jGPw4oslqERBRzZpopBQGapGRBNPsg51edEmTUjpdWy8O7IOGGiBMB7cLv4OneK8P/3G
         kDMw==
X-Forwarded-Encrypted: i=1; AKwUvByXsGzZvbEvoPoUYdXojPVuJpkSuI1I7nNLZJRzgoike84wmpxCYEv1t76ZJlD8MvryTyY1iFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbbRMNfTYmiogNuRPuscbjLIpUE6YQVHAYV+EXMAYjRkrsrVXd
	DdUmCo/hDUNOFsRWR6XAJLHArH2UFSkkEMAX9j0E0mKhA2kUUPlCqgLVRYOIN7xSMwfQXHd4h3S
	2Zacy69tM3mthOhNWt4JThausS7093DZ6kvZ4+Opu
X-Gm-Gg: AYBFou2ZaCDJ7VOxe0q7X+nQQWg0gh2xuRss1jSaMW4g/XznutN4ay5qC16Bmyjb1Rg
	hxCYFBcray9eDUGL9F2CMjzWys7/gt6mucQwk0VLYOdRuikgNyCAMCq3UUMZcrmw+ewpTHAmBi2
	48dHfcbLSV9z/v22snoKg/UBLCz+1unzSHoDcYjNqrTg4f4F7xBt9CMPQrH2Dt5Kj9eoHiRwIvJ
	5z9HQzhA+zu0WXqPOY4HH4t3hL4no/CaoPUnzmQzk6cJzaQ1VBadorRbgxqvDvixZrfZa9SAIzc
	7+IEfiHlFCjEa2NdvMUa/VZUASGd6e4dHoItDGy85p4+4PjU/X6NdD6yfMkcJFfE8Z9Avr81jm4
	jS0Hi59uLDIzzhmYpIcEnuonwuk4sOHgfRwZsPUH+1HMiFb05zOq2HMgmm7dlCsfsqJJIVDcHZV
	C+48FuB0xkyUO0PVg=
X-Received: by 2002:a05:6a00:1789:b0:8a0:3ed7:939b with SMTP id
 d2e1a72fcca58-8a3689a95d9mr7726635b3a.29.1793101359172; Tue, 27 Oct 2026
 04:42:39 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
 <179286304080.3134.13197757888201893950@kernel.org> <d03b1d1d-b7c1-434e-afde-8e2cab55e706@redhat.com>
In-Reply-To: <d03b1d1d-b7c1-434e-afde-8e2cab55e706@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 07:42:25 -0400
X-Gm-Features: AclHuK-4-NRILxSRpIeFP7FE4sa4Syr7I8ZfmKrUkTMykRT2uJUhR-jY9OGC8bE
Message-ID: <CAM0EoM=MGKpFjMQJFUPAehYNdqe0pgSf-A9saK6N6BCnpyibzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
	victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:48=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/24/26 19:30, netdev-bot+sashiko@kernel.org wrote:
> >> @@ -1784,12 +1811,49 @@ static s32 cake_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
> >>                                       QDISC_DROP_OVERLIMIT);
> >>      }
> >>
> >> -    /* choose flow to insert into */
> >> +    /* Select the tin and extract the keys before segmenting:
> >> +     * skb_gso_segment() rewrites encapsulated headers, which
> >> +     * changes the keys.
> >> +     */
> >>      b =3D cake_select_tin(sch, skb);
> >> -    idx =3D cake_hash(b, skb, q->config->flow_mode, flow_override,
> >> -                    host_override) + 1;
> >> +    cake_hash_keys(skb, flow_mode, flow_override, host_override, &key=
s);
> >> +
> >> +    if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> >> +            netdev_features_t features =3D netif_skb_features(skb);
> >> +            struct sk_buff *nskb, *seg;
> >> +
> >> +            segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> >> +            if (IS_ERR_OR_NULL(segs))
> >> +                    return qdisc_drop(skb, sch, to_free);
> >
> > [Severity: Medium]
> > Can this qdisc_drop() report a bogus drop reason for the original skb?
>
> I'm sorry forcing another iteration, but this looks real, and should be
> easily fixable.

No worries - I already have v9 waiting for net-next to open. Fix looks like=
:
---
segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
if (IS_ERR_OR_NULL(segs))
       return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_GENERIC);
----

cheers,
jamal

> Thanks,
>
> Paolo
>
