Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C23F6C30
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170793; cv=none; b=Z9Bbt3q1oghMrLldKWpcZVYdArdCaLD7PxW1+NVtykMdP/MQ64EyDJyRA74gSCp3YSOWw12I/CbAFWLJVsr8D42HkYAI4rVXcVguc7ZG/AvtKlmYLamzteAc9U+CG+yRwe97NpYFZTW5X26FICq6IRUdM7RFdXM6tQad+E1R5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170793; c=relaxed/simple;
	bh=kxId7MQ+zAvhC7OwaPwhkckeA9QjpjzDQQBUn6eAd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo/2qoWPT6yAxcCo+i6tnRT0hO9wH9HYqk+vxmsQ7Z5jesZWBPE561ti2KtHXxqVHB1Ci5i/W+5cyVn7/RQ7mccoKv7BwHT6GloTJuYuTHQVhiTB7lS80CCLVQtsuKjTPT/m/x73R9J5hYKuHjH0ZEx5E8sSSEm6swF4vXvByCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5E2PqIK; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5E2PqIK"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so1526293a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170790; x=1785775590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LGI9Ok2z6wQiVHpWHpCaegm9SgY2u01YCFL21u/wvQk=;
        b=D5E2PqIKE0kDgI3jDq0XJEr4FHBC8ExrcmLlslyieCGr6zXHBfKFietOZATzxCvfVz
         JtW0ZA35howiVbKBGSdiZ5dlwfanEYd2oLQwYZn/gdm+q3Owpj/3m15FpE/MIL6SkqKd
         owI8KXgsyvhJj0JCFrUJ7DO3agtZLx1lfpqRCenib5w/JmKb2agQfhCV7vZN/SPJoMde
         X2sT8b0UkAlKY/T9EUjB18DddvJPudd+m/kkAEMJi4+Orbd4RfqY8dwIOAnnwH5k4qTc
         iS1mcXupggbc5hfZAMkV7ZSTphQImPS8gSSIHTSTr+C5KTWolf7+LX1zvd++Pjs/L2WO
         DMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170790; x=1785775590;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGI9Ok2z6wQiVHpWHpCaegm9SgY2u01YCFL21u/wvQk=;
        b=b/sIsN78uL8O+Bxtz1DU8BQhIFFUVIqJsqtcGcxCfpqk1adhUeR5Qw3irb7HheSQaV
         gyOPwgbvmUWiFuqgmgbFHcoxebbSnbcaW7Bw7sxhmKCWGwWe6jVXUiLBcoCw+nCMnryU
         neyQxT18THc9A/TrbG1F1gP0zfIlCRKGXwkKL1LX+JUbW3a3hlkZILszaXMdQFQEAw+O
         5cf+NcC7TTpV68jQCvW1LoRvJS9Bt4/8dx9nU2hMD2ord2t9zq6PvD8BkxCUN1jpk7jn
         7t2H6bphOM1rgrjtR3zAI7QJdwsKa91btcAdtOyBUttE8DfoizvPwWkakvSGriU0iNh+
         bnYg==
X-Forwarded-Encrypted: i=1; AHgh+Rp43U+DrVby6uGIZV16rTEMVL5nYYjOmxAuybreegleiJc80cp/xaPAXlCXLy+SWcEkE4AR83I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/VM1uPtRCyNR1gE+xLmz+p28BNMok76oa9Y2Ftf5jmPzkfYS
	xZ5xRqwarmVoPRetkKmYlVZwE7vnXK3wBv3+MxcSj+3NKmQ96Z+S5qXP
X-Gm-Gg: AR+sD121sGxMqltIWgry9A/sxmPCrVWBJu9n4CMIT/J5l/phWTkSy9j3uQ1eFNfDkcx
	NF3uBh32h4x0ckXk0J8r8A0uCSv5qrMtTDlTtydN6gGbmtZ/+TLJTs/FSjs2McGsf1lT0kT2V2y
	wkA/K/Ndj7WFsZWSsAItUIdEiBvw13zl67oMX1cV8LACe06zLgjyZ4CN2m193nPGrCxM7BRHfGb
	grF39qpKfLT5ZdbpftveGwn4xqnJoUonlAYW4A0VNaxK17HgI17og1jpEIDbdEawJ2ufdQZnjh5
	I2t+pzCDK2SOSaztdV/7Az5tvltyY3JgTpC6/04++0MExfVLRlomtluhB0pAcbPDF+5t3aXCe12
	D9hZceqJ8KHxeqMpbkalgUoNwSAAWElOjQnw+6wLOGNxDfsPqGkEp+eKIH1oQKVGTIBmJffzxNq
	4f1Gqc1moxcdBv7zNbCE8mmOSlgYW3eFgmXa4MAshyOT+6iRl+LIIGlA==
X-Received: by 2002:a05:6a00:17a8:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-84e8cf4d013mr208312b3a.16.1785170790323;
        Mon, 27 Jul 2026 09:46:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1448sm3376385b3a.30.2026.07.27.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:46:30 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:46:26 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Message-ID: <ameLB_goNrMbscXO@devvm7509.cco0.facebook.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>

On 07/27, Pavel Begunkov wrote:
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
>     the former + for consistency. 
> 
>  net/core/datagram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..173b5d97bd40 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> +	if (i && skb_frags_readable(skb))
> +		return -EFAULT;
> +

Maybe we should do -EMSGSIZE? It is already properly plumbed via
skb_zerocopy_iter_stream (and you'll hit 'skb->len == orig_len')
and it hits 'new_segment' in tcp_sendmsg_locked?
