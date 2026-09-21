Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B704CA788
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023819; cv=none; b=YZJ9jr9Cdv2kGoEFcoeds9ImgBXLezSz+BH8bVHaaJ0C2x83uDJawaky5sGJU4ljepOWSpFwgzLkaFVmcNSI+0AFMPoLkvjnN7CjAcNpVv7MlmOw5pwiGhKxrsusdaRUUqcRfUSZBN1LPtrl/7PJcUq5ZE0FVKAxoY9K2h7IZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023819; c=relaxed/simple;
	bh=R0dC7AzYf0qWr4TrOi51tjRCzHfNwSax++tiE5KtnoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCj92fo0TGGR4X5vFgPtMCnbWcPYEdZPr9qUerSv7Mr6cPmgyzLL2wcoCO15kiBlBezoKYNNBxcRS09sr8+WlPZF3Ow25Q3ROH+1IDo7DOzLZG1uF+yztoN3rBRJ7oFuRZo0gKYRfkeFyJ0YBSC3n8iH/cW+mcRUyADkwlTAenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sK0EEQiE; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK0EEQiE"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39e249c766bso1462147a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023812; x=1790628612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCdR8n1lNuuohtFDAs+Am9lP1Oe411QNhr8MAfHsozw=;
        b=sK0EEQiEXEWOmeQyxDB2/Ryd2vOIkxMFvYWtoWRf85VZNLhfdbWKKXRE1ZxpBf+lB/
         s8l+pKnpgLvE1wll9wViRwRdcTCbPC0orzWow14Xwaic4HPeR40amgS4bPf8aFOFCw4I
         tz9c6gakfxbgFyR1eOjii+VVy8XJ0EyCTTd9BXH0OMGhYD35uFwC9aGu+My+2WA73vKd
         iEqBvf35J4N+wJ9glapQmCDWEIA6ykA78ULnUlDuZ/rIpjnQIgEY0K5rGRjVUED3eNir
         8aiAdW0fkjS3hL7G+5YJd+YKvfwveaxRnZ9B+eDzOjVstP3ikPPFeiTuXuomjmMaIHV8
         +EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023812; x=1790628612;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCdR8n1lNuuohtFDAs+Am9lP1Oe411QNhr8MAfHsozw=;
        b=jrxnfAYmduVErecmyzPB+FvsOalWKxV+kYZwBxjvpIF9ASyVwyxCMpwf6E6Gz1XXhG
         tt4j+4VAZI7J0YM53hdg3Q7qEMHECMzaCRwVyNraJnp6F3nKhczHnalqui8XfizAcEAH
         nQO1lvNM69ZhV1JhoJi18r3TN1MqfEcf3fLN15HwbUjqFwBE6rGxltgN7nP94gOvlCOO
         7MOKyCZqp3UTCWw/olbHYmRprVv1DzJp7maLykbl6O4Ix6zoczzQ7sC0MsvFix+MGxK3
         uuLrZ7AyBVF88gZzy8r5R324WEEpz22yuMq6W1j/Uk+mPYhDkbIZK7mQL8J0X5XELWVR
         Ut9w==
X-Forwarded-Encrypted: i=1; AKwUvBzeGdtY1Ai2+vwfby7z29ljP379d3EVxKWSZmIoCU/idlAY69AwiguZjryr2LwhKEfJON9vNdo=@vger.kernel.org
X-Gm-Message-State: AFuF++mKMeKeynTeEsnQ4o10tqoctAPfI8uTqoH7BeV0pgu3gPz+6QM3
	GYBwVtcugGzs91+8VVNrnx45qosTzYvavuGKVa6UDoi7vzirgfTqRSyr
X-Gm-Gg: AYBFou2a9DHuDB0A1tN03hnRgw7ljQbeK1NpZVauQQ42duCR6rD3cy0yZAj+HJHfAfS
	FL3aIykZbCIevx/L5jZ7ddVKS0FDTtTm9V+ry2RTXNxFdo3ZcUWi6s2ACl6/vxd779eZgRZvMlY
	FO6lvoRi+2AM1vhk3pEi01e0nrDerowV61b7BzHnhp/Y2qyFC+/4nMUGkfrXGCBiuEKxV3Qm1GP
	l7QGdRXPYaTRvcFvQ7KEy8+yC6DHVB5HFfYDnrDxREDwJPTcKgBGA2Hr4AQ79UVWk9PGWerMcbw
	xslI/ggziNvp4BVN/tw8btjOrZ4KWO94BY0Ee/qHMIc3bbU6imCxp/KpXbZtL8dZK25QIskHiqa
	7IrpQfYoW+DI+zgLPia2ea1ai4ISCQfzWDiyEkN0K82PAAgS6nUjYJ218aoPvHoROZ/Qg519Gfa
	xPCnBAWx72Y2xXABjWnU7uBOBFZW2lbnCPsJh+jOqEea5CGD53XruO33ECFbGZhYrR9dMdgsK7n
	IM=
X-Received: by 2002:a17:90b:448e:b0:3a0:22bd:6ee5 with SMTP id 98e67ed59e1d1-3a022bd8582mr9956024a91.14.1790023811973;
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067021ca6sm989249a91.2.2026.09.21.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
Message-ID: <arGYL1cqUZLBjpP8@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-5-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
> to adjust sk->sk_rcvlowat.
> 
> These hooks are triggered
> 
>   * when the TCP stack enqueues an skb to sk->sk_receive_queue
>   * after data is dequeued from sk->sk_receive_queue
> 
> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().
> 
> If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
> be called twice for the same skb, which is redundant and also
> confusing.
> 
> Let's split out __tcp_set_rcvlowat() and add a flag to control
> wakeup behaviour.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
