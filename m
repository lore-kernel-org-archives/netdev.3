Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E093E92B1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562789; cv=none; b=dLC4K/6xO9+CSjEWXtKrkRUwrChDRe5wcjCa4N+cLCjy6Id7kZe9kZ/+8E9RvcZISLxeXtvkDMxVOMry3UPltqG89DeZCF0VlS/gRFrNS8gxufJyQ/n6syr4Xqhlr4ULgsnYzpWeSX6ARnfN5k3f5WzyDwu8EIX2NiI/3LV4nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562789; c=relaxed/simple;
	bh=TzGkKn8TD3NZ/cb7c3NDgkoUymg3dMeC56+V0+NIcKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXL7TQvCR5IvTXd829ovXIaPq2tzhikCJeN/ZPzp5Q80C7pHOFEu8Kyo5sHMy0ubmT8hiLo9OukdPNJxWVIBJmbr9i1ViZsk9XpOsnyC5kgWUudCY9pwlat2oN0ICMIp837qHY8ru3EnmZPiDOMFuBhEsYuK3CwFla74OHUy1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcnJDbFC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHNeCW/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcnJDbFC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHNeCW/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780562787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QOMNMy5WtR0fKQJlZyg9RUw7wF3IZTQobfw9Y4B4IE=;
	b=YcnJDbFCfM3In5wMbOeoGBPkLrF/JseOczYxUu7Rp12Xdczxy7vaOzIB2mlQiuNVpOfknD
	+p//dC2O+2RN8fUq6QB5VakNr7Hfk8t5zuGB8ti+w9VBAXL26beKOia6YQ9gMWku4v33Sw
	DIytJ7dhD8yqCNgBo1XBL1+jSGt/AyE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-YLm3RoChMD-gmlilFh3gnw-1; Thu, 04 Jun 2026 04:46:25 -0400
X-MC-Unique: YLm3RoChMD-gmlilFh3gnw-1
X-Mimecast-MFC-AGG-ID: YLm3RoChMD-gmlilFh3gnw_1780562784
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa7755faso181426f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780562784; x=1781167584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QOMNMy5WtR0fKQJlZyg9RUw7wF3IZTQobfw9Y4B4IE=;
        b=jHNeCW/I4KAtYLcanIsmx6xX2op1rQNYq6MPDFUyv+6POYxuOdkG2er+Y1rCdFsuC8
         OCp1PI3JLcdAEAoHL4jYjPCMhtNMfWaqy1eo6Eqw2z/tneuuiQNsT+vJclUIhAwqJkmp
         5NRYEl6xadf+FuSAqt5vxss4JL3GOIqbm+EP2Atd0GMMn7ORMh/ssnpw0IZjmE7aLvsC
         wewcv/hSdr/Lixkutw2PC5MpI5GYlk2klyHN8YN1aTi2Fj7fmBo0gXo7DBPEv3lpJLYA
         hSEP0cD/2bEf7qDPmYAYtUKcvAANaF5qjcMaTLgZhY0x+/e2n3LPlhjSdMaWT5TlyiuQ
         x52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562784; x=1781167584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QOMNMy5WtR0fKQJlZyg9RUw7wF3IZTQobfw9Y4B4IE=;
        b=KRG77JP4ri2Owx9SBc1EwVHiPaNsfARx68Eznxu/xH/mFHf3Y2mDlkdD071i9i5zsU
         a7OeWM26V2TrMGVgA6hamNEt4x9i0YlTD2KW/mDpWGH4k29oPWHyeypFH8vGDFBcW4V3
         Lr4Vb56D4KnC4wNAJs1SVS9EYJFL7S1k06WSIZI6LelQExCVgV6tPs0OfCOB96XEaHib
         B4VInvH4Az/Qj3twseA3OLGsKzpNin+8y6Vjkiynp977UyAjLk2E5YMKPuqW0wgjL8N6
         A8uxTIdcKw+ejspQMgzzu+GMqQWINsdcIXM5tPNxxp2d+o/ZzHzB/eM+4wEc1ypf42yj
         0ShQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dxW7ySQ3kECvmenPMIDeT0mOOPRB6DpOYreUt57Gij7TboEdq2w2+Mx5l+sGj64jDpZHeQxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmAzyjgcbI3uKnP73woQNI8DF+Oz2uuP7YKrWIAMIjJQS4v09
	69694Ak6Z0AuzpvShncLBf0Imr+uu7c3CgROh5c9i3SdySDODxUvIM/Ri+U8q2gAton13Mj6POi
	RxSEHbPY09qtfmejY8sOJ+c8dQHQgqKZPF+lYGcZJOowZmccH1v/SRw/93fKMqtF8SA==
X-Gm-Gg: Acq92OFMFt51M2Ti0H+WhoufkTNek1wYPJX+yA+W8fvPdTMtllM2r8OBAllIV4kjMIE
	nvThgRyFJAdzwSusuwzB4C5uT1nU9x+afFJ93Dn5htEWWisAWr6bq/wyvPFfqs4yLvE0NzGqgGO
	nkyWIcO8yjtWNSOlESiw1yErFfXlPenby7BJ7vtSP0ZD652JkL/ptOucoMeRONkr7BU7nqgDVvL
	YghvWgYsvBL3VOVx4CYMF+0QwH0FBhg7UW9DiF68AholYGeNX87mvhzkO4ADdBlZUhgSUH+iL1o
	kgoYo2lTDE0GmQvWJAIQKFn8rjsfX+6gDmuL4qb+va9aDfjMw1qgYC5v2rdEWx4KUcS4eWvaa4l
	kTB1uH3Fh1CRZHxTcTmcGpDfBR9IvWrRac44DTo7Juq3yJ6cm+gliuU6k6LPg6CO0kdk=
X-Received: by 2002:a05:600c:8b30:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490b5eb4aeemr108691405e9.9.1780562783999;
        Thu, 04 Jun 2026 01:46:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8b30:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490b5eb4aeemr108690905e9.9.1780562783650;
        Thu, 04 Jun 2026 01:46:23 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm56479775e9.6.2026.06.04.01.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:46:23 -0700 (PDT)
Message-ID: <fc531060-6ff9-467c-b04d-1a913f6c718e@redhat.com>
Date: Thu, 4 Jun 2026 10:46:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: validate ip_forward_options() option fields
 against skb tail
To: Ido Schimmel <idosch@nvidia.com>, Qi Tang <tpluszz77@gmail.com>
Cc: fw@strlen.de, jiayuan.chen@linux.dev, pablo@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 horms@kernel.org, lyutoon@gmail.com, stable@vger.kernel.org
References: <ahlfI38aDciPfG2S@strlen.de>
 <20260529104356.911666-1-tpluszz77@gmail.com>
 <20260531121711.GA189496@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260531121711.GA189496@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

31/26 2:17 PM, Ido Schimmel wrote:
> On Fri, May 29, 2026 at 06:43:56PM +0800, Qi Tang wrote:
>> Florian Westphal <fw@strlen.de> wrote:
>>> I'm not sure netfilter is the only facility that can munge data this
>>> way nowadays.  The plan is to disable arbitrary network header rewrites:
>>>
>>> https://lore.kernel.org/netfilter-devel/20260527121147.22076-1-fw@strlen.de/
>>
>> Agreed, the source side is the better place for this on mainline.
>>
>> I went looking for other ways into the window between option compile
>> (ip_rcv_options() in ip_rcv_finish_core, after PREROUTING) and
>> ip_forward_options(), and only found nft_payload and nfqueue at the
>> FORWARD hook. tc/cls-act run before compile (ingress) or after
>> ip_forward_options (egress), BPF at the netfilter hook can't write the
>> packet (base helpers only, no bpf_skb_store_bytes), and the LWT_IN BPF
>> path is blocked by the verifier. So your two-part restriction closes the
>> only in-tree triggers I could find.
>>
>> This is just one consumer of the pattern; __ip_options_echo(),
>> ipmr_cache_report() and the CIPSO/CALIPSO netlbl_skbuff_getattr() path
>> are the same, posted as a series here:
>>
>>   https://lore.kernel.org/netdev/20260524041442.2432071-1-tpluszz77@gmail.com/
>>
>> so if the source-side restriction is the way to go it probably makes
>> more sense to drop these consumer-side checks than to fix each site.
>> Your call.
> 
> FWIW, I agree that it would be better to go with Florian's patches
> rather than always assuming that we can't trust the data that was parsed
> from the IP options.


FTR, I agree with the above plan.

/P

