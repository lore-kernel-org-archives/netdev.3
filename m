Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71C332EBC
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841274; cv=none; b=X1l1Hf4ZhtBatN20HL0DQKl4yMDLGExzcNYzV8pVIo+leN22/hf/EAKtnmCvn0FFgS6CEtrApIMS+msNe5UC1mGbgWj3hOIFkxO0TyaRHCdrsVVR8ombcOX3oKnlMuRQU6Mi94jW+X3qQ5RnIhxHVTGL9a4cJUwfbqWatOkCZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841274; c=relaxed/simple;
	bh=zZ+Qj6Es0NnBBB/krCM072RlGUjbGN1xFNtnJKtKur8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRkXm3ONOf5sjnwH5ETS6iS66MkNM5cARRjqE7bSYfmd/wRgxoLp4/AN2CAhwvYGMtLBTX1Vbk/niQQZzHtCsvEIGQtjSBJFRmxD1Yf46c64EtWEEOhf+8BaGng1kYzSvMGBNaS3jlpZ2lf2Colg2lrRH8DQPb5rDdFJYVjkTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ihD+X2Uo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ihD+X2Uo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso14484555e9.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789841270; x=1790446070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jaIZI05s3E2LLLYS99VJR5T7zbgwyUaaN0d4bzMK8Qg=;
        b=ihD+X2Uor/BaheJRzGIDFkYS2zOQN1zE640fNCoxbvX3Y9NIGf0MZCkTNP52ObRXVc
         C5WH7NR+kRTeHJk18NNlaYyiZCBWsectBKGDWRjsOl62JQBXd//jApbNvZrFKcKAb/Uo
         mHhVPlGynkc7wT3o90P+JNgZLnuxf+tiCfdYU9QrBcf5Pp58ydSInvZ1fAhPNO0ESehO
         BeMSMai44TuXPATxkEBVl1OldCwlvvgOYsYbSM/+i2bdPnRboDl9m6RN74xcUzilewVh
         I5zBjAgfzpZGAug2CiewhbpSuH32YyCveiIjnOVEDOTKEh5Ni9tDrTsekNrJ8++gWYX/
         j7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841270; x=1790446070;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jaIZI05s3E2LLLYS99VJR5T7zbgwyUaaN0d4bzMK8Qg=;
        b=sclcuhxY6sWnitCIMtSM2C13zCiJUPd8R0DUPDcK1GjN8k5VWZewiBZTiQTj4UAUav
         3DxF5+i+PpgChQgQisiTKrUomcLmWwtrpFn6rdGSFIzRn2upfE5Pbj3tjyET1XE4xaSE
         pQwFX97dn1+jtV5ppk+93cN1U13QIXlujNyXRcohtJKiSMcNM9bzUQ2zm2ua77RkuLRp
         YyA0E8bJ8impG9hGQLdz+sCQ02nVqJyQX73deOqAWfTxTbyvARF5Xj6jbNfFRnghRasa
         oKQq+stoD415xHNNbrV/tTOXrbs4md6ml4o0F2/StRPpCBSi64pPo3GylTJUMt6yq3Qi
         4ZAw==
X-Gm-Message-State: AFuF++lgHnXwIIT5YdhsaguqQ6B3Y80f/l1kulXhb+GncD2u9+XyjZJ0
	3O0H87/JZ8QGkJQ6pWlShbs6uK91mJMT0QkxI8jA1ak8NMZLxdqzOnBEiUZsXvAs3fcbcWK4hKN
	qkDvV
X-Gm-Gg: AYBFou1Wjk5uEhZMdy5pcPafmHYnqIt8XqBz7dttYmLG79Ff3mTtWpMLO3AdoA6aOPZ
	edm4ekPUloVnBalKSUJMpdIMtzgEXtZpPSTuCc3pmCxOrCz69XZhLpbpq3OZMRxz3nd76Bg9KnM
	+rkSHp2PLmkGNvfsjvp0RYEB6XyJxDZ+Bk616YveYj3MPeKg0XVdeH5benHmpvPxzBhVFYQKjLV
	1lX0YolncdFYQUZgUADUCj3GIvqgxEKHgUwyY182NAm3cfM5WB/oWYwLDRpcH2FxFX8HDI0tDuF
	zeafLqJ8WT+NWMOIOFMa3kQebUKzTp2f21AnQ7s6uJS/aUSK2uHSnz06eWYo6hj5TrCgGIiuXmA
	MhIV4kS4dz6VLNO7g1x1EdcTjZWLumQP/dVxIhlyfuLRhPFdNMtnklVffvd0h0zVk9167DokOAG
	79cspn4Ss1XTxrk6Lfvw878b235cc/EsnFuVPGktx4N8XZTK3x4Eur6tPgiH7EzUk6vFWLWZv2z
	YtQrBnGoPR1O8vciTm9OyaKzWs/RA==
X-Received: by 2002:a05:600c:c493:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49fc573697bmr79722755e9.25.1789841269149;
        Sat, 19 Sep 2026 11:07:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm333932115e9.4.2026.09.19.11.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:07:48 -0700 (PDT)
Message-ID: <859a23ef-81a5-4bba-a728-49dbfc8a575e@blackwall.org>
Date: Sat, 19 Sep 2026 21:07:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: bridge: vlan: cache the pvid vlan entry
 directly
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260918152950.1938259-1-razor@blackwall.org>
 <20260918152950.1938259-4-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260918152950.1938259-4-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2026 18:29, Nikolay Aleksandrov wrote:
> VLAN groups cache the pvid and its state separately requiring state
> updates to keep both copies synchronized. Lockless readers can also
> observe the pvid and state from different updates. Cache an rcu protected
> pointer to the pvid vlan entry instead. This makes the vlan entry the
> single source of truth and lets the ingress path reuse it without another
> lookup. It also makes the vlan entry always available at the ingress path
> for subsequent forwarding-path optimizations.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_mst.c          | 13 ++----
>   net/bridge/br_private.h      | 25 +++++-------
>   net/bridge/br_vlan.c         | 76 ++++++++++++++----------------------
>   net/bridge/br_vlan_options.c | 12 ++----
>   4 files changed, 46 insertions(+), 80 deletions(-)
> 

for this patch Sashiko says:
  Does this code introduce a memory corruption regression due to a missing
  release barrier?
  RCU_INIT_POINTER() publishes the pointer to the datapath without an
  smp_store_release() barrier, unlike rcu_assign_pointer().
  If a lockless reader observes the new vg->pvid pointer before the VLAN
  fields are fully initialized (due to CPU out-of-order execution), it might
  read an uninitialized v->stats pointer in __allowed_ingress() when an
  untagged packet arrives.
  Calling this_cpu_ptr() on an uninitialized v->stats pointer could resolve
  to the base of the per-cpu memory region or an invalid address, causing
  subsequent u64_stats_add() increments to silently corrupt per-cpu variables
  or cause a kernel oops.
  Could rcu_assign_pointer() be used instead to ensure prior initialization
  is visible to readers?


Nik says: No, if that could happen we would be in trouble even today. These
           fields are initialized before the VLAN is published, i.e. before
           inserting it in the VLAN rhashtable and linking it to the VLAN
           list, only after that the pvid is applied by __vlan_flags_commit()

Cheers,
  Nik

