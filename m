Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812D438033
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751650; cv=none; b=urIpYuxVP3BVt9n26R05TE+YIebg3sHcTzmba8w0s2n8Wvlzx8JswJZsKS07QLwrPBymH+aOAUkW9BSn1LBslBV+MF0Zp6xwcRWwM5em61gJV+P3vuIgJ4xra9POSjFPiOb9IdEPfSsFaZ5kXFt74YeyAnLKwoe1/QSG0V3qyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751650; c=relaxed/simple;
	bh=XFcVnZ1JMMpUgAucM08M423rlkCr9Yrg63fjcbz35HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoZYtNJIM6u70CVxwVFCQ1KFlyDsvnHCFXqECtUVbuutkttxV7FObnbw1wcKvVnsF1n45edQ2pMH4RSsAgaEv/NR4Ob1NBxnu8pxQkD1lyAEArpOKtkIrNehYNKjfGGjAU+OG7ZX3r/ldBDkUfOXLsTflo/JF1wy8JTA4Pml/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO8rLZoB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO8rLZoB"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-475417f010dso7467482f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751647; x=1785356447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99tDYKoCjAeR+uC3Qtgyha0AZSbo6n9nIxr6q2CXVBU=;
        b=bO8rLZoBbib2NHOp4Cv6iAo82CIIu1Q5uowx7PbuNJ/RECI2hQiXQlHWlmob+0cWOz
         z+hFTwqAslbQZ/rnmFlnRyI3otDwTchTcv0kULfrVQrxyAXAObVteXnVDbsRBV5+kT3u
         Uq1G5Wk456uk3XAIlHJX0yUwSfEwbol8J+oNRIBKrYOBra5vv53xxxwrtAnxx1Wr5FON
         smRcqYPO+UsS9fIkXBAkWAZnUdXFX5J7cCsXj4HafUFbn+P0kvh71nFNjecJU1DXQI7n
         5rYEKaqH5pk4Nve/IdePydu8J14RN/qjtO0jfzjmRH5Voapb5OFbh4uw/wS2tCoTKYpa
         Xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751647; x=1785356447;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99tDYKoCjAeR+uC3Qtgyha0AZSbo6n9nIxr6q2CXVBU=;
        b=UZyLtk5sG5rYTcateHnsC4MKMfSXnQQOWLyadoRQlvCFpT0s4fBBjO2/T7QEIsb3Zf
         1ePiE/5MLZ3Ag3YfGcpgoAO7lg8d0BV5w1UaXM9l8PppFMaH+Oo5w529pcZlBhSEJX85
         m1/uIA8/0BfH1lPxVBd4e5GOzr9qOEPOZHiT5XQjz8h2xLlA5AUfqS5Qahhqha7CVrg9
         YIUdu3s2lmbcxz9n+i+EDTRNkFINVHmJWWmV2oMGXyrVfuYvkaMzzN54nkwkXIuwCgZR
         vFfJNQzTgRDhXK99CXRhDeAcMqRb/XJYuOB3ytDi3PEJhl4kMjLhGmtGdFm2vz8yaGcC
         nFeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvxtpJyMLpx1ueOE0Kgni3+omNS1cBj8sQP0EUt1RxlSn/bJnxnLx6yCm+0KfjrCQtfVgbtpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWtSleZNycIRgz8TGax1Q/59qB0bNu1c4pk67eF0HKiDy1gJK
	wdCB450De3YAqlXRRdYr/Fk10gtIGX3ZsHNJPOX86kSkbYA5fxD7V8oG
X-Gm-Gg: AR+sD10IJhlwMV4oT8AVKX10T1W+ORKbQYxB48CJlnGFRNFCh7tYFVi0eK1j7LhloOP
	X1bEfS7oTGypYvsMI+C3Lo/ttve0vH2FQmfY390/485paLnpbFa/jQu8wa82Z9IOwcpRE0zuE+4
	ByGhr8j1h/oV/klfyNwHqLoB6avM65BDoEvDp4O6qXLmFq9QDzmAjzss4qHMmj5/reOL5AxvnNP
	Y1DOyqFvJmwMH5jFC3FaVxv99wy9m1Sa6g4ECzXUpnM9HZYO+LmY8UVBmBKEgs7bIi9DG8Oz5UM
	B7ZtanwHTJvmmSWAF3xCXJtkAklSBteWGqId+fQffS/yZRPL+05+Ygd+tCjLBo90+8lTJZ0ozb4
	n112RQkXq2e8RMgK1nxhccMpRNDs8u5j+XkSAZO28h+RAULurmKRE/ncDlehV4kZNSksXRpl/b8
	b8DxdWZQu83Q0TU/+Ikta1u7Psbr40AOFw9e17OQlSBKc6LQl5gtrOg2gMSHyTX9AgwcJ2/mXiN
	73phBeqRY7htvHtU8PAWuLROJ1kE9g+JnImuoNSjuKad8k2rj1sVp4U
X-Received: by 2002:a05:6000:2c04:b0:47f:80c3:92a4 with SMTP id ffacd0b85a97d-47f8dc84638mr365179f8f.40.1784751646970;
        Wed, 22 Jul 2026 13:20:46 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm9228007f8f.33.2026.07.22.13.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 13:20:45 -0700 (PDT)
Message-ID: <d40fc502-8437-457c-b561-cf82ab8dacae@gmail.com>
Date: Wed, 22 Jul 2026 21:20:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Mina Almasry <almasrymina@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/26 20:49, Mina Almasry wrote:
> On Wed, Jul 22, 2026 at 3:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> We should either have net_iov or page backed frags in a single skb,
>> otherwise it blows up down the stack. Don't allow mixing in
>> zerocopy_fill_skb_from_devmem().
>>
>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> It's true that we don't support mixing niov types and doing so would
> blow up, but this is an unnecessary defensive check imo. The calling
> code should not (and does not, I hope) have an edge case where it
> tries to mix and match niov types.

Nope, that can easily happen.

> Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
> may be fine?
> 
> Also we don't really support mixing different niov sub-types in an skb
> (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> and check that it's all devmem niovs specifically.

All those type intermixing rules might be flaky, maybe we should
start with DEBUG_NET_WARN_ON, but at least for tx from a quick
look it's handled by ubuf_info checks.

> And might as well put the check in skb_add_rx_frag_netmem. It's the
> same situation on RX, we don't support mixing there (and I hope no
> code path leads to mixing today).

A DEBUG_NET_WARN_ON there might be a very good idea, I agree.

-- 
Pavel Begunkov

