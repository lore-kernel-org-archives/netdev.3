Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5655C324
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969292; cv=none; b=c4ClTrnkHEanBH8IlS3bcafXWyMqifbkTU1B160fz3CCfZnwFWteBvRlO67BRAVv5vzTDrpssK9Xd6cJy/sfPpEEhbO4CKsr2x+W1HNa6go/iHHQiFwLBKGSrUawQkKOUXrq2jGEIIdlrhyg39bGVQmX1p10CH7mwjlUCRmRpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969292; c=relaxed/simple;
	bh=ZS57qCJaJZzvLtWT5rb+UsgkBAE6cq2kv5Ow6zPtdvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FX7KaZcTR1CdpTeUDEBIxHwh1FtT8UpA/trOBIZAI7nbVcIXDnKSQgLYsNbXhiJU63iyxHSCA3CdBXa6g9KQpzNPtCytc8hWNCbxC5oLzsTeM6KnVT/7sdaoMYwWJ3gVYpneQ3nb5Fiyky2FHNakBnmHOPisTVEVUqhb/SQeRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2U+tccv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa5g7st3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2U+tccv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa5g7st3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788969289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
	b=d2U+tccvDUJhK1KO8IXzntc+Tg74Bay+823w2bQgOMhw9b/KppIaURiklelERA5H5jnlFi
	xqZFfMpAmOFrTMdfmT7tf4FKl86B1cD87wXDLiM9AIRyE7rzddp/OEpPn2AaDxkE7NQ/8M
	XlnovGTGJe9r/eTh9wUpmnIN3oQOvNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-nOdnN7Z_M921Uxe-tyLHUw-1; Wed, 09 Sep 2026 11:54:46 -0400
X-MC-Unique: nOdnN7Z_M921Uxe-tyLHUw-1
X-Mimecast-MFC-AGG-ID: nOdnN7Z_M921Uxe-tyLHUw_1788969286
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843e59c32dso3888118f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788969285; x=1789574085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
        b=Fa5g7st3Z0sZ6+TymEI5E+NzBfphSSlY768Rw+F3Ax22kVyCGETd+Rx7hiWsf5LZVH
         nv9HOHh1Wzuix3zuyc17XHy/pbkGAYY7QYu3FIIMLzwlNXmVcKE15YxNFAQQ75N8XdGR
         yq40Ix6JJqU745NMY0Fbjq7ZSENafV/1TO5OFBdYwIkWY+b6/PM9Z10iP0FqYc1GSVLQ
         cpBb9guDxJuAu1lxNrGfbv6Pz8FJ74FifvR9IsCcN8gTjL9knYG5eQvO9cS8gCBpAarZ
         VxLsBQDERPkFDkJQfApUgK3akRqd1CFf7JVQhfy5C+sQFYHNyS+CT7RzvhmoSph462Yd
         Oytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969285; x=1789574085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
        b=OaiMvpYRaXFyK+9O0+4xgukzoPzYa95uT0JBLTp/IC+DOBYi2oc2jboLIe40ptLR1O
         xFoI1xWConQ0igax7JmjvBBhlQdtB3F87coA21rBZB4FXNzXWC9CZ23IiYxJtlVGusCp
         k8TiuDAjN5Tvc4lF7hGTP1QSWp/fkg/bLf6T5zSPoQ76rKkfkNtcXA4/hCl1p40rsyON
         JjDQwj59jOsdU9XO22YRy6O61TT99DC1T680ogNRmFmQUqB5NgWyvfa8FILNQkL5cvSV
         QMLKyCC4flp5oAkQ7tOdf+feXknVGA803EOAAxTvgpq/SRhHoR9uLZesadVlRzMZHBr/
         CP5w==
X-Forwarded-Encrypted: i=1; AKwUvBxaGHOCRM8NL+dQoDqYprjFz6LonUfpBMjrYrBPY6rzWuK4VA0aEfCyC37PNcWDTzFn0Idl6Zg=@vger.kernel.org
X-Gm-Message-State: AFuF++lN5ms3lIqXjphZs6IjUjW4WBPQSmBP2s4JovliN/Qr26bbpjM2
	KFc5wJOS7F8ltSmfaFafe6u/Wm2xQigCaf/GN6mn+YW2PIRmYZKQQC1giRH8rIvzlIDuC0Gv1mC
	yak+K8KwalQhdZzhFfBBfQXpywk6zmr0Ook/vYF2a8sb2g310GX2mOAT3oQ==
X-Gm-Gg: AYBFou32gEKZFyOqWzM2gpymsAOVSFW8YaNyTJbSghSrnv38Xk2XLWljpCww5wKBpj9
	+wu2lZyQdsHaAJ/BBudPCC4F+KU511BQ1eqcTd25hy5xPp30q5jVZpA58L/SA2p3BMPjPBYjT/o
	mjgBSrcFoA4Kx1hgQSkBz0Yn1QU96BT5G8yeyzcHy204KQesJr7tLjGJTMtG4bzhzjnCfRe5JVc
	cCP2Km4UqKtKI8cAPVSdLPM/T/+ZZIyE8wteZfOjb4m5pobG8X3yRpwaJ5FUbIZdjUSKeZxFQbW
	rF68FqqiRPDXs4+rh+MEh6QV5atWuad8lrGSAelp1QuBNbzffK+ChumYjG2F9jTrEzHeDzcezE1
	3hWuq6XHtHqE34BbSUnmMXJXRlAX3j1KO1S+biaKfIlI/EbwV8nG7ai9uug1C0HzR5fv067OcLQ
	==
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596602f8f.52.1788969285538;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596570f8f.52.1788969285051;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm44531453f8f.21.2026.09.09.08.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:54:43 -0700 (PDT)
Message-ID: <03f37b1f-a115-4c63-bdb1-7467ae8b165d@redhat.com>
Date: Wed, 9 Sep 2026 17:54:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 06/15] mptcp: prevent race between disconnect() and
 rtx
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
 <178896537655.219967.3201901026877077910@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537655.219967.3201901026877077910@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] The commit message of "mptcp: prevent race between disconnect()
>   and rtx" describes the change as only "Prevent the race using the…
> - [Low] The commit carries "Fixes: b29fcfb54cd7 (\"mptcp: full disconnect
>   implementation\")" (v5.18) for a real race that can leave a reused msk…

Here the code is actually just fine and sashiko don't like much my prose.

/P

