Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B074585992
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888255; cv=none; b=aBObLwPK7LTIn0h5T4exJgzT244PrSunl87miETOvKpDIeqMLdTx76JRt/YUpoCEPxO4Xo1diEnTZ7GwxVIbsNruNYUUcSRH4iFaCUa3pBS0EvkCxRUZIHERprNcLHeHu96ETQiLKU3lQtIak3ZeL18LahRJ+ldc0cp2+0+tBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888255; c=relaxed/simple;
	bh=s0OqfpsPIg8Pt5MSt+q+QpDOM4qK5fQ2tO+qofR7IlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbfA0H2k4p4TxRuEV6pun4eV6dUw9EYuo4NgkekNyDEq8a7JeQYedYjfJ+MNPYEdw1EZUHLi7ca7Q6S4SwEnEv65rxy9mFCASzv4EYNX876vfENEXViVua9E/6Zj+Nm1+GcNod7O7F81MXCimeK2Ofv3mnMJT5TyYj1UE0bFqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TitShCQc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+bDsrDY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TitShCQc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+bDsrDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788888252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4zf3Bcth3KBrAV1HNbPy8i6LJNKukq2cg+8Mcd17pg=;
	b=TitShCQc9uCUosll1QQgFkgsUzmSt9EXYUqN9bdMd9gAy7VrPcsSDHNjSvotfmMVuSrBLw
	UsZK4ctcD1dkwtNfbNnEdCnIVCnVteCgzMWZcq6AwyzfHc6BPBl7L0c0pAMbSDiGa3K53l
	vafcbzN6q+wpfFX7GZhhwfSYisDGv5c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-JygqLXH1OKeLb0IdKsXV6w-1; Tue, 08 Sep 2026 13:24:11 -0400
X-MC-Unique: JygqLXH1OKeLb0IdKsXV6w-1
X-Mimecast-MFC-AGG-ID: JygqLXH1OKeLb0IdKsXV6w_1788888250
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48584d903ddso1598931f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788888250; x=1789493050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O4zf3Bcth3KBrAV1HNbPy8i6LJNKukq2cg+8Mcd17pg=;
        b=a+bDsrDY/FHAd0WI6qqy6pTOfeqZUSW6EbLYbFrtbgxzhdTb11D8OnqkKRR6L8GWdC
         E14NyPQcRKaZx14Jo+tgSnJnjx5iAz90ZoFxCryr/toIwv6PJoQuSMLLSpPxDelf0i5Y
         9aEFtvVspXJhU3g9iPil8NwXTiiBPzBrCAaW0DgiOiRcMUrjIEYty07tMAprYXewvQls
         ZfTEbc5GQJ+mohTphL9PoVLVXyec+yUBUYJu/OEUUoG2mTJCgBnYxAfYE0PE65i5PcG6
         inQACt7jyR9aSSR8iHS9g2K6U9CYJQM/OsZBHNt0itFbYF/PCtoX/NcTqQw1dgyg2zRc
         3Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888250; x=1789493050;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4zf3Bcth3KBrAV1HNbPy8i6LJNKukq2cg+8Mcd17pg=;
        b=KR7M8tNdlhSwFZ47cTHldr+KuDAswl9beoAOFb8KbK7VgcVFyszcfU6HsecgdyRKdW
         1ee11+YpH5xhQeKYJjRieG2B+bH0Hnjr1LLchSsfgqFkqW+oLSObmq7O7SMIViG9/1Kk
         ZzDaaXgqJa1UshWdRhkEdX0kIBZgppMY1y4cTovsLwQS+6ei+3CRQCuiZ/gjjPpqyqC6
         a9kDdwWga3CedcmRQn2nttEbyeGoSVdXoDbxp6QW0AHG1AlkPgIcJIpQE01URnfzZxAB
         3s/LzxeYVpKFDD0fyEA+DotJA46U0KoNAT2DqWoLxei3gEphbCkIRu2sBZ0x+sGWkwCd
         o46Q==
X-Gm-Message-State: AFuF++mJz5eMGT3QDs9jxz04+LkCTJyfQnyQMSKFEkACGqBt3rGEG6xi
	DoEpMxmDQ6R2acw3KHHMLc1zIuJfFxCiOrPXApR+dxt16USWC91nCVy2dVJNQgk6Ez0f+su8RRE
	VmiXa1PYeCicMGXM7H3FHEio+Br8iEx6YJjPwb4zxqju5S6j/1ILxv0vAhg==
X-Gm-Gg: AYBFou3rPEP3X3jjmAqzxG70E2S5p/y/U3c+zTFMJkE3OD+u8NWZXIQyZPrLak05Zsz
	WmH9SVZzDj8uedOfxicbRtBKeOozda433P3/IH1VfMh/1eghswBtZNBctZhbCHGV1kgnR1NBbGT
	QJi9027rZ5BTzUOPeUN0rTmPALX2N+TpN4LaVaYemfglN7S7ni1I0/H33uOFszUVZTjNi3rIRFB
	qUfspN2DzWSIU2epgObqK8Vz+GTfx7MMShnfChRia3K/sLB34RcuuNjKuYsCn23kJwQaO+dgXvE
	2WCdCh2l8JjyDCHV/jZ5fGtYpTM5B7ed8G7e2n/GWRGJELzRzZPE7/lk2PCdizsJLn3odQX9k5N
	6WPEso+thUzPqczegNLBPk1ERiXoBEGsLI4PHi8zvg8VDkf/lBbA760e6bJjcKLCDaz45w2kHtg
	==
X-Received: by 2002:a05:6000:240e:b0:485:8f9c:2879 with SMTP id ffacd0b85a97d-4858f9c29e1mr22870857f8f.6.1788888250090;
        Tue, 08 Sep 2026 10:24:10 -0700 (PDT)
X-Received: by 2002:a05:6000:240e:b0:485:8f9c:2879 with SMTP id ffacd0b85a97d-4858f9c29e1mr22870808f8f.6.1788888249682;
        Tue, 08 Sep 2026 10:24:09 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm41479448f8f.33.2026.09.08.10.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 10:24:08 -0700 (PDT)
Message-ID: <1336f255-aa74-4e72-97be-c12e07ef3039@redhat.com>
Date: Tue, 8 Sep 2026 19:24:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 0/4] eth: fbnic: a collection of fixes
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 Simon Horman <horms@kernel.org>
References: <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
 <97beb3b1-95ce-4cfe-83b3-cbef9cd514cc@redhat.com>
 <CAKgT0UddZ6DMm2aiXQ=h4KrF3-WHeBG0iM-E5-TMKHu_LPUXtA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAKgT0UddZ6DMm2aiXQ=h4KrF3-WHeBG0iM-E5-TMKHu_LPUXtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/26 7:01 PM, Alexander Duyck wrote:
> On Tue, Sep 8, 2026 at 2:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> I think some of the comments from sashiko (the high ones on patch 2 and
>> 3) should be addressed in the same series.
>>
>> Alex, please note that the current expectation is for the submitter to
>> treat sashiko comments alike to human reviewer's one, see commit
>> c82ff94592fb68f529afe63ca7f5ddb7dae4ba83.
> 
> Thanks. I will go through and address the comments. I assume that in
> the cases where the AI is recommending something due to lacking
> context I just need to add a comment or update the patch description
> to provide the needed context?
> 
> Case in point being the AW_FLUSH_MODE and it asking about how we are
> verifying the flush has occurred since it doesn't seem to grok that in
> the same write that set it we cleared the BME so the device itself
> cannot issue any more writes and the read completion essentially
> clears the PCIe pipe.

I think in that case an additional code comment would be helpful. In
general an AI comment could be addressed with just a reply explaining
why the comment is off or is better addressed separately (quite alike
good old reviews :)

/P

