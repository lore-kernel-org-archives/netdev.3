Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530524;
	b=TpGWC8Eyiagw2Tld7M21gnjDLaHl6RNdzIb1ZPfNonuHvw955XQdAi1QG6uTQCo3Y8sz
	 IzxebCl+p68/1S2NasRGSRf2MnoVn9h0QVFVUb3+bHoS/iAdOZkfZ2A/+8z7pnIA+I2d9
	 zRlxhDcAM9oGVJBjgiPi6DUxazEugkdsK8ga9BxgT6YZumKnPfifnHMH9DW45FU4kLtYM
	 Hyv/tAuumzWa+NgjF+1YZ5kVVd9MZWE0cj0OHalc8NOVMg0SzMblpn3evW5i8yD4tBpxq
	 8ZCGYUhgNjxmdaKEElQSqXvvOdTxuLWvDTc9Rh5JD2VfBL3XHgfv7r9K55tvCZMxPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YL7HdvRgoulMVBDaE6Qg6DwUJJA2vnGhioXYaH02k4E=;
	b=akkEUybzO3q9EC5gwjvee8pN0iCIFmJdbtdbzef0F8zurMCKzJoFf/REdCec3pbT+Osc
	 C3bnW2k5cjknK3xNXdFbcT7ehkc12vT5SgfdXxj3Bt/COwf80ngL4mwp8lzYcphqe/KGM
	 AQvk7zCnoQWUjfacDxEde5helOo8qrlJOw3SdErZVgbCtnsXEiNamhStNpsyDbIlEazIw
	 mCDS1g+qz3sf9OYD4KzmtFhRnHiUBrzU1KwIelqHfcpvJacpenCENpbkobgRAAZqYLMPj
	 IU0PuqXUcqYhhhRgfeKdgKlGvFZWJHX7oNRXTNpcaQkvWtDEF9z+e+iKuZ5pQhAd2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpPKohat;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA5606A886
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CBA5606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpPKohat
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso348548c88.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530523; x=1795135323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YL7HdvRgoulMVBDaE6Qg6DwUJJA2vnGhioXYaH02k4E=;
        b=CpPKohatRHUTPl7O81pyX2Luk3+nxdLDH5mJo9iWEa1Bx0FmTZKMPI6bYU8rQZIjfM
         QtNO28jJeIk3YxGGcvQNS/N1b6tpN22FMqkzkvMOq4SqEs/wWa0ILnCdZ/RU7Ffdr9q6
         dW9TJVKj319GiULCAe+jPzAcHOyc18nBMJk4R3aUXjnmKXFaQwznf9D6ZqfLmHfeJugP
         4k5Jha7vcEEyHDb8kMZCbIsYvo8fL2+jLMFb45RLPA+jjKvGQtHQf+cUXWEJo9DxNquX
         INOk2dI0LwnL7/4hno/XcRSIgrqNO4WvDUYmGi0f4m4yKbysema+KXFZPAtMyKBc7uKW
         fGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530523; x=1795135323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YL7HdvRgoulMVBDaE6Qg6DwUJJA2vnGhioXYaH02k4E=;
        b=MZyyUOHvOpXMxVOcokcbPRzPeeuc5PCYALOo/o54gJ4KkwN9sndwyYkKs0v775GlTh
         9KxH7/k5MJT7Ozk1lJkA8pzILJULHtCHYWvZnPta2WT67dpuY+Z575KLbDwRwRUneSvs
         PyoZiZ6ey9KGAZ3AA++5vPNbvJ33F25A6wjRgRgsv5a49E+j2D8wJaYI6QAPXZRByijQ
         UYRilYpZXDMIy9fWaYpOXZHeeCxeOljOPsxkfuGHicpgy3sGBogpZT9LFnChuCAYXpSH
         OQIkZcfMKEHiCrhyRXy3PuM2owbuke5NlesWF/o5s4UpgnV/hFPuvUAkcn7AC8vc30Mt
         NCmw==
X-Gm-Message-State: APuU4Z+N4bXNgqEJsoet4P8pXc99tii1VTQ60Dx/XBStnV6cG2ljmN1X
	cRvBEEZFuJiqmpUMya7DpilqkPA82OI528PdOzlDqwcXAE1aPKsJsM/v
X-Gm-Gg: AYBFou18EfAofPTSenLyMNKZipPEuziuP+/rlscxxEXLKPLuTSSkKJK3LSdXy+C/hCV
	XxmtAwP3mp0EmpGe1kskyj5tS43GWoYdNJtwGaloyqBx1WIlcWOLcMw8B/escCPzYn21/c3mMN+
	3jjV+D8S0RcT06rpPjwxwK1cll2kk57ylJmfD9baPvR6B7FYKXA7KxC253+Au9j5RP10vmsNZUk
	HfRHYkHHe08WH91XXs+j4Cin4GNcphXgMK/YJyzjizlTEyTttGWmlHPL/n9khBaso7lbfKQYqjn
	K9G2uwEUnH2TZxLGoEMOzdvIWYNEL/98gZ/71/bWLcx+FfYld5jWbuTgCqrIA/K00zOkNQ+SkrU
	lCxQa2CN4XYQypslexLyDGP28NoFeDrNoII/IyLN3qDzetuMaU+N+Mly9pVnt9krjyX1ftEwoFw
	gJJ3s+YFWBFpXBQ6s1gRX3glrU3huHuvfcLnZM2xLeHWM7ZPBG8KTS+hN9sKdzdt0Tsm2fOjShZ
	wv1UN+hlyh6ZT0dVZ8+HG64aYInBlpk7u3x3klYNPC+pBNyZ+y7mrbr9kEt/i46leEwQVP/eMQi
	7azWUDKinCLtqD/U9Kc5U9M=
X-Received: by 2002:a05:701b:4213:20b0:1b3:b4cf:8f18 with SMTP id a92af1059eb24-1b5031a46bamr1155706c88.41.1794530523330;
        Thu, 12 Nov 2026 16:42:03 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:62::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm2811710c88.4.2026.11.12.16.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:42:02 -0800 (PST)
Date: Thu, 12 Nov 2026 16:41:56 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	almasrymina@google.com, sdf@fomichev.me, leitao@debian.org, dtatulea@nvidia.com, 
	asml.silence@gmail.com, bobbyeshleman@meta.com, daniel@iogearbox.net, 
	razor@blackwall.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] net: devmem: size TX net_iovs from the
 dmabuf layout
Message-ID: <avZZ-6GGciPC0Lti@devvm16445.scu0.facebook.com>
References: <20261111224740.2744522-1-sdf@fomichev.me>
 <1b764043-2efd-4e65-adb9-a47c0136446b@redhat.com>
 <avZC2hp_0ODMQ4SG@devvm16445.scu0.facebook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avZC2hp_0ODMQ4SG@devvm16445.scu0.facebook.com>

On 11/12, Stanislav Fomichev wrote:
> On 11/12, Paolo Abeni wrote:
> > Hi,
> > 
> > A few (late) questions/comments to check I'm not missing relevant
> > points,
> > 
> > On 11/11/26 23:47, Stanislav Fomichev wrote:
> > > TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> > > A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> > > 68KB, which makes BIG TCP ineffective for devmem TX.
> > 
> > ... with default .config. You could set MAX_SKB_FRAGS to 45 and reach
> > ~180K...
> > > This series picks the TX net_iov size from the dmabuf sg table instead:
> > > the largest power of 2, up to 2MB, which aligns every DMA segment. With
> > > a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> > > no UAPI change since TX addresses are dmabuf offsets.
> > 
> > ... still this option should be more effective because the limit would be
> > higher and the skb would use less cachelines for the shared_info,
> > 
> > I'm wondering if making a comparison vs MAX_SKB_FRAGS==45 would be
> > complex and if you could do that, too.
> 
> Originally I did not want to include bigtcp to keep it apples to apples:
> same tso size, just 16 frags in skb vs 1 (in ideal case).
> 
> I just tried running mlx5 with 45 frags configured and it fails to start with
> the following error:
> mlx5e_attach_netdev() warns "MLX5E: Max SQ WQEBBs firmware capability: 16, needed 23" and returns -EIO.
> 
> (fwiw quick review with llm claims that mlx5 only supports up to 20 skb frags)
> 
> What I also tried just now is `gso_max_size 524280` (on top of this series)
> and it ups single flow throughput from 200Gbps to 240Gbps (presumably
> by making the receiver go faster with 512K TSOs vs 64K TSOs) and halves
> the sender softirq..
> 
> I hope this gives you more data, not sure running with 20 frags is worth
> it (vs 16)? LMK if you disagree or want me to run something else.

Fun fact, also setting gro_max_size on the receiver gets line rate over
single flow:

I   client.c: Connected 1:cpu 39 | 1:cpu 118
client: == Source 2401:db00:255a:4a:bace::b
client:   Tx389.448 Gbps (2921248849920 bytes in 60008026 usec)
client:   Rx  0.000 Gbps (0 bytes in 60008026 usec)
client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
client:             2   125  86      2    0 15300608 10142
client:   net CPU 39: usr: 0.03% sys: 0.06% idle:67.39% iow: 0.00% irq: 5.69% sirq:26.81%
client:   app CPU 40: usr: 0.05% sys: 2.91% idle:95.67% iow: 0.00% irq: 0.21% sirq: 1.14%
client: == Target 2401:db00:255a:44:bace::b
client:   Tx  0.000 Gbps (0 bytes in 60009306 usec)
client:   Rx389.438 Gbps (2921238435008 bytes in 60009306 usec)
client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
client:             0     0 210    122    0  999424   10
client:   net CPU118: usr: 0.00% sys: 0.00% idle: 1.60% iow: 0.00% irq: 0.33% sirq:98.05%
client:   app CPU119: usr: 2.75% sys:77.46% idle:18.95% iow: 0.00% irq: 0.47% sirq: 0.34%

4200MTU, 32K rx-buf-len, this patch series, gso/gro_mas_size of 524280,
still the default number of frags (enough on rx to fill 512K GRO with 32K
chunks).
