Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632950;
	b=UKL0RXV6eUut2BQpp75AxqGaZKHNltiZ1n5AHEcwObphh6kqVlhptujpo7LY04CcxUyX
	 fZnO6CUoE/fypKrANEakkMEPgB5hBo3DKBJ8xiBbtb8I+mDJOmnEaD94zqaZUDuESD/Ir
	 WObaTBVvhJsRcbffH99tqMg7RPjv7ifDIlLxOiSkrLUCTA5Fcv6EajdB7sP/6e8fBXzdp
	 7UTevGuTQjoKUOJiPdU3jc22yBAd2PY3efbnWdsTJir2pzu+UcaLCCy1Rqsyp8J3ePBk/
	 x/oXqkZfLk5pYKnbVKWn001fGALQ5rfZcEz/S4fsaKaX2zjvtiwX2sIPVSnNobhlmlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632950;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ODeQNKP0UJzemh4mAsPTNTViZ9w8JQQkxq+xVPOOp4A=;
	b=UC8Gycnp7eRoHuwN16AZGLclm2Ktfb+jfHZ/4sAWSZvqByxytN9KEdfsT3Wb2iF+M8Yc
	 1VwMWKJ+ptsNvnegSnaohuymyXhwRQGYeM7Q7eFwbVJLoppr+sS+IlVoHl/nu68FVzrNQ
	 s7hS9wawUlzwW1j01h3l44OSn02AHw+qp0zDQW2EcZxtk7dsnT8JlZEmlYu4jrXIaH6si
	 WZ7kX8uq0aURkw7fXjdgb7HAGtHGjK8odsQKT6kIm1AnbDF2hRshwftJWwMWqYMEnM+xG
	 TW7vWdUuoyB0/bdwtm6z8GKGv9Y55hKPuAnWmNHwmjzoFr3CdtBN7+UvWHT7NNpsAMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MkPK98Gk;
	arc=none smtp.remote-ip=91.218.175.120
Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71B6070DB0
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE71B6070DB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MkPK98Gk
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ODeQNKP0UJzemh4mAsPTNTViZ9w8JQQkxq+xVPOOp4A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632947; v=1; x=1794237747;
 b=MkPK98Gk6+VtkxKxcLCiTZ79pZE+KHJ10FDlU0JuKqId69E4Br9BDm2UG5xM2pXu6bh8SDK/
 l/Cyoh85ozVnbJj2YmWmmk2CpYSnM3Uh3ew27r3OqktJwvxXv4J0LhnPVerVbbdrI6+WMLyqwPq
 y8ALbIKiQlQ+YNE2I9BMpwvk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6dff1b99e2386a3;
	Mon, 02 Nov 2026 15:22:27 +0000
X-Mizu-Trace-ID: e6dff1b99e2386a3
X-Migadu-Flow: FLOW_OUT
Message-ID: <d108788e-bd69-4bc2-aca5-d8080fea818b@linux.dev>
Date: Mon, 2 Nov 2026 23:22:18 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly
 queue
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 Florian Westphal <fw@strlen.de>
References: <20261030081225.2575462-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/30/26 4:12 PM, Eric Dumazet wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
>
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
>
> This can be triggered from an unprivileged user/network namespace,
> raising ipfrag_high_thresh and using padded TUN packets, which keep
> a large truesize after being trimmed by ip_rcv_core().
>
> Track the sum of the truesize of fragments in each queue, and refuse
> a fragment that would make it bigger than INT_MAX / 2. Callers kill
> the queue on this error. This bound is far above the needs of
> legitimate traffic.
>
> Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
> Cc: stable@vger.kernel.org
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>



Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

