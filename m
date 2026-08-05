Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF713DE430
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914733; cv=none; b=e6EM5YCmuda1vo4JCJ0pfWA6y7pXKWirafXTj5Y7xFamuLCh6RpKKlIcYDgxBM8c/rkJVZUC9sLgd3xrbDAa6uS7EtxCsbtZDRgvHyS9uDbiFHxeTYiKj1SuDE2qqrKXCoJU9zpyZeHdtcdluJbzIw3cdIdkPxw3Jl4YO0ntd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914733; c=relaxed/simple;
	bh=/8Mv1AI8B8h5q/dmK7nmITSjN4hpVuEk++uwNc/Z+/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhnwCyWvGpmBK3WkMff8WHJJQ+IZyXF3mt7p0+ZR4WpzYYaQcEXBSr4K1PZqkodOh0rg/2HMB6Zqb9jdEmUQZD8e0TJBRXFV3A6bg8BfoepwKeqD/JAvz8rL0HZgvLEKIwUPSyl/LOzBcZ1zeWLy2NLGVQf7/6MnKh0yibDpgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWJ77i+8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0FV8Ztd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWJ77i+8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0FV8Ztd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785914731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weTz5xMfFtmCj3eZsPtup6Hy3D3peSbc8vAfiLIUMAU=;
	b=gWJ77i+8EurRQ3muhy2sSScM03nxn5wUP3c9nUmjzH8q9TMmQHH07QyY7/N5dlBDKhcSRo
	s+UUilvlFEYz5Hzxs2cbLbdMTOUXapA+u2AaANxD0f9W/0ZhAMLWvLGI5fqmQ47ejUYSBZ
	LGLAXjwteBnbTywGf+WtIKiVDt1vYXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-87-5Tn-6O8-g8np3SUBBHQ-1; Wed, 05 Aug 2026 03:25:29 -0400
X-MC-Unique: 87-5Tn-6O8-g8np3SUBBHQ-1
X-Mimecast-MFC-AGG-ID: 87-5Tn-6O8-g8np3SUBBHQ_1785914728
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso6022385e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785914728; x=1786519528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weTz5xMfFtmCj3eZsPtup6Hy3D3peSbc8vAfiLIUMAU=;
        b=Q0FV8ZtdVIu91NkIbgsL9TD6rN+BrysuEDzZSBjv8ubCA/uGVPq42g1Lo74TmqgiyN
         C9eq5JkD7SSjKAn0tzlB9/VuoRFn3pX3hpLc3vuUQww1j/+Zh90vppHvVio6OKXlEl5B
         wionqDl3FJxIx0CipioWtXbq0ano72L6tDJ+0pCrpGPZX1C2TtHESoPTrik+5ICYqKiI
         Ieq6rvjqYcdiq4VifuMfsr8xVNiyqvs15DeY0Rznptztf3KLINZV2rluY6R7nxMbBasg
         qMXLQnHHz04X/gPC4Y3yHj/0YUxKEKB+BHCLULk56+6Zgv3x4FEnxvo33a2E80j1SoLI
         JYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914728; x=1786519528;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weTz5xMfFtmCj3eZsPtup6Hy3D3peSbc8vAfiLIUMAU=;
        b=E5dRleZCl4LSr7EpbB+WcjtDBLYaTNwLxoUJ32/NNnDAACzDG+FpyVgNdVtHHczSoa
         heeHJ06hKaflyxrFSfACMVBZIqcnPfDLEfhvPNRXpJLq496uxVEMZbc/AyB7WyGPBRLY
         UsT/zQW/p4X5lcVekD/BXawJnPCa5QcA6GdNkKkKCyCU1ysUa4Y+cUlTwdn/2Hjc2h8Y
         NtMXrm/uDiqLZaYfeY9X+0WUFkLhRgLwhDKw+3OVRwEJcUYHdFxLPSowYurlwy+DsUde
         lCQ8fBHzfGLYoknrTkuGQ+mTFDTkDkL7xw4BX7DSD+JDOw/E0Pe5uX1RrKVU9F/HILTa
         D5wA==
X-Forwarded-Encrypted: i=1; AHgh+Rrmf5EAxcNO7pGDa9be7ayRf7JWw1kADs0dKiKGGFY8bkgBnhko8gzl4AECdGVcmfo/c9lulG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjzPvkDjTrxL5Sh1CQ2TvDG5oeYUPHaAq8HTfcrAUeAT/JwCT
	FjwKRkIamiqeXtz/UOYfJLvv0C9Pk8D/7o4iOBBQJY6uKtS4T4F0VBbO8kbiWpHsKyxlYxjiJwV
	DfuOSj9YtKtyMyDbH/0nWHtv31u6CJfyaLfpnnhtHt/vMqIn2YS5AOUs6Sw==
X-Gm-Gg: AR+sD139NvLrlYWWRgB+ASDwVwlzDb/J7O6bnM49pumHlJTSHCAIYNYET2+oTDZtUnb
	UQVgbD30toNi8K/zXxQGzs/s4Jv8n5rxHr3U2pDt534glh3BWq/pP6QnypNhq5/9ea2/IOEtrCv
	qNE9wPjz3SV7wz7HztqCmAF/Iy2KbFlMrFJUicKSOLnH9eUifN+zfwrcqDQVO6yyiIcZPa+mzrZ
	hNBqslXlZ610mAuIMUtDLYZ2YuI+UZFOxbKWVRX2kPkjrKOX/iw8Q0GxFj6fAz80J9SiVmRjRcd
	inPefMhJdaPF5GcObeC1nwx6N1mM9HAzaENoUSmeIeOXuFK4cteiYsbylQ6RtPtwhkeuy6rwrIp
	vyldB/dLo6XiuPEuS++096LuApmKOabou//heuKTjmw+ZnTx2wfvdCKTtWaPN7TSnxBALsZwdyx
	8=
X-Received: by 2002:a05:600c:4f83:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4994e6c4194mr53322295e9.0.1785914728298;
        Wed, 05 Aug 2026 00:25:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4f83:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4994e6c4194mr53321845e9.0.1785914727896;
        Wed, 05 Aug 2026 00:25:27 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e03589asm58416655e9.9.2026.08.05.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 00:25:27 -0700 (PDT)
Message-ID: <4c70e63c-3b6d-46a0-bba0-33335f73071a@redhat.com>
Date: Wed, 5 Aug 2026 09:25:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/10] netfilter: ebt_nflog: pin the NFLOG backend
To: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 horms@kernel.org
References: <20260731151806.849724-3-pablo@netfilter.org>
 <20260805001529.3978646-1-kuba@kernel.org> <anLiOdg5xYKNoNLL@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <anLiOdg5xYKNoNLL@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 9:11 AM, Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> ---
>> netfilter: ebt_nflog: pin the NFLOG backend
> 
> We need a way to annotate patches that they have known followups.

Willem used direct command to sashiko after the '---' separator:

https://lore.kernel.org/netdev/20260726202902.760552-8-willemdebruijn.kernel@gmail.com/

and it looks like that would work. I'm not sure if such per patch
annotation fits a PR creation, possibly landing it in the cover letter
would work. At least would work for human reviews.

/P

