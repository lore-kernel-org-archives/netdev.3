Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772457;
	b=HC1TIus5jxil1iCbzxzaraZBxf6ePFsXtJSv9BS1awKQc2EjTFiFnlvZjToABWOUW39f
	 1wdJwYFoJLf4HHhEAeLz8/3GgOMa1SimDWZkVscEyH1jyDOXJTuy6XeZk+cB36qYyBuO8
	 s8t0LyrL/u9xF6/j6hsgSGFV7d38GGHGQ43zWhrYe1zW3pTB2zV2rK6D5tFDluUCBPsKu
	 qYUiwfILE+znXej3XFpgw0cigkAwyOMaqvkiiNWTjsWkPVTDSnTzSjCH0PcOaShFTJa9e
	 noqrZHiW7OCIUDLt0PTp7mPQmGf7M2ppQ8QMsIHCLisTfF+O9jEDLAPP1O42HrPImAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772457;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9kJziegiXF9ceVnU6QWNYLm7UZNmpZIr3z6LjOuG5MM=;
	b=RQM7Y9aElVMkP11N7uP8vvs4Dt3KHmhIeAxlNrFcDn7clsV19JxFPM/oisaJUaqQMe9o
	 P/DQ239a9LhTYmA+qkz1jo6Tx9wj30YtuItKXywLe39EB2k7ksKTCLa/ePA95r6Ucn2Jw
	 aTwGO7Rx0NLVJ8c6T7DV5iybuDjlRwH3vbR2gxkor+tlLYwQ0zRN7WMw0BJpCF+WoITKH
	 Xat7k8aNJ+De7xmfNPUp7H7MItCXpOvCsOhnXKB+FsLonFwbZCEUw0COCO8rqHfDK3y85
	 HF8MaFoPeoCmV6oKHX0nBJWbNKsPjKlOmUYYdpfoueAjVez7mUpHmXuOsORZ7H8j02w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fxLDSgIc;
	arc=none smtp.remote-ip=91.218.175.88
Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A754606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A754606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fxLDSgIc
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9kJziegiXF9ceVnU6QWNYLm7UZNmpZIr3z6LjOuG5MM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793772454; v=1; x=1794377254;
 b=fxLDSgIcA/NKQEZVdQe+c+tZv9EJm4A97xmG7kksyzEFVSz1LPqD6ZLfddWwZttwpHGHJqj4
 WbQ7rw50MpXacTQu7jIuS4iaZzy+L9FleibBF8vwLdpgPYzOHwg0ZgIAi1EWmIEfe5+1EFdSjZu
 tIaweSpziELawiYNIfJrbgZU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b4b12a133bf9ce;
	Wed, 04 Nov 2026 06:07:34 +0000
X-Mizu-Trace-ID: a8b4b12a133bf9ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f0c43dd-532f-4bef-afec-76b2ca6df0a3@linux.dev>
Date: Wed, 4 Nov 2026 14:07:11 +0800
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
Subject: Re: [PATCH net-next v4 3/7] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
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
 <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 7:01 PM, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip6_mc_msfget(), reached from
> do_ipv6_getsockopt() and from nowhere else. Convert it, and build the
> sockopt_t at the call site for as long as the caller still carries a
> sockptr_t pair.
>
> optlen only has to cover the fixed part, and the real reply size comes
> from the gf_numsrc field inside it. Userspace relies on that, so
> sockopt_expand_out() grows optval past optlen, for a user address only
> and only far enough for the sources the socket has.
>
> ip6_mc_msfget() now advances over the fixed part and writes the source
> list through iter_out. Its callers rewind by the reply length they
> already compute, which is exactly what the callee consumed, and land
> back where they used to write: offset 0 for the native reply, gf_fmode
> for the compat one.
>
> ipv6_get_msfilter() and compat_ipv6_get_msfilter() only store *optlen
> after their own copy succeeds, so a copy failure can't report a
> changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
> caller's optlen word unchanged.
>
> The old code stored *optlen before writing the fixed part, so an
> unwritable optlen word stopped the fixed part from being written. Now
> the fixed part is written first.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

