Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38062380FC0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757493; cv=none; b=Jk7z1EuQDf09hbUSRQOg4/KwPdSDJZA5DUINA4aQKwtudNrl4mmRmysLcXABzx57Sdn4d7Azr6/W2ypPiN04yiI74JzvT8pFvWE6KM3TEmz3PwTPLsE4wkUIM0F+29U+UTMwgDITh0eQEHs7o4YJweMvkSToJh7eV/tmem7cXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757493; c=relaxed/simple;
	bh=wD3MZbsN9jzINnVXN3GY8//2NKqq+BM9+4wJqBbMpj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ftBZrcU/l3vH8TPzYvE4a8Xt/mMVLqrUJDhir1oG5Fz9Djc9Q5SS6/JE2dluymNRHIhrX7r+gEay3vGZRTNDrLBSO/QqeMkFRPqZcGMqlb2mBy1w0FoA8PSDP8bDj3WAtVZk3annuZFK4UdeJN5S0QWtIG27tejScwcgnw+8ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBso08I/; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBso08I/"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9cc8da95aso1046086a34.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757491; x=1783362291; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgWBPgkIFq0GJmdrKvHCFz2V403YOlZzIZlCfT1y164=;
        b=fBso08I/obKfJVGigsaL/vbX5hEhW8hanNE2ztUwdOCwzJwbxm8RCiFve4x5RG5aX+
         W1zP8ZjhaZQ1nuPmkSM5EL8GOI/ONNbOF16mSdKxkUmHvdpA3cYXpeaSU12eqGmREzGE
         a8nNYNwWGXA/vY1hMfFSbLgMb5yDRp0S+cXnEZhLKZY1so4vjagix6hb57+jqAh96lPn
         iY1FQIIbHsvgRwXWk321L2+bUdgzBS8KoQWCSsg9Tex2/58dEv9Kt2cx4PmABREnXugf
         eg7yadeV0sM2mL80e9Hio8tMusU6vunmUaEtT3NqgsnxciixeZ14DMBkAzI7I+GnA6c8
         2nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757491; x=1783362291;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgWBPgkIFq0GJmdrKvHCFz2V403YOlZzIZlCfT1y164=;
        b=JTLk8ItLDaY8mj94h1iI8roaxvlodTyeV68MZXIp0IgnEMEB7lzyw7M0KP9Vo7Q4Or
         1lUWpYGYbOYHo5v9/cDEmCos2xh9up/xbJUS1FmzclL5afedWI2yHD9Y/11l2i4GfrgG
         ielcHwT/miclNreiMICK6zMMFLq+Icey2vy80DOLEyWyWt0l34SR6U008/Eu92OXiFgQ
         3a2jEhHpKM3cWwpPiPJB78PA5twWB6n4PEzMOzd18zdAzjDioPvi6yZFlkX9g+C49hkk
         uI96fL1a4ks+S8JyKPQy4739cFo3szZDZDQ8y54f6YRB1jj1RRxrCgZsOuPONBuSnWRA
         SeIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vLgBzzG0P8gON8/0b6FXvZJMdYaTADAS8mzwuBhgSy9p9JqU8LMSPvgzHBJF5G2zkTwFye6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEyJ8IyCG/41TrC42Oi2kaT4cpgjHtrynJlyy4gDtPJR4kbht
	BnNT6DsDcUAmxGCAVUNq5ZSujoB1t6+ygl16fulT3SPjJgh1ekVSUnZ+
X-Gm-Gg: AfdE7clms2TSsrhl9NDGc2Mm4wPwzs/Gh0yF364mnwtvPtp66Gg5CLjKrMp5fCp9FRW
	boWw7PvDI4240Mc4+L1bqyibGnJcXlo1bBbT67GRpVPeaI8velFw0/5ATPdv/EGw++YubsXwqrV
	otj/IuanjaxILBAqHQX41YULRMzCIOa7t7auxd107rWgq/eXaRkK1TgmZW6xnpDfn/HiZT5AwZM
	1jGnR700imHE5QQ/6PwqbSpn0SZbDv49nddaodwDbFQnYWJ59nvKiLSQREUIixaEAUGki1v4+Ah
	q5WDPHB8U+xDZ2blVCzhd7NwaP7WyYbzlh4jvgHTOXeIFgM6QjmMVI8akVF/lXd7U/ouLpZR0YS
	kGqdSU0Vr3jofbsKnxoVkEFwYHCIzIQerHtbLsiz9yp264DOR34qqTevDDjr3871kN26e2zzHBI
	28nPS6tqZsLsvfJ3ybVx1T0w7FJCWmiWUWPlPkg+eD5RjFuEcvyvCA86jLJ4b7pVa7QMjVr++HR
	uFXOts=
X-Received: by 2002:a05:6820:620:b0:6a1:5cd7:226f with SMTP id 006d021491bc7-6a1893f6428mr479536eaf.66.1782757491124;
        Mon, 29 Jun 2026 11:24:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a18917194csm371263eaf.2.2026.06.29.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 11:24:49 -0700
Message-Id: <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Lorenz Bauer" <lmb@isovalent.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 "Shuah Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and
 delete from tc, xdp and flow_dissector
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>
X-Mailer: aerc
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
In-Reply-To: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>

On Mon Jun 29, 2026 at 10:27 AM PDT, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
> write. That gives the order stab->lock -> sk_callback_lock.
>
> The reverse order comes from the SK_SKB stream parser.
> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
> deletes from the sockmap and takes stab->lock:
>
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   syz.9.8824 is trying to acquire lock:
>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:42=
1
>   but task is already holding lock:
>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skms=
g.c:1173
>
>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>          _raw_write_lock_bh
>          sock_map_del_link net/core/sock_map.c:167
>          sock_map_unref net/core/sock_map.c:184
>          sock_map_update_common net/core/sock_map.c:509
>          sock_map_update_elem_sys net/core/sock_map.c:588
>          map_update_elem kernel/bpf/syscall.c:1805
>
>   -> #0 (&stab->lock){+.-.}-{3:3}:
>          _raw_spin_lock_bh
>          __sock_map_delete net/core/sock_map.c:421
>          sock_map_delete_elem net/core/sock_map.c:452
>          bpf_prog_06044d24140080b6
>          tcx_run net/core/dev.c:4451
>          sch_handle_egress net/core/dev.c:4541
>          __dev_queue_xmit net/core/dev.c:4808
>          ...
>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>          strp_data_ready net/strparser/strparser.c:402
>          sk_psock_strp_data_ready net/core/skmsg.c:1174
>          tcp_data_queue net/ipv4/tcp_input.c:5661
>
>   Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     rlock(clock-AF_INET);
>                                  lock(&stab->lock);
>                                  lock(clock-AF_INET);
>     lock(&stab->lock);
>
>    *** DEADLOCK ***
>
> A tc, xdp or flow_dissector program has no reason to update or delete a
> sockmap, and redirect does not go through here. Drop them from
> may_update_sockmap() so the verifier rejects it. It also closes the
> matching sockhash inversion.
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

John,

please ack.

