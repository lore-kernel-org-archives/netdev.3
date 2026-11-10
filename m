Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278862;
	b=4kSAf44wJ6qkxBTXAIcvdeb9tzEiueNddBxGJhNixOO8PrVF4hIyWPCvLTyUd3xxMSlc
	 2WAkmVsG3xNEmpQ3uiKSxS+9Objt1SjJmaVX6WFT/en5yf8sXRuNrb0Yr+980ePT6TbAz
	 73x9PQh0vjuKkeD23TLRYHHfDNsfmcDI50VzAFOJJc+CdhXW6geg6h/A07BsKrHd0nK43
	 RbWwuo9gRRHoNhshfySX43m5XbKOwCP6MdfAy4IRDy4kv/zmFQGX5j4wDhQlwl2jSFbtT
	 qzeYXw1KcXYGk1EEMTYiFFwanNrr7Sk4nJcJj9qhrssZJD3CiTxTwfoEm8gUsXS+zpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
	b=XM618W1/Y495M7nkEnvBjXqGPr01i7dhVh1MW7/YVVsBU6uTmWoMfa1wYfmwFtQIU4Rk
	 ClvuBNFjDJK0RkTUS/9aSVBBeyCPETF7mRX4v1SsRdJRiN2maA5BXWzf3ehrFHkpFZsNR
	 g1P042Fq4N7CtzBbtrWRWvEJ0K7xmV8h6aCNhapcxkJwhM8pwvQnzqshMfFEgykewVx3I
	 Ugza+nAEF0yrCn+1ZcnFCdIx6i3EU31tODEUEy9EJD4OVo7z7yrdJ1N05dGQXIVtbLixp
	 B4ZuiKYpu0DbHwwCOEYmS4RsdmaYq5dOU19N+IK9Ul9VPLu+UnT7GDhLQR7fe+eTJ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXDhpVPK;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1F606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B1F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXDhpVPK
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-99be54f9c14so1119827241.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278861; x=1794883661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
        b=xXDhpVPKhEwmXYlSdgVQWRD0yKtOa/0Jw/dE9lGk+00h/qpIBRBu6nYBUWXUzsBIKu
         Mk8lf9mhxkiuZuVqgGV/DcNb6gN+cqUzzGaoVl5hEoVetgWT1Qa6qEvst+uqueb0Rluy
         rBpM45G0Kgmf7f7iLFzxPiXDygzfN35egxwAa8x2ibzfO5rHCUYA8aFVS8vz4Sid4MJh
         tx52lBzwWWNdu2Bllk8DdCHnir32H9HeDfZcmF9poJ44gPcpBRnEuLO/ceeQNmo9So/9
         ZnR5bGpZAXa1CAiDxN+3JKm0XU4q8b6B+hCLP1i5opauNmPLdkxI/Vd+TEPrE4qYv449
         BA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278861; x=1794883661;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
        b=BJoBvTwLnVf6DhsNIbRc8jaAADOQOT1cXsKCGm0Bt+uH/1Tq1GwNUPieV8CTtDrGGF
         Ta8vJCcGhnDQ0eDhGZ7JG0dJVEmP1vekzkB9FZ3DuX85beIEwwg1nYJVBJkO8ml+vYv+
         n4Dh0AwgTsNtQyM2NjrZ9sGfGH+QfWJ/pxedXWcmR0tvq46c4GCPDcOwpuA5WzJXVu0B
         3awwatOUTZGH5xA1eSIjQgP4jOfj2PR21JMgZfjEDKSsrYcIc3VLbznTPlhUoK83nLp2
         0uqARJNnCaCuHFxAa+M6mE6ZzJX3QtqyhuWd+qiWZ9DZcgLZDNO+bh9gyMwKIIe1Qe19
         C1Mw==
X-Forwarded-Encrypted: i=1; AL+hErGzK/ffxeVCrD2soEJ31BMOh8Wp/hsxDZVyqjqvLDLryHp6Yh6QtxL3vs5JwkTcPpntUDcEuKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/psNsEcmswILpejIVW1coL2ncBKoibCFv7+XdMUPhmVPGurNSK
	xxrD6JswOkRO/ZcjCCa/Hd8cSeUkgT9pDcpk0QNQGF2JqWBUKWoz6BXg
X-Gm-Gg: AYBFou3B94a0SXD3TSoprNTcHX001Dvg+Jl8X5V8CecMR/ApRhs5FAO86EV+3jGLg08
	bzA1NAnvJRw72Eo6d+peILtw1JHFjQAVfnsW5ITtxU0Pm+lPFG6XXrv0LwiVc/WVA/BKZTheAjk
	5V9UJ4WskFAVWn1TppPprenBgZQ1R0wYlqsQC9kXl8/1wQwwgE1dZucmBsT5FhbclqH4S+OYQw7
	VsP6tbrh05TFvclO4+x4KRAmVxKhoT/y6Lc9VNPGjinBh8QX7qEGN8muLfIHGLcneqMqArPg1mg
	jpT/rNHvIcK4UcUxaY8psOfU5KYYfXm0dL4BIVlpIMTZ8gcn2LpEpmOiHa9gmXwymI/Px/oYTjz
	tU2Eh7yaEHfhmE3/DbnL1v/4Kek+IZGtKOkoHiOcR0eZamuO5hbv7w8HoaQPaXasE3h5ad4Dbp1
	EtcEAXBK59AOAA61sk6ygDZYG1QdjxjK9Ybv0k8fIbQBMGcXubzp3gkS8/AIfF0NqH7/8VrUPMf
	wdz+pY1WVHnb13WgLZwhe7hmgqABPAue5m30iL1vTJGE+Tzx5evXASAwPPyE8988+y7y0JyB05y
	nebSosZpqEUkUS3bTmPQmrpqEMg77w5zPDiqrcnKj0ySdHKTNRlrA8UO6WLlNfDBiyncePErAmj
	bFEpOkkCn6KXOL+gd0zwVrUNn9Awd9miuVauJzPqRVYX3YsLWAELielvyu4MjEWNWhBpuJUY=
X-Received: by 2002:a67:e116:0:b0:7d2:d876:fb3c with SMTP id ada2fe7eead31-7d3011e2755mr389213137.35.1794278860666;
        Mon, 09 Nov 2026 18:47:40 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2019bf87sm1116873241.11.2026.11.09.18.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:47:40 -0800 (PST)
Date: Mon, 09 Nov 2026 21:47:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.2c8d7027641a5@gmail.com>
In-Reply-To: <20261109014400.9025-2-yanxia@cmss.chinamobile.com>
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
 <20261109014400.9025-2-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v3 2/2] selftests: net: exercise SO_MARK on connected
 sockets
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

Xia Yan wrote:
> cmsg_so_mark.sh sends to explicit destinations, so it does not test the
> route cached by connect().
> 
> Add -k to cmsg_sender to connect first and send without msg_name.
> Check connected IPv4 and IPv6 UDP, ping and raw sockets with equal,
> prohibited and zero per-message marks.
> 
> Add an exact mark 0 prohibit rule before the connected cases. Connect
> with an allowed socket mark, then require rejection of a mark 0 cmsg.
> 
> The same test fails four IPv6 cases before the kernel fix and passes
> all 54 with it.

nit: empty line before Signed-off-by block

> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
