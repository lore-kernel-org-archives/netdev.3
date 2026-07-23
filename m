Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05397379960
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796464; cv=none; b=EEZcdy2CrxYrZ9ky33ds8ZRhoTMlNwbH345m7WMuWmyhAD4vDpaBMyqKCDRJY3378pn+/sWSj+mDCL13oI4VP7NEiIgY2CE0U61tkZ35chs2b4kJuVsvftbLrDngz0QB8qGEHSmu9eQnT0yxf2TtPlHCwFdzPOxQ7MCr/cu6xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796464; c=relaxed/simple;
	bh=wJnYAeDJFcg7z47AiP2il6dpStvlAZdRAAiKPf2MdJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9Urucz91dQtQ8ltqUW6M+zmU870HPPnuZ1d8PtwBnLWBBYDF9ZQIp9+Z2fngDy/JguQJHAcCCX8/QkdLIpM0B/k8HHMrF3YCmbLgcEqhMmJ/dIzfAGshGDnuUVKy3OtjJD8QcM/3oUD8DlO6JEyGI8ia7QVQ0ObXr5ME8uevy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaAj+qii; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZlLvRIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaAj+qii";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZlLvRIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784796461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIn+hZ1YS4Hl1t0phWXq7iBXtPH0Wl15h+2OOcDUJZ8=;
	b=RaAj+qiir55IL+bW5hJoPNwW02QK40PQVtTv8GrY9WAoi+Qkl4hh+0yDpoNoocV/TXlfUX
	dbvj54O6j9IH2xsdwMV2upX8kN0EQ/VAn7/i4oFDD5w3z4dc8rnjb0Pc06vZ2c+BbnHRHl
	LPmag05WbphabtOkjkVKBRqTSuXBk38=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-pmEH3PbiNKCxxcz9B-BFsQ-1; Thu, 23 Jul 2026 04:47:40 -0400
X-MC-Unique: pmEH3PbiNKCxxcz9B-BFsQ-1
X-Mimecast-MFC-AGG-ID: pmEH3PbiNKCxxcz9B-BFsQ_1784796459
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so4181585e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784796459; x=1785401259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIn+hZ1YS4Hl1t0phWXq7iBXtPH0Wl15h+2OOcDUJZ8=;
        b=IZlLvRIPkstPBElfWAsB2x/LTanUdY+4A1/KQCfQR6QZDKgXqa2zLR51liuNp2V2Mi
         MY4+rPnEBvCh7VWjycHl0km9i/x+InIklOMxxXpVBIoJ2f42d5uAtnjs/rvmJ7gmySKB
         nXZbga1Sl1F6cx4wU8gzQlBUDZGBQAB3zpyngKTyT2HodXzP4EEsLq+Uk6Nrgy1oWxhn
         tZpWhN5kADrslUzGStkr2YlkTFboiWBRSW+xaTkNnx0YU82sBoD8ib9T/7vYaiGsLw++
         zkC1QCk/IgvvSh3t+ciQ4xgQ2k4RzXlAhqJnkOY0tuQZxtpUONedT/BQrUIdElVNq04l
         Eggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784796459; x=1785401259;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIn+hZ1YS4Hl1t0phWXq7iBXtPH0Wl15h+2OOcDUJZ8=;
        b=FF3lpMbVhD1OzqJdxtv+4QOjR3fe47yLULWObXG7oL4A+bWCQ5aft//w9ef+HhXaaf
         4x7+KxU+5FepEkLEI1SD3mhThIQjbUy7xtZNtUrzndaLgWbQD1Kk8d8xTK22ViPKgunE
         o0+kyLvzVRTDGekEyrCNMC0NeDjGmUJxb0DGBX8+sWF8vH4JzOe1znZT9yceRdzoElY0
         o6yBdeSp4nLkwQleAWJOBJxcoD9V3GovFMzz8DihhPaMG3xImIHkV5eOI0Rd3Qs/aFMw
         ot+zYSfv/N7GSoW+MixEI9atevDP4c0Sg9bacjJm+DFtkXn9m0HG+71wbVdv4MgR/XMm
         GURw==
X-Forwarded-Encrypted: i=1; AHgh+Rpuou812HCdRiHLEGFX8E/w2f+LATbQK06LcBsKo+KqEXYSZCRuwesxgOJlHNH040xqGvkuUOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Y0fhsrEiFvmX8QaPn8bpbcN6xTw1+L1pMFpWyq4aZq0yDv4+
	rfqc+ZgWt7lyhnJT8/jd3EXVdLw/DWS6ioC1ta0VdAIP/zYNUbh3YHzRR/ncnoKFae2DwTxS9Zr
	yDR55w3RzzONUSO/itCitvNs7l8S9UquUP9MOBi4H4KxKRmO0YbVqRppa/Q==
X-Gm-Gg: AR+sD13EpJAviahPr35zYDlDg7lsfjZWcVG/Ve4m0nUXvBnwpmji/vBT1oFx1BVHEXr
	p4Op19BSP33kSpEmvlESGzm1A3iBX4h8OnXcOJqZs2EfCzOrDa9LsUjMOE+K4vLvdy++K2oP4JM
	olF53hbKMI1szhB18jhLn7w8iyUhEP7PD//Nrype7S/lTHwWZhMC3ke53C1OrMJiKJA1tvj6e+K
	OWa5aMHAjU5fKJfUYw3Tj4m4ahApPT4gYEgYsPp7v368ShADTljy9gD0meAUrP/FQsT60XkYy/y
	ebwmYzeLfMFQueFznKtnAmNbrp8xjoNYRO+sH6/6fnI1zQaVqczmgEdWa9Dwm/fXlJOuXl4JqAZ
	wk6j7NmJrjwCNU7enPVWPDi14moI3E7gAsEqObgPFJDpxkUIdoyjOrYuu3GP+B4o5en25n/DdUx
	/hfw==
X-Received: by 2002:a05:600c:8b4c:b0:495:472c:208d with SMTP id 5b1f17b1804b1-49573d25e87mr20143375e9.38.1784796458913;
        Thu, 23 Jul 2026 01:47:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4c:b0:495:472c:208d with SMTP id 5b1f17b1804b1-49573d25e87mr20143065e9.38.1784796458444;
        Thu, 23 Jul 2026 01:47:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49574653f83sm22339255e9.0.2026.07.23.01.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 01:47:37 -0700 (PDT)
Message-ID: <e8829e6d-977b-4aa5-b823-9bb723219746@redhat.com>
Date: Thu, 23 Jul 2026 10:47:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/9] tls: add TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 leon@kernel.org, andrew.gospodarek@broadcom.com
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
 <20260709205325.1591196-4-rjethwani@purestorage.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709205325.1591196-4-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 10:53 PM, Rishikesh Jethwani wrote:
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 8c588cdab733..c4c15c0e731a 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -714,49 +714,64 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  	}
>  
>  	if (tx) {
> -		rc = tls_set_device_offload(sk);
> -		conf = TLS_HW;
> -		if (!rc) {
> -			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
> -			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> -		} else {
> -			rc = tls_set_sw_offload(sk, 1,
> -						update ? crypto_info : NULL);
> -			if (rc)
> -				goto err_crypto_info;
> -
> -			if (update) {
> -				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> -			} else {
> -				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
> -				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
> +		if (update && ctx->tx_conf == TLS_HW) {
> +			rc = -EOPNOTSUPP;
> +			goto err_crypto_info;
> +		}
> +
> +		if (!update) {
> +			rc = tls_set_device_offload(sk);

This largish chunk changes the whole logic beyond offload update for
_both_ TLS 1.2 and 1.3 with no obvious reasons and no explaination at
all, nor in form of code comments nor in the commit message.

Among other things,  tls_set_device_offload() is now called
conditionally. Is that an optimization? Was the call really unneeded
even before to this patch? At very least such change should be in a
separate patch, which reasonable documentation/explaination.

/P

