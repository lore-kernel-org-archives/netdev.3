Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142E5326CB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178018; cv=pass; b=WangCpU2IGmfYPz1PJbxbnOaIZwBQvfG2VF8hKKsL0y7bgxuUdlvE40lBLTGepdK36Gj/TtnEpqKw+cWIX9s9XVusZUUW+GV+m1Ir9fy9MwEfFgHlvjHJL2Hn8qmHhlw8d9iVnkVGbgXDGaFCSkv0HOUmH76BAZVmgHxb3VqwwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178018; c=relaxed/simple;
	bh=plBphVis8sYLOOrAsqWWkAJL0HO8LEBNGCFMlGRTMVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBAVhrE1pogl0nB1vDJ+zzEaWAOstBXpiyCcNMeOQo2D9XlMwj3W3bWtvwI7mygvzAi6W5gxpu8e9/UzNNOOBXnYnSsgBU7p/sXJtAJeUOiAQQjWkHpDcZrXzjrVuyLvcXGkrzvG8hlUsRPfTfZG+qd0GKopwhUV11fo5x2c7to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm2INPB/; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm2INPB/"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b18f28268aso31718eaf.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790178016; cv=none;
        d=google.com; s=arc-20260327;
        b=hDC+pq1CTOXfjSp8mTJwbcdRrtfRhlnAD+0wZgbTAq/0tc4W0BuWFnDw8TiiOpUQsY
         DJjT4vgRZvnyg7BSMpd7f2bymJCHolSfvGi8FMaRWFFUv7cgoDh/TbgwIR+2oUr2DTbp
         /MbySiGudf1o7wTJqGeo5WX/2958RWohBovLZhnoA7IL/2JnlFuh58P6OUXn8Z/wpDVv
         Dfm4e+2jdsop4x9pDSTTF5aUNOJNuxI5XyXJxlHdxNUEOnxigvLwaBpeFM5GmohhsE3m
         2wCRh+wKSHqf/bHn60bfPH4MR8Y3S2IsWvzmi/Azk3BFa0z3lR5n/RgRNo7cwOjDchh2
         xuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plBphVis8sYLOOrAsqWWkAJL0HO8LEBNGCFMlGRTMVw=;
        fh=SojSOu5WFo423zDrm4SYfD5XktzNjiiXLgDhGPZ7EXg=;
        b=XyCsHmm9GC+oRt4FwLyTRdnTqh3BQG6Hrektv/fJZrv8jfkYrALwUBvIAFV977rPug
         r/CMevWU+2upINDHufmuMPFQHgSU7A1fKbnEKZY34zxyV3udSm8nxNJF2PpYvrTd7uVl
         jppuc8v6r7xG63tYcjepkH+yYtnQHmu5WFIyLRSKr3OyYw6loLIUhhGLf9hIov805ctT
         251QE404fN3M/iBwAEbt7++4OLOOrVtAF3fTzlqYSFs4g5Qtgvt4BUx4+b/SMFFMbILE
         J6zWgeQb7gu+9vh5/9PpTOAzELw1+BXTd9inMlBM38l0MItke8lybQS7DXhRnk2dM4Wj
         KbSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178016; x=1790782816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plBphVis8sYLOOrAsqWWkAJL0HO8LEBNGCFMlGRTMVw=;
        b=cm2INPB/9rCqjGjznTx5zKWjrWfIWpnXs1FvzTdYqkVb88o7r5PsQtPn0uiuVPmnXC
         MX+tQKC46Md0kIf/xSfql3JI8jk8bZGaudWm+a8OI+3n0x80ECOAUxLnbh7p4BymQ+1z
         gGDM8DX+WamDE9uhQ13GCKBtV37b5dIVJh68fA7G1hIyak8/GH30PUmpcg8N8qzSuaJF
         Hlsw4VRBcntF8kMTGrBbWpCl+d4UbAkmLzRdn3qJUIDIqH/nulpMI2ezM8OoUKZ4540a
         w0l36sjehhvgGfijL8ne78bQImuJ3/DR1UVURKu1a0NYNGWDsySW8zpg1XkCX7ZPohuY
         X0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178016; x=1790782816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plBphVis8sYLOOrAsqWWkAJL0HO8LEBNGCFMlGRTMVw=;
        b=CAJVxqvJ6tMsFY6JPm7xsj4lVxqZALMVr2ScdgoW5uyiKXHKtXQdcVTXCKLG00BGy5
         tSf7UxCKgZTxUdBjdwrgo/iCdVB/XXKYvWMZP/RezoGx+laEdqul1/ANR/L01PocVysJ
         OEqekx9uhDBNXfrinzH/gS5FKBID6WsUapE+aTkpzdqsIofNmwWa7wnknFjRDCY72eyd
         egq4UI4n9TxWP1qrBdCxvPz/+lzAaLROHeSLy1As1jmJByTxrxSkCMeqDZz6wdVQTPEX
         wChRdKgMj0uK/7l0UhwG+9xYNpJ6/ZRrLx68U1gnpAM5QwuwdKtA+7l4G/VXye/wno7H
         AHlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVW/vQ2bDBDUiXXbnWrInaCro35UuAheNf9zNgIO4jFv3MmK4tDJ8iOIO2HKhD7ofEngUlDqM=@vger.kernel.org
X-Gm-Message-State: AFuF++kcssXG1YHZGhfQ9+I44WtwDmGYaPy3eo+SMCyPr896DwLoVlkB
	UEviK+k3C8m/A67sCpqdqrfl8nlqKI5O0bVlR84L8VK7hdHfUiN1rOi4+/rP4Cn17eXrd8yCz9J
	yH/q2ulYGEVhEpuKlAyAT3WNn0JSjTvE=
X-Gm-Gg: AYBFou1+tYvihs15rAlisGe9/8/wd6ZhnXpzS9SozIqksfhc8PW09lALk9hm0OkqiDR
	3R4z2asOBOqFSPY3EAKCdxdCW7QRMNzXeLncCsmbKJjTlOIMmcM7tyUHlqAdsabUcrPdcf++z0k
	nj8fuiFxFGuQwCfwm6QwiEiPv2PAkSe6kglcgmQkVZEAbQ3P5SnTs6VYV8peukIkyRCDTtmU0LN
	qXqVKUH+JNiLtbK5S4W2CrVy4cvJTaxZScB6mPAYd4/cX0WW6o2AcTNmMwfKL1cYhsJulMbUE7P
	zqupz+vreuxpS8OpCCrlvpKQEjumiDa6+lLfc/cXPIHFivvLbQQbsovrR8Kb7Vc5cESxh2sdsoH
	O4llfdg==
X-Received: by 2002:a05:6808:1a1b:b0:4c3:ef94:830e with SMTP id
 5614622812f47-4d5b9f9412bmr3726243b6e.3.1790178016141; Wed, 23 Sep 2026
 08:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-netcons_ratelimit-v3-0-8e81b789ab37@debian.org> <20260914-netcons_ratelimit-v3-5-8e81b789ab37@debian.org>
In-Reply-To: <20260914-netcons_ratelimit-v3-5-8e81b789ab37@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 23 Sep 2026 16:40:02 +0100
X-Gm-Features: AclHuK-eiR2fNKubYazj5gcFmudoFI1w_j91DvZRl7oxVpCmicGBPNhjY_7h0xQ
Message-ID: <CAGSyskW+HsE6Bp=95EMF5rWqKtoUAFp6CjH8sAFs0gYywuALvA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] docs: netconsole: document rate limit feature
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, paulmck@kernel.org, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:11=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Describe the per-target token bucket and the two configfs files that
> drive it: ratelimit_interval_ms and ratelimit_burst.
>
> Spell out the two properties that are not obvious from the file names.
> The limit is accounted per message rather than per packet, so a message
> split into several ncfrag packets is never truncated by the bucket
> running dry halfway through.
>
> List both files in the target parameter table too, and qualify the rule
> underneath it. Only a disabled target can have its parameters updated,
> these two aside.
>
> Note in the message ID section that a message the bucket discards never
> reaches the counter, so those drops leave no gap in the IDs.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
