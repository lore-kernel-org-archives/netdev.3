Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263941;
	b=aDwJFDvjOvUe8cg88Hp3UzK+2Ox0i7Amxtx3gSqF+NbPbtsuTLAQouOJ8So2YKXLXuXC
	 Y2fyzNVUUPi2q0i0nKIzFpSPlrgzUugE6Wdj+xzke9yswuW32WStgN4wKKy7RmwDgLaqt
	 0sJc7Cgg7Lko10DLOTHYnwXeiYsl76WEkO+cbTep+/AQyHLgELcgIIysDX7cOpP67ZmMJ
	 6g/hT44G2nOy844Pi6nNK5ehMEF6E/NBHvw/NvqXnylXuKKzg9cj2hvtnROl/zzrbt4ix
	 ze7i66nIKqpzWMdEb2c6qGtDBczZk79p5XlKdDD1tLljB2HkkrRzi3jFqU3+oUO6Zuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
	b=ay8/cc0TOYhFzzS89IKvX80WBEfRv8tM1+E2wClRDn338ORvSYQxjADw7M2aFQY0/FKh
	 QAl0HFwu7AD+vTABFY2ozmPUhLWDXRVKGRYphZDX0HxP/xRIhSjXZc0+cVoKLIQlXmWhI
	 jv1VXfYEXF/CkTppCzTGBLiux408KU91YYZMvgIVuyLB8Fn38LUo8ocfOrg7YxsRZNxGO
	 dW0EzOnusgR0XbPAO4WguQDd7ZXuh3GswY1tG9tdrDbe5EXRopFDW/vUSEOe2xAEP7Gj3
	 Rqvxz0BDdTJnby+DQLn5F+TkwA/871c707fmAfnmUcxkDqgjxBrjQ6jLBLYeEBoHtPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=AZQLynIu;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA443606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA443606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=AZQLynIu
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1350791f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793263939; x=1793868739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
        b=AZQLynIuAkv1ZxUEIzHuGL6g/T1/iI5IrYiMhrg86KmJ+eg4wm+adc7EEryKM518h4
         LYhmDrTLfV+Duya0nPUSKbbJWEax4a9+ivsqC4zX56otSPjtuaYFq81NPMB15xaxizN8
         jBIHJLEwDp68+d0mhgyVv/aBUl8/Pd4FkIbNzYd+M5Zn9e9mfI+9HJJBKZYDtvEMQl5f
         KmJMDHnv8Xdo8BX60M06lwYeHx4//0ikrSPSF0cYLxfavLh0WaHeTbDhL5mM0zJ1MwN2
         PqCfxWnkaJ1InxrdwpmjzRVzz5kx8eQbByzWic7TsHtyzRxczcdCc3GxqdGob6k6Ee22
         20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263939; x=1793868739;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
        b=VGUfgE3kmM/V6CrjkoOjt1VbZ36N/uij8FL9W7JjVWLoWDfsBVb/58A9Uo1mUwYuoi
         PVlqKUp2+An9Dd5K3WJIwDFOBnl24c1IjFLpla54IDlDCdEhSapYgZ7I6S1TdoCoV/vj
         OGlMKErjnSfnfkOQI8jjqYpmQor+AYbgaQxMy1gir/Q0TooqdGelbNTiRzsJYihVfah0
         G1Abjxut+G1/uf3YO3bSu7JBdjfqWEQaYnsU/+W5WMMCyxAk+76FCOG6gEUJ4TDBitny
         tiuM7dk60IeJWgoTy7i0/B8r+DXca8MadN+ccREGs7ZKIq+w6HhaERHtUQ8YuOw1/xLl
         /LAQ==
X-Forwarded-Encrypted: i=1; AKwUvBydltdF1a/InVl/Ak/HT1kUnPbnPK5ga20LGrufiUGOSL9cFWhCgt9f/cV4PIS879T1aEDfVg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxq5WpK4E7VQv/y9cVwVO6GGcp9cfm716jjUMJumCGujDKa6GR
	BvLMkqFCP84SRB/kFRFUW0ghdbBLm9F3eGaGfM5RDpNuSC3AySTouLmwFnFmXcMtjdaLH5axB4s
	h+2KW
X-Gm-Gg: AYBFou2WL/F7sIdXwz1sKNuqqSc/WrCdrGZEjwwuZgboQivb0SdyiIqT4qqNI5Z89Sf
	ond4Dv3cITev1vuzUODrgJArNKbhdY9Q4fnrus9ShMOtaGdnTXVwUMbY7W0TCA2k5h4YXWncJlh
	MnxniGHhNgXoXECcpSTKHygHCdy17x/TG/iAnivGIWSxbyXAWphvQ1MCGaWb31NtWREMmyjRQ1r
	qEa23pdS4LeTPdW3VrAynmqrauqUeOAUZLgFZQ/bNpBlpPC9V7kXfVVw6aPGwOwM8AsD4doWlWI
	QbsTzgm1xXpkxbr0Trr2zqlIDfrlbRkf6jwbcarGJxYhcHOjk5YIsffxsvw/6Mn1+wAvbAXXSHL
	sZAue623Gg6hAsCPQSzaDFRPafhaKrvK6UhDMUsCS6nF6Dq9TSLePQNWQcN2N4MG20efyjS1bjE
	T9KKpA+7tryBmNYEXTrU0vIHGA4bRHezzKCyYpwWvd5V4wf3xXeMaGOb3iikW0clevnDO/JbaPu
	bLN+kwIkOv5to3qO017/ZL/RDm2dNL4JPX0RulX4l9odQKBaSH4HSj1MfVZb+ouZ9RRygJcBWv5
	f5qWl4fwpawtoG0i6JM2OJfjMzj0tQU5cxPtKyr/CCrLtQFFXScCvBE1WDg=
X-Received: by 2002:a05:6000:616:b0:48e:5c60:6a3b with SMTP id ffacd0b85a97d-48e5d5dfd9emr11686469f8f.46.1793263938677;
        Thu, 29 Oct 2026 01:52:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm32992051f8f.4.2026.10.29.01.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:52:17 -0700 (PDT)
Message-ID: <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
Date: Thu, 29 Oct 2026 10:52:15 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring
 transitions
Content-Language: en-US, bg
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 18:47, Baek Kyu, Kim wrote:
> Two CC transition bugs affect CFM receive monitoring. When CC is
> re-enabled with a new interval, the first RX check uses the previous
> interval. After CC is disabled, a received CCM can still change peer
> status even when its RX work cannot be queued.
> 
> Patch 1 stores the new CC configuration before enabling peer RX work.
> Patch 2 keeps RX work disabled while CC is off and skips CCM status
> processing during that time.
> 
> The v1 submission covered the RX work restart. This revision also
> addresses the two review findings. The interval fix is a separate
> patch because it has a distinct failure condition.
> 
> The combined series passed 8 CC interval/transition checks and 3 CCM
> status checks under ARM64 QEMU/KVM with bridge/veth. The CCM status
> test failed 2 of its 3 checks on the v1 image as expected.
> 
> Baek Kyu, Kim (2):
>    bridge: cfm: Store the new CC configuration before enabling peers
>    bridge: cfm: ignore CCM while CC is disabled
> 
>   net/bridge/br_cfm.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> ---
> v1: https://lkml.iu.edu/2610.3/01364.html
> v2:
>    - Add the CC enable interval fix as patch 1/2.
>    - Skip CCM status updates while CC is disabled in patch 2/2.
>    - Retain the RX work disable/enable fix from v1 in patch 2/2.
> 

Hi,
Are you actually using CFM anywhere in production? We have been discussing
deprecating cfm and mrp in the bridge as noone seems interested and they have
proven as sources of bugs over time. These don't seem like critical fixes
so I would target net-next when it opens up.

Cheers,
  Nik

