Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3038C408
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531654; cv=none; b=G6SD7HuHupPq4m7k5y5HSBCwAg1jRRFfLSTXRO6akwKtg12nNK3LOryx05kdE3MDI1ruVjtkQd0rPB6fHhujCkWUKVBfsZQuIqhdeIwwoTojLLiQigEyi6Ui+WsGqamVDAnwDUEoKVjf9McrrCQFTbTGS319zkydQg/Y5aa/S3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531654; c=relaxed/simple;
	bh=6zEHfs6NVagrKkHTQrtRq0DKa/7gfElvLcDsqQCnjmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJgQOJODqAL0Yz+5cM7fd9VeKorlIB5eWqWjWY0wp8VxH24yqD70PAeo83Ietmlm+Q+MLKcN3X5o+NmEt43DXE4z354TiVmZ+hJBrbfRz3aXl0iYWHgHr7kBwSUBahKczFvXe9lgig2Lgoyhf5zc6vxqlXJwR+h0trNFOwN0xk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5kyLqHk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5kyLqHk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so25140835ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772531653; x=1773136453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6+Ol++dwc5uQY0FUuFGmKhf/l4t1CM8X/CyOEISVX4=;
        b=J5kyLqHkS+06mMDoIC7ijss8AXm3EXmgj9/Tdv8CnL/fAaqEqpoJ5RmF8AAGwta2Gr
         9ZTkF8NtEIuNmsu05VbVxiHFyZshxu5q5Wmqn5cF42UZxpJ2/xOVnkA8WwbRMGfJJss1
         cLagcRqIHWWjHNoEPPGebOFVMVE8Kkjev05Yql7cLCLKKVrmKxXiYtYMsP+QnFZWdZdE
         emeTxt3PhsMAHqpJbQ9obFwQK/iVGXRfN+PPaB+i3crxl4pXkZXNtX8W/jQL4YdyDg4D
         uRLWbzHQSC7Wk9ludbDFFOofWth0trOvi9l2vuNJKeuMs/LfSQ8DJWKZiqdIWDs+U3kK
         FN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772531653; x=1773136453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6+Ol++dwc5uQY0FUuFGmKhf/l4t1CM8X/CyOEISVX4=;
        b=rhI0MQq7wPnLdrNYzvRaMQCWEf8z0AW3AOUoc/ar5MMayLzHQEg0IFejVGYqV3X5G0
         zb+c8nQnEKDfn/+m8MQlLeQsySHG4rqM73T9qiEcmZ05ChVVr7AaaO6NjqUvd3f3vZ7X
         6RHDdbLVA+6bffsOwIj9YV5qqDf+cevbgxDy027wY8EYwvEzPIrW+2GuNwP/+8rYNwpF
         1LB485+TAtykg4bMmWinP9msI8Elgg0CKScJBUFC8APaZ8wTUXs6J/y3QGWODjYaTX0E
         xVmFyXUfQ5qFJg2qA3nbFiB3Yug64imESIhHTpxJMBRvduP8Uqt8byso14y/2Kij8bLx
         tuhg==
X-Forwarded-Encrypted: i=1; AJvYcCW8aseA3/iRcIAtlFU7hANlEN6/zlq5ncSdBxiibX90tg+4+mN6YkwNUCFiKog8DOFuxwASQ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJ5oHSnoxMqU3PSjwlvhrZ8JIe1LCWtQn64UPuQrquWQtODce
	QMcszmEnnhqeJ+ygBoVuYF/oUBRNraP4wUPkfnzUUn9TVmoVeh08bFOl
X-Gm-Gg: ATEYQzwfW1YreCMkIYpqrpMI/zcLjPw2jbs2gRfQY2pxyuzWo13DI0wTASN3jBCk9s4
	XcX0sL5fJrZApp6KGE6JuC+MQ2oN0J7xGkSBhU64bblLX/uULFxx6XNa/uUejigm8EvPws7sfar
	IZntfkJoIYHuwgJvjTQ0v8lKx+YVAhO8Uqao4mdWbkIRvlJGWf4QBsgaBFBYVxUBQqlxFY96JBx
	58Xr6RPlDUBPsdlLEhB/ai5fvvtihEvuL/lb4oLNy3Xx713gh6sMRA12qZRYvHiUQzIbFbZmP/t
	luf5Bp6m9Wqvz13elVc+R7yMne7G6FH1dGlMrNF+M09ZG3Ni0anIlmMDOLHl6j9Y11qFnLHwU4p
	p97cxs+c8cpuVDwOBPXxXURDMsm4RwRsi3c+xV4aKRZpCm23Cz5dhc2656y2SGu+qK5KFfY+6Ts
	2xmpn62kw+Gr2OCPYxTrxVyNqeUVfmrHuVBgRSnT5dUcALYXJ928dbSkI7fPHVH+A6sdjwFSo2L
	gHteeDfHVRZ
X-Received: by 2002:a17:902:ec8d:b0:2ae:63a4:3baf with SMTP id d9443c01a7336-2ae63a4420dmr6105535ad.46.1772531652863;
        Tue, 03 Mar 2026 01:54:12 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4e571b90sm60596445ad.62.2026.03.03.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:54:12 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: edumazet@google.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	horms@kernel.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tcp: replace per-packet memset in __tcp_transmit_skb()
Date: Tue,  3 Mar 2026 18:54:03 +0900
Message-Id: <20260303095403.3141135-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89i+10Jz0BpOPdajdLccfBz5UNq9ay7qcXS0LwDaU-07ozQ@mail.gmail.com>
References: <CANn89i+10Jz0BpOPdajdLccfBz5UNq9ay7qcXS0LwDaU-07ozQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Interesting idea, but the implementation is a bit fragile.
>
> I would instead add a group in struct tcp_out_options to clearly mark
> which group is zeroed in  __tcp_transmit_skb().

That's a great idea.

>
> Partial patch to give the idea :
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 46bd48cf776a6a37e6ab2664245cd1e35a88d4f8..b96168f50170b7359d26de2389128bc80d4d549e
> 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *options)
>  }
>
>  struct tcp_out_options {
> +       /* Following group is cleared in __tcp_transmit_skb() */
> +       struct_group(cleared,
> +               u16 mss;                /* 0 to disable */
> +               u8 bpf_opt_len;         /* length of BPF hdr option */
> +               u8 num_sack_blocks;     /* number of SACK blocks to include */
> +       );
> +
> +       /* Caution : Following fields are not cleared in
> __tcp_transmit_skb(). */
>         u16 options;            /* bit field of OPTION_* */
> -       u16 mss;                /* 0 to disable */
>         u8 ws;                  /* window scale, 0 to disable */
> -       u8 num_sack_blocks;     /* number of SACK blocks to include */
>         u8 num_accecn_fields:7, /* number of AccECN fields needed */
>            use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
>         u8 hash_size;           /* bytes in hash_location */
> -       u8 bpf_opt_len;         /* length of BPF hdr option */
>         __u8 *hash_location;    /* temporary pointer, overloaded */
>         __u32 tsval, tsecr;     /* need to include OPTION_TS */
>         struct tcp_fastopen_cookie *fastopen_cookie;    /* Fast open cookie */
> @@ -1565,7 +1570,7 @@ static int __tcp_transmit_skb(struct sock *sk,
> struct sk_buff *skb,
>
>         inet = inet_sk(sk);
>         tcb = TCP_SKB_CB(skb);
> -       memset(&opts, 0, sizeof(opts));
> +       memset(&opts.cleared, 0, sizeof(opts.cleared));

Will send V2 with this change. Thank you for the review!
