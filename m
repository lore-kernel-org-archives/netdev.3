Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793326120;
	b=jjpuBww1dfKU3OkPBK7KVdRZQ8V2d6cPnCDivJoH9f/fV+xuR7H8lobJ1yAGQkOr2Dxe
	 0PaTJk69wPLWe26P+/uItXw58GzLeTXGL0G+COYwbtXa2JAkfnAlVGS1kUmySkghPmCEV
	 H4O8RJ4GxMQ4d99klQ1Rjsct6/NKJkNRzCwCd8N7TnYQxrRMSpZMFyCkjTvGqHknen2jo
	 /ubqN0VN/cIHeTTwOXSfo3TnNk769XABus9KrfPKwwUcQxO8KqWCMsGlydjI9lj8OvJwz
	 Na/Y9BtphDXb5RWVvRusefBNvY7TvKogLNQtuctJ5PW4byAi/w6tA2fyV9HuvX8H2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326120;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jXEeJjVSvGxZ8q8EzCH69WzOU8f2eD7e2wgHvZHQF68=;
	b=pqsr2j2DiOF5cF5p/K1vaBhHc4aWWc50TFQzVIjMnwxUOi46BT4K2tXZL7MuEl4UFhO0
	 1+oFwLx+r/C+o6WA2PCJIamlgfOxsSOmT/tmvfMNxN293jWV21acGbrClB2zDbOl/FqTH
	 sdBNqjIw2RGVvfMiw4Mao7dJVnLwiS6r1EyWJpdBXdb0BCimZVCIY4F6dzrHg4JENj1NT
	 tnj0MDnkkPUfmls6nlZeyz1wW6SU7I+wlRL97/HkVGkgVDSXGdCnxMiaKGD3MBV/6eGVd
	 URxuFxzW5WKtFS8KulIkKda8pKj2dSDTHqsIBthqbRH1BZb2AfPhVgkQMhATgoJK1vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ChxbJdqt;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD7606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FD7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ChxbJdqt
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fQ2I1M5NKH3HdhAaNaRV7oOmuMHnPLp6U9yM6UkMKTs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793326117; v=1; x=1793930917;
 b=ChxbJdqtseFWpGuGcRZcrnrbobTyUOfi8UJjCHg7dd9IrYr/vO0c0lIttd2Ioe+d9PBBYlyj
 UIhNZReqjWTzAJ4WUAUSmng/DOPlaQIQsKoc9tm/T/ztP9wVae3iV+y2By8iuyU1GmUNfvzYqz+
 uL4hkrKV7vpbFXKap87Oxb0k=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 952ee4ee204bc145;
	Fri, 30 Oct 2026 02:08:37 +0000
X-Mizu-Trace-ID: 952ee4ee204bc145
X-Migadu-Flow: FLOW_OUT
Message-ID: <8a565dd0-f2a7-4d18-9df7-bcf1ed303a59@linux.dev>
Date: Fri, 30 Oct 2026 10:08:31 +0800
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
Subject: Re: [PATCH net v1] net/mlx5e: kTLS, Fix missing error unwind when
 enabling RX offload
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, borisp@nvidia.com, witu@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20261026095346.1212609-1-xuanqiang.luo@linux.dev>
 <20261029134019.GG257209@horms.kernel.org>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20261029134019.GG257209@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/29 at 21:40 Simon Horman wrote:
> On Mon, Oct 26, 2026 at 06:53:46PM +0900, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Since commit abed42f9cd80 ("net/mlx5e: Conditionally create async
>> ICOSQ"), the async ICOSQ is only created when an XDP program is attached
>> or priv->ktls_rx_was_enabled is set. When TLS RX offload is enabled for
>> the first time, mlx5e_ktls_set_feature_rx() sets the flag and reopens
>> the channels so that they get the queue, but it ignores the return value
>> of mlx5e_safe_reopen_channels().
>>
>> If the reopen fails, mlx5e_safe_switch_params() keeps the old channels,
>> which have no async ICOSQ, while NETIF_F_HW_TLS_RX is still reported as
>> enabled. The next offloaded RX connection then dereferences the NULL
>> c->async_icosq in post_rx_param_wqes(). Enabling the feature again does
>> not help, as the flag is already set and the reopen is skipped.
>>
>> Propagate the error, clear the flag and destroy the accel TCP flow
>> tables again, so that the feature stays disabled and the next attempt
>> retries the reopen.
>>
>> Fixes: abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>> Found by code inspection while backporting commit abed42f9cd80 to a
>> downstream kernel. I do not have a crypto-enabled ConnectX NIC, so the
>> failure has not been reproduced and the fix is only compile-tested.
>>
>> The crash itself is the one described in the changelog of abed42f9cd80
>> ("async ICOSQ allocation is not triggered, causing a NULL pointer
>> crash"). This patch only covers the case where the reopen that should
>> create the queue fails. ktls.c is also the only caller that ignores the
>> return value of mlx5e_safe_reopen_channels(); the callers in health.c
>> and reporter_tx.c check it.
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> I agree that a minimal approach to addressing this problem is appropriate
> for net.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the review!

> 
> However, I do think the logic of this function is becoming somewhat
> convoluted and would benefit from:
> 
> 1. Handling error paths in conditionals while leaving
>     the main thread of execution unconditional.
> 
> 2. Use goto for unwind.
> 
> This is approach is complicated by the function needing to
> handle the enable condition. But at any rate, maybe a follow-up patch do do
> something like this would be worthwhile?
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> index 3cc1213c2f68..0f5dcd1b822e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> @@ -137,19 +137,22 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
>   	mutex_lock(&priv->state_lock);
>   	if (enable) {
>   		err = mlx5e_accel_fs_tcp_create(priv->fs);
> -		if (!err && !priv->ktls_rx_was_enabled) {
> -			priv->ktls_rx_was_enabled = true;
> -			err = mlx5e_safe_reopen_channels(priv);
> -			if (err) {
> -				priv->ktls_rx_was_enabled = false;
> -				mlx5e_accel_fs_tcp_destroy(priv->fs);
> -			}
> +		if (err || priv->ktls_rx_was_enabled)
> +			goto out_unlock;
> +
> +		priv->ktls_rx_was_enabled = true;
> +		err = mlx5e_safe_reopen_channels(priv);
> +		if (err) {
> +			priv->ktls_rx_was_enabled = false;
> +			enable = false;
>   		}
> -	} else {
> -		mlx5e_accel_fs_tcp_destroy(priv->fs);
>   	}
> -	mutex_unlock(&priv->state_lock);
>   
> +	if (!enable)
> +		mlx5e_accel_fs_tcp_destroy(priv->fs);
> +
> +out_unlock:
> +	mutex_unlock(&priv->state_lock);
>   	return err;
>   }
>   
Thanks for the suggestion. Agreed, the nesting is getting hard to
follow. I'll send a cleanup along these lines to net-next once this
fix has made it there.

Thanks,
Xuanqiang
