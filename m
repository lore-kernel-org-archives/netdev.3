Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BE3B3BED
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399934; cv=none; b=nvF5GRPj3k9Rv0E9+WyRLXbHkE/JmeK/UM3RnydDKB003+ZiUWcZB88KT8PdKHtzhyt0nAK7iGB5Debuib0iE5lezPfQrMVv+nrAlWgt7EtK5wCh//Y5/FtREnRlNnjhmrIiRAXZjgslI4zZJYalchnc8eifog2uhnGeiiqW4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399934; c=relaxed/simple;
	bh=3HnYLCft5wrDNptkmSDOqzkg8ENAlnD+Y0X0181LznA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZ5mi90crrrzjyd5O+Zy9VXrLqYYGyxxex+glNLIuWGuz9GkGyceItsZh87FlTwejbuoiEpWLBKlPGfOddfc2YjaRZcxGLthgcTDWPC5mSOAMfgL9vbFI3hU6eVtwenVUHdrUUNC4Ks+5ocIpMfPrJYah7dp/x+HLYOg7pss3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqcvjyM5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqcvjyM5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d02b4c3601so14760315ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399931; x=1786004731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fEPC2WyvmVN5ymscE1Iz0kKQcHLyRFx4o2IfQD+5pVg=;
        b=FqcvjyM5mgsBImkAB1qfJHY3LCS/jZ2POL02H3CZYmv0V8xSaVmGLe4pLqCp0dMrwU
         YuMY4Oy5zHK+jT4It8p03hL2jMklclqPO3eC1+vqjANTcw1URhzPJ2tfiPE+ZuWpLqp6
         thAu7qsvdJtvgzibRXB1rHZRmnwEnbb26+IpC4fOA8dCTDxBHhBjr3k3BaPQq7G6W1i6
         8g9wzmjhdO5PzB60AsN+KR0p53YYtzTrWaNJHQLMFEO8L8r4yPMgksD0Ooux93oY+fZ9
         Sa7ygfNItNBDp7qg16qiLU9Vn4ey0QN5F+zIThbpqyyDSgNQU0KG/HeiiuGZdDGbEAY1
         vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399931; x=1786004731;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fEPC2WyvmVN5ymscE1Iz0kKQcHLyRFx4o2IfQD+5pVg=;
        b=H99R3r6wlazicMCQvBBiFJL3sl5T4m3BPPdlRRtCWcoMdCmz1mFFYfzOqTyr8r4qak
         J0FWMBx9sTN8P88P3FaBkpGcdKnAZXY4/vU8hcWocJJZUB6KDny8spDqavC3evYpcLP7
         Nq7u3up+DxS9XXenypajqKVGO8AvOaQ98fe/QDshNnBzE0IKGsw9DZyehsWryMItmPf5
         8LBIe6TIMgQnRWuN5A/mqTVcDcj4SMOzHbnZjC5dU8JIfhD24vSW0Bb3E2TIhyQF9NP+
         MYGw2Cl68OKtSJsUjrSXQkHtf4rRLcp87ljFfRXyldXFdQ0iMQzK84U3Me1ALNPCsSsd
         V0sQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrz1+nDEnpDBAoeS6AIuzA8C9mctxEzRDfBP9o9F4XP5lAkTpQ/WTz2A9VkOoE0uPK8MAm2Dvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7q2vZTQruNxndtt88tGoJM3BShaaHhuBm0g8ilNwwEEpFDFxO
	EG0eSLHWM83LRXjnqQe38T2UfKyRbisARUTY3D5KqKqCxcQyHWOujQsB
X-Gm-Gg: AR+sD100Ucz7Tw7RxVLy0I3fH+Phs1dZO2ZKgQZ2IIWD/qjgV7j5VSe5O42hXn53H7K
	RMQuCovFG/WvI4sQiEWXdG4gccs8t95iuXqMghm0kJnuH5yedGRFvKFgKsz6Z6FOqCINwpLB2CZ
	B4jp6azSABoZnSYtox+F5fcblZnXYI+5so20WvHdaliDUJCKbAguiKBI8cYtf3NSmAMPxEDbT9e
	GNUqYLy2CpqqInZuK9UBrKQYxT/z1JlGvpAhkqVoOf9mp8lBc5uc0LICUs5miseUCtGnlXDpNRZ
	A8rQzajqx+4JhSmEmcu3t7KpconbLqGRcs9JNmEFx5LzPQ4m/X3bTU8Wq7IIC3gRbjKE2sjVjxQ
	51n6t51OsR3y0c+QTsz/n4+ycwmlpqQmc9MgdCY2SLZQKIePdhxKm8sSbwxxHcCzqX8uBxWpCR9
	9xTdnE/SP//wW6Bun92SH3MbpG73GYUW4frO3pGf2+iKvqDxWi9UiJlmMMp+AqUnkqNGbw+m+Vq
	swrCEjLXX4M4JxPWg==
X-Received: by 2002:a17:902:dacd:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d035b98770mr17436495ad.5.1785399931588;
        Thu, 30 Jul 2026 01:25:31 -0700 (PDT)
Received: from [10.22.76.22] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c4090fsm22601515ad.80.2026.07.30.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:25:31 -0700 (PDT)
Message-ID: <51881c2d-0c76-4333-9bf5-63d4945c520d@gmail.com>
Date: Thu, 30 Jul 2026 16:25:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 George Zhang <georgezhang@vmware.com>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727071305.45826-1-phind.uet@gmail.com>
 <amn7W3hAIEC7kcQO@sgarzare-redhat>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amn7W3hAIEC7kcQO@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/7/26 21:19, Stefano Garzarella wrote:
> 
> Should we do the same in other paths (e.g. send/recv) as well in a 
> follwup patch or in a series?
> 
> The patch itself LGTM.
> 
> Thanks,
> Stefano
> 
That is a good point. I'll look into it and send a follow-up patch if it 
makes sense.

Thanks,
Phi
