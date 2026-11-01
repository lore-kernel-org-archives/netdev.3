Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793570905;
	b=UwyTDpKZu232hvOyiSchQ90f8ugpFSlD4690fucAeWCj5GF8CGzzAJklDTX44KqyPV72
	 zvMBj6SG0jRIq7/DiQyrNUflZKXyXEnR1MW2o6v0O/sEW1h/c/cC615N3Bsv2tYcisWEZ
	 IpDZUhEIqFfVtvO898c234IPY0fXPQVCtu47IW9pXrhvkqT1Mzdh5MOSkzJUb0At8Iosu
	 SP0e3O5H/SIn7LGtK6svp5LjOOLc1RGa8fNHTmAfyHBIHeZgbuJDR3Pv9K7C5XOGSFPQS
	 kQ7bI+DxM9ZL4JiF94eJ5JV6quyI38BSh2iJLDIqjVdBPQADK9qi/lxyt7XgRhFvxGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
	b=peRMOrkdSZ//bkJ2rUsqt5pkA2jL8yZJT/dtiFoef5su9q64Aw4/K9DV4fZc/uIuN1op
	 j9AOAUwM3I4+KeyIvxa6VkO1+tqDS7MlOh7v1YM86xiWCmtrpqZmcDFMBysggpeDJ1Vz6
	 067i8GMt0TPShacVrQkvivIbDmaS/SRs2d6DULlD4e9z1b8BgFvFT+rHQWDR677LfVzB4
	 6W+bMSNRDqlslKwTBqI1WP3rvPmIFAhMmvuVrcFTx7gFucg/ClyUfHAte8aegIW1TafA3
	 gwOWB1hKRPuzvcHEHbb8YVDhCapDC4pyimnmm5auiZkPLmEz4OGj2RCLX97IcuHVEOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Edoun3lc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C66606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C66606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Edoun3lc
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a60f90a924so724272b3a.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 14:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793570904; cv=none;
        d=google.com; s=arc-20260327;
        b=QuGyLbydspe2l5mYgegmtIFoeR+ZRx3sNc8m64W6gCb3KkxqAHJSz/Z1QHh5G/qoWo
         zsx8lIbpiIB1vB2AsnUKcfbSZsVmtTTmS2X1yMwwOl956dT1+qmGYbtKsYbmlqtszHJ0
         X8doDKNM+DvH3/AsgiwYxQXcPhoIChEqlwb+MhJmbCaOl0e3+4wpqDCeXcV8dEEWMiVS
         lWiGnWMY0nNrnEvIAGQGlLpxKQBTsSW0aMVX48okEoV16OYGvFvSsb0ol3nfLFg9R9Zh
         XZYCM8leELyQiPTZTFuxZN4iM0CRzIX5pYDOUeXzs2tTd86N6RpZvrmyig4qEOEaCROu
         r+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        fh=Wb9DVDULmpc6j8VpUw/87dSUm8bUBKa2Tfv3D2tp0ZI=;
        b=et9rYt3EkoGTOsnfHMLH0QuTJLgWoYLK8B65NztrSToUbNr+baBKc/KUR9kTXieCGq
         /+JYOQjejrpRQ2NEkSA/Vzxtai9axDohjwB84nclgfKNYDbVgEUw2+UDQ/jAIEYDoYZl
         nD6mWuvNxjXLPNYkIFL6tza/7RYqXgC23VQsZd7onE6GC8al92PIQKrB8npEv4JKteR+
         q68VN/E+EVEXeABUxinkvtPaeVMRJo6y2NTrw1lfSvqXJLjbj+trGfYIt9Yqr1c9562Y
         8rk+N+iwXoOGCEZAi1CFrTC1TxITl/L4QTLezrCUDApSYcDIJ9T7wxXgmR6C7UWe079P
         pOTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793570904; x=1794175704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        b=Edoun3lc41UYZtcPN2YtEdQOXNgQvW6Y/sz9dZRx4YRMYUgYd0/T1wWoRsJao0oBAA
         5eqh06VLdtAKF8xyLO+fyE0Z4JQTDt8T7zjIbQewXTC3YPS1/8vaEttmr8U7yHqq77KD
         6bkEF6ZPyKXWbbkdNs8Ow70qA2rxuSEVD5pkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793570904; x=1794175704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        b=05lMf35j73EP20yZKDD12xmX4HwUHF6NQ+fhjtkXl9rti2f+bXo0jgHXTaMRUbxAXH
         7DkRkPu/WgDc3Lpaz6YJoM2ARzwnjYJtuQNzCoXQsl4MxKqX3dZKEk0hcjx2/ZzkTgJ5
         NTGG8Zuy+YfikvhwHsFkWiyM22xcOpqRGPfBUSrh7ZC9VrNBFUXZk2GPPO29eZ6N70Bm
         7IlXwOkm6KkTN4W0jdrr+6lx4VA/4641uAa9k4WAQA8H8giyjVzeqZjtsJg/vyczdrdD
         e5s5qLDoEznNpLi9DyOpgnh5l2oRIpuZatxL7bSlk9XQoaqNQll3gE1FDL42elTmo9f1
         tH3w==
X-Gm-Message-State: AFq9FYKOSeVC8kS9MdYP91wz9EbY9Qa9yX07MYMnuPxLWpKda81x9wv+
	0MZl2G2QPees39r/C6n3rAtT1GGN97rMBisk86OnvllG2ScECN2WtaX/u5NE+iI7Fk4ZuY5XdvA
	M09T63P64q5JebhjGVmq7ibsPa/yhNjW71qs0/VBH
X-Gm-Gg: AYBFou0J1EtC6rhQ5Q2eMFaeqapkpaqBeZmf4EcyCpc2fHL4wM12GeDaITZ4eJypUOX
	PzVM7N4xCsNW5jRyhcJGIiyb+dtCzXmFEm7eHdr74slFSVkuHnt+wbInnqJoc1Yewi60xSvPevO
	Epzoyha0LrfoeO5G8KVjo50SRBaQTu64xmMnsEK+usTaJ/iEP7v/cZduUwXFAVyyIEkJZSgfmM7
	MfYn6nJqCizZKU8WSATaHn+Q4nF2xtcnytAzL9hLbg5aHeRKuPAIByuZl7OylGtIhF4xQgrh7/v
	Yg+d68/2iFvUefJZ0oKrohRhfrm3u4MrlfVWMEER1y4fA5Tp0YC4lygRri6IpISNlrQog/dc0A6
	vy1l8HlUNqhutJr7RaywOmzZstpctxCJ8cVYXvpcZIWGzHBeFkBsKmQa5Ok1NvNyYq7olSiIV2i
	W26OKmfz6wK0Qiy+I=
X-Received: by 2002:a05:6a00:12d5:b0:8a0:5d8f:6675 with SMTP id
 d2e1a72fcca58-8a9bfbf4ce4mr6600642b3a.58.1793570904488; Sun, 01 Nov 2026
 14:08:24 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com> <179356441771.3131.1618449912961461255@kernel.org>
In-Reply-To: <179356441771.3131.1618449912961461255@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 1 Nov 2026 17:08:12 -0500
X-Gm-Features: AclHuK-rEYdLUizre6WqtVeCRp5nbMqf3uSANng7nnZL1dTrmlvsMkzmwbBVzM8
Message-ID: <CAM0EoMm+Ewhw2exfUt4LYvsFS1E_RRre9NLD0qq7uzOSxJXbQQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3 repost2] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 3:20=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix checks that a teql slave and its master are in the
>   same netns only once, in teql_qdisc_init() (net/sched/sch_teql.c:211).

Pre-existing, out of scope for this fix. We have captured it as a followup.

> - [Low] tc-testing case 124e ('Try to add teql as a child qdisc',
>   tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json) no=E2=80=
=A6

Ok, fine i will send a v2 with a new tdc test as patch 4.

cheers,
jamal
