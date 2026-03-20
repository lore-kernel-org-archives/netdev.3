Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B53D3D09
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027554; cv=none; b=raf+DrAOuyAhRAKuJd4gzgsQak6R7cHxn/LDMgWyYRX72dHSiuD5Ff97mR60+cwqBmVUipyCndjR+uiQFceNQCK6iPgUlpDpN9izNZnaXTC7z1gjVR6FWYu1ucIF9Z5fNlarp2UAV0pBwNyxjv7ZZNqrjXP8GkdCpbxL60+Z7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027554; c=relaxed/simple;
	bh=3fSdDJFbX/UF8TqIOccS25W+2cGMSyCwQsxne17PRds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyTANLYla24dWU0QJ60C/3ucffZ3ppHoKRBZqHWW92zS/REDVyvPnf+McVFdhIWOoBXsNBa5LszOkNkGTdHXrAvmDRI9Ft5V0se+/69QQB+Q/6TE2ObB9NeIimgiPWF9Xl87lpU2W+5y/OOtOlp2bepkNuac0iUTYGKJUFC3icc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0eT+yAR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0eT+yAR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so7111155e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027546; x=1774632346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+viBsL1LV1syQJtwyDa3wbaYzbuA8qNDXpLw2O2MudU=;
        b=b0eT+yARBY5tuL7RVI5ITvbIS37WOgNa2bMOUZsSVNDRmT7rp31tHH31kFIl9uG8hS
         Ooo5sBiy+2NPtYgWtZ119RNKdTJLTtfpinI4Dzs9sBT4CnKaVbv6sgzxrfwJk59meTyc
         wThRdd0t6CUdfkzJ4hVUggA8ljFonO8KO8geTh6836OARZOJnBknaXC6jWVTRKyMiPAL
         h6clRPKsqPGF5smDrXjRieooBbiBDeuQdGwRyh7WEjNRkKUEUo/ahAkYUj7ljvi6VVvU
         laIE9qITs/JPga/0CLWr+UDXbND9dUDDkKdXG9H7uzH8vl1SeC6WQ5pXBIIPc7Vrrrsx
         WBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027546; x=1774632346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+viBsL1LV1syQJtwyDa3wbaYzbuA8qNDXpLw2O2MudU=;
        b=kE+PEKUt5PCyATv+SCO1DodIeTZ6VyZ9dWctjhAwAPxRgK+UbSpGZzh1QIeLzi+k9A
         69dkDLbeCFN/6PFEanGWy89m54b27ZdmzP2PIUvtGsAEEionNVVAJ4iMyVo/ogpAP/AV
         wuHKt2omy3dKuyKP4ccMYSQxUjvK1i1h7utVu2ojgEG0Aj+ZWNya52yyiIPbJIbtQ4Uy
         0TWzBt8aqARSpIEH3C1GuOn/yk+bL7TsJYX8INH16lNn3F+MaoUCCbRRJekTFC1p16c6
         XNWTrDQHeA34LhlZH9qpcmV9K9TEx2QObsw30VXgbSWRiexvtWZyWzk1O1zriB+eiTx7
         nlog==
X-Forwarded-Encrypted: i=1; AJvYcCVkdeX1QKKcd/f2gk9GumIn0NnNYLIopVPIdHO1R6U2srh6lMHcsjgOR5kJQ5tbKQxEqbFUhFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLee4sSO+989NBCfgUB32KNZ9BLc3L8STZhgHsstceJQefNWE
	6hdWsDgVFSfKBDW4m//B2gt29+L10YUcFkOzY1IsQB5REsp+n5lKUGVQAMoR7w==
X-Gm-Gg: ATEYQzzDimaAndsW/GdrfkeLywvgpB1D6agddIy2r4aLgDzGnCTMJXcVspArh6rDJi6
	AVzDvCgEcm25vjCASEUUMT7EsSW/IFeW+ReB+cZeqjUzfokyu2p4Yo03NtD/unwW7ENHJiKF81P
	F9/O+ikJZ9G9krK3IVd7+EuF/rtf6Ye/oVTtIFC1+aL/A0SKrMux7LV+4dddmep+MxfUJB27/WV
	IyoSi+kaJTyPyzC33lsbTb51cdxRUqGpehxBXXJA2UuFEfKAcBTX38/byc2WRpzMvcg1ae/1wsJ
	igs4e20eisW1uqOVnMRsXhjOu2iJJShx+eBZfJMUnAKEvr//5MXJ23mT9mHo7R0NQVDfpLxN9Oa
	b0FjZjycl7iPUWB7O3UWwyPcjH41ziZwv3rimdfZlKgtIF8Afk8E0/+GoCPNsn7fELQ/vJX1NsN
	ld52kBfmTrmfX54bHMeRVa4mWbwgI76oaOzrFcqqcZsgcL2MM5ZuTedogsdGxZTz0rvQviaw3h1
	zbuI+yG2pxSiQoU02zrfxPE
X-Received: by 2002:a05:600c:a43:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-486fee0fbcemr52991765e9.19.1774027546346;
        Fri, 20 Mar 2026 10:25:46 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm140067275e9.7.2026.03.20.10.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:25:46 -0700 (PDT)
Message-ID: <4abd7d64-2973-436b-8eb4-ea3b92e38167@gmail.com>
Date: Fri, 20 Mar 2026 17:25:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
