Received: from mta0.migadu.com (out-232.mta0.migadu.com [91.218.175.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16723BD17
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854852; cv=none; b=sSttUioz6izjgq3jWmvoJDjL16wRzPJ/mYdtj9ycsT0rwef7N8ysRwC50DLrLxPzC5ojrMQXUbdmERnxcAvTXBR11uqQt61PHVKL9jXFu7Nn4/qO5oB8zJy0E8OqnDSTIylaKy6cZ3Nn3PcVI2G80WnVpckLKdFfNzNzDJ5TOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854852; c=relaxed/simple;
	bh=TdrxPeocDCcL7nOQDC314woy+U7ILdOxkwXK94uv0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGKLJbkfsUyRWL3sN23x6h32vT7Es3g5qXYDYa1LpeBhYJweR8lqCYvYWZsPFMgSbP9CWYBOUlmLmq4x9N8uefZic2vtyyTExk7ciw1udDm4kGTvjXirfErk2BdcDjbAuWMy5BXUcwnN5u76TqTSGSOaaMCeJ6fzY15Lwt0YLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibsJxtcf; arc=none smtp.client-ip=91.218.175.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibsJxtcf"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TdrxPeocDCcL7nOQDC314woy+U7ILdOxkwXK94uv0QQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790854847; v=1; x=1791459647;
 b=ibsJxtcftBOqOPUtt10M7Wohs4/1g4A8KX4OTYFh/HxAJLYF7msyBE9ScYTpG18Z0fIyoB2m
 4/Z0ROICJZyyNuXou6xPyX6s19+WsX0QgOCxyrNlBXCk6BzOBVFvQ94tKiBXKiI3enEJNhv7Jdc
 OLbmmKwlbb/UHUvSqy2BhmxQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 58d18caaa2fd1b83;
	Thu, 01 Oct 2026 11:40:47 +0000
X-Mizu-Trace-ID: 58d18caaa2fd1b83
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddd0a7d0-3aae-4847-a592-4b429762bdc7@linux.dev>
Date: Thu, 1 Oct 2026 19:40:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: fix the program leak when XDP is replaced
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 joamaki@gmail.com, daniel@iogearbox.net
References: <20261001012639.298690-1-kuba@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261001012639.298690-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/1/26 9:26 AM, Jakub Kicinski wrote:
> We need to release the reference on the old BPF prog, whether
> we are going to no-prog, or replacing the prog with another.
>
> Spotted by AI while running tests for the propagation series
> (leaked programs were accumulating). Selftest will come in
> the net-next series to avoid conflicts.
>
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Fixes: 6d5f1ef83868 ("bonding: Fix negative jump label count on nested bonding")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> CC: jv@jvosburgh.net
> CC: joamaki@gmail.com
> CC: daniel@iogearbox.net
> ---
>   drivers/net/bonding/bond_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index de2489c3d9bf..09aa45d71fab 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5732,12 +5732,12 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   			bpf_prog_inc(prog);
>   	}
>   
> -	if (prog) {
> +	if (prog && !old_prog)
>   		static_branch_inc(&bpf_master_redirect_enabled_key);
> -	} else if (old_prog) {
> -		bpf_prog_put(old_prog);
> +	else if (!prog && old_prog)
>   		static_branch_dec(&bpf_master_redirect_enabled_key);
> -	}
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
>   
>   	return 0;
>   
