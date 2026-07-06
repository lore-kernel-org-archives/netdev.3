Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2712D8370
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344853; cv=none; b=ckKCKw2+terqQxBIDHw0Ei/Fi4fMND074naXHI83GQ3zKcvwgk565gZkuOinUe625IkD6Dgc2XCsPv2E9tgRuUPaxT+JOjiscLwzWU95qNNQ2ow0u0ZugSSMWCt14UOuxq21nXRtKQjiCs2eh7fHT9lIZH3xQ91g6wRxpHay2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344853; c=relaxed/simple;
	bh=dOZOfz4GEcL94TAWHHP3lq/FSUgOnvQBVmqjHjw/D7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVn3e7g+jLMUXU29Skqmp0MSVFX2o0HHSB0P3UerHa5iwVQkzYwEKw8p7dhfw3lFF1xnHS65ybbXmkF45Jv46U2Fo5rhVlUu7PXKL7uOWQZNuhmmqRtVmATe0hVOGJ4nQJQVXqUa1sCBFBGn4grZHxtFDIPrShemk/53jj3bdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxSC6EbQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRnSB55V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxSC6EbQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRnSB55V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783344850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IUhPhmdKFY/hvP+RYH3Pc2WHx3JLJjsr6cul6j9Vdw=;
	b=YxSC6EbQRyassKLh4zE3VIKFri+ZHEXE43B1tHD4Gc0/FH14gZOsUmi42cSPBJtyk7z35l
	QXRFcto8ZzOVQ8kpJfUKkAe0m47ZkGIiKBZjxwy/cnkDymS0+sJhMQT4T9lyvFj83kmA9/
	zWBBX7CGhPVTsr9Weo9651PcGP8efeY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-EvBcW1vlNBO4npFjI_9vMA-1; Mon, 06 Jul 2026 09:34:09 -0400
X-MC-Unique: EvBcW1vlNBO4npFjI_9vMA-1
X-Mimecast-MFC-AGG-ID: EvBcW1vlNBO4npFjI_9vMA_1783344848
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473de38dcfaso1741847f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783344848; x=1783949648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IUhPhmdKFY/hvP+RYH3Pc2WHx3JLJjsr6cul6j9Vdw=;
        b=iRnSB55VG35RyGt1WJPF9DrYaAn9a+ZrDlywdWEYetUbvRPf5om0PqyEi76GvwQ1uV
         PFxKQep1jJ0KifQQX8X/AkofU4UxTcwj8bK1TviuV1SId3JVDG7oYUZAjNhmFwBTmQs/
         Xw5N2Dxv/jixEPQUnKO0z8eucI9s3i6Nr1QQLX6uS3jCQq+YMGXnmlGZeMn0IC3Ip8Ib
         0d2NcRjUl1lOPiAdaJuqfe972aomzW9S7x4Qe4fF6BKMzkJhUbkOAIyQKtKfQwcjQ5wM
         64y6cA+I7Hf+C3YTQlo9n2/oXyeTdxEpjGFLTITY+e8BTqSevHK+KIlG20yMseHL+T5L
         QsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344848; x=1783949648;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IUhPhmdKFY/hvP+RYH3Pc2WHx3JLJjsr6cul6j9Vdw=;
        b=gdV1zuEFfthNmcykSUSBACark+OvMs6qVYDQVQzGMkDIZwAsiEmT1GsdrAV7ioDJXs
         cKllXBqfh40Nir4oy/nN9BSgB99EWiDHsp28fjZdj5ymrGaO5rhwJBN4hnyaZV/OwOOu
         az4eeTem4lFYVwU/Cf4245WH32zMvJuSDe0Ch959CX5GOw30/T6gYPbApVOv1hi4+Trq
         VdXpjAEdd4Mctg+tKn3jd0nMvMspsjAozaGWFO1glpqPDkfN3XUkLXZl61cicVJsRy9I
         dnHBX3Eu6/YKklhe3QQflpwWAIfDhavMdb+S9InnbqLPr4fBDCfa35aY7O04psD7w3q4
         j0Qw==
X-Forwarded-Encrypted: i=1; AHgh+RrQMGUiqDQ04BTl4+zhHoGvSF0V8SjGD0/WgX2qIuFrLYhhV5sJnh/qc665x8epIAyUDkjddzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAgm/seQE30UL7TrcX5x1Ah9iqlOVeAC8LzCZB8KEO7C20OaC
	A9hlQdDhzHrg3qYxh3+asnHd1AKHGc9qHQ0qqQaAgfKLjywPpfG+JFL0XikUn4QP85w7KuSXmxm
	FPTPlBp4E9exOKnwFepWTQnt508FF2bC2k/zuYIp7RxxpGOUVS0sVrVSdmQ==
X-Gm-Gg: AfdE7cnxewaAjR7j+/J/y6Yti7CEwwuyCOpmrKO8YFqahn6mkeniY3IHruKPmDVR02F
	3UfiDnW19uzKkIgUUk+KDyAJ0Zj1Q6OXdCRU98LCoGhMbdtEDysuMdFj8taSPPmFQms/ND7YfSr
	X6/5xX+IWioy/FVeq5sFAkZ+WSBDOXG+F8hzRHQ/5uFxp7a+iftz0iOwV7SN5aGhlACFMrBVatz
	r/10KERu1pLffsSlaW982E3rh6Oj2b/Win43vPVEWqpiEnD+fdscf2UaxPxonL2LEPEVxK6C6a2
	QCvQOS1+nlT2lbcY8YKRMs9FrzUkbawd8d8ypaXTY5N4aQQ/mKLqyBOWLPTodeDE2nDqObf2sru
	plyyueR9gFobrScGZRiLOlIKgwP4xHCmPdSw4nSNSs0ZO9FxvcwYOdn1CywGKTIPE8U8BmN4mfF
	CK1YL0KIYkvMO/
X-Received: by 2002:a05:600c:6085:b0:493:bc97:916b with SMTP id 5b1f17b1804b1-493df0929f2mr5699535e9.26.1783344847700;
        Mon, 06 Jul 2026 06:34:07 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:493:bc97:916b with SMTP id 5b1f17b1804b1-493df0929f2mr5698905e9.26.1783344847212;
        Mon, 06 Jul 2026 06:34:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d607sm357583515e9.2.2026.07.06.06.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:34:06 -0700 (PDT)
Message-ID: <b95dda96-ee50-449c-9d23-3de490d3ab1f@redhat.com>
Date: Mon, 6 Jul 2026 15:34:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
To: Conor Dooley <conor@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 maxime.chevallier@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, weishangjuan@eswincomputing.com,
 horms@kernel.org, alex@ghiti.fr, lee@kernel.org, wens@kernel.org,
 lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
 <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>
 <20260706-confess-dagger-e60b5fad57e8@spud>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706-confess-dagger-e60b5fad57e8@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 3:21 PM, Conor Dooley wrote:
> On Mon, Jul 06, 2026 at 03:09:37PM +0200, Paolo Abeni wrote:
>> On 6/30/26 8:34 AM, lizhi2@eswincomputing.com wrote:
>>> From: Zhi Li <lizhi2@eswincomputing.com>
>>>
>>> Enable the on-board Gigabit Ethernet controller on the
>>> HiFive Premier P550 development board.
>>>
>>> This patch is included only to provide the DTS context for reviewing the
>>> binding and driver changes in this series.
>>>
>>> The upstream DTS series will be submitted separately after the binding
>>> and driver changes are finalized.
>>>
>>> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
>>
>> @Rob, Krzysztof, Conor: I see this patch is not listed in the devicetree
>> PW, but I think it needs explicit acks from relevant SMEs. Could you
>> please have a look?
> 
> We do not typical provide tags from dts patches, but that's irrelevant
> for you, because this (and effectively all other dts) patch(es) should
> not go through the net tree to begin with.
> Instead, the platform maintainers should review and/or apply it.
> 
> Additionally, it seems the contributor's commit message suggests
> that they didn't intend this patch to be applied at all?

Thanks for the head-up.

I noticed a bit too late that part of the discussion about this patch
did not land on the netdev ML; a new revision is expected.

/P

