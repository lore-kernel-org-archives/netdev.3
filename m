Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799534314B5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344231; cv=none; b=uLkg/MPYsrL9DOjlByBi9LtSLBwd1BcnfpM31gHkBap5nm0Esm8x0EHPofVbLCiow39NVDGY9vGyfnBu8HIqRkRCrqYtMwszdoeuFnKAErwl0Dk+SksRYwnl5yLedIb8TJSQWSte83v2l1ZZ9xcUpZ8Z6btr3eMt3dezt5DkF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344231; c=relaxed/simple;
	bh=9icQHWfI9YGkAhOkzEn3IBX9QGsO+7zdPDEg9k3r2E4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KIrGmfymrYZGvI47EeyXot5fGHzmHpBbdEQfAUI/iux/wfkOs5hNa8ZJhUX8ppnDJDY9uBsjxtAH9d18FoOLh3bur2w2U4qtqn4zEDOLLGaHuzo2yTqotDLCkjE8oOKGn161gEV00Av2iB/VAvPNvbfr8RaTgyTM5LP55doX/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUO6lisK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hp+4bHkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUO6lisK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hp+4bHkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783344228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9icQHWfI9YGkAhOkzEn3IBX9QGsO+7zdPDEg9k3r2E4=;
	b=VUO6lisKWlVHaLmTIviZducZCm11Jj29Nib1rMMcDCZeeGBlulfiKDk81JPlK1g4dG6seQ
	1G4pyr8RopYiOXrQ8Sp2eWGIilIHGfG0EXoQTSZWrs7fbd3J0hYsr9Vk/wTagxqbZdLa6v
	6UDcM/Ac8Q6AOWJeKOW9/zGEQvWPe3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-7GehOm8zMSObWFi20A10SQ-1; Mon, 06 Jul 2026 09:23:47 -0400
X-MC-Unique: 7GehOm8zMSObWFi20A10SQ-1
X-Mimecast-MFC-AGG-ID: 7GehOm8zMSObWFi20A10SQ_1783344226
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4729d2a64efso2802204f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783344226; x=1783949026; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9icQHWfI9YGkAhOkzEn3IBX9QGsO+7zdPDEg9k3r2E4=;
        b=Hp+4bHklbyaydVMeHOUw8GPE3aqLBITGvpyNUScbDUpBO8LshBt+iCDtSEO/I3gtZK
         Jyq6JRLbkXZwqnD3jdD9fc6opd2pWdqWEj8/gOL/90EzJ/aAx7hKvAyYtTL6kxor36TU
         Bo+5cduMR1rKwWsHGBLmFjttcwh3mbkOmCE/0XbNmMFnle2eq2JW5Wm9Aar06FJlSB/W
         Y2Asna9eN+0L6Srl8wUv25/iCTtEkdSCNiWUHcUFx9ERHtAfSH4GKp2ct2nao1R4TZfe
         SBtilxVRQ+fMsKjcbbsiy8oJMp44e2hEG0SMTcSh424T4JTW117HSMG1vJfI7EOlIuVF
         JZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344226; x=1783949026;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9icQHWfI9YGkAhOkzEn3IBX9QGsO+7zdPDEg9k3r2E4=;
        b=k853kQNbFQDrKDKLBlyQ/eM/3OB5DX0Er8hSKkOpobjsl06MirzLheO9mwaAKyxlQ+
         jXU+QXyhWrGmfVYwNLSRMOw+EIfZeDSceQwYkoT5S74N1bQnMopryFBRY0brXau4yf9f
         IdlEZooPVNaWHduj+XiT33cdaRedkF27M0ReLNq7ONl3gnKezG1Yi9osZptd+8+Wj+SR
         K4McttKGE4Gc7PZBUAbdy8y79js1D3KSoA5Nlf1tJC4ViocrH/cMWkNDC2SOZnL1TpVQ
         Dm6upmYQs5CwtdFgtTAl1I6BEFbHNo7FVksHhjBvZ2rsRxPsqjpym6Gq+Y6jQ/n49iZ1
         jM1w==
X-Gm-Message-State: AOJu0YzVSDOjePQuDEpCkyuQy7ToNTXuywUTM9x6JKemkVRgFIfUcrJl
	wfcibpjoUqSoKtCcqSc12GrFHAkDfO/6NDQrXxQfeUn6x2zpw0n3M+HXdjwthe+EP+LC4mqFHt1
	Gp/vbkR83Fw91/gcFWAP0R508MuCkeMcCzgq7fvJ4Ii/qntSY8P2ufkmm5EHZeROun9gH8DqUsB
	mcO4XxGtz5kvLqYkgo4RBt2YGbghpxUShO4UA5Vro=
X-Gm-Gg: AfdE7clPfIEwpbCFAvY4OlQzDW/3+z5bFoijPEy0Za32KTh4a68x+TTkr/8mevt4IlA
	L9FAibRKdrNQsPsj0XsnZkn+DiOGsMZumCaVWb4m8ORHgInp/is1l89Di0tKBELgDQ2uKYOuHKM
	PPrDh8VBQ9nyC3nSnZXV51nRLb/XOS4obJiLcbikKKeVd19n6VZuKL7fuPyu6/g2M5y/L17K80b
	0SQ4YLVE3YLF8VU8UV22j8tIz+Un8iQOzgwvsWX44fUNA4iRa/5FRHsTafQy6g8K1VpkNZI1dC/
	1pZmrJWd3cGoNo+o/eEXyk0VVkTiVY/rOa01MbFgS2f2xrcHpvdwPf/7XNW/bTgra35HEzm3JvO
	Muau9bBBo0vkaIA3PmJlVQpJPhqXNgFjivBfeQPYAzbDxUCccqdcoIFEWaY5XnRxs236XvcLJL2
	50bujMVlgsvA33
X-Received: by 2002:a05:600c:4584:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493decb3dc8mr9425155e9.2.1783344225806;
        Mon, 06 Jul 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4584:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493decb3dc8mr9424685e9.2.1783344225172;
        Mon, 06 Jul 2026 06:23:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm25503590f8f.21.2026.07.06.06.23.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:23:44 -0700 (PDT)
Message-ID: <c0cd72bd-6298-47a4-82a3-c43811c98063@redhat.com>
Date: Mon, 6 Jul 2026 15:23:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] patch processing delays expected
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

hi,

As you have likely already noticed, maintainers capacity is currently
limited due to holidays and conferences and you will experience
measurable delays in patch processing compared to netdev standards.

This contingency is expected to last for the current week and the
following one. Please be conscious to try to avoid unneeded ML traffic
that will slow patch processing even more.

Thanks,

Paolo

