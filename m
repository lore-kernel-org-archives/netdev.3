Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616030;
	b=i7GGOea1PnkLKbmTeJKYd5VHTwzGbwGSXOYeMIR5GrAy51mMQk7RPDniN3m/fO8CKggo
	 baittdRnnAsczZFeWujbD2tZn5opEM6Um7svmWFsTfcjv7RrlO/F6rGSFPYaNXWqcYcAr
	 4F16cYOCi9LdpQpNgwWwLkBDqQG4BuFAzogH1nsIMmcisn9RfOf004b69pJ+nF9t2wnj4
	 MIgSWQa6za6l22Ra90eBMK5JF0b2qT0bvdY6Tobvxlp5UfmhQltRU67qtUNIBovp2sBkA
	 whYysloxgWrvDARkBz1P69q/+oH2ZRtKRfvsIZ8hAftUTa1bfMhRYQqRNdxztBNbHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616030;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
	b=QuKRIJj1YJ/JMxeHoEZLuhTIT3KOPoZcC45sfj1OkmhKI41m0EN78T7y615iRphYg1+P
	 VKfYK0boDRSJdDCDUZeKbIiI1oVQ+UDZZERu9i6kMBq+XD7b50oXT+hUfoxvseGupXWw+
	 aqyG18gPWMH/v5uSPi/RVQNJ0k7e5ML/XJmsckIeFr7sMglDE46Xf9FcJICIcHrsNsbNe
	 eLD9OySPiAPzo/UKeVhEuy3I8V6EipUf9oENO1Ss5TmlApom+4cm6ROXcsI2a+ZZO5EKP
	 dMLY1orhvy0HBk5UukQqQ+xbms24GBxiwVCOKEKIvKEu2sgfly0qpr7mYrGbYLOYmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FUY1KLGY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jfWxIkgm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09E606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F09E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FUY1KLGY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jfWxIkgm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793616027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
	b=FUY1KLGYLICy9WFzsoM3qFqg2fihgPDYpzhVRKRRZ4QqG6bXge6fD162xjc0AEQt9zSa+4
	805FyGU47P++BGU8cKcHiHMYSDHyLYUZfElE+8Y4uTAeotR62RB96X6DyFLdxPRgxwD6Zm
	5zY/tFqBUWu2FxwL9P3TvHsUvjE1nSk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-uKYCsqfCNYCTpcJ5r1x7rA-1; Mon, 02 Nov 2026 05:40:26 -0500
X-MC-Unique: uKYCsqfCNYCTpcJ5r1x7rA-1
X-Mimecast-MFC-AGG-ID: uKYCsqfCNYCTpcJ5r1x7rA_1793616025
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so26798425e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793616025; x=1794220825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
        b=jfWxIkgmx+p0GWeBUL6kyI1wktmaQ20NM6B6cw2s9Mo2CmnM72HFmQL+HNFibfMfcW
         kAGsibMB9o7m34VfvLL6xBZn+jrQ134pr03AwOIIp+MApG3MewIqAEVJ85a7G/G83f9A
         EMTckJkMovjFcpnFomuYoi8h6QP1MgJjQ96EgLeV8sQeHzIuHxkOOSTNXbf1Ob1bQHuh
         oE4ixHa2uegFSDp8IWFM+Q22BubIMiF2L6i0yKTaLhK7dXWEE/8JAw10BLSeWKTL59db
         cmgpOb3e+RuaLmZjU8S0wY6gWPSOu8F7VpwaKfDjHSJg3tuNalFRAxmvNwQNCsizH8hn
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616025; x=1794220825;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
        b=yweS9wiiww8qENTl1Nl+6IKsH4uu6bjKcXWJTPtttleznm7IoOeT9/BfQaLR5VKJrh
         mG759WpbxTs+7IXFO/kCogLuIgv8UyDR5BKFuwLTMMA3Y2upkcyJhN5dXRnW6molJJlJ
         vfyp1adCWPfwnRncJOqaOoXwP7uuUNmsQPTm26h+eFpX6tWRsIw5/17KOZIXsZGRfHH7
         BS3rTxCUp4BK924dThod2i3iCcfGn84DD1njom7xyCjGif0zNKPItyduL/tg6/uDyQeO
         7Ew3F18KikW3GYYCxgG/YzLDOCB2vnm332Kskn7STschN1EQTD51AT3CGQ3RQQwWwA8w
         ETcg==
X-Forwarded-Encrypted: i=1; AKwUvBw7EwmeInqzJYkibWiVpV6bWN6YApx5KWfEuTJ6f+MmFjrJKyyLgzXs48USa2tb3OybNnI3XrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOmizldxSsYgrjycFQTmU+rrmqC20AfXFVV3j5gtqD95v0zky6
	eNhxJ9cJznOC9eLVa8wKDl3Lyvmhka0fPzAfpHHNLLYA1mJu+ELWzYwGZpiImUWMbJ7Vy4fjVo5
	P9xOdxMemK00YddD6Jh6y15RHfYE68BN4O+ymqcufXDhVQyVSz+PmOHQ9aD90n1YWbQ==
X-Gm-Gg: AYBFou2MIEl2O1xyDt8azuHBX8tEZRdN3inGzMrXxsYp5lXNqpSoeeQjIuZH+ynkL4f
	Ai2FxYV7l0wACxGTkmlB88zRirZMXJVU6Hbg/Pv87fo20smaWF6c91sZg89KaYzGKMfsbaF0AFi
	yt68TouHCZTVzlnr7KYqbUzH4nISCFQbxUoEMToRDacSILk3nqUti1cNOqmPg7fNQqvZxPuzG4N
	CWlNscXuF4RJoyAa33hySVVF8h+r1F8xTGDqI0cUqvG7PXN1aJ9QbA4D7yLBxR74nROoMA2JCE3
	yUggrxU8jpgibEPAc0MOaIVTWZqPcZvXcndPgJa+YGq8HKeQnfbMizAxq/pttpnF1KWcMqAuMo2
	SylN6Pv0cj0usQl3O7NCipxQUDPAdtPL5r4tm6hXmN89KuivtixOe0ymtPJmYVn7sfMQ5o8NCd2
	19FCHB3Fa75UwKhKwtX7eKPOk3jb05CSdzB8MWzoERTD8=
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr223282105e9.34.1793616025368;
        Mon, 02 Nov 2026 02:40:25 -0800 (PST)
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr223281775e9.34.1793616024956;
        Mon, 02 Nov 2026 02:40:24 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm267462905e9.13.2026.11.02.02.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:40:24 -0800 (PST)
Message-ID: <924ed39e-5298-4ac9-a5a9-12c6427ab281@redhat.com>
Date: Mon, 2 Nov 2026 11:40:23 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] hdlc_cisco/hdlc_fr: shut down protocol timers on
 ->detach
To: Chengyu Liu <19290937@qq.com>, khc@pm.waw.pl, netdev@vger.kernel.org
Cc: stable@vger.kernel.org
References: <tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 04:23, Chengyu Liu wrote:
> This is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync
> per-proto timers before freeing hdlc state").  That fix added
> ppp_timer_release() as ppp's ->detach; cisco and fr have the same hole:
> 
>   * hdlc_cisco: cisco_start() arms st->timer unconditionally and
>     cisco_timer() re-arms itself.  The proto has no ->detach at all.
> 
>   * hdlc_fr: ->detach = fr_destroy() tears down the PVC list but never
>     touches the LMI timer armed by fr_start() when LMI is enabled.
As per Linus's guidance, this is net-next material and should not
include CC: stable. (note: the reference change landed before such
guidance).

The above usually does not require a repost, but for some reasons
this series has not been processed by the nipa sashiko instance.

Please repost for net-next (retaining the fixes tag). The new
revision should land in a new thread.

/P

