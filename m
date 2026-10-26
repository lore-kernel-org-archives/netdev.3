Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999995;
	b=c/wSZT4/p9a9eM3riF5JnOIEcS2WLtUfMWcMUnPFDzlhHIZjFQjoGakHYcG6S5lpQUDi
	 6EmM2+/dgTB53EiD66KnKVEyKr9LPO6NcTpdJdqkO3z/2UNMLwqgFJ33ycF1wLaNkmJaI
	 C0R7299kCXUNfwTggbBnlQ0YK9TSIR+Dt4U68NGkVnHLRxk7lJ97LWKpK3gSGQvu6MqHM
	 1L4J5y5dz+e/Z3DfslrylUZjtKxjBF1xKLpKBMb37Dx4TCWT0OQ9G3Au826ECZlTiA5lp
	 EuBhaEgUuhhdmUaPT2dh2v+bAFYNaQ0aZbPoGOeSLMarXXUOJl0kwwVGqPkdd0XXdcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999995;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7oPMs0d7czZDgpisnaM9AZCe31nOE82TuAm2YPxvoec=;
	b=erCFC2hXWtm6COgyabSaOahaDuPE5XRlmuKxkWyKvJ5oxyEBvYPm6Nm1fG37D5cGAJRC
	 ge9SSbyuPrqgC1gA1fX4adh54uJN9w3rFS3g77lNEXmWcyUU83J7nydcqrnUUSUzQoLbv
	 Ys/pc8Dq9sX/DGzwjhyP/XUHHUJS6P0chV/RHE7AM0nZoImRZ/3A4mk4A1uh8eGUaZO+8
	 bWX8KqtEKAalu2fOhmjnkLt5BCtdhnAg2x6FTQegUBRk6JEGgNFe5WwCpvTqFAUtDrDxn
	 gdPfK8fzmUUFFTb2j95h3V1U3TL/x2oExSCy3gPhWyC4oEO9hZqqNbW9zNWSXyWi9ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpZjsW6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpZjsW6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7861F031E0
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999994;
	bh=7oPMs0d7czZDgpisnaM9AZCe31nOE82TuAm2YPxvoec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OpZjsW6umHSAJmIGuIlw0vg3e6dV/zUq02ZzorYxiCk6cN37MBJNachEl0rKqkH8i
	 v3Nk9jJAzZvvuZD8JhipJyWbvmoN8ICO7VxpsH9q2R6JxH6u7/Dn99BqrXDx8AiqCZ
	 B5ikN31G5bl2To/jKxerWsJBAKubEO5lGcVSuR7tTY8OFurF6B32p3CkdvVAIF6M3+
	 srQYhcb0mK+7RiMhIcz5qy4l0KAZ/oSpo5BbqJCMDeWMDYxddi4V1pTm/bbTxdW4FX
	 HmAggB67Iyb8OrgB6ScnD2lVZep61hF8ZzPQwvPzMerEwL09lj9mHyCdzYK3z0cFEe
	 yszlz25KU06+Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-475920b9ca2so843639fac.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcg13CEuwikwTAoU30rBSutf6WwCI2iUgQRziGw1vg3s+DXbX1cozBxOZvLwl724550CxfIn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgy2cDKKxMIttilw4+MXVM94sKX2glmNwrLQYka96xlcyvizh+
	NBUdWxOLJmWYVzYJ57URhGpOyovXtm6cO0KdidFKb4/SEWdpK0Z3u9C2GNgTULOO7EH+P2YysNA
	uADZZ+vKmEyU1hsPZpH5T4j7zvbOf6wc=
X-Received: by 2002:a05:6870:1702:b0:486:a82a:a345 with SMTP id
 586e51a60fabf-4a83f588cc1mr3264518fac.25.1792999994001; Mon, 26 Oct 2026
 00:33:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026061300.256009-1-qingfang.deng@linux.dev>
In-Reply-To: <20261026061300.256009-1-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 08:33:03 +0100
X-Gmail-Original-Message-ID: <CAL4WiipU7wttXiBu-+CL=DaP4nfnkEpoMm01uJWorSYdS2fb9w@mail.gmail.com>
X-Gm-Features: AclHuK_dI9VeKqD4E1U4bCUOsW46HKqWcruEWLK_U7y7CH1Lv7Vlz9PQFvLLTb4
Message-ID: <CAL4WiipU7wttXiBu-+CL=DaP4nfnkEpoMm01uJWorSYdS2fb9w@mail.gmail.com>
Subject: Re: [PATCH net v2] pppoe: wait for RCU readers before reusing a socket
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Guillaume Nault <gnault@redhat.com>, Felix Fietkau <nbd@nbd.name>, Eric Woudstra <ericwouds@gmail.com>, 
	Asim Viladi Oglu Manizada <manizada@pm.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 07:13, Qingfang Deng <qingfang.deng@linux.dev> =
a =C3=A9crit :
>
> When pppoe_connect() disconnects or reuses a socket, it removes the old
> session from the hash table and resets the socket's fields. An RCU
> reader that reached the entry before it was unlinked can still be using
> its address, ifindex or next pointer.
>
> If sockets A and B share a hash bucket with A preceding B, a concurrent
> __get_item() looking for B can be traversing A when it is removed.
> Clearing A->next then makes the lookup miss B and drop the packet.
> Reinserting A can similarly redirect the reader into another hash chain.
>
> Call synchronize_net() after unlinking the old session and before
> clearing its fields. This allows existing receive-path and
> /proc/net/pppoe readers to finish before the socket is cleared or reused.
>
> This was found by Sashiko's static analysis, and reproduced on a VM
> stress test with KCSAN.
>
>  BUG: KCSAN: data-race in hash_item+0x1c/0x60
>
>  race at unknown origin, with read to 0xffff888000a1c566 of 2 bytes by ta=
sk 147 on cpu 2:
>   hash_item+0x1c/0x60
>   pppoe_seq_next+0x112/0x1b0
>   seq_read_iter+0x595/0x700
>   seq_read+0xb0/0xe0
>   proc_reg_read+0xd0/0xf0
>   vfs_read+0xbd/0x220
>   ksys_read+0xa9/0x100
>   __x64_sys_read+0x47/0x60
>   x64_sys_call+0x98/0x1fd0
>   do_syscall_64+0x5b/0x260
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Please next time include symbols. (scripts/decode_stacktrace.sh)

>
>  value changed: 0x0002 -> 0x0000
>
> Fixes: 72cdc67e7fa7 ("pppoe: remove rwlock usage")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026102009211=
8.47416-1-qingfang.deng@linux.dev
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
