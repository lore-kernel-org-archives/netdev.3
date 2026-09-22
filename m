Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC94F7CC2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073898; cv=none; b=W+8fvbnB3u3GpEiV4wFLHRzdjG9HK+mET5mRUwp11Co5Yzpx7WSyPqofioDh+Fkl85qBSc7fjmyMZrKXSQ0wp/MzNhmV6RQzmN9lY0dHyzJSng0Rk15UOdc6U5AhzzRz36d2eIusnTAf1ZnmGP6rkZHhSQiot2wlj9Dj8XR0dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073898; c=relaxed/simple;
	bh=cxh/2QahMdTMrSn/S9/tFLpxWD7uh+KmEFc1Vey3WJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II1SPrBIEHc1TZi+R4ZXkqA+EJ0rhXGJX0j8Pqb9vUrKpQbE8HMtPyjqcbJkMRSoHyWEXYAtOmzh74273xt7Sz/WlxiF/CInIH6bpMAwl2Cfm9MZmD3L0icW0Y4CL04PdkOGFuS0pwtUvzDjZMOTZat2jLZXxGUtfYh+krydmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHfQajuv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=exIzAIIC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHfQajuv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="exIzAIIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790073896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ei08eeL/NcpLae0J6M0HY6w13WSG9UITooaK8YczBr4=;
	b=AHfQajuvTdrH6Yictc2xVfFD9OanTtxUNZB6uWPIwRuTuUEO3uoGo7Y9zXA9bxP3ZVgg5U
	qdLGY8onDFB7uP8FdKd9ibePR+anqZ7iLh1QUKiDNjT0FBv3d7+1mCE/NhS9cbHF0AESsa
	CAQ26BjnT9QK2/vmLKNPV79YFAMnlWM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-E3zQkay9OW6Ft0ZZzZUZoQ-1; Tue, 22 Sep 2026 06:44:54 -0400
X-MC-Unique: E3zQkay9OW6Ft0ZZzZUZoQ-1
X-Mimecast-MFC-AGG-ID: E3zQkay9OW6Ft0ZZzZUZoQ_1790073893
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4886448d257so204552f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790073893; x=1790678693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ei08eeL/NcpLae0J6M0HY6w13WSG9UITooaK8YczBr4=;
        b=exIzAIICUOUq8mLI87J6GGuAHjfauxOS87av0bbdRDqk65VQsVjWiPLD425C8qCdOp
         +wVRxPAcF8/v1w5nvCU4y3hCVn/04iEFtr7VZq9Vet41CZf3Wx1uwNX21dpIXOopgd5+
         HIuHEHLUn/Vhvw1X4UUrMQvgKDfQrCvM3IHQTTS1G5vBiPYphQuZUhiPZvQzXTmWJ3zB
         E6z7kdPxmfNzqifwC1epTwy7X4mK6bCh8r1T6XzcPFNB43YR2Z9mtzV9s5D4YQFv6wFX
         9AhoBmxm0LLpyzWunrRlTecDiM7s9eg8q7peFXCcnbGbvoxxTQFdO05o9GyszTUUBkUW
         3MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790073893; x=1790678693;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ei08eeL/NcpLae0J6M0HY6w13WSG9UITooaK8YczBr4=;
        b=Fr25cHZ/o3ItyJVuaOwHVE86/jfucA43v3i+lFZCVyJaYgl+C4ZkDKoW8iUZp4r3c0
         zPH+AhulbWffwRBtr+zgB5ZT2P4C5SjLL68E/oPu1aAaMxcFHNLUdCGh98Ex4XAl6LFp
         vduZgIU62rgPUQaBSI0Kicd9gBUdPUm9sb43kEzF8UjJfcXAg2CZYYKpLTNzNeU5pSyP
         bX1/C5IXXB/PdqDKwfWAIdK9RJLluv+RHycWNYIisOifgA+KxPAjrgkqYZRZo0/nMok3
         SzHNByaxZ9xzhVoQpIuhTrPThkiTRP/La5ZkeMZgIwH8AjxqSvKacECYzEVFX1aI3WiF
         7uGg==
X-Forwarded-Encrypted: i=1; AKwUvBw/8nFXDqHT1c8ih/Mkrgufn1SbJojn+WesLMU0EtAW9sG/UUViPgItcnbjvvaDUd00Ja42H3I=@vger.kernel.org
X-Gm-Message-State: AFuF++lY5cPDfI9JyPZTf1CjY3jpZAiAEPtmnlFQfQIKaF0gGlA2DFGM
	RKRT5KsiEF0f0yvdyWWOjdYkPmy2XU6/ec7VlF8owd3GDlVEKEowbaMxctV64hf5ZxeKJJzUKfP
	fuXsmpG8QM+uQWsftwtnLwQzkc50ydzcbQTqIg2cCW3fgdTnUOZDtiPOFvw==
X-Gm-Gg: AYBFou0CeOEYCR4PNKODq/mrN4AdzCzUR+iR8xplvlEDTKPH/TDCFlHTsDPCVWoEzvl
	IHsB07DK9biD0obuc4ekNimh9pzV4I94NPaQv+M3n/Fe8RiOmtecpVnOURtSmJo0iyLTxg0I20B
	gE+Q2m0E5u/Jqf5IS0f2+w1s04N0OCABi51Ozr+SU0ghegfoUXCkYC6mWNJBy9yo/Ky0s9tkegj
	UuWlFolfoN9kq1+YSjM9jJ0SogbbTMBEAZmRYMFkZUi9wtMSOHw0bwYzjxu6G3OFbXWwTyzGUBa
	QtgSYhd15u7P5hwxgbra/ztBr8bIoqkYfGODcy2tCrB6gwHtE9WMWqvennKW0uAk+gngJnCKQl3
	YyHDaRg3a3pUDP7WWcMnN11JgxdD2CR5DqJARjhozS9GScWag0MVP9n251LSfEeF84B3MrwR5uw
	==
X-Received: by 2002:a05:6000:220e:b0:487:c43:e577 with SMTP id ffacd0b85a97d-4871e217efcmr19509922f8f.24.1790073893503;
        Tue, 22 Sep 2026 03:44:53 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:487:c43:e577 with SMTP id ffacd0b85a97d-4871e217efcmr19509894f8f.24.1790073893140;
        Tue, 22 Sep 2026 03:44:53 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862774543sm4571801f8f.11.2026.09.22.03.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 03:44:52 -0700 (PDT)
Message-ID: <4c83e630-4293-42ac-8ce7-d6abd5cf5b17@redhat.com>
Date: Tue, 22 Sep 2026 12:44:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] net/mlx5e: Fix offload lifetime, cleanup and
 exclusion bugs
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Boris Pismenny <borisp@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Emeel Hakim <ehakim@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, Lior Nahmanson <liorna@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Roi Dayan <roid@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20260917175433.4090878-1-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260917175433.4090878-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 19:54, Tariq Toukan wrote:
> This series by Cosmin fixes several mlx5e offload issues:
> 
> - Block eswitch mode changes before accessing the IPsec context during
>    policy and SA creation.
> - Tie TC eswitch and IPsec-blocking references to flow destruction,
>    covering bulk cleanup and flows with outstanding references.
> - Track MACsec hardware-object ownership explicitly and delete remaining
>    SecYs during driver cleanup.
> - Serialize TC/IPsec exclusion counters with a dedicated mutex.
> - Prevent SHAMPO from merging PSP packets.
Some of the clashiko findings look both legit and relevant to me.

Friendly reminder that you are expected to address them on the ML.

/P

