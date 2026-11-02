Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646795;
	b=akCx8OFhLTPIqZdCeDZQn9eJvrbmHaJGUmwXM4F2l6Owe+YVSA9fv/syNDuLjT/IItY7
	 kDQGQ9wafWnYtl2zrgG9qEnzL6OmiLUfeH6/xAUBu3Wj8efzrqutGAAuPwoC6FQGxPGYy
	 0xCY+O2g8rVyXMcjcQojHiwgE4dpMLiP8Lb32y9fGiweuwxfsImcdynSLKvVxUIdwshbm
	 qevX4pUAteSF6yyCxv06hWG4KFuSO4bmi9bnh0m0x2UenbtAYS/Bd6ZPevqPKYgGt2BoV
	 f0kodOElhVxNtdCuLWBub90abk1g218PWq+5fnkMr0oQ1wBnLj8a9prIT0AoDVwx4zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
	b=h8KG5tg8I+5gYZzJDlL3kfiQ2BylZx5xGMJlmntOIKOfkXaMjIUsIJsadWCZj/nzrael
	 Whk+0K9AT23JTpBdqUq3tlck6Hs83PH9XT0k53ahfXoLmpVU9iun8vJNTipe2YcueTufV
	 /lfVEyF9ZsZzNF0CoJcul4EvyqhPSYvn3WLScA/2XvsuCXbYANdPbhJgG8MtLt2OroT/T
	 GtuOa4YXJ53w545bd46hC2JF26kNNIY7WwXixJWB5mPyhOUQ4i41P68BctGRW62qJ9rif
	 yjGQK0aPHCISnRj1yVhgbSaK4kz7vAPKYxjgcWnxtLHOqfns/uj0MxPT/AWmfxgNNvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGgIgNYv;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8A606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA8A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGgIgNYv
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2450175a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646794; x=1794251594; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=AGgIgNYv+1UTnvfh/F07/DULKtzMOSoD7VEwy6wFpWFPnWWmGUJBsR1uXYYRIufWr6
         9ZwCr2EIRbWAzrBR4o1aJJhEBn3G7/KNe5lyhpFrA7DNQ8w0GlbjnI0wt9tvTJg/aSh9
         qoaUBjGodgVKzQnV3wRlptSZ/BhltVMcRK26772justhnwVP6v4kJFKyio3x7KbAQADq
         J0P2vUb+ruGwWzNjX0/WoycfTdBwwR01pdS6qioqjZvyiuZ49N5ojBt1UA+L0v/VS/ZY
         Cvtoma1S7MF8t+7/ux+4RgsIky4t+L+XlBIA5ZGL/ZTkdqMHHvJhLghtVrKKm8AjkH2o
         tv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646794; x=1794251594;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=Cdyw+Skol01K1mjnhbKSSpomvbxC/4RZAyf2m3WyAPiCCZHJySh5McUCX8qJt18bBX
         XOci5FB5ROyCT7xHmAL4GX2Lohhp72NLAsZmcgZwGtvCqZYjtOmVCSiYEIHQt7OLf/Sk
         gfIfUq/ViXhp/MlHuNdSKF13/uO9dT9yP3guvOnN/FSNXrw+p7FklNRaH+y3jqwmdvSb
         LxEu0MxQ5dwcQX7th/2IqAr6QazqoV0hO+2CviE75Gvpfd/goA+04/OdDQg+HDU1N740
         M2HzU1/sxNqTHVnVpPtcUHt4pD1gL3+QRkHvU3svCMXAJo50Z5JbnsAaek/ak/QFfPPR
         CwwA==
X-Forwarded-Encrypted: i=1; AKwUvBwGFyLXrWVYnSlp+qQvFziDdj+UTsZ+4akiwsI+lsgAIdRBFUkPH3voYC0TTMHxc795Xa0fUUo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/slRkrDfXBsk2KW0QXytUcvrZdYUrhaTTzEEW4+7hoxN8EDRz1
	VoTf7k7SJq5HdOUGor+n5kgNhzu3KAHhqQMU+03KXH4R/SNmzalE0SGY
X-Gm-Gg: AYBFou0GhY/6zQNI9iGd1piCLrFzTcwkPmg3oVUuMtphRlhBpz5Im7z6ZgN56tNxqsP
	Ic7tM8h+adNksbr9IBaLbzgxqLBxNouI/cU3xefcrgoqSFqTbObQ5g1+hRhcKKg5HIGwqJagWiU
	WdfBsz5Aw8BwCaAmnckR4X7WGaPgCXenPoeHrx3j6BRFM6YQeR7TJIWXOskXsbMCALhkJCUTrUW
	jF+W/aqt9xUl3C6flV0htrwCcHxnYPw1BYgolR1WUInj+XaCzBwcIszgNXtm3PZhHesPnDb3Syh
	iyuT6+EA/O8j9/2Ttm5Uyhq7XU4aA4JKGd1cr5Ut51x7QeZMfEofNzvSrsHDM4E75mDtiNshNBo
	PDKe6nWbPSvv5kyF1HT6zPlCCcmeUgzB+37mU7l2zX08fqTWCnfjAeavnWEXv9i3ULKmiRj74Cc
	/pFm63ZyliSB7hi95RReKbyU3LHqG4+//54mNC+MMA81pDHMXGTwTK7j01s7Rz3TW4v/R5iZumK
	0B+y/UgnwH8aTnIcjh77mZOOZAR3EBlaIdTtK9ot0+1tYAPYAUpDbXkwbNzoO68MQx4atmlLkoI
	3GHRcKqlda0SH5qvCMAYYVcdMISgRhNDJIz+ka1mr9e2UT0WDXaB4krk1Z7zKsUjIGkq
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3ae897c87acmr9116933a91.23.1793646794112;
        Mon, 02 Nov 2026 11:13:14 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm451194a91.5.2026.11.02.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:13:13 -0800 (PST)
Date: Mon, 02 Nov 2026 12:12:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
Message-ID: <tnw2q0.1tgt7zq8oeb0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
>message. It then subtracts tosend bytes from *copied, the return value of
>sendmsg(). But tosend is the number of bytes that the verdict applies to.
>After bpf_msg_apply_bytes() tosend can be less than the message size. Then
>sendmsg() reports dropped bytes as sent.
>
>Subtract the number of bytes that sk_msg_free() frees. After an error the
>SK_PASS branch already does this. The SK_REDIRECT branch does the same if
>the message is not the cork. Nothing changes when tosend is equal to the
>message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
>Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
