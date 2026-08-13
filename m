Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379848C8CB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635160; cv=none; b=tVKBP6D9OlahKszKSEOA+rXZlyEHJXy8JLc1j2HLMN4WzmJcIJO/LZBZzkaUN8ET0rDaGOLICzugWdjUQV6RnoCqJBI3isjgKJolaob+S4pXOr+wtLeCKBuisQoQrglmnFCNxKN31zqZm5D20+wHW5zI7bW5JyvM6gzlvPJogIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635160; c=relaxed/simple;
	bh=PzZSdJns7HjASdkfYzg1C+XYSB2Ffe+G2qcY53wIdd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uOxyagtTaNNrQokZaI//4LWMj7FX8KL4Vyy25FclVEHHgbRTIR/o32wDuqc4ME1lo7L7y8EqZcc3y6ItqTtDh9KeOqI7ZD8Cyodi1S47kMW8aNFsNI5Rzo63XA8PJaqnANHp4LXkj6qP/HNLG95jflfpLzFCMAIrNLioMZZyLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkH+q02r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIGx9ma0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkH+q02r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIGx9ma0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786635158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzZSdJns7HjASdkfYzg1C+XYSB2Ffe+G2qcY53wIdd8=;
	b=EkH+q02r2OlaJxNg3brizkGfserx5nw9bxPN4hL7D+/shNzgWpmA/a2gl7Aa4dAKVZNQli
	l3lDSq27JhR1O0YxE2xAOsrrn94d9QJKIT6bZXZS2MheOeqY9ZuGBPOH86md4/jDbF9OR2
	7+uaj9dd13cY8UlMSzC4dLdrYmNsVVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-sYMfmvVKMYK9btmpkJ10ag-1; Thu, 13 Aug 2026 11:32:37 -0400
X-MC-Unique: sYMfmvVKMYK9btmpkJ10ag-1
X-Mimecast-MFC-AGG-ID: sYMfmvVKMYK9btmpkJ10ag_1786635156
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954a93c565so143405e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786635156; x=1787239956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzZSdJns7HjASdkfYzg1C+XYSB2Ffe+G2qcY53wIdd8=;
        b=RIGx9ma0flWFmpbxCIKeGeWSHUzQPCFrJCwo3x+dLZGa3PCY5Nu2YmfiHBaQtul5dn
         Jvgadm3/OZ4EfUjt0AlOJ/QFp+NNU7Rv68qhoIicM/y018hKkFnC8hs+AxRAFfjMSyI5
         oUSQd2UotlSg5+kHh+u186/KbrSRT9YIHLE1kd2yBNBiyKZ4yX2sFx8/FPUce2/agnLM
         SmXf5df+5Idl5nHtYO9zVTK2cMJSeTDXIo9PS6ZenlSgxqdNge5ViDUooR5aN1CXfb9s
         ZZkAIBOBaru+aqQijnueDyEDPaUP6MPULcW+AmIW82RKjZ99c4uz+qZgjbiG3IaLtZLJ
         LOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635156; x=1787239956;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzZSdJns7HjASdkfYzg1C+XYSB2Ffe+G2qcY53wIdd8=;
        b=F4Xkkshv4CSWVP+9ev93h5HU2Rd62qiR4qNSY5kVL27vVmlC4YltnAKFLI442c2Qvg
         RsXVqhD6o2gtTIZFsO+RDIiEhSQ2v2Pj4Ygf/NdWcO7ccwK7NOC8+3vIltsAl9dRt7ui
         +Csw3NDsQHNdtE+/+ie8i5hsvzK8x6S6ImueLXh5PItTWOE1PKqa0X2ztEXiSt5FRUqn
         hI+cIXRFi/Z/3mEjOPoZPdFv6tyHBZRDVjMKQRJ/+QpeErIRKjk4kRxP124LxW9BiFpn
         DBl5/fLvOq6Vg0eJa5GIa89e8Yn25iu5p/H+UyCoJ8FTqPl8UFP3YhtNPrDJ9PSoi40x
         qGPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9it+0PXslvMD2BlY6oIi94LaaZLrW9Knrulxh7uQeHRpue3gZCjqarmshRqtfCiUa3+GF8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBkFFjBQBGq9MIANL9AtulaorfT/OScoYnm1VOJDW937w3Vn4
	vyKpBXZ/h4wD+aiBNkt3hNlf72limLC7qre6DTYje5+HYmuKoNUhzx8/qqd7n5ZUf/QTLmNchLX
	2wPEk9J+t1ILfMcnu3GG7vK3Tan4kZuCs1uycDGMGRTvbFGv9TDk6uAOBMg==
X-Gm-Gg: AR+sD11nu2FQspAI+Cli6QvQxJNsurTw2b/kaM4JI/NN8oVYuSSdscfwIMKXx5ZVOi9
	hRWwrUpQA7uTGMiT85Uruprc49PKXg9CaTXtV6WSgyqENJtd2Q1BwnA5nOpZMoGZ3CDnjTdPa68
	9D3jJgifjq1CQvCbSDGhO1vXBHP3bLFsim/J3IozUFcBSUW/7/M/m3xA+/bGuCdPSm4PcoLw8hx
	4/7N2E2HNKHcRVyNzx9b8a6p15koJiSQyJsXyw7Px2AG189PIau7BtDRg22JxZaCIHvnVAp4OxS
	M0X08/+kbtAEygVjYbGO9LsA2yKwMgz5ldZQVeegT6JtDRSA2uTKJf12JXeZnouNOUPcUM6Nu0i
	GkG9YdwCf6TkhtUXBCQfAMVXSRpeswSztXiBXo6nE8WD2DG7du/sBGF9JhOyqYacWX7EXo+WV51
	c=
X-Received: by 2002:a05:600c:3b0a:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-499821cda7emr68106465e9.7.1786635155974;
        Thu, 13 Aug 2026 08:32:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-499821cda7emr68105645e9.7.1786635155548;
        Thu, 13 Aug 2026 08:32:35 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821652dbsm71500225e9.9.2026.08.13.08.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 08:32:34 -0700 (PDT)
Message-ID: <e5a958af-4144-46ab-915a-84fd2075d383@redhat.com>
Date: Thu, 13 Aug 2026 17:32:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v7.2-rc8
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
References: <20260813152104.256382-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813152104.256382-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 5:21 PM, Paolo Abeni wrote:
> There is a known WiFi/mt76 regression, waiting for a complete fix that
> should land soonish.
A revert for the blamed commit available here:

https://lore.kernel.org/linux-wireless/20260804120004.523934-1-mikhail.v.gavrilov@gmail.com/

Noting that it will re-introduce a bunch of kernel warnings.

cheers,

Paolo

