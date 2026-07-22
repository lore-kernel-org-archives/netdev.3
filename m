Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7BD32B125
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708997; cv=none; b=q7hTsSwS5CBSSmW8LLFuihqIKuOIG4j7Zj13bV4/2yfYd/xM0oQoToHO+CeimOHVM4jFaihXVnG1aXm8vyK5QvYyxR4OpUBHgPw3dBAVphn9OBiDtmYCuGLzaa8qLJ7ljsOsT4Fxczoq+RSd5O+CV0RsKPUzYjeAFV5BODFD2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708997; c=relaxed/simple;
	bh=D/zlSFd1H5gthfkgYjTudpTd+BpF8ExOfLFelpBdujo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3qUBFgKqMFmhvvG01i4TeJIOZKhzab/GY/mBgCRdGf+TQVnMwRcL7pAXZSMWzVlxAwG6I2K6Kb0K5OvfIax5HuwiLYuFGloMqB3EGBDCpBiLHgVm4dvCalkLIwY3DlQAQTXmASec2osgUjZt6nLFr9Ik2LoKaA1ZrsKXWgtEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TCQU/kgm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TCQU/kgm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso6934860f8f.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784708993; x=1785313793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+o5BhmpQGUXsPUn94swQ8qdBGf076Q7ku70v+i3VIFk=;
        b=TCQU/kgmUtjBnO3/OVGBkly+eRHPH5Yj4ojhiQFFa67sCF3OdqZNFyhSvA3sdLSm4q
         fMLPjmhPHEoH3OjZRP2R7toYmHad1jV4aw6CpknluP/By6xFw8GXN9mwrA2hFt1NVikn
         xpnu2twp4iTztmjldTVnEBx2fm/Jfkqtt/pQOyE9SmWqoXlG4sW7rpMTL3Yz8noVNNaz
         nDr66oYrVSnDWcHmm8+EDAh6FBG16cO0jyvn3ducg65fXPggWn+oBAV/+hKQxkitXrJi
         KQhxh6zMY7j4wCrK86bVckPq9ko2mjOmRd8lQxq0nY6SeR9qS3Si2HcQY7Qf9ZDffc5g
         oK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708993; x=1785313793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+o5BhmpQGUXsPUn94swQ8qdBGf076Q7ku70v+i3VIFk=;
        b=X4JjvWQ9pQyDMrU6mnNJyXAI0DkpEIvop5rN5bWf6vJVsIXaDqCLUxWuem62J9x5r4
         pppHOhvwkpoKPuOkgB662MLetvpQDh7cSUrKUMt1KYOMq/8naK0ML5W4YrH9OWgNeyG3
         v91Yn5OOYiUGQZG38cJkbNxGHWUmJxbRSdGyuSDa0HvmSp8OT8Ccsp50FjtBXPfX2Lec
         XTynvBBUQUokpUUEqi2XO0uNgU3shEI0Pv9Vx1CHmGDWt9UV4Y+BuuXIc5z2X6+wMazg
         QG/5CuWd3nXPTPe0Jg75gK1We0r82syk0COji1zMIEZRcoCdHjakNZEW2Spw94chwxZB
         nB+g==
X-Forwarded-Encrypted: i=1; AHgh+Rr/9Zd5e/2LOvQtTpUCTYM6pyhkqKa6bpd61CLJ9ImYfCcHLq4POqo2AzOUuVx7I7rvhTB1iAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOGC2piFaY+lBtDw/DfnGPRQPsLO41u1y7w8RQDVqh+zsftpS
	4EzslKb/f1dCFwEMaesRrVgofLS7Z4wQbKNbxtZhKPJVcG5kkyRZgXh4XqGpQTv/bqY=
X-Gm-Gg: AR+sD13yhty5a1QeJCj/5DwXq7fa+X0sMlgW1fwGM8ylhb7yr/S97aAtfZxg8T10wbT
	jFBwzqJcpRTYL/x96myOuKaaWIHukmRZ92/71rOb5zB8SxBiRngLMt9IelAmHzIZpO80dMkN0Wy
	j+vwK7EcPro7sNQ+DAB8IS2AyRw/Qoi9ejgQ9+/fxTqNobDO1OyY4OmtEZROZhR17NIW//NwKyO
	hx1UgEolDSMCAMZHb3gl2YbAzNyJyevCY0cFD3UbzUqYm+gsBIUMFHLLxIwHDQpn2o4FMlNOKwz
	7KefHE4aj2wu53bC1IM0Cj9wT6qVwo1t91FmsLz+ns9n5sxiq9WFahtHevUajRCYLc2V44/8jBm
	cfGf2wMXzdgMLLk9HmrcIZ2rXzruN6EYwVhvNUnnnj/7KMqLfsSLSSfIWZeqBcSHcpihinnEkZZ
	r+pnAIfjPF642o1ndziTBeAUayy5APcTgh2nQw6I1UU8s=
X-Received: by 2002:a05:6000:240f:b0:47f:83a1:6b7 with SMTP id ffacd0b85a97d-47f83a1070fmr4754652f8f.21.1784708992834;
        Wed, 22 Jul 2026 01:29:52 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6c0:905:69de:a6ba:2af3:1ea6? ([2a02:3033:6c0:905:69de:a6ba:2af3:1ea6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm4148066f8f.33.2026.07.22.01.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 01:29:52 -0700 (PDT)
Message-ID: <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
Date: Wed, 22 Jul 2026 10:29:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/6] net: usb: pegasus: Move long delayed work
 on system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Petko Manolov <petkan@nucleusys.com>,
 linux-usb@vger.kernel.org
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260720100902.155605-6-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.07.26 12:08, Marco Crivellari wrote:
Hi,

> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.

these changes are problematic, although they look like a good cleanup
in first place. But the test you are using to determine whether USB
devices need their own work queue is incomplete because you are not
considering the reason they allocate their own work queues.

These drivers have their own work queues because they are part of the block layer.
USB devices can share a device with a block device (storage & UAS) and
USB devices have common, per device operations, in particular reset
and runtime power management and disconnect handling. Because these operations
can be necessary to complete block IO neither they nor anything
they depend on can use IO to allocate memory. That is they need to
perform any memory allocation with GFP_NOIO or GFP_ATOMIC.

That is also true for any operation on a work queue they need to wait
for to make progress. That means you cannot limit your check to per-cpu
variables. You also need to check for such dependencies. In particular
any usage of flush_work() on such queues can deadlock, if you use
common queues.

Please refrain from making such changes unless you have fully analyzed
the dependencies.

	Regards
		Oliver

