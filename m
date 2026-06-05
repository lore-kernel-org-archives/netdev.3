Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAE34E75E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622144; cv=none; b=AbRZkTQHJihRKQ4HEDlTTpSyg39A3BvQzLV8GgyoL3lSwOWXqjDRfMOt9zaVIR5HM+ocd3VLhNWn0WeZn/l1Apx1K0D9Rm1Gdz83jOrUDfRpZQ8Rk7ZavqGLqATtE8C8GEq+0V3i3GcuTmSQpt3pC6Eu47EJsOF6tF9hgksuIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622144; c=relaxed/simple;
	bh=/IIud5K0OVSjkbyQe29J/aToaIax/e6ADD2e1l7K2Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdPNeNpvUBgzMmzSyqil0QSa1zHbnwctzlQTJvzZ4SjdgAlxSRSX4X/iUzZ9xVlJIWCYBwtChbKakPxyHuRiCSjxaq5jtHYZPGGZP9WovL+IS6aUs+RSOqCgpOt3QVCBW3OQ0XNmGIxWZ1myC7i56mJBCUFSQ3RxP2pd6JFTwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvAdtVX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvAdtVX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0402F1F00893;
	Fri,  5 Jun 2026 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622140;
	bh=ZLQcSPRDMxtzb3CUp3dmmxIQ39HxGRFQxD63qLyM7L4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QvAdtVX85aLMCLkyyHHsz/MDMYqw6fEnHFG+kxTHWWCnJcPu9h7Tgt/YqqX2qAVAZ
	 Wdjjv1fPpNAFAOESOLrLIzbY91si+IRueUKOP5NYcxMQ7l9gcj+vWZq2tunwM0WbFT
	 DqlMjGItoed8Loe48iAoQr0D4BTN4cI331sQxMlquMwdMpSXMhwc9b1BAMUm3YKgBF
	 c6p619yFp11iF9kFpW3JQRVt+9JU+kqOReIpOXF3oWrPBPuhk9p5/ESHt3Dj+7Wbls
	 6FadD8Q6d7S2tefJDaVT/tImI4ThQnxnUVi31uODmdORb76YbQNXxJ3KFlsmDZUtpU
	 NA61YvxrG7b1g==
Message-ID: <ae104399-5868-498e-9114-92d35f052591@kernel.org>
Date: Thu, 4 Jun 2026 19:15:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: remove obsolete EXPORT_SYMBOL() and
 EXPORT_SYMBOL_GPL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260604173413.2782008-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260604173413.2782008-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 11:34 AM, Eric Dumazet wrote:
> These symbols no longer need to be exported, they are only used from
> vmlinux:
> 
> - inet_send_prepare
> - inet_splice_eof
> - inet_sk_rebuild_header
> - inet_current_timestamp
> - snmp_fold_field
> - snmp_get_cpu_field64
> - snmp_fold_field64
> - fib_nh_common_release
> - fib_nh_common_init
> - fib_nexthop_info
> - fib_add_nexthop
> - ip_build_and_send_pkt
> - ipv4_sk_update_pmtu
> - ipv4_sk_redirect
> - rt_dst_clone
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/af_inet.c       | 7 -------
>  net/ipv4/fib_semantics.c | 4 ----
>  net/ipv4/ip_output.c     | 1 -
>  net/ipv4/route.c         | 3 ---
>  4 files changed, 15 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


