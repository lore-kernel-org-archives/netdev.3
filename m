Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DA3264D9
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219275; cv=none; b=bI0GxFVQIZ7YcX13jKG2a0aM4lDqK/OyXLIwPldf49O6uULU0LUCAjoVICFCPara3Lsjk3sZfP0PQvL1xOUGzggwbGzG1fP/kBZesr1VeZz2L5dEYMrGxMKp6bGGFN+oGiieK9/OEcIs9bVx3JWBFhcLkupKKSfDvYVoBQx/tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219275; c=relaxed/simple;
	bh=pEvCIlsOhRAj70ZxrQ2cUTuuvafqO6SisdQCnGXdrd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYBXx3ioW+YAcrfIl4FdAy5f2nfFbaMYMZFqmv/Q53bkEIp/MeI6iZX93jG2OzjvPzh4P1/chlmzYBZQFVRAa7OQyQePvdPDatJ8jwwE+xgbbo9DyXAwJ4x/rYnqeHvjHWzrnE6bhiwC1xZvikgNG6OthUgO/BvAClvCUfL5miY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVXpth6j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPZJjPcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVXpth6j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPZJjPcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787219266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCMN5RrsJ9r82XL7HwcDHi2CWLePB9JmH7djzHyIvLw=;
	b=KVXpth6jsJXb0kebXrVEj5rl7HgQ8qizEn5fNwvHTzfaDb9mFQxWOecHyXAkVRbUUqVH/P
	dKktx+xkjBHAC7vk+AjMA0u68DqEtie/AGewlhe4+pxD20tb6Vh3HlB7nAv3SHq5/LLXAn
	j5wtu8z66u/Qm7VKbXsXrzbNT3xc+gM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-yJdOFy-gPTmqZ8kc8lTz9Q-1; Thu, 20 Aug 2026 05:47:34 -0400
X-MC-Unique: yJdOFy-gPTmqZ8kc8lTz9Q-1
X-Mimecast-MFC-AGG-ID: yJdOFy-gPTmqZ8kc8lTz9Q_1787219254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so13983015e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787219253; x=1787824053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCMN5RrsJ9r82XL7HwcDHi2CWLePB9JmH7djzHyIvLw=;
        b=CPZJjPcj6iAh45HCZ1SK+nsP4h2HsbP6Q2wErDEtHqcnyup7uFfICgdv/CICptEtZ0
         CXoT96TXa8t3M0NSK9d3Bs7njkOb7jrLuGINrtHUXPORa5G6GNkFpqMszVKtw6ZoVjLZ
         clMYLdQ2I9vDEWwGPLOZSuDJ3vvq8wxSnAihW7TkDSKvypoqWjBFJxrmD30236oU6a0J
         ns1uw9utwOlpXbf0emDqPgXzKswd48+rydIR4nhPDWlP94NVboXklOBQNnd6KzwGm2a5
         GbAloOYloVZ5FHCub0h6G91ZcL409AQSsgAT8bWZHZQ5p///9SNzIwgrVCBTpvL+Xjv9
         noJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219253; x=1787824053;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCMN5RrsJ9r82XL7HwcDHi2CWLePB9JmH7djzHyIvLw=;
        b=iBEmI+zIwmbScmjdwLoiacBpesekbyX/gii9E0yRsRG1a1YaBrSaUOLfsIILzcdlkq
         0QQKty5ZV+3yv85i3uQWqPq/2/D019CcXKqSQzbLNVRRQhwiJMF763bcnUcXwNcC+k7d
         FCZriEGTBSGwsW+25+BnESBsMyw5q3IvEYsJAEqU4D4wAU4l9ZJsPHDDckdFgz/uR2TR
         +eo/dqYCwmCqsVt+Y5sk5+VmBRyUpkLvlhNOKCyJhj5iaeaSCj5qC4pOyoI/yci7OtJT
         iWzusGFxZKwSLbMupk5yPM4UE46KaVcZVCTbIf+5BcrNjwWMAc2guKzeSbjhjLzdTCmz
         GYXw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8VYS6ZUAJRBmpxj/5HoGwKiDuXb8hfvclMvNnAwTvbKv4eW+oIUAdfupZ6V+ebz2hr282csw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQYs3VG9307Hgh/+MIyKvRSxhVy8FJO7u8jyfMDXl33O6z1jZ
	hIdFsxJgQjfTsTIDlMpG7MMfzr9GItV3GilpZTUZM3QHl6t9GWqCKsC/rNh9XXqHQur6ZDNVHnm
	0tkBVu+4RgL9rplqKo9vhDfdEoOoZ23+is7T227zTsrJdj5cMkvRFRFTLMg==
X-Gm-Gg: AR+sD123mosg0h126QQ1F0qrKIYf75WQf2etda0bmjlXCqrBkgYLAAyYraFCjcW9hzw
	zrpv+11TU2ndn13DXY3WfriYMkfY16nziYZq+8l1ZaQOtwK0i/ak7+35BarGcl7mMCnumdnsIru
	/pT9o3o8AlL1G9qdarCnqfP0FISQSSnLZnMUyzYCa6qGyEgG4V7Pxcx3dYiMmgoO06g8rzQGZX+
	wbA6eaCCaFDRlnQSpINhTMO2Xh2pEX7YDFLhNPZg0Bb7Dl4cKMKJnzfzWxufEMJb+AQa7CrgO/X
	V+Rp3oiqhujo6cWvOGPAagSCZb6aC+C5/PCEXjewigXfrcykNUXDtf5BsZO6gI8nt5pCxAw1tzA
	aNLP5eRIxKEJ5ZbzeuwVkejb3DB6CqBpNYhFQFCn81U/J/3btaH+5vvdaNECgrAy1RPjIbvzsM1
	Q=
X-Received: by 2002:a05:600d:19:b0:499:b4aa:3d70 with SMTP id 5b1f17b1804b1-499b4aa3dd7mr11811295e9.14.1787219253562;
        Thu, 20 Aug 2026 02:47:33 -0700 (PDT)
X-Received: by 2002:a05:600d:19:b0:499:b4aa:3d70 with SMTP id 5b1f17b1804b1-499b4aa3dd7mr11810685e9.14.1787219253109;
        Thu, 20 Aug 2026 02:47:33 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e805a4sm146422415e9.4.2026.08.20.02.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:47:32 -0700 (PDT)
Message-ID: <ce75808e-6bc6-41ee-867e-f2d9cf8de0f3@redhat.com>
Date: Thu, 20 Aug 2026 11:47:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260814211603.53670-1-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260814211603.53670-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 11:16 PM, Rosen Penev wrote:
> Convert b53_srab_prepare_irq() and b53_srab_mux_init() from void to
> int-returning functions so probe failures are properly propagated.
> 
> b53_srab_prepare_irq() now returns -ENOMEM on allocation failure and
> -EPROBE_DEFER if any port IRQ is not yet available.
> 
> b53_srab_mux_init() now returns PTR_ERR on ioremap failure instead of
> silently ignoring it. To keep the same behavior, warn on failure and
> continue. Return on -EPROBE_DEFER.
> 
> Check and propagate both return values in b53_srab_probe() so the
> driver core sees the real error instead of always reaching
> b53_switch_register().
> 
> Add error handling in probe as a result of b53_srab_prepare_irq().
> 
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

