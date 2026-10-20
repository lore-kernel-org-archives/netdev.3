Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493835;
	b=BanClcxSHBp6YTKzA/w6LW5qq4D4gh5vHeu5sXsvG41l9JOCRyCsG1K2+mMpJjyO1OjR
	 FYM92ySyVmeaRPw+H2cFaWEz2hfa0MtGyRHInH66Ax9fs9y9IKjESS6ACMhXCA0Fb+4HO
	 vawGcGA+YqVRvpQ8mYLuDvMVVSwhYtXXwpT7Bn+3/9BRcR3rdm21DiAG8XIHB9JWGFfku
	 jE01/0a2vqC2NBYfTUzyJxh6VZ/X6mb/8ocDg5MJ6WZi42eKrD1crGGQrnqUqAX3iZwws
	 C7vcsx2/MRpQ6euQfWOO9/j1TBTnLVG13Oj++jDlLzZJd9oe+EJfQCLKnY6h+1PBwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
	b=lGMHQ5axHyXWStBVx8SsQxkY8WPS4MbKdxZ0l3Rin8TGfZCAAoVHv+3nqWsbPA6k7nlE
	 lzgPfwO4QkZUkO7X+mn678hIbIzhj9B+UXK7/Y374JUqXDswZ1Jm98ntmGLuk6y9HkqzO
	 +upU939Ds+jpWppFEsAPJq5HhpwAJJ5w1lJ4HBlAJTl+loMgXgdp4DuOwKSKJyfPEABLe
	 wSbC84ExKe6fSZfN6kCsMKQKaoQozBAB95sWichLeiaIDA8OokCZzp3PESelECnMUJOqj
	 wVMBq4JbB498iaHwRSTodKt8XGaVJQkFsN437O3fuCuHJPA8BBFVw/7tutQfj48s6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IG8CNnwU;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B3606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 393B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IG8CNnwU
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so4889915e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493833; x=1793098633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
        b=IG8CNnwU3Yrj9dJ8HGq+mCXNLvDjQMFVKXd9PsRwu4nWGz2dDCgtbz/8x0FT463ahU
         uL12vHG8JwsMp6f2N5DElvkEFuZjOIoxpjr2CTgly2P1KGn4wNbR4YrxWNh3zUZ+deuq
         JLF2B0G339BdzTy9BSEtsuL4tAuyPRbCTeOhkafSrK9LYj8oBzky8Jja75yXmF8SDRqw
         bOydB5/9MlSxpEPaCoNJFF+zrYyTQXJu2xhjY/1Ohm5W04Xn39Abwj/Q+xQ4ZuckKuJ2
         Ps7ImPM35FH3Y7idboydTb9Fwa5MqaFu2iqTlbtXbvDXsVveqhPuaedBrNXLhWwP7eqW
         p9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493833; x=1793098633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xmo5pGCKClMTznAgnt3P15PbfjUdQDHaOBja2Zq9dD8=;
        b=2Lm5B6AWlnZBJXQcuEnxpBPUCE3kYQw69G1Rc3rPh8Ng7ZmEADN4D0XHpHvHwCdhwU
         vu+PG0gaR2eDDOfojDqzAG+2meSbQTf3xkVozOs2Gp0ImlMXzQ71vg0Izt9ZKhwGn3Nx
         SrjHM1fASmoSX7iJUoRNhziSPEJFBNDokkiJSxqXgkXGbJmO4X3BSc+2epceWy+i7b7+
         FXGboNT1OOGi0RXNJzklOM7or5KU87WuvddbS6fIBX9T1QWKcQFb50+7gg0Fz2Nvvmxt
         nf0d2kyGprBVLFT2fyXFaKS01kb9qmrIjIOTIXdvHFKlXjbrjfsTYB/cIJA4CT/Z8fg2
         0hrg==
X-Forwarded-Encrypted: i=1; AKwUvByuA9sQiPDT+SOpcgOlYCyvP/DQzqoTFl1k9oP0iYQC2FwJv0DyIGtyKvwnz+1Egre1Zmy0ZzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb1DSR0g4la0ZUiO0lHALyPzBVOTNShOzSX6DGXwy2WBrYJk9D
	zfSoYAYi1m0tDRPU+y2MbVrvWl1BpxENBq8EsP/cTjgw3Ebjxl3M0jDV
X-Gm-Gg: AYBFou3kQkQIILKzpItrutFbVnHn9AaQJuVUp0340YUtNCNycENG4OTpR0YZPuC3aaP
	wkqM9s8s2iLdMa89wYkDKZs3j2W+Qn7WRk1AktP5xQ40tvyZ/0tuKK2VSQixi+Ba99SB2s+W3y4
	uesS/zql5MRhIj4X8Dr2RsbXSomuFGHqKVO+tSKIHdrhVUxR8EJP2vlhiFSeWl+o6zyuMi69lSb
	4AzogqsN1nqC02DCuJ0wfkyEPHhxge0tgRFe6nxn054vnPhGbWNpmAHKiHHRxS3AVg7xbnYT1gD
	vBySoJ1qEuxi+RIPsgPd0BuYFYKhqvGNr0Us1VG8rHYVhp0biqxlzF54lIr0Zc+oTVGNZeqWeU3
	kaELHTQaQklg9poDOhRS4/JbK+AItkUEXhZSfIj/JrD+DN5EiMcQsx9VRayBvFIVq1kiB7UARNV
	RojaGab0tE1ApAtLYM5tCV3YkF3ohNq/ImlFLb2kh7BZ7fT4lPC28EHforBFRp0n12bCPH80GZX
	cZJ6sCKWgPMPwwSeF9FsDXkJ3MU/ver1DDO0JxYo78JupS0mklXDiP45+oc
X-Received: by 2002:a05:600c:3556:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a1d76051b8mr237749825e9.17.1792493833438;
        Tue, 20 Oct 2026 03:57:13 -0700 (PDT)
Received: from [192.168.1.105] (92-184-144-135.mobile.fr.orangecustomers.net. [92.184.144.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm231782675e9.4.2026.10.20.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 03:57:12 -0700 (PDT)
Message-ID: <87d73b29-945b-476b-ba02-71a5bad4b4bb@gmail.com>
Date: Tue, 20 Oct 2026 12:57:04 +0200
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
Subject: Re: [PATCH net] net: jme: keep RX MAC clock enabled for WoL
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
 <179181078924.434549.16666867636447785126@kernel.org>
 <20261019182217.18e26e57@kernel.org>
Content-Language: en-US
From: Franck Baur <franck.baur.67@gmail.com>
In-Reply-To: <20261019182217.18e26e57@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Agreed, thanks for the review.

The RX MAC clock should be gated again after WoL is disabled on resume. 
I have added a call to jme_mac_rxclk_off() in jme_resume() to restore 
the expected clock state.

I have also addressed Sashiko's second concern regarding concurrent 
link-change work. The revised code prevents new link-change work from 
being scheduled and drains pending work before arming WoL during suspend 
and shutdown.

The revised driver object builds successfully with W=1. Runtime 
validation on the JMC250 rev 03 hardware is still pending.

I will complete the remaining tests before submitting v2 as a separate 
patch thread.

Thanks,
Franck

pw-bot: changes-requested


On 10/20/26 03:22, Jakub Kicinski wrote:
> On Mon, 12 Oct 2026 13:13:09 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [Medium] The patch turns the RX MAC clock on before arming WoL, but
>>    resume never turns it back off.
> sounds legit
