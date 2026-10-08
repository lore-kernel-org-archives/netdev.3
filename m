Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D74EDCA1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474434; cv=none; b=SDvWjKNSd8ZaITxNPvBg/6PRVadsdClIBEpkKYPLno7150hUIGORdDRRF3aspenuMZuo962uMnjhDLvtJ6p91s6wL5C+1Lu8j0MWcTeySV5pNPXV3UgYBufeGXr37oZsbOpMiy/VxwxjLPtuXzT28fzz8jd+/pY8tps+oT8X4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474434; c=relaxed/simple;
	bh=Fv69M9kf7M8P9lf/EOlij8e5fDTE4UYWx31vo2P5D5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYFELClr/zGXCYpF3oeyuLO/RD7a3aTbl2kXvfz2DDJ/Irp8fZc+JEc/5FX7lD2MEO6Kz3fqMGJ5GRuOW4XhJHgOR2Cdp7bThegTF0Id+bJGIku31zgsl3VFGRZElLDB3RvD7DP5iaOR9UkJHfB1CRnDrxCFL7FEn9lVJRNhsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUbiEFyX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUbiEFyX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso49624925e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791474431; x=1792079231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fv69M9kf7M8P9lf/EOlij8e5fDTE4UYWx31vo2P5D5c=;
        b=lUbiEFyX7Lo+LY5qtpIDeeTxmJqTmNAKPF0GUIRw1rA/tsFq8y/f46Sa3vBHfH1Wi1
         XIgkSkNe4T4jESOuTCRzjxhr3xm4RJx86Hp0zab1bufH20QhBDHS3Yc3bxGZBG4x8O+q
         sxhP8YF36B9bE77m+uH66ljcu0sWVQr/95MpB7shoevYPFB+FZvx24Ra/7Cpigm9SkmE
         O5JTga8/cU2V/1CEwEd4WgQRyTtD3s2o0VIykGwXboLmnnuky0yfm9R9fveAHfKnpvpQ
         itZtZSMvamorfhSQ+IUvlBoTeVBHw7/52h7+izITm7KADSpEIAAdcX6Stfm3VxyXFOdm
         X3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474431; x=1792079231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fv69M9kf7M8P9lf/EOlij8e5fDTE4UYWx31vo2P5D5c=;
        b=YoGpECfaiVAvUJlChx8T37+ekmAUZ2VxHwWIC0lIGHGVb7sflitZmPP2FiPOrvxDGG
         /1jefpnJBJ5hMHoxHC4I1bWzvR1py80cRytT3mjYCflO6pOZC+m6slrjBTS2bFnA7y7q
         IlMzRUep2j3uuPYjqswAPVbgLCIHINtqhG5GEhtS+WSovFSB8NpfU9xBQVRsKtv+9k/m
         mPwNZzPLcRVV0PeQFiKny7tKvOoTzpImLMtJcar8JVBlCMs3108iI7uWfLB15Yg9d+/M
         zqhEO6MW/WL8d3gSp9Zg9u75o+Qn1Cz9gJUcR+yVoFDGPfl/+DTweS+hNxTKAQfpLG5v
         GU7Q==
X-Gm-Message-State: AFuF++nutRkl0Gfu5zH5tqdGuVWOQAFN3lgZJSYOb7FpcJTXlkwE550/
	4yCVOHN1JN8anfWP9eDcZNUgTDlMuLUjlMyOYvl/t4+ENqsURB/Q297z
X-Gm-Gg: AYBFou2/wqlDv8dUmSdkXx8LbcXe/giHnkRRGP7ixu+pvjkzAIvlCmCpVTqMQTlHb/9
	/GcTrBxXAP15vyzmVM2Wb+gSqjaqrj7OEWsRDP8gp6XhrMGkqZO0vRX+Tev6k443tKPmiTycWcY
	+qXqGfVgWs8/OoyWlET2LloCoDBjr5YkqLd9rN2XRD4pC6a7uHhGqFbmqvLwkDSPLdRsCttEm+r
	YIn1vmuppcG3LQJly0aNW+Lh53KNKr71XLEyInBm+WG1/D4wVTlziiZ6gINUnv3c16FEm9jBcMj
	U60AFGcCh/OavtUUvk2Atwq0/u7hA2chlSX07fHRN27hNNVPP4SYOUv+hEtM5MuOIXg1rop1W/V
	IJWZgV33GC3op2OZYF3Dl1a62WEv1mXwMdXr2hll5lxqUaqUvgvD9QiU/4Ow1AdbIQpAhGILAGx
	BuhcjHcfcpBvxmDnHt0MUko31RbVFhAOt52HweqNILo+yMpikZdhFnZrwtUDoWESYfXHZhq53I0
	y+S3WGw
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a180422c02mr105584275e9.10.1791474430445;
        Thu, 08 Oct 2026 08:47:10 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db652194esm232749f8f.24.2026.10.08.08.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:47:10 -0700 (PDT)
Message-ID: <6cf2ac60-a9e6-4a2d-a7a5-7535441485a3@gmail.com>
Date: Thu, 8 Oct 2026 18:47:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
 <179141094859.2527009.4935200551311639225@kernel.org>
 <20261008084012.53e34d5f@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <20261008084012.53e34d5f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/26 18:40, Jakub Kicinski wrote:
> Hi, please answer these questions, and try to include the answers in
> the commit msg of future submissions.

Hi, I couldnt add reported-by tag when it comes from sashiko,
should I include the answers under the "---" for future submissions?

Thanks.
