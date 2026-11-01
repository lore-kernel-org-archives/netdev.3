Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793527381;
	b=fgJ0dvEgB/O/vXj5CbPRJHgFS1V2mjmNIlOsBLAOzYlR8iA51xsOsEZ040n9tUa2Kzwr
	 LNTPStjcgZpE5SSVx0Bb5NxCItf3lEDI7BqNdGi/WKyQKOLRpp1oU6cxuo6M0foypLdja
	 +ZYF+Ibo/+2eQQezfdA1UG4aa4riZN0yFsAt4IUJS6XUhR36BLmGDt6vhtVEMLLmF/V0u
	 jU6sfXKc8/TBB5xWZbcfLca3GrKtah1n/Xa8Gy+8goBRGMxgRSD1a6RNMC5SD1zFx2Koi
	 TRiB5oov2mqMPO4oLz0XoApF/XuMNgstPBQugWBsnHCshHW5n8fKyXIB71dKYgNiebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793527381;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CcUb3OEvt4a1yV7+AYfYcqheRryY6o0DxYaBOwnyDcA=;
	b=nwChHectD+fnVCnYHoDuGxyPv0vyX5aiC4ONoAH/4lWPLinRoo7QUIhfse0PpHuKJExh
	 HPDDBdMlZhanwikPB3HsL2Dis2D1RjJ5FJ8LOhy4e8CZLreftrhKzQyJFsBFZMO/3cCfG
	 1B+k7/91a9kZ5TOKsWaTWQDbeHdRdiVTV0G3EZhfzWbCbkcE6Rxd8vP8m8KhSpVXSMaSF
	 PRqyHRxRDSEpDkSLExjWdkiZKtm7Hl1fu5CC9dBNdV3w0R8NtGppkZOawpyhUpCaiiwC1
	 6DRcT4QZofCzLPcvRM16A1d9e2BZWT0/eyEV1fUMRpxxKv6mTwLdFnvLwlpyeOCgI/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bkok4EIA;
	arc=none smtp.remote-ip=95.215.58.121
Received: from mta1.migadu.com (out-121.mta1.migadu.com [95.215.58.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40579606A32E
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40579606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bkok4EIA
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yYCz03GhobTxtAJpUtamnKh4J2bHZRJOFBYPZ9SOXn0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793527376; v=1; x=1794132176;
 b=bkok4EIA52/J3efDJoMJVfywKr7US22/DAlWiNqZKvXQnnAEwwOsmbWg8vLsWZgXfPE1v1lE
 8WWh9/sMEvo7+aoQCBrofccYLf6BWEH5Pp/hXJnfxRqgXISey80Lv3f+mRKsjj88tOZpZq5Brp3
 NhhDWjlsBG1IszXRmX6Etf3s=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7d86e53af7001ace;
	Sun, 01 Nov 2026 10:02:56 +0000
X-Mizu-Trace-ID: 7d86e53af7001ace
X-Migadu-Flow: FLOW_OUT
Message-ID: <062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev>
Date: Sun, 1 Nov 2026 18:02:48 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: fix device binding after failed IPv6 connect
To: Xia Yan <yanxia@cmss.chinamobile.com>, netdev@vger.kernel.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yana06070@163.com
References: <20261031074654.73952-1-yanxia@cmss.chinamobile.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261031074654.73952-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/31/26 3:46 PM, Xia Yan wrote:
> tcp_v6_connect() sets sk_bound_dev_if from sin6_scope_id when connecting
> to a link-local address. If the route lookup fails, the failure path
> clears the destination port and route capabilities but leaves the
> device binding in place.
>
> A failed connection through a down interface can therefore leave the
> socket bound to that interface. A subsequent connect() on the same
> socket to ::1 then fails with ENETUNREACH, even though a fresh socket
> can reach the listener.
>
> Save the original device binding before processing the destination and
> restore it on failure.
>
> Found while reviewing the error paths in tcp_v6_connect(). Reproduced
> in UML by connecting to fe80::1 on a down dummy interface, then retrying
> the same socket against a listener on ::1. With the fix, the retry
> succeeds and data flows in both directions. Tests also confirm that
> existing device bindings are retained after failed IPv6, IPv4-mapped
> and link-local connections without an explicit scope ID.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---
>
> Tested in UML on net fcc00b15cb21. The complete tcp_ipv6.c file is
> unchanged at the base commit. Before the fix, the socket remains
> bound after the failed link-local connect and cannot reconnect.
> With the fix, all 12 checks pass.
>
> Build-tested on x86_64 with W=1 using configurations based on
> allmodconfig and allyesconfig. The corrected tcp_ipv6.o compiles
> without warnings in both configurations, and incremental kernel
> builds complete successfully. WERROR was disabled for both;
> allyesconfig also had KUNIT_ALL_TESTS disabled.
>
>  net/ipv6/tcp_ipv6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..7bb8266d9d1b7 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -146,6 +146,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	struct flowi6 *fl6;
>  	int addr_type;
>  	int err;
> +	int old_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
>  


Reverse xmas tree please


>  	if (addr_len < SIN6_LEN_RFC2133)
>  		return -EINVAL;
> @@ -358,6 +359,7 @@ late_failure:
>  failure:
>  	inet->inet_dport = 0;
>  	sk->sk_route_caps = 0;
> +	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);



inet_bhash2_reset_saddr uses sk_bound_dev_if too.
  inet_bhash2_reset_saddr
    __inet_bhash2_update_saddr
      inet_sk_bound_l3mdev

So I think we should restore it before  inet_bhash2_reset_saddd ?


