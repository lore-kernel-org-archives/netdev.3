Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779C33EAED
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769532; cv=none; b=Y4E13sr3hwcRP8zCZnwPSw35CPexoaVNf/8Z1g019oWWqsrw7zHHuFDqcQAgtIdBfcX9fiXJScoANSawlHcg+VbdSGFadezwiUR8a0ViI2uLndsQ0YXQjnAka6POr9EM9YS+5gBOalY00bIMk9tyInx8lO/M/pxEmrC6OXjPut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769532; c=relaxed/simple;
	bh=JMA5e3Vhieoy5LOQMLN1Rk6Lk6vh2o6PLFn1addiWl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFJYp9VszU+q3mpQlayUDYvzANDVjGmZYCMEOUZv9KSScKofcDG05IKMetCNUjcj4ohLjA0VnDKE3NHvR2d92R3A9rngQn/VfcnZ3SUFHXag5Dnmd4gX8dQc4ClRLpvTIDqvGgIYSz1p7LdoxdBN/fspjZVgN3ncJDjSf+jSwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUnf0vzs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUnf0vzs"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359108fd24so1176272f8f.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769769529; x=1770374329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4btR4k0rZeSwxf2XbW90LUQwuGXqTdQA1zSC1Z01I8=;
        b=XUnf0vzsrDO1UQANIzsAV+0H1QyKFqlDrH5nKTFklRvubu4B2Q8VsGJYJmMTxQlcyU
         msYruiGO8snZVhSYgDwUhyMEk8a5gjGYfl+r7TGdNP9eQ9+CoPEor175N7+oiQ2xUOwQ
         3rzOnRHSA6bQgrl6OYcgXe86hBnV3W64V991I+87tnS8wAW5wceH5mtae4+E+hPPCy++
         YCBb0HulPIr+GTzDl1nioGpp1yOKIqQtRitH7vA16g0Wfmm8UM3VS9yiUCsFXen+bmWB
         LzkXlLK4pzlnS0KpfwbtPk/r+qg2iLHLZJ1veggSKUCfefF+8RbaQPdv6qUEXKLHf1oj
         nmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769769529; x=1770374329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4btR4k0rZeSwxf2XbW90LUQwuGXqTdQA1zSC1Z01I8=;
        b=gsPl5ar6X/RpwjmFb1RosTJv705MpTeDrnbPReYD7HpXRKBEvBAaHd6C3MpJpX+0xz
         rR8OOAeDHDwxh4h5lXZ556Z0mKonhTKZG1tliMBqzjjPlULJ0+FY89OC0yPjQlPCj+Jn
         nqfArVXapSXwzl9/3EcfwWuRa6ZmcF1Rn+uS7F+btogq9oUbqrP/Vb65xQzHg3oia3uD
         5uvzZK7x3g7E5g4MfywgTKo0elxybOD6vj6iuMgxBOeU5DXWnDSQV4DO4lVY+snQqCdM
         xS9Ggr2ki8mwz0yu0Ze3GqorcklbUvyJHB7jbXklpRUhy1x66ZYHOARWu0Tig4xVkQx6
         0KRA==
X-Gm-Message-State: AOJu0Yw3FEFBoxX1j6brcnc88xqQ0rguhNm65YMqVoh7b3O4MM35oNdw
	xVO0OQ/bYogAL/B8kGDXFNwKR0mO/1KsUtlFDL6IPz//38rSuIYgGmiY
X-Gm-Gg: AZuq6aJeZ8eeWHle/IsVMoBgK43FgRzZOIU1Uf2Lej6I1jgwgvEmNRu/4fRRgj2WknG
	gNLhFBDk4IJkiqzf3KpBr7N2oPwD2+x4OC64XvGgo4TLA7g9owfLICf6jyF0BP2EqSCl8hKxbSz
	VNkDTav2PnRs6uIh3itHZMKzyMgYrqA73dWybqm/BzYgODn8FQpJr2l9OEvFk8DQ8WvLuTqQhpj
	Bxy+56B3YINpC/AQTWiBnrRSEwP2MqBVg2yusuMFvrfnMB8pRhDdOzl7Tajxm7BpqsEM9M9vzA7
	pL0SZj5fUEiiB1vpuYTPILwYki14Gdu2XUJB4rGEZOKnbzO1dkk3pBtUNsPfRXealo5JI6CzCtx
	DZweKuOTx0bAMAL5V5oyjDTGyZSBgtVgJbJ63bX4dxZojmrdJE0PNGFW7UGX87ZEdyASai7YqHM
	ZR2VJkexa4OL3tPVydv6MPvm8KJ6FBpA5vcj9g+q3IkCneUn7lJFIzEezOZ1+/Bl7D844EVExIr
	9eHY46ytZwiksGMkkZkrOwjF/zSU834Y/4iJuKFjFyYtTLWNvh5JZc/jQ==
X-Received: by 2002:a5d:588d:0:b0:430:f97a:6f42 with SMTP id ffacd0b85a97d-435f3abb528mr4022094f8f.54.1769769529137;
        Fri, 30 Jan 2026 02:38:49 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:99eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm20800594f8f.6.2026.01.30.02.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 02:38:47 -0800 (PST)
Message-ID: <30fa29da-6e7d-424c-9169-b61a057d992c@gmail.com>
Date: Fri, 30 Jan 2026 10:38:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: bnxt: make sure we populate the qcfg
 defaults on old FW/HW
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com
References: <20260128193258.125274-1-kuba@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260128193258.125274-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/26 19:32, Jakub Kicinski wrote:
> The driver now depends on the core to tell it what the rx page size
> should be for the agg ring. We must populate the ndo_default_qcfg
> callback even if we don't support any queue ops.
> 
> This fixes:
>    Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
>    RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3852)
> 
> with fw version 225.1.109.0.

fwiw, looks good, thanks for the fix

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

