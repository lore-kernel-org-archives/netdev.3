Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300C39B972
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744587; cv=none; b=E4QqwtpPQvrohlpsM7XOVfqqw7ILeYW48CAHFJJYin/Mp1Mvbbg0u3UVW87GzeZidfo1mOnJIwE8WhcgJAJwv7apvtlRnP23mTuBRhuuodBuCqwE2NoZkjnANYJoj8IFYAHwq4O3YY6FV+A5sJl/JTkEkjnicj5PzuSMq7f+hPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744587; c=relaxed/simple;
	bh=1P7TVUs8vlJl5YaJJABUQccUdEzN1O126nG8vfnUGiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2f6A7ya5aY9Ux64I/8oC/dT8JCs4+Kp7iUW3WEV1YqlEhSQzf9zZiE1SlRfdmz+t2n5oiYpcgTu3gVR1IY8MmAarCuTI3UafyGA9AoNm071pp9CFzeGgBNxu7d/7sRkp8q3vGPE9eWwAAaFYtpko3wFIc/HdxVF+2gr6K3RYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHypWULH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8aAHW4J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHypWULH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8aAHW4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785744585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r60CrHQJf16nAPbNtw0Ayb1C3mfQbcUJ+MecIBEbHcc=;
	b=WHypWULH6EmOrYSAXK7M6XTr+4mRWXw1o5cK2o/XxJYfcyMnw5TDXlbvvLvuPDGAn/lwL4
	B/qLYoOouF+vLDVgoRw43iMBiECp782pBDlhUcvPz2xzqmcSZ4oxyEcJIWHwvQFBrjG5zj
	ku+MNRSvJVEpdNOsInRTmuhqEVuf4lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-QXRKc5IrOaiOsHjy8HfYfQ-1; Mon, 03 Aug 2026 04:09:44 -0400
X-MC-Unique: QXRKc5IrOaiOsHjy8HfYfQ-1
X-Mimecast-MFC-AGG-ID: QXRKc5IrOaiOsHjy8HfYfQ_1785744583
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8f8fde2dso2190673f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785744583; x=1786349383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r60CrHQJf16nAPbNtw0Ayb1C3mfQbcUJ+MecIBEbHcc=;
        b=R8aAHW4JgF9BMB9L8M+LSUS/Yhc3Pv0oe62pqTd6T8h15yI0OwG9EROhPyN3on20/b
         0VwVr62kx1UAL7IAA0LnB+qkiz16SCu/RyoPbGFOC9gnK3/pI8aZb3im+qW8dkUu7hAr
         27zeQFaDW5ET4E094o7Ge7RoZebBPS3Wzdokd5tMTMvPFbEXE+NQSO76MojVDCNSIdS0
         yEmXlcaA4EKuLZ7Ibs84p+d49nerSb4U1m1AtdueWkyxobI+sHLkdbAL10ymbs2P8YwI
         3li997E+bmRwJaeNEsfOJvGDY+nD5isvhtLiC6fFAqt57QwOZ1KgQ3WstPn/9eW6vuCp
         ADcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744583; x=1786349383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r60CrHQJf16nAPbNtw0Ayb1C3mfQbcUJ+MecIBEbHcc=;
        b=piCmyKZxOBOsoe/0JIlL9yo/AehOahWkVuM8mrFHRxT9pLqJjLMc9ak63I+AV3gAqf
         M3RWfgaH6zC2YUFSVMYE4bHdqBNulIG18rXn4aKBP+NwGCmxlaGvW7LSLdtpsDc9CQpA
         dQQMDuvU+FKkBhWUf2NYMpd0Y/GuUlR5B9frvkc4KtpQ+635JIfCc7Yf+RgOXhaH2PCs
         RP03KTLgDsmxEzf0sT9XMippoGj+JVV5TlHJBIn8V+T6AiR93gU+g08fIhw8sM8oLWLP
         jjnGSZIy2On6g/UtxVjLA+NiolIRy1HUdBn32oteCQ9fxN61lMtxD/BxmmSOpYSgmqr7
         KhAA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2KIVYA1cFWkAGgl7kRsxzAA+Xl9r8VGD2rR4em3JI+AaZpK6W4BVEnYBJeMFltw/O/a2nOLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxbHqIlGVjZtKendAI0qUVilq/+x1f8Quul7P3G9NR3+G80X9
	MYp7+qz0J7MFybS607uNPweyOvj8yRjMq0SMnk2VRiDPhP6eVzwNqClSq3wTzP2joRhSj5MWOXc
	Tn+qCr3VdCbikPQ0k3qKbINZAeHx4bGr1vNZWsE63QD2d+Q6GQHS+agPuSw==
X-Gm-Gg: AR+sD10G+Ks2AdmYbQV9t1DscDY3HzKRvKofv6pJtP8SEy/MrtbYiFS772OUNlHixvb
	JkegQq8S9AajiHhTVRo55WDHEXY+/gHnqF7VGmNPIL9Ss7VuGmtUZb+6ted4MAjwldCfeM/zDuB
	Fyy6xS2sYIizoJY1qLgSDlCxzxFihu9FCQUZhpUCFgyXDig0VQokzVsjPxek9yRCrPfpowJaAb9
	rAJTQJXNvcpYClRULBhFi/YZoYc5MDu7nAKqOUdpjKgsDJJyv5qwAR3ECD+7FGgPB7SZuAwQsFV
	vAI0Tjfq9TzcghJDfv6l3jNMM+jtepMfeWOHl/JzpenE29cAfd7FilNcmhGOAj1motkBiODpHgl
	2jFFw9rV9zm8ndo7ksOVmAnhKUrb4xlDmNwc97Z4+SXEvUrcndHBxKPbgq+jQE6alnWROTrWgur
	A=
X-Received: by 2002:a05:6000:4615:b0:47f:8887:3b07 with SMTP id ffacd0b85a97d-47fd72d320amr22901430f8f.13.1785744582785;
        Mon, 03 Aug 2026 01:09:42 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:47f:8887:3b07 with SMTP id ffacd0b85a97d-47fd72d320amr22901324f8f.13.1785744582188;
        Mon, 03 Aug 2026 01:09:42 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd64eef60sm25916518f8f.16.2026.08.03.01.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:09:41 -0700 (PDT)
Message-ID: <74f99014-d09e-46ca-9c02-d10570f62fe1@redhat.com>
Date: Mon, 3 Aug 2026 10:09:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in
 tcp_measure_rcv_mss()
To: Jakub Kicinski <kuba@kernel.org>, Nathan Gao <zcgao@amazon.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725030806.28135-1-zcgao@amazon.com>
 <20260731174644.02410e2d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260731174644.02410e2d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 2:46 AM, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 20:08:06 -0700 Nathan Gao wrote:
>> Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
>> ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss()
>> with a call to tcp_set_window_clamp(), a helper that implements the
>> TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
>> rcv_ssthresh via __tcp_adjust_rcv_ssthresh().
>>
>> As a result, each scaling_ratio decrease detected by
>> tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
>> rcv_ssthresh is usually cut under memory pressure and grows via
>> tcp_grow_window().
>>
>> Flows whose segment sizes vary keep scaling_ratio oscillating, which
>> leads to an unstable rcv_ssthresh: a dip of rcv_ssthresh only recovers
>> via tcp_grow_window(), keeping the advertised window at a relatively
>> low level even after the ratio itself has recovered, and can even stall
>> the sender.
>>
>> Observed on a customer's proxy gateway after upgrading from kernel 6.1
>> to 6.12: in the worst case, rcv_ssthresh was cut in half by a
>> scaling_ratio dip. P99 latency jumped from <10ms on 6.1 to ~100ms on
>> 6.12, and almost returned to the 6.1 level with this patch applied.
>>
>> Restore the plain WRITE_ONCE() update of window_clamp, as introduced
>> in commit a2cbb1603943 ("tcp: Update window clamping condition"), and
>> keep the rcvq_space.space adjustment. Now rcv_ssthresh is decoupled from
>> scaling_ratio changes in tcp_measure_rcv_mss().
>>
>> Fixes: f5da7c45188e ("tcp: adjust rcvq_space after updating scaling ratio")
>> Signed-off-by: Nathan Gao <zcgao@amazon.com>
> 
> Not sure, I mean regression is a regression, but also the previous
> behavior seems to have just been lucky rather than correct in principle?
> 
> Looks like Eric and Neal are AFK, Kuniyuki, Paolo, any opinion on this
> patch?
A quick grep confirm that except for f5da7c45188e, only the control path
calls tcp_set_window_clamp(), which IMHO supports this patch rationale.
My understanding is also that this patch should not re-introduce the
issue addressed by the blamed commit.

It would be great to have a pktdrill tests for at least one of the 2
relevant scenarios (the one described here and the one relevant for
f5da7c45188e). My totally uneducated impression is that writing a packet
drill for the case described here should be slightly less difficult than
the other option, as there is no MTU dependency.

TL;DR: I *think* this patch make sense, pktdrill would be helpful but
not a blocker.

/P

