Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CE4AF688
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441795; cv=none; b=oR68ImE79gjTVbKWTkQk1WltGp1vCN3hPxsh96PZlm8aihEDFm5Vfs6xafJPJhD0K59ThajKRcUyVIzzAhO8W3ECZWbAN/aRAe4/2azjW7Rbdrur5mY8bgVjZcKhHs8gs1cA8uX5NE9q8bOVEz/RWRUCWyzk3une4+0LwUey1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441795; c=relaxed/simple;
	bh=EDFARvlMcOirKUGwE9AZ0iZlv5bOg6YoUmnxawq5gxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4e09A+F61f+NZv9IrYzH2khLuKSSecY2CZf2LGle7B6F5MrZWlkKgGDgkJbBMaBDCEqK+MpYPWYJsc5+6F+VbBx3uZce0olBTw77S4vxU4YwWL5IStU9phbxiRA3xE9xRoLHZx0OmtY0/pi8HAYCYaKiIooe0eAWlMSdjtEhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkFkfr4u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gsqab8UP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkFkfr4u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsqab8UP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788441782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lljH/FqiYJ4HVD9LG6mSefJkZCWX5aKHWi6CMB6vKwM=;
	b=gkFkfr4uoSAx8TLjRFhz383ZtKcXO16FZ8RK6vha1sd6ggYXZUoB78odlQzwjNrOqGgX5A
	Z0cHjDBWXdRKsyVxldwDyBiey0ol/7cHP9sC4xuKwHK1K8QwBx3Ep+NqKKeDJaG+889eDR
	f0KqUNkjVhFbfj3I/lLmaBR0MYoLpyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-LeGS9-nJOumApFndna2ykg-1; Thu, 03 Sep 2026 09:23:00 -0400
X-MC-Unique: LeGS9-nJOumApFndna2ykg-1
X-Mimecast-MFC-AGG-ID: LeGS9-nJOumApFndna2ykg_1788441779
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49991beee7aso21862835e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788441779; x=1789046579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lljH/FqiYJ4HVD9LG6mSefJkZCWX5aKHWi6CMB6vKwM=;
        b=Gsqab8UPA09Sje4VKotnyjahqJl7BHCCqd0cUvV88oX0ECHJDy/tIEKEqxZ30rnx4r
         LiZNgts70ySTsdrSzCweAHHZ6yfozHQ6+oDR59y34j8tF5rnte0oq2bw3Hf5jNsEMy8l
         KhtyNJ8KFiONYqezHLCsJm9mb95ToVs+ZJKj0rYsfN20wqZVyHxKcUcf1jXKCBNgcuZT
         HblPRJ3vTtCe83WocTDomDa8RsuF4ILK+H9YNo/lZnMv2asU2oOa3cHit46WOwCLNk0M
         BAhNwD11UiJdhisNSg5prbUynZESVU2mm90RLd8W0OQoOE0IKkxVOt3xRfG0WcOpA/pd
         G/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441779; x=1789046579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lljH/FqiYJ4HVD9LG6mSefJkZCWX5aKHWi6CMB6vKwM=;
        b=tKbXVIC9X81Iz9vXqXVClU+7lrRocHJw/RUJcnQwT0kMYD4zAIpZ8uWi9rkt9Z72al
         0waFZspxErb6H8kyaSpVcVTvIdcqVNr1WOw9oLLbeE4Ybx3SZOvzJCAwInXtZ/vZztfh
         j1l4O5/bGbod3umwYA/umnKFSo2IFHWhnQLON6fbp/jL66YM28hh93w9LjO+ZGbCMD7/
         PmOEiuC7FMtNZNKQThfkesSvS80fHi7IJ1a0tIRJT4GgWj/IfodtmpsVE1hccoJcw4GZ
         ebg3HiRE/Xi5+zFINoux6VS1AmscKqITjkE2lv2IFQh3dpxqW4akm883b+lBckgROHov
         Bb1w==
X-Gm-Message-State: AFuF++liTu2H08jbw3bZsOVLPUIvD62jFyMQDzenFyVjCv4b6u3ZC6Vn
	G2i2NLJ5EfxlFSdzSN1MXN92ZrXPAGn9uncvjy0CxRWnfUpESU4+z6PUPGRC4oG4PE2czZXXa2w
	IeOG8Jwwfi3ZwwZolWe9PApt7OXAn+yzewsavnDNRbgqbQxYQc6JxPR8RyA==
X-Gm-Gg: AYBFou2vh7N+jlF7FqqrbXsXDQllUtmMymrqWlbSNHRQe4ig3LQ4ZWfRZtsMk/hl1Qx
	VSJovUTeIPTWxSXI8cCPQuBnM1MePOiBmBboB0pUtKps0XNMf+c+ZJMOlPOF3gFu5SDs3XCc2I/
	F/Uhd1HmOSQXyZu58cOdwN4xU5bQmNy/GKbdCUK0MsCCjVKMKyGDJaqeNCtome9gAhCBGHVjnGJ
	1b2mc8Vq7EnWHZak+qG3sBtSzpWlJJlncWsJYS5Hu9qYQnIhDapDYe6aOrF22PYkfJDq3dp57wP
	iXZn1yV2n1NFkM5RvmwwmOrzkx1qB7BA8tx9i20N2bRy2AWf5MmY2lKkKXOz0B1mPftmQsbqlSd
	qGpgDZ3aSEiySjrvtsLc3DNcUriV3xnceFIFOJkyWYBmy5sqO0NI07xQH2aziPxMDv1OdjbhZKA
	==
X-Received: by 2002:a05:600d:a:b0:49c:e88b:b7ce with SMTP id 5b1f17b1804b1-49ce88bb80emr188830455e9.11.1788441779283;
        Thu, 03 Sep 2026 06:22:59 -0700 (PDT)
X-Received: by 2002:a05:600d:a:b0:49c:e88b:b7ce with SMTP id 5b1f17b1804b1-49ce88bb80emr188829265e9.11.1788441778811;
        Thu, 03 Sep 2026 06:22:58 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm70872675e9.10.2026.09.03.06.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 06:22:57 -0700 (PDT)
Message-ID: <5832ba17-c096-4f07-aa73-2e2bb6f79856@redhat.com>
Date: Thu, 3 Sep 2026 15:22:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v3] udp: revalidate socket family before publishing an IPv6
 cork
To: 4ncienth@gmail.com, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 vyasevic@redhat.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
References: <20260902010408.1057857-1-4ncienth@gmail.com>
 <178844070069.3394541.5419916956797677793@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178844070069.3394541.5419916956797677793@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/26 3:05 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 · Medium: 0 · Low: 0
> 
> - [High] Incomplete fix: the sibling IPv6 socket-dst publisher in the
>   connect() path is not covered, so an IPv6 dst can still be installed…
> - [High] The fix is writer-side and after-the-fact, so the mixed-family
>   socket dst it claims to eliminate remains observable by the unguarded…

It looks like fixing this kind of issues, if possible at all, would
require adding a significant complexity to the data-path.

I'm wondering if we could just remove setsockopt(IPV6_ADDRFORM) support?

/P

