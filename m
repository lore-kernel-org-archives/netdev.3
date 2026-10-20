Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523211;
	b=iS9hbRF6gImbV3ETlx1ikT/p71X/O2heyr4UFH98bdbcOqYwRaaGG5/9sg8bHE3jkuww
	 MOzxbj317QPemR3P+p822FlPTIVgZri51Ggt9NC2NEiilPqnEBN5e6Ei784kR3Z/lX5V9
	 0YC5xdcx44gCEXklLFj48Hc1yF0lw4OFUC9ojFbwWsxDXfY8FCsZHteQt9qzPV73dJNk7
	 s9U0UN71ojraa+vI6s+bsH110qzBOSaKH8nTCia1Qzl0rdo+KW/L/cnUgrUVle2nCMmFJ
	 LGhEf/WeV9OZ4Ib2H+737wRBay0+wWDyZoE3doNN1Iukh6uCRfgP55PrCYRLeMIKEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fWHcLGrpwXfqLXhaJj0WaQH5QqKgXLOGytFJYtpDAYM=;
	b=NDne5cvk7riCcRBH9ZmZhyb/gbFRLj5Km3NkKcPio+YmhSAif6xVb5jumnVmgWRfH543
	 nId8K2/Bpp4NRxDD3GcpnZ7+Sa+lCdNvt4ZFXLrmklHcBPqIBsLpyEeQXZXNTtrJFDR0N
	 lEpU0YjtmRjopIxxZX6cse/ObaGxCx0mW67ryUJVfOatwZtIN2FIXrt21cJBW7eVEcxhB
	 9jyqrheOLPhht7VkP9tmSEbk3RxOqodW0Y8hHhoQanUvSiBJhRCZSvuPB65ma9kly3+qq
	 CmsDlJ/hNJr2zU1sp8DEshyTnM63kYrh1hxCvM0s28E3QBEgagX9Z5Hd9WNDruLvphw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvBMvhO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA6606A32A;
	Tue, 20 Oct 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvBMvhO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDBF1F000C9;
	Tue, 20 Oct 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792523210;
	bh=fWHcLGrpwXfqLXhaJj0WaQH5QqKgXLOGytFJYtpDAYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cvBMvhO5eGuUCxu+Ci3R7HHSR/hPR5aHl1ZRoZg8zMPbX8SjLF+ymAl9Eb5wsalPU
	 Tj5f77QQBw6aM3Mdzfx9/RAU3nuTYEbfH8/huuiWnIjZOhfXYQHHFGVWayPGOyusMl
	 JMqoKBTTUZZ3q3J+h2Yb7p0f8TOPdAkrurcHRWBRncNfpiwaXQUGlywaV+hztav94S
	 bFGgL6C7hfsPteXZTcd8w7O50hcqcoZQbKz0Nm2dLVFaz1h48sXJuWfu7ac2YbBtXv
	 6GwvMiLvPykabNa/Gatz69BocBKLcmmo9sVWZrw84AuiPXH+oQ4Kko06Gl3CkGsu0G
	 ZH1yVAC5UDBKg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski
 <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, Dimitri Daskalakis <daskald@meta.com>
Subject: Re: [PATCH net] eth: fbnic: Correct packet header prefetch
In-Reply-To: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
References: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
Date: Tue, 20 Oct 2026 21:06:47 +0200
Message-ID: <87v76w6vjs.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

Dimitri Daskalakis <dimitri.daskalakis1@gmail.com> writes:

> From: Dimitri Daskalakis <daskald@meta.com>
>
> The existing call to net_prefetch() fetched a stale address. The data
> pointer is not initialized until after the call to xdp_prepare_buff().
> Thus, making the prefetch ineffective.
>
> Open code the address calcuation to give the prefetch as much time
> as possible.
>
> This was found by manual code inspection. No issues have been observed
> from this.
>
> Fixes: 9064ab485f04 ("eth: fbnic: Prefetch packet headers on Rx")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
