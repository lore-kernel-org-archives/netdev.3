Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72E33AD85
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021870; cv=none; b=Ji3nnbfHnKCuYL3xuzaugfgujAI2csUsFQ2HQDpHz3sDmYF6kkL206IYGbZn28HRmhs1dH1KOJ4MpkO6Fs4AET5/UlLfJU88mWjRp7Y87Pp/2zKm4KARXV9V2nSWNHI3VU+2ULbzDFA5B1zFN50A5d/KaSW7RjE/6S8j++zeB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021870; c=relaxed/simple;
	bh=K5MCWGaDb9+Usu89p/nhCacCUBAdkl7T6O5WGidxHQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaMwEGOR2OsszUj6vMhSOOGm4DjShAY9cEn+EWImkd7EHBQYbMvSnPHuJixRf1powRbj22ZjyrVw+Mkmw57ESjL3evHgmaYmai5lRKBiAnsiOvNiZ+uokw4PPEs5qqtSQ+P699bv7LM1WaBTxkAfttNZHDUIkx/F9wMRDGcuMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lt7WMgzt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv7AEC+S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt7WMgzt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv7AEC+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789021867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNvskUkqFZbQpRJgmwdtmrBCyRkK9l89EkCz1aQmZnU=;
	b=Lt7WMgzt7T17ntJlcdZnKLNTPY5tbB3if0CRiu7LQUXR8Yedfti0uw3/Is6lDAhS+iMALM
	hshY9vbe6GF/sOtdmOAEU2bD4y+FsW1Hq+Wc3n7NJYulJ2bjjM5v/YWE1EqWPHzr+FEHS9
	keF9RghhblCIFRvjK6r3yQMc1iQ6ZkU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-bYX8uw6mNRqXdLOF2xzJSQ-1; Thu, 10 Sep 2026 02:31:06 -0400
X-MC-Unique: bYX8uw6mNRqXdLOF2xzJSQ-1
X-Mimecast-MFC-AGG-ID: bYX8uw6mNRqXdLOF2xzJSQ_1789021865
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso2829755e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789021865; x=1789626665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNvskUkqFZbQpRJgmwdtmrBCyRkK9l89EkCz1aQmZnU=;
        b=Vv7AEC+SL3+jl5Ok1zIPeau5i5ObA0gLUmaYQnTNusG+BrWrudZjWq6ICjLBruozLp
         meEUZyIb7T5WkCIHKy8ac0qm1LcEzUuWwlJDqm4Ak/iuSAcoM4figsyt8pul1JMMFEBt
         i5TNOGaFPVYS/1XheRq7hDUTcYXTwlzT7o4zhEDss/YJQ9fxEiy32+aR2NEqma5ZPhSd
         NXb+sCckCY4heMyL98p7XFoSzIe6l+ETeGEeAJRA7XpLNwx4Un5qUcthPOmkUtU2ZPZa
         fxOywQliadynB8J2XtSN26T+yELdBoN9hINE46OH7OsguwjUZwXK++2/s9mwjFZ9a73k
         B/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021865; x=1789626665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNvskUkqFZbQpRJgmwdtmrBCyRkK9l89EkCz1aQmZnU=;
        b=Vv4DFkQrasRnqPHzPeq6cqbfJ2/PCsSE5GnW9JVnH+C294QABscZ9tuGjmegkaG6vP
         /HcKL5rtvTxmpnZtTnA/cA8rzFGH4xDYtjbjsAN5Fa2Q/xeQ1eEdXewNRBYDaIdmVSju
         bMeDZ0WsjPuvTAwB+sY8kzOCdI4vwMMG8U6NyLIJ7xSt4i/PL7CWnWbfgsxBJUIUsACT
         Vtu5LGeLhw/nrELBwEAeE2gvbZOpyaX5eDu5Xc/Mbi9bhxE3zvvbhAMC2m3Z5RYYGUUb
         kiPmufX7aX7ngB+0MhQue9KXJYVNHp5BshSsysuqrxler1V09inQia7e2q6rhWQxll7A
         ECUg==
X-Gm-Message-State: AFuF++mIu/mU0O6o8x3DyUWcOm3pjGIRLt14QNsk1p/Zhc5l2Ru01B9O
	FoB4yglApPU1GbbL4QICfLlnNHbWRvVrQh03zt9NkxFKYdGEbMeONUW0hY9AI/7vZikkH+0mnqb
	Iuc3pSwhxWz95foEmk6qpX9lW39htWvYvbwoC0pc3y3IvLA34LB0NAGFPyg==
X-Gm-Gg: AYBFou0cAzLMw4jiZLqDrz+2N9+17vfvoekgXTCDs2OMmCxeXQkyx71tttQjtjzZaSC
	UorQOLXxA15uoDAm8wMUTrdtB8q57+2DIOPdpAtuMx7FJcJPGZpLBwqVstyXCmFDgbN7+og40k+
	y1v/7QWJcFPF0ZfBsh8bO3PoyhPaMhSQiOMy4puR5oiwckZxgr0E3yuoi0tZRQsGhxnRExA49Cm
	uo842FhqYS690k2+M8nfhDSypfbrtsCEe2/PKHXn5Sg6DxvLhsvuzU1jdw7BqW0HQ/y+JD3NP6q
	qDwlI+eVmSFXaxdJrC5ximC2AY9uwCQh6lYHwH+116HxALOrnNnCIRORNVDxkZ3Uu+HtBra3T57
	4EtaaC0Sa+OD/fFENUgODUgF62PM3NUQuVEmjrfyViwlvhCDVUohOkHGqnQlKjvJR46Dj94U/cA
	==
X-Received: by 2002:a05:600c:8b10:b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49d26dcaa22mr30713705e9.14.1789021864401;
        Wed, 09 Sep 2026 23:31:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b10:b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49d26dcaa22mr30713235e9.14.1789021864004;
        Wed, 09 Sep 2026 23:31:04 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c38e3asm52660975e9.9.2026.09.09.23.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 23:31:03 -0700 (PDT)
Message-ID: <6c019cad-be78-441c-a556-05dde12a53d9@redhat.com>
Date: Thu, 10 Sep 2026 08:31:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: run netdev work under the ops-compat lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, sdf@fomichev.me, kuniyu@google.com,
 linux-doc@vger.kernel.org, davem@davemloft.net
References: <20260904180058.3803849-1-kuba@kernel.org>
 <3e210ef7-f807-4de7-935d-09441710acbd@redhat.com>
 <20260909182215.14b5d94d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260909182215.14b5d94d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 3:22 AM, Jakub Kicinski wrote:
> Oops, looks like this has been sitting in my outbox for some reason
> 
> On Tue, 8 Sep 2026 13:26:52 +0200 Paolo Abeni wrote:
>> On 9/4/26 8:00 PM, Jakub Kicinski wrote:
>>> netdev_work_proc() took rtnl_lock() for the whole batch, forcing
>>> even ops-locked drivers onto rtnl just to run their rx_mode / ndo_work
>>> callbacks. Take the per-device ops-compat lock instead: the instance
>>> lock for ops-locked drivers, rtnl_lock for the rest. That's what the
>>> callbacks already assert (e.g. netif_rx_mode_run() asserts
>>> netdev_assert_locked_ops_compat()), and non-ops-locked work
>>> such as vlan ndo_work keeps rtnl, since its compat lock resolves
>>> to rtnl anyway.
>>>
>>> Without this adding more uses of ndo_work, for cases which don't
>>> need rtnl_lock feels like a step back.
>>>
>>> We can drop the comment about the extra ref now, with the relocking
>>> it's a necessity.
>>>
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
>> Dump question: can the `netdev_work_list` work list grow significantly
>> under non pathological conditions? netdev_work_proc is now going to
>> acquire and release the rtnl lock n-times for non ops-enabled drivers.
>>
>> Would it be overkill trying to acquire the rtnl lock at most once (i.e.
>> keeping the netdev_need_ops_lock() and legacy drivers on separate list
>> and process them accordingly?)
> 
> I haven't seen any evidence of such relocking causing issues so I didn't
> want to complicate the code. We have a similar situation in a number of
> netdev genetlink dump handlers.

I see. I suspect containers orchestration/control-plane heavy
application could notice if they depends on the relevant handlers (I
think at least the one I'm less unfamiliar with doesn't) when the
relevant change will reach downstream.

I think we can improve incrementally as need (at least here should be
quite straight-forward, for gennetlink dump handlers it looks more complex).

/P

