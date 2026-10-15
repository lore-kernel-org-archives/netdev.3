Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD932F39B5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026883; cv=none; b=n+7eydvmC8cHtDPo3uKWeUHkAQHROIR6RQZnUQm1TPGDBy/wuThbMsaVcK/K3AK+hesJOx6jGWsqnnSaVD8mfTIMubuCf/y+BOsBxzUBGX+zHTiAuyh1MnWhv1PlCDzV0k5w71UQrfTE07AccFDkVI+iE+NBtcdFHQTLH2p+wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026883; c=relaxed/simple;
	bh=a0JM3tGonG6TXjE/FanhVttaHvXzL1JEEXBVFVdzvlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzKrJ0G6VfwT1KTV2pA+m2cN9c1WkzNyIp/w0LTyFEHw55rF+HhvGXiKSAWqvb3G9pTliZjRUqrJx/B/fuysNLfqcN4Axm5gLp/168O9ETNmbczS1j9N8bm7yyO83SfX5+2W7meRXD2KZTbcNxzMmlp6YhdkhaH4K0DY4D2+hWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNs6Q0rL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNs6Q0rL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso44171015e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792026880; x=1792631680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TITPVJDihb8Q06oVMdVjVp/hCUi1JQZf8N1TzMREhjc=;
        b=iNs6Q0rLRlUqyPdel4mXa7w3Gsq6fO3j3Hc7vdUgQ1MjqmB5x6j5L5SIbzipUWXZF5
         iU9DYOhOo5HKNID6wiTgLrOZgoYcMliCH0HMpOCuZQMNAMyVSaFdKFyheWyf3ZQwbInU
         B8x+CEOokgbvfHeamkrkTwd5XR6Ajibzu+idWLVPyz1KQfaROp2FkrI4/pLH6V7jJDZR
         TeyXrhIOscmHSIvwT2yEYMcBBoQ8a5WjSsG3N1U0p3z14HzyGVtIPowjyWWVF9cY3N8p
         ozu+iFl0YUJVIBVsJfh+8lSqwtd/2uWhSMm3Gnd1jYJmQx5pd4en2JzSiAZeoGQ6kvo7
         PvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792026880; x=1792631680;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TITPVJDihb8Q06oVMdVjVp/hCUi1JQZf8N1TzMREhjc=;
        b=qzJyZcHLlZ9hED6wqB0g9WRRgKrCtYFnto4LfXicK2d92xlkSzC3kH82AjNkHH2+xF
         SIjtF8lMdO0yCvotZOw7Ruj/dDYepAOIK+PV6zbxKny7c6oC1zZaLg66T9CqyOW3MYjt
         DWRemuD6rE7OY2vyH2nSJynGqZgTc1cyL05oBKAxyGahZL3KIt019be/XV82UdFNPE0D
         aGgemcjsL2awvMZHC7f9fi1ku82QvYDtfm8eaccS2V7WXLsD2rjYA8f8PjWfycFcQKUI
         5XgVBDUZsJBl0XlqVNXtyt6uPg0xeleNgQEwlM2vOJgPUkcL8A+vS083/cuLCAg1rUJZ
         KAMw==
X-Forwarded-Encrypted: i=1; AKwUvBx/3eE11fyX5eFj2tSDt1eMTnYMubQe8WzDBX3NniTM7c9of/ji/TISnGLFDYRj4gwQ0Ut0kXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPRu1zRMD1ffStPd1/43ANulWWT42CqdJI7VGN5JpwxnR8CmL1
	dZmnmNrkVLHf+SDnRayXkAo4qmGwSR4lrfxxmMx/KSFmA9CAqYHjxcEJCYHeZg==
X-Gm-Gg: AYBFou3u/LktLwD/sANdJEYC6COKLSnAaroqPF8hSAlmC6ITDSqZ6YamyUsJCcfmWYM
	S4nwIKxWWtwxvk2fGfpr+bIa3plq7rIlR+UVIgnbild0HrWZoXwczbsEJi4xeuCVjLuf82+LH5B
	nU0D5TxMt6BqhymB/zAUZ6XfT+SFJNsp1i/oy2fBukfj0AbFyN6LV1v74tDWSBgqr48XAXhl95f
	peZbWE4EWCLjuzK2cfm6aeB7QCXg7FIplIJvQHEhkuZxRSoTGlAhdNrjoIxAxZVzBWTe6pI0atz
	dAXE/n7DsB8lE0hDxLI+a7enGzLLD8gC1ZIaP2+IQsbtd0DdHZAXekhQXXjyOqBiZXu7l1OpDa0
	K1SYKBmJ6ydfJ8nIXHwyw05MsvCSWQU0AuVATw9gSjY2cafYW+kom1n3WXO0mxRyXCy3eEe3Vfz
	uHkiu/LOYnGXsKPx+HuRt/3FXJOEKEERoHLumXbJz3ZdNPEA2P4w+4+sm/Yppgtu9xrIE2d/759
	qeSCb+e+ZtzJTb35ssgt/uDOyDLcRsC7dzpTd7LF+MVaB+Kndq3yqsltx7T
X-Received: by 2002:a05:600c:8b0a:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a18e446db6mr326233375e9.1.1792026879579;
        Wed, 14 Oct 2026 18:14:39 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd99e87csm30060215e9.13.2026.10.14.18.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 18:14:39 -0700 (PDT)
Message-ID: <401073e5-6f35-4230-8734-2428e188993f@gmail.com>
Date: Thu, 15 Oct 2026 02:14:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sfc: fix NULL pointer dereference in
 efx_tc_flower_replace_foreign()
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, shda@confident.ru
References: <20261014145800.726-1-rand.sec96@gmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20261014145800.726-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2026 15:58, Rand Deeb wrote:
> efx_tc_flower_replace_foreign() walks the rule's actions with an 'act'
> cursor. After a redirect action it adds the action set to the rule and
> sets the cursor to NULL:
> 
> 	list_add_tail(&act->list, &rule->acts.list);
> 	act = NULL;
> 	if (fa->id == FLOW_ACTION_REDIRECT)
> 		break; /* end of the line */
> 
> The break only leaves the switch statement, so flow_action_for_each()
> carries on with the next action while act is NULL. A following redirect
> or mirred action then does "save = *act", and a following tunnel decap
> action passes act to efx_tc_flower_action_order_ok(), which reads
> act->decap. Both dereference a NULL pointer.
> 
> The loop is missing the check that efx_tc_flower_replace() performs at
> the start of every iteration for the same cursor: reject the rule if an
> action follows a non-pipe action. The foreign variant was added without
> it.
> 
> As a result, a TC flower rule on a tunnel netdevice that redirects to an
> sfc representor and lists another redirect, mirred or tunnel decap
> action after the first redirect causes a kernel NULL pointer
> dereference. It happens in the context of the task adding the filter,
> with efx->tc->mutex held. Adding such a rule requires CAP_NET_ADMIN.
> 
> Add the same check at the top of the action loop in
> efx_tc_flower_replace_foreign(), returning -EINVAL with the same extack
> message as efx_tc_flower_replace(). The release path already copes with
> act being NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 17654d84b47c ("sfc: add offloading of 'foreign' TC (decap) rules")
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>

Diagnosis and fix look correct to me.
Acked-by: Edward Cree <ecree.xilinx@gmail.com>

Sadly I don't have a working ef100 to test this on.
