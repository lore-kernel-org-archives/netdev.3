Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45D42124D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467767; cv=none; b=TQUdT/DXFY+qiIk2UFB0dJZnG6oVoWORJ1a5BwFsqnq38R5TLydvkpQkGL32/5CslaqnUrrXNZ/I8rMPDRjn+4hurlaMlDqxpSyk6T45YsWtxUHbrvH1jglrkSLFkVkxyytCEXrYh21BeNbnJUOBL/t/g/r1vxTPrOur8q2RGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467767; c=relaxed/simple;
	bh=uWtLnTFh6qTHf5DLMoR8B9T86+1W025loHESsMmsiZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7H7tO2wGKV9eR5SDeg1g9nhhoqI/EJ0lIeC7XGHgla+lJn6U/jGW7zpZyiC7dWppA9VckecJOJfvL6Ou1T9GgEIkYwb9JujR1+uPCqg6LUlmPcX9/dOGZT6AFz/9AqtJCPVoYRbi78NnXl2dhWVbVmi3ziob3GRsGowfeQED90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgA786KC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgA786KC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so22706795e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791467765; x=1792072565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTZ7Ce3DSMwtlL3baMAmWojuDL2Dz507rHvu3QqzBVs=;
        b=lgA786KCLR9bnqh1vS4vStcSzLFg6pH6rXryf2C+Ot87aKb5U73417nbocOIDf2icQ
         zvNtoEMT+ps7QJSBTq0DpUM8CCyJiKTH6NnQDgDDx3tZzWBf1kUgw3a2n9fiZA+7wrxq
         hb9hJMpuXe2ChCEoTUvElBmDNvfkKUv6BPWGm7dQO8oF69Oy8FC1Kwp3N/Y+vGCs31k9
         hQ/e8CQcUuL4iHC5kqzqacxg+gKqw5g3OIpJCEfYfTwHr8SqdkhFrbZNz9vylJZsSMnd
         xbFpWwgT7846wf525xFt8VtSB0xYp7vPDyPWyMC44K8G9o35p9ymO/xdQ5a/pP6m/now
         eH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467765; x=1792072565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTZ7Ce3DSMwtlL3baMAmWojuDL2Dz507rHvu3QqzBVs=;
        b=O2tUJsBvI+hwiOkpTr68FsAfE1RMS+1O+DIv0dgHhg29lA7hrfZyPy2sVNKhZPhXMM
         EOEBC7d5jfGbKDTbcwjxna7lnrcbjiN0mZKk6e8Dj0wa+Jv9sKFattHixTFN8D3S6GZL
         em6NyKJY57HbJDDqNV2L1jzJCZ7VYr3JyihUW4yOfh+tguf7hcxZ2A3nS6YT1yHLUt8R
         lbMM6qA4qoYBRNu/TyVnTzQvjj78WrmuKRbX+UtgNm6nBN68ygX5nm/Id8pPCQkHoEXI
         AM7+3nbmY5zUmoaoLSG1RC8MvgVdeL4MvrsRWqpIBFPHQNozeKqtfFroodUykMuZTjHy
         sxfA==
X-Gm-Message-State: AFuF++mqhu7gIpXdvPqyS8zfERZXe/x7uvpMhXVMLApK4EIancNgaZSa
	QzJHorZPbEz/szoL6KZhkS0RBxzme865MhR76FfVN4A3ahhwy/uCXczz
X-Gm-Gg: AYBFou0osEQUTpY+H3vKEs0p/5JnJ2dPyNK4isnQtR/F6ztBD41NqcSA6AMis/QHN0L
	FOzouSi4JH72ovEmpIluJg25NiaE0gresKUy54guUiNRaXAIOJe84gdjGnytntPQzLGujcWETP4
	cwnTixF6tQjOPcnOGDaUvESLkTPQHj2Lgbw2p1rscCucONT/dl3KgtKIsYYI+sUerA6h16fPswZ
	rKbjuUNGzUKCeRkVeh6DVJWKj1wmeAk4zDGtQbxeBZcLixpW7xh9hURtkZLPH0pd5lMCX+st8ZT
	AqU8QHjHdJE9Xm0Tm9PPgfvm9zWfe/f2kY+K/c3AUA49doTsUA/Dud4aqDKnyM6WyrMOwjuJYkz
	/k4Mpsz82MfZFBMbtGufJfd46zxa26R2HFP5bsPJCl0HNha3R3FwNCwvSSrNNjP5GyjF4jZHrCX
	D4dXDWWVi9SD0hV6hMzaQLye5Prkqnkg+bUdsg7TvjaIN7JK/qC1Y5RMgIzeB4IIUHdBdtRL4D9
	fn8ed+O
X-Received: by 2002:a05:600c:3f12:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a180310ad3mr101294365e9.11.1791467764620;
        Thu, 08 Oct 2026 06:56:04 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a51afsm78302835e9.1.2026.10.08.06.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:56:03 -0700 (PDT)
Message-ID: <241da2cf-3437-4c66-80c6-487c0c5070bd@gmail.com>
Date: Thu, 8 Oct 2026 16:56:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
References: <20261004223852.312487-1-omermetekaya0@gmail.com>
 <20261007194914.2958b69d@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <20261007194914.2958b69d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/26 05:49, Jakub Kicinski wrote:
> On Mon,  5 Oct 2026 01:37:24 +0300 Ömer Mete Kaya wrote:
>> Subject: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
> 
> the patch reportedly doesn't apply to net

This version is old and superseded, please see the v3:
https://lore.kernel.org/all/20261007220311.113827-1-omermetekaya0@gmail.com/

Sashiko did apply this version:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007220311.113827-1-omermetekaya0%40gmail.com
