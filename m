Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E07402442
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518489; cv=none; b=nXPb1UOP4aXsC5i1z6jrvemJPnreu9jlEaEvXWOQDAjNWEiy3TYhc0RZi0ZbNOByhRP9EFze9Rwq6yp8edisbzkjSCdQyVr22FpeQNt+grzb+aoa7jPHcpnXt+nO0Gl1IxdslnO7cssgGSAO79aG2iKF9LoxnVXag9aXj5uaGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518489; c=relaxed/simple;
	bh=VbrujYzk/Kt70jnqfCTt3NCF2m9icQA5HNmlxNrUsQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgKHL2tu1w7AUiFE+dT5rgckflIjZXHYq4OVoB0yDvRCAk90xbhLgqzcVKiIQZ38vUn4GvrHuXrAaMpG6NNC9qiPo3y4addZFm2envvmkO8pYS35aKLcHNov0tDxZWgG9pFqgQtgfvslyfHA5kPzJ3DVpjaLqaz/JxUkjAckNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHOEZZzK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOEZZzK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso31617205e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780518486; x=1781123286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+DWIlNIG3f/eL+eaLnXdVcfcuXoaF88jz/IhoI85/U=;
        b=CHOEZZzKh/kIWSO8ag6/NEHYEZAsMLWLzNjK+aQHlKNiG7ts0jAMGjwcbiJspYkZ+H
         m/iCCOQE89kptvQXUe+EFvY/EICBc54nEkcIEcJ5FOB0uHDYi+tTJiycxj+mMMfzKlfd
         mpDi1Zfjmg1SJrGI+cd43T4Px6RW+K7KuYQkd1jCfF2q2yPL5+ORdB+TURQ60J+HCy4F
         e2EXup9KDtEz4AjCy+nqPFQL2EZtA5zHIPuGjK16UVEuLs4xSLeZg4KTwpkJI2RlLSko
         yU53aT6xw02o8zPg2v36lS4ZoCpUSEf6cMbdnhJC2Y4GtMTDpCwiiNYROBdYRE33paID
         WSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780518486; x=1781123286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+DWIlNIG3f/eL+eaLnXdVcfcuXoaF88jz/IhoI85/U=;
        b=I6ea//SZCuIlq/GgSbEXkktkJU0U8SSBMfjfpS9Y/nnzjXS+xTBS75FUK+IgsHnjC5
         LsLG0fLGQUK4l9Vbb8eZXZ6VtXXMgWywqdjcBIDyAzHIBz2Mp20GIAKUqJRYnMMxsyA8
         o2OWX6rPkVkdjU1yGSqqvf8/HS8OuDHjjLf2gcV46/umZEI67JGXH/Eku28fEhH4+0I9
         nxdX0Asw58FE2uJW4uiJ9jqdlpXA/Rtqkpj/jUL69eRb4D0BYDZ058xVL4VQePPUvWvm
         B05SdrMbllEXZ6i0VJ/LsZ+yljGskTBn8EcRyQQGZKyMaXnp1ZHfOPmqxu8GDOsI76I/
         r2wg==
X-Gm-Message-State: AOJu0Yxzixwe+NnvVdMN02LsWboKzYUDOBVXDzIhzdPhGnP/anTn/ct6
	FMSgoEUQS6edkORqKDEIxV9q2k+pYUWJbGAP5tWBVeYyFqV4t6XNMkzo
X-Gm-Gg: Acq92OGkwrptJwe1LOpLFdNpkOzWZqGfhcgEgrkIT11Gj0VyflmynXuOFBGUfI//T+/
	+y9oRofcVu8U3tLTTiOu9Z/IWRcIERHVuHCb0/GSGDz6UPCMYAaWomdZtYcC/KyYCZz888qQVVY
	TtZoilQUY/xB5P0+mpLLsxCE1Jy1Aj5NQxxd6xLoVmyCC7DKepH9YmicKoQVNTJmqNIkCtocitw
	HA1iHfiQAHN3MZWAln9+Khpq3Q3VR8+7DHGihRIWHCfJIziqeIsswnnNWvfu7C8iufqVqx/6DAI
	OQPBBpTU6kdCPWlXMLAujoJgaGGu1Sbnp8dxdp871iRE3b1pEtY6+jAIAz4bSTrOwRcIVPrrXHq
	BV6BhLdT/y8UBH/HMXRQRMv3h0fuvQh+7FNsr09778n65q2/KEiEp5ZihXf3tRf+50OccpYo6xB
	/zrPHmXNLlbCSeyi8wnbuvRO0aTzvfX2pCLpASB/5gFHKoPyQ3CEvYg0t/asJgG1+8HbD2PEs/C
	SRk8aN3p/yt7xED26seu7ld
X-Received: by 2002:a05:600c:19cd:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-490b5e9fc71mr84945695e9.5.1780518486086;
        Wed, 03 Jun 2026 13:28:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a8632sm27996995e9.8.2026.06.03.13.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:28:04 -0700 (PDT)
Message-ID: <74e6932f-a755-4931-8d4d-0025826a5502@gmail.com>
Date: Wed, 3 Jun 2026 21:28:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
To: Jakub Kicinski <kuba@kernel.org>, Gui-Dong Han <hanguidong02@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, baijiaju1990@gmail.com
References: <20260528092838.2099352-1-hanguidong02@gmail.com>
 <20260603112035.0866d7d4@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260603112035.0866d7d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2026 19:20, Jakub Kicinski wrote:
> On Thu, 28 May 2026 17:28:38 +0800 Gui-Dong Han wrote:
>> Use release stores when updating the gate and acquire loads in interrupt
>> handlers before touching channels. Keep the existing smp_wmb() after gate
>> updates, preserving the current ordering with event queue start and stop.
> 
> Why are you keeping the smp_wmb() tho? You don't have to repeat what
> the patch does. The goal of the commit message is to explain the why.
> 
> Ed, WDYT?

I think... that my head hurts from trying to understand this.
What I particularly don't understand is why it wouldn't suffice to just
 put smp_rmb() after every read of irq_soft_enabled, pairing with the
 existing smp_wmb().
And, conversely, why any of this works at all — what stops an interrupt
 handler passing the gate, because the write to irq_soft_enabled has
 propagated to its CPU, but the writes to channel pointers haven't?
 Naïvely I'd expect the smp_wmb() in efx_soft_enable_interrupts() to
 come _before_ the write to irq_soft_enabled.
(The smp_wmb() in efx_soft_disable_interrupts(), I'm not sure exactly
 what that pairs with, since the ordering that matters there is between
 the irq_soft_enabled=false write and the synchronize_irq().)

Anyway, this code predates my involvement with sfc and I've never had
 to touch it, so frankly I don't know any more here than anyone else,
 and if a memory-models expert reviews it and says 'this is needed and
 correct', that would mean more than a review tag from me.
That's not a cop-out "I won't review this", rather I'm saying that if
 Gui-Dong can't convince me because I'm too dumb, but can convince you,
 then you don't need to wait for me to show up and add my tag.

-ed
