Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727E3BFE5B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244854; cv=none; b=B3MmNTXpLYcJBSw9FGzLjNHIQXnBbXpEuScPAfo7QcD0PvRjh5CCX3BqjGPb0FK5ZWYEK8Pb4IDv/mCSlUBzQrMCQXFnnP/4Ix1hqkAEL6K/B8h+VVi2RfAcVkx3EVz0fpRAdNfvTVfCj9yYqDh9cpUI2JSDk4nhgXRFHh63HPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244854; c=relaxed/simple;
	bh=NN0e0g23jeBHX6DFaufsvruZGi8WnjPIpSL3GTO21Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGAOfGrOjh+qeLxWVXkgr1lv0yoe/Khh8F2cldT65DlH0ah392K6CBpOrNbJed3I3fCGbhSPh+VWUwQ8COBwdbihL9GpdlZ8Y29vo+pa4C3Ddh/NTDVphBuCIYwGpIteUhoJwRYx1d9ysZYJDrzlO4S6Fkt4nYDNV0sL2Q0uEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J84dTtYk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cp8BzTOz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J84dTtYk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp8BzTOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790244842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxjUDCrVF3cPBepPW95UZ0ZG6+HKjGTnptEQIR9dc6M=;
	b=J84dTtYkU18ysRbnjBoKfLb5+57Kv594Vb9cm52iB8iHNTYlDXGr0NQpcrXXgUuBNo5Jbv
	ofAJ6FgtIfHosBouEaOhM1KREIFNbDl6/VbN4jpafz+CzeIQAF6RhJqLXIc13Z8nifYIcY
	HXCvlMoXmlBZILFp2QIXbsGmJqRdZ48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-j40dkQqEP0299Z4JsTfTJw-1; Thu, 24 Sep 2026 06:14:00 -0400
X-MC-Unique: j40dkQqEP0299Z4JsTfTJw-1
X-Mimecast-MFC-AGG-ID: j40dkQqEP0299Z4JsTfTJw_1790244839
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so8829705e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790244839; x=1790849639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxjUDCrVF3cPBepPW95UZ0ZG6+HKjGTnptEQIR9dc6M=;
        b=Cp8BzTOzuE+FQku/yyxtEMZyQw9rLFDoakeNIAs+uYvLoP8SiZwMX/Q570mzAB03QI
         1Dmh5xyWQkK1Ou6a3UyQtB06dC/baYhoTYC75AsaujaNcpu2dguTEVU8Z/B3jqOFTv0W
         RphynXZlT43xQAPvM3TVU6BkTiz9Ke8O+SHz208pigF3Xn6MoWjceLeypyAz0iK4wE0y
         yQg1k1QrTMmWogWGCTJ5mhjEhCmQmQDD8zkZt1HXhVIyCHUhCAaZCL1WwM3ZWFQMdSDu
         KaLE4bIdydV4rqGnOPNfZRzRbOREGpvQm171hrg9kAUJWIt1fKPYKvhMRrot93/CQ2hR
         s3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244839; x=1790849639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxjUDCrVF3cPBepPW95UZ0ZG6+HKjGTnptEQIR9dc6M=;
        b=KTOXzxcPQ76ljfMXa2nBFa4Zukx9epuo+v0gHj3Av3N5mscMGURpQDVkR+dTbAdvj0
         Ud+kecF+35UOb5PugZEIcq09CY6OjEdP0aLJXstbyXy6/wVJnHNRnCcoBqJR24qCLooh
         EKaucC4TbX8HQtQZOfFL+n95tBjCSlkpYK2H1faM2kJgKAOFvvERLHXrkBdPo7/3dL+E
         LobDghGtfCXwtx3AN2zp6tgkeS7930+kQg0PaZLkj9tjg2/OZS3VBeBbAqjLlNBe61Uj
         IDnysYfJqqKtiRMkJ6drjuTIUl6wXNLfJQGDqGe3baEvvt+Cx8B44bqOQcOSSoJtgcSD
         GQvQ==
X-Forwarded-Encrypted: i=1; AKwUvBznoYHbsVNrUIjbg0++h3GiEZTgIPCN2gUcEbQ9HrTKDBv2W7axLI+guAhcMXobQ03HrN3EJIE=@vger.kernel.org
X-Gm-Message-State: AFuF++nQWqq0F6DjEt69DuWCwmHB7rxju/iMQXsSRjE23wYKGpOx7zQD
	sui6WPFLXBTm1rBdC4moXCO8GJYXeM/50xk+gv6Vj971P5pPI5hwfkmPkQ5zdFa3Nzz080UzNmC
	wWVAdKRvMKWYjcwh0+pKCrYjTGopGakFLK1DEVAi5ghlORQhpyO5nEZD82g==
X-Gm-Gg: AYBFou27u3CIwJEC/R/LEEXV6QSNDU0xX2wcXbBy1m0NM3IbcUYbei2lYNIwAQLg1aH
	vKQ7SXY7z9b43LZPcn1V/wXYOeIJ/ZSYS/i0TG2OGCSubkh2pRjfOIZB8L/tGbzjASgfe/oM21t
	iKK8c82uCN/LUVdZpJWA1NxQLk3lFU/nqptsos9sgEJ2TLPSY66Qm+UwUGQ1cHrj+fIBtnqI0l6
	9bgGXkjNwZ3KbtM7JQUenSQAMN+6GSTZjIN8W9a59tUncfwPDvQ6bJRacUhCFFjlJz3arhTtwG1
	awjMM4ly7bmfQWvxg8/k058SjDBBCf2WsdNEJ/Yuq0YwT/bEQGW+i6Zc6tUnB2WNmRKeuJd98wW
	T2lp6aLkmgmdVaq0fIK282VW9bJj99Ggm5SmP1e+4fp3qw0bm1h4DZxLnrNNb6wSEDkh7GaiJdA
	==
X-Received: by 2002:a05:600c:870c:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fe66d76camr33596585e9.15.1790244839517;
        Thu, 24 Sep 2026 03:13:59 -0700 (PDT)
X-Received: by 2002:a05:600c:870c:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fe66d76camr33596255e9.15.1790244839132;
        Thu, 24 Sep 2026 03:13:59 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5b646sm53445335e9.4.2026.09.24.03.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:13:57 -0700 (PDT)
Message-ID: <4745a390-6859-4a5e-8ee1-ab9634b3bc10@redhat.com>
Date: Thu, 24 Sep 2026 12:13:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sctp: copy zeroed stats to user in
 sctp_getsockopt_pr_streamstatus() when !streamoute
To: Hui Peng <benquike@gmail.com>, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260919213634.3314055-1-benquike@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260919213634.3314055-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 23:36, Hui Peng wrote:
> @@ -7589,6 +7585,8 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
>   			streamoute->abandoned_sent[__SCTP_PR_INDEX(policy)];
>   	}
>   
> +	retval = 0;
> +

AFAICS the above is not needed; retval will be zeroed later, if in case of
no errors.

Also this is IMHO net-next material with no fixes tag.

/P

