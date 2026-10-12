Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C134F24E
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812944; cv=none; b=rkmm+QOBwqp5bN/v/mssfl1pTl3Ozwa6bNr98h2RuUcx3CVOrLwV1YJMcfcMRDYbDzs98qWhzXwxnCKorpqZAps/GqQCPLzYyd3QNmitowkWUiMCP85caY2hF87nFEY28r0lQV41HwC2ztwoBN9qFN7FWM4SzcyYkDrZgHfx/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812944; c=relaxed/simple;
	bh=rGWBxA5Leg7jRIZfZqhjk4LTRA/0KXbi4AqEB9RQjHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQO+Dtd1HiiZksKIqESp94qhMaf4vHTJe/zLF7NI5bnCHJ3TWr3zPvQsspopcRYM1FgCKSp890QoRxbOEyhNn5j0qFMLtQ4ctAh220kJBYcXOfQd/JM87Y6OM9GrpZM/9ODAZsFzqMncSFXZ/01QJIDODfTLwLcaXEEyhL/M3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU9eFgS+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fY1z1iBQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU9eFgS+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY1z1iBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791812942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsrdtBORkwTwhqxArtXou9zZU6guyDnY+FE3EhTpPw8=;
	b=LU9eFgS+xPI+bPpKVvmQlyBb+Hs9h8qO7lPNNRsoxpmRgC6XCM6w87De1YNHbgYEUpLlHM
	u/86/5LlbcM13qJvnrFpVqzT1Q20XkvSQmpbLsW1W8v+X6vBvTs1uJGN2moTwPx+T7VnGQ
	cONzkvKX18DM5f6n9u5WiDUFtzCm+FQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-EDrNInkxNoSqXUQyfPAoTg-1; Mon, 12 Oct 2026 13:49:01 +0000
X-MC-Unique: EDrNInkxNoSqXUQyfPAoTg-1
X-Mimecast-MFC-AGG-ID: EDrNInkxNoSqXUQyfPAoTg_1791812940
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a020cf06c3so10344255e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791812940; x=1792417740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsrdtBORkwTwhqxArtXou9zZU6guyDnY+FE3EhTpPw8=;
        b=fY1z1iBQVyeWuK0tpzTMsipqRnXMoR8HUA/YN5L4I1GuUWrx2ThwCUZdWcN9dgcPeb
         vEU2m8BLoxsFw5omnYtnFqEeSq5KKQIXtPtRDOC1VyGjhAve4dKe7UA7CbOsC1wWRgQ1
         Il0MulZ/oPfK1FP4pqIuc5LKV+UaB7iANk6Of2/Kid7ap/0l9+FIgNp3fhrX3xkArYjY
         doMchNb6HxEsOeEY67XjalRWucSydFksHb14UOHkI06xjfHdCSkuz8HA6/2XqRIDxd5y
         888WQTQcnCOphn8rmu9dyYKP3CEPHvX/OSJWwZsWog61I0Zf748U4Dv/x9tl8wBcDBxj
         z+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812940; x=1792417740;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsrdtBORkwTwhqxArtXou9zZU6guyDnY+FE3EhTpPw8=;
        b=Aw+kik0cNunK3i9o/K/inMYf9iBTkGODNtGqDddxUvHMbZvZDXyWqDb8piz49UxJbp
         TFRHf4qPTHddvdFccSiCQejfjjad/6ntB500vv42yfF8h9oJHezJUwQ1DtgP6YW58zxA
         ebJlJGqFXzOML4RSFOKV7d+Awn733YKCiTuNquxTa6A2NGgmorTW5k8VgAS752WzvFfo
         c04+9tLC18Aks+EJf3JxAf2/K7Ih3kgT2958AYUsvC73j0eggQc9cjBzehV6J3lRBu+L
         5qDOQXnf6StbmQMKu6bM518H6bKgpclDlBR7KqDe0QG4x7ZzME+qfhqxlymvaEpNr4qX
         s0Ow==
X-Gm-Message-State: AFq9FYIt9VaunVaWncrKZeB+ICgOlRUmCHoM+A2z3ua7W+fJZiuCjQgu
	InDklnRJknCx6PZg9GX9alGk0GEUsUEUYYwTpiz1p8+ZEspXFro9ryk/jM+MFXcPifsCQZ2rahW
	6klJkA+E8wfShoOECCWpJOFYMI4COeu5m/kAgS7JOadzarJEeDA94I5nobrWllDO83A==
X-Gm-Gg: AYBFou3aqINHhlO3gpUGwTyUinZB6oA1Qm1qyBrCw9pf/0hLjALBEmnFAUNELvLqy96
	K9SbehVEafGCM4WHYk8bI2H8Wo5tgz0NVlTMpp2gS4tSYGwFM/EDhZcz2U4EtFL1nPsCrTKOWIw
	cAG5NTC9KFACjJUwk9OcGteMxe/hfAct1eJ0v8jcf+zyN6Hz0lAQK5MFcjtFU/6XSyxya7sUwnm
	+7l7kOoiMPfoVlNJFsGbvqnx/VsLfEMK3908PoV9mg3dQxseH6Ja6G0cwB66nBCvPYudT7gu8V+
	YF4CrJ3aexEClOJGwpAQz0c9AUs3QC27Yb0yELS36SgS8/ZTk9b7Qt7HgBW2ek3wXDaYAGv083t
	ksDo0OMF8po6uFoujrVULf1L4wfp7ZWus7YK3DV/W0ln6KhdxOSdncoh/QS3wXBCDqOXp1ujm7g
	==
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4a190780997mr116146175e9.31.1791812939702;
        Mon, 12 Oct 2026 06:48:59 -0700 (PDT)
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4a190780997mr116145785e9.31.1791812939169;
        Mon, 12 Oct 2026 06:48:59 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm399106975e9.0.2026.10.12.06.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 06:48:58 -0700 (PDT)
Message-ID: <833b5ef9-eda9-4c15-85cd-29202e0f87ca@redhat.com>
Date: Mon, 12 Oct 2026 15:48:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: devmem: check uid and netns in
 net_devmem_get_binding()
To: Kaifeng Wang <kaifengw@google.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org
References: <20261005210403.3206872-1-kaifengw@google.com>
 <179141784973.434549.3492874220530662715@kernel.org>
 <CAKkY-qOKHkuPfMk+1vhQjRymPKcG5P69CWFLYv46Xp6BiTXO5g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAKkY-qOKHkuPfMk+1vhQjRymPKcG5P69CWFLYv46Xp6BiTXO5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 23:40, Kaifeng Wang wrote:
>> Could this break existing devmem TX users whose TCP socket and netlink
>> socket have different owners?
> 
> This restriction is intentional. NETDEV_CMD_BIND_TX was made
> unprivileged specifically so that an application can bind its own
> dmabuf directly and transmit on its own sockets without needing a
> separate privileged helper process. As noted in the comment above
> netdev_nl_bind_tx_doit(), bind-tx is meant for the caller to transmit
> "on their own sockets". We are not aware of any userspace workloads
> that split bind-tx and TCP socket creation across different UIDs or
> network namespaces.
Still there is slight possibility of breaking some weird setup, so
I'm going to apply this one to net-next.

/P

