Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACC3128A3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442210; cv=none; b=mO8T+0j5W9pCv6MQ26L0YdxmIwZMYienUaE8vGF/If4Fjpiyjh0WDW4xErcc1GlaG7jBo3OGDUkUym5hG6Gw/Ux2ljdj0pXprjV3Qts/zfiHXF/qvwvcuHv14QOU/5XxZBkLdw5//xJej11GfT9YHFVPnhPw6biPk120A00W2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442210; c=relaxed/simple;
	bh=fzbMJhUAuMGp6GQ0px4BbWlOEM5YDr/DP0bRMWeEC64=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=COij24TkYYPKwSeKsCq3AfikjWB5vxKFLad+Irrde5hVf5FEVZ2GfhUatqnD8uS4ELb7F+oX4yNV/BDJ2j62AFX06O2pjfmxmGxVzU0hpEDi3oDTl3mjIEZxeSq65hzKCfF1P36cQx0wvMRS1q6GkUEziP3iPZrXpmnV+jtPKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDhBWpIo; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDhBWpIo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-650221149e2so3330959d50.0
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775442209; x=1776047009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om7CMU+KUBMnIrb1uq7hMyiNSH8jke3lfMQm56Bk+Qc=;
        b=rDhBWpIo5OIl/rG7cjeoOmvBGRIhAW19w4KnoJpcp2aUZ9SoWfHxL9g+CXfWvT8cKy
         tW5S0tfaiLGXyWcG71UAnA+iQ6YjMeb2HhM9UUM6AWUzgScoqfLjhXseoMNGPm/yIYjO
         O81O2DkPh8Z66B3MrNZNfOKkzIk3tzp4OBKnM0suaa80s/KUAxJ3mTPfcuT5+5Gyo9mz
         esdSY2GvLOFsyWt6TRW45fq69mSN3abEHRqtmpTG+kgYBb2mX/StcSimJ+M/cH/yo6P2
         Rr6bKHgi1be8Ip+an9k7ACPIjqjk3eGlsdFA2PfxVghvcX1v0AF8HerpSpUs0YdJWLJJ
         Meaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775442209; x=1776047009;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om7CMU+KUBMnIrb1uq7hMyiNSH8jke3lfMQm56Bk+Qc=;
        b=HU70k1Pg9daRn165/swwghU57ztim75X5r6H12livb4lJbnchBWZtAQhS6GT+BF5TC
         TEvKNp4C3vGLv7vxMg48/yiiL61mxqypVwU+wVyDg2fgS3OAZFZ1IAglyx00NTlcqGAX
         0XyBPaFo4vpZoyxiPtyhMgvVDJk9OjtwgG3IOELo2J/ItAGlKbdhQcM86v1QehSMOQcu
         g38ShwHNX8OvfyDRjnfDbNaKzmDc2KERKWpSQ2MhKeclI6mcUJWzpvAeTaGAtuuqf1Cy
         2YCY4j4kpYBqmbha1MvgO1D/EL76sT7CE8ef37+Wf1fyHCE8SXMuD+ddLXSEQY7IClwA
         cpow==
X-Gm-Message-State: AOJu0Yxpn2RW/siqlfL65w4eybIAKw+K9JQmB2RuSOgvlP6pXKPHaxc9
	0XPTwtJyvogDvtTicEIkoM1tzMFUjXACVM7uwGGWwAARHqsu733ucEUw
X-Gm-Gg: AeBDiesoYprBmX3KXlmlNmaD3p+2mpn5laI+Xzju1xmJHq9n3JVxSP5aZZXIe0MN/vF
	TITKRdc1nUqLYY+kc9ajWKtCYK9jXl9Uf2eTlriD6OdS2fiDJ/OYBBMshwOAj7DJuBHoS4Cl0FK
	zlF+G2HXvCHqN3cjlN4wZhrmYj+zBOICXkDd9BOwGMdVVPU8HHysm6EZ/SomX+WeGhzm+08FkH9
	dlMcEF/eG0txxU9EqI886WofCwxu/7R4+DhUAoObfUW+agQZ1kA06Eng6d9O8g95UfKnDxr8FU1
	Y/ER++P+q6KGVgOkQv9zHipB+SDrbbGnyzasgRlFhE3raOhb3tFUIkggcQvDtzwn60Hw4eghcv3
	IvAdqV0I38594tYl9DTbSVaV2EGNgbo/J/3/EU6hCfGNsSPOCaB7s2NoF5aSqLLm30T3Kn7uR8L
	mLQqx4eNbnnSNxXCWU/B6QxvqvRow5QnsH9jOwtZh3vk77n/an40KWwIk4sXrTKKSnI/K3sPLwQ
	Fro
X-Received: by 2002:a05:690c:83:b0:79e:9cc1:edf7 with SMTP id 00721157ae682-7a4d35d7d6fmr104588547b3.13.1775442208679;
        Sun, 05 Apr 2026 19:23:28 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef3fa5sm47715847b3.42.2026.04.05.19.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:23:27 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:23:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
In-Reply-To: <20260404150452.83904-3-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save
 cycles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Check the tsflags first to see if the socket timestamping is enabled.
> If so, then try to fetch the last skb from either write queue or
> retransmission queue.

This message does not explain why this change is made.
