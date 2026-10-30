Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377263;
	b=aI2CC3qkyWD+KrGVBE3yPKp3QwpMYqkKYj+f3vk8w7KaZ4vqBiSOxKFSfqoK1zzruXpL
	 itt1/bZh7iK9oJ1cpjPPVyOmBscTYBY0I9Y8KKjh3z6fwRY/bBuohWbEFQAG3l8QEW19W
	 XjVOace1fJ0TPe28IPCXZGBheUHs3iBKNk61DQwJUy0COVwqW8FkjUVVWiDbx+6qYAtiX
	 IbXAf0DzN28oyWnW3PrryeC6uoRbLKdhz3bjDdit5Tl/W1LftjrGy5PQr8flLyaqKghec
	 rBey9FH08DDZkcZe+zBlNGsaeeAK45A1EEXMuP7oSwyjnYv+x+zsX3A23R2WOZHIUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
	b=iXXb0IM1idN94D/iSAHzdckZXAQmhEZ1IAJPzscQTVGLfPIzyM+M026fTfYxgY6vKeMy
	 HpZH9Rye9Wq+p5c0Wano9X03WX+/oZa7rbKetYCYROD2yXVZHr0jM/wDpLf7Arb7SJtMA
	 BnRWdYUIG66SsXyWkR4RdrwopwcG/9Z0W9pkrf0kE1+BZcc9Q63O3Rrpyz9E1SGuiALO6
	 AkFm9WiZZDMB1ZbQoKuKzaerzdTGTLsKmTVZPFVFBg76dK2o+4l+L7vug0J9jRXe+r5iV
	 WWTsM/ayAYm2IjVsP9caGeUZnIW8rod5/qVvAO6+64a+fFl6Q1A2IY5D4F+WQg+C/Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9CHq1vD;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13128606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13128606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9CHq1vD
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso597915a91.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377262; x=1793982062; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
        b=I9CHq1vDLmpX5qnXoIUx7W4ASxXg58bg4CoxZea/IQTYf+7FRm2u6GrNy3Qn3j3nlg
         UJxqEUcKYHBqkycHpSJcauvmDbezNNIllKp/XE3mSKVZ1zgOp2R3GynGHy595JJsgYXu
         hE/0w2yfpfnz/FuJ4laOfNGSfBgSf3Af0drgGx+doom5rGA2n63qXsZfse1dFKmexB4d
         To4Rf9D1Pj20zXCgKf3MXZM867DNGx+EYScp2mpe5vNh0rzFMQNTx1r4XQ6MSFSoTXFq
         vYtAgD+txcxlyZvBVQxCZEP0gQXdtLXIV951fIg3IBC0ABpQSpyZudtRS+0isv9Jh83f
         H3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377262; x=1793982062;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
        b=fl+MiiSWK9NcJBHkj8vgfTb2IWrtardmeo4hq84DTg9dKQ8cr6cBTcw6YpdoIXsI0a
         k6L0WRvvfhkBhQ2x6QmSijjZjU0YegoWPMxv25K+14Fpg2/TvudvBdvE79C4iSmcY9n7
         l5weq25x89yIM7mEEp0vCFzZMZ69CtZraNND31tfG7034VEid4u0K8YW1Z3UXR54m2Gg
         0zsw+yhI11SGhnvSqTh3gAxQ2JqM/J+ePyMdewRp2nHbVAm7hDRc4CK4i1yhcQKxiQy7
         pABZl4gbEz70smswEC40LfXRBrz83h+ZFRB+DZbrd01y25uUXS9+NdSVMXFbCRsjqeTe
         QTXw==
X-Forwarded-Encrypted: i=1; AKwUvBwNgeHcpveMslsL+55CfyLRpSDqFSSvOjGvQho3IYO7I91x7YL4jIA+0Bq3RFGdtXmgVppic1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVWmV5CI+wo3/85iVCoSRYrj1W8aaRpHaGtB5SNWNZbVlUq32p
	5y+wcSQn7+hGkzbHC1qTe5BD9HvOqtZKDAkwJ04lDOFVOSPk/6zdtF9n
X-Gm-Gg: AYBFou0vqpfjuXbw9lQn0A33gHYZQDqct4qp6TD5rI1RDiWeaPEp4Qibaf5ZKVzNZjS
	mRMoWmGUauxryEx/uImEZ8Rphqd4l07WKS5VPq7irTNkpIl/VKti33WWB8XpGSamlX75kOZrewB
	4FDXiBc3LOGs4F5JeeHMFT3bLLHWHHCCFC1zdd0hGqifpjweiPrFoCxcw6OnyMiJ1yh4T7PFeu5
	XE+uPfy3rcMrvdhXzeqIivpP2JausWQZ8dN9k4HIrnKBcqfmoH0TpUUhbZM4VSzna+2O+MHRHJH
	ISxRTdcw39CSq/f4GoDyATFQo/68Cjo2TfCWT+J6u0yJOKu3oFLbJQnf6YMAHgbWxSvGti6Qz3k
	1Mi7ThZODnMrLgvI7/fcKXW4cA1w2XUJ/Kz3iWNlAy6iR+cycFNS4qbihYm6HjuXo6sgnE88UOU
	7kvH4XM4ThCmg5KAlLoGrnMobLaQqnD5041iMFsNC+t2QSMwZKqZVQmwU+dfzjne8GWhh2DIGwt
	EO9mq8sbzeAMKpbQC/Du/+cdn2a3FTxDrbjyeAfAL6i/GEnXgxX5vgfx61UzCcFv1nS1bBWz7Pm
	5i7CT8CWetdPU0G5jVKs0GsfNfmM7DYqTfNYgPnx/GrefKrQUGtj+ULkUd08U9ITNvysYPpwTjF
	Nj5GFf+XFP51xzm/AP122KE55kTBAqIRIzA==
X-Received: by 2002:a17:90b:1f92:b0:3ad:4a8b:c701 with SMTP id 98e67ed59e1d1-3ae897b51a8mr2370584a91.45.1793377262057;
        Fri, 30 Oct 2026 09:21:02 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880b1f71sm2113239a91.4.2026.10.30.09.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:21:01 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:21:00 +0000
Message-Id: <DMIB6JXDLTPX.15EVLOCXRDOOO@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "David
 Laight" <david.laight.linux@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and
 secondary hash tables
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
In-Reply-To: <20261030122045.3035709-1-edumazet@kernel.org>
References: <20261030122045.3035709-1-edumazet@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 05:20 AM Eric Dumazet <edumazet@kernel.org> wrote:
> @@ -3431,12 +3477,12 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  	for (; state->bucket <= udptable->mask; state->bucket++) {
>  		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>
> -		if (hlist_empty(&hslot2->head))
> +		if (hlist_nulls_empty(&hslot2->head))
>  			goto next_bucket;
>
>  		spin_lock_bh(&hslot2->lock);
> -		sk = hlist_entry_safe(hslot2->head.first, struct sock,
> -				      __sk_common.skc_portaddr_node);
> +		sk = hlist_nulls_entry_safe(hslot2->head.first, struct sock,
> +					    __sk_common.skc_portaddr_node);

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
