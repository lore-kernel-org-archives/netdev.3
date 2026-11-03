Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670123;
	b=Vf5/G5xi26ywkOEnH35eB5x01WnP6bXK1MHtUdBdgTPd3zwX1V3xEc9JbnlgEfhDbUG8
	 uQm4rorkbMKq55vOR8WQTH2I/wIROZ2ujAsbcb5WLSRd2Yc5snVY4P824CikDupugaQNe
	 GGRI0TjEBhsq7mAr9f3FJZnFKb+RuCZrUvoaRJzQb8G803mPSJ747qJM9tZCZbo6mbv6b
	 rek2cVwdX19jHilGhTu69BFek0tXkkwgOQIa1+eeQ60uPXbC9VYaMr4+GbyPikmhfV2pd
	 VQig3h5+XfWaantTkfyZein3WfSi1RwuILZvWagf1zUkXwymlPSOncx7A4qJzD0hnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670123;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dGnaZBUj0XNcB11772fHKRR4jnMCSTKoOZ96EtQkLP8=;
	b=QGm9t4D8eAbTLxdNMwDQDlVXwNOcmirwR5h7oFb6sj9l2Jpg2ZLZhO1YbqhaiE20wJb0
	 yeWWEfANZzij6w0GIw7G25PaxmMs52Uzrkpz7vIqv3tyAVmhz4u/9mvpW4asMy0aMk7r3
	 G8NOkBPkFVhGu3BPAp4SWVPkLDMZ8ZWTIaYcQaq/D5K6TNj5jprt66PxtbDPh5ud/ZWzU
	 aYv18NEbdg1F9INz+Vmo6G5rpeG/Ph3ljG+/4PG+n2Vkb2cEwsyMIKgfSPP5KTmpOZADG
	 gmz5PV/LkK59TIly8HZb0ty5BRro/GlZz1k8RRNGr2OVjGpYUaZszvDJUkmxAjEM3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKH70yEb;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DD606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F39DD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKH70yEb
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dGnaZBUj0XNcB11772fHKRR4jnMCSTKoOZ96EtQkLP8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793670121; v=1; x=1794274921;
 b=fKH70yEbYDywQGAwgfKSS+FjmYqpdNjx/QAS6L7HT/xmTPtjFKacyw2MbKh0akpklTS9OHgd
 koVAORicRuRu3tQLsfJU9vw1xGIoAAdyPRjlLZcrpLoB9v3kYqa4Gj0jnTKUox/RvMJ0oLPNMh6
 k8yttt+zw5PAe78xF3bDXib8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4aed7de82dbe24fe;
	Tue, 03 Nov 2026 01:42:01 +0000
X-Mizu-Trace-ID: 4aed7de82dbe24fe
X-Migadu-Flow: FLOW_OUT
Message-ID: <f64dd211-6449-4522-92e2-af1d5f238f73@linux.dev>
Date: Tue, 3 Nov 2026 09:41:52 +0800
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
Subject: Re: [PATCH bpf v2 11/15] bpf, sockmap: Don't copy 0 bytes into a full
 cork
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
> sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.
>
> When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
> flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
> nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
> fails without a flush. sg.curr stays at sg.end, and from there a copy moves
> it past the spare element. Then a copy can skip the first new element, and
> the peer gets memory that nobody wrote.
>
> Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
> does. This pass of the loop flushes the cork. The flush empties the element
> at sg.curr, thus the copy in the next pass starts at the first new element.
> Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
> less data than it wants to cork, as it does when a part fits.
>
> The first Fixes tag is for the -ENOSPC without a flush. The commit in the
> second tag added the spare element. Since then sg.curr can move past it.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

