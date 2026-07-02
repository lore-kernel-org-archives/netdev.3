Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58803E16A4
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989202; cv=none; b=WSwmrK7Y/qJQqTtUHFzyIdDngfVv+YNllthcNAVmz+2+GX6xJ5ghf+U6UPtTPzkUFE41JbMbIvQjt0d2Q+nPWxRR0O6uCpFja+gAwjLtwSkWf+yMbn8h6T+ss0fsfyyCMXKcZ/BPzQJNIsAOYu0gO9c7kqjq3YZrttjVlLS78yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989202; c=relaxed/simple;
	bh=h8ZpqOaUWtsuS4VnVEmZYwH5Jowx/XUHQyg5IY4lRTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCCkki57xBA+4CMlVcu/8cVrhLpLyvU+rUwHWLGtEYbJHKFtzsLEP/MOQM/n/nEwsjTRJVYvGZDvic9h3TqlfqdsIxlEBOyffNZbaZdRaAu04ic4/3ZLMhRQTs15sYFB5cwnOZRI5h/YhU06C5muyOX0b6oCw7QLzAFs3rv0UTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6NMXKNs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7mtvYwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6NMXKNs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7mtvYwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782989199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8+ItG+n5SavQTNo04OoG8HTpK2q0wv+Unc0gqZ6yGw=;
	b=P6NMXKNsz663nHc2OiMZOdnVA1WzodjJ1+tgjIyvAvsvhB81KwykGXmHQy8Rm7LbnzmZJj
	k+D/Njy6Nrj6RCf3wGi6fY3N+ZsLCr56fiGec6aNF9FKHjlyYWj+Lf5hvt6EMe4cBA56Br
	WZljKIRV6ZIZ35pG+qiHkMk03mHHUXs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-5bOWc_8bMH65-9oCEBxoYw-1; Thu, 02 Jul 2026 06:46:38 -0400
X-MC-Unique: 5bOWc_8bMH65-9oCEBxoYw-1
X-Mimecast-MFC-AGG-ID: 5bOWc_8bMH65-9oCEBxoYw_1782989197
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c126fae5f46so80234666b.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782989197; x=1783593997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8+ItG+n5SavQTNo04OoG8HTpK2q0wv+Unc0gqZ6yGw=;
        b=a7mtvYwpfoZrUQ1CWhsncvnQ7EMl0nKyfAMdr+hU8pzT/DZ5/SI1cvodWFTaIoAWO2
         rK0NSQA4YtSO9mRJHLzOmSEAAVFpOMAN5AVUVj/M29M1RUPvfTHHIugwliXMq9GK+clT
         tcIJO+WHWm36QOpTLukaneeQag3SFWT97UQuqNsZ3ISlb6RrSKh0M+nGeSwkAEe7UzHn
         284xD0ExUfrn5T/9yhykQ2NMQK0aNMy7nwL0SqgSEfY91wy2uuQ4JA8jqemAQuBSJPmE
         iXICrmhtHd0AdVKl9XKVNIBbjvsDVk4GAOe5i70ARxVtcqKnYg++Vpo/D4gdRY0FxLsp
         Hefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989197; x=1783593997;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8+ItG+n5SavQTNo04OoG8HTpK2q0wv+Unc0gqZ6yGw=;
        b=DEOc3I4t99YG5Xj/vCp6hrcNyIP6MX92dbiOLDe3KlcZIOE984ncoHGKhMQxnUCa8S
         pYM2l4nhCbZDwB12TkjsSWD4+A0d1EB0FXX9X36qPZAODttq+sfwSeDTHGBz/CLOyUzU
         Gc7k6tNxy/liUoJSrizmeKHP2ONiKTfF26uDUV0sH+nLO+bE1eKdRt+61kmIn5zSRbeH
         1nFwlnbdRW9LUB6b8FGhrLDPtsAuNMy796F7/6Qx+o/okyvvuyGHSXW9peWxAwmiJAs/
         bgVrf58YHErueFJoWkXJ+YU/8ewwCMkdvo2QVrwumdMxT5rVYYIKlic/9puxDUBRNLS1
         5GGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr00YoBv6bDPrIkedeNbalJLXjZlBQs+4ZygTfqF+TtXyxi7ywuiKG8zTXdSv5I0RZUI1geHqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwEC8jTLVrueVmwR9xERYCZXXfx4n0lxf0TY4SFfOLCUHx52L
	8BjKXm/iVHhkJwXA4hma4i3d3M2K7pz49dYE8uzHfULvnCtAmuQPXoLGaCQX1pD6Tc+0/O4MvXm
	pPKkUp9g3DSUtDPEqW9CvJ5mIB6pcMrvZvy+zKG4U5jJAJDX/5qnQvP8V4Q==
X-Gm-Gg: AfdE7cniyGjXrUiGwxvKijzV6YTzFfERfKFIYvlEG5EGeA+gD8JKsyjbWCnQ70nsPEs
	cauvzAm0bR+LwjvXj5fsc5gvnLmz0CJtEUboC59tl02HFGELA0jJKt2iqF+mKrs7myQAHy+lht+
	YdNi/jSyIPc1R5p1DkOaVdNZJo+cR1/0XnVAeh0JmXmoy+a63xm8UlwKH5d3HiXhjeKXrgozMYS
	vJYGAwWlCMi3udD6JtSdySY4l3aR+IGS8Ufjb/LS/xIewiiyPN0MoLN85Lna+vDTpoBtk1omEWc
	UlUNTypEQe1zQJKz7xi3cQS6e3rof8rsKIxkRSZNdDzyc+qioaJtyvwZ7fkqfl4J+Md4fryjkGv
	1+0K3Fp56C+77WVUjbZZsoZigsEPCETQeoPT42pvr8Zi0hLCvpDNmztNPj1HhxbN5owl6CeBxNc
	Nkgz6k9REUog==
X-Received: by 2002:a17:906:818:b0:c12:4ad1:3ec0 with SMTP id a640c23a62f3a-c12aa1f505emr185058966b.54.1782989197355;
        Thu, 02 Jul 2026 03:46:37 -0700 (PDT)
X-Received: by 2002:a17:906:818:b0:c12:4ad1:3ec0 with SMTP id a640c23a62f3a-c12aa1f505emr185057566b.54.1782989196922;
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c779dsm108378566b.53.2026.07.02.03.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
Message-ID: <2551da86-63d6-4873-93e5-266f29935156@redhat.com>
Date: Thu, 2 Jul 2026 12:46:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] net: emac: mal: replace busy-wait in
 mal_poll_disable with wait_event
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260630041634.284127-1-rosenp@gmail.com>
 <20260630041634.284127-6-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630041634.284127-6-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 6:16 AM, Rosen Penev wrote:
> @@ -371,8 +373,8 @@ static irqreturn_t mal_int(int irq, void *dev_instance)
>  void mal_poll_disable(struct mal_instance *mal, struct mal_commac *commac)
>  {
>  	/* Spinlock-type semantics: only one caller disable poll at a time */
> -	while (test_and_set_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags))
> -		msleep(1);
> +	wait_event(commac->poll_wait,
> +		   !test_and_set_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags));

The above looks dangerous to me. IDK which is the expected latency here,
but unconditionally spinning without any obvious upper bound and no
reschedule does not look good.

/P

