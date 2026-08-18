Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185B2F5A36
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049576; cv=none; b=Nh5z9560ZjntiT/Vr63IDr7XGBpHVUfFdibMdHJ2q02Vu83bqkCdA0SEj3gm4q0SnfPrWhjJZj9CYKTJ5e1D/hqy7Ns6fBNYnp5GKl566yQCPI49/6KpIhbKn6OKPgBacyJVZFxOe1WqJ2jtI6dz4Fqb0ZC4ru3KFR13f6dEM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049576; c=relaxed/simple;
	bh=iPosarQBSWV5eI7/8ZRgW+a+iy2PNOiNvd0h05yl9Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZzZ89unTRTfxzg5keRg/qyZiCxSSLPtVVmDW+Gu2v6Vaodg+mlnbx2hB6/xBKqejCPh9DpT+/1z2EEC5mZZVMQG91PL0q/tV1tHcGUpiPIADxxyzj86TsuXb+QLSnDXMvnV/zzb6hWcQ1+yGMTWZEyWQVeWOgOyMHQBhQOGQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b51mNKai; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nauJQN3Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b51mNKai";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nauJQN3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787049573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOd22pWC2yjVgZWo52qO+z8giEOH8YNVnM+thO5EZ3I=;
	b=b51mNKai7NaZYQHldMqxIM1qH4lGM+PKbN5P8YQvnKW1a7jHnYcbohwhFdxN2cck8EtTFM
	1FL7GJkgwW4UctARJcIxDOAkoNaFEvHTzNlks1Sqxnpbkysba9p+NSjKEfByBQPzVXkSpn
	X2y8eDofLcn+pK7IKw+2JeGbEnnHRus=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-zf-UlWpYPACaLuRv-NGt9g-1; Tue, 18 Aug 2026 06:39:22 -0400
X-MC-Unique: zf-UlWpYPACaLuRv-NGt9g-1
X-Mimecast-MFC-AGG-ID: zf-UlWpYPACaLuRv-NGt9g_1787049561
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83416551so3861839f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787049561; x=1787654361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOd22pWC2yjVgZWo52qO+z8giEOH8YNVnM+thO5EZ3I=;
        b=nauJQN3YhUtvBOmBx2eR8yznhD+aOcLSX7iROmfiFmgb8FZBDIn5YOnrncQi9Kpu8+
         ltT1L48L9sh7ic8N/LReotX261CDGEsLBVTiPvu7+wdpNW4IRC24rAhd6yH/sLsgS9Nl
         /d9Y4O7pApyYxwBwmkWftewCWkvGsR+IVPlc1ePEnCTbiWAjBu9ViD8CIHG0+oKb+N0Z
         HGVsxA+2gaG4wlsZW2z0BWKuROaUxfsNVZgYWQ6bjcu1L6K13++LKig5gpPDeTM7Z+hj
         DS7FsgyQJO9KkHMuThAiLC/gt+5Tp3XiHKpHXSv+YcpXViKkTMZbmoRtpeufTMTHPALP
         /HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049561; x=1787654361;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOd22pWC2yjVgZWo52qO+z8giEOH8YNVnM+thO5EZ3I=;
        b=U0bujZ0cOoFGEnrS73tnm7uh5bXa/sc9HWHoouvsIRWSqV93WO9RxErjPi3s4p3jt5
         xtUkCDNu2SVzS3EiGWJp2OZvJnejyyl41VXYxNisN8NrXG+c6SafPW5meBzdjNGZ6Uc1
         WVPxW7fA68ykr3ODrmDDZmQEgOSIoa6KymhcFkqvcJf2B/7R55FKn25NtJ/beU+dhWE+
         ZDG8ocIXuLanVG3siS+FjkQ0S4TVt0pKoxuiTq4l3+UWlzhUivkyiJP3kOVJ+KctCVsf
         wXpMntKkFrOl/Km8dP4yp3k93kHN3x6mwCGGyebqE2vDdgrXEV3qHVZQE6KugzcbOtKR
         Jo3w==
X-Gm-Message-State: AOJu0YwKBGGY9/eXHZzlivX6GvvjaVaQxFemEBvmpiofLAIiPGJzz4XH
	APIyF+KUXJ+GOwg/tn8D5g9c+uMSRehhV9ZU1XZKEUbIFk4bAoxFG5RFKScSI3kMrHRcNvnxosD
	W5ruGwpqCCcCNXFy/i0ktvnbZ+GfID1VE8EtAseXeksUhxo/nTTxvzp1/Gg==
X-Gm-Gg: AR+sD13rauAQpF22Pcpsv+iT40dLyo9FC1PmEfDvtYQhPiEB6H0J0EwCAgXO+PYgQWW
	5f5FO/dAtqR5EdBhQfLa2mDbP3ttrCdIEhZ5eMW7AsCxIvzq+uE1z5xkRNiEembusDbbkl0dnzT
	TSizy5hh1iUGDaoGvVUpmyGi1SbFRWn1eyq/y/58Kf4bUuPQmyQscnGasjpX40p5E0LemQHczbm
	tCVzWlQOXE01Mq+GNNqpYrvubBHG2dH/BQJPvAwdiOfYTq+C0YNZQ+23bUVLlNVe5btm8B8rbSO
	AHeg71NP3rSlrhP6UJqhtyiMyrFNNR84Mw9tS7km2DoC8WNqpFa+cLXEScGFnZxmU0WkeTnC/hU
	h+BVVV4KbMg2KqsKyK0MMM88VzgaVuy56QjOuJJcCYypE7lcLxBtaZsWC5eoprGN8mVisCoQo+T
	E=
X-Received: by 2002:a05:6000:40c8:b0:481:568d:f119 with SMTP id ffacd0b85a97d-4816068c6admr46795638f8f.0.1787049561319;
        Tue, 18 Aug 2026 03:39:21 -0700 (PDT)
X-Received: by 2002:a05:6000:40c8:b0:481:568d:f119 with SMTP id ffacd0b85a97d-4816068c6admr46795511f8f.0.1787049560753;
        Tue, 18 Aug 2026 03:39:20 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm11752248f8f.32.2026.08.18.03.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 03:39:20 -0700 (PDT)
Message-ID: <0ba32ecf-306a-43ed-93f0-e378d21a2bc0@redhat.com>
Date: Tue, 18 Aug 2026 12:39:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] ip6_gre: fix hardware header length for NBMA
 tunnels
To: Ido Schimmel <idosch@nvidia.com>, Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, atenart@kernel.org,
 yuehaibing@huawei.com, kuniyu@google.com, kees@kernel.org,
 kylebot@openai.com, thorsten.blum@linux.dev, maoyixie.tju@gmail.com,
 vega@nebusec.ai
References: <cover.1786542637.git.zhilinz@nebusec.ai>
 <64b46542bbe1701f07702aaa50273e2a87903db5.1786542637.git.zhilinz@nebusec.ai>
 <20260817064250.GA196908@shredder>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260817064250.GA196908@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 8:42 AM, Ido Schimmel wrote:
> On Thu, Aug 13, 2026 at 12:22:34AM +0800, Zhiling Zou wrote:
>> ip6gre_tnl_link_config_route() accumulates the lower device's hardware
>> header length into dev->hard_header_len whenever header_ops is set. This
>> is incorrect for both users of header_ops.
>>
>> ip6gretap and ip6erspan have a fixed Ethernet hardware header length.
>> For an NBMA ip6gre tunnel, ip6gre_header() creates only the GRE header,
>> the optional FOU or GUE header, and the outer IPv6 header. The lower
>> device header is headroom needed later, not part of the tunnel device's
>> hardware header.
>>
>> Keep the lower device header in needed_headroom. Set hard_header_len to
>> the tunnel header length only for ARPHRD_IP6GRE devices with header_ops,
>> and leave the fixed Ethernet header length unchanged for tap and erspan
>> devices.
>>
>> Fixes: 832ba596494b ("net: ip6_gre: set dev->hard_header_len when using header_ops")
>> Cc: stable@vger.kernel.org
>> Reported-by: Vega <vega@nebusec.ai>
> 
> It wasn't reported by Vega.
> 
>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
>> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Thanks for all the reviewing effort!

FYI, since some time, the nipa sashiko instance is using as input
gemini-sashiko reviews, and cross checking using different models
(including opus-5, which AFAICS is the one producing more relevant
feedback ATM).

The bottom line is that sashiko nipa is/should be the most relevant
sashiko instance to look at.

/P

