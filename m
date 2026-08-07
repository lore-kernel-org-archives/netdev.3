Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376A318EC4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112287; cv=none; b=G8LH0Yhb8VrFrlX2/w3PVTfryzYoO5ZY3iIbqeH7dT6GWyuBXkEh29Hgqh8vnqi0elQSJGzothiNDRWfFyiT+54GpxlBBpklZa5F/RYRIilad5WGUost0CGChun/7pAUAk79Hk40U8HMWnnf75pP2AuvPEittXXoPn3vqrvp5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112287; c=relaxed/simple;
	bh=GHbog51p2Z4EmxKia8vLY7ePutOlVqf78v5nfm+uPc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FERWKjSS8PD+nSmfV+RWBl7QaanhtktQnNnqaxhJuYhi7vu9MF0yI+YxyL1oAOaTfNfQKnUkSVDvZRqVTVIUAMGHP8Q3zxM3MZFkmb0JkqvmtpK1KjlhjpQGM994dKMXcE0PYBao/iahd30DwhcWBzajHEd6zgLb5i8x1tSGuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SriD1Qfg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SriD1Qfg"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2ae992beso306721f8f.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112284; x=1786717084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oTVdF/cMHvQPCTQKP4Gnhf9IHEJ6JKbavTkPZ96gSE=;
        b=SriD1QfggulUsibtK6d0Ta2fKnmNqDuAbYwtN3p43bpacvnfAhvDaliv4F60FDL3nb
         srx2BBMCYPqWUtev+a7Uczz63qSfHuWtQG+CrEH5/Sl2tBt+OqSP2Nu0Ton798PDsWFj
         2TxtNc0QUeZ1jwSv23D4jDlTqB9IHUx4JP+7lBPYrvY4mjJ75DMfkO/mVIFId5r87uX3
         N9MnXai1XcGIuAWK721gepfB/HehgQZNH7Pm3z7qSzpJVUfsFpmOMG8xyCMVF582qlGt
         YuXnwC3slmvPBNKnfml2qVJhu1EwxAwRnsfUIfq90QjcLjDZYxVLhyX+kEhy9lrm/EqN
         RJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112284; x=1786717084;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oTVdF/cMHvQPCTQKP4Gnhf9IHEJ6JKbavTkPZ96gSE=;
        b=MaKsjucHRnc1cEeu26x4mcsF6wkE32NfOntQWd5m8IG5RjCKVM+s13ggveQ9mBuwd/
         aV8QDiHhY+fadN85B1Dnj1U6FI24AwlZkY26rvTAyssMC6GeF56GenSqN+c0J0RJ3U14
         IXzqyqzPzweG64JUzHrncLKbPAtqqBbyVvgzwUVqtcUFlLYb9+fBi7rhNaSXq3Fo2VHy
         5dkbmqQpLMFra5OYecwNCKFfvbFPTc0Hx+E42esiEUcz8CnwJlplMdiS5xaYXu6Kq2nQ
         aOcvcIKz7GQgXNwy52Jio0OsCLt0xBoanHYYTGDObQ3HGPUzYwhJxfaz7Sevn4wXGNxe
         q1tA==
X-Forwarded-Encrypted: i=1; AHgh+RrsRKbCgOqWn8i93D6xuCMkMPMl6o1JhP6ycqIr7qUZ8evl86y2xUNpyOgzd2UKvERXU+QqQJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAE7SuPDKXMohteAg3mtsmWo5pJhPUKAMkfERfuPMAb3FNaqm
	iyet99m5kS6cSJIUVSNLr4D47/Sb6ANfZJDFkoFizfRrB2VGZvWhbQ1/
X-Gm-Gg: AR+sD12+OvqPCr3kA53vehzeVPVKnkFxqiDsU9YkKFr6duYxbnUR8N0rfhJditNaQ9Z
	YUvmEwu8oekhGKR+72HmfH7PvVDedhuZkA7HhPUGBQB5TL+n3l74NDQvc7dhxdBr4zxYmjV2L4U
	RzgkaAoELFxXeS6yz/78eMrms1Z0STZPJbCDt+3KMnXkXP2wUB+m3coGlGUw/BrP54T/dlUytY+
	0pFKc6W6k1GFMDeeDFIHh4/8dnkrLZ2eqXOrBMHpdkDBDbadRlzjKkYFKJ6gTTRPHKjVAzHvhYd
	Qe/QwKPRrAFiUeFAT7hD/PdBj5p0fdCbH4x6XwrFpw1bsrEzIHDD+S7IsfvpnQF/Sa2/0k6Y+J6
	IwdTRuqEn5EGWIlpbS+iG4WwJYStsYNGwURJ+h3BkuxSK/VG4ZBq/FrKNPHOiiN3KlCl3DDTQtL
	LpbV9a420YIj2mCKM6zSJdNeV175ot80m5JtNxA7kGmd7HLwQLceh8JqbDS9r6AJQmt08HL+Ojp
	fkvmeoGTdlIlozIYfRCaxSxAjVR8AXWojkTkyF6rVdQHiXFCxG18+BRW0AUxVROWJI4niLW//Vm
	9L1fm+Nkv9hacg==
X-Received: by 2002:a05:6000:200f:b0:46f:7d90:8124 with SMTP id ffacd0b85a97d-47fec528a60mr17428673f8f.2.1786112283910;
        Fri, 07 Aug 2026 07:18:03 -0700 (PDT)
Received: from [192.168.2.69] (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e902dsm6183555f8f.21.2026.08.07.07.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:18:02 -0700 (PDT)
Message-ID: <e0019840-0b51-4997-a5cd-8bdb0e95ebf3@gmail.com>
Date: Fri, 7 Aug 2026 16:18:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hsr: Avoid holding seqnr_lock while transmitting
 packets
To: Hangbin Liu <liuhangbin@gmail.com>, Felix Maurer <fmaurer@redhat.com>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
 syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
References: <20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn>
 <20260807094325.GG51943@horms.kernel.org> <anXStphPD0z-ystm@fedora>
 <anXatDPkcVsCTB36@thinkpad> <anXnxn-PBv8qH6VB@fedora>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <anXnxn-PBv8qH6VB@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2026 16:12, Hangbin Liu wrote:
> On Fri, Aug 07, 2026 at 03:16:36PM +0200, Felix Maurer wrote:
> 
> Oh, interesting. I just came back to work this week and found this issue
> when reviewing the syzbot bug list. Since Xie Xin has worked on this,
> let's drop my patch and fix it in his patch set.
> 
> Cheers
> Hangbin

Hi Hangbin,

Thanks for coordinating. I have just posted v5:

https://lore.kernel.org/netdev/20260807140751.1351-1-xiexinet@gmail.com/

Patch 2 contains the overlapping seqnr_lock fix, including the affected TX statistics and the PRP supervision path.

Thanks,
-- 
Xin
