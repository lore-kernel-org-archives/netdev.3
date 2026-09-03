Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16047426F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428264; cv=none; b=dx2q7etRF6qdujuImCsL0XwZ6P9kmbnNFAWmuYNu/OH0uDau5lZl3PZStTwBpuV2g4KnVfCppTUUMLbx1NXaL960MuPYENzdqIi1lF9QpXHHfIhS8xryAiM4CtppJHRPRmtYBlwR7ZgynXKR42vaGoaI9oVgyemX4Ha4GNGffqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428264; c=relaxed/simple;
	bh=AgOOQ/X8FuhHbRJqDZqNm6FH9w9WhULgA91rRXqTtc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6WrFjFfUcOYd3391+1n6UlOMgOEs9u7qWEGZO7g96+iu4UmFGMJxQHe29TJT3+1dSm5FBotnKZcDb7FCRoGqcOPrW8lIA6SaPjIESAFNusNSPjYrFg7PruslFpTtMoh5pOxpCQFb3hlMY1vWCGgw20pAknIyauCRsEIFsf+8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/xcly+0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7CPT5Wa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/xcly+0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7CPT5Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788428261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqyLfPimaSH505OA2sugMY0JdybunaldflNnBPDaYSM=;
	b=D/xcly+0tya+KOWuZJJNTSevmybuiWxJKWUGBlQt6WMDIkW74Ue2iJH2MaZ7GdqhYoEg0/
	EPYoiipY1sL0YQ6KDLVXRL5R9Ekf9ATbK+JBND8OLQzgevGE9Nut4QMf2hSptF9xYdZ7kV
	aJuRQvVTPytcW2xqhztP4GvPH9pSwZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-90UBShFDPg289cztXVoz6Q-1; Thu, 03 Sep 2026 05:37:37 -0400
X-MC-Unique: 90UBShFDPg289cztXVoz6Q-1
X-Mimecast-MFC-AGG-ID: 90UBShFDPg289cztXVoz6Q_1788428256
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so18652635e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788428256; x=1789033056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqyLfPimaSH505OA2sugMY0JdybunaldflNnBPDaYSM=;
        b=N7CPT5Watp6i9uSYGFDRuQD4VrZiilmfeRRuGzbmtQa2ZVRwtcRxhxgJxvs+AIDuh5
         jZObeFqSQuozTkdvGYsTeCO3RMgdQa+4ECB9/EOkSeusY7XVKGwlUhi5dG8V4vLGX4IC
         wxomQQbgaCpZIJGskjHp0vLFZc1OCkZeTSMIiUb0Bpksz3U5hl6ItsLG3PdYinWRL9Yc
         rT7UKExQ0TaP7td6p/9mK6QzXzoPu82b3hNMhLVF+0pG5yeIEKkv8bpcAirUTYYu43xq
         tZeYeAYJDeOGTmKC4cQf+uYRhg4aQkaNDl0Is1DfdgXorKvhySqoP3LmrCCzny6ffApX
         /yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428256; x=1789033056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqyLfPimaSH505OA2sugMY0JdybunaldflNnBPDaYSM=;
        b=cIt5RxfZ8qf0mE3w0eDFsSwCfzRsu6IWyM/QPWxz5bEvkEsKojkxEd5GR0omX/pvIG
         NqgriyTORhaN0+tJUNzq/EAO9rNI8iF8a8GDMkBhy7MT6Ng0SoHXqVc1b1jotxOPJg0X
         ZvuzSo8idR18uFt6kNq1qR9xOtwCJ6ECRb7wXpoylQtyp1FsogTj4yye5P6bZSuJQ18D
         GK1Mnlo7AughzDqBnBvQ/Eq564+3gmjGf9dP7DfU49NGyshxigDa+TiMEPt1ZsNq1Lyz
         socLXHd4YHyU/dNf25VH6EwA2SDax+8vB660N/opj/lz1ptJwrXEXg5mnSvzfpOimu25
         buag==
X-Forwarded-Encrypted: i=1; AKwUvBwO+lRv7o54ETGSZK7JJwyNdlcN+yVnrJwhUOhh0Vl3jTMif1uverivNtojy5bhLOUI6gEnQrk=@vger.kernel.org
X-Gm-Message-State: AFuF++nUhBbcC5Ns3meVmmcGj0ky0g7WxjT+4MAylxsuVoswnz9cJpWs
	BvQXCeIxTIojh24PhObKSQa1Kuj0SupFNCdbrWxI2IhAVbzyR5gyaK7JX/36bcvnAsXo/wmrFX3
	Z/eSPH7XleObYK2ZjFI+EztJHUsrfX/QRtBMzPMMgZuMXIjsT1BavKtaKmg==
X-Gm-Gg: AYBFou2ljJ+r6gS/zR0+p3L5bGQr7b5hKNHaoBw7EJ/7vDaJkoM225JIQPVEtuVmPNG
	p+jFCXp/yRQot5l37L+N2Gamrv80XOGxwnJH326wInCNxtkaUyjxQi/Flt/zsD4fEjoeDw7/oEl
	adw5lotjX3bZ3OtPyClzNWjvFXGOh4Bkvbnoie+XFVxebn8JLPDDuEtezkczE1U67E+7lqG36Ue
	9Ju26Yf6FwOJlvgL5Vgv9efcv5uSLFpJy6RKLEssY2ebfh9CwxVu70+A2SxKBstC6Jd3rEEWgjp
	s7mAoJfb7eX4aNwiyJvE4IAEd+i09tXfISP8pndqeuYy9yXrixPkDxUprarHW+HVZxbNwwKcbe8
	jWP44yCFq7AswXEp2De4cFqnLkhYk3dE5amIqslcpSUSY83FsnoGe4HrxcIE8/xENoHr2GeVzmw
	==
X-Received: by 2002:a05:600c:8b88:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49ce584b899mr189686185e9.12.1788428256119;
        Thu, 03 Sep 2026 02:37:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b88:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49ce584b899mr189685115e9.12.1788428255660;
        Thu, 03 Sep 2026 02:37:35 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f914bsm68349605e9.3.2026.09.03.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:37:35 -0700 (PDT)
Message-ID: <bb4ae7c9-e705-4eff-9813-065ea4bd9514@redhat.com>
Date: Thu, 3 Sep 2026 11:37:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/6] Fix a variety of TPA bugs
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
 colin.winegarden@broadcom.com, rukhsana.ansari@broadcom.com,
 linux-kernel@vger.kernel.org, raphaelcf@meta.com
References: <20260902015652.2421609-1-joe@dama.to>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 3:56 AM, Joe Damato wrote:
> I am sending this series as an extension to my v4 [1] which was just 1 patch.
> 
> Note that patch 5 of this series can now cause the device to fail closed if
> memory is tight; bnxt_init_nic propagates an error that was previously
> swallowed and fails closed instead of succeeding in a degraded state. If the
> maintainers want the device to come up with a partially populated rx_tpa[],
> then patch 5 can be dropped and this series can still be applied
> and will otherwise work as intended.
> 
> This series addresses a variety of bugs orbiting the TPA code in the bnxt
> driver that Sashiko (or Clashiko or whatever) pointed out and the series ends
> with the patch from the v4 [1].
> 
> A lot of the noise generated by the AIs while reviewing my v4 are unrelated
> bugs with different fixes tags that, IMHO, distract a bit from the crash at
> boot that is currently occurring with Thor2 hardware on recent kernels.
> 
> That said, I've tried to wrangle this series together which I hope will solve
> most of the important bugs the AIs are feeling something about.
> 
> I do not know what other rabbit holes the AIs will find when I submit this
> series, but if there is some reasonable stop-gap that we can get applied to
> fix the crashes on Thor2 (while I iterate on the rest of the bugs at the
> pleasure of the AIs) that would be excellent.
> 
> I boot tested this on a Thor1 and a Thor2 machine and there were no crashes at
> boot.
Waiting for Michael's ack here. Note that I think that the AI report on
patch 5 is not a blocker.

/P


