Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926448BD3B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431547; cv=none; b=UxxTKbINhqCV9hDPHXNTsUUStKgFkfd0TOephIYHEF1C6QTjMAxN0lItnZPkVew38GmWbe3fhhYZQPB/57zFUPbDluGa+IeYi5jTw+uWmVv1yc38BK7hdEnDmCEuBjKE0qwAuQUhKXbh0EkCtKj6JqAwWDnN8akHLiQFZ1UmZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431547; c=relaxed/simple;
	bh=UTWEEMTIdKTL982VQSfBJWW2fta0VT/gkHpdezrQf2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg3z7Krshk674I+L0MX+2ITJvLAAmf4QSS1nLP6dE82jg6ooHa1xqi+2RW1LC5hRgr9R2VTdGSYc38reuHB3bfC6ZFf76kphgybrsR1dwS8QmoHlVvEpOyiional3ZXbBGTkqmq234egep2qbuGvz6B3yfSkN+nva/mLJf4U43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLAiTh8c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qpuOUr5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLAiTh8c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qpuOUr5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788431538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1S4jDPBcWhcjpcEN8bURyLjdL/4D6hTstVl8KFuzFw=;
	b=ZLAiTh8cf3Z0L3yzT/Ht2xJnmt/5deZtpwCZGwGDxQV1jio6wNItgWXd1z+VSkPDRRWJcN
	MmwFkx71jThr+RYIR/FTYp1DGybzlp/7EpgOJuxthgRed2s3TmwNI3RQYHtOtlKPd1s99t
	W6psqHW+9vtI67cZPCo65Tcr0r+INE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-EBhGf1OvMkicJxLIIRmIxA-1; Thu, 03 Sep 2026 06:32:17 -0400
X-MC-Unique: EBhGf1OvMkicJxLIIRmIxA-1
X-Mimecast-MFC-AGG-ID: EBhGf1OvMkicJxLIIRmIxA_1788431536
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a5e9400eso1891067f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788431536; x=1789036336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1S4jDPBcWhcjpcEN8bURyLjdL/4D6hTstVl8KFuzFw=;
        b=qpuOUr5bUd8lFpNtDrfNd8GD9ABYnCgP0+ukoKvuyiv+2dAWzMGXe9p7dW1N9V/zrg
         eWXOiH249PPXneZ8sczfw0ALM42vREVhSm6mive0LiOcMIEIb39LRWU2s4mfzeHHK5Xv
         UZAdHwuzyGSI4RwUcTX+EF0Z2a4DgyKvCz3KyZlo2EcZMf3sZP80cn96XdXQLrg9ncPy
         QHp6/7MDMAeRYlPbYJn7FtglYVUPf0V2Od2050NzArq5nfcXHDGVP7c4U8uJJcZJksCL
         Csn9gJd93dtjKA7Cj4J08pRRfo5QYYNGsr2l2O1kRbuOghcV078MKzeukMDK5IjjAtpd
         fbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431536; x=1789036336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1S4jDPBcWhcjpcEN8bURyLjdL/4D6hTstVl8KFuzFw=;
        b=MavHcE4G+AP1p6yB69rpD4O8HbW4jjFx+av4yVMTxn72V8ZoC4S+JnDe+g6U41Y7jV
         pM6up0OsWqypPcRFY3Mm2TcqZMuDC5kJ673ZTEhLZ+umdVjd8VneiylGVA+kIhXWt39b
         9ienSxZRbNQ/dplrTj6QLYOVeBns9Y1FGAL1ykdomECGGldBoBC4RzemmSCSldB0MK0/
         X4eH/S0LdDVZt7/mdBx2T1bAVIUWJ8QC9NjyxNb15kSqnyZLb5RHqhMy9ASZ24YJfutH
         Sa/JbNKFcHYxmc8q4lKialk5JZNevV6wrLmaZAZY8ypvhFfjfHRSFgKT+VwhqhFOsPQB
         0qag==
X-Gm-Message-State: AFuF++mYPWbIhzBfGJdnxY/LDsOxEVs9qhoe54abOZkMVdcCQbwrvmid
	Trx94a/7V2zb8vnSKwjVPccxJ4ILuRonEcx8YK9JDpWCi6/9/bWAMa/g0VOrfuoHOmUUNeEcxl0
	QepJb6a/NEz6Y7Et1zL3dpYtIgOni+ZopYd1uKAR1FI0SS0IJM7uAXIZcdg==
X-Gm-Gg: AYBFou3U6AqZJiZclFppSI4a7MYkFKLJZIgYOKix7kem4QQZ0zRY74oL5lmmN0ILFKO
	ik363mq9imtdCxtIt6xe1KJG85Q4dtoBqD+NPgAhWHdr6Wr1cgZUiC7a87pDg8GLlQD33GxvoRJ
	WV2zltBdSKRX8x1P4Te6DHounrsnx9vYWwOnmok+nn6OPhMSuKu0+CKIY4AY6fUy0lRr42RBmZN
	PqPDo0R+FDYRRucsnIKeff0vTC72ocju/25p0sOqhFouxxoO59W+8FwH3bAaHBLjH5WmD/Zkspr
	cCNtFp9OdQyWUWl5s5E/JqLSLS6VsasSj6tCR66uXIZL+mz5bZb7d9d+8vN7YoGGh4HgteqNFZR
	7xr5CX16c3R0NUNAwyt8VhoDGaNyW/D2UDcfbylavIbxqijlRm59dF42wV1YRNXKFeqVyy/ZWIg
	==
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr189606795e9.16.1788431536326;
        Thu, 03 Sep 2026 03:32:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr189606265e9.16.1788431535877;
        Thu, 03 Sep 2026 03:32:15 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm84231465e9.2.2026.09.03.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:32:13 -0700 (PDT)
Message-ID: <0d041c08-1deb-40c3-b05a-e4657844b3a4@redhat.com>
Date: Thu, 3 Sep 2026 12:32:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] octeontx2-pf: Add NIXLF error and poison interrupt
 handlers
To: netdev-bot+sashiko@kernel.org, nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 naveenm@marvell.com, sgoutham@marvell.com, gakula@marvell.com,
 rkannoth@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
References: <20260831062600.839203-1-nshettyj@marvell.com>
 <178842771187.3394541.7325489363068011329@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178842771187.3394541.7325489363068011329@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/26 11:28 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> - [Medium] The patch bundles undisclosed VF-side changes that the commit
>   message (subject "octeontx2-pf: Add NIXLF error and poison interrupt…

IMHO this comment is borderline relevant, but addressing it requires a
level of effort that would offset the benefit, as this is only for code
archeology's sake and we already have the lore link in the changelog.

/P

