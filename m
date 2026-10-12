Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BD4F55C6
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841688; cv=none; b=UdaY6zMTHkgSz0SETlnybxzc768hEf6wuAXyAXdeMslMwARAQrVWAyb/HG7BQ6pdT/E0FoC8YYfIWxNvV/dtKmZa5yPcfqun1PHwOaTMy2EhttitAoGdiqEn2x7SUvHBKvmIMQYMhTOYR5+fGMtoMDXbtCBfI4JgtiOM8s5J7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841688; c=relaxed/simple;
	bh=PEBG/k1n0Nekc/Fj4VvaYhr5hFLRa7NhzeeUHCU4N7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObQr2jqXDdmtYM7clvSoFeepfXBs/oKN2VBt+tgOPB+m6Ca+oLiNID6Xposv1bXSfCc7lsMpGtX6TLFUq27gwCZJ+IedMGiJmMW2TIskWJx3r9hsTaaMC/tjGuZXWeD7svINABldmcHTbxsOZwvuSyYjA9n2GbZA17QGj6YU4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXOo5kCg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXOo5kCg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so21130815e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791841683; x=1792446483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zq/8m1eSiHTlioZUUeey5q3Q1PxGXgxzAf3i69rhbQ=;
        b=pXOo5kCgGZf/tIVqqAGo3MjAEeE8g2vHRTJEqaHQd+i+kRg6qrp1hI4bs8nvSzdqyd
         nW1/fwr+yLN7mgA/SOQis5wlt6zweHF6B7vvlh6is0tZxAJmBQH5L0huGqMpyh+W/RC2
         FqwCOHGvtJ5J6P/BY1qilRav1FLxIXREhVNOAfUq64MDrI+2k/mLdhnctd8S0mGj24lW
         jXuAC+PPCRVLGgFIVNlqhBUHJ6w+n9KSRKmbRJ9jGvPfxZLrukjgOFnn7yHqnuiFPXgj
         QTK/L8Yyv4iCMH0MASwPpgIuCQtb0KTWNft8mpkXevYcPLatB82oMreDxO4pzMVJZ1zt
         jLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841683; x=1792446483;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9zq/8m1eSiHTlioZUUeey5q3Q1PxGXgxzAf3i69rhbQ=;
        b=AbT6u5KIpFI+ppGoIMqkG7VI4qqDPxXLwS6s6s2lnat0TBSSXCu4EDU/Trnzh//aPY
         M97A8Rhr9dhKvnp+q1R0guV/Zem2jZEZglWb5Cf8fCsdAUd5HZGAW+JpsHUIqwD4MVYu
         OdHzktsQwcCkuU/kejvFZO1/I4XxTpMQfXzP02RzslrNUk2L58+ifCUbekEkHSxPS8sU
         /XJ4OgpFd/d+kuHaT5LpuVTSarxZPNtuzGoWmX52ZH14HmtaBx8WLA7bdvzcxchYnrM7
         OSXxvD9cUxGLkdcjpbomzuwnfZz4mHPqfm8OgA1n6exu9ASoPZ5toEYhwfmGmHsvinJG
         nnlg==
X-Forwarded-Encrypted: i=1; AKwUvBwIEJse8pQsLzf9kOhvudJkByLs6GrzxssrVuAaGmKnMZkt7+ReQtafjOG7OZCvC/cREnNjsSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsUlLZEemyh4aWbvWsMLhWUQodek6+s53QchWcHvSG4ZYv1ZNM
	2kAU/32vb4jq+qLXDZ8nCqqfzzHN/3l5ZBBhxrMtt7ww0No+ET1pY3AL
X-Gm-Gg: AYBFou3oqxmuxjJxmfyRMlHktfnItMrOkN1iZ862MzrwwcffBzaI/BsvdQ0vTs9FmH3
	qigoHFSgrvvJL2yzQ+818MfcnJydnncGA8pfFscQWeYU1RcxrgFjbzHxbHiUsxIwjxOwHkIak1O
	+0ZrrjcznC6Ygf5xFcZ9vCvwxTrQLYnxdF8QZnfTmN11RrXlrxSYLejtq+RIkGT90neEKTGN8Bi
	4d3h/ZMG1gei+Os9HONP6I2xsuFnITf/ObB4U2FWBVpYIwmYcvhOQ6UWPv2BErI3CCk8+s+Mx21
	i8EkW9wPb/P0J7Z5gWB1HJdYoBnYkhisnqP0ZeqGpRV3Jg4v1wmKPk/hYuRO0BEMb7fbeeExuuX
	UtQWtmQTuvf9Qs+2yB3esu8GeNbZaoaYZLkSNC5o1mTP/HLIxwYkbBHkaze9GWWzwSzz+u2KPUl
	ypjEmsilN42P9tGJiXi7Fj9oTjWClbXDKcxCF4/jM4hPOLUiuwJCdwmn/BrpToxSX1UCtnW/o9o
	zc7fearIvKTAGLDYcND1y7a4Mbz+QEcBINyoskEvSfOALI9CuStHB+IRXd2
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr223185285e9.27.1791841682545;
        Mon, 12 Oct 2026 14:48:02 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac52d3sm1449484f8f.43.2026.10.12.14.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:48:02 -0700 (PDT)
Message-ID: <aecdab1f-9af6-4a07-938d-753ff9fc9938@gmail.com>
Date: Mon, 12 Oct 2026 22:48:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] sfc: ptp: serialize host and MC synchronization
 transactions
To: Alex Austin <alex.austin@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, bhutchings@solarflare.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com, pabeni@redhat.com, richardcochran@gmail.com,
 smhodgson@solarflare.com, alucero@amd.com, pieter.jansen-van-vuuren@amd.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20261009183240.1898762-1-alex.austin@amd.com>
 <20261009183240.1898762-2-alex.austin@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20261009183240.1898762-2-alex.austin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 19:32, Alex Austin wrote:
> Protect the DMA handshake and result processing against concurrent
> synchronization callers. Serialize clock adjustments with the same mutex
> so they cannot change the PHC during a capture.
> 
> Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
...
>  static int efx_phc_settime(struct ptp_clock_info *ptp,
>  			   const struct timespec64 *e_ts)
>  {
> -	/* Get the current NIC time, efx_phc_gettime.
> -	 * Subtract from the desired time to get the offset
> -	 * call efx_phc_adjtime with the offset
> -	 */

Not immediately clear why this comment is getting disappeared; it appears
 to still be accurate.  Is it just thought superfluous?

-ed
