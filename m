Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DC471403
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808331; cv=none; b=NB1s9ipd4TcJPcWbT6An2hXNIXbkOJPnzojbZ2f/8QL2wkdTVi7cggujBq4LKJEXWEwmrF7z3rsgFezE8cPyvmwcARxj0aGJc3mjuZ0YP5/F4QuEPWHQmcBD791SuWkjFnEBxS4obDleOkQvDasjAgV6Wh41zorKdvHpH15Q0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808331; c=relaxed/simple;
	bh=XHYH9goJLfB4hT72FSpUpw7jM4IyFmcp0Zh+k55Cx84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu40rXdDcDqqbCZl87yAndLZu8Txdd+CHgyqos2ckLb2eG97JtgFefs5mf2mFpErwaqbFxVSSOB48Qrb9UeJ9qWOlpPGOdLvFPSUPTRFP7z4y+LRYVmrpHZorYQXkf52y4DNHPVkaT+nrTQwAw86ZE/nm0t5uTbIszTfz4UMMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISdK2hnX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISdK2hnX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so44143605e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790808328; x=1791413128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw5hqKS3ct7o0O9F9EDtZ/MEdTAhkcvo8rO194jpxu0=;
        b=ISdK2hnX393chJc0it6P6tNY7sCdY0ruGLT0WyJ6JWiY+SSzK0JAEqYSp+VxytlaQC
         nEpamEdYcZflJlovloL4CKfYzI61xONiGvSjPKm8GELZcLQ0QiDrFazO9vWXrKB2YtBN
         2GDrwy54AS4UfPcShIypu9VaiE/hS7q+/fF8zhUKqX9tP8tRDpG3yYI2+pDyiGl6g4Yw
         wWNuIWiX+CE8drvWOUKhzqgE9dCgTvsOcBZD6K+aRvMltKhCLuX2rBcl3KYjI8X5OIoV
         mMnnin7CJN88dO/8EcVlbgXN6L2/ZRsBn4IPMeEBOes5Obnm2COXmYiA2U2FCgQhEYSS
         7k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790808328; x=1791413128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mw5hqKS3ct7o0O9F9EDtZ/MEdTAhkcvo8rO194jpxu0=;
        b=Tcxg6xbfAyAd/tcBPmlhKuPkOAb4gIwolT5Y5kVOyrYlwYOktocbpJu6y9J/h7JLCR
         tenP46kv5TUbsYHWY59XZJfubtZVvlLJKo9TFk4+Hoj+yVFHOZtaod1cVcJ4/4/IDE24
         wKpNE1Jqw0VFeA1PZ+hZbRTk/OIcKAZQGeedt3aUwtduqgj2ASGhtVq+vp/ZhkoAfuBs
         8/513zNek3pXvhqWjmQPvIM17022jlZoihEF/WQtQXK1WS9DPv4pNTN0FnFHVQqK3bii
         QU/xaLTKOgPRRJRlKpoWDrVAnwg4oZXdoTFz1T/zDPT5k50WgrM5Is54sEIL4fkN6Iij
         oLrg==
X-Forwarded-Encrypted: i=1; AKwUvBz0S4fBhcXbS9GWyCB35ZbBGzV0+Ek4WWlcHnIdghnsgfPofETV3fA9wYnvKbjBJOO+Tc1DXHs=@vger.kernel.org
X-Gm-Message-State: AFuF++lS2LOPQzzoZIWMClgFEC8Lenm8+ZHQCn1OHrViR1CyqjFpM+rW
	l2SvIFFHNYaV7skGO0YFLxf3Oe//lmxDlIYbPjzrcyMQZ+PXDROWxXho
X-Gm-Gg: AYBFou2NwkT0GcqJFm23JuRPqj3cabHQhHw07lYn3AJhavw8rdUGI5ZbuzmrrVL/zsH
	xRmRF2bz7oDIqLKwC6ivt230qlox6EKAJ9A//K78S8XTRKnBh+pk7er+40/2olDCLu5rFRF02Q8
	W3OI3IgMxiTn3FuJYkLKwyPFKULbid2o8jQU6psE1Xpf1a2Oajg6woim0wc+ooViPAK6WPNfcmf
	+I0h0VTa/NqnN5BGa88sPteQJ7kLibO8IumGXZ+2pS/zerGoyxJtNsy20zjwjCMMkTeLlHI+AZ7
	37WO8UAThYiGfCUp5JkHanWH37fIB/klvWXk9H7oAaClT+BqxifZDLCNPmf0HWRzYoLU/NosdQD
	3lnrCE9Ep3yPCtUrkOJ9msu4sWIS9DcW+rbcz00WMxglP90U9cGTYiXz2XWaQGjb9f6t2wMNn3U
	Clj/tLzyP/pE5favqiDx47R07eFmxeOGCqFV6Kj8wdywIHscSDp164RR82z70FBHBYzPDTl9PzK
	Kxa2nWH
X-Received: by 2002:a05:600c:a43:b0:4a0:561:d0fa with SMTP id 5b1f17b1804b1-4a01b00c51amr47011655e9.18.1790808327880;
        Wed, 30 Sep 2026 15:45:27 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0692ae3fsm1982106f8f.26.2026.09.30.15.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 15:45:26 -0700 (PDT)
Message-ID: <970dac30-6739-44f2-81c6-e79813295f23@gmail.com>
Date: Thu, 1 Oct 2026 01:45:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: digital: fix read of resp->data[0] before length
 check in sens_req
To: netdev-bot+sinfo@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930220857.721985-1-omermetekaya0@gmail.com>
 <179080647916.31693.5412797645123910488@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <179080647916.31693.5412797645123910488@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 01:14, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Manual code inspection.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
It was obvious, I didnt triggered.
