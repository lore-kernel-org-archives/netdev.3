Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EE370AD5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422928; cv=none; b=VhJ/+34XBPhtCEk0CxoXwhRkBuxi/MbVCpn+cWJzWz5h4neMuHx/y8AXOMUOlTb0pWLNCDnTOqHOi9tJihxpAv1PExTT6J3MmZg2TMavg3k3dGn0ll4l6jp6Cq9L0mHcdEoo6VYiNE0Yn5CI4LM0HoK0r+XAU5BA3HLb2UQo/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422928; c=relaxed/simple;
	bh=YwGBiuEcm3sjogZOLti1YAejry6Zqo6w1QEnPrFrIIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsybiGpyeBTO5hAlDsIkoGUH642uBdXIqIAwg6AYeWEj2iq62ytLm5rQud74nvuH1MiF2W9CAfVMHqCGGIKgh6c2JXlyG6wJRIrH4g8IO387fAZGB9C0sYwUt2E6xcfNth7D5xlP/53+wk4lHruE9NnUHjENo27eLam7ymnefVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1/shINN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiQ+EQYz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1/shINN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiQ+EQYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788422926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxj+lVXL/zpSaRcXZGTkqNDz4XPtDz61G0ycxj2h4L0=;
	b=T1/shINNPV3NKnKJqZUqYdrogFjTvZ0xHO4mcQkKnl+M9TEhT6P5r9RE+wfQED2RUSiT1l
	Pxzg+nfmWgbwayl5nSlch0NamQl3X+xfANFpFJTUjtQBafGQ9CSbt6rvYMXgGhHadjOSjQ
	90FfPEFUw95eJ5s3y14wKJk7pShXpzY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Y4ghsBItMtGubH7GTZjcAA-1; Thu, 03 Sep 2026 04:08:45 -0400
X-MC-Unique: Y4ghsBItMtGubH7GTZjcAA-1
X-Mimecast-MFC-AGG-ID: Y4ghsBItMtGubH7GTZjcAA_1788422924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f4bff865cso1196551f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788422924; x=1789027724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pxj+lVXL/zpSaRcXZGTkqNDz4XPtDz61G0ycxj2h4L0=;
        b=WiQ+EQYzky0mST7KMIdPaCabJczqxRoZ3qHRXcwrijyP9Zs1HIWhC8f+Z6SRlTaViH
         9qsw8Avk8m6c81Rrmo5NhSWHAj2fM9CoftoZuIzS83G0dMBabccqsr6sFoXfbIw/WdcX
         ToyrFxrthzkBHSbOo4VVwkkp2i1mnUAJgWUwkSndX6Z/bZ6EBczCQGvA9OwhPa12oVlV
         9pWWYM0yGdZKHIKUNWN+u2WxJSFGVRHMIIk97INg/wdbE9x9I6ZCeU/ija5KFY0sFv/P
         g433zhZOyyl0Gu3iAtG719zarTgiQCuxBN38nbUhG0xwgG28FGxdHu2XreWvhfZoihdq
         5jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422924; x=1789027724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pxj+lVXL/zpSaRcXZGTkqNDz4XPtDz61G0ycxj2h4L0=;
        b=Sit6QEfnjFJgqMT2nb7WKu3SZNsHqF2hCp4IsGk1JkWhdcFaMNtx51V9er/7MKD9rL
         Anwko6/Dyk4jYaahQLhm4GM1M4dnVB+MSM3tLMz8Y3tue6PJQf5gYmIWR/MBsu7dymd4
         j5IyUBzTQsUP4zJGtJ4bjnNsXDsnpYQh/OInSQs/kCe3tYOiM2Idt7jmtqejJz1Htl+n
         F84WHxR4FyRFXs9JKzA+pFHlWJTm+3Gqy5u+FYg/xw4M9Sj5wsTBz5TILWkb2oFxNS46
         S8N4AKum9IHSx97ucjgjQnZRCU0DLI7CIm4KcoVZAVwpi+eiNDeqYyNH0LQBCsYVwhYg
         scvw==
X-Forwarded-Encrypted: i=1; AKwUvBzucwJ/7ad1s2E87AWoUDlbPNOQB6X+uoSTaupRDpVQ80AHxlCveu9bykvoBg/yagVQZtyzZdc=@vger.kernel.org
X-Gm-Message-State: AFuF++lZt2ul/fvoLSTkdOp95oqFMAuyXfni8cTB5EK/6aIp9fBGb08S
	ecdKWbUJamffD54SX1Nhh7j8L++g+eGewIKFnxQP3fTl50gtig0UDHOIcZTF/q/dk2bOOaM0KxG
	JoEBiIN7p35iEYEa875Psi0lCnBKo+lrMSFtnBt27OhoxdLOtcf/Hd8prWg==
X-Gm-Gg: AYBFou0vA40diWBcZ/pXl5ecGiHsH0HcPRoDFH99/r2nKvP4JLpv0WlL9Cc7Caon/da
	Yt9f56nW4w4HZ7s8WX2FkM4VLik4JkU7A7KjObbYiY7d9ap8VRvWwcKIA8w0efD3mj5nTY0tPNG
	OHm6VSjhgYsvpew4aNCWJX4ZqxGD0OaMOz9LGR9PoWYgMoJPHrxgwLTC7WcefSxnEUeJTq+ny9C
	hpQJ3YlCSWhKpKJb7jV9PMTxflUOglI4XKopG0uaC90yWnj0aYvIrOxbWoIbaeYQEmiSGLZ0Vex
	MI/Mi6boV94Vr3XdbQrACa+1nouE/JLD0vHadLBpf68BF7lPtxC9KchbfhI5Xvncxy58dG82IIi
	RR52eD9nYvwAMGMOQzvqrwD3Ob3P7Phh9K/zVLK1Z6eHqdJmbF1l1pp72u98+7IyUvp4vOl8kEw
	==
X-Received: by 2002:a5d:588f:0:b0:482:fbb5:8a74 with SMTP id ffacd0b85a97d-48488f032b6mr17086055f8f.11.1788422898326;
        Thu, 03 Sep 2026 01:08:18 -0700 (PDT)
X-Received: by 2002:a5d:588f:0:b0:482:fbb5:8a74 with SMTP id ffacd0b85a97d-48488f032b6mr17081105f8f.11.1788422866905;
        Thu, 03 Sep 2026 01:07:46 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm13498841f8f.14.2026.09.03.01.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:07:46 -0700 (PDT)
Message-ID: <da990dc8-a7c5-4870-89f0-ad8e7dad0e0a@redhat.com>
Date: Thu, 3 Sep 2026 10:07:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
To: Ziran Zhang <zhangcoder@yeah.net>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260901023539.6986-1-zhangcoder@yeah.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260901023539.6986-1-zhangcoder@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 4:35 AM, Ziran Zhang wrote:
> The old comment "mdev = 3/4 mdev + 1/4 new" only describes the
> common case. However, when RTT drops sharply, the code applies
> a finer gain of 1/32 instead of 1/4, resulting in:
> mdev = 31/32 mdev + 1/32 * new.
> 
> Express both cases with a unified formula using variable
> gain g.
> 
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
> ---
>  net/ipv4/tcp_input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf..2c9feb181 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1108,7 +1108,10 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
>  		} else {
>  			m -= (tp->mdev_us >> 2);   /* similar update on mdev */
>  		}
> -		tp->mdev_us += m;		/* mdev = 3/4 mdev + 1/4 new */
> +		tp->mdev_us += m;		/*
> +						 * mdev = (1-g)*mdev + g*new, g=1/4 normally,
> +						 * g=1/32 on sharp RTT drop
> +						 */

I'm sorry, I have the feeling the above does not clarify much. Also
AFAICS it's not a 'sharp' drop but any negative delta.

/P

