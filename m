Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671111;
	b=0lIcaoEBybNqWJK0DOVEOoix1+qx0apVdMGgdxHv5a3ifhTKW3QUI5FccTELPr4Nq90m
	 PVFVTcho4GwLWSwRzt1gvkGgNVWDs4pfoxX4YUDkrmHHtRuidsU+D68SNSbdOH2Qh1Kxa
	 XvBmN5QwGwPtIJzFmeMuAbybYS0qvHhZeBPCRYYSM41J9Y0MlZ/Sh/uLu4XM+f+Gmiefo
	 IPk7EFF0AefRmZrgjkRO5AJ1BZL25m/cghJa2y177EU+Z1Bih9z6bJ4IZt3aBzPUBe5k3
	 e+xLTKIKH/KephRbDBxQvlzn4eckpsh6UdZysIJoOqbTXdvZE14kL1UwBIxmEaOioYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671111;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HvlT1XjrX2pqFLgxdO8FZhy56kYrtx0Ju6Likqq4/Is=;
	b=1XlL1ajt4ooCM96sEdVtIPcXpqZ7Zda2jMfH7rPXvvmlGCKb9H4r6HxtiG2DbOkfKgxQ
	 T556BMZAoRYMobJmgUKapr97u/eRpa6IlPv/RfwIHuT6baJC/S8pWmBCgjx8zgINfSVTq
	 mhb8OFaL9lS4Z5JzOPZHezDZHthUE8qpttCAQe9hKu++/sJY0lEboUyYbpABjv9VgHFUX
	 dbYXtAQDJXALCip/wEGkbjLwmLHjjys37N3TDsPALCkBcRZaM85821svK9j4fanVXha6A
	 7i7nWCNr4sxeVlqaV9Um0HD/QqmwmdXzDvqNP5J9sMxFStKUHSshNPSTJeFWjDQWXmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.134
Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5F606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F5F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HvlT1XjrX2pqFLgxdO8FZhy56kYrtx0Ju6Likqq4/Is=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793671108; v=1; x=1794275908;
 b=uRZEuZB1MIG+JrUSRpHgvgMdk2c68Q9U6xzmblMOr/qBg6NjJznPDDiqjHT9QLEmfwar2v3n
 7JcO1hG+c2oycIWr7EgKcKhD0yqkJ/ednaDBOvX3pKSLezw/Vj1plVphB51YGhB68zvNGRG6Fmd
 gSVFl3JRUETARJpNkcEzjjkA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fa320ababef1ed04;
	Tue, 03 Nov 2026 01:58:28 +0000
X-Mizu-Trace-ID: fa320ababef1ed04
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d684932-998b-4f78-a445-79f07523d600@linux.dev>
Date: Tue, 3 Nov 2026 09:58:17 +0800
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
Subject: Re: [PATCH bpf v2 12/15] bpf, sockmap: Clear the redirect target
 before the sk_msg prog runs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
> reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
> redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
> again on a cork, and on the rest of a partly sent message. Nothing clears
> the field between runs. Thus SK_PASS without a new target is a redirect to
> the old target. If that sock is already free, this is a use after free.
>
> Clear msg->sk_redir before each run, as the skb verdict paths do with
> skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
> sends the data on psock->sk. Then sendmsg() can return another value. A
> redirect that applies to more bytes uses psock->sk_redir, with its own
> reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.
>
> Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

