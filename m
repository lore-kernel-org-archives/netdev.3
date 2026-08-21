Received: from mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765146D570
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305842; cv=none; b=FNJ9OZ9XHYrrIULcSz2IeWofS233qN/dvOI/g/IrE+DO9+pCPeTwpKOXOJKAMsV/Cld9OJwM/cDste1IfOGw3aGZ7herOIfSAekZq9PYOsaDTOrQeCXWvcXlMRxYoBLge94dpDlRBOQ6N7Ruf9nB8T2F3jSBEGtcpo0a3GAezQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305842; c=relaxed/simple;
	bh=26KRncgTornO5CSMrEdAC8WicJUXdDhszLrFIgZQECo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZouePQjWkVVfXqiIewYGrNNEy0suidHY+kJoQknL14AX/vooX/3ixGZQRg0g7tzepwpIEDfPAOHxGI1kYIfOTs99ybUJQd9TTcDHseK+1efNZo5kdIIdKCqbIT5e7aP20mmucjdfHCEDgwXzYGXb13EN2ESJq+fZWhMWRstNXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2PsFJ9N; arc=none smtp.client-ip=91.218.175.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2PsFJ9N"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=26KRncgTornO5CSMrEdAC8WicJUXdDhszLrFIgZQECo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787305828; v=1; x=1787910628;
 b=q2PsFJ9NCLaBLROfMmJag1QI4hjmNEyB95Ofny5murRqChlPhA/8/B2qFwFgSKq0OzTp37Us
 rHsWdbvpksqTLCCDWdKmHtkceXf5QYLpxgVedCKblvhTOJlNczcwVPizhKtf9enLBQ+bqKGtXBU
 VEQ8c0Hb06678RvdrroM9AE8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 6acfafefd752e352;
	Fri, 21 Aug 2026 09:50:28 +0000
X-Mizu-Trace-ID: 6acfafefd752e352
X-Migadu-Flow: FLOW_OUT
Message-ID: <51141bdd-1349-4a24-a713-8995b62ae1d5@linux.dev>
Date: Fri, 21 Aug 2026 17:50:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfilter: osf: remove unreachable break in nf_osf_ttl()
To: Linkui Xiao <xiaolinkui@126.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260821022817.153861-1-xiaolinkui@126.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260821022817.153861-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/8/21 10:28, Linkui Xiao 写道:

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> In nf_osf_ttl(), the break statement after return in NF_OSF_TTL_TRUE
> case is unreachable dead‑code. The return statement exits the function
> immediately, so break will never execute.
>
> Remove the useless break, no functional change.
>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

