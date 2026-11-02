Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634460;
	b=ZvTrKSVfHfX46uCN5e4HEWFsKKCBzsydK7VJ9WBj8ljrN4eHhbNexLVeQsl0Rzku07sc
	 WEDRWpRJlQCVKDgCLAARSpnmUpkoq4M4apcvDCKakBugSOdxsVJ4FAR26h6OC0YFXEyDN
	 E+0mOOA/XVqH76THuTCn9p9y9YkKiiCUWBAm2PmKpH9eQFr2qK4eormGO4TMHDSyK5fE9
	 EMrkP4htKEE+cG/vYxO5owA3pyNtWrcP/LxmF6PptiZE4ZFa7mxVz2dHZbXUnSePuHohy
	 Rw6LoAzdF+yciEzI6OtPuIxd3ur3RvhTqJJoUlTrpSZYFVFjOzMcFkM6Zw16IvLKDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634460;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6oNFMWCWOpStfYAnMdrje9lXGqu4L1IBJ8dC+bnvLWI=;
	b=XRNqu2ZxxnVtsbqrL0S8dOUEehWQEEXvtnIFExzlLPM7cS7Nk1GEDfkZTpchs3PTobzx
	 50U/XI9lEl4EvQw+B/O1brL1j2GwXbOSIyTSeIO5acuzH95RZRLycYyqzwqqw8plPG3US
	 bgymMtY8iNteu9My6QGC4+x63+RymHX/UiFuOTHQynDu9anrZuTqrInPDWJl01RTFPHgO
	 e3q5UyIECrNOWQlcKNmVIaCWWgZ9GFFGrhUHB9GTdnVarLZJQq8gbElPj6N5fw8RvF71c
	 lrMqKtK2h7gEyzhAiajnsVTXfmKT6H0V8Fte2qHXHxQ7Izc5l2dkYoJgds1hSS11+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iw8RDlD8;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MObWBwTp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88E6074679
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F88E6074679
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iw8RDlD8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MObWBwTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793634458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNFMWCWOpStfYAnMdrje9lXGqu4L1IBJ8dC+bnvLWI=;
	b=Iw8RDlD89ocGpI+AWDRUUv1nfPxnS2+ljNRRYL36vdQDsTtB1v7bmuPGsCvW/7KD2z+TMl
	98bxLST/osBVknshIZY/Rldx4Z68ZJuL2KBBlsIFlmRc6Edco0QnMCb7HP85G6/WkT6An0
	gOODbuMYBN2TfXiJ/9IzvXDt+GCKsXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-3HSc9UXBPZCA47mq5GVy5A-1; Mon, 02 Nov 2026 10:47:36 -0500
X-MC-Unique: 3HSc9UXBPZCA47mq5GVy5A-1
X-Mimecast-MFC-AGG-ID: 3HSc9UXBPZCA47mq5GVy5A_1793634456
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c430f0f01so2808173f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793634455; x=1794239255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oNFMWCWOpStfYAnMdrje9lXGqu4L1IBJ8dC+bnvLWI=;
        b=MObWBwTp7Ynx9mSoZY34Ox3eRHXp0E0x31JMykZiBE48CSh7yK5JH6PQZTI9jcVcGL
         eEqvsf7RCagBPs9zpoNDOd22ITM+rvCxhncV0bZfPCsMRAXTSzknjZKifZkS2LjwBngA
         UisfB2TMA/YECFubsCCtT0f2LpPmp3GbXdKvqu7+ZXOINkhfmFCvOmr81/edJAZSMJXd
         SjvgZumnlts7GKATp5qog+auts1Ap9sOhi6v1DhDqtOr8Q4xTBErYC/Yg2FzRtd/PBfq
         L0SykiO4BMPZtHb2edr62lux0jpyOFzxuPlHYJW9KsnhPqbiVF2ZwOXS5ACtwfWgxIYC
         6LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634455; x=1794239255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oNFMWCWOpStfYAnMdrje9lXGqu4L1IBJ8dC+bnvLWI=;
        b=LSaBk4BaSky20O+9gGFUgJrHhQrJe4BQ3d3Tsu1v/VHBttRwPrKv/t3PitPh1qW24R
         Jo7FE6D3wvQ6SmpHn+tCOhgV3bpkbUrhUy6MfXPJ9T5w9FbODB7MPF/r+OG61JpCSEjb
         jLx61LTMVZ84ZOmT9tURaPjobGtc+VYREepmLXgR0ZL542DnyeTJZKMFYMGKKiycyBX9
         k+p8rpncY0aCj+6PWaztbCGlKSJ8gFGIoIYfn5NBlsB/0vh45BNqykvFCxTW6KU/6iFW
         Lz47DBub5LLpx+dIjMRZGtVAKDkIenEraraQBA50p7P4FAayo+zw6Y8gweoMJ/gd4IwN
         JVEA==
X-Forwarded-Encrypted: i=1; AKwUvBwKnzTFxawKfCKzUNXymZJMx3Cey+vkaiXoNjuXu9/xEKPnQ6TIDTm8imsy5JhUM45c+ilxU6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GTGCEIuIWDgoUrGiq3crLMFdM/V24/RVXcIznhVY7+gBmqYb/
	mcItnuH7gA1GRI7uqHbsCnzaCXuaUhh23AnrbZEC7S/zNtCLaMZ1kLSOw89didYYasi1dz8T3Zb
	oEfXWHN5KDYJ0RFc5B1cL+1pTEJWndeHBQ/bu6FUmuS9vAPJ7IZuBLlgcE2ztLK7qnA==
X-Gm-Gg: AYBFou3kFjQ43bg2n2yBgTMoNCPqLCZae7Qg3PyP/eo7ceHCq8FEq2hDJ/8/qYp+CFS
	btiuXgIDR8xikr/HsEbwXWNsXttJw1isYav9nyGBBIPt3qrGzORXm4P6Us2tqawbs98DVO/+h6x
	RMaGbr378NsUHy4oaezqgRepj5clMDM5TwnN6o6ha2Fc68tXLXTK3Vkea1apGI5qA8nTfgQipJF
	CIxukk0PDw9VU3P1sQ/LTyptJVt2o+etoyQ6Otbsi3iYGCcwc26bMTI/xma9tupEKxQXO/D1wIw
	b1k2vGcHYCGB+4dAQZFZbFeD1R2idW9JOJ3NqKqXW8ok13IH5IX763CcvpYOQ4Z80qlr2tSXIBk
	Hf7YDF8bTuH8t2Rzn+YCGWKaS7n0abP4845EXTqV+bSZfStX4cUXdcj6/+Pggdst6ScZDTeffOa
	2r1anlwZOwUSj4d3iewMqSl8qsikQMKxyOXljjSRzHgbs=
X-Received: by 2002:a05:6000:4559:b0:48d:ff71:dd97 with SMTP id ffacd0b85a97d-48e6e2bdd94mr16293259f8f.7.1793634455639;
        Mon, 02 Nov 2026 07:47:35 -0800 (PST)
X-Received: by 2002:a05:6000:4559:b0:48d:ff71:dd97 with SMTP id ffacd0b85a97d-48e6e2bdd94mr16293220f8f.7.1793634455206;
        Mon, 02 Nov 2026 07:47:35 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm20493214f8f.23.2026.11.02.07.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:47:34 -0800 (PST)
Message-ID: <15433a8b-5e5d-44dd-a12f-f2074857c1ad@redhat.com>
Date: Mon, 2 Nov 2026 16:47:33 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: clear the conduit RX queue on receive
To: John Macias <dencity7@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <CA+KzPspNN14ZEyxisGrOSpgfTqajJfZTXG_iHBRMYd2su1dRKQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CA+KzPspNN14ZEyxisGrOSpgfTqajJfZTXG_iHBRMYd2su1dRKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 03:51, John Macias wrote:
> diff --git a/net/dsa/tag.c b/net/dsa/tag.c
> index 6a5aa7fc3..e53dc3f3c 100644
> --- a/net/dsa/tag.c
> +++ b/net/dsa/tag.c
> @@ -95,6 +95,13 @@ static int dsa_switch_rcv(struct sk_buff *skb,
> struct net_device *dev,

The diff is damaged. Please fix your setup and re-submit.

/P

