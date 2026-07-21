Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8161A9F82
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625757; cv=none; b=BW7iw1A6K/fILHxduaEwD6luDo4Dyz5lmnYeBMHYuMIEsPUnbHHetHUUIdOvefw1jPhdgua60xZ2G2nNAM4kUYlsPFxzkcs07h7PaxfdyEU4mgCNo4Ca/SZ2MXYfvqP04+SLIfiCsokAPqP5JXi6OZb0KO1CCWZR2GJrwGTLfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625757; c=relaxed/simple;
	bh=V9t7B57bdBssO+2R844LK+yIc3KRghmALDC2YOz1Xgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtFbkozS8iZxcpcMH5jWWHHSCl5qGtIvI5v6aqWdfzactjPwV7qsjMT7qOIPQiNRfpwuLE0CB/VawM3JsEqKSP1pZ/5pNqn3jCegTITT8pj6ycQG3JWdycb6abYntZCGHKjVvQ51ViXCJozkfXUpZGb4v2AAdHnXtQ655wrswdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOkWy/jy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6BGji53; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOkWy/jy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6BGji53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784625755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9t7B57bdBssO+2R844LK+yIc3KRghmALDC2YOz1Xgg=;
	b=TOkWy/jyqxVf7AxnyNy+pdWDPfn/PHuUoS279yDc2LsMc7EjH20+OZpb2vdchoR5ogd0WY
	KyGbTBUtG6Aucy7mkFAbKPGO8Xza+/1EU+Y/f5mQtT4g5GN6k+vRF6KlwCwr0LcYb1tb4A
	CyE7ul7MJaQahBQGPdjAxYzKC2ZVa5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-6S6rntRzNzKfnSBZ90hh3Q-1; Tue, 21 Jul 2026 05:22:34 -0400
X-MC-Unique: 6S6rntRzNzKfnSBZ90hh3Q-1
X-Mimecast-MFC-AGG-ID: 6S6rntRzNzKfnSBZ90hh3Q_1784625753
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so99122255e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784625753; x=1785230553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9t7B57bdBssO+2R844LK+yIc3KRghmALDC2YOz1Xgg=;
        b=O6BGji53dcYdsEwRvWssp0rT8K0lJ4welnl8wDZQFP7UUL4BWVC/GQJlvSTUVAsMpV
         D6eF0tQjnFASnCY1mfSZ3nZA+GtIWcWNwkeHtShRyhB53VQ7ViFAfUGoIEMue4GVkV7T
         2fgxM3Hf1OSkBGmztGThUSRQQGJzZkwAeMn4G4pNIrHEEZGuQq+amIuz6Aj2LHgXQOBh
         QW1sDboEYxJ2UZIzvfDWiHtNWw/t/xvZCnANPVl5Bak9KJl5PLBY8W3ZYBhgcluLGSaM
         N8ywFXz08OSUq0iO5xGElGL5k3kVIEKtK7QxaBNPxpdNXJK9abbcvNosBzMebb1ssPgg
         0y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784625753; x=1785230553;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9t7B57bdBssO+2R844LK+yIc3KRghmALDC2YOz1Xgg=;
        b=AbUovzHQsG6AnRWrngSjmjLH/oG84A4DniZ1qzEfzrhXT4pnIKSa2mesDQ/HXsiWgn
         LT8m8N8zufdjAcFmgZGosjRUWEr5tiJFItpb/bBFeWIW9PemYV0CKVt3mNilmvlczuvh
         rO/yjwgAG46jjfZZy8Mxx+bjkgXXhdfB5tvRfhIyhS1/dSOjVPzH9Bs1LGKJAoex6K+n
         YMZPNInzo4myrdRgHvExx025cr/fJDkozyPYf8S0rSNWIqGCXFNtAPYnlbv6dYXUsip3
         JTWQtZHgxwJRX2TGbQTa5LyNf3SXIhuupqf4gqKg1laKkU3ste2PjnPXfslcDUMePD6v
         yJow==
X-Forwarded-Encrypted: i=1; AHgh+RrZOhy651Bvo9r/cZXspNbhnlDZdraXjeW1S/pbaP2O6CnE58llLBcOD1V5NFpYqFXkyAEW1A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHI6yxAjGbxJvui9bea9pLUF//bBT/xWjWUElIwtb+VfPmjQ0D
	rdgPQZdEsXO9BDK/jQ15XSD8ensL3DhVC1ortWEmzZd0j0EeVDybBxzOfXJwteO2SdMBO00IF9v
	BNGT5NEBpedoZYN3YLiYt8EpU6YI9YGy9jZGt42M93HaVIFEGvrxm1vclOhi4SMJ8dA==
X-Gm-Gg: AfdE7cmm15xiw9CnwSZuHzNxlwhMJ7vJ20cf0jKLqKgMrFhUt1de9I7OU4fXbiAbFK6
	Ga1iwtRQHcgrKG3xzCXRrIMq2gxdE9N4CZKue2H5MWez8yIDHc6A73i8LDZLF7jfc5xgi4XVH3O
	F5bi5bZeZ1kdxQhsl/Gm7QfaEGrt8XH+6KdpMjJ1nS9g2zieNcETQmK3DsRjEihVDmWsThJYQee
	7w8fXDTXiqzMMVhsz7RIjVLfofi+nLrEipqw/UfzVZpNrI+FxEtDOkPbzPBxahdd+rDbCEb612w
	G/FA5yfS6gSWLYWotyZZEHQ0IgagmxlhTPylRyV93zfXPPXC6oTJHgxnhYQ4bxoMymOLiBwhYmM
	GrExeUjmah+FTFi1C6aHdkIHHr/P6uXbKWuzGxnLFxl2zsA5BlYLqQC7rJ8UohVZFMyyKAeCf4V
	JGjQ==
X-Received: by 2002:a05:600c:1c09:b0:495:4fd4:f7b6 with SMTP id 5b1f17b1804b1-4954fd4fbdbmr173134695e9.37.1784625751902;
        Tue, 21 Jul 2026 02:22:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1c09:b0:495:4fd4:f7b6 with SMTP id 5b1f17b1804b1-4954fd4fbdbmr173134415e9.37.1784625751503;
        Tue, 21 Jul 2026 02:22:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm40416990f8f.21.2026.07.21.02.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:22:30 -0700 (PDT)
Message-ID: <d6cab50d-dd90-4022-ae15-50df05b85556@redhat.com>
Date: Tue, 21 Jul 2026 11:22:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] gtp: parse extension headers before reading inner
 protocol
To: Zhixing Chen <running910@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
References: <20260708042244.120898-1-running910@gmail.com>
 <CAMyuFdVWgvx4yafBQfbTt4Do535p3PF0LCpZ6Gma0WZ-De2kyA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAMyuFdVWgvx4yafBQfbTt4Do535p3PF0LCpZ6Gma0WZ-De2kyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 9:28 AM, Zhixing Chen wrote:
> Gentle ping on this v3, in case it fell through the cracks.

Please, don't.

Maintainers are overflown by LLM generated contents, and conferences &&
season interruption reduce the available time. While the patch is alive
in PW and no comments from reviewer and/or sashiko are pending, no
additional action is needed.

The patch LGTM, I'm applying it now.

/P

