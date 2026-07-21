Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B22386571
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657232; cv=none; b=BtIq0z0vLtfvT/fvJPLxbhQ4vo3DS2a8bKvX1/YgVniSl/elJnh1Jo+g4Wo5oljFYkXl/jHhk/8Dax68vi2xcEIRI2Eo6jFpo1NoOu+L0HKyoUCP/oZIKCP7XPUOce3IuP1FUwyYnBZLk4u759hMw2ovwRl2MSGRlz3ZmZYtRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657232; c=relaxed/simple;
	bh=9lXSt83zDc2iahpMJgYIEg63ZHtetzR6WzV0wmmwP5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSeDitOisU0cmEI6yjWrCzb9FPjwiV/9p83eUQs/23enSFlB5Tyi5lQVilv6o73XF7/gsIIAwF+RIorQNVqDz2XTeJqyYQ48kRenzk3MzTe48JTfKKVWpW5YTbu18sNBnXbNSzYUZU7h1h+TT5h0PdRkOZ33sYxCMJzuzpka8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Noxphimi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Noxphimi"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efec2c28f8so55397836d6.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784657228; x=1785262028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//omtI2xpVdB5Yf7tp/3B0bE0I7pWALaYODcnC7HZFM=;
        b=NoxphimiB4tD/1Ru6sD+tbGTtk2ULU9MDgefTT8ArJMHkXsNs4PzzJlQYkszHthS5s
         g2cTL6nbWRxJqZRN8MCxIQRDMA9VZbVL85UutsUhAE3zSCO80JcnMl8BLKlMkIlBhNJa
         rBPsOMEIy1OM6drMyQfLfoKBCA1rGb7AV5yEoDW7e8K59IeL7u5Yv8FnQodR9LGM6VHU
         eZnVLF/mjSyndMWrgyaU2PbMvcL6seKzs+UvwTGUGWzoP7gcvdDtoUvazJYVTqqyfItt
         K6q59XMXTV8pIDhIa/mGa6d0gfoyvwBntx5jiRecs6HN+2DGtQnndzTBageNYul2egaf
         eqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657228; x=1785262028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//omtI2xpVdB5Yf7tp/3B0bE0I7pWALaYODcnC7HZFM=;
        b=bCDqAV8tO7+o4lOBdu6PN7OJHs67e2n8Ppu2gyo/EvYPy6fEshu0QugU3ImIdmmP7W
         mN7JlRqls49hklVKLeFskkNsUyoeHAWJ8yHeinHf7kmxSapHqeg9UBMuKFOtCCqzHYkx
         3A5hVvQzJ4PoSPyubN6t2CpEH3RsdI4siq0Ds0CJQDsXHPlLDlpejVXLb3jUyo+uzkip
         wXRXJA5cekpE4uh5tCDvuhOEy5nNSzELsyGxB3H2bJQtdER2i3QqyQccAiphDhcXReyG
         0FLfjc5SeNw0xK7D+c5KLItW/XpwGQ0tx124T0+ssG60AAUI8eGMMHwAMx0bO8AjWX11
         LEYA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8aXHYbcl24tnTepE9jNGgFbEYi0OSLBPdguW4pdBArHCkNq+zoAVOMmhqgOhgvjCWspT9TAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgjy9QsD/BlXP81CYJDJX4xxROLXC4fKlL/p1DXg2sU/W3gXcH
	yzRDMLULNT09kCBKhXc2AR5YAegrCnyZ25EkkOTiSzO3z0kh/QNPjmFf
X-Gm-Gg: AR+sD12ZHIxoSLC7OsQfRp3GQZLTjovHDbR4bu+Io7mI05NkVp83tFqCFWkeL8Cs5Y4
	WXaWqwLEvwSgHuX8rhCPqAwjqZJj085k8jm0Rs7mtUdlAe1I/+v1seCyOS4SZW5tYOnaIgGZTa1
	4uHM75LRtYQBgPNe3CC/OiVtCQ6Kd1XVGLO9Cm7w0CR+dqvSEYPgErtVQfENEFhpvIaZa5IhbCU
	YhOgCtSbYB8JEag/xPU5gHIPuhjfK3x21dOpgsbEVZlbR6HuabO9yQPC9PmJZOSqzVLbZkHYDOo
	+LK0YacVspdhEHnKapMMsaR+d7K8xw5DfBYEpBOiIVAnyhFDgGic+aC4iGQgu8K5P6aRcSch7M+
	xO3dySvrxKtOW89XNnmTx4CLgNux0Rge1ovsXkroLabI/Fc7NTxFll7UNQF8em97XVpaqw7unis
	hbzrQRMAYGyp3vcieZ0g5/QGjBnIM1JA==
X-Received: by 2002:a05:6214:301d:b0:8ef:a4d5:1523 with SMTP id 6a1803df08f44-907783b31d6mr217236786d6.42.1784657228144;
        Tue, 21 Jul 2026 11:07:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:3aa6:65e3:232d:4717? ([2620:10d:c091:500::571])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9e1ad3sm1710816d6.29.2026.07.21.11.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:07:07 -0700 (PDT)
Message-ID: <7fd2e4f3-ccfe-4e09-8f24-8dcf89b4774d@gmail.com>
Date: Tue, 21 Jul 2026 14:07:06 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] nfc: digital: fix use-after-free in
 nfc_digital_unregister_device()
To: Weiming Shi <bestswngs@gmail.com>, David Heidelberg <david@ixit.cz>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260721163632.1570651-1-bestswngs@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260721163632.1570651-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/26 12:36 PM, Weiming Shi wrote:
> nfc_digital_unregister_device() cancels cmd_work and cmd_complete_work
> once each and then frees the command queue.  The two works re-arm each
> other: digital_wq_cmd_complete() ends with schedule_work(&ddev->cmd_work),
> and digital_wq_cmd() hands a command to the driver whose asynchronous
> completion schedules cmd_complete_work.  cancel_work_sync() only waits for
> the instance it cancels; it does not stop the work from being queued again.
> A work re-armed after its cancel_work_sync() therefore runs concurrently
> with the cmd_queue cleanup and dereferences a digital_cmd the cleanup has
> already freed.  digital_wq_cmd() widens the window by dropping cmd_lock
> before using the command it took from the queue, while the cleanup loop
> frees the commands without holding cmd_lock.
> 
> It is reproducible with the software NFC simulator (CONFIG_NFC_SIM): start
> an NFC-DEP exchange between the two nfcsim devices and unload the module
> while it is running.
> 
>   BUG: KASAN: slab-use-after-free in digital_wq_cmd (net/nfc/digital_core.c:174)
>   Read of size 1 by task kworker/1:5
>   Workqueue: events digital_wq_cmd
>    digital_wq_cmd (net/nfc/digital_core.c:174)
>    process_one_work
>    worker_thread
>    kthread
> 
>   Allocated by task 5124:
>    digital_send_cmd (net/nfc/digital_core.c:234)
>    digital_in_send_sdd_req
>    digital_in_recv_sens_res
>    digital_wq_cmd_complete (net/nfc/digital_core.c:134)
> 
>   Freed by task 4994:
>    kfree
>    nfc_digital_unregister_device (net/nfc/digital_core.c:859)
>    nfcsim_device_free [nfcsim]
>    nfcsim_exit [nfcsim]
>    __do_sys_delete_module
> 
> Use disable_work_sync() instead of cancel_work_sync() for the two command
> works.  disable_work_sync() cancels the work and disables it, so any later
> schedule_work() -- whether from the sibling work re-arming it or from the
> driver's completion callback -- becomes a no-op.  Once both works are
> disabled no work can run, and the cleanup loop frees the queue with no work
> able to reach a freed command.
> 
> Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")

Fix for this commit should target the net tree instead of net-next.

> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/nfc/digital_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
> index 7cb1e6aaae90..6def5132a4a6 100644
> --- a/net/nfc/digital_core.c
> +++ b/net/nfc/digital_core.c
> @@ -843,8 +843,8 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
>   	mutex_unlock(&ddev->poll_lock);
>   
>   	cancel_delayed_work_sync(&ddev->poll_work);
> -	cancel_work_sync(&ddev->cmd_work);
> -	cancel_work_sync(&ddev->cmd_complete_work);
> +	disable_work_sync(&ddev->cmd_work);
> +	disable_work_sync(&ddev->cmd_complete_work);
>   
>   	list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
>   		list_del(&cmd->queue);
> 
> base-commit: d4932951a19a5f1ec93200260b85e1a4c080ff77

