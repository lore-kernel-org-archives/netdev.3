Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D54A8A30
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781138; cv=none; b=sj338CTZERVSmY872xDanMbnQEM5J3FvqOvBFo9AuQoE0Bs0f3hp4zK5/G4Ava9c3VTKG31fzmhoVCU1sdp7zAX8tk/YgGZsu8CRu2r4lEcXXNdwzRJxxZE3aCC/4zZm90qgpQNFOXA0Y4U2z93lB/nw8OpJEwp2WQAIj5Bs2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781138; c=relaxed/simple;
	bh=7pSMEByB7R4uwEx4lR7TNQm7S98V/dF0hA7MZYBm4H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gr5vxDw32inRtbQbonlNIztoO5TBHvjSPfOlfQYkoIlfHkCKZ+CNesQvqZha1YNOHgoCswdIwa+aLjdTkaUOfK1oKi9G0LtzZAlWtef1TZvPQ6Te2O/+3LtrGmV5fG+KMnxiZzh7UiuRRSwYcCTpcheBFLOD3XZb3ebAkSro/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D5apak0v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D5apak0v"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4858595f997so2015050f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788781135; x=1789385935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTxWf7Z9THbI+LNbFW3uX14W5LzvtbTTU9b0mD+aQ5s=;
        b=D5apak0vWBt2mSW5LrB0IjvQ8rYPxzo2Gd8GBTp7qwtCbCTtDjzWEPAkbqIrhEsGRs
         exfS3GQQK9vrTxWQGPaL44stBDoH16b5GuYR6bThLiVwIK7xUhIx7ufkbZD2uDOen7ak
         1yKeobsRxqP7UpWfLwG7fUknB6Ja4Kc0VWOkQiUH5Q547VUSov7F3B8hyIkx+1zKQrU9
         Vt0SzWfPhWr5y1jwClX2WVeszlH8/IinQvu8/HmHwjwFdhIwyQmRRMsL+wM+nlEFQAHJ
         MwMQXlvhYgNI6Yhn/bbbepFL5bVg8OOwlzZQcxHyzxGwLI1/J5Zryx+Z3/HRehIeEVaX
         EP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781135; x=1789385935;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTxWf7Z9THbI+LNbFW3uX14W5LzvtbTTU9b0mD+aQ5s=;
        b=aXtEXWYR019t0FRnEObLsYyhwVNcsCz9wZrzZ4d8AWDQBiK4SBazUWCykRYZxmFkuE
         aQRvZE/v0fjwhjUIrySfS9Ra8AzP0Inftrf5W9Yw6BWJdACY7Tj7+KPfCEg7+uqvwm5N
         VJb+O45m+mWWv+A66MMxEFdDRMZjSowe9tSAQzyDprXN2TvNLZdTmO25JmjMrHwfY5Ma
         p6ijHsvdHXtthdpL5jdTYy9Y5C6I3X6NCh7DprvwiI0Djcfxq8RBNEMfnaes2SsLxQGS
         AFrENm429tXa4nu05CdwZlESG6zpMb4Y3+T8HSAlvfmg0ltLI07Ykhp2pMckE89iE11a
         uEpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxETv0CH5QKfWD2OSzn8NkgzMhKL9UKA/7tMdx7eNPF6f4IKhoANgv3cAsinV1B1ndPSmtX61Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mglxrCIKAcl74lRE5mRzLCDXI65d3wZWdXnAAukyflzph1WAiq
	UhvufDS4aqs3glSQkgsnAjwjOTxskKWhQVb/9VjiRrYZ2AhG1OxszBaa7xzTFZUGMcw=
X-Gm-Gg: AYBFou17MR+2dBSELxPgyU3YwqHcW7Wi7RGielAM6zJU+1D5zbM6RY+RfCn1Ru/LXL6
	mhmFFQlliNzslQcXO3NEZv2CWhlofVlkih+ZxJpQAB7gVtU8UUihsbv+lQAIM9u25SX+4oH2l02
	DjaqgBtfh5RWkXLwBerRq3dxwgCROeti5KqyYxXX9jgrQKJk3CMK/PQy+swwQkpeVH5XMOE7M/x
	EmGYDH2EXxMYjuTlP4K9UkwsuHwiZlReGzVHGtQ/uAlhWYFTt7AsUpcc5EULMBNeZEAhAyLurmO
	wC+rk1e7j1eebPw2OZ3VPI1e/3mqVF/TaF8gaJY2oXHExajlPMnGRoq/CGqxzUudB4GxC4grPDu
	v4AYfqQG+/BDFOJ0j4gvajXCeFfZc5CDtOLGEFViQS1FcS7peZDhdcsl6i319GMCEVxX0Rcpx5l
	RiO4FOZ+xO9b/MMAq61zR/I3VLG2Df6r6GUBvfw3OwaYwG8fdcuHzP3XmIEVL/dQwjtnEOebS9Q
	Z7k+fMV88IaIHFOcRQQx6tHMhw=
X-Received: by 2002:a05:600c:3507:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cf7fe6900mr417183625e9.3.1788781134823;
        Mon, 07 Sep 2026 04:38:54 -0700 (PDT)
Received: from ?IPV6:2001:a61:1340:dc01:654b:3cf0:59cd:498? ([2001:a61:1340:dc01:654b:3cf0:59cd:498])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm264862305e9.3.2026.09.07.04.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 04:38:54 -0700 (PDT)
Message-ID: <6e0dbfed-cadd-4274-8165-886725413d0f@suse.com>
Date: Mon, 7 Sep 2026 13:38:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] usbnet: fix smp_processor_id() use in preemptible
 context
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>,
 netdev@vger.kernel.org
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
References: <20260903165456.498079-1-omermetekaya0@gmail.com>
 <20260905224553.595766-1-omermetekaya0@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260905224553.595766-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06.09.26 00:45, Ömer Mete Kaya wrote:
> usbnet_skb_return() and tx_complete() call this_cpu_ptr() before
> disabling IRQs, which triggers a BUG when running with PREEMPT_FULL:
> 
>    BUG: using smp_processor_id() in preemptible code in tx_complete
> 
> Fix by saving IRQs first with local_irq_save(), then calling
> this_cpu_ptr() and using the non-irqsave variants of u64_stats
> update helpers, since IRQs are already disabled at that point.

Hi,

thank you for the patch. However, if the problem is preemption,
when not simply preempt_disable()/peempt_enable()?
Why is it necessary to switch off interrupts?

	Regards
		Oliver

