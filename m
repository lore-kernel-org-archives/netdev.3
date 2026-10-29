Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290249;
	b=CBhx7qLM20LjJPoQydK0YdpcmTf/vYjtZp3+U50gCZotpvSg7bMq0u3+suvVQw1kqtLe
	 CTdxPPsmc3Cl9JzNyMRgkIhIwoofH6x6A5BhRI1aPTWl0Tf1KTmtkfNqRlyPduqFMkhME
	 ZcO4Jpg1VbMQf+s7Fw8ASTO3NpoKxvb3b2Y9jGuodYE15zKb3fwd6YQf4tS87uH7CYrqO
	 XGcwJR89AalHjW6wl6dM8vKhmj4qqB3Rm0a0XMFo2aL0wtRJs9pBdut4l3iCegtHHsvwI
	 i2oRH6xGSNcFwPTQLV69IEPl0XwFEEElW7PGR70akyPJNKScU3L8/WbxzCr6ps3N+5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
	b=SmWii1vkmxo+yqlplWaVkKU23efasaSyodnGEXsFDTl1nk2d+H8h4Pm3Q+lT+SDhHKWn
	 WfNx59726lZX5fGvqM9cKuFLG15EGJG8+GFyvDKbPFs1uHH73bmtYHZTmrsEoWo1ctXC0
	 Ws4LfYBEziat0g21/7krR534fWPExKTTeHthS4UYDxoU3P2z91NeJV8EVvwzYzkZNbYyS
	 c1/OGREuO06sOVlS+Yv2tlCeCNuYy2StcmEEFDe/uagg8jOr5N5hPSjUhaOaekPQFlgCG
	 Zoj9Ke4mJSt9tg05i1mvbLgoGWmI0sVJ2+lbd8yAQnJ+H66dW5CC3EUiTcztoD/UUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQ1HgAJB;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B11606E017
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B11606E017
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQ1HgAJB
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso311727137.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290248; x=1793895048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
        b=BQ1HgAJBM52AsbQ7tfdFq3gPd99w/14A03ldC+9zCPotdgmBElhQocOdv+zPBbopv3
         /sSlGYpgzZKxyUuURLiPcADtZ+/2b/+asX33xRM9nkV7swnjQ1JGfho3PNwvXQaAwdJm
         OMUAq+L64oXGkKt9nBn83mEEBOjFSMoK8EVw+KnQS0okrCLOFV+xdBozRew+RlguxgDc
         PBvEba/FY/XCihapa3YmOuVXiCd+JkdghOGo6l5oGUnyWfiPXd8kKr3RimsBeLA5EWSj
         M1/wrs8KDYq46uodupnIcnbtKpg/EVX9S0WuBAizCBQnHosJN4Go+QXM7K21B12ID/yr
         o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290248; x=1793895048;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
        b=WXWmUYFepxhgdN/V3kDZVkWxDKjX4AzQBtZhUOdtXpe7+wjLNe7UAvyXdAwUQFS1Pt
         i1EiDJuVV68N5FEr12EX23AX1jLxFLPegK6VVuJbG2f7RPfw6u8XAPczPJbKE5cChxV/
         Kyf4h9eapJJ23SQVVVEUpDqoqQcF0/NX3MUflima60qzDyxxI3p6i6hMH3byrztf5Pwp
         dfoBqxcwZdnQSCUj7FYKyQfmDzOH5WOm5vkBwKsb/JDcAKnah7jlmNZQc79ei14er+dC
         ZW8FcdDE0I0ID/GzwcBCu2cPe3h58Eduv124QH717blwVDW1Hun3bQqxq/lifcoRVYGU
         KYxg==
X-Forwarded-Encrypted: i=1; AKwUvBxk4f3Du4azoNl6g0kSWjQjW1AG0h4v5PBJM7u1IG2rTHBmvgq27hdAqgouOCpV9OfG5xiWRgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvoRIJhVEq4l0dnIZyOWM1l37T7AhVedFNvzZuaLI4SgvYHNAP
	SamHaapKytNHZ28M0+xvAv0DZVPkyE2eBiZESkf0WFDnmKA2McY0EcIM
X-Gm-Gg: AYBFou2I55MMbbJjexGmBw2xJkU7hZwI4fIhe5pPSc84cXWzNFCobOvGJpKEjbRyOF7
	DsRY/N9y25UQSPcM+dekv713KONkOrt25yy4w4Xn7hjzJHdruQ0+UXNMlvHDZDQ5NpdKn5gAAd0
	kYIuOefH4m16gSucNnWSsPbU3K0322zxJUUJDTBonrWc4AURmdNJqULL4dZCBHilLpxQ4tjJct4
	KZ8Ug6QdDVaOhhssv6PC7AJ4SDoal83zmblt3HwQUFLPsvnYJIa5q2itZTDXmRzu4Qhjzt28jY1
	hXZIWa21Vu0B9fburHN1d9abupfcGs/K+YCLyASMFpnsR3n+v9S4RvybQGqr1jbRcyNI5jQCO/K
	+RxnRiya6eCooX5E7ztdqq+5eQSlR2WB7Gb1zBhKQMLTE+fYcBzfGUcu6cojC/CVlVYyyWa2o8x
	vFuOFJ/PIm0nX84/pFNhHo/pbiFmx+HxzJBHrhrwf4H9B3AYbmf7cJ+L7XlugBBGQpvf/W3E4W4
	gxWmYeHlNFmbOfpAqFJQ+vFpx5GDnt40FBWa2/iuvaEgNJXGj5TXO+1Y4Qq8hHbbAZmVw+RG0MG
	TecOU63sePuRNIRXkJTN6v1SCNkTL1FB81uIo3B18yzCFdIE9q2z6waTDnnFLfuCIG6dbmTmyPs
	LJ7HfKtZltceq04QGVT8uA2pkOkO4hjNgyyCu9hQdfaBQJ+2wEzRj0lctu8/3sYoQFo7g
X-Received: by 2002:a05:6102:6a92:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d03a504ad3mr3020376137.13.1793290248125;
        Thu, 29 Oct 2026 09:10:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f8dfbddsm5953842e0c.6.2026.10.29.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:10:41 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:10:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
In-Reply-To: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
References: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: charge fanout groups to the memory cgroup
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ahmad AG wrote:
> fanout_add() allocates a new group with room for max_num_members
> socket pointers. Since commit 9c661b0b8544 ("net/packet: make
> packet_fanout.arr size configurable up to 64K") that is up to 64K
> pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
> The allocation uses GFP_KERNEL, so it is not charged to the caller's
> memory cgroup.
>
> Each packet socket can create its own group, so a process with
> CAP_NET_RAW in its own user and network namespace holds about 512 KB
> of kernel memory per open socket that its memory cgroup never sees.
> In a cgroup with memory.max set to 16M, 256 sockets each creating a
> group with max_num_members = 65536 took 264 MB of system memory while
> memory.current grew by 380 KB.
> 
> Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a

This is not the only such allocation in packet sockets that does not
account. If addressing that, probably scan all such allocations and
update them in one go.

> user can make on demand in the networking stack already do. With the
> change the same test in the 16M cgroup is stopped by the cgroup's OOM
> killer, and with memory.max at 512M the 256 groups charge 262656 KB
> for 264640 KB of system memory used.
> 
> The missing charge was found by code inspection of net/packet/ with
> the help of an LLM and then triggered with a small test program that
> creates the sockets and groups and reads memory.current; the numbers
> above are from that run. Tested in a QEMU/KVM guest on this tree
> (x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
> running the test as uid 1000 in a cgroup v2 memory cgroup.
> tools/testing/selftests/net/psock_fanout passes before and after.
> 
> Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
> configurable up to 64K")

Your email client corrupted the patch.

> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> ---
>  net/packet/af_packet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c91..406397acc5c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
> fanout_args *args)
>   /* legacy PACKET_FANOUT_MAX */
>   args->max_num_members = 256;
>   err = -ENOMEM;
> - match = kvzalloc_flex(*match, arr, args->max_num_members);
> + match = kvzalloc_flex(*match, arr, args->max_num_members,
> +      GFP_KERNEL_ACCOUNT);
>   if (!match)
>   goto out;
>   write_pnet(&match->net, sock_net(sk));
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> -- 
> 2.43.0


