Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3D370ACC
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192051; cv=none; b=WmNfv2PmZq0QiSoD+ytodka0U1jxFxwYm/nQ/V+qRt9+LGkGJdlbemVMcnHedP+YIVSw/r2Urk4W0+lyyR4/7maUbgy6zhJCN9iY+r7bEyWa0GFLhDQhM8xwa8fni4MFN0xQqYxh5AteEbzKbc1N1UQ0DopKJSXhgxRlCmrpogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192051; c=relaxed/simple;
	bh=a6+lGz531nCb3yhM69U2HOYcWdA4eqtCtaEPwYjL4Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZl+7+Ef3HhgNsu98HcuzjaTFYJ/bB0xaXFgJwlZiNiXkJXhXw9/A3e27NzqKDvMY4YfkkFTbWFCPT0wfqhRsofGuBEssdBAKbo4PWUAis9y9FmlvcRSkBNjI5Yl+pJPycgYNvU2mED6Ta4jUlylucdHa2znQL3+5mOe0kKDy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqcT7SUp; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqcT7SUp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a6+lGz531nCb3yhM69U2HOYcWdA4eqtCtaEPwYjL4Xw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789192035; v=1; x=1789796835;
 b=YqcT7SUpt05bppMU6CSb90moUDku6rYHzCRH1g8i5cCuqNJseknhnt8Hf0TWcF4MFmKQr8SI
 UwsEBBkLc3hTMRyFXtvxJ4SH4nc/ZWbAPBbOMSmZsZw0y1iUcx1dcbw6RKa/fqYH7SKDdxDXkO5
 3bBf6G3zA4+5yLcb7Yxo/tSI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1220bfef01b82b27;
	Sat, 12 Sep 2026 05:47:15 +0000
X-Mizu-Trace-ID: 1220bfef01b82b27
X-Migadu-Flow: FLOW_OUT
Message-ID: <7d77a070-f223-48fd-b72d-f5477e025add@linux.dev>
Date: Sat, 12 Sep 2026 13:47:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sit: do not report an error from
 ipip6_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260912005442.1795813-1-edumazet@google.com>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260912005442.1795813-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/12 08:54, Eric Dumazet 写道:
> ipip6_fill_info() returns -ENODEV if tunnel->sit_parms is NULL.
> 
> This can not happen yet: sit_parms is only cleared from
> ipip6_dev_free(), the priv_destructor, which runs long after
> RTM_DELLINK has been built.
> 
> Returning an error from a fill_info() handler is still a trap,
> because rtnl_dump_ifinfo() stops at the first failure and propagates
> it, letting one device hide all the remaining ones.
> 
> Return 0 instead, there is nothing to report for a device that is
> going away.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
