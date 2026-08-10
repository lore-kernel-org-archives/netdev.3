Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9143786E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386955; cv=none; b=cc1HtkyhSRRRq61w0f4gV7MmJCUST3i8JkV8vO0691YVAWUS3f8eVVvuML6qCC/HORIT37KS9QC6swvKpzXEYmTIhRnW9BR7cimxCmV2F9o8JdDyTZ7v0k+5j9zUgSJ3rjcL7CosktoLtDPgQ29+uEgSsFBLPiz0iD3cqypXgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386955; c=relaxed/simple;
	bh=VFvhje9ONwo8tsHkXIxD0CE/7U5QDcliaCcHtzqjCsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5HPSSRwYVJrdh6TVSwIDqj7A5azQJpCNyy/fgf3uTc0VuZsZ6KDFrPLhSXdGh9UOVAoEsR/UK4Rggfakj3odOPM0q8XAkCVHlWbGlzR3unV59W8xlTLuL+CHJ5wp4CgwTmKKXivVGCZ2R5un7/h9ftJLzH4I7j3ebuKY/vx2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6hKWiO8; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hKWiO8"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so2023968a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386954; x=1786991754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jtr2BaGwELh4jAzhl4BDW4Dq7f/B62WrbZTY8vzy1rY=;
        b=W6hKWiO8YqJIS//wX9NQCnL2vIY8hj8qrmd63YjIYsn/zidQwHAUeyzrBsCZ2VvR0a
         r0E+1InjlmJYqHTZz1ZFCnpFD6E4YjrvpVYxo/M61iMn2RGSW8HIcoMtyiL3M0Mag99L
         g/lVjWNgdVEPDruG93iGXENa0eGLIwC202gVnOdu2vO4Y59GVOzLanbVcZXBYNfRoKQe
         LtY6wQeuFl0pwBfJta9+/G/H8kXDQMbd7XZtdV5QEMJ02WWsJwCceghjYp78wMweYNe/
         TA8MJl+yz3vWBIorAE/vnHBMUUTsp1j9jLkqRGbepdjTghJC67k2WQsru452B/U3LTT4
         ETdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386954; x=1786991754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jtr2BaGwELh4jAzhl4BDW4Dq7f/B62WrbZTY8vzy1rY=;
        b=p8vDMn9KRu8LBieIB6wQ11sx7MwhyXXolDvCOiq4MxcC0XPNDmmGC3QJxiCTydFgEF
         YM1ezUwikG+Xd2RnFIRAZP0IQ/qp94p17oLkxM9BS983rcsSeLldxhbI8q4nR6lkOBrl
         0YCqp8rT+adOSRRT41mYBjFBzQQqXJqqgL9Tr1ZrfYWGr2fwPhzRqENRczaqaNbU8azT
         w3ePnHebUYFKYCT9ADF46aA9AlRDggSwXRdGx3HOP+AF7WjEcPFik1MQTKu8wMAsTWOK
         PcGMjianhYuOOtC21phJFdPPfG+gDTSlL5XHLuP5ALVhrEprZvXx6227H054545ja/fL
         sS1w==
X-Forwarded-Encrypted: i=1; AHgh+RqwHsDTwyVSN9Mklebfa7tVaS0trriwyITZeP26CNjiiKLV5oxcyBHr60AG8irNmeqEq8s0OBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxug7fXyqcOfPOX7gVATIRt5Dn9bXM0FA9rdHZHNVvgCuK54e1V
	RxiBXdqup4Qxr3AGWN8KamNAzMvjgAH/QdJ6GhpMb6knED248OMDYjB+
X-Gm-Gg: AR+sD10J79SA+sz28h9e7ESAsJhLeMnDK67wF/YknEy1tWPaClIcoPcMp+b1dKudpEY
	Yu1TN8YTcYOn/FRkJmgkZOF9eJDt7+5seN9RPgl26l5wBMH8FHnOHg06ddramp4LGh9RDH/kaUI
	3tGJ+auUBbg6Fm7iHVe9GaIh165HZMxiS7W1OilJYtSsteWj2c60MLwXiF7s20uAU5lhywQsTTD
	GNVW4ZaNUERzvEOGFGbfhCAYDc4xwcyn62/UX0DijlvKJQNYwdkrwWzOPPyzQQBb0NZwQmuP7Dg
	zZeXmBorJyxjfnp+SqwODUrOC8mBlew7yoBfoZwLsOVJ6PlHRAZmx+PW3mvkOUpkWLIR3cx53kb
	JwOAqfsOhU/37Dv7KrGcCbYO9M7/v/joh1PsSNII81zY4bMEv4gUDiiqs62Lmwj0iQDyV20y5ps
	LkcgcVbRRrOjMaye7UY+cDCnpx1kkjJfDZF1s+53VjwBiijLSKAfcZhQ==
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr29135359a91.13.1786386953837;
        Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5190ad0sm600581a91.2.2026.08.10.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:02 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add ksock kfuncs
Message-ID: <anoZycesG-0xFh6o@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-3-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
> 
> The API consists of five kfuncs:
> 
>   bpf_ksock_create()   - Create a socket (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
> 
> The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
> SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
> bpf_ksock_send can be called from SYSCALL and LSM programs.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
> 
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
> 
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus, the bpf_ksock_send() kfunc, which
> is exposed to LSM progs has a verifier filter protection to avoid
> recursion so that the whole bpf_kfunc_set kfunc set cannot be called in
> a program attached to security_socket_sendmsg(). Also, because of the
> LSM checks, we prevent the use of the kfuncs from asynchronous workqueue
> as the current value would then be invalid.
> 
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
