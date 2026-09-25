Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9522083
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294696; cv=none; b=DkbbGpVAZC/TW5d4zNUl0M41vvNzwDNf1jJxD1EJibrjhKZBSYP9JHZCP5fHJap3kx5crQCmln3YZLFRahHS6pptXCMLrhtTqyH3eej0Ldc9FM+QdONt29yTQFGLsi7PevQoCybkh34GHHagyq4BOftPEubVlrV9N6I4sczVntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294696; c=relaxed/simple;
	bh=rAvKWZrxLvgCPTLvJvB1BAkWD9OtTSNteVT1S3SD1g0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=tF4NPNGARh7IrENcW9VK/XqQh4Ksl7u1v9O9UE+DBOP/1IxWyQoFajI0ACP1wAdGTGmxuuutCZky0/S3LQT5VMTheFFLmDCo/i87m7/zLDzYHWGhk6cP+V5m5nCw2tSFOMeXf09mB+3l3PXy4BdsSi/CV+tZV/XmMyTGchWeqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ6yhhr8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ6yhhr8"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8631d0023daso220281b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790294694; x=1790899494; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cigb57ggqvOPpol93ktV2mCf9hAKKRb/9fmR4jwfSd8=;
        b=bQ6yhhr8xw0JoCSLvi7BjkpyvuEjIGrStgXc0n1xoS6t/I3+KLemh49uEsB+8+0OAa
         tfpGFsb+EXDi0A1OdD/aZxDKr0bX1sDyEc5Oq1qsxmFc8jzUm64mNZcX0JUZBNreY8oo
         rD2RIdffhTwpfJWWHSifmgQbpU8QOV6KjH4M4mPe1gA1DpI2Ytpr5DY/msycS4v/gU8D
         jxspBVCewDMT15V6u9JKCimTEOgVkbKKvtp4J3uOu3V8LU5EZ+9a7rVH9itq7E5fEOO+
         im8gqmfRqSLozuTzovRDxuwgM78BeWPfrlDqq9X8A2xCed+G726Q1H9UeUbr4aj3TdV8
         Czvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294694; x=1790899494;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cigb57ggqvOPpol93ktV2mCf9hAKKRb/9fmR4jwfSd8=;
        b=gxfHb0OBW2Uz98oZF3ZgW0PR1w/LtRe30zCgx/HPFRBWW32II8+cYXDZaWu4p+dlGN
         uPIwfd/OYNFnj2e72w7axrzmGMtyKWf3XUFrkKAh34mlv0JmM4ribfVGbyRmXwv4Mn2D
         YrTYmmEdDeLwjTZHWo3yRRHz8nRZ0AAxAcHIrkk+LA4I8GpjSCXLaX2onLN37DJB67Pr
         5PxxlfDKi/Ag5533AYPNa6LABmUzXpy9inhMVbkxHkkjC+cYu0nTqGTYcJ1vuyD1Wt9v
         qJTKCUem5HkIX46qTV4UW7UemXY/eFA9EZXMzOQaZjWwzvtAMIQYBRMtejpK3NEvUp5N
         Cvrw==
X-Forwarded-Encrypted: i=1; AKwUvBxYeFGXtF0HJljvZP1eiqNxlOKJhxGGBrUgAQI+zg5/GNwiWOH2KDwUhbeiEeBq74PVDBGIKoc=@vger.kernel.org
X-Gm-Message-State: AFuF++kjms1ONw16YiGyg7VuaSYicrgTXNIDIB9ruJPsvheCjbaVrChJ
	ErpocL8/e9gFipucumnGJoSuPE0xKQ3sQxQVxnH9VQRHzjrMOgOBsyX2
X-Gm-Gg: AYBFou3tjYyTNuWD7vVab82JcdS+AQZxbWlBmKgs5RBEqenOLHs1YOxpiI66/TRGwlu
	CgcRAloNDitcdaNrYkq4JRvesCzI3PeWCQsgX98eOLOiTm1dT1c0smBqyxIlTn0MV6zCczWPppm
	ebDEzbU8E8qCPCWspVVb/0/fICnPlkTbes97+ll38Y5+iWx/MZvzSohyHqkG62z5IcShEe+gzr9
	dmIavxJdwtkWbecRrMAnJvqCOXsqAx7moiKexx2fE/5AK6NuIkBcV5soL92Pjg9ZaTiTtYru62+
	yCttD+y/I2dM41BQvMzj3sEMh570PxUjsoGSW9eOtcoKGrFIQtx1h9RDBGpyGDVLV79YuNAQnQN
	Mwe6lKFmabXQBREOvogsyGjbQJjWzWYoW0bd1/TcE76vd3CczRp4OJNVDPsLiDNXAywWjLjZtq8
	cZiX2GhEiEx+e8mEIYrq6v0uV3Sib+I+4Sf3vRDNtaoDd/5sWTk24YvPeHMGHBX5t4VS0jgRDHK
	o/vEImi5JLSeNuBhlE5YEXcK4BfOVkrJBJZOqmN92SuSrWfZ2L5bgdZno2/ubu8xMTXyVzTcr4j
	dDNZ
X-Received: by 2002:a05:6a00:4650:b0:878:34d7:699f with SMTP id d2e1a72fcca58-87e9b79c67fmr3476778b3a.47.1790294694409;
        Thu, 24 Sep 2026 17:04:54 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fe82ebc55sm285808b3a.4.2026.09.24.17.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 17:04:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 00:04:53 +0000
Message-Id: <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20260923213719.224838-4-kuniyu@google.com>
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:35 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.
> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,

can we drop the flag ?
hdr_opt_len() is called for every tx skb without per-socket opt-in.
The prog in patch 8 already returns when the socket has no
sk_storage.

The flag is one bit per socket shared by all bpf_tcp_ops in the
cgroup hierarchy. When one prog clears it the others stop getting
enqueue_rcvq().

Then sk_is_mptcp() check in the kfunc is enough and there is no need
to touch bpf_sock_ops_cb_flags_set() and TCP_BPF_SOCK_OPS_CB_FLAGS.
