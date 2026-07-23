Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34B3EE1E5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793597; cv=none; b=OjL21xoLJdC6zV87xZZyiSwHLkEIpk22ByXoxA3KGFC263Cw45BEjjYUeoe0F1tTnyLdPUFvhH6EzV0haXhTv7jRIJaDUV3JopyY3AooU+oHEtfulTOchiptqbRvK5Hj+Myl/hZ7ANEdGxvMaCKc+ebwIw1J7XzSgzjfEqopTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793597; c=relaxed/simple;
	bh=No3y6kELBc7olzI8QwEEy+zapRVEzzEwggV2aOwKR9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjAMIHU1EyoCUciu1aJXRoHaTs4r3GXtM25KB3tGQKUOOwSJMen/lVO0N+SGEZW0xxG1Jb7W3diLc2+lwCrKXluguTMVm5b/1eKDWpacp8YL6QCi5xw1ABEHqvaHF8cDEOELN+7IMInMijA547TDzI/rcg1nHJg64Qfz0V7Gxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc+os91T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pytiE+7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc+os91T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pytiE+7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784793594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=No3y6kELBc7olzI8QwEEy+zapRVEzzEwggV2aOwKR9M=;
	b=Vc+os91TXGwJJBuFJ5C+1rX0GdH6scG9c521y0ZoR9sbG2jwSB0FRnztW2w2AOB2BwhZ9r
	M/dHq4XAK3/YZ5o0SFWtbDwRhZivsIfvw03OGjxWXO92XDMnA8ITwl+UbeO6m8r04UDY4W
	Tt5hT0cl5qD+8tzLWt1P7qDVkpENoYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-U-y6PJJMPBqNGERygYf1Rg-1; Thu, 23 Jul 2026 03:59:53 -0400
X-MC-Unique: U-y6PJJMPBqNGERygYf1Rg-1
X-Mimecast-MFC-AGG-ID: U-y6PJJMPBqNGERygYf1Rg_1784793592
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so193082f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784793592; x=1785398392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=No3y6kELBc7olzI8QwEEy+zapRVEzzEwggV2aOwKR9M=;
        b=pytiE+7TKtmoTJ+3ky591vjoICGSl8QmglgARVrQM/WAIAf1T6PNxskR6esyVaxFay
         ut4FYuAyqFkOe3tA5MI/TuRB4ZqPYAALP4PD54z6Y4OmoN3qjrHlf7ZoauIAQwin9Z1o
         rscbOLCePN4hVpQy4W7Dr67FA7RQGY90essXPBLJOG1LUIb1TO1GKkAhkphJJV8BiATz
         E8K18dYai5Icplg0qGce6QbF8BicpEQNT/aFsJlhDyC9XWkTnvUhQ0rpZWAIhWHRdIEf
         iFaUDi4beIqOJWc363LWdfCc8s+yuICFNH7acaCJot9OyeYIYVgPFZMIoR/okN+pdSy5
         s1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793592; x=1785398392;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=No3y6kELBc7olzI8QwEEy+zapRVEzzEwggV2aOwKR9M=;
        b=bPOCNVQI5TnBxVE1lWWpEBMw/t/0fGntFBb6se2LZ3QhccysSykRz/PcmnAJWFldO4
         hInKsNngPTzusAZeKVf3SXJfQEQ4PFWt/TDrUFtTxNWrbe8e96Og+S+8a9p9Q/tcncz2
         sM5bXGE/vmo6Cz14BB/4wPZHty1MUtBuOoFHAyOKbZOEl2ZBCyrInQGhHcOWT5DnDnpe
         XOBVFcC6Z3fN/t1kwyVkCWcxtrFgwUD51LFEPzdTRRQ/Y428XyWVu2fQMppkuFoDGWQr
         8PQeVoh12AWSW8vokZArGJn70LkteSd/YxM9UEdMgZu24l8qe+NzjuZ01y6GkR2MhRrk
         +bcg==
X-Forwarded-Encrypted: i=1; AHgh+RpYGSYyo/wx0iZbn72QPR2PXxxgsB/TnX0Ym/1cPXvet/Oi0kDfCKQ2JBF74yAKn8JrsIxZER4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/Qkfq4QsK79etqD/dCSCgoF8Y6X1yecwymgE2Z+4eDDIUH9M
	qGokAXhlS83xLk4vKBaOUIr7ITRUbnJKoXi6x7eEKsqbVYiwA1R62EYcFRSPtyYEUqvL+obtlDF
	5keESeOmUjakCHjmF7xsQiJKBJNYbIqMtdjgW/wX8fY6/ZSMhU5nrV0NcZg==
X-Gm-Gg: AR+sD10ZRK1oib9fGR6AGrXGRGznrKn7D6hInSf0rl9eRCOYvzjTDDhAceKNmr17E3s
	AyUh1EJL3tJ9Ry9htTZH/AfjEOW03HH7w9XCQg0t2z1yTFHM+t/TPNiNFIcf05hfOxophJF6EPP
	XAvbQcXQjXIGx2DuP1Ma60kdilfXciieSxsUwAm5bzbiCloa4kIcdH0FPVifVcrUOMVAXgaiUS8
	1FmEDjqvHX9YCp2qtuFGObGeHTwfUWVkcT+nqTkTB6XKtwNmb3TLkI75+UbTMfApEnDPTGWqX6z
	Ze2e1Xmn4uklIwC50foUF8oL4yENgHhGhtPy6SjJMc0EDuQot41qgb/3rq4UZQazwl67SsqtDGL
	IsAgrRWz5xctqLU7it1jxunc5Lb5sWAlYaRY/Hepw/6DnUvKJcrMWrx0crYagI39OuF2h+lUBuD
	Sgqg==
X-Received: by 2002:a5d:5885:0:b0:47f:59b4:390c with SMTP id ffacd0b85a97d-47f8d75f30amr2381023f8f.50.1784793591878;
        Thu, 23 Jul 2026 00:59:51 -0700 (PDT)
X-Received: by 2002:a5d:5885:0:b0:47f:59b4:390c with SMTP id ffacd0b85a97d-47f8d75f30amr2380985f8f.50.1784793591448;
        Thu, 23 Jul 2026 00:59:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6ef25sm12189475f8f.36.2026.07.23.00.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:59:50 -0700 (PDT)
Message-ID: <dc814287-dfb1-4514-b349-104e6754cd38@redhat.com>
Date: Thu, 23 Jul 2026 09:59:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net 0/4] net: hsr: fix GRO/GSO super-packet
 handling
To: Xin Xie <xiexinet@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, qingfang.deng@linux.dev,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260722171836.196-1-xiexinet@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260722171836.196-1-xiexinet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 7:18 PM, Xin Xie wrote:
> [resend: the previous cover letter was silently dropped by the
> sender's mail provider after SMTP acceptance; the four patches
> themselves are byte-identical.]
Please have a look at:

https://elixir.bootlin.com/linux/v6.6/source/Documentation/process/maintainer-netdev.rst#L385

Unfortunately this is a very bad period for unneeded repost, given the
unusually huge PW backport. Processing of this series will be delayed.

/P

