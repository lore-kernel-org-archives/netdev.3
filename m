Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12D330650
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181841; cv=none; b=QzRYN7IQO966KtV3zGxfC/t/noLtoyue2MwSI6AjAwIXtx45T2SoSMU+jRpherLPiri8XDz3UdQqRa4ySbIRSUSlPFCuSz+/lgIGm07X20A1zwnbOffsWJvhw7TCmHn0ZjKP4z+hfp46g1AKl6T2175+UYwKMRQ2H3JaZTn5vM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181841; c=relaxed/simple;
	bh=+gxDmjotSf3LuBIiaiIjXvFNTGmFAUolGNFNkJv7du8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOUgMRdqdD50ZOz9zaWm0beTBIZP7oy3di7iN5Y6dqsvK4QolAvxHJcKEzfqCfIgiim2luL5svySzZ3UENpCJa0wCMuYWU6KcFcz0q865i16/tFriKlAOhMt1ApH/jqzKcnpewsWyBHuoVsks4RF6hX2Mq4figfE0wcfZfrrkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TjMC4n57; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TjMC4n57"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e4998d28so2396845f8f.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788181838; x=1788786638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39pREVZZ58PRD5IOFAIgDXEtV7Al6dYOwo9W4DadEPU=;
        b=TjMC4n57JlICA+fZlm+EGQyz3aYVT7U84E/P32+mGr9FHcta1ZPhMEaCBV6HI0LT1h
         fj0hywjfkoSZg6VX//Dind/AM9pjEqEaOSSChOx1OZAB6S6B3AFZvqb+c6kJe0d5WVSh
         Yi4JY6UnoS1qM+5nUD2jj5mE7FCWhp3JGAbFjfSOUvmiBzrWl44GgUyI7aGpSJ21R+2y
         2Y57zRu/s3witvJ1KMV/lmfCcuPQdPen1dJwEumn9XdNv+m1pQyST0tJkDYppYwTISFM
         V4IlwVWHqKSFVdG+nzXIWnjL9eLs4qJQRS4TOJSqwY1+ttPwFp6E4VZBp6/oSek8Dza/
         04iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181838; x=1788786638;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39pREVZZ58PRD5IOFAIgDXEtV7Al6dYOwo9W4DadEPU=;
        b=jftHjJTPYNVGH/IcGr89M5WrKUAYbNTwAZiSraHgZYiynEhBGdc1wbh1/SiGr4BQRj
         l0eO9YRhbiaVqpRIIPvNrQ6X4d/f4+RJPMGq0Wiut0Oai1ri9QzYpVQvLRimbGjGSyUD
         EaGDaWpJzTRfe2A+4e0csu4L1iK04+GQa+0XSwtoWABlvsndynE0HRjz2w4xRExSOdRq
         1jHpVAXEM1WbmoLA1yX4jC/kvplJpysT6t0OZCuVgARbW8D5OUSvooDMijauAkbMR9OM
         n4eU8jkYQmOPWgXGaid4sJ8MR2hSOZcNOxoEpvaaZ2au6H/R/+QD7yiXfCa7v+yUaHLb
         3IRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO6fvyKo/n1/O+y+0ftdMQB8NfLPMniAIgMO6Fo4faLtrHvKAHYAkR4vvHRgasluQv1oxtnpg=@vger.kernel.org
X-Gm-Message-State: AFuF++mDN25igkQW7SMYYJPKtd/NRg9FlnyzmninKH4bAE4GA9FrH+3Q
	8bbnXde005mWA3t1Li/AjT3zcQOhXmZVPQXu61tXqcwsucOrGA2plyR9dUMMo46bnJI=
X-Gm-Gg: AYBFou0oMwPFe+ANmgBqJRytV6xhGTf4/h8vSvUTPrghNnMUZVvNL8KrS9JXK3UocCN
	qm6GBEJ9JtcF83IYACuVwmNl+sxVyhEgSPmZgEmKz9hrmSEtr/Rqhpks/DrWzkVAAGNJH2fBEpI
	+gE36Zl/+yYgCTkCqdSgpXEGKUzWlWuZ0L8c0Idaibr74RTbaMLWaE98mH6A0BU9K1zqL89WrdC
	iID1RqxDzVeZfhcNHtTMF0l/5PZ56czBeRAMBRKuNUsKgu9F4926/uVzhsNptX43RHeUAXhmDAR
	+e07YfzrLfb7zfVToERqzNuq/nXPpzW4WquBASh6eswZOKF3DSkU4vxtkl+LkWg0QYIkVhnkOGv
	1nP1AEwrC/5NEIhgQbk1OxQppj6V141pFRjuz4nHUJabcJAY0O1xR4bRj261n9YuT18njRvIR3G
	ZuJleQR7NIDJW+4oC35ymVMUCHbxE0EPfZFZDTMcUyLRDXTLDDeGnZMkEEBYjQ3W8Bt+9x8QrfX
	uNsY7soFCfExNbZDp+MFG4su2Ky/yc=
X-Received: by 2002:a05:6000:41e5:b0:484:338b:3bc1 with SMTP id ffacd0b85a97d-484338b3e17mr21271089f8f.27.1788181835254;
        Mon, 31 Aug 2026 06:10:35 -0700 (PDT)
Received: from ?IPV6:2a02:3033:283:b9b7:bec2:3dce:f757:ce06? ([2a02:3033:283:b9b7:bec2:3dce:f757:ce06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f22sm23547103f8f.2.2026.08.31.06.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:10:34 -0700 (PDT)
Message-ID: <66a6f7fd-bb11-4c1d-9871-14046add019d@suse.com>
Date: Mon, 31 Aug 2026 15:10:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: ipheth: stop data URBs on ndo_stop
To: raoxu <raoxu@uniontech.com>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, maciej.fijalkowski@intel.com,
 diego@giagio.com, agimenez@sysvalve.es, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <8DB5FB95051A2E5A+20260831093619.838403-1-raoxu@uniontech.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8DB5FB95051A2E5A+20260831093619.838403-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31.08.26 11:36, raoxu wrote:
> The disconnect path already kills the URBs after unregister_netdev(), so
> unplug testing eventually quiesces the data path.  The gap is therefore
> specific to an administrative close while the USB device remains
> connected.
> 
> Kill the data URBs from ndo_stop as well.  Do this after disabling
> carrier_work: ipheth_sndbulk_callback() schedules the work on TX URB
> errors, while disable_delayed_work_sync() prevents a completion caused by
> usb_kill_urb() from re-arming it.  usb_kill_urb() also waits for pending
> completion handlers and prevents the RX completion from successfully
> resubmitting its URB.

Hi,

this also kills the transmit data path. The packets in that URB
have already been reported back as successfully transmitted.
Is this really the correct approach?

	Regards
		Oliver

