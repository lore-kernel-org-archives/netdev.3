Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296057;
	b=okE74ORcE/0fWN4LGvygmOWpb8rXWlweE+nvVGl58XpjNxJFDo7lfo9UhH/K1AHUNZq3
	 mRpjPNy9RU55kA9y77NG0+X3cXXHIZ+66+X5MclakVD8DMM26xWcRL29y4vYCyna314qD
	 FVFTAw8S14xrfSxAIJdUDSETiFW7RI5I+nTE6l22F7JEzJejpYo/IqCSrYpTA8pyzQSuN
	 HYcj4lAUFsWRTXCs2kxAeGqBGgpWZpmDYtunzsXumQ0rxu3bQnfO0xUF8UAyrvKTpRKUT
	 TPRFoYm5MW0MhLvpXm8AGkX0WTaDJ+gwLcRNeL/JoZCevWSO1UpCGMC/jB3xA9BSWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296057;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=LnKFTqEo9mbuMB3ksekDGZNFTkGTEKs1EUyTBA4ZAgk=;
	b=3Sgn1tTd1YyWwW2Pr8ulsOoBkWvuPQiNoqTVguyNVtbsMH24pXrX7neZExIlwiI+Kwxj
	 wTSiIWxsWYhZrhcugfCVrcyiRrQOkc6ij0V6iDpqY5DlHngSpU7HOkm+pskKAWIimqm05
	 4+S87UKhloERP9S0MInjr/IT0L9Z6/HdQrmIaAUsP49wiehPmUDNEf9LMFB5w7BwFTBjf
	 +J5ixU4Ht1lMX4cjlzrkLb2xC7cGu+yDS0VlbgIM2HYWEOs9/qTSEWqvoZ4y6mvJgTb9Y
	 5R9U7trplsXtzBxRFXQC2axMwpBnCpeAjzNhuBCEhjor4dEH63lZZm0mUWBONz26Ysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="fq3/D3pv";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zArYBILc;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C2606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=fq3/D3pv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zArYBILc
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BA13EC0170
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:34:15 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 10 Nov 2026 02:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794296051;
	 x=1794382451; bh=LnKFTqEo9mbuMB3ksekDGZNFTkGTEKs1EUyTBA4ZAgk=; b=
	fq3/D3pvK6xVM8NIp3jUr45mlkh3gL5XIj7Wy+wUU0+7x4lVlWDaOkvRUYnB+FxM
	TCOhCV4LO1pT176AXFl5SiTIsBOqtH9V/4RH2hYaFuRZZB4qqqV6+4ZL0PWTkQCN
	d4patdQLKqlqTYSiAF3FImY4ojaeoLAJJfVBd9yhEvytMIgKKGGz07BIiywzcgPk
	xb1FVrLlBpftuwfRs8kI4jE/HiqhMz4x3cbk2oG8UM68csMZs1Jz5cPdO3TLzk/+
	x3mVeXW6BaYPfLkbfZLTvj125IuKhRDZwP4VOyioMxK0m5co/O3DRRZGyCcks2bb
	enpLv3AnXIZLR9bTlcJF1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794296051; x=
	1794382451; bh=LnKFTqEo9mbuMB3ksekDGZNFTkGTEKs1EUyTBA4ZAgk=; b=z
	ArYBILcUgrIGRz1lb3qNrFqbGGsAyVkdWI3wVWyDZegk9HvSL6HuSusADUd3VYIO
	pUb9r7VEIc6CbEfVKIN0I9WuGnjhE0jij5Wkai20HZa9LB88BemerIsgBr2u/t5E
	KW4xcDNqbZhTYOza5CDrEWQmeL8yvh5BgMLLracQCqKoq1J51+pFmq4WOkmFHeDY
	zmq3Hj8zkDsMUwn0jW4Fu78809Udt4/3tw3dG/D4BNqIit9xrgbH71sqd7FmK810
	6IRlCHS2XlOj7Is7zBxNeTtXcH+tdOurl7iTG1/3F/72WZnLbiMdPGIjetU8Sz5m
	w5XpuQfLmf0U/VxYkbfRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794296051; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d/viNSYqj7cToH5vPbDeBbiIPgvvqfEB/5CzAF0qBb/4ECQ
	qKIHPD3aro5ZQlwOFcpguWUVsvTynlkjWq6FcvGkksOTVGH7NJN7mmQxZRbKXbxo
	OK9JKDJVuMAw6Hjoaa5jtm2uh496PpCE1EZYxlVpq/y3+1GfVbJIykpB39SoiJK2
	0mt4oKEQMLZ5oJkqSXu7jlG7/i75EHaYQ5XSAfhRcwr/QXukZZ9pdGG3eL+wuQoz
	QVsRkOMO2s8X7xT6CYHC9ndUdKvTJ8L+/DM/k5Or7xOHV+7u+E7rzYGhMegBWtyZ
	rFuZJurcfZ1c37Z6fGUfEcWexeY9PWt6TRk66Tg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HzNNTSVlOwU6snP4VpwtHH4KuTKK78D+uRypWvjBwXU=:gagYGVpjjGD3+1swqcbwOX78Gh4QjwbfE5X0sniZH2c=;
X-ME-Sender: <xms:78jyagHF5ucUFYonea1WZ9AZB2w09KlSryvluyLj-q21ZJD2RiPjkA>
    <xme:78jyakKbu2gFZE64cdIwaTt7tHEFPYHw7vMIv-1_djONmBEfYr6a_JQ9S026SgkOZ
    UXtTnvxMkbuenilcoN9BJ630ZiR_JPElqsNGvLNKa3rdmJqV_7k8cEp>
X-ME-Proxy-Cause: dmFkZTGHLteFQwB2pRh05wI0aMJIXZ1AZdSXOC4Y9NU+tN7p3CKPE+8MaPFS9WRYxaiy+L
    ACVRnSG+ehmzszhx9g13HBHQRYgRxFTYsW7Pewg51xbT3jGoUklWLqZk2FpOsJI5hvHDT+
    LoqpoTFVp7a5ucO3Q3ZYqQbKKBYuXBZcnOVMChFx3DYwABFCVT9RNuX7MNQE9xA/vu3HAo
    X+sm4JAsfFwyKdoTblmpAN5OFkNpv6EU+N8y41wdw47guPe+uKUrY0xEFEuzAFYlnaPFCK
    wRV5VMNWACQqPeQ6+rjV18d52qb55Zv9GN+FA2Xj9SHJvrnqYjoWJBBh/2tOz0ITa/xrRR
    WRt9tJI/9FL+wbC/zHTpaLISQiiCC172jDZQ/6e0ngF2mZUpd6UC8eJ5NvF7WxRNHeFmoB
    5rss9JkRFV2WphZirr8fhl2e2oB27LQ6IV0qDZdTd8UiotDXUbCTPerSvbkiRuAfisrmWE
    o5IaGzSSdmY6BUtik+exvzgV++U4P+GMnamBC/bearey2PdDYQwOVjd3q+I9nCnn0depx/
    iA9/pUcffoQ540KDIefQ+hdSW4Odx2udQ8K+sfonIdKyQ4YOMDg6gxtRf6y26S5fLRH/hC
    O5O+zdescs3df7CiGGOEoQwIeQPCx09eWX5ZmRSPl3OGE1mNsSi5caE8DNmQ
X-ME-Proxy: <xmx:8cjyaifme5OFP_Ukm990XxRuCvgWMyOSYAIImzczfsWo0WDihzy0Mw>
    <xmx:8cjyas52K6ktO6Y_ONfy0RM13_hgy8AKm80YGAgYLJjTZnPArbHv-A>
    <xmx:8cjyaht-24XkkG6K5JYZEWReFV8WEaTRBD_wZZPvzkWZjyBKeLCujw>
    <xmx:8cjyakhT8i4utIUKsMNKGJU_diMTS7VPCplbb1l-Rjn5iphT04tTmQ>
    <xmx:88jyansGq6ykRA_QRrQn9WfbiRT0-QvraK3nqjHpJusf5rr1favhS36A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CF4B532A0099; Tue, 10 Nov 2026 02:34:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ABcdwAwP2ymk
Date: Tue, 10 Nov 2026 08:33:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Nicholson" <mark.j.nicholson@oracle.com>,
 Netdev <netdev@vger.kernel.org>
Cc: andrew+netdev@lunn.ch, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <d38d53f1-91a3-4537-af2d-036a957ae092@app.fastmail.com>
In-Reply-To: <20261109235730.2519016-1-mark.j.nicholson@oracle.com>
References: <20261109235730.2519016-1-mark.j.nicholson@oracle.com>
Subject: Re: [PATCH] myri10ge: correct uninitialized variable use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 10, 2026, at 00:57, Mark Nicholson wrote:
> Compiling using GCC 16.2.1, for aarch64, I see this error:
>
> In function '__const_memcpy_toio_aligned64',
>     inlined from '__iowrite64_copy' at 
> arch/arm64/include/asm/io.h:260:3,
>     inlined from 'myri10ge_dummy_rdma' at 
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:535:2:
> arch/arm64/include/asm/io.h:217:17: error: '*(const u64 *)(&buf[6])' is 
> used uninitialized [-Werror=uninitialized]
>   217 |                 asm volatile("str %x0, [%8, #8 * 0]\n"
>       |                 ^~~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 
> 'myri10ge_dummy_rdma':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:511:16: note: '*(const 
> u64 *)(&buf[6])' was declared here
>   511 |         __be32 buf[16] __attribute__ ((__aligned__(8)));
>       |                ^~~
>
> The correction seems to be straight-forward to silence/correct the issue. The
> additional change to the simplified `__aligned(8)` macro is suggested by
> `checkpatch`.

The patch looks technically correct, but I would suggest
improving it in two ways:

>  static void myri10ge_dummy_rdma(struct myri10ge_priv *mgp, int enable)
>  {
>  	char __iomem *submit;
> -	__be32 buf[16] __attribute__ ((__aligned__(8)));
> +	__be32 buf[16] __aligned(8) = { 0 };
>  	u32 dma_low, dma_high;
>  	int i;

1. It is a bit confusing to initialize all 16 words
   once and then initialize half of them again
   a few lines down. For consistency, I would use
   one style consistently, either everything in the
   initialization, or everything individually as it
   is done today.

2. You only fix the bug in myri10ge_dummy_rdma() and
   myri10ge_load_firmware(), but the same problem
   exists in myri10ge_send_cmd() in the same file
   where the compiler missed it. Please check all
   of the driver to see if the same pattern exists
   elsewhere.

        Arnd
