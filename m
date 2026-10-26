Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979506;
	b=BPAH2zDCKd4mtkNrvrX55Z4roLr88uqA9CokH9zoK68HXfO7rsPcFxiowouuEXrW18Kl
	 +0uaT6NvbVFzHQ/9iZdir95/x5BfXtVGHfw9hPER4rwYCbFDaFqe6aYS6RixTLQ74KHRf
	 VqstapREo61CH1s9gXmfFoZgLw6p+tL/m/zAUFnkZLrz8rd8zseUU1qI/VH8OOpzh/Ufr
	 F2/lFSeKXgsnyz3dh2OvI6a5GuEvfWVbBzoZHtTpWkpTK2vQ25kjCgClakBD0vmdIrsv8
	 91LQFNzhgYgTPo5uODHeW9opRb0I1e+vFzwRKAcqGNK6Z/UOfNGQhA7WS/OWsoRp1AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
	b=1n/GK26DYNj/iRdZt2f1+togn3hr+B6xhifwiD3yPmjgT70sIk8RQZPLz1GbvThbCQwg
	 oXAxzfPWOOqqopPx3wIQwuYFG6eIHA0dads4kLLLBfc5lDYv2H/PccKnSP53XLb9ra3VR
	 W6eXOZOt6ULJb9wCmAabb1kTl7Ie5EvP4XUa+fjPTkRLEvciAiL+GAvOdize7WaOK9QuS
	 NEG7X4GbfeduX+yohJ3I0h454aTzDlaQN2IeQNYQ4wTamy2KMLjI7dywQhnmKKK3/v2nL
	 bzHLaivuYKPSSS5vs++4zuVV5AV9r+mnP0cbzvsTzffQnnjDazHO0rHO44rz1IgkOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpYYbdm4;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E7606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpYYbdm4
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1320801a91.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979505; x=1793584305; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
        b=kpYYbdm4UIaNLa+4gA2O6vViuDhEEOp89PGqsr6EZIpTsN4tT9rOukWJvOxKhiMzeL
         GZsL88QdGFZkEGpbWgmYAFWisgtS4+VmFYBxz5F/QASaNM18840QlkwDndtICLSkDsYT
         +wm+sqLmhdtZ0wQYO/YYpFSkRwbXYA8hTeJsttvMdEb3hJ17KHaxACnHIddAhMAUVsc8
         zMiQZ/e/rOloj5PbH/wf2fzd0LKgnBXs3jpJ0hLVcoXa7yWfqzFCfpgz9PHDRvw+ZpKY
         9dQj8TE8BR25EYre0sIPa9V9z1wBOa6KnuohoN8g3q6QdscMbq/p2/JPiJeBQ9mgjIk+
         1qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979505; x=1793584305;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
        b=gGftgq9nvjMqFr0E9gSWcseieMQ4kwT3OFBQQCF8HcCZThBv1sj9Tc6l+kvPJRQBjr
         H9I/6M1gyB0BmVV7sI88WUbQzZm/GIMaigjv452kN+hMm8UFZnSevBxmwpM8osL7954O
         htHMezZ1t3/ynGuUd9ZAsPW1qHf0tUm7MboWx7zPQlv0ETvZ4PO3zBtGqvLJ5k9zgwTw
         COBkjPestb4iYdao4U/lNxTms3G2pZ+RuBRBMI/2BTQGSn+AEF4iZNg3R7sYNNaDsioq
         YOi/it9/O1W7lPm1XwafvNDSFvtXNRPiP+MrHH6gmbcOwCYCOaGebjAO5KbRCl4/zQNp
         OYvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnP6d0EBXWS2frteZT3S1sc21Ju4oNqcpHlSLhYt4PQjWRlgp86eByeusV/eOpsPuvdeUpAN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWy2Rt294mqVAvEwndWUDPY7BViUVdWwyRt1B9uYYIKkkkd00+
	/qrA3wAdDj9YeBKoK+ArmStl2+RFHHOSoAJqC3vQcbm9iukGkivL541bSF1ugg==
X-Gm-Gg: AYBFou16xD3T9zurOIKPDjOYo/pUIgBVSl8F6NKVmKVqz9QUWtQN2+qEUVKS44p4TJS
	xXmDu1iC/ENCvvEpH/0EP3qX6ZBdaMMJgrUQrCYZqTEN1Bb274AlXwBvxWsxq8tTwlHmTQVD9Ty
	4/c5dtziEsHCzzWkxlzgwEKmOtHQg5Z8UK6YD1v0qfX7PiiRpkR5DqaFvnWvMzPfrN1if8pj//Y
	Zbf/7oRi/5aClYiL/mdjiK11PXGQ7U+fWrT8BgolhCVJY5fwbzf9ot/mPofIzA8XEKqxXYFzYGh
	IUBYoDqkjzfW9LOBIZfzjRl2vk8vfcPQsvNOWdjaAezEzL27xiKzpk9XwWQIngaKC8hv8vShwKA
	KP+aMCpAC9GIt5KQfNstFveaM+pqtQmpbi5sRaSSlrCLwww5iSELel0HKMTDdjBopvSuQgsaCLk
	EgJ2MrgUgmn5V0LyPjqQ+enl09BqPKRnPr71WSKM1GYcdVT7UbapznpoInv+lhU3jovBL4xQzDf
	Smvp0KOLNYiYXerWpUINhE25yStWJ5r9x6SLynvw2ZjO7x0WmkpT1/YzGWpzXyf8OJJT3tBfYdz
	/DkYVdcbs+IP2rLv0I6/zD0crV0IRMQaMo9zUCPQyZ50gOWU/X8EMQoHOsaDCw==
X-Received: by 2002:a17:90b:17cc:b0:3ac:a5ff:2cc3 with SMTP id 98e67ed59e1d1-3ade9b2ff58mr4868899a91.8.1792979504834;
        Sun, 25 Oct 2026 18:51:44 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm6281205a91.0.2026.10.25.18.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 18:51:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 01:51:43 +0000
Message-Id: <DMEE6SW3UE97.2DF11HBEBKYYI@gmail.com>
Cc: "Geliang Tang" <geliang@kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Stop reporting EPIPE on
 zero-length skb redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <kernel@eliskeggs.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Cong Wang"
 <cong.wang@bytedance.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com> <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Oct 25, 2026 at 04:41 PM Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org> wrote:
> On an ingress redirect, the empty message is still queued as before, but
> the target socket no longer reports EPIPE.

That leaves the target broken.
Nothing dequeues the empty sk_msg. __sk_msg_recvmsg() sees
sge->length == 0, returns -EFAULT and leaves it at the head of ingress_msg.
tcp_bpf_recvmsg_parser() finds FIN in is_next_msg_fin(), returns 0 and
does copied_seq++ on a socket that didn't receive any FIN.
So every recv() on the target returns 0 and moves its copied_seq further
past rcv_nxt, and the data redirected from other sockets stays behind
that msg forever.

[...]

> -			if (ret <= 0) {
> +			if (ret < 0 || (!ret && len)) {

Lets skip empty skbs instead. That covers both directions.
The socket's own FIN that goes through the backlog is not queued either,
but SOCK_DONE check in tcp_bpf_recvmsg_parser() returns 0 anyway.

Something like this (compile tested only):

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5..a5003c7 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -711,7 +711,7 @@ static void sk_psock_backlog(struct work_struct *work)

 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
-		do {
+		while (len) {
 			ret = -EIO;
 			if (!sock_flag(psock->sk, SOCK_DEAD))
 				ret = sk_psock_handle_skb(psock, skb, off,
@@ -735,7 +735,7 @@ static void sk_psock_backlog(struct work_struct *work)
 			}
 			off += ret;
 			len -= ret;
-		} while (len);
+		}

 		/* The entire skb sent, clear state */
 		sk_psock_skb_state(psock, state, 0, 0);

pw-bot: cr
