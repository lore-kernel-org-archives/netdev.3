Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669957;
	b=FAQdXY5xmSjwhWq7H7Jlg+XqO9nvsVxgMl9abQrtuHrD9S26xI8Kz2dbuZgyJFwclwXR
	 GjV7NpRkXmaLAfMVS86ho/Fe83DK7Jn8B6mAOEw4xS1sHmOLT91fZS5Gt4oKhjE+uuVDJ
	 G4Jk0YIeINWjg80liqqXKoAy0mRVqWfu8RAVftHorB2Mx1T4GpUGFNxns9s0CuJoVGmKd
	 7gakDoaQ79EJsnX3DdKonAHnHCpUlhktWb+X1XfXj/ISEdIs7g5+mVfMyC5jJz7FJVJc6
	 rdJVz0/FP4/RPJwdxY948uTHAH0KzWUhta1kK9SBw9suJbCOF2sKWgzkfpdUXEgvItw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669957;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HOxjTWq8USRbKf1NHRtOCVdwPDHFFHRlSbuWNNCvU8A=;
	b=UHhp49MQFwhHXMT7xgkw1F8CpsEMpl8q07IvZQL3RcEoyww/RU8c/fk5F9yujZszqy3L
	 p32X9qZOLLy0WzIqidtO28tqfqQ2N16G8jbdbAYx4mi/+Ux4AXaNe/gT1xHm/VvYSSV2U
	 cn6YaFEyp0W0hxTdSCHN0kz84iBpYvTNgmSr0bCeECADf0QdqlB7Ep+FnCrcxnvo5fMka
	 B7ti7ak87XM5cyNxK88aLP2s+wgQKGfwhVovv0kvdxTuKuNgl40zJ+O4Tz2Yx53QVmrC6
	 1Hu2XxdxQ9s7lgaeJ9UFVjd1I264PWRJBhhorrXHHbilp5UdMP0h7jHhlNClqJYpbqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uDfYp4CI;
	arc=none smtp.remote-ip=95.215.58.192
Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E66606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E66606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uDfYp4CI
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HNSCS4mk/qPWR2K35tmQ3WR1yx22JuOv+/Tg+3LgkOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793669952; v=1; x=1794274752;
 b=uDfYp4CIMXMT0YXcKpjF9YB3K5YdgLBw4c88NqUHwD/Lclmvn3GyDF3AeYlSAKjVzlZUoafv
 eeyU7b2yNVBPf6u3Uom/s9NH6qbZ1pAgOagbIhnxVGqmo6ypScxjhm6RO97oPf3OANgiusJem7v
 XjHbBbnFksp3s1WmK6Yr2+eM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6da7c6571af7a7ce;
	Tue, 03 Nov 2026 01:39:11 +0000
X-Mizu-Trace-ID: 6da7c6571af7a7ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5a1ce12-2c0c-489b-840b-1cef8cda999c@linux.dev>
Date: Tue, 3 Nov 2026 09:39:04 +0800
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
Subject: Re: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when
 corking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
> after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
> remove bytes from the front of an element. They increase its offset, but
> they do not change sg.copybreak when the element is sg.curr.
>
> tcp_bpf_send_verdict() can send a part of a message and keep the rest as
> the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
> extends element sg.curr, the peer can get memory that nobody wrote:
>
>   old offset    offset    end of data     offset + sg.copybreak
>   | removed     | rest    | not written   | new data
>
> Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
> becomes the cork, as the helpers that change a message do. It sets the copy
> position to the end of the data. Without removed bytes it changes nothing.
>
> Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

