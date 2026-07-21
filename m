Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EC471425
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663513; cv=none; b=fO889aswHJYNV6/Fy63/3PqB+ENdk7CZ36OAGlVxFNitKsY1OxZvMEYq6xwz9IBpU3km61oQ35CchTSaQe1fhdGgnZ4m3pUG5Fot279yoVFU7DvQ8v09kSm6ti3cs93z7j/gtZz/gTDJtQ49KDZmWlOkrVSNSFiLmLCqABw2SWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663513; c=relaxed/simple;
	bh=pcfYZsW5GJxrppNfg2PPv6QOtuIwDObGnm8vEwV4bSI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dIyx0aNJYTNqeiCl6FI7JpC8WhhoxJE9C0ZTD2z1Dcs8WySaq/jC6awOEZWKYyKWmLG+k+l3fL13nNydyVH76/AjmItEtLy7B47slTMUpvAML6vsa4mWZITayb1GRoIEZPqAkFbzJB6U6mjjgZA9fFH0RYO+pUcuHNqNtG5Cqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAHIUbAy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAHIUbAy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ef11a0972so55226377b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663511; x=1785268311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1hwK9utK8maH1goNHBFSjyplyEXYS61mGZKNHEb4ShY=;
        b=MAHIUbAyXVcunjvWuaQAN3mLZg1RIvE+A5wNwKH/2knkPsDnIB1mKz29wtKCtXagoy
         ambMGuR4MQSkn3c0gyy8GtA1VRKNtvwOrLOjQkUUz+gEYZMjl4s2GOHGBHdUCS8HaPQ0
         bVg5vYZWqYRBlSD3Cxt4xhnluF9Bjgwh+bHrSt3g42W6Gzj2lkFkEtohImE6TL7WUMhC
         SfYpU8lMnoTufLTYdndFijNYMh9ws+ucZbdXnk7T8m23YrHtbOq9x+BlzIK6IEez/VLQ
         6QW0G2dFF9gu8vNfoQBBGz81SjmvGkQrB1iWL/FajQ3A8OHmG6zTcf2hd0z4ZLQEt3wI
         c6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663511; x=1785268311;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hwK9utK8maH1goNHBFSjyplyEXYS61mGZKNHEb4ShY=;
        b=L901ku9AhDX+l536EOgQ7eW3RJUkHqywEMAxJo2ODNAubvo/l/biZ8p/z/bVWHCCoE
         s6RetDWkZ+Tw79JxpUnG+MiqFjLezCUKiq9f2xYJQ9lTNMSN8v6fg2bcUZrl4W++D41w
         26qeR60a/p3ZfZCMsFJCwHaDgkzat5F4DuPBslqmkaDSYP52TV12e8IxPV1iDdZc8JMd
         BnTvVfpaub5OICpkQeS6+lRZJHBb6UT0R1kLzkm6WfCKNLAw3ZaQsIqcpekCWD7UqXb/
         KwWNUoS7zS5OzNOyxi1C4iC/vRt15Nv43YBhnBhwOmCjBlplIiuNd+WJYovZLBMS1cUQ
         kZQA==
X-Forwarded-Encrypted: i=1; AHgh+Rrtw3xWJgv8IgqDreGT7ejioLQYCCRoykLxDXHJhznEo+DRiFFEFKVy9QmHE6+gNZfPVtxkd2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfczOKteE/kIwJ1pElQQCrW7TteQWnhlD7Y2A0P6xp9zli8mD
	uJ3RjOXtKOkJDSRljoJtGjb1+Tvqy0L/wfOllxQ+XVMCs1sQOlSsG/JZ
X-Gm-Gg: AR+sD11/4J9bGfBrlxnaAxO+cwcz1gCNu+U0hflvDqgRsX/UBjjFebXWrA0rDCMyhvO
	IZS9HzDwMnGezXKMwSvDvhsapBODwjkV+TZ8ejBbu9rBRf4c06oxA1M4ZfdTCOVUIz0Jmm1FbbH
	JZmcNwUBd7VhX01XIPqxr9qjkFjp9QLG9wzL4htWSBD6uUsXLL500qGAJbRlGrLdEj5Rj4SoCCn
	kWrtfo1Pd9Xny5s8rftEzAsuSiV99uptPs9lkAvOEjTo6K8yPKe9wKk/YEVx3btdjOp3mSlTLYj
	uBEn2C3OqHuFYGWdhRu2wrYkvO3rs6mDUk6Diq2goVnKX4xmLwu8LN5HOh9iRyaNw5NICClQGhe
	iK7sMJVEWo7faQD6NeVPafqQa9PkZ3/a5Duv9KqpW9aARNpioezIgMZW+tijAV8K0ZNoTK0nHbZ
	BRWM0s6eRGa1owpakz0wUZeIknY+7bdsIP6KaJwBe/SvyvhXiVZUDznO4=
X-Received: by 2002:a05:690c:4801:b0:80c:85c6:897f with SMTP id 00721157ae682-81ef263285dmr61224177b3.62.1784663511458;
        Tue, 21 Jul 2026 12:51:51 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33ef0a40sm2741587b3.39.2026.07.21.12.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:51:50 -0700 (PDT)
Date: Tue, 21 Jul 2026 15:51:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1c390169c9796@gmail.com>
In-Reply-To: <20260720122714.759175-3-joe@dama.to>
References: <20260720122714.759175-1-joe@dama.to>
 <20260720122714.759175-3-joe@dama.to>
Subject: Re: [PATCH net-next v3 2/3] selftests/net: Test PACKET_STATISTICS
 drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Extend psock_snd to test drops by setting a tiny receive buffer and
> sending a large burst of packets.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
