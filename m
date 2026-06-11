Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444303672A9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212789; cv=none; b=d+K89zf/F82To5g1QRfgMFWamddW5bj9Bzi3Q9tZA0Y3AxCFUxHGrKPPn1nMApMmtLpOOR+Up3MOLimghBBsBlEezCI54WamRtb/3KoYZlqufiEFanYUI+xw+4FaGJTUGmCEkHGrncpA2W/DtlJouxfM27tHWC0PNFmDXBfWtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212789; c=relaxed/simple;
	bh=ZtJX3WQMMA9mK+XaCcfLnc35EMB865YOIgWqBlRERPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9SIsRVcf5zNL425gd5XlPbz/PJSYo1cPSjr8lpIdXEoO2+h32/LAUr4eEujFvSMxC8/vZ3/z8xOooLaDvELJGHIbPvNcfLDzsrNK9lrX1VuHm6kXMVMGHILLrX9GFqm1ubi/H7Vxjv73x7H1Hnp8GeTumFudmKVctwLDa+bDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=hBa5pHA/; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="hBa5pHA/"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-138129a622dso563561c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781212787; x=1781817587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qf+EMuGOGT252QVdKS/7NYWLP675aIpiwNn6fsk89tw=;
        b=hBa5pHA/lCT+/3vsW+QBm+9mOfu0xy8Uxv8H5EHDrjvowK4cur50bmrpY0hHgNhJYt
         3N3p79AooLfwpGwocaeJXBs1nuJfOBlbvl25IjbFxzFflpXP5xUWVOLQhjR0MplrenjE
         K3uVcYQABYhYSkKoKMP41dfithK7laoAZKa6OqFfUzLqhbz/jjdb4cvh/ZAOm9pUiMv6
         9OjAGeLhFl0P9uRAt4ZYvI4UGCUQusyxhjcbMn8kP5nL3vPiC3DIrOHh1dMslYXjaqb5
         QIX2ZLTqobVjsfH2DpALdKeqQ20v9KB+wspFH/2KA74h7rIucYmDqlKYz0RZqjY/DkA6
         pRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212787; x=1781817587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf+EMuGOGT252QVdKS/7NYWLP675aIpiwNn6fsk89tw=;
        b=tWxWIYrfpKDhhfeE3AbkAstYCnxwQN1ultDMeqSXJKPr42Mj5idVq8gzEzXMw5uDCk
         +6EY6YrJwRsX/aLsV/5fr/u8Ppnh+cfgkkcr9lIJS8JioV0gqLLFbPKBAEXEo11StpYt
         IiV875xLdyDp4YFybGKi8fOhhYN+Y5JIuK6MQFsJmmracImcf44VPCk8VWPZ+FUAzWX8
         Hj0nLFKFgEgq0I1BSijvvTKmAckbCok0U81sxxCHKsuWZkXtaRGM3ll4w3eRJvqSpP4i
         CO7MC0zRQI+IHLgML6FNZZElUt3rYSLB/MoNgAWsJDLqkn/WtDk+WeZpoWmnUAiJf6eZ
         BRzg==
X-Forwarded-Encrypted: i=1; AFNElJ+BnaTIusRY9AgTmM63JO4m6PJ8ouhHtfNUeXhP5XwpuPV4fOLd5jV6Bj2WXryF76u99c9M4fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKXgl9JDxnj1TbkI4yNoQ/lpcaPanXFaO8ZcLqwlRllB9krqc
	iKd+dR35kWkFezUUu9h32dH+UC/vZBwLV9mkLAI1Oq9XyfMhBatY3nLZ2Kr2UTAfcQA=
X-Gm-Gg: Acq92OFSS+V+Ex6XNifJjqJDXfgVY4LbEfLxnviZpqDMmu/dr/9hsjLob3RrzJFNw5f
	tUBTa+eL4Ty1KlqRBIlHU44P7LDVDHxy8Mca+SF7m0Kxz+cURuyMMU/1lIm0aHPNLYaIkpkN3X0
	xUaQ0pxxLRA1Cj8WLgf8IcS5V1+1yeU/iHq2aNhECXgI0BRkvfnhubzwMrj6fH865Y0D1/mS3Qk
	qwAgoqyIXG6btTuNaeSENK8QA/oxYltDvK8zKvlN/xM5kb9UhUhOv+PY6HRIBEyVk3gUq8qxXhs
	fHaxbw2APJEMMcOrxuVTYtUr/epsX+CQEXDixRC+hQmt6Kr7Co7fGjUc2vMUTsY0NMMQYIFUmAC
	ZaOzHwCI0ftXiNh+mWhkjv7Xx1cXIkSxGWAZTdRkJQUQItIQpyq4H2LR9UNH6OXY91EDxIBgxds
	eGubBIG1Bfixiwi9PMT4em5MLuo9mollzP7bXsuhSPVkv/NHILF5GlLg==
X-Received: by 2002:a05:7022:6ba8:b0:137:fea7:ed19 with SMTP id a92af1059eb24-1384bb1c373mr26757c88.3.1781212787304;
        Thu, 11 Jun 2026 14:19:47 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b919ef9sm84787c88.7.2026.06.11.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:19:46 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:19:45 -0700
From: Cong Wang <cwang@multikernel.io>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: take the socket lock in
 udp_bpf_recvmsg()
Message-ID: <aismcTr30ORVXQhW@pop-os.localdomain>
References: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>

On Wed, Jun 10, 2026 at 05:59:17PM +0000, Sechang Lim wrote:
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b1481..8dd73e9ee1ea 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -80,7 +80,9 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	}
>  
>  msg_bytes_ready:
> +	lock_sock(sk);
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	release_sock(sk);
>  	if (!copied) {
>  		long timeo;
>  		int data;

It seems Kuniyuki's fix covers more than yours:
https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

Regards,
Cong
