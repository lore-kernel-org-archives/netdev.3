Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765777;
	b=K0lgPcQOkByUb6TuHyOhwJ4LNbwMyh3X5flLwSl5xQvkZhBPf6Iw4NM01zDFvd6uqi2K
	 gOPv0RzJHAhbthq1rii3pNdOP4+MAnXdl6C9W3BfvIutydYu2OHeuxNaaGynJxG/6zxh6
	 uPLpfvoBI4+Td6Iu7gFNmQqukFJoCtv/eUe6iQPceqhplrzzZm03Uh2PAzK5FMiCVW9QO
	 /YAr9Fh/U29ST7hB0CjI99E8PMbppWB1j2l2ynpgI5dLg+bR98cLPwtlfEtXZhWGVK4we
	 987svReBMkDpAW8IHZUrMPes2+ZkIOCWKtrvkqEBZX3OSLBWl2XeR1Jrz9DEj+ZQoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765777;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K/cIC+iFmdevIAI+I2RKVd6I0g7XOiCzAkoSeW4/ahA=;
	b=ngvOPm6CFyvF/0SXDTn25DJTZdf5u1BuFFgNkDkqGfQgVcAemoD2XrDDA/C9hk9sX7In
	 7Ci+34jA70Q6cep4GWHgIDFzrJhhSSwqaEnisY47WHqptm9kuy82673MiuDcMgW3pk+5V
	 V6CZNTN4kPsnz4A3aBirGPjv5pc2ss+Dn4E1k+CEw94vM+ydzV17ndDSzcGULWfajcRrT
	 H9sAmTxGaBfbBCfH0uXw9vP0geVXGDf9C1OOEdKdFAhit/uL+KSEruSh2EGphMiHItow7
	 FO7CTeaOXhS2l21SU++iRh3tq7eA02E/vqzs3weHeMgFGiGYFwdxP+EyEbKAqKd7ciQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z7CawluL;
	arc=none smtp.remote-ip=95.215.58.185
Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AFA606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 04:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AFA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z7CawluL
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vOi5qQ0/DXnG4QFkyblinf0P8GKtrfv4uQiJ8Uvnh54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793765774; v=1; x=1794370574;
 b=Z7CawluL2fAeDcWOMjTaSwZXO5rltRY3EmeRBJOdaLjKlQj/ClrRIakW7Ph6cMVOYJA2sH8H
 p6vmttNFNOJBb7jhf/TykWnsYTBhl1jKKBxnG6QQfb6oD3DtJYXkvfPLoCeYhJbejs/v8DBJbO9
 gnw6axvo809dSLfQDnqs/1og=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5164afd9a38a0a63;
	Wed, 04 Nov 2026 04:16:14 +0000
X-Mizu-Trace-ID: 5164afd9a38a0a63
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb64096f-2c73-428b-ac74-881227539a2f@linux.dev>
Date: Wed, 4 Nov 2026 12:15:51 +0800
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
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
To: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 7:01 PM, Breno Leitao wrote:
> sockopt_expand_out() grows the output iterator up to INT_MAX, but the
> MCAST_MSFILTER getters converted by the next two patches rewind it with
> iov_iter_revert() once they know the real reply size. iov_iter_revert()
> refuses to unroll past MAX_RW_COUNT:
>
> 	if (WARN_ON(unroll > MAX_RW_COUNT))
> 		return;
>
> MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
> that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
> hits that WARN_ON, and the iterator is left where it was instead of
> rewound. So does a caller whose optlen already covers such a size.
>
> Cap the size at MAX_RW_COUNT instead, before the early return for an
> optlen that already covers it, so a size that could never be reverted
> later is rejected up front.
>
> Sashiko found this while reviewing the conversions.
>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  include/linux/net.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index e2a866fbcfa5ea..de56f89d475ee2 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -80,16 +80,21 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
>   *
>   * Call it before writing through opt->iter_out: it re-anchors the iterator at
>   * the head of optval. Only a user buffer can be longer than the optlen the
> - * caller declared, so a kernel-backed optval is refused with -EINVAL.
> + * caller declared, so a kernel-backed optval is refused with -EINVAL. So is a
> + * @size above MAX_RW_COUNT, which iov_iter_revert() could not unroll.
>   */
>  static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
>  {
> +	/* iov_iter_revert() refuses to unroll past MAX_RW_COUNT, so a size
> +	 * beyond that could never be reverted back to the fixed part later,
> +	 * even when optlen already covers it.
> +	 */
> +	if (size > MAX_RW_COUNT)
> +		return -EINVAL;
> +
>  	if (size <= (size_t)opt->optlen)
>  		return 0;
>  
> -	if (size > INT_MAX)
> -		return -EINVAL;
> -
>  	/* Re-anchoring reads iter_out.ubuf, so the iterator has to be a user
>  	 * buffer that nothing has written through yet.
>  	 */
>
