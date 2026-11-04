Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751255;
	b=TBA8WdhnqeW636JztNsBSnm9Ubma8uU3s+eyue5i0NatOAsdb3jY7xj5pK63c1ml3ib1
	 79xWX9vXyKp3OAgKYrVtL/J2QEs7XawUv9kPe/nCxtYfay24m2GJhdRjwlaSrcamREu+Z
	 qlgG2W5yHFFzsZ6tCMrCieLf6zEU5JoaozRVDG4+RaM1CvlmgBKUJBtouioI+o+LWE3Dw
	 EA9r3DbMXALUIKc8YNTsHshDl8jO6tCtzPM5neN9DE1a6cWkX0nI70+a8O4TleHH9KqRT
	 Wmzc4S6jUFOtOj9yrsJobgEYm85bm6VNBXXwbdR3RteCtB3w6UE0ep9IeZ54lKf1/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:In-Reply-To:
	 Mime-Version:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=0C3vS80b0D+y+F8f8rSDZook9rRTV5pBeEVsPEFc3Yg=;
	b=vtGTNcOenwfdCbtlGPtfYc/5XjuRTxbqw2gKuQOTPSguNP6B2Q4k9E4kVmrGXjFP3JJ1
	 l36n4wLQ1Q5YTCOcHiuBN9eFuUJu+0vNdc/bXiTJIq7VxYmliSQDposZVF5+/gsHot5DG
	 L+5Uby5Pb/O1ioCe6a2vie5DGCgsdX3qeRheTr4ImWy6RzGQJ8S6E90Sx6of7MRphD3C7
	 QhHYgLI0uUPAQKynLzlJgcA+SOM0zB6Jw7KsBDcYF1haHusS/gdOOHamOG8IhsgodMqqH
	 uvssiLQOpxHAughOqvtxLZwmeX8mGWkRWLvDELqaFNtHMNavYszurmoEKeKO7YQESBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gpsiXt+L;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F8606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gpsiXt+L
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so380326eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793751253; x=1794356053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0C3vS80b0D+y+F8f8rSDZook9rRTV5pBeEVsPEFc3Yg=;
        b=gpsiXt+Lx1ZaXcGETB/DpG859ORQWw34HeZ4i/HbRZkr2HrHRYRnlQClCxPPrvdMBS
         GEflGEM2njFo3OKgBIVjNYlaCgIw144SlM7nIaotrEa0MWvxmqBS0BdWomjoHGW6iEeP
         DeFrOHsmBQIbnSwRrgOLE8Q2EwTb8Q53jI/z2AJw1IC3Oy8XIJMd2wDBXvvDOxuaO6hN
         bcKQqDRyLcWauKBNgtcURfJ3O4vAUZ+PsMzZXXFoC38sJkIdqiWyppoZ5/AuULZWjF7Y
         E6+t00iSLmoJbKR3NDF32G7Y8yMxrxl46JsGRRlo599aOF2HOj7p4J4j1ksFDMw0v5If
         Bblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751253; x=1794356053;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C3vS80b0D+y+F8f8rSDZook9rRTV5pBeEVsPEFc3Yg=;
        b=hFy8zfvd9ZqOl/xyN+bE5OhSYTB7PAUsC2XOJf22iC4PLAff9sCvvJuaepnr6RnwFU
         5dBPtCI2LzylS5b+HmBs/Q4+HZHytCF4qwx24re+L5p7DpGduD7drW2FgMUIW9gqSSvH
         t3MucMeDSuY8oMguruvzs6YjZUVsnM36qCm4sq6cGPSwIprXCMLx+V20qmIXmGAtBKbb
         PPGwX8sgaSAGTaKhwetRC5ukBSe/EBZyArtqviCaEHePdxkdVZ930pMCAVEKJF3jfwzZ
         rVPS7+Y3IgiH7L7CPZ+m4gRjSd3kEs6WRFW1+nUlQ1NsdAHhdUiUYT0axFYB6oSeif6w
         nP7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwF+iaKMN1VKeRChXTXyKaDeVF9+lPMNKn/z8HgAbUJLr/7f6WXVLI+C9Awm0H5OyE3+WrqFDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z98EFnFWU9hdSmwkkIc3MaDPshEM9y2tsvJgfH7+dcauTLqr+cb
	qZBlw0sh23BesZgbo7aLz1KroqoiUVmZu+hKBaR+C9jE6rSGhv7RQYxz4FPYMcKpAAO6LYmEQSx
	hyLa/xLCb9mJhdGiNIoQbug+ohw==
X-Received: from dyclv23-n2.prod.google.com ([2002:a05:7301:6197:20b0:36c:a067:eca4])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a945:b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-36a423b3556mr37881360eec.21.1793751252976;
 Tue, 03 Nov 2026 16:14:12 -0800 (PST)
In-Reply-To: <20261103235152.1904727-1-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103235152.1904727-1-sdf@fomichev.me>
Message-ID: <18e4af42c8b279c4.3137322e32382e36372e3935.1c58a7.0000sendgmr@google.com>
Date: Wed, 04 Nov 2026 00:14:13 +0000
Subject: Re: [PATCH net-next v2 0/7] net: devmem: size TX net_iovs from the
 dmabuf layout
From: Mina Almasry <almasrymina@google.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	sdf@fomichev.me, almasrymina@google.com, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, razor@blackwall.org, daniel@iogearbox.net, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 3, 2026 at 3:51 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>
> TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> 68KB, which makes BIG TCP ineffective for devmem TX.
>
> This series picks the TX net_iov size from the dmabuf sg table instead:
> the largest power of 2, up to 2MB, which aligns every DMA segment. With
> a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> no UAPI change since TX addresses are dmabuf offsets.
>
> TCP still bounds skbs by size_goal, so frags get larger, skbs don't.
> A single frag can now be as large as the skb, which matters for
> NETMEM_TX drivers with tso_max_size above 64KB:
> - mlx5: 32-bit length per data segment
> - gve: splits frags into 16KB descriptors
> - fbnic: keeps the default 64KB tso_max_size
> - bnxt: 16-bit BD length, devmem TX frags are capped at 32KB by a new
>   per-device limit

Reviewed-by: Mina Almasry <almasrymina@google.com>
