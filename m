Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248959;
	b=F47sjklDOK/eJTARIy9psXiLjVzSbyXY1TXPrRcU9Nq9dL4SOy0fvtC+UnWgt6KbsBvG
	 U3Kl0646l3+mI54FQmsqPEAMYHoGxiWTE5vjA5ds8rsUjUOweEeJzDSTG1/TJb0G8yohP
	 LjHpaHUEqoUwCmNKB1EMbBoYvdQubpLhGdODICspQ0uyaqkfTvs9AtLckf52+4Bf3AaV+
	 xIkCq5Ir1YjNGXXpDK5BJ9IRRYXpL58qAjNL0QNUAY6U9ydgtiHS4/FJYDrWIv1xOvZKW
	 T0mllFEWt4fz9KFp6zGdCmEP9hlJ50c3QO9AQKvcuB4l7BwvFPv8/1jbC7rBSJdnp/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:In-Reply-To:Subject:Content-Type;
	bh=9ABICdwqhmlXu+0O9sYf0hzD9JleqZBucAewgH7hCEo=;
	b=bDJC6DA51ObqxRA5+LdzZhAPJ14wjwyQmsHJyjPMtqNn4z3bpJxs9e40tIzJXA+wUEf4
	 K2Oe2nMMKDVt7ZZIdvbKmVTIWqRpHAnIrbXZt0RL2RixDLBBUZnOC5h0fOMdqTXOSa9jo
	 IXmAEQJZjGYaK2LjoZyPaVfDdiIXeNPfB4hrSJvvlXS6KdlPg1vgsZ4fs05vRr8IYmpQr
	 /3GR/iJNE8dFNsBIYXQvD1W3tefm7CEwEqYf7NOM7uiyijHN6r70KQRJdnZsnsUqaH8H5
	 B43nqp2SMJ218QQ5ErsEDoahyjaXZWfheojL73oTy7pe9ARBbSHe11JtMa4GDW+30kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLFcnmT1;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F8606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA5F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLFcnmT1
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36e06480786so550152eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248958; x=1794853758; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9ABICdwqhmlXu+0O9sYf0hzD9JleqZBucAewgH7hCEo=;
        b=jLFcnmT1udEkBHH8ARZmBU+AHoffdfpm15WgGjDE73KYjuYejVwNQNw4vhBCFbzzSZ
         3HdPMNTl/3sOA+nmNz9n9I3cN0gI1TLo2PuQhNV9jjJ2mdGIaLXQuSR9lEXNTqJtiEGT
         b0ali9Y0D/2oBxr5WuI6PYyCSKic/EPQHdL40/bxKAyTduon4WIMOaG8Czke1mc5FuAn
         7NXD3qXGcob7VykrCwbrZOpUZfPsRvMEcatTaNLvZ4DB/VrDCPWBmccSqLSG4klLZ3zF
         cOKVFzgLV1jlFqnSNxPQQiCRxZa/1qLNeXnSMrUteziGLz6fVM/kBOjY5Xi1sgYAs/5P
         UlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248958; x=1794853758;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ABICdwqhmlXu+0O9sYf0hzD9JleqZBucAewgH7hCEo=;
        b=HHq0qwcuwPwmHkykco4Zqog+wzgmDPNPoj6ON34jDKAsgvymlWDjyqq5SOU8XOHEP5
         E5pOb2pTyEa8AnWFm/ed+ohAOMViSB+rpm1VzMreG5kIgsrNMtV9uuMVM0LKm5okfVDj
         61tvE58sP8EaCE9DW+ozIG1pRDqXf4HjBbs+v/Kgu68yKPi01/wQzCCC1yrpbdYTjjND
         Iik72Cqs+PbOxBodzPw2wEbSaHnEo7F7ITJXSAQGbNZ+xVMPONMsQkZ310CizhxRdizE
         OsM44LoOpy+PjzwJNyCY36+JJOGaZRnow/hPb7ejOb2nK/9xmt7TAgHok0EORgVfHxFq
         l/mg==
X-Gm-Message-State: APuU4Z/c7ANl5x4J8T/Z07ROeHEdQ1X2sn+WP3UUO0qZxSGK3l7K0sb+
	Cfe6m7KTsAOvCkRvRtcAZS1kfIWatvu5I02AEmQjRUb5ARzQ+Yl7X15I
X-Gm-Gg: AYBFou34wFR7Gws5ea7bOX17e1uWM/pWN5I7FqgzqOyY8EuzwH2wo3APnGn73Jx3Bvu
	wJhEA1jtWJtiHpclE708EkRmlgFB6xIUcriYygW4PUFVn3ltx9KmGddbJmo/xnVym2YAm9qHQLE
	UNfIEeGdl+2pT+5x41pebl5AmDhIRHRDQIlrxcOhF4fFpQbrFu5M6sjE57Ufl9F8ExncRtEofPe
	dvPU073x2lN06+Vk1m6fDPUHboDA78BzbAoYMRtGToJjNxrWA8hg332TuIQir52dL9w+hCdVLzT
	ScunLOf38pQBso2T4M+hc820pNfHYIv3JsoeQxYY+J1xVYr8ySlfkCA0cGZCWZDUi6e5Ov1N+VR
	20+Sb0HA8rUwYVyHw/P8kpzaCYIrnTS5LxmQOvbJ4B4wkaaEYugoa9QmNpJs0D/QR/AF4M03ho4
	zIrl2nDa0qCVqSMfjDV9DJ5edENLfE9KBiNOljAohieEGX5SfEOKwrB2iH5TdJUgzzM+u52yggM
	SWoIoN+M/VqvUfEXwmPf8JuTdYdWal7RAp/TCn6rJIOjODawk8PkW5XM61jfqofGOobhDknzJ9x
	0+g0f9YaweLhwqVeCvUzbaaXjlBJzqtCVdtnNyfUJTjD
X-Received: by 2002:a05:7022:b90c:b0:1a1:8bac:c1c1 with SMTP id a92af1059eb24-1b3b5fd4344mr353755c88.15.1794248957752;
        Mon, 09 Nov 2026 10:29:17 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm722817c88.2.2026.11.09.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:29:17 -0800 (PST)
Date: Mon, 09 Nov 2026 10:29:16 -0800
Message-ID: <3d2b8463b7ea74cde9327a3b8678f1e5@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 sdf@fomichev.me, dimitri.daskalakis1@gmail.com, almasrymina@google.com,
 dtatulea@nvidia.com, bobbyeshleman@meta.com, asml.silence@gmail.com,
 daniel@iogearbox.net, razor@blackwall.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, leon@kernel.org
In-Reply-To: <179418738408.994134.12387400537759262351@kernel.org>
Subject: Re: [PATCH net-next v3 8/9] net: devmem: size TX net_iovs from the
 dmabuf sg table
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

> [Severity: Medium]
> netdev_nl_bind_tx_doit() now passes niov_shift == 0, so a hugepage-backed
> dmabuf gets 2MB TX net_iovs. Can a devmem TX frag then end up larger than
> dev->netmem_tx_max_frag_size?

[..]

> Is a cap applied only at build time enough to keep that contract?

It's not, same as reported for patch 4. In v4 tcp_clone_payload()
won't merge net_iov frags, which keeps the cap with large net_iovs.

> There is also a related issue in the same code. It is pre-existing and
> was not introduced by this patch.

[..]

> Would either of these fix both problems:
> 
>   - compare skb_frag_netmem() and apply binding->tx_max_frag_size in
>     tcp_clone_payload()
>   - don't coalesce unreadable skbs when building MTU probes

Not merging net_iov frags in tcp_clone_payload() fixes both. Mina's
series also compares skb_frag_netmem() there:
https://lore.kernel.org/netdev/20261108013838.1454450-3-almasrymina@google.com/
