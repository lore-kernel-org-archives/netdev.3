Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91999411A0D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340909; cv=none; b=fsnIwFv/Dop/uymoyqN7Tv8QQ/75xNhhzCNVshcL2Ao2p1EruCYZ5sAnU9jHJuNAQJ04LMa29iTdmwNkzPVD53v3j6XZFRQ30NacHr/2rp+ANqkjvoTSXlDm3pJ28lYfl1o/HGReAo7e9fGNugtsiSI/F50z5gIFbu1XIzhvSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340909; c=relaxed/simple;
	bh=RwAX5pgChJMqfXEa33Kd2aBkaBUj6UYE8AgaDNe40rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2AIbx39qjjRzA01TeKfKKxMINkYtykpX2NdVdAnnYL1tbDnZa7CfN0Yjb2fmVlwvRqMP6Z8NTOi78LhHnNfLS+7Kmkk8u9m7YfWd+CUkgzK44ibO8j3JthxT/YJ/WMaNbZEP2SJDZ+getG3vDykLQAwLpuUK9zaEL6nJub5y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso4367825e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340906; x=1785945706;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4Wt+vjl343skXe3sXNKhwsDuZGTpbrXV2WgtrONqIc=;
        b=j60B/iygFug/H/Oagh5kKWQaMsEvhUzdux+zNsd0ecpl8yQPRtpd7kmPNNF3DEPR3h
         G0KMfsUXu5IMNx8CKwAjH4EPmCJPSCkQc/UXPfARh/UhHOskzwgXEDQiKNLkLd0hSxdS
         x9ruGtI/oFI2rcA6NpjvSgDFoZdRRogoUPVVoHuXyLpakC+McNg8VPsYlVWNXi6rmVdP
         otW1waiPflkzvElTdvVZJt+uLYJ5xphfmfKPY2RicPScDb4Rigq/wSC6z0592vwOf5yJ
         mTekIoe1iy/Z54w40OC4mL5rTciWLohxQ/4nVko2x9iCcnSsliapv2wB5hggKz+ytYLe
         OAow==
X-Forwarded-Encrypted: i=1; AHgh+RoDnBKkqV3Jujk/hKJ4qVyHh1t8itQTR+k07GjY0BKOPqitb/mts1Pwa5RRSLEhmdC95A3SU6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2abUEvRK+Yr/P4fU3wdk39KJ71riIQQaFMm6SYEi1SwGdf/GR
	QSbLYr7xnihcfl5NvQwn5JdG1A7QLJjPdRW2F+nG880cR7LOKBPWC8kj
X-Gm-Gg: AR+sD13S+GacWT+HPXByK5V27e4z+Z6DBCxxOit85x2C6pq+O/fm8CAA8GJqCQlkYd2
	xZnFiJR2LU8gAVJayukX9SU7eWXxlx4wV5Q3rAtApULjqQK6ziSD0LrpVcMK7MzKQkTstWvYu++
	a3WgKvfgF4kujRfXTpINLP8BOzqSztGqL0b9aYhjsfvyHWKgNVyVugXWQpRRCDyQhXT+uUX6rhz
	P3vIoCNvT53bA0sqt+D3dqQxZtCxrDluq7PAngIRNE9aKSDixGClP+yFqu3KumLHDDuDfkG/FRE
	dglcrW/wjkrAdORgoDeqnT8S7WYGcUGelSLROOesVvx9uvbyv7RlEQz5Z+1ge4lbL2DZ0DMsVAm
	Ht2hbmFAcQ7zK5O/Ngwx8AzdpeyZqS/tNVbMyawn/DVVo7UCXgXiqP9s7zXgUJlnKBmq3bEdIkZ
	7yyQxSLJC+rMu90MRBf4oA9cI0UH9rijZzgDNTO0It40HAC/DNEv4OAlU3HzC/icgNUazboXX1m
	YxT33TvSIegqZZ9fOWwMCUv87c=
X-Received: by 2002:a05:600c:4fd2:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-496c6590660mr93994975e9.21.1785340905518;
        Wed, 29 Jul 2026 09:01:45 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6abd0a6sm7503911f8f.10.2026.07.29.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:01:44 -0700 (PDT)
Message-ID: <9e03f8a1-a880-48a1-b392-a6d72c2abe8e@ovn.org>
Date: Wed, 29 Jul 2026 18:01:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] selftests: openvswitch: SCTP flow key
 parsing
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20260729064549.3647518-1-houminxi@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260729064549.3647518-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 8:45 AM, Minxi Hou wrote:
> Add OVS_KEY_ATTR_SCTP to the ovskey parse table in ovs-dpctl.py so
> that SCTP flow strings carry the L4 key through to the kernel, and
> add a matching selftest in openvswitch.sh.
> 
> The missing parse-table entry caused a selftest NIPA failure: the
> flow string "sctp(dst=4443)" parsed without error but silently
> dropped the L4 key, producing a flow with only ipv4(proto=132).
> The kernel's match_validate() then rejected it with -EINVAL because
> OVS_KEY_ATTR_SCTP was missing for IPPROTO_SCTP.
> 
> Changes from v6:
>   - Trim unit tests to cover only the new SCTP key parser
>     (removed tests for TCP/UDP/ICMP/IPv4/EthType which were out of
>     scope for this patch); address Aaron's feedback that testing
>     existing parsers was excessive for a selftest tool.

I think, what Aaron meant is that we don't need tests for the test code
in general, not only for existing parsers.  And I agree that it feels
a little excessive.  I'd suggest dropping the unit tests and merge patches
back into one.

Also, you need to update the tools/testing/selftests/net/openvswitch/config
to include SCTP, as it is not enabled at the moment.

Aaron will do a more technical review of the test, so please wait for his
reply before sending v8.

Best regards, Ilya Maximets.
