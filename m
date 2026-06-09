Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4893F4835
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002584; cv=none; b=uZokXWbDNkDouLEjV7dJp3XAKlu//ynMET/IaOvADqkbkIQb6CH44s/P+pmHN+gPjZWz0XpkgVLCXfJUHOstKRqIGpx5J4IhW5WnaB0md0MaHvihVvcSOV073LAc7Aljc+0fenOep6G1btOUzBD6T05kwLJGg6d6OHytEDJi7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002584; c=relaxed/simple;
	bh=+I/emWIMpz5OK9O0WDpDRa3M0xoLc3qCWoaFHxS7tU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgcG1PNHlQSEUIdgqmHcEUxwNdIqPsLKE3Kv1wjJ88BuMCIeKbpsRE+43KMyUlLMuv1oy5M1cQLkdI6S5d7PbURF+JVgw/NrGCZFfu1QrFysqbShMrKrb7syTuk+BSQe4/RMeOQqrHpXKIBzUkeES0ds59ine4Iwt5nPXxbD76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU4iWvNQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=olCSFWTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU4iWvNQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="olCSFWTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781002582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/WfzyLR/nks8SQbfnC26t/FYPJsMiOkM/D4jryDNZ8=;
	b=YU4iWvNQhmyJWv3xm7QlmjzymsUpL5yUx5oZgsEzlr8pI+mwP388X5m3qsS0cmHUwfLy7a
	323llYSCUoDHv2JVV3Sh4w8QshEx/ZCpwzOIjKVb/2j00nLZWCS49jSEjQQG8g3SkCOZJ3
	UiaJ0CXz3Aos5DURlwAJK5kqaMnA6e0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Xeb5zYPWNU2E4GX_ADfwPg-1; Tue, 09 Jun 2026 06:56:20 -0400
X-MC-Unique: Xeb5zYPWNU2E4GX_ADfwPg-1
X-Mimecast-MFC-AGG-ID: Xeb5zYPWNU2E4GX_ADfwPg_1781002580
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so2494171f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781002579; x=1781607379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/WfzyLR/nks8SQbfnC26t/FYPJsMiOkM/D4jryDNZ8=;
        b=olCSFWTBKsKtO51Uq6Ve/QftnkCKSZ+usUqmNXo3mxvp8cWwYmfIm6XwtF1CstODFw
         YKCFY/3x9jyFmfYlCBn1cK4NHBGacdsRx0dtXxJCDCK2QBaZ04BpfXSsPDy9CtlCvnD0
         LvG7+fObbpt3PCb7EYHZI47XVyFAzK75Qomkk4sBr6LRj1ZtBfOjikqqAISUIynSAxbv
         Zs0J8lUOFyHiOUveVf0kT59/uWlCjglombUKEF/ymCtFLoHNszz0bV6D6aLclf6y3SHh
         HYZVmSYCDdJ2GdIu32un2RoBpPJi+JhZ0GgVgONj8rN3hjICNIke1sRbEOdnMYo18hMY
         2+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002579; x=1781607379;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/WfzyLR/nks8SQbfnC26t/FYPJsMiOkM/D4jryDNZ8=;
        b=Hv52vNrKRfMDETL6exU5j6wEGNpTu/oh6Ugk5eB5Xnjp0f6e4xWyz+nQslaXXPt0qM
         XpewaeWeMt8XSQoWP6wgCQG3QtxNRGvcksAx7Gp9QxE6ehhBY0n7FGG8jB8HHSPuTG9+
         PubVTp/nnLzZPJJdfvlj8o8gc2QplFsMiCSqIBZkMXYUOa6g9K8dw9LntoTEmJM5wJfq
         Y4Ez/r4QZUFs40ctFmt0dnhef0PJ7PDJ6DPnAJAVqS52bnxW9BO6MRN8f8bg4dEvSF77
         M0clL2mXQrrzqtVAbUCP1tT5Tkz0tlkdGr5V9tenbH38jhdUOIaqXpABuf7yxJilOES5
         FQSw==
X-Forwarded-Encrypted: i=1; AFNElJ/AwJfNayD3qZ7GCqXquk+xqZGx4D7co+09nOgmsrq190UkOYPxqpcJeaSIL+Gh/7M6jJfnMho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRBQBNTOzC8ngYRN1CTS9PzY4PAVyguzGDg/lVd+3hFc974I3
	UsGaZHaJyJwxXw6hxzYJDHuQqk2J8vyGNI6C+k4kojXUX6n0nrnCkq/G0kMrrzvFuazwYZbnbZj
	tHYGq7MKCFPxOSmIlg4c94j27dfC09+WBdfL0NItDAYt8SM+z4CwoSSVuNA==
X-Gm-Gg: Acq92OFnuW/MfIMxJhRXOdhZ+ZroEordOokWqMcDh2runTpWGjmr79Mc8RHxGAtPh/s
	Gdp33dG1C+0CtE0m7DuleuMWTkCwFRzSS7wH/qS62+gn0hCwLyvCMZGpseK6y+DHvpjbhZd90dH
	Ozs6jailT8ajBkppQIYdtwO7FPw4/XQrKVsHMZI5AVI/azxsj5OweBs6+MM+W1OCN/b6hSiib09
	LHA7+4tTfXWmhDubnb5eEQirs/CvTXGimiODunWuwwMLOI9ad8J5OmM3wBiUWW8YNjWJCHAZgRo
	fOTu6+OCHfrPOYNozHIZXOkm0MoMasAxnMKyc7e7mkKgKdDK6DVQprzTKP9/n9km8rByJ9qX0oc
	KjFuYreMvVaFpI3G+LLHINanf0+oAoKxNAW4Ya+gf091oiaXmna7l/mX4WTdhdYREKA==
X-Received: by 2002:a5d:4c45:0:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-4603063a18amr22853096f8f.36.1781002579623;
        Tue, 09 Jun 2026 03:56:19 -0700 (PDT)
X-Received: by 2002:a5d:4c45:0:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-4603063a18amr22853054f8f.36.1781002579214;
        Tue, 09 Jun 2026 03:56:19 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm109104155f8f.27.2026.06.09.03.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:56:18 -0700 (PDT)
Message-ID: <c530d07f-5841-4bfb-b296-b47fc0ce0614@redhat.com>
Date: Tue, 9 Jun 2026 12:56:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/openvswitch: guard command substitutions
 against empty output
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, davem@davemloft.net, echaudro@redhat.com,
 edumazet@google.com, horms@kernel.org, i.maximets@ovn.org, kuba@kernel.org,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org
References: <20260601115307.1411211-1-houminxi@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601115307.1411211-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 1:53 PM, Minxi Hou wrote:
> When ip-link output is unavailable, when the upcall daemon log has not
> been written yet, or when pahole does not know the OVS drop subsystem
> ID, the affected command substitutions silently produce empty strings.
> The caller then passes empty sha= or pid= arguments to ovs_add_flow,
> or matches against wrong drop reason codes, all without a diagnostic.
> 
> Add [ -z ] guards immediately after each assignment. For test_arp_ping,
> also align the MAC extraction to use awk '/link\/ether/' as in
> test_pop_vlan. The drop_reason guard returns ksft_skip because an
> absent subsystem ID is an environment issue, not a test failure.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

IMHO this is net-next material.

@Aaron, @Eelco, @Ilya: WDYT?

/P

