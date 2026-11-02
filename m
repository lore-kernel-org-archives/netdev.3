Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645421;
	b=azLHcFi4L6lez6YzMzAn2F6/V0jZpmo1zbg7+X6UU6Bp8Ezq7mmC01rOsZ2Wt4BPbG2N
	 r1Bnbx9QrdDO6X745voVYqK5bsCz4nkSKMQ6eZkfuq59UFLDd7BqC8zQYoxXEq5AP8a8m
	 AdUSl+ZnsYrau7Vwn06oPXazPd5KnS8yxt7ohZXN5KXT2Z5pXqeQjW1UiZ+smcjfhulE8
	 bSpAf4ownVtnocb3XR5ZJYd22EqNTPze3ZdLqEpZCG6XQr9vCJHligQmoYuQBmL85HZqi
	 IiGwX8aOd7wqrsUXKSrGYMnMiKGaXWQv5Q2XJH7CNSWCONf0pbh+C8rJl1/7nq9Y7Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
	b=qemNtz+t5XVU0PKi4aRT+pf81jIrMTLKgajCMOH72gVr3dPm9ctRNEWJ2a6RmK9XfVx3
	 EslUgYjuuESr4Gj7aUJ/Iey8Oo+ARSRLelpwbGJgbpJaopi1rD+uOR0/vK1mwuA60izJI
	 OUfOu6pFOlzXJQaCFJ0x1dilqVS6yMKdobDP632jPkD5wnkyPI9gf4q6JVKbLS5Vo9Eek
	 EdPH4AWv/ncER7tOU0he8cmg1UvylIFeO7Iya0o7ssJpt0aaKPqCFW1LLeBr5vk+uVJIh
	 +CwnHwbDoIp/YU2zTor+vpLRtcnb9xwYZviJQR/BolXnIH9eyZNoOfnThbVHTtBsHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p2+Piy3s;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B3606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372B3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p2+Piy3s
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so5037636eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793645419; x=1794250219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
        b=p2+Piy3sAooPGQJVbNsD99Y816ezaXqpod5YbnBem2fq6wIOuOW3ZsHW+jNTagbfZK
         JPLSW1xihm9pdnsrcrPQWoNmVok3fvK+cX27K8SeproOZJKxvtn2pObWdkr/aTJavyHc
         fYp5snY7hjz+rKceH+kTDA+BRVTkaashLjqQVUQSU5IdrcxIGeuJC21uSYb1kbYJnU1r
         Yi829yFsVjhlbCPauZzn4kXivWq5mfqJziwL7B1TuF3sW0ubsYV1bgkSVy3Os7vDgGhJ
         xX8OPMnDDNxuS5ieQVzgpNHuiFHFXu9XCasJ3nyqMX8VVzG2z2EjYhDpmY6i7ba8Jo0H
         ZcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645419; x=1794250219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
        b=1NlWPMc0F30vQ5TsgPL3E+fVr93+SDQWzdYqR5DbaLPUo0zsLj42Cc4ZlXmNMMDMm9
         TyMfpBMQKqdKROeMzLyptLd6gTDeiCW+NsJsXBRY/YGwN35nDQqdGLAzB+FlgU6LMX1M
         EoxsCJJAJDgvvetnNgZ1XA0x314eTqntM2CvtOCdjKvEAS/hNFNJxLsgsHabmgCzkVT9
         Sr8v3XbqW88FHn+YZjDrntk1FtDvthgdt4j5EK6dXw/MxUYxjx8CPIrKOMTlpM6TBi2p
         /mn7WYFhYiFQiMxA0pxcbraDVYvZ3vyZwrrBh6MGUZ6MmvI9mKIgFs4kvV1eMXKwzzYm
         54dw==
X-Gm-Message-State: APuU4Z99dY8iQRUTyhEglwgeO+uY8Ct5XJE6ZWuqptikqoOYnnN9Qh1Y
	C1LZN2+O5Xc8APXxw0fgA3hJUn2BVGrthFXo8PFdUHnJIQ0jevJqdvqlCVR4RMSa3SgueOXhvBi
	0IFgcqdteD6td5dbjMNI/lvZGRQIa6Sb31KJHuRlTUPHCAczOw/TSb/Z1yyhXSVuiPVKktzZ8
X-Gm-Gg: AYBFou1zJUFbC/dVDguVsapiJeAh8XXAS36NL8uLFiKyXjPjLMI2cnFE3IQnOKD6HG9
	zYbDJaZzuWxtnKlgK+F2pAzG6tkGMXJYsRfOBG4uv+1bokdNg36/+7jXbqJSokEPcr2xH/UrwGI
	0A5WDrMQ7NcIYWRWYkjaiEX9HrI6JPBZPhYx1doL3yrEcQPcfo9OqC0C9YDxYBxPgVk9n5C5qx0
	7NNSzNNioQnHcSk1KHls8+MVCiVCbLBIr73xVTEElW5aAEiwRA+ArIUdCFsK/HMzp98CtZpt87M
	DRXvjbRwa2KkKPEs3qeUf+b7EAPpk1LaKBkAZI4dS+uLlavBMuKqWQetI61aHx+Lh64qUkCEIAn
	OjL9RFxmEOdW4HknK0YmatL7uSJmxWTUg6S+COwD7Tf6fc4C6bSLGiDGutO8shsbdGpSz+EBMK8
	APxxA4gV00dreVqJerW/o19WDQXmLKGqdkr3S+MiUXbGtpZKpJLkh1sPHW5GH6x76VV8ZEDqRU3
	1PbhLIhf8ttIAhsCYLTHEEusbXcv1bwKdDE4PgcRxFdNLQELTQaS8on0j/4TPWufFFgdIQuaYmz
	48Jr1NBYDYyQKpNCh6ZCT2X2dYJ0oI1J3DnQ5exq7A==
X-Received: by 2002:a05:693c:41d9:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a4242f5fdmr16518897eec.17.1793645418844;
        Mon, 02 Nov 2026 10:50:18 -0800 (PST)
Received: from localhost.localdomain ([174.136.204.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm39651738eec.13.2026.11.02.10.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:50:18 -0800 (PST)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly queue
Date: Tue,  3 Nov 2026 02:50:00 +0800
Message-ID: <20261102185000.2384364-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
References: <20261030081225.2575462-1-edumazet@kernel.org>
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

On Fri, 30 Oct 2026 09:12:25 +0100 Eric Dumazet wrote:
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

Another data point: the described trigger also requires ip_defrag() to run
before skb_orphan(), e.g. via nf_ct_bridge_pre().  In plain TUN local
delivery, ip_rcv_core() orphans the skb first, so inet_frag_reasm_finish()
sees sk == NULL.

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

Tested on QEMU TCG x86_64:
Padded fragments traversed tun_get_user() and nf_ct_bridge_pre().

Before this patch:

  [   62.400852] ------------[ cut here ]------------
  [   62.401690] refcount_t: saturated; leaking memory.
  [   62.402231] WARNING: lib/refcount.c:22 at refcount_warn_saturate+0x74/0xe0, CPU#0: init/1
  ...
  [   62.416741] Call Trace:
  [   62.417754]  inet_frag_reasm_finish+0x734/0x8c0
  [   62.419460]  ip_defrag+0x149c/0x25d0
  [   62.420502]  nf_ct_bridge_pre+0x95c/0x12a0
  [   62.423684]  br_handle_frame+0x6d9/0xf10
  [   62.425568]  __netif_receive_skb_core.constprop.0+0x576/0x2bd0
  ...
  [   62.430759]  netif_receive_skb+0x7b/0x3c0
  [   62.431822]  tun_get_user+0x1a1e/0x3a90
  [   62.435183]  tun_chr_write_iter+0x138/0x260
  ...
  [   62.455272] ------------[ cut here ]------------
  [   62.455348] refcount_t: underflow; use-after-free.
  [   62.455376] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x9a/0xe0, CPU#0: init/1

After this patch, inet_frag_queue_insert() returns IPFRAG_TOOBIG:

  # tracer: nop
  #
  # entries-in-buffer/entries-written: 8193/8193   #P:1
  ...
            init-1 [000] b..1. 44.803126: frag_ret: (ip_defrag <- inet_frag_queue_insert) ret=4
            init-1 [000] b..1. 44.804161: <stack trace>
   ...
   => ip_defrag
   => nf_ct_bridge_pre
   => br_handle_frame
   => __netif_receive_skb_core.constprop.0
   => __netif_receive_skb_one_core
   => netif_receive_skb
   => tun_get_user
   => tun_chr_write_iter

No refcount warning was observed with v2.

Tested-by: Wang Zhan <wang.zhan@smartx.com>
