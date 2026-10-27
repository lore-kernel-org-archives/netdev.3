Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102061;
	b=ebeY9P5A7jVasIFB/XgUXrWQon1yStWo9r/Rrbo1kBNLLtk/8p+zZQVexE+p+MEMEqkH
	 SU8gwiy/IUYaAa1cL4+29jaHqcqU6zDSomwUPnhun2jBxyv6ZUX4PzGe6dnzOSXgyotnH
	 bGuxZ6v7ZuxI5CMwI8FX+u4WT7kM0sftcfPFc81cviYMQ34/F82Lg16fMqtZmKri6KvtD
	 vK1g+juaoml3NHXR/dULXmlkC6tSqqJBaUX7F4kUXotEJvXln8RhbT/UXksUgt4sPWgcb
	 7gvZL6zAMmZnKuReH5R0ZiTdZp3p6Pfm07/w1WoDsSWol7ZQMbKaKBJTyfKFvwxm4kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102061;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RACdtXZjtylpJ4vLt4UW9KJj02FOgkoM44pU5ajByGU=;
	b=Sf6e1pEW1hvJ+uvLIkwiOB80djRG/nCwG+BqQ9BGTKvJ7vyOgoe5fZMreevT7HSJe859
	 UaySCx/SmbTXzqcFVKodMELDuMnxZVWxIRtv7vV10OBlzSquroEegwoZ2ePg8LtXBEFh9
	 mSKOgZHP/pBT6jlfbD3lEJNbYrc3gcIWUjeJxi7k1vNcHAh/CwhFnWmXPyJxVbFMeOcgX
	 Vxf2SfuHm9extxkckwM/9eU+cE1l4NP+Hw4NVf//0MiHPX5JQLCFeBaUEErb2Ckigy/zV
	 F+shQMyOZ9Tn0NMV/EMHg8ri987nz6OM5cV+ocXr2jJ7YZlCCC3m4GsOIxUwBvIEgmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6U0rz30;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pqRBtJZI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C18606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6U0rz30;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pqRBtJZI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793102060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RACdtXZjtylpJ4vLt4UW9KJj02FOgkoM44pU5ajByGU=;
	b=c6U0rz30ShAw921tTCvDRJ1qZ+XAesDlaPaSF0tPhQMBaaATA1Hp1ccjCTjIV+qjNGPiiF
	tvXnfDP0TGYcNAxeoD2fUn4Ax8vg7xFtf+vecT9Q8zYb8pM8wfAb1njUzM5BH1s6yp97g+
	CB78cQlULwt5Om5D+nMX0qby8mbG1xw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-7o7WyFbJM3C2y1V41Vl0gg-1; Tue, 27 Oct 2026 07:54:18 -0400
X-MC-Unique: 7o7WyFbJM3C2y1V41Vl0gg-1
X-Mimecast-MFC-AGG-ID: 7o7WyFbJM3C2y1V41Vl0gg_1793102057
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so39055495e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793102057; x=1793706857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RACdtXZjtylpJ4vLt4UW9KJj02FOgkoM44pU5ajByGU=;
        b=pqRBtJZIgeXnImGGgvTqkWzoWWbVWymVE1u4nAjoQnMzaI0TuJUR9cR70uzn3cf4GJ
         LPGIr9ItbS9r6kW5ETwXJlaEtk62PnvwMQzXJt+id8P+sfEOVAXcgouwRrYffwyEmfId
         w3yJpJf89c1Pe14RrweC9vCPTYNdgFUOPWer+XBFXG17+u2DOdyWx4q9c84YKmdFW+vM
         eq9JOXX+SlZmwxJ0nVRjnvJhP3sqGbMw0V6CeOu4En8CagrmUws5T/SLcV/a2joRIfib
         HrBRp0EQIQBa7HF01p4hkN9hXrRU0eG1N9+awNIIoJddbTRyak/R6QajrxSSwrB6Flf5
         L7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102057; x=1793706857;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RACdtXZjtylpJ4vLt4UW9KJj02FOgkoM44pU5ajByGU=;
        b=JZ6nobGvGFnK3RVpX8/aK8BSzO5sI/zyT8pfOZtkeFlGNfn9Ql9uXwnEGZ+jIiivn1
         0IZBGnrjGb2e3QvYZRUWGR+9dVw7yVnhvAT+7HWwU6+Vh/yCUiyrUp+jXs9Dr8FAjHFJ
         9APUmaHSZf7bZwAAyJKFVnKlWfi94awbMAs7Iy47RFDGjkmklTycHsH4ur6Zkz0RZCDv
         Wzf/IDIWMIEktwhLUGMPfuTetEOHlvHZeWw9etb3W4ZUPvJAab+rNpiKVMc5vJq1jCC/
         QwqkUlZXsNf4yMwaZHgOF1G3lm0uvyGtesK6dZNy/Uy3HwkD4kyZOKX0w2mfB2XtRWHp
         VxsA==
X-Forwarded-Encrypted: i=1; AKwUvBzzYTjabKix76JWvgtsMHZHgvcN6bY12Kik1Ld2B0Uimjqv0mZg76krzlnalDlSfLTYQhjCpiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZqjXjH+qyUTTtlIWkcF+Kft9EdHEbUj/zoTxtQixBTJUlYqeu
	+TatKfu3d+sjwy1PIxLbDT+KFNR442zGb5zVmCtlv/FLA6uoj4eFEA7th4inNjg4S+3yKU7D/pK
	WrqGwuA5JR0S8jiekyPAYlvXi/VOa/NzgRVmLcj5VPQCYxKEnbtYqdtA92g==
X-Gm-Gg: AYBFou3pqvqelo7s7dD9/PN1sH7vNH5K2UBGAyRsZsHJ9olUK+kn8OaIVsK/ed/DbAe
	0c4Wr9CqSyOBkYbKjN2Jkq/j3j0hxQgG8JveoWFJK4KB1wPUVqBnKnd7Cq7CUz8Sbkm8eieC5bh
	pR4/YEXtO6ZJ91lx1pVqcei0rAh2QEhi9KJ47Z2P8SlEc44AGWrUuUVxVPdbMWTLhUKwZvN8kYA
	nJzBMpKsG02NsHWch0FBb2kaXWbEd+wJ2sF3cxfqcarYTbIPfs5aBGgFgtpG0F8u9tW/w1aZPOd
	cF9Mm65s5JwB44P/61aDMlGdc65VZRY/rwO5wI0QTQdr1ajB1uRwgMXRB2lM0yJRc9oSW5pLtHI
	wukCj8it0hqE4N81EQQtPIkuma80HV0uVrvQ2W/5rHSsBxE+u89TiNhR9NpBqk5aDTa0h2QAo1A
	==
X-Received: by 2002:a05:600d:82c5:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4a7ca0f7e06mr48519625e9.22.1793102057250;
        Tue, 27 Oct 2026 04:54:17 -0700 (PDT)
X-Received: by 2002:a05:600d:82c5:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4a7ca0f7e06mr48519215e9.22.1793102056880;
        Tue, 27 Oct 2026 04:54:16 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm259948205e9.8.2026.10.27.04.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 04:54:16 -0700 (PDT)
Message-ID: <be411f93-4105-4d68-ad03-7bfe602a8cb6@redhat.com>
Date: Tue, 27 Oct 2026 12:54:15 +0100
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
Subject: Re: [PATCH net] octeontx2-af: Fix representor flow rule PF_FUNC mask
 and channel In representor mode, an AF-installed TX rule must still match on
 PF_FUNC, so do not clear the mask when rep_mode is set. Also, do not
 overwrite a channel already provided in the request when the rule comes from
 a representor device; only default to the PF/VF rx_chan_base when none is
 given.
To: kmahammadraf <kmahammadraf@marvell.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Aditya Thapliyal <athapliyal@marvell.com>
References: <20261021091736.2406505-1-kmahammadraf@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021091736.2406505-1-kmahammadraf@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 11:17, kmahammadraf wrote:
> From: Aditya Thapliyal <athapliyal@marvell.com>
> 
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
> Signed-off-by: Aditya Thapliyal <athapliyal@marvell.com>
It's nice to see an hopefully human sloop, now and than :)

The commit message should not stay in the subject, and the above
SoB chain is wrong/inverted.

/P

