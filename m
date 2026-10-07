Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720371D5ADE
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404269; cv=none; b=TFs1WT8Tsy08EsQsBkEAP1rYclrMD843MvK4aFunDPxrVBRsFs3ZCAPa4ZEaE1WFeG1AGV3ZiRmOk6No+U7v8cBRxhA38GnpRLOhYi/18pKXl6VUS7UnO41+FLu/tWF6hru+91JflcHhsbuADvDIfdssXnmLgHZ8F/G0wHLQnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404269; c=relaxed/simple;
	bh=f/GwSDcTuNxj6GI0IAdppKyMtlQZ5eLCPoEtFeydlAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwvFa+jCBrmnMsNULgo7Rppi+Jz6F3+ijJ82l3Fq/qDmwtcGO86yfkGRCIamgo3CCGiRt/p5n51AECqDTppCeCfXWTEcDn2diDhT/VAsbcQ5Q9FF/DA8tmQfFlK6MAmwOHq7qA/ADZFKOahidp4QRDd7qAJMtkvMUwKYwjX04tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=yvWFLm0O; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="yvWFLm0O"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-487048857f6so1884740f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1791404267; x=1792009067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpvtus2Gmr8I4a/o4HiiEj3yjRD5bzEOhaip8SrB8nI=;
        b=yvWFLm0ORuyZ9yRXtqUyLnLImvGJu4Qd8Yu4de/2uHI+VAeGV5VtiJ3Q7kMEtMCPkK
         YSfEvepc9vBOk8LWmAm4/PQn5cej606zKCmPFuwXuJgXlWlv/OV8dgJTHhC81OhunJwx
         K5Rs3lcHAcyTAaLm6H2s6gbnD3SEWbmJvTym7NSDqzOkOtSiDsgLDpTspm5H5YfoH8Ya
         blA6YhfbvY+azjKczPEg/T+xAc9wNRohVcwXQH/3Ma0sICEv3IHkhtpZ75vcuPRXRyI7
         ijO25MeyRmzrTUcvDNhXXYYlNsPHwc78/rkS2vPVkt2XxpS05tiOMuikzflEe4OBKsQ/
         ZwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404267; x=1792009067;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpvtus2Gmr8I4a/o4HiiEj3yjRD5bzEOhaip8SrB8nI=;
        b=ptLFq/40BcGfQOWeoFcMlTMI30kmaZQCCXrsoUGAcAflpOATvFi5AQC0jcL9uv5Ea1
         X4aa/WyZeWUqthFpf9NyRjV0z8K3tACQQgGbSZ6qiUiFWSMF2OwTekG1AtcXoZ+SK1E4
         i5g89Tx6FulKOf8lS3Eota3dfwSIEqFy37tQAfVoJO0T/lGmi0EUPfr8vhB4yHgrGIuR
         A85ljd6F7bwgYZjpXR/lH7V6+RMHo+wlG1P1rDdXtJeh8gJtWRoO/0cGf0ROCLNtnnUm
         pWnxmZdnFt4VQB9RkAvWp/P7tVRpVxdaOkf6xt85PsW387bD01uoPz97WVI/z9quCiN6
         2M0w==
X-Gm-Message-State: AFq9FYJ+EIsZWf5OKrGZihjQnIVLJyPzKn/TjO9+D2Joff4diEdoODAM
	q/fPbWpvJmipgZ69p/HvVkdgcFO8+XTHsBheULuwPTZuX0XyhQ4WgkM2T5brW7sPf3E=
X-Gm-Gg: AYBFou1zny1KwsHJGwr76jnhA+SWjsswiIvg7wSW2LkfXboJYnQOEKQOTBKgTxFMrsQ
	mbhc7lIBu7Z9k8AykdrQr8erdnidBgSGgXtgoImYOAkIOIUv8h9bZ6oLWqbje+NRbrtLguIlF1z
	wWrrh0qW99u+tgR7eRbRM7LaIKWmxL2k1gHxOJ4UtlEO2DE47WxWuRj3vLx+AuYLkwFtt/ihkrB
	daCXRh64wPYgOJk4GQy2folxHGyQYuWm54H4mCpW1wrJVWRZUXTeqCuSBOs/4IKE9y4Jo02PSQW
	OEffMp6bu9KEQ91fBSpEl+UyM0DrSM1TOj88UBTTMeOmm1Rtq4h0eaht7X5ICmzr0l6JgvyBJp7
	Ay7rTDduPMe81IEI95CJwe4OaSmEnVtAe/tHwS8djRNOVMIsxou9MJxoXyE6DQgVHzx0Y3DSQlE
	wxaADwZXlaqD7CWu7Ko4UAAVrva1RyVZmNK8X2an6cjd63Ou9BvYzIuYnrOG+AQ3Bq8+v/4VR/3
	o1N8Anfm33NmzpcfMPKmHFCPcVgRhn9kXztXwXj
X-Received: by 2002:a05:6000:41dd:b0:487:27f9:82b with SMTP id ffacd0b85a97d-48c72886689mr6669566f8f.32.1791404266599;
        Wed, 07 Oct 2026 13:17:46 -0700 (PDT)
Received: from [172.16.1.199] ([31.221.81.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1ffd2sm7005500f8f.34.2026.10.07.13.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 13:17:46 -0700 (PDT)
Message-ID: <33f685a9-1140-4b4d-a40d-8250ab93e500@davidwei.uk>
Date: Wed, 7 Oct 2026 21:17:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK
To: Jens Axboe <axboe@kernel.dk>, hengyul@cs.unc.edu,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261006125732.3425762-1-hengyul@cs.unc.edu>
 <01d75013-9eae-4ec6-93b5-cc1b2b83b791@kernel.dk>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <01d75013-9eae-4ec6-93b5-cc1b2b83b791@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-06 16:59, Jens Axboe wrote:
> On 10/6/26 6:57 AM, hengyul@cs.unc.edu wrote:
>> From: Hengyu Liang <hengyul@cs.unc.edu>
>>
>> Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
>> 81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
>> allocate the rings with io_create_region().
>>
>> However, io_create_region() charges the memory to RLIMIT_MEMLOCK, and
>> the rings had been exempt from that limit since commit 26bfa89e25f4
>> ("io_uring: place ring SQ/CQ arrays under memcg memory limits"). As of
>> now, a user without CAP_IPC_LOCK gets ENOMEM from io_uring_setup() when
>> their rings exceed the limit, which is 8 MiB by default. PostgreSQL
>> developers have already hit this in their io_uring tests [1].
>>
>> The issue can be reproduced with a simple liburing program, run as an
>> unprivileged user:
>>
>>      #include <liburing.h>
>>      #include <stdio.h>
>>
>>      int main(void)
>>      {
>>              static struct io_uring ring[64];
>>              int i;
>>
>>              for (i = 0; i < 64; i++)
>>                      if (io_uring_queue_init(4096, &ring[i], 0) < 0)
>>                              break;
>>              printf("%d rings\n", i);
>>              return 0;
>>      }
>>
>> Before those commits (v6.13), it prints "64 rings". After those commits
>> (v6.14), it prints "21 rings".
>>
>> This patch makes io_create_region() take the user to charge, and passes
>> no user for the SQ/CQ rings.
> 
> Agree that this is a bug, stricter accounting may break use cases.
> However, I think we can solve this simpler, and actually kill more code.
> How about something like the below instead? Only apply accounting to
> user backed memory, which is how it used to work too. Would be great if
> you could take a look and also run your test case against it.

Tested in a VM and confirmed that with the patch below the reproducer
correctly allocates all 64 w/ a 8 MB RLIMIT_MEMLOCK.

This change is really helpful for me as well, thank you for addressing
this Hengyu.
