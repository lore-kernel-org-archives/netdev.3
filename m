Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F375470EA8
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924014; cv=none; b=rMRYhJAS5dGs432Vyt0gGV4tC5/uqLH4LOdxItmK9X6/D5HpHvg1iWuVp7H0kYeyJ6wqNp9OFrWsRKmgQJtBO+jg8saxhq4YqjX+4aIhTLqCzOhbx7q52qeVzb6/U0kWvkW0gzOD4q9w0xA3HPs4NtL7bJpLPqa95m+gfzECHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924014; c=relaxed/simple;
	bh=qMIrOtqwDGQK7tR1Bzev9TaGmRY6zy0a+hjBj/b95ak=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=li8wR90Y5CNXcFr2fA6HTv0/u7CzE9fDGNZS5XLUgFlPo+rOnv6AsxSaMlfo4tiTzXGM0DWTRiQCUV1ZziTSVcsqvIvh1vusdzRwD0fjxr4QzuZw3tA/2ZHdHLfQjhRD4bQIFuz+B8BqtS0Uk1m6XzNA6bdIEY37Cr3KcehPJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2WvOcgR; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2WvOcgR"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so2580880a12.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924012; x=1790528812; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yz1+tTRLmkyE0kaHQfyasd/tZYeHVlGzAW89MX5E2p8=;
        b=d2WvOcgRipppSk6g1D6k54nvA7uurpMduo8lqT1kInmFMvDftVTr9ergIqywGHImEJ
         d0CwIw9Pkfsqd603LqR0do4zbQAQFcxCVjUdTDGZ37ny2STI9rLDVjS+A1aTGqi29mT1
         eAaV8ELXNiZ1d+ofFLDxV/QS7/g4958cJhNC+NomHLCOKNtK4TuMkbSOJUg4z6b91Mc9
         vNqttL1inu9W369GYWCSHCP0RCf6LQafwh4ZJqYp4QsMiaE7yYhD1guNUakAb2WDaiYr
         Zc1qo1+UCmjLggx3zbRUhu2hprQnnqGsd7RYcMErBoMOn5O+ZBASvqi9wFK1SSwarjpR
         xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924012; x=1790528812;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yz1+tTRLmkyE0kaHQfyasd/tZYeHVlGzAW89MX5E2p8=;
        b=PTebr15By26MeJ1wQq+HatyVChVkD6BPGYPsfFatjAtlWT5W/1r+/A+W2PsDNnzNMh
         pSX4Gk1CSk1XX+0sJ5EgpRxmiq/44GQUUUU60XagDwFwYYE6Gmjbbf8ntjdT8Dl/tORD
         9Y5ETbcHEQHFTGpDFurIvi3jMIryNf40YXVlMO7PI0ryEnH4Jc05R2g8YKNanswlixy/
         hTrMqXBC3rB7k8n7gB9iSgP4/Qd9BBbQ+0+Qb5gjrx9wT8Q4Vm1c/6bVmXTwPkKIzlos
         PqMinMM/jH05LIpzo0U3MUACApzMu09nh+udXvqwxFzv883ZzcAgPHu2BBGMAnH80wSJ
         IMjw==
X-Forwarded-Encrypted: i=1; AKwUvBzfZto2xC08RXngh9AVLTF3TfB4eD5Ge4t9Zh22kn8NlMM2b8MimfLwQNf2a3KXvfnWDFYBO+g=@vger.kernel.org
X-Gm-Message-State: AFuF++n10GO6jRBhtL0ZFvF/SMth8Ugb6k6k1ioWrDndCsJnZXos4Wff
	KLYIXeoW5ktlPpknqEAz4C6lvhHTXZHrsk6F0RqL9HeC4qVZiLU1obHP
X-Gm-Gg: AYBFou1/uXRlm/+H9PC4Mg7Z/oPMsQGmGjyNm39vV6zMYsY4qZy++VwQTsGRFTPWU9q
	S4ZzHzhE51c5+wSB48s2G8ZKisNkER4Q8X1pXCtCzuaz7ixzJZpzVZ8lPvkH9UwaLmV67o/9Rw2
	PnUllbIMD/ioH/S9pDFNTvMl1aFbMcJPsK+PBynt+s3lbCIjjuFDgOVfShD+xjU12jcqNqJJfuQ
	BCYABJoecTDy5syymxfBNj9tU1qd1G2U90prU9QBn1+utdzTVW8byB7KumPKOu8wnSF+omnE3zt
	eivLygVA/yfhlFPixy5KcTtlHMCkD4Bp8k21AUtCJ8pulYEKdo6DRBFCW1Z/EGplcekucsqO2RR
	uEfnGlmBOCUtx6ExsY0Drh/brVTrq95ZlRh0NZfFRgZCgWb8qRnRvy6+7PhOGHxRCqsckqgvrQO
	qLMnYfBG8oSXnJxYz5IKhO/A0EX0jmDn57aubqRjLigLlkidflWMCfpXq+T3dsNNaEqCTX8Qobf
	LnNyLVGnDX0nv4Q1Lg54T4Fu7fT3EFVaiYL59k0aOdfj6JDoBVofEm2bMFLL+RytUXNh47vbNXa
	OGU2
X-Received: by 2002:a17:90b:58c5:b0:39e:6c69:9b97 with SMTP id 98e67ed59e1d1-39e6c69b286mr7319728a91.60.1789924012326;
        Sun, 20 Sep 2026 10:06:52 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c64csm9614016a91.10.2026.09.20.10.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:06:51 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:06:50 +0000
Message-Id: <DLKB3UXOH0IS.1UL8NV9HSJFXG@gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/bpf: cover stale CB after LWT IP
 encapsulation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>
In-Reply-To: <20260920163211.795547-4-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com> <20260920163211.795547-4-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:32 AM Weiming Shi <bestswngs@gmail.com> wrote:
>  .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 288 ++++++++++++++++++
>  .../bpf/progs/lwt_ip_encap_stale_cb.c         | 100 ++++++
>  .../progs/lwt_ip_encap_stale_cb_freplace.c    |  32 ++
>  3 files changed, 420 insertions(+)

This doesn't apply to bpf-next.

And 420 lines of selftest for a 40 line fix ?
That's an overkill.
