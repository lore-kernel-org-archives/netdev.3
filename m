Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD3F326C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920758; cv=none; b=Y3laRygIY+dNqmTNe/6kH5l+Tn83ytX4UyQDyAryFOEUOFJf9KIjx1EhE4R6a4LxaNUk2koQaDSUnyH9GyLl+HpWFZK8ZhYjyH1nn8hcqhjKTv8m5QBepXeclu3MZ15wcXbpEdBiGquIlBjlrKDqwyerNHzWF9SFx6rhHuTgAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920758; c=relaxed/simple;
	bh=SXldiWeSBHh/RUC+pz/Z3pn8xriVxkGMlcAH6wkwwtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crHBZv7t2z2+qFexosAk3zJ0RlWTt9JnJbxtS5ahL5Sy6UOTIUaCOciHzRnmP2N5Ii9K9OxLLN53RXAD5ea5kDwIe5GEDS/tvAttuEtfQLVon240Gw7vEPR70fE2btASlqcJEm1eHat4ziIITclhR397+lz1vi4vD8GtoI/RfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVDb8ACi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ox4dwB+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVDb8ACi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ox4dwB+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785920750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJv5koF079AhpRKjQRIs6WVbtzHWEnWNzOeKXg3GqUM=;
	b=FVDb8ACi6tKK/a3SG0YAtKt8OlC0PFwrBIMz4t4OGbAr8MgS+gt3Fl5TLFkSG1ymVGMbx3
	xYTAz5+qFzEU8iLjO4V27bsGVkeL38mM3hWAjG5/7J8bnmhRSY5qI1TEtqaxB/fYRoaIuf
	BSf4VHlyNG8XLwuK+OulUNchArekeUs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ASKOui4tMa6T8IDjz9OBww-1; Wed, 05 Aug 2026 05:05:48 -0400
X-MC-Unique: ASKOui4tMa6T8IDjz9OBww-1
X-Mimecast-MFC-AGG-ID: ASKOui4tMa6T8IDjz9OBww_1785920748
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so7642985e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785920747; x=1786525547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJv5koF079AhpRKjQRIs6WVbtzHWEnWNzOeKXg3GqUM=;
        b=ox4dwB+P1H0fEf1LGg8ho9mLY1t7YF5+hzS8FgbRsuGOQj0cRU0dLAi3Ggq8SWjaXT
         9v1xPcFSMFn4sHF1TVGP6ACP1j/zlJb1WLvkWC3TJ8n4HyhlonMz5cUm9xiiMRGZeQBc
         bU7s2QI5y6D143L2xos0Wi1y9qbFlKn8sCGGBxEW+aBuJ0bXgRKFTaEudScZGHUjZhnK
         01CjGKbkXKdINUYRMYp/WodNlzLMnO3n03sbcbU3zsU0jf8q3d2LN/WjSsH9+9eNR6PP
         iGY29sbJpuHh8+7BpDCE6Z2pzoMruUxTyN9e6+Xzqyt7hkJA4PR7YmNTG3Uu/sK50D5Z
         5hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920747; x=1786525547;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJv5koF079AhpRKjQRIs6WVbtzHWEnWNzOeKXg3GqUM=;
        b=pvgUEAFk7zbkAX1dN1yH06WzSqokt0MmRYAIh50jYEnglc42OPeNb9JF7zigKX8iCH
         w8laP4RBMhpgAPgV7JNuiMfDkMu8Afpd/GRdXng7tTxIKR9HfDlxlN3Gu/EZKf0XniYp
         y8GUHE6XTTwG7l9ZgQ23PrdxftTI+wtaPFnbGXGswad52dqk3a1l7pOlmTUqOt6/CsJU
         vpR3y6dCrLvc+6jYieh6wDepfhwzAfzLdtc8oQMMpCDTWWz8ofS5d6M6bSbRqexFSjtO
         r0EIOWEx0PIqqhl5mHY8RJGspAU21AwtqH4vfrRLMH1vUUf7jTFngkSy1nOMMfng59HU
         bW6w==
X-Forwarded-Encrypted: i=1; AHgh+RoIC56z+HdxFVk9KeMD+iq2VhqwhDGvlfkb5LZ5P8y25bq1Nz5FT9yLq02Hung9mDCHZM0IGkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dpFFW3AN+IE3Bl03wZL1rsvJdMcCW4Tl3UmVbzJBzI7j6ZvZ
	eWzT01DUA0HaODt6GyWUir2iTQf1FJWODfpgIklL00F5aadwUKQIB5nJJOeFCp7QqBvOHEYZZWt
	A3o1XxEZJ/iD6xwjZufyK+uvZd1HwtcUAc6OL3zU9UW/rk5DNNQI3C5eKNA==
X-Gm-Gg: AR+sD13iM7Bf8izEffNfIthS/RilI7GBlELaKMiuBvl5qKwETcJmexrYjbZ12zcstg7
	KistIqYMFLCX7mIa60fa1GbcCJD+IoJFtXXkvyyk/f25At+coFjwE8E0ZJGtf2I2DvDfN1pIrr7
	0OopJj0Umy97wGMePGGNpc/GrHV6/upMvTcR7ckHHa+vNTIUT6owiApmPZ6bN2/ipL/m0ROr3hu
	kz0YpfnLbcH3iLP7bPLp9yI/L0a9Xmc/BzJWYDTuypAFjTX7D+fhSoyawgUvjP01sSsBy3Iaxyk
	NuvyBUhWeHYeV/CKM/k7vRGRU/3a6FZcH7D6TgEDkKKwAfmPO5szKA/YDWQdcQnu6HGXMmc9Xc2
	1bkd1he59Fjr/vitOqV6cLaSTbfWlY1N44QELn8Z0UGN8nRtTZtm9gHZhHB8qhCNMgZrcfsraa5
	o=
X-Received: by 2002:a05:600c:c490:b0:493:c337:db0e with SMTP id 5b1f17b1804b1-4994e7ece20mr57702835e9.18.1785920747606;
        Wed, 05 Aug 2026 02:05:47 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:493:c337:db0e with SMTP id 5b1f17b1804b1-4994e7ece20mr57701825e9.18.1785920747044;
        Wed, 05 Aug 2026 02:05:47 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm84916885e9.15.2026.08.05.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:05:46 -0700 (PDT)
Message-ID: <14b8701a-44a6-40dc-b46a-46096ea5bca2@redhat.com>
Date: Wed, 5 Aug 2026 11:05:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdevsim: fix deadlock in nsim_bus_dev_max_vfs_write()
To: Slawomir Stepien <sst@poczta.fm>
Cc: syzbot <syzbot@kernel.org>, syzkaller-bugs@googlegroups.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
References: <b7bf56ea-7522-4163-acd5-aaa69ad03b3a@mail.kernel.org>
 <c74a0579-dc37-4f3b-8dba-8380223b361c@redhat.com> <anL6nNIJDqWOynzw@nr200>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <anL6nNIJDqWOynzw@nr200>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 10:55 AM, Slawomir Stepien wrote:
> On sie 04, 2026 16:33, Paolo Abeni wrote:
>> On 7/31/26 11:55 AM, syzbot wrote:
>>> From: Slawomir Stepien <sst@poczta.fm>
>>>
>>> There is an ABBA deadlock between the devlink instance lock and the debugfs
>>> active file reference mechanism.
>>>
>>> When a device is being removed (e.g., via nsim_drv_remove()), the driver
>>> acquires the devlink instance lock and then calls
>>> debugfs_remove_recursive(). This function blocks waiting for all active
>>> file operations on the debugfs files to complete.
>>>
>>> Concurrently, if a user writes to the "max_vfs" debugfs file, the VFS layer
>>> acquires an active reference to the file. The write handler,
>>> nsim_bus_dev_max_vfs_write(), then attempts to acquire the devlink instance
>>> lock, which is already held by the removal task.
>>>
>>> This creates a circular dependency resulting in a deadlock:
>>>
>>> INFO: task blocked for more than 143 seconds.
>>> Call Trace:
>>>  wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
>>>  __debugfs_file_removed fs/debugfs/inode.c:751 [inline]
>>>  remove_one+0x2df/0x3b0 fs/debugfs/inode.c:758
>>>  __simple_recursive_removal+0x215/0x520 fs/libfs.c:623
>>>  debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:781
>>>  nsim_dev_debugfs_exit drivers/net/netdevsim/dev.c:372 [inline]
>>>  nsim_drv_remove+0xc0/0x170 drivers/net/netdevsim/dev.c:1803
>>>
>>> INFO: task blocked for more than 143 seconds.
>>> Call Trace:
>>>  __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
>>>  nsim_bus_dev_max_vfs_write+0x229/0x3d0 drivers/net/netdevsim/dev.c:276
>>>  full_proxy_write+0x127/0x1f0 fs/debugfs/file.c:388
>>>  vfs_write+0x296/0xba0 fs/read_write.c:685
>>>
>>> To fix this, use devl_trylock() in nsim_bus_dev_max_vfs_write() instead of
>>> devl_lock(). If the lock cannot be acquired, return -EBUSY. This aborts the
>>> write operation, releases the debugfs active file reference, and allows the
>>> pending debugfs_remove_recursive() to proceed.
>>>
>>> Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
>>> Reported-by: syzbot+3147c5de186107ffc7a1@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=3147c5de186107ffc7a1
>>> Link: https://syzkaller.appspot.com/ai_job?id=fcdda182-bebf-49ab-ada0-d4d2e814ebf7
>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>>>
>>> ---
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index aed9ad5f1..421cd7327 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -273,7 +273,11 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
>>>  		return -ENOMEM;
>>>  
>>>  	nsim_dev = file->private_data;
>>> -	devl_lock(priv_to_devlink(nsim_dev));
>>> +	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
>>> +		ret = -EBUSY;
>>
>> I think this should return restart_syscall(). This kind of schema is
>> calling for trouble, but for netdevsim should be okish.
> 
> Thanks Paolo for your comment!
> 
> Can you explain a bit more? What is your reasoning here? Is it, that we expect that we could have
> the lock in e.g. 1ns, so it is worth restarting without bothering userspace[1]?
> 
> I see a lot of:
> 
> if (!rtnl_trylock())
> 	return restart_syscall();
> 
> Why this pattern is so popular? Is it for the same reason as above?
> 
> [1] https://kernel-internals.org/syscalls/restart-block/
If you don't restart, the write will randomly fail when the lock is
contended, as reported by sashiko gemini:

https://sashiko.dev/#/patchset/b7bf56ea-7522-4163-acd5-aaa69ad03b3a%40mail.kernel.org

the user-experience will be terrible at best.

Also, I missed this other report initially:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b7bf56ea-7522-4163-acd5-aaa69ad03b3a%40mail.kernel.org

it looks like the above is not a complete fix.

/P

