Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752106;
	b=T7RV20ba5dwLbsOdCUmNvLD0jbhs5bg6pCjv4QCCqnVHYT8BBsQM3jkuPz0o2pP892EL
	 yNMdhuYkfsPqJLKI/C7iiRRXmHOi++b0ad1HhxMwUnRnZI/K+PqWXqcymNelvDRtlclPS
	 iCOZH+h9HDkAUXp0w9VERA27lZgoU8XsTO7Nfn80TUzlpx/7tfPNT8t/4hH0kqoxGLzTE
	 gbyhpz9V6Ftg2ECLppMOgE+bYHw1Og+GEOcRc0bztsk+ZxPRauMvHcVTD4ERQ+3Xvx8fE
	 kB8WqZcfKhwiP25o/aOi1J9kOfG9tNHDgOUoQ9qFDfFr1hXiEOklVLXOnT4UU4+U6/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
	b=RFyLGcvrlyhqn/e92n5oo1uLL272Db9OpYCc5wCGN0Vcaiz5n34tvcZqXPbYdqdQfJgO
	 Z7ASwx9Xl64PRPiWuZ/qdrv+HbM2vuvejIu9rLrwz88rnYyu7uLEMQqoKX6QMML0E7zPa
	 BpjP6yP4rFNvrlXSM2P05ejmg3OdVPqysaM+nTo3O+FzKGI67W5R96HTP4qL1WgatPRc8
	 Gd15isE4NmyH8Ul1EXuJBXR6Z9m5M1so0OtJKXT2cdTt8JdD3vcUKZFOwxLlxgEnCO7Wo
	 m0YG//+yQ/D63Lh4s4S25k7LosaWEnGKEqPT7VvoN0VWx9elcjjOd0f0DpBa9hAv7XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxkZp1mz;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599BA606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxkZp1mz
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8fe8e343fso579295ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752106; x=1794356906; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=YxkZp1mz77ojbFPxidaXHQKjUlHQaIgDEy5h4M9t1/S4CoKN0VHi8gjLfZxbymF55+
         aHmiuKgloUrDu+nvzQQ+Sgp9HgHlHjpGtUztVe/SK2hNF1iQBwfOcq3jrx9SmaOWdbYx
         IOP66YHyJB5zeog0zg3fuqBPwdKVBUHzB7aGKihgH51rmVtlY8TE6IWBhwsad3/DU+0r
         A20sej+C3V8QObTb3FNNjAu5xTZn9XLwICCGcPyuMJN68DJbYA6vXUU0pTUVIIbADUZH
         ubicMipElbC8x11tPTMXjtazSoYuI5H4aTutLFCuz0jWDswOXFEBUYU5xcMx463oa1a1
         RVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752106; x=1794356906;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=OpmkJiDHpq3Qbti4NeyVUtPCrAqjU71uciY83TfpicgmLV48XxUcKApbFDhJjmJJsY
         qKW6wmSlhimKvbzvpVSlYy/rPhCDuKtpYevq1AKEne7969qkwSCzKLBft6QMRnPleYAj
         O4G2Lm1hrShHgL/jZIX9tBFJbHgbZ2XbJ8QbM4HAtSrpUZACO+poDacHxKm84Fe10Pp/
         8gtIwxpwYsNolV6HPJCZRJqWUSdJ88EifaJUL8yyweJhVShrtJoNLbuy2Qq/4mqqPoZo
         x5cd5XehpuyzTCLElVQ3xHYoRJ5Epyif2zAsTCvyzYAiLkAMCSmEtIbeOXtn98zpb+UJ
         RHGw==
X-Forwarded-Encrypted: i=1; AKwUvByDC7TDVsYz19bahi34s7SbmMki6zR23F29rKqzz8qwTrUYCH42EFz/5ZtM1W78xFZDLBFL8SU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2s+o8X9R/JeOBnAR1okhWGaiN/G4so9e2IpD4oYBatIGzBfmq
	jvZ3G164vk7nKX6Wp+fZVuarSq6C660mR6gdMkTN0o7cjG4Kd6wWzqHG
X-Gm-Gg: AYBFou2p77NRbJXlSRLDnxtHUJCva1NmUvcQ0ONw8iNmldbw1YpWCsuko52spqY0XRl
	kYV2ueRFtfW0Dg2ljxz6/me3MJCIDRz9oefhxWFFfvkhgD2vgKWrAceN96OfR9GLG9BNmVnXkav
	IB6q/LWOf4lfVYSl1qu9P7kFJk8BXsmdgbLoNxAEU7qggLcMhZgX3YYjaSgSibwaVYQFc1HgN9t
	tL2Puc2fxTsXLAslsUHM3caSY1xkroAsKS0vLiICN5Hnu85OhXKDp15Gydomeokj3e4fdlYShjg
	+GwzVXfecYz4Lqq5oGHPs8tCuZRNR+/LSidrcUrr4gM5omMDj0HIPaYbAu+0/uVMNtokXSFu+jr
	h8tSigOQypIMAD9taEZmQdlfz1NtkZjGiLaZJmHqzopgfNJdY3uQ8korHNQ4uvfQXXPqGg1nLAP
	T/LDh+UE3GAQIxKptiJ6goa97yOuTDxa0+Lep4vgnFQ6B8wNoXwoQUqc1uxMaZa6uglEA1ShIQi
	0/LVFFGdoLkKyZ1FJfJTZ6mcrB4IRs0ocsTnFV3NqR5v/TIFCB0YiVAe1nHd1G1BOkEsrhQH1ZW
	zmfzqL1EJt+JseaUTv7+rWQT3KXDTXVVYHdncWodJpv8skzf8jgBhqoBMfdb9Wfy+Y7riDQ2IG5
	UAUi+vTygn2iAyh7F60jvoW/bHsp2eXEQeA==
X-Received: by 2002:a17:90b:2741:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ae897b955emr11276403a91.26.1793752105586;
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1165337a91.1.2026.11.03.16.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:28:24 +0000
Message-Id: <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187706.488855.8366350890804573396@kernel.org>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org>
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

On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>> +		if (!psock->apply_bytes)
>> +			psock->eval = __SK_NONE;
>
> When psock->apply_bytes is not 0, eval stays __SK_PASS during the push.
> The budget is still debited only after tcp_bpf_push() returns. Can a
> second sender on the same socket still get past the prog here?

Yes, as today. It's already explained in the commit log.

> But B's message is sized against the budget before A's in-flight bytes
> are removed from it. Would it be better to reserve the budget before the
> push? That means debiting tosend, and ending the verdict when the budget
> reaches 0, before calling tcp_bpf_push(), instead of subtracting after a
> failure.

No. That breaks the single sender. After -EAGAIN the verdict has to
cover the bytes that the push didn't send. A refund after the failed
push can land on B's verdict.

> The shared-cork problem with two PASS senders already existed. The kfree()
> variant used to need a third sender to end a byte-limited verdict. The
> early reset makes it reachable with only two senders.

yeah. It's an old bug, not from this patch.
Two senders are enough today too. B's first message goes out with A's
verdict, and the code after the switch resets eval. The prog runs on B's
second message. SK_REDIRECT frees the cork that A still pushes.
The log of patch 13 says that a cork is not safe for two senders.
Jiayuan proposed to serialize the senders in the reply to that patch.

> With the early reset, can sender A's bytes be charged against a verdict
> that another sender installed?

Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
a thread. B's verdict ends early and the prog runs again for the rest.
