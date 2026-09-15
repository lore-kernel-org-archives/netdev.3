Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D2472F9B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467948; cv=none; b=u1MBCn8ZptXSCgG2MlKB9UNsR5mQS60wlWU2W03yfJokOtTS6qoeGbRFArIvKcV+HxpHkUnVd5q901we8Gl6ClhF+z0ucW8dob9CGZGYJf8M/4UCNVf5ZvS/lHMXiBI83gIzT0IvpfyQQJGDKPBGbyw1flWkc4D9Sh5TqSJmjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467948; c=relaxed/simple;
	bh=iULOzttYr2n0EJHmyLMcC6+ASJIWMJB4gX7gYBPR1Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OywAPQkbJDwfdAJAt2RB4qcyCuU8sUm8W/8vbxiCzPL6xcA4yeVZL6g2hCsW1Fj/uJq5WtbbiI4PfecaPKyTwJi2o/nLh1m2ZQ45pAqrJNL2kqLUzJ2Qxaa2Lx4SY3myi4AQKFP3IbIqVPU5ooQ1V6nHJ0UZt3AvW+0vsjReRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nTBi2z/X; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nTBi2z/X"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so1710495f8f.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789467944; x=1790072744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wbiTQv/9uPbaqQlAXhrI//2y+UzzYyIuwCVG2sZ1MZg=;
        b=nTBi2z/XNHCVn7WCnaf73X84kAQ+VXAp/b1dnjIxCJdi5sL+t/ErULkAIr0L7FRTHs
         0utx/Q/Bg/yEo9Ztk9K8JO7RCociq+TCB9ISjboQFWUjUa0LW15NRA8K3XJCDqUo+T1K
         IntyA5rXyFU1nnTYtfKKNmUxo7AHTe/nRMiTjqd8XUvIWMUfs+Uu8L0dvIsEN/NgUaVx
         EaVS3yoOXool9WLNlweTsnaOO1Z0tvWwkhRcVyDeuatjwP03b1pNixAUiaMbML4CoBec
         Tb/EjiNQpbnEeqgIbQNqhj9VMSh1vfeNd+N3yWq8PvzewLVndjnPtyhGABqKV0iwG7P3
         /EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467944; x=1790072744;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbiTQv/9uPbaqQlAXhrI//2y+UzzYyIuwCVG2sZ1MZg=;
        b=SlZPBhlpfx3aP6zovw4wBUryBqBqnlA9JMnFVU8ziyYN1Mf8ED5XWPyXyrXzbEcFcA
         O9ZEX4ixOuJY2dMXy+MPTeCgpS1n83lsEdM/I1qkwTJ/PCeH8ixSgGtZMSWsT5Ex1/e2
         a584/H3+kJXJSMh2wFl6gDqY5tDHvTV8FU6Q3PiVTOTaUhB4tAyulY+6ApyOnQbEKN95
         eoqnmcbwjlz0XkvXePMzVVT9B6lBzdKyZjJqItTt7Zgxb1AogvLddOeV7K3p6JDZYitA
         5fjp67OasDfknuVh3LOPZZSTZCu8Gv8xqKCkrJMId8OzHN1i7RUx2JlTIc0N9XLfcu8L
         DgmA==
X-Forwarded-Encrypted: i=1; AKwUvBzLwjLkC1UCJwi1gtmTHby90WdZMWHGLhg0/BcJrOdpLzaFXYP1kVIR0b71fiZbZQhFlpJvJq4=@vger.kernel.org
X-Gm-Message-State: AFuF++lf5TmY+z7Ib04AY9j/Gjo2ZhUIHr7kL11JekX5IzsFVZYAeC0Z
	AePeERM2EPUcQVxWojv4I3zeL5oH++3WrsO7cQji87m2QinTV8g2c14DM+6Vbnmj4BslaVqQboQ
	hGIaGMWc=
X-Gm-Gg: AYBFou1NbCy9t5aIdFHHwtJzdo/Slb2fz8FQ/5mAgSgsJZ6duKgYCAgfsJdd6UbteeF
	ksCAJ8plVtnEtczwqAO3/U9eOia9+onPdGzh1TVEHUew3bHcWuJrxbCfPNLimql63+oiO1il435
	wwXQPQcuKbIfBh1hP3k/rHe+yAp3kueC+SRufCbo4JpZLRrgLGvNwe16XO4arX9qw9vSyPkJlFI
	pJDjH3FaqP/Nfqz0zfwA5xzZh7x9UWWb7f0lBzfGNdggcEp78VAYDtnNNJ8eZHo4P8hcxYLuLRC
	xGmLYhYzk0dNQu6xsisMfGHZcEWhQfusbRjgmB5dtA/JZmSJf+iMObi5+Z2Vs37BDeZOvxIZGKS
	HKhJyhUZ870HMGk3YZzRzVGIm3Oi8Lf6cFXRxNm0aKMyTQfAUO+7jHXZb1b+GoU7q1VuF7exjcD
	rZi3NYUwGKUTCRT3vmrLYovm5Wgqi98oCqkptvNDACfdApTswmiCia/hIOKo7bXE+CkQzxk3500
	+sbuOEL5A6qdzCFpkvzxEtLcR3Thw==
X-Received: by 2002:a05:600c:358a:b0:49d:2607:4ada with SMTP id 5b1f17b1804b1-49e7a6870f4mr176898075e9.14.1789467944007;
        Tue, 15 Sep 2026 03:25:44 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef2e117sm54564695e9.1.2026.09.15.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:25:43 -0700 (PDT)
Message-ID: <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
Date: Tue, 15 Sep 2026 13:25:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
 <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 13:23, Paolo Abeni wrote:
> On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
>> This is a follow-up of one of sashiko's pre-existing bug reports.
>> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
>> while holding rcu_read_lock() which invokes the blocking switchdev
>> notifier chain and may sleep. Nonzero MSTI changes come from netlink
>> with rtnl held. Move the switchdev call before entering the rcu section and
>> assert that rtnl is held.
>>
>> The call cannot be deferred because netlink needs its error and extack.
>> Also DSA reads the old bridge MST state during the callback and checks it.
>> A deferred callback will be late and will see the updated state.
>>
>> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Clashiko noted that the fixes tag looks inaccurate, should be:
> 
> Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")
> 
> do you agree? I can fix the tag while applying the patch no need to repost.
> 
> /P
> 

Yeah, I agree. As Ido also noted, that is the correct commit id but it is
from the same set. :)
Thank you for taking care of this.
