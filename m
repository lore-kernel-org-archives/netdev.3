Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BB36A34F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245960; cv=none; b=QraTAe4zydzm7TUe+4Pl/wSHtYWI4RADJN/4RgFPOighsAv2z5CWmq/rA2Zx3CH+vW6Fjtx5CInwzY+rgae8EsIpLEtoAw1IrvR0Xx8uXtfqFxiyby3EdVcgF20ZTNWAuEJnnXzEjMYEibuyS6p3UCjRUKO8iIe/cQg5ukD++2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245960; c=relaxed/simple;
	bh=PM8yG5L8nxfTl0hQPflJyNmieEv0klwsJeYgC+9+hsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blPtiUE0aQPLh8abtQB7I+Cm/oVUWf22WwRWqbKDdFkERdD3AAv5qZIOq3yWOEeWj7GzZ/whwLw1Y057EcgxSB3FnR417auheetOpfmPs1jt19eN4CQMtmhZPugAwSXnIxP//dTWFvol00Ef7MhpmIehGUTM1F8n4iwC1GkJ7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mKZHGooV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mKZHGooV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so3859115e9.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788245956; x=1788850756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k36GfoFRjCQq2uAtog6zcbE63ZtALQcw/6/pmjWfYF8=;
        b=mKZHGooV4TreMXbIz2mJyy1cPCXeElHjKlCkk5jSk9C5zd+ucM2EopkKA1bxeNLyej
         NkC2cFFh6U0cs8sSlEswtVEuO9ETRN+7UOiuaDHWalW/5hK2nGGUVOKVYiXtWl59ZBuS
         WeVhNzTx4T34x5dJ1Sk+7Ov8RHSp17B1Elo69nJdhMN0K+xh9akUypTxCq8MrGylsqNR
         NuzQCUXmkxkrm/D9M+tzjZA+SZkUG2uJ+EHTYRoG0VnM71Fo70uFbcciBlFvx+E0hnPS
         awn8kT0QVPDnzfRxx6E1LFhUOeiOWbgah39P3Ok/xrDzB5Enb3UJbAxwyyDFP3lNZtyo
         2S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245956; x=1788850756;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k36GfoFRjCQq2uAtog6zcbE63ZtALQcw/6/pmjWfYF8=;
        b=MlbqcDSVWy1iOtNiMDu5jip7xO9JP2kgyKaQv0hxDtNbhJhaN7vCMgcuxZ9wgrmtBE
         CBH8kRrI5u28PNXERtzHDwbW3oedx9KviW8iGbCPyKPXW+iFfz9vmPmnCd7kD4YbGVLL
         5L/+PlsbjQyAp1MjFP+Cadafu2o1F+eInob3iM+lXVEanf3Vd4uLpM/z992X6Xxk9M44
         LtE6JIs0kark5Lkni5EzEKsiPI+/ZSemuDQTqkLT9LuzQbKONyUojD1PioBEudzSDtKd
         qWAidn/WYwMohN+AWV6dnWzF17jaDprofhfCJKW6aF+tU/bmlOMBrDzSFhkTdGPB5pyv
         E/UQ==
X-Gm-Message-State: AFuF++kfuBf/YyQwLA7RGWB1pmLLN87aeX0CGR6+fkClvcsHPmYIv+mR
	jCAXgoFvl91xPFt8s+XM8ObO6LY2FuD0tAFauG5hcdYtxUlUgbFcUp2x1FUU81jkppY=
X-Gm-Gg: AR+sD10xvQsOL2O3aAHgPKyecT+BWKaBUAnEsshVvv+1oFj/QsDzFT9B8UA7nc1dKbT
	97BwCMYO2o1GzGTSTzARsSTj7gelrzU2YidCfOyc3Z6+0Y3cYcT9cxva1k9UVZYrPKJPropddF3
	sP8vb8h1PT246PSiqNI8SWs0Wya+4u6kl7Wgtna/Tec50A390hf9kWvpA2F3ihO3JBBXXBmk5LR
	3KbsAfn47stvI3I4i6L2zx0RaudxjnASi1cFzkzOLO53g+O0AzokAsu5QhCsZ1pDv3Ci3UeyXxt
	abVNTTMxqS3BCjKClUWVijtedZur3s9/GNm4TNZJg1zIaOQnqV3JLkAYZv3BI36jnH70yxpO+Hi
	chQSvs3SJmapvcVhusZFHl2i1W+EhK5+ftmNtljaLjGoRq4bjdiffRkepRqdoA9TBbxeFF20ctb
	3j4xR3ALBF9xkmccV/ejo+3z/s3Y4uER2wTpzuUKU7iqA44ZuHyvnlTei/7w0yjRiF+HdaDi6m0
	K5rf/dpmboyqoEzd+Op5Gmoe58q0A==
X-Received: by 2002:a05:600c:4e4c:b0:49b:e22:4ee4 with SMTP id 5b1f17b1804b1-49cdd416ef1mr48881135e9.4.1788245956428;
        Mon, 31 Aug 2026 23:59:16 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1025asm44368765e9.6.2026.08.31.23.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 23:59:15 -0700 (PDT)
Message-ID: <6e1a4e05-7290-4430-9668-e401f10ca4fa@blackwall.org>
Date: Tue, 1 Sep 2026 09:59:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] netdev: don't use dev->flags for IFF_UP
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 bobbyeshleman@meta.com, sdf@fomichev.me, Joe Damato <joe@dama.to>
References: <20260831164159.1124679-1-kuba@kernel.org>
 <20260831164159.1124679-4-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831164159.1124679-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 19:41, Jakub Kicinski wrote:
> dev->flags are not technically ops lock protected. The IFF_UP flag
> will not change when dev->lock is held, but other flags may change
> so KCSAN would probably not be impressed. Because of this we added
> a dedicated dev->up which is safe to read under dev->lock.
> 
> qstats want to make sure device is up, use dev->up.
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Reviewed-by: Joe Damato <joe@dama.to>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/core/netdev-genl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
