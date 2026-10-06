Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7C38AC75
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324439; cv=none; b=HUXIlnZIfiVEwmGZwDW9vX/Rjs0w2L8MB3+AvvYBokieUTqZuB5rIFUNvPwDWLHXjYK3i6nVXVHwKR/F8hKSr2AiNZcyeb1gNzsZgBFoA4DJ14fqmV+hjt5Kqh+bE1IplFKL/o7T84Y0R6wn7u60XEZq+dY9W/dxi7rbNfa/xoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324439; c=relaxed/simple;
	bh=B4fH7wRo82+xD0mPhsFWyivVYv0Q3R1a6JKRMyRXCJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Fkc9L1V2uskCRZsQGEQwC2vyFjgFXrPZKDpFChIOeHOl2bCdE32xOqdy4m0GwAi04BL/cd/c1y+H29io5lPTVPzeX1cTyOm+QIRhvpk/+7fZqald94VDebQn09B2hzFb7ZpyOjoz5pJEx4605EsQwHlzXQ9/pirDdBjPNyfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwOaoZ8f; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwOaoZ8f"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e4c3661728so2809575ad.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324433; x=1791929233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xV1WC96HEZo5ow0jJgk/jpxh1KNQ8B6OwYydLnktSEc=;
        b=BwOaoZ8fe1j9XSKi+VK+PXgi5n67AuKX5i8ebarMPo1iK7UNnx0EaKT1E9AoKiPtVr
         BUpT9lcpcT6p12Vr+57ClnQgthJYH3y25YYNZ+aI+0wI27aPB1h9/E/0CajiTHPBB5CC
         J9C/EuGuYmEjdbqANemtzP7vQVxGqArXSJ/3qNRk1yYPi7Ltf+Cv7jpH2AKfluV5pDRT
         XBqUPj/nnjW3rqQHcVsWK4AePBnCNm/zuoZfpMWzfHR+khMFMuqaZu2LfS7YqWQnxO3n
         AcfLQpnlvu3iPFQ7lOcc2hLEDLPIQS+oeuZcAej2BBto62KkSWA2CGOVTJwCxtSWz1lm
         MHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324433; x=1791929233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xV1WC96HEZo5ow0jJgk/jpxh1KNQ8B6OwYydLnktSEc=;
        b=GwO/qzjQVEfyRag4HYNDpzg0Xfg+t08QrWkuZCyu0pgQ+aHDThr7WhHDDvypc/YUQn
         eJr9yDMR6LS/0tuVEvQ2kXcS2LADzFES3U2T2LuSrq/T+DY05NrIT6V414xovuc1Ef3D
         jGV5z661X2p+c6MDbsHtlrJd3sW0IKU2sREXIlAUzhf1YJIDSqem1fXQFFnRHXRIWtRM
         ZEx/csq/Ii1Xrx6lpn5bwqgLOkJ081SQkGdLqENmd2aCn8jAl60A5DvhEBDI/wkZKcOF
         Q3xIorpKy9r4q3L4gr138Wyc+6HUnFyXR6mA/HCmE7tZyl5WkTkhDjlTi7iYWTgmgIj1
         MQzA==
X-Forwarded-Encrypted: i=1; AKwUvBx1pe/AeTS1EWANjQRX5lpUOGw/kkJma+ZBncYGcYO7xWZickqcX84aG3WGMH9h/DISwZvZevI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9tXSk9YZa4JWaF37XhcJg1bnIoRyU1dpS3DaLDiyci0RX5vwl
	HesDI8iyYgsQKTSJL41hwih03YICJXz9VV8bcjRueCqwh9VJBjLeOJ+s
X-Gm-Gg: AYBFou0zxjexeEPiPIK6mpccR1q3wNIXyERT4pXwxo969TMi4Hucu4lv5sK5TfGLVaf
	P7vHZekYjezQaq9In+9mTERjwk7s8vcv1XTTMN7nPkDxH43CH9j2GJhlypgiuH+2gL/fqpVi/8v
	PVt9wCJYlmK57++R8zSgZ/RBt4zI1PkM0h8blI0X//BHDXP16FcLCAzXMDipxb0o+CSS6EKUv60
	1uNWUFpFXU+HqJHg+kmcfo+Qw+DW10sbnXl1OjmsERBt/EVlDcbFH+ZM3DCSHM6zyuSlgYAOKaa
	MOhlMKCS97piaN1yMd/MEW6x7C37k1H4cKbNIwvcrYmacUFbGOm4Fn2Pgt2Sd7PM1INK76h3T12
	S9EbrBQ3kM6rwzz2iuFtqxaEzu3EpYjInUkCzbjOY+36QQVDBmGealR46+iL08LzgzvgXYrscDR
	EbRXEnyLsnU70GHhOOT+IAENEBk7u3Z4hWOOFSd3PgYlgAO9Rw09wpMk+TIXTiC4g=
X-Received: by 2002:a17:902:d48d:b0:2df:91ae:7ab3 with SMTP id d9443c01a7336-2e6003aeddfmr4365225ad.9.1791324433115;
        Tue, 06 Oct 2026 15:07:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fdb36sm1587575ad.22.2026.10.06.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:10 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:06:40 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 10/10] selftest: bpf: Add test for
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Message-ID: <asVw6d5Y0moFn_GG@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-11-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-11-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
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
>                  => rpc_desc_seq + 8 + header size + payload size
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
>     BGPID=$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
>   ...
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len: 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
>   AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8
> 
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len: 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rpc_end_seq: 258, header_len: 100, payload_len: 150
>   AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_seq: 8
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
>   ...
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
