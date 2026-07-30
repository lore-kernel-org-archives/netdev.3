Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEA2D8796
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399564; cv=none; b=f9/o/RGw5Aot+gGzLrShlw+CY7+/i/QnBaYKbhI8sMVyg3o1ffl+PtT/BkFLI3cOiuXOT9+ioCX9fi6j4HKX129O2bgGHTouLIvt91PXSCkXBDzvDZ8Pw1obVN+XOZxYLwi9JAnzlpBoIjs1QcvMSgtdW0T0dSo+6E5mrY5WhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399564; c=relaxed/simple;
	bh=IqixvmD1av5MjlW0n7e3KrrvReTfMASV5Vqo/m3BslE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBhTsLUg6/zvMHllBKBhT95iuPw/vdX4Hj4DPC6fqUlWh/qs6MDvKeN4lXv3wj5PNwJJis7rrrJVDBlxMI8RMS+DU0pCvPMLPE5JEJp5U2b9PUZ079M/LMiM51v5KLV933o5GEVIzk+VlL5vTU74FZ0GzbE1cheAYGarFJ/t5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgJYeeZA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvP4NY+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgJYeeZA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvP4NY+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785399558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fA83bFeg+9x2Wfa1HoGosZSSyu8kJd3KsVJaNtX2O+M=;
	b=QgJYeeZAxiN2JDsynJIZuyoKI6MzwAiFsJ/eJ93ftReKlGjas5zlcihqsI5NB4vXphuSl5
	e6T/qUhG+1p+8R8iGu0J9E1APPnGg0rS29JclM6yH6d9zR3DgZJWp0XcCTEgRmyS72yycU
	Ojj1Mm5CNttnuEL2nfnlWvVi4WStA80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zj26j5FaMZ6ZpTDQaR2mhw-1; Thu, 30 Jul 2026 04:19:16 -0400
X-MC-Unique: zj26j5FaMZ6ZpTDQaR2mhw-1
X-Mimecast-MFC-AGG-ID: zj26j5FaMZ6ZpTDQaR2mhw_1785399555
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4729d2a64efso313606f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785399555; x=1786004355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fA83bFeg+9x2Wfa1HoGosZSSyu8kJd3KsVJaNtX2O+M=;
        b=TvP4NY+WOwYiSqVbSvbCUoYCREM+nFToXWCnHXAFA+vJQJhaF7QY/stoZUnZH/dFT4
         lO6gQC5ivehiESVCatci5se+avSaCCEIqqFbC8ikmM6ez45CoRhreV+Wl1iAHFVIIY/C
         Q5cGyIUKqLFay2UWX/TVlYneYr4VLImXMaEjJULHCd5hV3ncKX+ytt/fD9fxF6LfhEYn
         5Ey4CppOy+mlXThQBDYFDNXNJYS6B6jVUmcQUllsYiwXU22yLOqQG9uUtxqhpGWkHspJ
         sLR2Jn8CH3+RO92RY4fxsTeiCwc+6oWx+g3pGhNUEzQcn8tpHsf1swbxZtSRbBYUpTXt
         GmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399555; x=1786004355;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fA83bFeg+9x2Wfa1HoGosZSSyu8kJd3KsVJaNtX2O+M=;
        b=SUhCf7jVSZymlZC6ttPqVGYWH7aJyqwvBjJM4Vc6O4KBE/zfd8b4bvWImyhofYIXFK
         /dyumRBgX+2dEVbBGOb3Q5JcBooLDD8OQUK0n7NgB2ektwP99Q7RJwvHQIKFRXlOUlTA
         XmXtmExJTaOqXlhisWEbt1TLtQS1QO+mc1NE9HbvnLuu1+0rmfjrRBLKT0Er4yViIn6O
         65/fpRVGUzPhJYGy5TkB5WB7IinjOMidgSxp9cWBGE9G4en79rYd0uQ4rotufN4KqpcY
         C70Kw2GV5G0IExdSca0hcBo9k0hUMiyh28YnSTUQR1Nt80ehdRr9NgnQZbdVC7CbuW8y
         uwkw==
X-Forwarded-Encrypted: i=1; AHgh+RpZDr6jLVfCHH0vrO2So59iYure17MmctA4yabsMeGr6Vo4Jb4R/ZD3LG4LRJh1jHnI0gnnJiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpP+M8vEBZ8ruuhkW2b4Ih2nmTZApA+X3euyWb0boGzsMvhSFW
	8C9IEUG5oSfDAamyjFoitt7sYTVE4PFNZRhqZvT88RK5brXbUbailx9zMr2Z75S/PW6wx/HBWqT
	Pv75fcPK7KhjP0TidB46heV6aaOJ8P8QobV4UQAJTW+fCOQBq6ty2SyDLTw==
X-Gm-Gg: AR+sD12Ya1DT5wnp5MAiN8K+Kbk/HwP2OHz4weTmGRTkEUFuvsSAes0dXbLxxkjYHzM
	r3amuo4pC2LpfMWIqHJCb9q52q4hsKJ/0aBsDq0C+fP2GRiMGRMlsZ3799iGEssQoDL4KwvtEv5
	hngesZvyHOJrUM+18RFO3r2QQybgTKvEkS44Pn5DMVrCDMsh/P/h/fyF08BerhgNyG+D3tFBuT2
	g+TQtcIxliBMWGx/Hm5iAzpzdWO174l2aLbzQBiAIQ1He/g0OdCdT/XUCuYJWxQS5waLXUkBEo4
	1uDAweJs3e8mPldKwVMSQ3dyHdOlembkH9dCptzOOhLWoHlLo8vSaGyiPGl8EBgV/jqPMUuT5X1
	yOJJaTzG8kFBYDFe3+VL3us84Sa4pUpCGXcPOsT261nfhnT8aVjNBf7rCDRWkrSINULrPG4gDN9
	EulQ==
X-Received: by 2002:a05:600c:6d93:b0:495:636b:e50b with SMTP id 5b1f17b1804b1-49801ee0ac3mr11523815e9.6.1785399555495;
        Thu, 30 Jul 2026 01:19:15 -0700 (PDT)
X-Received: by 2002:a05:600c:6d93:b0:495:636b:e50b with SMTP id 5b1f17b1804b1-49801ee0ac3mr11523485e9.6.1785399555029;
        Thu, 30 Jul 2026 01:19:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6076765f8f.14.2026.07.30.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:19:14 -0700 (PDT)
Message-ID: <89b0aff1-d639-4366-9ff2-86260130d532@redhat.com>
Date: Thu, 30 Jul 2026 10:19:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v5 1/2] net: lan743x: add RMII strap
 status detection for PCI11x1x
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
References: <20260723050827.694832-1-Thangaraj.S@microchip.com>
 <20260723050827.694832-2-Thangaraj.S@microchip.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723050827.694832-2-Thangaraj.S@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 7:08 AM, Thangaraj Samynathan wrote:
> From: Thangaraj Samynathan <thangaraj.s@microchip.com>
> 
> Extend pci11x1x_strap_get_status() to read the RMII strap bits from
> the STRAP_READ register. The is_rmii_en flag is initialized to
> false and updated based on the hardware strap only if SGMII is not
> already enabled. This ensures correct interface identification during
> adapter initialization.
> 
> Update the netif_dbg() to report the selected interface as SGMII,
> RMII, or RGMII.
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
Noting that this series splitting confused Sashiko quite a bit, but the
reported "issues" is actually addresses by the next patch.

Also noting you should have discussed this point proactively, see
net-next commit c82ff94592fb.

/P

