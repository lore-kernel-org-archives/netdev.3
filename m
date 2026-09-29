Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1B4F3EDA
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674026; cv=none; b=KGHU6rADuskAmeUTDMTyN/JEVwtnOH7apIDcUgSAEuJky+NweweM+3QX4Yex1Qb86nTo9JhLvBCl8t8TroM1VHXdnI/jhaZZfh2v2ld2xvAWrg0LmAGDyyXJaLLU5P4A5JQx+1X32WyLX5MOPMrbmPgI0QfTTDncXH/a7yjPUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674026; c=relaxed/simple;
	bh=fcXyvBXj7Sy0LffIiP8HJUW08OGSCuJRW/UUi7/DyfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkLDglsNn7hKv5877PUWAnJMyjnkGE2Uz4Q7glcQudvWRQmzHuKbXFlOdQVUHvxQv5Bqlc2+hjepoO2b4BS4bfF9OT+58I6sXefNVtFUL94EX4qFWz4PMhG8ChAgwhVghDdF6FjgvaO2OIBg6l7MvW3GpCMAnWBsmKzm3toRZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGvaV2Zz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPOGSHcb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGvaV2Zz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPOGSHcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790674019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
	b=EGvaV2ZzRI/OndavcLYpDBlajKS8C8K5Wx/1oqj97329cZi0rpb7lKSxnztIZR8NLB6Y7s
	8xWOwP0cMJ8FZP7OyJxqYbRqJDgQghSqWOmLYLsOtrD2brkNB5qsbqDF9aEcxmwp0LMbrG
	AL7OEQJZ4pL2XrnEOsze7S1KN2XgsOA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-t1V-fO_nOBGgNM16z2nOKA-1; Tue, 29 Sep 2026 05:26:58 -0400
X-MC-Unique: t1V-fO_nOBGgNM16z2nOKA-1
X-Mimecast-MFC-AGG-ID: t1V-fO_nOBGgNM16z2nOKA_1790674017
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2dd1f915e2so173346766b.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790674017; x=1791278817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
        b=DPOGSHcb/Cx2xsTfN3rRl/XFXi/pUVEaKMJ0u1vulQRjLMLed5jQ/z7Sy8/QYR7Q9y
         benk0CvkDOJkfxbrd0/PRRPTpOxWh+QqJmmI0k2kXRU7Kh7HGNXntNlM2bUlMfa6FKST
         l5OV14xUFwta0WAFG7jY7GJokTSjPt+k6am30s+fFXLri80Q87GpIZP6/C5J/LEiAIrX
         JBSyMT74RjZOf6vhMVMVzF5GfOHdxsfe1XeKfe7lqy0T97TbvG/kHZ07gaOSOt+8cG7W
         LkZrBXQYIC4X804i8gjE12hKtJ0+Ps5PzKMLzxm8uyrITRKqiw7JyEkJGVYJRJtOJhIQ
         Kj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674017; x=1791278817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
        b=u5ZJmmLpuEYFDWQS2v/vb91sMc40Ej976/K8El5nMepqrH/9cNzjVYKgLLN3bRGh4C
         TxGoKsfU2gz0a7eIaeRB5LxpKs9NomiVRL4MNicnSBjDNHAZw4naXiEX14qoE/Mx6A8T
         2vhllmBJjJzS40XfMMPU5jY1U8MC9GjHZrWZZr/wDnmtDZreWhKozdAQE0VjLPT2T0d+
         wP0nrN3ryS3mQ6wjYIvfyXKi7CX76b3VEx7X/QQrN3aKZO124nM5pLkOXD9Fo4klJxrG
         tWrM1+RE79LUfAuuQ4Mon1gd6YoAKGXdpn/oXONiq42r6vYJwHaVr06cTkvoI8//ccLN
         IRCg==
X-Gm-Message-State: AFq9FYLkifw/Zc5vAKsdh/CWMFWK1jZo/kTnR3YpOSkZTs82hXoeuGgN
	/Jqd39mCLa+W29iVUjVhN9EgMKFPMpssQW3HDVJhTHtVK285iZp7bY33SmwPrF0PIRy9JoEuwJj
	9jyUcz/WfxVgANTDuQ/alsVMiP29SSIQZw4Fc2bzT+I+HKkj9osvrAdz17qGC3hSBuQ==
X-Gm-Gg: AYBFou32DF+lNThPEKNsqrKlIYRfMo8F+Lk4NQ1tdT6mrWRB2UHXgD9YVsx/VB1Rl0X
	2eFFeiFpSk9yYPvaUO8j6x7fFJa6au0pR0WSE3kPoeLckR7Tm06lw1ajD/gqALdRu+d+fn6Nj9b
	vfOkdFwq3kRKluvSWfOUmObnVybya4OpMsFP5CmKY+vSdT7yI07C8zRVSKOlgKwGGGd08MLfTEE
	EeCNxFV8DXDmb3rIt1I4GfNjuRETNbmC+kWjq8M/nh3XywxNAe7msGA/yw1t/xRWjIAyvsUwByS
	UsGu+cY/SlnrdcEX5ctkK1cQWY2I53C+veD+m1b87/hSh5lha0a97eVYNQjSqM6qcUkm4PNW6y2
	y9q95YE1eyQUzimAhvruOXl5T6lRQFZ5bUuKlbf1NuzdaqnYiA6mXZIjebIPgjALAiv7ytQvJ0w
	==
X-Received: by 2002:a17:906:730d:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c2ac23bf51fmr1255284266b.17.1790674016562;
        Tue, 29 Sep 2026 02:26:56 -0700 (PDT)
X-Received: by 2002:a17:906:730d:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c2ac23bf51fmr1255281466b.17.1790674016087;
        Tue, 29 Sep 2026 02:26:56 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678bbb0sm601169966b.5.2026.09.29.02.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 02:26:55 -0700 (PDT)
Message-ID: <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
Date: Tue, 29 Sep 2026 11:26:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/12] gve: simplify reset logic
To: netdev-bot+sashiko@kernel.org, hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, jordanrhee@google.com, willemb@google.com,
 nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
References: <20260924185316.2831077-7-hramamurthy@google.com>
 <179036256202.2160803.12978678207911420221@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179036256202.2160803.12978678207911420221@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/26 20:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 (1) · Medium: 2 (2) · Low: 3 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] After a failed recovery, an unprivileged user can crash the
>    kernel with an ethtool query.
> - [High] When gve_recover() fails during a reset while the interface is
>    up (service-task reset, ethtool reset, flow-rule timeout, or…
> - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now calls
>    gve_teardown_clock().
> - [Medium] The commit message does not mention several user-visible
>    changes to error handling, and one of its design statements is not…
> - [Low] This patch removed gve_queues_mem_remove() from
>    gve_queues_start()'s error path.
> - [Low] The commit fixes a real unbounded recursive reset but has no
>    Fixes: tag.
> - [Low] Item 2 of the commit message describes the old bug this way:
>    gve_close() during gve_shutdown triggers a hardware reset and then…
Low prio remarks could be ignored and we prefer no fixes tag in net-next
patches, but the first 3 ones in the list look relevant and should be
addressed.

Also please note you are supposed to address clashiko comments proactively.

/P

