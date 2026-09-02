Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA564463B7C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345539; cv=none; b=QAs47KL+zr7YYdAWVXkLpEYJpb//aefe6t574H7n6H8Dqb1ZGT+AE5+rvPBzNIwfV4aA9rkxCm3UtaHamElzd/MxKD6N/F3BAQNZGii9OfyBw9WkM2vAYYY6fMvdahOisCdi2309eRyBFmsOhvZODl8OELXnQKzn8SQYtzpcYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345539; c=relaxed/simple;
	bh=lG2f505tBrP+DXM9kpPo93xpUjHLDTko/Nz9Cqmu9Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFF5CvhwwVBCz0waHZezhQ52odlr8xDp72T6aoYTRuGVSnXqT0BUtASVtMxqIL/WdeHLWYf56+LX4PEDcZLzmL42XlssEJ0PMziNuhL8U1/c2FLRpYfAw1LkGWcYXooMdoR2o+DYVKoHV1M33vQumJ4t+q21Dh7iXVt6a+XUqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmlNm5uT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvYfVNWg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmlNm5uT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvYfVNWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788345534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAIMKFNUvZZYcEQjwd/qvyu+ojnofRmgk3T+41xXpsQ=;
	b=ZmlNm5uTWTC/G1s96QsEVmNoFXAyoNAcOM9ZVVBx3eYVlazkNijYJLD4yKoWkklmyHwFwY
	gyGDXQx5wwaYm0q96ioDt/s0Rxd2LddJjpwdPZ8up2V5L8UgHXz5q9fprQTsSZnCGe03VU
	4YFRBnjYhCco4EqRsD44Axmi+ZOxvbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Vl4XSYoJO5yGXCuwE0nDqw-1; Wed, 02 Sept 2026 06:38:50 -0400
X-MC-Unique: Vl4XSYoJO5yGXCuwE0nDqw-1
X-Mimecast-MFC-AGG-ID: Vl4XSYoJO5yGXCuwE0nDqw_1788345530
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so761299f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788345529; x=1788950329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAIMKFNUvZZYcEQjwd/qvyu+ojnofRmgk3T+41xXpsQ=;
        b=fvYfVNWgvPMU11ecrQr2tqnhZo5Jrbe0+M5e177mXkxUjKPuN4PA0CNzadd6/jkN6r
         jpG0Bg/LzF5KQCgcOnChOZTicTyvOd6PWM6YG76+d2gUzqKb8vWWItIC6ugZNnhAC8SV
         vsh/f9SDysMriTILjCPMCMGpyx2dI+WIP2OYi33GzYnhLgTijYsnaP6RAYyQQlpTd1VY
         2Yq/lM6K2S82uIrUxqZrcGzSqzbuAwSn7lMSU3imDI1xMQjaroLLm/SPtFB1MD/afneO
         Ied9ENB1NfoeNjkqEKUxbFCIlXH2SWYvRGYwyCPHf+4EbfOG4fqdZ192FqqxAk/uS6Yw
         EWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788345529; x=1788950329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAIMKFNUvZZYcEQjwd/qvyu+ojnofRmgk3T+41xXpsQ=;
        b=Sb0A8zf2Z1aEeloPgnY4agIUH3+XWfaCpQ18wsEleSVVnlzcl77ij8xtZr88J7hkPA
         5fEy32RbLedDD6dsM80ra/rOfYjD47kGkfSDAjh+p+jYTPq+3m6C5bdRbcrrxHVFr18+
         6ED3itD89DHMriZMWjTKeta+fAvGQHJwA1FGulr/nVqL2kIwYSOBKmtT7JcE+vsLHXYI
         9SY9CUBMZ7AWDKpR2YaJkqt7BXkou7xhfbacKSyi3gnNd0V+yQ+8VB37/4v1Y+500wQf
         aiPkLEt6T4xrTDT6YvMyhk9ur+CkRmTxef9ftLIZhMZk/t5Sn6nhjWZuWzy3vYw1Tsao
         lFeQ==
X-Gm-Message-State: AFuF++k0mfXQCNWybDyH+x0BwuE/hLh0UMb0lhit7jpTszbTfW9cGggp
	60M14NlNjP3/QE8GL5IcCvmJBiTwSemlQ9B1haR455aEVE4qlCjWb/9P03+ZU2ExkezawScG+2S
	OMdVB3/lw1jhs7NQVLBGNIvngsz3gFYcOuNcLmUAXl+UwzJDOzbqLxobSas5IkCEZON8jRxVeYr
	QSsiiGgntBSkkhyQJrttiN5IDvqYPDh7wFJitlRlk=
X-Gm-Gg: AYBFou1QgEOCqQlwIhH0zQj61K8zYsvI1as0CgMHubsyv48/nhj5f1w/bPOUgiFTuhS
	JpKn67y4997s72Ar7Pnya+UrAQFgf34zHhxtwmHIJ0XOtws9BuAgunH8Y6Shsk6067JnW1nLiRO
	huVhNIBRyf/dkQkVQzQ6ia0Q80NT51AJR2mWcqFHG4ZC7Bh2wUzlNo0Vr/ATU3naF9wIdt31XVB
	kXa+KhzJ3+rH1Qg7rAEVroUR7bLg7YolMniXJOPzv4WJDC5X2orYkKbYnWEm9Ago1mvvnu4yaBC
	6F+Z34yiVwL5/XAYBXSW+6Q+SVgL7hjJxMsv8GldlaHKG5Qu8BGmEly6tmTI5X7tOkVe72G5KeK
	FMjDoh5rPfHzWdpGzzyYdFejBf0UnkKhsnLE0Ltw9Jbo5NG3eHcBIoc4S/VrwtETmvTveDI6fJg
	==
X-Received: by 2002:a05:6000:4817:b0:484:40b0:ef30 with SMTP id ffacd0b85a97d-48488deded3mr7475696f8f.6.1788345529600;
        Wed, 02 Sep 2026 03:38:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4817:b0:484:40b0:ef30 with SMTP id ffacd0b85a97d-48488deded3mr7475630f8f.6.1788345529125;
        Wed, 02 Sep 2026 03:38:49 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm5964456f8f.34.2026.09.02.03.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 03:38:48 -0700 (PDT)
Message-ID: <ff5f066e-c959-4079-bc40-2da5229a6815@redhat.com>
Date: Wed, 2 Sep 2026 12:38:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] AI reviews are getting emailed out now
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20260901161809.0608949b@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260901161809.0608949b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 1:18 AM, Jakub Kicinski wrote:
> As mentioned previously we were trying to get false positive rate low
> enough to start sending AI reviews out automatically.
> 
> According to the stats for the last 3 weeks 70-80% of the patches we
> are applying have no issue with severity higher than Low (50-60% are
> completely clean). Only around 20% of patches we mark as Changes
> Requested are have issues <Low. Let's call that good enough.
> 
> The embargo on the reviews and time when review is emailed out follows
> the same timeline as maintainer reviews. Delays are added if author
> does not review other people's patches and if CI finds issues.
> Paolo explained this a bit at netdev.conf.

FTR the related slides are available here:

https://netdevconf.info/0x1A/docs/netdev-0x1a-paper49-talk-slides/Device%20driver%20workshop%20(2).pdf

beware: the link could be updated, please check the conference page.

/P

