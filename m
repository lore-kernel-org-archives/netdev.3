Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56450408033
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472969; cv=none; b=Z70gyKSVLksgBBnRUg9DfpdKPUOZocu6FHBVrm7KMIXqhVI3e7dZtoEgue5/T8Sre0KGyrcDiebczzFSyhvW17/j7hMGoZnTp6XYmPLc/S+mAul1NgDfimzBX3mXqW1zmWpo88AnuGlCg+5EeD07FwFkopu6cW8XdwZMLGTlOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472969; c=relaxed/simple;
	bh=zEG+i3P1lHKCAC1eCi91e4ihr/Q/qxsS4WTGc7Ig/Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSaEo0189v5Zp29mhAr1g0HbRA95eE/uLkCeZlqP1NeQKPc1eprUKZ9jon7r5wDHW0JoWeFBwZF1cFsBxaaJXslbDNrhsrOcE6DPEURmXctA3rV2kibrtdY1RHGEJ/dm2keL1m/RcWF/t+VvMWJKSwdGc0dFtn4n20CYEz1Hg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LU6R/nbo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LU6R/nbo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so15350925e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472962; x=1781077762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZKrB+sQPLZnuhkbyzkgA0Pj2pVr+WrfmmMKpUXADMQ=;
        b=LU6R/nbo8bcKi+mmsycrHRHhwLTFd+IzOnkob+Tgj9A1oGCQRxYVs8pM5xSncsVcSK
         cnD/CvFhllab7f+VuQ2wKpFWt6q/8p0oaP0dN5ymjalx3/ytTyG4eKNW8JGacmEwrMcS
         MK2SHJMIlGUfx4ADphDsYnaRvv3idcjpZVY7xRk0OSssOprB30JAxvtQrXeu5Ol9+Raz
         3B1kmW7Ulfk0Q/G/oY5URkJQqlS/rFKZI77FkRZ0rjXa6Fo4/MogJssXLPjJBdCOcMsD
         7GVmW8faKZLqK8Jt0yvaiO1twRF/y+BN7La7Bkv0pu125D3sJ9XYkQ+YKd+UxvLZHFct
         mhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472962; x=1781077762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZKrB+sQPLZnuhkbyzkgA0Pj2pVr+WrfmmMKpUXADMQ=;
        b=BWywqhKBQsnWw1h+4MlQu8QrtAAI2L9xoxJjE3W113N1i3rP6LMNf9B+WbWO4ywJ+J
         a/lZqHjADZjKy/qFdMvNn7ME9YiJazPMkUU1FtpdBHgZqsWSDrsjbzL1SmjO9a47gKaD
         /imsenqfFk/x82AJM9K3vF+PkBluY5xJ9aMtOhdtI8PLoWCXS5weH4TelSsYub+GDaFK
         msLAk4s+saLEtSHBvjCUZ6KRLSAfeauyym72LnMInFspuEu/wb5f98pdiSLv/aOjEiQh
         KrJFVHg5ErWVFkxBqOVTfUxsMugXTlj6jiXY4VM3okVqUZPiPasH2raeTrj3owEXYILv
         /tHg==
X-Forwarded-Encrypted: i=1; AFNElJ9+WB3UFq87uouw7X4/Ra/Ys9Obp78vKH0xUC6rdQagnvHi6OcSekeACj7pbRIUulY7XkpLeFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiNAo1552sTnepO2zvJ3cJ2NH4vfHfGzvjvgN/+nN6q6InbEy
	ttTBM8sPinqRu3EFqwvQryoWp9SuMbcKNcgonCvpyesDRy6RafVXtsza9wim47BZA3I=
X-Gm-Gg: Acq92OEqFwSkGIZc9RYeVRO5FO1JKafaevhCEFZtTba4trYWx0MnyZZC3C5UQUq2Aat
	VUkMgZRSCIWe9iIK5nsi35m/p2MGWHWXchHkLRf9tt6oI1PpGMuJhfxCRr77hXEQmwClVkjUZTM
	iNWouIas4WMr7/LNQQTF8IwFxAarnoMvXN6iyY0bKKB0FioSrWpEbvMG/4R1QLZU/GU8348Pg4b
	sOrYXkdXTRzI2IQXRUD5USCmGgBQQK77qQcRpbxpSikPrh28HVSv1z5io1w1SRJcEIV+f+M3zYs
	25ItYoSnB9y9DVNh7eqdGoUT3ICLuqBijDkvKFiCPYrSMvsvB1bXq/ilScdppuCYxT02j5QaSqi
	AckZzUJ3tuXhCQUzHtDLtwPsOechHLSKRneIGuwyCMWPUFmF6Cs05K6usxMfiAvvGEE5pJKVBBA
	EVJLuL1BXmVIodg7juczQftGBKLCzGUaNDFnQQTZtDNgAh/pfQD4R1066BBbZk18TJ
X-Received: by 2002:a05:600c:470a:b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-490b5e51b3bmr36495775e9.18.1780472961635;
        Wed, 03 Jun 2026 00:49:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm201972655e9.0.2026.06.03.00.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:49:20 -0700 (PDT)
Message-ID: <300c7fb3-9a8a-43f6-93e8-90ab268178e0@blackwall.org>
Date: Wed, 3 Jun 2026 10:49:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 08/11] bridge: provide lockless access to
 p->priority
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-9-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> sysfs show_priority() needs this.
> 
> Also br_port_fill_attrs() might in the future run without RTNL.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_netlink.c  | 2 +-
>   net/bridge/br_stp_if.c   | 2 +-
>   net/bridge/br_sysfs_if.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

