Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5C4A43E8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820765; cv=none; b=MnRSdY6d/BSyLEgNMcEd55ufzg4/uHe50IV1WYuall95bv2Ec3vDcXuIOs2TanJbUrUFYBk3jNWYeoyFYfVxYar+6fm/Za6oxRlzgj6PjjjBCrCXNhN2K2EaZnnsuGk5oVROMDhbxDJ9lF9OGEX/s9cLKOkGXX1dI7aGMbhMXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820765; c=relaxed/simple;
	bh=RjTtcobNiuX16BwUGzmJwy8cP5rQnF6XH7IuekcPHow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtRfwCTkrXcasB+KyQVwtuUU2+/GPL/rRh3XlwzUG3lZ9k3Lt4cKEEw2OzFzcQxFIp4yhRCR7N4MIhQY7jfLhcyxs30VJl9ykeK4MPUOPkaqgefqZBPDsRpB8JaYme1I5TTDeEwnEOO5ojdPzYVCG5puAbOqzXpq8056m4VvkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmc7OY1I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHQpKTeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmc7OY1I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHQpKTeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791820762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqI0vKWhWID0iPwfFlqep4wyz02zUJ79cFz88qhSvN8=;
	b=Tmc7OY1IeRTCVWxthJ2Qq+IA3K/DIlWL3ZZufPZre8wqNU3t7+g45PizCxFn0HollJMu7N
	yiXSpokNf9BTFXH4oZ0b+RThrJatdkRyPd1k+aDFw9Bbfa1OqnsCxZ7ZYJza9V/QMaPoMQ
	loPiGhAETj+ulO98UKQyDZHjIB2s/cI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-leLqc0GWN4Gq8q2y7kGceA-1; Mon, 12 Oct 2026 15:59:21 +0000
X-MC-Unique: leLqc0GWN4Gq8q2y7kGceA-1
X-Mimecast-MFC-AGG-ID: leLqc0GWN4Gq8q2y7kGceA_1791820760
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a16fefb7acso16042205e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791820760; x=1792425560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqI0vKWhWID0iPwfFlqep4wyz02zUJ79cFz88qhSvN8=;
        b=ZHQpKTeIU+GTQe8mkqMj6h/K8V2aaFUk0FTEPB8hS7r7Wx0fjtOaOCGEFC9fKRuZSN
         IyhCRTVi14CVjQArPEUI3r+hHlM7wAHa67bRa/pun8nntJYcnf5216NAYxVdnIdb5ZhT
         6Qd8qs9sLqqPrKhSgRQv0TPOrI3Yak0ARENsOTQf3IYgFAbesSiVmlAxUPndOnDrH0rk
         LDAx+gllcKi7lS9tsyCEOgj4vVZ6u1L0BKuaT+RqBYldMgIFPUrs4hMgIDUJAUikFBOU
         RDFYNnyVb4wOHCcecvFpMZP45iC38ynVhRxfHl23TpdjyQZRyacXop4aJIxt1WZguNty
         ZkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820760; x=1792425560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqI0vKWhWID0iPwfFlqep4wyz02zUJ79cFz88qhSvN8=;
        b=O0YU/t0yry6kS2AwfGA2MD/N0pGNfA3/zQJHwnZ8nPFFFxHpGfBxoIKuC5jbkfY2zD
         ZRAZECrDcIlKpApo678IglQ/w61oXRaI2kvnGFFSFemnp1L1G/BLziHmtORJb5KfJnsF
         TYV9xp2sI9zTZbvysTq61wE/q405AYkAqR8tZYtJ6NYPquqQccdKvUKRMYmAsAL8Ybo+
         tVOFOY96MLYbqj5+jFR48BFxwy3PwgiReZRnUEo16VJJQZT43KyF1VccIEffJ+NSznJB
         u7q9Kzb0OPidFX8oAjoX3nBrwNjVLSRhOqjyEBBi6E41YOLChajlmXZD78ItpdM8YYfS
         /nnQ==
X-Forwarded-Encrypted: i=1; AKwUvBypJPXkvY8UMfIDDIWwkFEVUbSBAlANDRis4VI/Yul3ESY6i/B+iPYni4xa6+0de3RXA4/+GwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIc+I11D6pTJ7qlIiiPIB37rZDwedI8iFv+BsQDyyyFpeu8xOuS
	V19Wr1Zqbw0A5F7QyHpUQ2p3ZK8VRWy0w80MMKPe3KXDHLjO7NvjxsojL/HX1AzdrePJIDpQIji
	DGag5jZx9OWdwJy2ryeUxQWAeiBRNB3bpgG4vHKscHW6Dd3019utEcaemyg==
X-Gm-Gg: AYBFou0lc68/fcbuoHEZSats/bgWiqfGtK0Bh3uXy6KuNYOzxeupRw5AWYNMnYJFCpg
	LxLJY/h6sERWhkUXpUQsb3B5BUIecifY06l6IW6CbWQn2Fk+VvJZGGyaYDP74r4gEpWcmjSzpha
	r6XnBLG8B6eD2lAeFSpQEDavGOhMRiuta5gXQBnwMJuCDBlOs6d1eLdaoeSYpV4QCJfARSItc/X
	u6m7Uy4cuyFfvO3UGswrVHPpArb5SAH8qjkbJSOgX/HBiigtLDdZsj7jHAe53JxV6xqDjvMPlXW
	YU90kIzMUXNqQEj27hSKyEldl0bVS+eUkJRV2WZAn4zCB1tFARGz6xUuNZTNF/DibdlppV9YfT0
	BulsnZZAwr2rKBBoTbPIZyAID7+iqG8U769g7tWI2gwU/DuOWAZ6ATwVoE6BEfZfWbtT4tpqCBw
	==
X-Received: by 2002:a05:600c:4747:b0:4a1:80d8:aed0 with SMTP id 5b1f17b1804b1-4a18e4a9862mr200106685e9.15.1791820760089;
        Mon, 12 Oct 2026 08:59:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:4a1:80d8:aed0 with SMTP id 5b1f17b1804b1-4a18e4a9862mr200106225e9.15.1791820759686;
        Mon, 12 Oct 2026 08:59:19 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb68abfsm327977205e9.0.2026.10.12.08.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:59:19 -0700 (PDT)
Message-ID: <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
Date: Mon, 12 Oct 2026 17:59:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send and
 connect
To: Andrew Halaney <andrew@amutable.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 17:09, Andrew Halaney wrote:
> SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> the thread-group leader. The coredump server using the coredump socket
> cannot get a handle on the task that took the signal and is writing the
> coredump easily. Workloads interested in per-thread authentification
> have similar problems.
> 
> Add SO_PASSPIDFD_THREAD/SCM_PIDFD_THREAD and SO_PEERPIDFD_THREAD. We
> record the sending and the connecting thread in addition to the
> thread-group leader.
> 
> SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
> SCM_PIDFD message for the thread-group leader, SCM_PIDFD_THREAD sends a
> pidfd for the specific thread. SO_PASSPIDFD / SO_PASSPIDFD_THREAD are
> independent, allowing callers to get both styles of pidfd back in their
> cmsg.
> 
> SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
> that called connect(), listen(), or socketpair().
> 
> pidfs_coredump() now also stamps the dumping thread's struct pid so a
> pidfd for that thread reports the coredump like the pidfd of the
> thread-group leader does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>
> 
> ---
> Changes in v4:
> - Moved get_pid() out of scm_set_cred() into scm_send() (Kuniyuki)
> - Dropped unnecessary helps (Kuniyuki)
> - Rebased on v7.3-r6
> - Collected Kuniyuki's RB tags
> - Link to v3: https://lore.kernel.org/r/20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com
Out of sheer ignorance, I don't see the shared, stable tree where we
can pull from, can you please point that out?

I think that this late in the cycle, the series could go via Christian's
tree only and we could get it back after the merge window. WDYT?

Thanks,

Paolo

