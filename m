Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785354779
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479832; cv=pass; b=mW3zCsgaIEGSiy5LYWATTcDjXDg0/6JOkQu+OOuFk0T5Aa0wlLjfIZZpU+bNOUTvzSLoFF8KXi2O9BIadZ4jzKtOe98xkkyzxK5VOSELsgnoEDzx6Syp60u1fTqIlXKzeDdWXfniIJj+WGBo9+Ns2tf8/ymx0Y1jZTkoUWAJBLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479832; c=relaxed/simple;
	bh=8TPLZhK+AhSCBPEHWCi7lPDnehMDfRAsgS0v468v7Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQAYjDfQB9a6y5Y4eTLqklv/fHoCYlIL4wnblT8nWVv1QeQp4kYIYOi/ePuNBFM9OsGtIZHvKaMFw7Goizyc85c4fCLyiAgMxJ/buRV4vgfV9Op7acLqVVHjHo0CQHgLJ/QDiDWSNqBXnXv02uEQTqwTQJ7y2FDKkzYYoNecLoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ2af5/V; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ2af5/V"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f5d3bff929so3665739b6e.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479829; cv=none;
        d=google.com; s=arc-20260327;
        b=RCt4/5K2y7isKphk8mlDxy7HkreB0u/LrQGyf1p1/+A3f4uX5CQHhUEf29bNLIMF2H
         eFJsAMXE3FxTamPSIkjSCnXqFzCJN8XGM1B8RdAWBOC/NM1YEYJqfpnyBJhW9Dg85mR3
         ervAlRVNrRJ6nl8BCBuhuW9UofXudpBQ3CrlLVPYlOnkP29IYu2mGht7B8XkajMSnr//
         T08dUg1j8eXsNmZea9aIlEj5m5P5gf2IXtwrL+JrVXg7Jz70wGqqNJx/55KoTOS/ZMQJ
         AKIs4MBjDRPmn/WWQYKkV8PulDcZ75kE3eRi/mFRHRuNKLgxgrR1JyVVjcDgIXqyh0e7
         Sg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        fh=yXSef65dnBYQJpddeiEx8QqtsnlHxeNc6++xtEaB/Do=;
        b=dW6VRce5YE9qXB5mJEh+HJcwje0uTTnLdvW7UXppk3nnKTMjmUrOmJcxs+97Tuwzeg
         PlDr0wfY7qOwlp7LH3PhQV4rYpNDUFaTeo8wzMRLmfZOHh1rLQE61y1XE1NEXn1cWNbC
         ZmJis8F+O22DLUZzSQ3ccdhBiSDmeMGLSrAEjwR5bIOT9rMMnbc2tGo9C1w7lQQ/KHqC
         ir6sAyHEgld7+uuh9M2QexjnDyYvk9hK09pFSPZ4GQ/xeSqWr6xR3nA2sIhZbQ2xnJJH
         WPPziRcB0YFPGIHzfhS3BmGjSOoaRRW2D72sXtSScxtoy6ABJRPA6i9PdejN6jUINw19
         8oMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479829; x=1792084629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        b=LZ2af5/VCGasoiLIcdMtF0vHlIPEThHv632wtd5mKSU3zEiqk86gvNOH7GieD8qJzd
         X4CA8mTkVC0+Exo6UT5SxTRp3VFTOLd3+dNaj65SaEjQrQG8MHTbykyzeZtVQCT3ds1y
         3tYKRUeTEKxKbg3IDOVHYCIdthlisOFuigdm2jVV7ttvG4QkcmxW7ElTMJ3+mF4Xdpag
         94QI5jyTACo9dq168WjSdvlRS5Gn3UnjUAemm7ER3R0Zx1UT+aqC5fRRXoNtH0y4rXmi
         1EFWTHHfixtlaytiwW957farPLiHKltBYeCpUV50tfZ8EN/3t7zU2M7DLbO+LNNm5sXq
         Y0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479829; x=1792084629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        b=BQKaK4NDZgE9fNWsMp1uWsxltZHd45pBgLTrwPvCFaRHmALaOOHVKboPGsnk3KwX2K
         eU1BO/Dbldpxpc3bBL/K7g/jvRfOGhf/umPetPrrVjmKHcHGhqFGP3//vqosUHf0ZqDf
         zSLAUgTk2hSlbE+fKOj158IrCkKmharptsGkqW5w3yP0c3CWhaoO2A6lREwMExeI33FG
         GEybUudzIA7v8CwHE1MsVbJN3LiiOOKN/zy4quMnZxGVNWt1gUu/C/1q5cN4lPuG2Uqf
         ksaFVDtdDkqiFEWoqpz8qy6E/6PbkpGeJ3Rkz1oqvsy9Snccox27a1v6xDCU2iI8lAzC
         4uMg==
X-Forwarded-Encrypted: i=1; AKwUvBy/M4/CvbiaYRSp3RwMHJLa+8/FLH0x4zXgrRNFr3NdVFoavoWl/8M0vUI5UYEWD9blUE0Zz48=@vger.kernel.org
X-Gm-Message-State: AFuF++kH1qY3OFlauULzzksxzzyOfqkwGk/yOXKlZw8rPEwK29kUj1yz
	ZiFOn5dCwykHNFJ1lQ4GvgtlmSo0iF6nYbCfQAiQx5srYdwAecN4A1OrpkzyoGWQqde6PQYLJAO
	mkti7rMnVGBDxSd6SOQ0IwlOsRnsYewM=
X-Gm-Gg: AYBFou1KzAYNQmrX1xgSQRDM8owT+iZwphDctAvwZbcztLlXoolkk2x3J54PedKZZzE
	5q3vrHi+1bB3/gtkRZGgRsGBzD6PRomV6c4bjlEp8A51ZaX4EzrGjp+czoHKprHKgBWR3IZvRS6
	uLESVLgmidGlIYVzojqDBw6qFJJQHd2e6itxWg4iKJq3+YanVYWwvd9kJwxtALPpsGFLTuMM1Dv
	lZ2qhvfMX0Qwl7/k8s138WIRDLPITyH2ZyNGCoARhQnp7RDvnqSitC0XNLZypok8BZHNS3lhVCN
	6jAtc1WeK2wuoORWpbMKZI691ze6D10b1zrww+KfLP1n+bHpSEKgr9w=
X-Received: by 2002:a05:6808:16a1:b0:4f4:4de8:9373 with SMTP id
 5614622812f47-4fc46890902mr5775908b6e.21.1791479829230; Thu, 08 Oct 2026
 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com> <20261008031604.256498-11-kuniyu@google.com>
In-Reply-To: <20261008031604.256498-11-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 8 Oct 2026 10:16:58 -0700
X-Gm-Features: AclHuK8ASGIDEe0W65rv_VH9rEvQ9UE55lHFYXFlGQ2gOAXDeSvmVe1l7KhhIAk
Message-ID: <CAMB2axPBS2=hPponYK4z4mA9nAhCXRVOWsR3F-yWOqzWA4BbzQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/10] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> The test is roughly divided into two stages, and the sequence
> is as follows:
>
>   I) Setup
>
>     1. Attach two BPF programs to a cgroup
>     2. Establish a TCP connection (@client <-> @child) within the cgroup
>     3. Enable BPF_TCP_OPS_FLAG_RCVQ on @child via setsockopt()
>
>  II) RPC frame exchange in various patterns
>
>     4. Send a partial RPC descriptor from @client to @child
>     5. Verify that epoll does NOT wake up @child
>     6. Send the remaining data of the RPC frame
>     7. Verify that epoll finally wakes up @child
>
> During setup, two BPF programs are attached to simulate
> a real-world scenario; one is bpf_tcp_ops and the other is
> CGROUP_SOCKOPT.
>
> While the bpf_tcp_ops prog handles the dynamic adjustment of
> sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> the TCP AutoLOWAT feature via userspace setsockopt() using
> pseudo options:
>
>   #define SOL_BPF               0xdeadbeef
>   #define BPF_TCP_AUTOLOWAT     0x8badf00d
>
>   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
>
> This reflects a common production use case where an application
> decides to start parsing RPC frames only at a certain point in
> the stream (e.g., after HTTP Upgrade), rather than immediately
> after TCP 3WHS (->passive_established(), etc).
>
> When BPF_TCP_AUTOLOWAT is enabled, the BPF prog sets
> BPF_TCP_OPS_FLAG_RCVQ and initializes sk_local_storage
> for two sequence numbers to manage its state.
>
> Then, for the RPC frame exchange, this test uses a simple format
> defined as follows:
>
>   0        8       16      24       32
>   +--------+--------+-------+--------+ `.
>   |            header size           |  |
>   +--------+--------+-------+--------+   > RPC descriptor (8 bytes)
>   |            payload size          |  |
>   +--------+--------+-------+--------+ .'
>   ~               header             ~
>   +--------+--------+-------+--------+
>   ~               payload            ~
>   +--------+--------+-------+--------+
>
> Every time a new skb is enqueued to sk->sk_receive_queue, the
> bpf_tcp_ops prog parses it and updates these sequence numbers:
>
>   rpc_desc_seq : the SEQ # of the start of the RPC descriptor
>   rpc_end_seq  : the SEQ # of the end of the RPC frame
>                  =3D> rpc_desc_seq + 8 + header size + payload size
>
> Assume we receive two RPC descriptors in the following pattern:
>
>   1. When we receive skb-1, only part of the RPC descriptor is parsed.
>      rpc_desc_seq is set to the first byte while rpc_end_seq is
>      unknown.  Thus, sk->sk_rcvlowat is set to the size of the RPC
>      descriptor (8 bytes).
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+.................+....................+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
>   +-----------+.................+....................+......
>   ^              ^-.
>   `- rpc_desc_seq   `- sk->sk_rcvlowat
>
>   2. Next, we receive skb-2, which completes the first RPC descriptor.
>      Now rpc_end_seq is known, so sk->sk_rcvlowat is advanced to it.
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+-----------------+....................+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
>   +-----------+-----------------+....................+......
>   ^                                   ^
>   '- rpc_desc_seq                     '- rpc_end_seq
>                                            & sk->sk_rcvlowat
>
>   3. Once we receive skb-3, which contains the next full RPC descriptor,
>      rpc_desc_seq is advanced and rpc_end_seq is updated according
>      to the size of RPC frame 2.
>
>      Note that sk->sk_rcvlowat is NOT updated to the new rpc_end_seq
>      yet.  This ensures that the application is woken up to read the
>      already complete RPC frame 1.
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+-----------------+--------------------+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...   |
>   +-----------+-----------------+--------------------+......
>                                       ^                      ^
>               rpc_desc_seq -----------'  rpc_end_seq ----...-'
>                 & sk->sk_rcvlowat
>
> This sequence corresponds to the 4th test case in rpc_test_cases[],
> and we can see helpful output if we "#define DEBUG":
>
>   # cat /sys/kernel/tracing/trace_pipe | \
>     awk '{ if ($0 ~ /AF_/) sub(/^.*AF_/, "AF_"); print $0 }' & \
>     BGPID=3D$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
>   ...
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len:=
 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
>   AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_de=
sc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8
>
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len:=
 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rp=
c_end_seq: 258, header_len: 100, payload_len: 150
>   AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_s=
eq: 8
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_de=
sc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
>   ...
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
