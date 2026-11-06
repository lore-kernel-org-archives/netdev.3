Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976924;
	b=StwTN2yc8A/DH5OdDZ8cW5EJhcQv8jHGvIdeHf1Xl4HT4BubQA/NeOK76IMI0Zx8ceIK
	 dcQyzKEiDb/qWzs2QAp2WfCw69sUgbrkoy57fNoPfSc133ZnRCHvrszPyT57BMozBDMTt
	 qMoO12U/c1ktIo51EI/6Fj36tz1+RbvDzZOuFP9t3IootqTTbtGVINAG/khiFczDRXlJG
	 Xk1P2oUg3thTyEhezoDU3IlxOuoRt1drc+u/rtX+Iq0BVB449pkCKC+y52oCV8UItgQo6
	 IAwkgMTMe+ECyfDfp51Zc4IDy8UcMs5afj3702jGSiFE8Yd5xZLFvfKS59IIQhqLTQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
	b=WSKLbP707inkZHQg2Mae9GJkfz4EQxOp11v/BbZsu0dgXaf86LjPH1xgwORrZDEuSX/F
	 gez7GLXyXQWS96pOnib/ojTj2/Pv+W+xvt4yL5snwPBood8p+j8AZUP9vDDwlB3/+Y4/0
	 WwuoZGAD0LacOQN4s4V/La6/u/SXUjG7F/2PwPQQN0731LUJuEcf4pOJ16JbE0l5h4Two
	 cPI/jTFFqK3OsJRpaVMJff1ciT+KPPmvJATpE/MR+0WiGPPe3QBEoUnkWNAfMVLZPed8c
	 LlhnvxqVZcvRlkXdv9eqsrpTzES8XXbOvGWYRggHBP2BKuUyOwEbRzMP6xGQZY9xzGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvEcq5EW;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCA606A335
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFCA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvEcq5EW
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so444821a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976923; x=1794581723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
        b=pvEcq5EW5p5RyHhNApIpanjG+XM0py0wkLCpq1Xoa3Rz+fpzGcOAiH/VQsXsemgM2S
         9/PT4v1X1PrWv/6wko+hr5538Uzoi1ZxC/AFsLOhd+bY+DRPLkKcZleqOOGtCDQoD8M1
         mM+eeXRYItk6md6ykyYNeDjO7DnyXRssj+9poenaAlETqHqgC2ei9cd5PQGhXJvEHMpk
         kpIkYRIWkVJQf+Vzm9fgwIXNAbdVd8ZfceNtJOW4YQRZKD/LlADYQsXXuNKPzzq4wbV4
         10BaI/kiV81y1PXRDYlGI2+oI5LvaqZsbIOBT6KGXLMGbic1FIcM+oW6WCpBUL7XCdmP
         vB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976923; x=1794581723;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
        b=0+IQeR+zQxE/MXEWJHLN9ILKkx2DnhuMboofdAOF2AwBXQFR/jmEPTdi7clRiPUw3Z
         Re6OfPfqJpqYfETLOiYtQQ7N2i/41FYQc9oj0bFLEl0RWeWT7OBcqL1IJMNvbpp2z8ru
         dBmcS4+QiBz60dZP1Vze7fnT0cy9gAz53AUbsl2XLEHseGo+qkrVbVAxtmjCS2Cw4W6M
         Pa5uny5NSThT01Hb3hoF8srJH9Cr3oHDresGDl/PRcPeUhfEbvy97PY8RBV223ktgrAH
         8z1inZ48ifWnSdfptz9lmDyM/mwKMvr8lwWZwW3ZXJnSlmZAArwWfRGFsdSkmW4srqvJ
         FBCg==
X-Forwarded-Encrypted: i=1; AL+hErFI2Pq/i02EeyqCrc61vWatC0sHBaeC5BkwEczzc0082dwcgSf9iV0Tkla2DVzbZ+3/NBdI0os=@vger.kernel.org
X-Gm-Message-State: APuU4Z/orv8L2YkSw2GwwtMbu2YaxMo/4F4+qs54+bg3ctAGbMpnvJ9r
	kS0mrG/DCrelq5tbMMZ65H9S1tjn7JrQUQL4mGRFZRXU9VniGbUCmfeE
X-Gm-Gg: AYBFou1MMdwAjIPyN44f6dWO7TnkZf+UI9h4gWoWarph1bB0MfC8WOfcEtDC7iU2pUf
	UtXUmNjiHFC5eVseUMm1okKjZ2IHJQKw59N2XgAxRgxuCNrAkZvj2UE1eJGeVfhHwySce+96Cmz
	2OVMvOuNLfpsFlBBDl9NRRhIxJnx4sCulpFwx+foqmbUhTSqp23L3t3KNUQb/4VDP63ydwPItAh
	4C4ELwWBDasvoxhL8gLMlV4CmsfMWyBXOsY0mPTENhyqHWQ/4W0u6VyzccHFjS4OLlU5Zqw5SGI
	24O2Wiq9X0AUdOs/AqLpPvmMXAcVeL6bYCXBNlno0iM21dKpNhy0+LffSNi8o7VNkMu4VQGhWzt
	LOmya0PQqQ9C9jgqq0r72WmgLRBCErxAlacnEpZfUOvCEtlQduhYykhwT8yy/dPOSRioHk/D5pe
	SfMJadAR3HuWuI4PIwJIJAUkRbzXLYqC9ltGQhp+ZhP/wYqe19smxYlRXpDAdfQCu5zwuKws/8B
	fUYzosu6h9FUnI77++vWJwJ3jnr2CKXXFkG4DYwkGLBRXnjNnPMwXMBaiEqXSwNknhVCPkIPjWm
	VaO0RE5a0Mw+EK9qi/Sr4TJlD6mA8zCG0g6FXvSadK5RtnpHWI+h0hM=
X-Received: by 2002:a17:90b:2d85:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b0db700c35mr2482629a91.64.1793976923367;
        Fri, 06 Nov 2026 06:55:23 -0800 (PST)
Received: from [192.168.255.10] ([111.55.212.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42a72sm3783225a91.3.2026.11.06.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:55:22 -0800 (PST)
Message-ID: <4c5e04a6-afba-4f7e-b790-c109ddad0318@gmail.com>
Date: Fri, 6 Nov 2026 22:55:10 +0800
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
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket
 insertion
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
 stable@vger.kernel.org, Lin Jiapeng <jiapenglin@tencent.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
 <179397371960.488859.17332481477084448537@kernel.org>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <179397371960.488859.17332481477084448537@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-06 10:01 p.m., netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


The issue was actually triggered, not found by code inspection.

Reproducer outline (unprivileged, uid 65534, inside a fresh user + network
namespace with net.ipv4.tcp_migrate_req = 1):

   1. Create two TCP listeners in the same SO_REUSEPORT group (one is kept
      hashed as an anchor).
   2. setsockopt(SO_REUSEPORT, 0) on one listener: sk_reuseport is cleared
      but sk_reuseport_cb stays attached.
   3. Repeat connect(AF_UNSPEC) + listen() 129 times on that socket. Each
      disconnect goes through inet_unhash() -> reuseport_stop_listen_sock(),
      which re-inserts the same socket into the closed section until
      num_closed_socks exceeds max_socks.
   4. The 129th insertion writes socks[-1], which overlaps reuse->prog on
      x86_64. Attaching a classic BPF filter with SO_ATTACH_REUSEPORT_CBPF
      on the other socket then consumes the struct sock pointer stored in
      reuse->prog as a struct bpf_prog *.

Kernel: v7.4-rc1 based tree (d68ce4e71248), x86_64, CONFIG_KASAN=y,
CONFIG_UBSAN_BOUNDS=y, QEMU.

Symptoms, first the out-of-bounds write itself:

   UBSAN: array-index-out-of-bounds in net/core/sock_reuseport.c:152:9
   index -1 is out of range for type 'struct sock *[] 
__counted_by(max_socks)'
   CPU: 0 UID: 65534 PID: 22 Comm: poc
   Call Trace:
    __ubsan_handle_out_of_bounds+0x91/0xa0
    reuseport_stop_listen_sock+0x290/0x310
    inet_unhash+0xd5/0x400
    tcp_set_state+0x125/0x260
    tcp_disconnect+0x47/0x1950
    __inet_stream_connect+0x2d0/0xab0
    __x64_sys_connect+0x71/0x80

then, after SO_ATTACH_REUSEPORT_CBPF is issued on the second listener, the
corrupted prog pointer reaches the RCU free path as a struct sock *:

   Oops: general protection fault, probably for non-canonical address
   0xdffffc000000008e: 0000 [#1] KASAN
   KASAN: null-ptr-deref in range [0x0000000000000470-0x0000000000000477]
   RIP: 0010:call_rcu+0x10d/0x260
   Call Trace:
    ? reuseport_attach_prog+0x6c/0x140
    reuseport_attach_prog+0xdd/0x140
    sk_reuseport_attach_filter+0x97/0xf0
    sk_setsockopt+0x973/0x1cc0
    __x64_sys_setsockopt+0xac/0xc0

   followed by "Kernel panic - not syncing: Fatal exception".

With the proposed fix applied, the same reproducer completes cleanly: no
UBSAN report, no oops, the SO_ATTACH_REUSEPORT_CBPF call and socket
teardown all succeed, PoC exits 0.

I can share the reproducer program if that is useful.
