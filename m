Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298C3F8ECD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103707; cv=none; b=Dm6YW8BfNCE9W/Eip8AMa+eO8++NagglU8lczl9XxcGvwJL9vh5VZIPdS6gXFB0hR80NyLJJ5rEKIN4JMeizBDWGumpj0v/HvZ7QFvcgwyWD9a2J8fKZbhUmwjkxP7yKfD5Tlf3WxqJ/OTxcFG1NK+nvSDGpjulXLfUJQYkNEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103707; c=relaxed/simple;
	bh=W3KhDTimuwgisUptLxdE3P0lFgT70NS8NtJzHMxIpog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzOj/H1XQGZ/rANSWxGzdkDdkpxxco7RtzpZnvojuPVLPTq61AXG4a6hMiUUhOe4fmp+/n/aPJmInwoBFwsl4TTnamxlGJoHtM+fFaA0yvm4dCZPJy8YLmLZEoGcFIP2opYO3/kkclvoHc/yK41C3Llr67NNCzPIPN1A3Ju6YFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4veIr6R; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4veIr6R"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so4776440a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786103695; x=1786708495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjCLnnMYnIXAKd2QojkF632kR9nXx4FuPCfAi4Zg5FI=;
        b=r4veIr6R/4v+8PsLkesemVV6U7bRiaKr5WmvAYOC79xKQ61iNfua24pbDf0KfM98In
         +Q4fuFRFfixYeoHPADg5YttcwPlUPnX8UZCKghIKqP+u97xpOqYuqaRDcYT0iTVuuEft
         XGw/iH7e12Z9XVef1fyt8eJjjWwSgtDWhRlcBN73WfFN6Fmpn5nXMec0ntjAtaloucLi
         BXCWCd3o+Vdca3m1GmqRgazgVUu46rtRhXYJSui7BTSQ0BhTEZISJhn2H9yJU/maqCRH
         /LsG+VOm+xNF2HfNtopuVT14YaZOWK/o6Pd4fuWI3gfh/x6e9dJb+H2ZfZEnNRd+9bE/
         6Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103695; x=1786708495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjCLnnMYnIXAKd2QojkF632kR9nXx4FuPCfAi4Zg5FI=;
        b=SrtoofdL9j4+gxb34KnU1nwFeutBLkyP0epsx+4ENMio2o18WG9RR1XHT9XyE9wWbQ
         AYQ+aCDnldMi5PkLF8CCwC4sUKLAKh9In47NJxezwhzw3y3Rxd249qUo5wp/vruu/JsO
         st/9EWn0GCbYh6c0vc7RVtq80gwrM/2xbITzACiGaJXC8XKe+BjOZjbkQOiMQCjhcm2Y
         n0PRDNkijQAFn908zQZEU/F2jHSIq6gZLUNIGhYop4D6VFb0iPOKBNyiVh3DPTcomeEW
         1gHqFdYMKZyCwIJZcYbK9S3/sRObre5qtoE1ZifSQDFUim31ipgykdMV0LtzzdJjseuC
         FrqA==
X-Gm-Message-State: AOJu0Yx7GBLflfBdQ/BVqrj6+zkdf8H0BuyRxjxrAlhq6yyCMeIKg19w
	+K6gn+OAzDqnvVORl5rdqu9o5MPX7JSDyPCUyrnpEvvIrsilwG2zKhHN
X-Gm-Gg: AR+sD132Z4bOLkGm1EtIXSZR9LybAIkLUUwnARN3Zsfi+S05fQc8FIEHNlciZODuyy9
	5Bvq6nJ633xmYgXCsQ3MZW0+hf5YoGb+6/eHXLF/bJ8BO3jH66TRJtdtgIykGFwssLk1XjLIfAG
	MGT41vbc575PT5j+e96FNNNuWsLEsBA5jpxfMmVB0vmRYT8LKnj+x7m0XCUKjcrMIVIOsdaPujO
	4/LkxzwxfR6VOK4yg0RLbN/0+9k1eAe3UwFfGGxfEchjE+5/wm7j/5qL4iDzthikFhOJhdImO52
	1cLrNsNwnxMrj1FRPO44/4Fu7YkEEVHj2vuGVCP5tMvAl/NFknK2AE0TNSfK/wAqCMH6RBLN6c9
	xlz6uRX1HHtfgNsXZJkeSMBsjtzqIGp/jbbnH6inDKdJsOz5T9YjnWMUWTfTsLzhJGYbf3lyd4k
	8adYipoZGJKGjlfwLLnE45P7y1BEUN7rROdhiJ3GrQ55eF8J7s4ofj78ZHGPYl+Rvbvg9t/7Deq
	Jajai3KZKgTcxPCZzuw0nI8NzhSVQmk6fjJsNGYq9rkhRWtFD4CMLg7mhAMP7kfsbmt3XYipoSy
	P/fVsgdSE0g8z7o/ooAxoXLbxfIT4aMQy3g6DeYZOEayaZGqLg3eZgk=
X-Received: by 2002:a05:6402:e93:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a14f09ff2cmr11039309a12.1.1786103695297;
        Fri, 07 Aug 2026 04:54:55 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7cbaf69sm471408a12.13.2026.08.07.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 04:54:54 -0700 (PDT)
Message-ID: <8df5c003-f28f-4fce-ad4d-9c6247d06892@gmail.com>
Date: Fri, 7 Aug 2026 13:54:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipvlan: keep lower device alive until private
 destruction
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, syzkaller-bugs@googlegroups.com,
 dskr99@gmail.com, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 syzbot@lists.linux.dev, syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20260803121140.261329-1-krystianmkaniewski@gmail.com>
 <20260806083834.28db4cde@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20260806083834.28db4cde@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You're right. I treated the netdev reference as a guarantee that the
device was still usable, while it only keeps struct net_device
allocated. It does not guarantee that the device is still operational
after unregister has started.

Keeping the lower device referenced for longer in ipvlan is therefore
not the right solution. The caller that wants to operate on the device
needs to verify that it is still alive.

Thank you for the review and for clarifying this. I will prepare a v3
later with the fix on the caller side.

On 8/6/2026 5:38 PM, Jakub Kicinski wrote:
> On Mon,  3 Aug 2026 14:11:39 +0200 Krystian Kaniewski wrote:
>> Specifically, RXE acts as an asynchronous owner in this scenario. RXE
>> queues RDMA device removal on NETDEV_UNREGISTER, meaning it can retain a
>> reference to the ipvlan netdev after ndo_uninit has completed.
> The netdev reference only guarantees that struct net_device does not
> go away. Caller must check that the device is still alive if it is
> trying to operate on it without a guarantee that it's still live.
