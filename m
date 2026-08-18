Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA5476CF7
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059145; cv=none; b=gZhjmVzQpfV/EXL5X7HCYTRDrqrafehdjdqbNtlIaKO6J2sqT7tBcE3YR5l6o91ZjwluJHWxGzlSn0CGe9sBx2PGVbaoIgb9STu7PWD6xvCXwFmoq+ymp3sAbdQbwFiqlVA9lnJMv3IToh+CikRi74s/jFcKW94Yknn00WLjD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059145; c=relaxed/simple;
	bh=K9AYjcSpVCzONxZZ1QdyN/huFM2O2T8f/N4CMMgl9Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZkiNN0I+u+LjgED2ZAziE0JLemhg1/OAX0ma6e7sWTAJpEAiXC1udRzVsMFmv4ycFBBb3Pt1oZytl2DBHEEGVD33Qijbst2enu3GNJv+EqKBoLj/zVqnjnTAG0XEeueNx8WDaZ/dAi4baL/1J83/eiRfEYSce8wysUNxZN2KLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9nF6+I2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6jX66Rg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9nF6+I2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6jX66Rg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787059140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9AYjcSpVCzONxZZ1QdyN/huFM2O2T8f/N4CMMgl9Jg=;
	b=F9nF6+I2DUqZKX9O852wFg9pUCxe0AOVIqpjb4GEtWHo8F1DxkDQvmVBTGCPwUqEWvwhEC
	UHIW8DxSSbzuinMgb7c3CC7fY4VrFQfk5GdOaCu4UGFC1NzMogdB1sp7XoPamuXJTbAD9F
	taY5VDI+w64UJlJ/uC0QJzxS40p74Ok=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-K3L9BoZeO72hcwIe24kNjA-1; Tue, 18 Aug 2026 09:18:58 -0400
X-MC-Unique: K3L9BoZeO72hcwIe24kNjA-1
X-Mimecast-MFC-AGG-ID: K3L9BoZeO72hcwIe24kNjA_1787059136
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso4720465a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787059136; x=1787663936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9AYjcSpVCzONxZZ1QdyN/huFM2O2T8f/N4CMMgl9Jg=;
        b=H6jX66Rgwm/iDHDxa6FB7cIU7qUt3jCybU/LSrVZuBiUvSNo/4Owi+phP09L5PGx7j
         ZSK2fPGJA9m8jNdCZIU32H0gyBqhN7Dp1FhZSBVuqiK4ZdLTU9hrwQyJ/wqnfBnLsCJN
         fHuR8MKU49fBDZUom10nylf++OxdZjskuop8+GChvJlUMXrcn/o8HA2Q5/5TJIBZhH8r
         iX+QeqXTHa/2K35/97TtibNRzJdJcjWZMdcaCyXZucfMqU81fiqddpwcDQNcxrrkHCZU
         WVe1bME+8u+CXYKengb6ze0OLHkcCPTNP0kk9QDUZP4lLDf4fGxjjrMKqrcEUkX7sW+u
         aLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059136; x=1787663936;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9AYjcSpVCzONxZZ1QdyN/huFM2O2T8f/N4CMMgl9Jg=;
        b=Wdo1fQ9PIJQV2YuZ5f1pFzupK8WTr/PJw1CNyHNMhj+uo02/si0a36G0CmWcY3NlY1
         +gVRSkr183Sha6gQkHnAWJgdWV+f4IOikX3xatLxnS0ZiakjHoNqzTJ6LFL3gShm02sx
         8usTLdP/aZkDc6hlBYXzfcxZX+QHz8MwSB/mIpqqYl5bYxtvsH/coWZqza2udawDndQc
         2WB8Tl3BpuEcgyfkRvc3Pi/LSCKfJ6DIohbArVbL/HK1fF9xXJImDEFDWH7cDTBCVY0T
         ZCznNT5vvNkvFBxcRekmRG/DqYEymoOLYFtDdFsQHCESfNyNhyAN1xJlbFSyRg2fjVZg
         jUmg==
X-Forwarded-Encrypted: i=1; AHgh+Rqtov1sHACNmTIp9ynSbvqY/W3JpQ+vBAUbUt+VBkR3NHb/JExcpNWrIWUphGUEi8G9dNHzsGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4a3OVguI0GA6pB5uNmosMNAJp9ouYmdLlqodTjTQKHnOni5xk
	GCmC71vvRceoG6aKtlM3ABCzkxgPiSp1uP0OY8s5Qlq/3UY69eABcJXQ2GLoMtd943MceMG5E1K
	w8KgrfcsP2jEn7J0RNraWmciEyNpEKTteCO/j5Cb1yGCQfl9LVqT5sKVc82SzHCEKAg==
X-Gm-Gg: AR+sD137ABushMF9SzT9+j2lJBiSevxuxUZKCIRoWiNC13a4sXt4eew3s5YdjeuBTGw
	N5kC4BqJoepzH7uH3E2MJ/kUNTqCmqyIQqTFfRhplgHJwq2/XhwcMCPpKXpRRB10SxJZNBIkInY
	P+XCWshIW+o+MjfRMDRLQQXBbw/F3Em6nZd726R8xVHH7z4LKI8gVBFBY1UFk+CoNfvfAlaZgQI
	OBY2OrumOwZ4xiIoirjnc0nH+FhmuauRt7gwVZ4KYGkHkBWDGt9bivHQ1945YkWV7eZU2mU+E31
	zLiMJ5IjV1WpAkEieuiDIUP01nFWQaf061XG4yvjYu0kY8IrDKrgTO0R54nm24eDFhlCbuFSOvV
	LvQWelgT4Au7i2hZ7H/roV89TfjHO0XM2NJxBP5fnwQuWer01VZNUHgN91rYXtdafNvaU7c2poS
	0=
X-Received: by 2002:a05:6402:1588:b0:6a1:f93c:f0a6 with SMTP id 4fb4d7f45d1cf-6a38a997586mr14907307a12.12.1787059136171;
        Tue, 18 Aug 2026 06:18:56 -0700 (PDT)
X-Received: by 2002:a05:6402:1588:b0:6a1:f93c:f0a6 with SMTP id 4fb4d7f45d1cf-6a38a997586mr14907218a12.12.1787059135721;
        Tue, 18 Aug 2026 06:18:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8596ce4sm1792511a12.21.2026.08.18.06.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:18:55 -0700 (PDT)
Message-ID: <3f18947b-3136-4526-be12-08444ebb238a@redhat.com>
Date: Tue, 18 Aug 2026 15:18:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] Netfilter/IPVS fixes for net-next
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, fw@strlen.de, ja@ssi.bg
References: <20260817232957.1281637-1-pablo@netfilter.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260817232957.1281637-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 1:29 AM, Pablo Neira Ayuso wrote:
> The following patchset contains Netfilter/IPVS fixes for net-next,
> I am targetting this tree since 7.2 has been already released.

FTR, you can always target 'net' regardless of the current Linus's tree
status.

No action needed here just FYI.

/P

