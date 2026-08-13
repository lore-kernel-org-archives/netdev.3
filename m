Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DD41A4F8
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651060; cv=none; b=T2Ng9OVZSMuBFNeyAnfPuOZ7LYFPeL1l9mVJAZrKCZqpATi1675T7cjP9ownDFF+me16oYGgelvdbM7QpePEvgja/5TKSc1HUV1MSdhLOTmDDOaUjGvoOdLl4ZS98cG2vbO/YMCHSrb6fyUNvgVs9toFy9+Y5pfQmt0FFuF6bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651060; c=relaxed/simple;
	bh=mmcczImX4Np6efXPFHf7qJj0HMqdd2GpYjV8ap04iq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhkoFcen+Sc+QzYx0FaPBbjNl3BYgiYlHMW7tzZPdqyPLKYPYARLMaubrOG41DzH6utAg6oyLKZtiMNAmZYXQiy62Dm8R8QgUxB43FWUd3MNCS0YxSUsYK7feVYN5NfDjgDDlW1aC9tK25mgwoPilRkrD9UL3G/V2CyxMNPPxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7O2n5EH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7O2n5EH"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e7c6ec9dbso16955085a.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651058; x=1787255858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QozjQGqxrfRYTn9bsQLY9O0yeFB4hAJLRkCJPd0/Bok=;
        b=L7O2n5EH1t0e/T1rWV/VAqVdCjKdl1H9l489vscHg8Of2aKXv0mjjNGtiUjIu6bnuV
         wABfvFTfpHjg2ufG1y8GH0I2KNijnBetpKzfEDjXuND2IlO5a+wl3KqCTX5jCor9KVrr
         VALo6ZFinOXyh8uorvc/FoNfij7Zc7alcSAI0Dhdh5nZ0apYxj0G92z2bGyPCQACGEXh
         tGQbNybFwsBYasmRpFYxo2uoZ7rUoratKM5/CkpX5jJhADeYKq6ACGqwu0fwaOq67PBQ
         6z2kwmLoo8oV5FhgHCcMFXnlnK/NmjkvycIeVieXwy6/jq6JQXNIzZ9SMp/qPFrq48Cq
         Oasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651058; x=1787255858;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QozjQGqxrfRYTn9bsQLY9O0yeFB4hAJLRkCJPd0/Bok=;
        b=k/jY600uzTcwXtE7rUQrikNjfxoQyZYGyxbkM5lyQzJMpQQ1cOmx2EzK0jknaThX9Y
         QuOfglqHjEc8vqwyh4BUMK82z+vYalRAbHGrdfCFn/b25vUf0l3QBTkbQXqYoXQGnTgF
         vYfs4DCD5xTfSPb5X4poo2F3wv3w3B8Ya4mrzSR5ZowaUo/BHC4nRUhjoNfSN4A4U6pR
         N4/y7b5wJ+dLQoTFvLzjCCc2U7vGYO67JMDVv2fBGVGaqLYXld7Q04eSZ0yYQe+1teSa
         UMdi0Ao0yu6h5+bywC3vfKm5sSmlXtHzXTKEc5C6tY2oCsf+uP6JTDXpQtBCqpQIsRA0
         C8pg==
X-Forwarded-Encrypted: i=1; AHgh+RrKhjQW7Zi9ogWbMT+1ysIHGLMtUUxfVcsIVnXB6jNQITqbnLpKLmaDOg5K+YeXqtldSZBaq6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmMfXa6JAal8oNaUnBFKJoc4p1vWlxNBAd1An2v8I81UvnYDf
	IixnbxKKdEVepfqUMio5F/ut1TosZ1qY6SjynTm/pKqTHa0pgxi2YGVI
X-Gm-Gg: AR+sD12AxReAPEHQW7f1HmC8iY2TtA8ru1sugPaUijfFfttg4xYdl9QIl86IX6953Bg
	hmgp9fpC13RdHZdDRgkK6Xx209zAwfTdGE0HwSqWiBxR7KDEXAEkOOVynwjtAl1DTDxD//FP152
	GojEytRJ9RoJuT8qEGyoYSrUccFpO+aGSyP54sHZNKy1hDFXLjCfpnBhwKSCKSQJMaZggGL3NOt
	c3f+iqM6av4MYsP8KuWee5kIbkEE0eEXYic55pTe+uAniASoaFHabMPjjsWzVCu+kJppZwtaOnp
	UqUcgN0km+EJ4S2svNA5x8Ytp2WQxB+9uUZVZsGvA3F5Qxj2BJFlY6XsBIvTEfT6XTKBhodlptk
	8WkZw+U7dJVi/8F5HrJUY0fSqqeneDg96LJ0J58YInv7g/jChfPs4lnuqvOvC5S7Qmon04X8vBQ
	/mHz/MpZBS1aeVY8KsvoFjPJZFvGHPX3ci4Dw5NdiCkhjsoQ23ShbfPAsuvzN021rSDGlDsMjHN
	E66dhi/Ciuvi6Kvwc5tXg/SPqMqhYKN+QZTPT+Cc9r4HYIhaaP/VQ==
X-Received: by 2002:a05:620a:4bca:b0:930:f7ee:2ce6 with SMTP id af79cd13be357-936d234212bmr9290485a.31.1786651058316;
        Thu, 13 Aug 2026 12:57:38 -0700 (PDT)
Received: from ?IPV6:2600:4040:9399:4000:e553:72e5:7d37:c7ef? ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce22b36asm63089485a.39.2026.08.13.12.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 12:57:37 -0700 (PDT)
Message-ID: <522517bd-869c-442d-81c8-c0236563a925@gmail.com>
Date: Thu, 13 Aug 2026 15:57:36 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on netdev
 psp_dev
To: Wei Wang <weibunny.kernel@gmail.com>, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wei Wang <weibunny@fb.com>, kernel test robot <lkp@intel.com>
References: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 3:34 PM, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> sparse reports:
> 
>    net/psp/psp_nl.c:513:13: sparse: sparse: cast removes address space
>    '__rcu' of expression
> 
> cmpxchg() returns typeof(*ptr) and its internal casts strip the __rcu
> annotation. Wrap it in unrcu_pointer(), the documented way to use an
> __rcu pointer with xchg() and friends.
> 
> This was introduced by commit 06c2dce2d0f6 ("psp: add new netlink cmd
> for dev-assoc and dev-disassoc").
> 
> No functional change intended.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608080910.l9KvOH7O-lkp@intel.com/
> Signed-off-by: Wei Wang <weibunny@fb.com>
Commits targeting the net tree need a fixes tag.
