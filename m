Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F11D86FF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133752; cv=none; b=T+JPfY66Zv2jrOI3Aw54AHY9l7VkiU1dTNGP1HKrmFq2OWbKp4Bz8Y11+8lFdQcvjP8FfaDp0E/L3+WLSqEAZQDvLwh2aw7DY/JD49P9SqkX0Ke9P2JQUo88xqG4L1ukrdGp8UlBUOXNDO7HPF2amsvTftg1egB9XWYtkRkyv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133752; c=relaxed/simple;
	bh=wRlNcOB7itbkjYrmZIWLcKJrW/YQBayrAT12g+/Z3bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oomnIP80GiPSWCyRrgy4NOrezdymDlFxqaeY3MT9EkyRJo966unjifz/52YmEc1fYShi2At+SX8QvjqHiKyOPm4awJKvS2wIv8Ff/YB1LzoUbQBzRJab+n++AuGcw+7zJFvOI9DntSqyH+eN9h5TUJaOswJGQHOdQUxU/rB8t5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ein5hUTU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ein5hUTU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980dc26022so8499355e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787133750; x=1787738550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cg+yldF2jGU2W+Aday5IEXW6RsRpaufWTkAHi+tbVKw=;
        b=Ein5hUTUFRoPpk/7OH2yJvtGFVC9GGqltmpZNap4Cy3EHMeKSyZvkU68MhZu0ILEfZ
         W85KM1TG1LBm+y933L4vSKm/9zwoJeiyx5LuYHCPquOwCjD5RqQE3mIuwhPKja0ub7wi
         PxkmB+81fPIcPHFTJ9IAM6VoVKE2O1RGJNhw/wsh5O/l36pECmyhemQ2g1xKnhAseQbX
         DdEfCnNdXiZXMlzDC0GXSHogZrMUyUF3wieZFDdATVy3GQxrzTjnTFpF6+BxlpMU1i8J
         5lkz8+UKmU1M41Ck73822InK9LMMLXz2fZDRqk8jBeMHIY14lW0DyTl5Rg0i2p+0BeAI
         UqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787133750; x=1787738550;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cg+yldF2jGU2W+Aday5IEXW6RsRpaufWTkAHi+tbVKw=;
        b=sqeT/1ITUGBq/AmpeXTWHYeNQQ/MsRxC/CSMG5Kpur5WYaDenZNGDAVhBtdIO+VTmL
         Ort9JLaddMA6GXBYs3iIPIzzQ5FvorDuaqIYbed8/KWxRjrpuKJMXibeN2Ep34kh7KiH
         zyX/l/1TbiGS8Gaj7mYjEuKoPxZKuZSLkZrRsa6nHJpABJ2KfyzOdYiSSeVCerSoK6lY
         Ipi/DWnsAFAeFzQMZHqIP+R7TQBm9QJZcGQf6kO5j7CTmjUy97yUXFNpPcKV5ACZEBg0
         xu+kPoAiAN639qfkYVf6oSIWVURrzI/nwBhby/vQ0Ax2UymctQ/vo73GH2EYoG/L/Fmu
         8wZg==
X-Forwarded-Encrypted: i=1; AHgh+Roai0+o5pm4bNkKUpZeg02ng5LPDH+E/Lr/mcyE9eVrQdU7nVGlmR0iERvAVHcLEnVTOIKbakc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TmHSx9E0CvlxReJBpy8POtJ2GIr2pkBWcqgpIdctq6duF9w6
	m31/1qlNUkXuBme5TwK9pc0IT9wbeGF51PSH+DvL2bYWF3NNzbT4alY8zWYLYgmQp5A=
X-Gm-Gg: AR+sD12Uh6EbOLEv/SJXNJ2m+crmuHShF4haQPE6rWqObcmgtlSOKz7GaLW6T9MlPtP
	3P/9aNV3A27xbeP9/OSW4LSoPqhMGm1IHL97y2iqgR3JZTIRLAfnVJN45uaPeyEIwnGCDiE1Ozt
	w5uurn0FzY7kfcYs+EMJPKNSCjZ+/E3ek8s44zNUPOf9OqUlfxmSYOqWb1mhmLd7mcnB9fFwN52
	6SiZ9APmMVmNTgllRSYOuB1Jp7umYagLLlXXeI+WZh18t/K2cAsgJPF6/LBBQbhzid13fmCSXup
	V5zBUBWn4QaVbHikCYq0KJ5ZFysrlLU/6G+ODKD0QbZxXSI3Nm8OPTyvz8mCnU/haivn0yHHCvU
	ekhe2cP0aw/4/Y78boOhjzmp4TKRP04gHFAC02sGCNFNbolEdcEG1mpGQ4AL0peEkoZUCZahsqF
	A0ilfFiL96kymNnsyP6WYck+/28Rdvwd66af75cWZDadMTb3MMFayQRwwJXvfGohfKpq20GjkC9
	dIYrOwjRqb+rPK8Z3sVnUwOFQqPeQ==
X-Received: by 2002:a05:600c:8b35:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499aa1a54b2mr62359805e9.8.1787133749281;
        Wed, 19 Aug 2026 03:02:29 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e09905sm63333605e9.4.2026.08.19.03.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 03:02:28 -0700 (PDT)
Message-ID: <c89c5035-8c53-4104-9ca6-cbeff864c01a@blackwall.org>
Date: Wed, 19 Aug 2026 13:02:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
 <aoUP0sLeEhCPxukB@fedora> <aoUQdublxcfZzqzE@fedora>
 <1ebd9c8a-5b7e-4ebb-9c7d-5b2b2fe4a675@blackwall.org>
 <aoV8hvRlyRrFQobA@fedora>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aoV8hvRlyRrFQobA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 12:51, Hangbin Liu wrote:
> On Wed, Aug 19, 2026 at 11:35:29AM +0300, Nikolay Aleksandrov wrote:
>> hmm why don't you change the way the reset is done? *untested* but in theory
>> you could just record the values at a reset "moment" in reset unbalanced and
>> just use the delta, so it becomes a reader and there is only 1 writer left (tx).
>> Keep the counters only increasing (important), only record a snapshot at a reset
>> moment, count current total bytes (sum all per-cpu data), decrement the previous
>> total from it and use that as the "interval bytes" to div.
> 
> Oh, you mean add another variable to track the total unbalanced load? e.g.
> 

right, but without any locking because...

> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 659a77323444..a65be54049d3 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -1546,10 +1546,10 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>   	return bond_do_alb_xmit(skb, bond, tx_slave);
>   }
>   
> -static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
> +static u64 reset_unbalanced_load(struct bonding *bond, struct alb_bond_info *bond_info)
>   {
>   	struct unbalanced_load_stats *p;
> -	u64 tx_bytes, total_bytes = 0;
> +	u64 delta, tx_bytes, total_bytes = 0;
>   	unsigned int start;
>   	int i;
>   
> @@ -1560,14 +1560,15 @@ static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>   			tx_bytes = u64_stats_read(&p->tx_bytes);
>   		} while (u64_stats_fetch_retry(&p->syncp, start));
>   
> -		u64_stats_update_begin(&p->syncp);
> -		u64_stats_set(&p->tx_bytes, 0);
> -		u64_stats_update_end(&p->syncp);
> -
>   		total_bytes += tx_bytes;
>   	}
>   
> -	return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
> +	spin_lock_bh(&bond->mode_lock);
> +	delta = total_bytes - bond_info->total_unbalanced;
> +	bond_info->total_unbalanced = total_bytes;
> +	spin_unlock_bh(&bond->mode_lock);
> +

... there should be only 1 alb monitor running, no need to lock to keep it up-to-date
     also this is its only user, so remove the spinlock

> +	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
>   }
>   
>   void bond_alb_monitor(struct work_struct *work)
> @@ -1612,7 +1613,7 @@ void bond_alb_monitor(struct work_struct *work)
>   		bond_for_each_slave_rcu(bond, slave, iter) {
>   			tlb_clear_slave(bond, slave, 1);
>   			if (slave == rcu_access_pointer(bond->curr_active_slave))
> -				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
> +				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond, bond_info);
>   		}
>   		atomic_set(&bond_info->tx_rebalance_counter, 0);
>   	}
> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
> index 51c083c76115..9d3877644286 100644
> --- a/include/net/bond_alb.h
> +++ b/include/net/bond_alb.h
> @@ -131,6 +131,7 @@ struct unbalanced_load_stats {
>   struct alb_bond_info {
>   	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
>   	struct unbalanced_load_stats __percpu	*unbalanced_load;
> +	u64			total_unbalanced;
>   	atomic_t		tx_rebalance_counter;
>   	int			lp_counter;
>   	/* -------- rlb parameters -------- */
> 
> This looks like an easy update :) Hope I didn't miss anything.
> 
> Thanks
> Hangbin

