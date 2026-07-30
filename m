Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CC4052AA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409336; cv=none; b=qL4mYPmdokp6FJfWa35Nz+lo2e4Zvf8mOT+zfCQ1XU5dczMPLBB4NkUN9bF+opOgRBRmUOdksBEPPJ4/S3uZa97RteUWwozgwQdfHx0qAdCT7pRgZ6opcOx1PqjAJGgirHyEW7wSxu9gUGfbe7SPxIPb9D1njDLDrkg7PdFoIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409336; c=relaxed/simple;
	bh=4dNV8PH0CaE40xpTad7DkyOXVNy048PvQhAPvDCkzwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJbSMrsj/JG0ttkLBU0v7BY3ZkdC5HpEf532WNi/i6QiiOVyXaeZ56O6oqNSWVYEDMZskob1hapg2YfUFN5AueAlQmSBSZbw9Z1WB8lkcttgvCPKwR72nd712yZ4uIv/E9LQFVH5lLDLRuXMw8bevzDvhOOtfm2lDnBerucrgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqXoLe4o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=juxbA9z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqXoLe4o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="juxbA9z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785409334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
	b=UqXoLe4o0pV8vH9tHJ5gH33EIizWCO5d84JXeQZuiSXGLpocoZTWuANNNzkoONMvuFrMB8
	FdYI1e/Knj/qtmE/65a4dNV7YKWIYu7wWZ3/mJNTHOYtEoflKNv+0eqVA3aw9paQ7+9FxW
	mCutB81zrNyPVI597xLT6rU1kcYq+NY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-dIRlE2sRMPipHYV3Q8vjww-1; Thu, 30 Jul 2026 07:02:12 -0400
X-MC-Unique: dIRlE2sRMPipHYV3Q8vjww-1
X-Mimecast-MFC-AGG-ID: dIRlE2sRMPipHYV3Q8vjww_1785409331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47eaa4006a1so371538f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785409331; x=1786014131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
        b=juxbA9z6XqwaJNCKcoJ9uv4M1IVgCjDc0YXm8yxZ2l3vGHwftQxeCCkM0uoX6pxUbV
         k5Dhn73wHJGdoRAmhvE5azNSLPVbqAhTWTaLPU9QDdQpxSYIejUPO/jf7O3tn/R+27F9
         1MM0EB9QMF9ljk7hqOYrPMtwTItpVJXfST9Mo7oEhjHnPXtU4FrtKhgYK0labPnXMISq
         9U94puQo7Bgay8+6Tr789dTymCrSXxBF/OIsvIcoex2ugL5a5NstkGLVgv0LVMKcju2C
         HDRpRAP1JAE/pvJysv4ihxXUmGWgtvmH4KF8P/KCy08U/NH32Y5jv6c+DbHvmfq8Eswi
         TSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409331; x=1786014131;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
        b=oy8S2AGGv2WFaHvDnWaaFcY02Y9/IHnz3bUJvrLBCMHP5PY3NrLJb1j9A3LI3Oemsp
         2GknHRCW8SxZwfBDBrqBIHHoTv6V/hMyV25cyQTX5UVte8AGcVFpbmaRgR0CnhJEXiV3
         ggR6pI5byZaL8oL5yfw93E/ECwxa6agX+2pbYN4yQZVdZh4coHRGTmVN/TeO4OKMrvJL
         Rws9S5U0E7zqBEW5PaIMYCLIeWSHjKrHcDpDy8rxCLC0xf32OvgqvMC3uiWeL7k9XndN
         x1SR29xTyWQ1LMoGdMM6aORK9VeSUfZcOfYtk9c/Z60JUagMX66BNRJtdxZER+tx/FeF
         95aw==
X-Forwarded-Encrypted: i=1; AHgh+RrqF1pmdUob+fQ+S0363YAwL6244lkCD/B3IsveCDaJBoWDLokUgJC2sh9cphUMzz5x9N7r0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozYqyAx51MGQFVQwc8ygQKN2DiKnqQfgxk8XYQaxifAZu4u5b
	DBeUMNzitOYwsy9JdrZuME6AcGzDYjGoC2piTmOszf2ITmEf8EUZ/rpChRaMjiiEvIeLRVjlV+6
	dCZlOSfSp0RyZvoehyvJ94w9ZwDq5eoYE0QuHrn31C8lzVC8LMvW1NiY71w==
X-Gm-Gg: AR+sD10NVIZld9cO33CZZHUvfqpZBwuVJ9vuA8Rbk8GamsEzlsWUJS5HYwxqbg06eV8
	zyi369r9nz4ybSoMN8wHj/GxvKIuFt7b6utWSfAOv17np5VqgeC9vjJ/d+zAGEx5e8bFGCNm9rH
	A1kMLZPpgFaeCcyByiAF3Z9KIwN5v8Q6gwNobvy5huw3wNVubcCoPAj+BZHBJC80yaE0oW8wCDh
	Uqg3NTB/NCyhuJxMpBWLwt9jhDRKY6BAKrbTyNr4iBdpRrhBdS2LAUURcihq/KshFjaqyt7xFK+
	NQNu7AA9fauaDR5yv6l0Ls8AMJgToBrVhWR5gzcCk4HON8W+OxH3jEhwFlMCgH6dV56SGfw0UPw
	rdhSeYc/LDTo8OpchN5d1ZDmq8hLUSn9V9YFkqPT1PWsKLappqJYNtDmCACqtlk0gObANni4afs
	L56A==
X-Received: by 2002:a05:6000:469c:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47fc8bcfa1dmr1198746f8f.6.1785409331137;
        Thu, 30 Jul 2026 04:02:11 -0700 (PDT)
X-Received: by 2002:a05:6000:469c:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47fc8bcfa1dmr1198714f8f.6.1785409330584;
        Thu, 30 Jul 2026 04:02:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4817223f8f.27.2026.07.30.04.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:02:10 -0700 (PDT)
Message-ID: <9da84225-3d4c-4dd2-ac77-192ab0f3c03b@redhat.com>
Date: Thu, 30 Jul 2026 13:02:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] liquidio: Fix possible memory leak in
 lio_reset_queues()
To: Jacob Keller <jacob.e.keller@intel.com>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
 <54804d01-9254-4482-a0be-c38c3c6177b8@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <54804d01-9254-4482-a0be-c38c3c6177b8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 12:55 AM, Jacob Keller wrote:
> On 7/27/2026 1:02 AM, Abdun Nihaal wrote:
>> The memory allocated in lio_setup_glists() and setup_rx_oom_poll_fn() is
>> not freed in some of the error paths in lio_reset_queues().
>> Fix that by adding the corresponding free functions to the error paths.
>>
>> Fixes: 4b6e326b2d34 ("liquidio: Per queue oom work queue")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>> ---
>> Compile tested only. Issue found using static analysis.
>>
> 
> Would be nice if we had a reproduction but I suspect this is tricky to
> do without some kind of fault injection.

We are actually requesting such info, especially for patch touching less
active device drivers.

Also sashiko has a bit to say:

https://sashiko.dev/#/patchset/20260727080258.86279-1-nihaal%40cse.iitm.ac.in

/P

