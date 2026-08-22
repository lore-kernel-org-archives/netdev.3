Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E1379C43
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787396130; cv=none; b=fI8VsUsy+b+nsqcIHyBfN3cnCXeK83BNGSkP3yIzfKPZmN1I8UmQ/rtZRHBrQ7k5n/egr4pI6l1kyFR6l+6gt6woF6qO57YasW8lu9hbJRdBvfPvqSM4JjSxtQyvlIcXWfu1N6GVLT4OJ3/7btzfAaccboRiwid3fOt8QXs5I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787396130; c=relaxed/simple;
	bh=mIRVvQlMitwJ2TgSeN+63is4M32mqgfMaLC73/cG5gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INy4bpY1BhI+t9tRFXezTry31rLGUBpNpFHNNcSHElL37u5haiaoDgpLrm+a0IQ8RpIrjTlkUzQKngU35KemhmFfRUaKCivOx7Er6VIoBQGsz5yWT8i6eGriu4sCGMfuQshPR88v/atTe/bhI31eAQp99avpht9tPDUaa54qnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNLqXqYm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNLqXqYm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954dff6536so14702555e9.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787396125; x=1788000925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXeos56KLg2M5NQRpaxXrpkevC0KZ7ingkuH0fmAz58=;
        b=oNLqXqYmtmk/GOas16Z4CR15w6NfzQE1xnkhOq45BnJJlADrHx/sDkDGFd6hkgGee7
         7NUZbLUyjHtprTCJpNUEMiY5Oc2VaPr6VhnSUALoXBTtECJ2RhfFRNy8QK8sejpS3jub
         33rXWb5/QmfrjV9LLHc4IVNg2cy3UVqPsVZ73Vo5OmTdqyVi2B3UVvAp9HBW4VxLZF8u
         lO+2U/RMN/kmPqcXXqgiTBxHPIxTDsTA574LDjDBXU+FO7FOkXRUO9n+rc5kPW8J5UKE
         iCVu7eqs5QppXKy4xyTRgNu+vPqn3CG3zDkyrQonPuApGV540Bnfc/ZhL7oUFoe5OVQb
         uRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787396125; x=1788000925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iXeos56KLg2M5NQRpaxXrpkevC0KZ7ingkuH0fmAz58=;
        b=fQ0kx2NnV6I/0X/x7gksLyMY5Gz1pbraEbmpzDDmgiAow5QnPdbbSKU7hE5toMQoN3
         sbvsXVIxrwNsX6sHaGpgWeylMU3YP1q/kSVaOD/c9oqdTsrw100LolROefzgFuWzbcli
         pwzExRqKH4bW2ObQctkoU3zCGeDn7dQVVsFQUFIhFpyjpJNxrDxfVAx9prR/5M0MBEPx
         YuxzMzO9erQPEmepSEOEGC5wgiPlYwkLbbh2hpZPXynEz8SFhE+8zlYzZK80JPdjZPNX
         v+AvKC5WFNxHE07zO8jv5D5mJ5BOfAQdML11tdefNCNurv9ZQ1Mrf1aprG3NiDKSmGl1
         dVJg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5azT56lu5Tl8lcwQcLhDHslsl/Ept4lPKTdQvqo76utB+qoSIdQKuvcCKvKrHjg2yGhzGzrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kZfnMFgL/2aT0UB4YRPukvDeMNkTHQogV5Rs8tlAuWQMib4AqM
	IrFUrgGqpgkENV/IaGBy3TZgnF2ys+leLsCO6fo52uaxaHXfVki5IZ7V
X-Gm-Gg: AR+sD11037vpxmVY/BOoaXe1wcQQCovJ7crTNaet1J09Bwaw6hCeotuhhC4rmNM9YiM
	VpTJjgX0MGnCP4AVRtZFHV92vsEv/qKsE/tuJULY+uDEiPseOebkQwQEzoLqzUgb31IEMb1D+lQ
	uF/jCdcQqUjUrmmyM/fE8ZN67pGBKW2lZKwH2KH/6RTZFL3n0/weNs9yS5PYf+kzrRo27JZcrh+
	5q13gV0CK3qfVmvsnXm08+tUkAlb0N00D1/rIcjcHUrsD69Pbo7USkInuzFg1vsWmRS7wX96L7Z
	BSXaHcYY3w3x78iUAHZhUuqf0cj4EtvOskMPnn0bQgXR3vDyjEy5utT3mhBAprmeOalehqfXJW+
	rDpHfPP3mqiTJwOCAG4qION44qTF0xqRI+8pBmx1fXhqF35H4rz6XAUqY1lydIpdnccLTkaDS+f
	0KV7H5Jr0HmBwmXMC97PLH6oWUj9PK67o8J41Qt4UsszwxTUnvUKrnUS0S63sXEgC2+j4OWV/CX
	2UEC/ARcHlttjbvVnGGvOHjmid7qZowae4zwbT+bY9TDPTPzgSLkYFievXEMuuEmju0qz8WMGyb
	EsnW3ffF3mZcDQWxVsNEf/qSbBoN+EcOSvxOYrg=
X-Received: by 2002:a05:600c:6217:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-499b8460e7fmr182614885e9.12.1787396125322;
        Sat, 22 Aug 2026 03:55:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915cda6sm65813845e9.14.2026.08.22.03.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 03:55:23 -0700 (PDT)
Message-ID: <f4602941-5010-42de-a59c-4caf3d60b10d@gmail.com>
Date: Sat, 22 Aug 2026 11:55:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: tcp: block mixing readable and unreadable
 frags
To: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com,
 edumazet@google.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net,
 horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 kerneljasonxing@gmail.com, bobbyeshleman@gmail.com, fw@strlen.de
References: <20260814191336.187243-2-almasrymina@google.com>
 <20260818102612.132228-1-pabeni@redhat.com>
 <CAHS8izPid1ZBEE1PqdUZGi10KK0vPZjza-nSOP65h5Munr9bHQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPid1ZBEE1PqdUZGi10KK0vPZjza-nSOP65h5Munr9bHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/26 19:37, Mina Almasry wrote:
> On Tue, Aug 18, 2026 at 3:26 AM Paolo Abeni <pabeni@redhat.com> wrote:
...>> Note the mixing described in the second direction pre-dates this patch
>> (there was no check at all before); the incorrect predicate and the
>> forced re-segmentation are new.  Reaching this also needs a local
>> privileged setup (dmabuf TX binding plus MD5/AO or IPsec plus an ethtool
>> feature change), and in that configuration a devmem send through the copy
>> path would likely already fail in skb_copy_to_page_nocache() since the
>> iovec holds dmabuf offsets rather than user addresses, so this is stated
>> as an observation rather than a demonstrated corruption path.
> 
> Pre-existing issue I think. We indeed assume binding != NULL means the
> send is devmem and zc is set. We missed that we may not set zc if
> NETIF_F_SG is not enabled. Probably the code setting binding to

Hmm, I flagged this one, I'm going to send out the diff I attached
in the thread for v3.

-- 
Pavel Begunkov

