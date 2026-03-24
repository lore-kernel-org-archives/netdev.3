Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AE23D7F4
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377988; cv=none; b=PvTGYxNJs72mH7Nyi+pcb3JudkGDTtztpd8DgMQHaYX8oi7WLcGtfYCg2gy15ODl518gmcC7Bx0OAF1ZAxvyRxrL0XrTZZF1qklkirNcLLSWPJkPAEfx7XI5yVzuoBjg4Mg1mbaL7VcUgQOans/3FImlvoX+Fo9sEngP1tzQjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377988; c=relaxed/simple;
	bh=UvczzIsOMS3kXQveM0wpV/GAU7QOBQmVRRHQQKtC0Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8CqUfunqBFxlaicUM8Z39IR6OvHp2qjKHPX5QZydKO50p3EOEuAy70SOr6mvYArufReGcD5xWHanqm58PkNWx0Wk6JVJRdCUiNG/so/LWgHJmybOQqsZux07QSIRgkkjf+L2xM9wlvtPGHrKeefzZtI9bZZz+AalpUo2XMV8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb112c09so38526995e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377985; x=1774982785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojOjsKJ7l34G40EKUErpTUD3/94bIcbPZZRxSOVCdW0=;
        b=mD8pYYAm5dSXw1P2woBO3e8q2fXq9BUwwUf4fgqaIIk0E9ROl4fyHCnoZxTp9Q3c+r
         MkVWOBcUIB09ipr5hTpFc5McO7y8IZHGtSeB1ZphtHHIQl26xDRgHYlJL85h70/L5bqU
         syfxxsPoDBbB+PPr2vmWpsP3NwO9gJo/lGgHNBpeP2GZd2QvvUhsSLRcaD/l0vuY+FzY
         b+cne07PHnuiRgaxAdl7CKD8i56Qco5FQxQ31YX+JOY9fjMMsqtFkh7YiXwlpJ6e5Ff1
         13wLTeZvBoNsG7d2wRLk7A7WGmmCmKxW2mq9wvNrmUVvR3/B5SG0YBBwx+TDVfSSMy11
         XLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqN0y58DwFHHQMqGxmr+h8DYVm9B1Kz1Ovm8s1KWr66jPdzE31bptmuGFsEhTpuN1GwfWADbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaDkNLFbVYfZS6UMPvXzCE/AkJx641ky/Ds26cJEzeuQY0kGe
	KHIse/oPIEMrqoj1NefVjQYEaT2wuNuO9dv85voBpSpHfYREZij5ZdLi
X-Gm-Gg: ATEYQzx7p6uIZb+7z2xJ302PxxcI90p+uEiETGRmoBcgG0CVtDHahaICILQCNiK9oVx
	Ttbw4sX4oayXeUY6cBAZ1d3szseQCsmwyJ0aXlanf8LgS/GeBqZwVc51eFaZK3l4Vw6xh5Q9Rvy
	lWxVVKWP0qAE1bgbzO9nQ+h+w6VHr72fKwtXCC75SKp5WShmcfAUh1fxkJws+v/YObQ164GQJJP
	40j0ucNSYRsEZ6KPGPmkN9OBdoucZatJWIB9vs2cUJqEN7CS0JIyrGLJ95n3eeqHp1F91XRjuGq
	gqL6jgSIlRbOqoV87vfEmPNUOg5eel2VbCR1WoaEsqqbp4fraI8OnXcitgQFY9E/V94dTRD9IAr
	S0F6gcpJoYBlCKxUtunqmpCvdTf+cBylX3Ubuamao481nH5MCeSg9BaCFlh+YxV9BjZSwUP1Hs+
	MjFfRmPXP5h84KW9LOC7XpHj34yvMrtA==
X-Received: by 2002:a05:600c:45d4:b0:485:557d:9fe with SMTP id 5b1f17b1804b1-48715fd63a9mr12314225e9.12.1774377985164;
        Tue, 24 Mar 2026 11:46:25 -0700 (PDT)
Received: from [0.0.0.0] ([94.156.174.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113c4eb3sm77639005e9.0.2026.03.24.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 11:46:24 -0700 (PDT)
Message-ID: <1c41e408-15f2-4c83-8a0f-24b46b1ec1c1@linux.com>
Date: Tue, 24 Mar 2026 21:46:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] ethtool: don't touch the parent device of a net device
 being unregistered
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ido Schimmel <idosch@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Greg KH
 <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, notify@kernel.org
References: <20260322075917.254874-1-alex.popov@linux.com>
 <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
 <eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
 <20260323150827.24a6259c@kernel.org>
Content-Language: en-US
From: Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20260323150827.24a6259c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 01:08, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 02:08:53 +0300 Alexander Popov wrote:
>> Hello Andrew, let me describe the scenario that I see:
>>
>>    - The netdev_run_todo() function handles the net devices in net_todo_list
>>      in a loop and moves each of them into the NETREG_UNREGISTERED state:
>>        netdev_lock(dev);
>>        WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
>>        netdev_unlock(dev);
>>
>>    - Then netdev_run_todo() frees these net devices in another loop.
>>      On each iteration, it chooses a device for freeing:
>>        dev = netdev_wait_allrefs_any(&list);
>>
>>    - At the same time, the ethnl_set_features() function calls
>>      ethnl_parse_header_dev_get() for the child net device.
>>
>>    - If the race condition succeeds, ethnl_set_features() takes the reference
>>      to the child net device being unregistered. That makes netdev_run_todo()
>>      free the parent first.
> 
> That's not sufficient detail. ethnl_parse_header_dev_get() is under RCU
> and unregistration does an RCU sync after delisting the device. Also
> not sure you're distinguishing struct net_device and struct device.
> 
> How did you hit this issue? What are the net devices involved?

I've provided additional details about the reproducer of this vulnerability to 
Jakub and to security@kernel.org.

Best regards,
Alexander

