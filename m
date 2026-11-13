Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608567;
	b=iAd8pRd0TamlwxuBPUwBNoviaNAXAzA5Q9Rbcum7bDilM1ovcQcYnnIqQ7aU/9eIGYRO
	 XhrdreEx6rkU2I6VscOEN9Grs88xS6F16N8p4URAj4cGytBispzNmJRr8h2QGj+y5ODKw
	 bASbcKQvPMm6EBqA7zEDXmi8hBioNanLa+Az3cxyDumk7Zb9QdNCDbJBqwcHBfQtXhPbQ
	 gDMnG1r3HKbjxtzBsJc3mjIXkrtyzsN1pEK1BdPP1O4BUAuIhqFbSK46vr4BOM+Tu0Giz
	 91mRSBof98cj4Tdj8Z9nppSr7ZxYgciJxHmsNWhdyngGqzgMnYeWET5GiG+DnTbZc9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
	b=BAtdl7JGY/9UXuQ2rAoyIOSZvIVMpDqCyZdKqQ9fVIrpnkPYeQaqhbMzyeu9l4k97quQ
	 Hlkrz78dX5We/w7q3l6KehQyr9bbg2aquuxOa/eeGTQjTYj7TxzrZBq4m9QWC4yAHE6VE
	 myuf/Bi1pUUeX3Hj1Jz5Lk7OKs5hOIxkx5MuAn6odH24qbMD+Y/5XtLQT80i7LENU7Cs7
	 TVA1cWKpugowQ6zwrCRK9E+CSO/bsfbCHIOejXla41QL2PUpuKK7sbg+GUjj/3Jv+qQV+
	 BLZCHUzj/L++D7VzvUXNzjPFv6Na5JwFsVmXPLfvtHudJyBSvqhAhflIbUwcBjehp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kt0eGjZ6;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C3606A88C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3C3606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kt0eGjZ6
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso716663eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608566; x=1795213366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
        b=kt0eGjZ6lI9yQVuQ0WalkgZYGqnAu6quAkbn/YNnSaNNY4bDxmg7vWu5L/iCEKeRq1
         BcHDv16Nly2AE2lgZ1szXyCbpA//4r+TIy7pmoIrIaWlaAuhxishgr/nf6iJy+MF8JHL
         MnFiQ8swqhS0T9o7CW2+KpZh79x4DzoeNMIG6AbPH6bu90SMA4+yEXC9cAzM6enI8Y0J
         2N0H9Y4xL4Kj41pYFL5pMsv1U33XLXGZlmtM3S4WLqvVUbDJ+yObSu0oCraJ4gIg+Qrv
         xYsUdpVKLCo1UNmumy85tcug4O2Qi4xN+kSO2xy4WFG7/h6Nu2vesGAp6pwgnTMh6ALv
         Nypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608566; x=1795213366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
        b=OzecL67WNDQJjqTwPn2wLj9uVDXVaSM92EUXTKP2UEUmqAYd44RNIxVyzHg36HoKql
         DWRHdx5TIV3t5rD0BAj8JhaJUhwk7Z1Y5rUzitPXpAfVu9vVtabPxOTUvncA5jJmYhxU
         kDSMO32a41N5Y7w7qhfMWpDnBarr2LcgXYYpmtT3zxG+W6zqThsSjrDfVlKapc2J7Hi7
         7Rfv/vhkec9lMXZ6bFfuH8VkWq8UDN7eL5QAAfDI8gphfwnqUSDV+9fj5JBg3riotCuu
         mEsi2tAByE8dmkVQASw0iwAyFRjeFbCyYDl/7r0hQ7z7Hs5T8aWYIPg5WFoDBxJiO8hn
         XHfg==
X-Forwarded-Encrypted: i=1; AL+hErHIYPezb2TOAdtChwRd51qA/9ZgTU026B0eE9zJ8z6EC+W/coFjAROFCgEB+tMfgPJxgUONn2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mavzcc2Bf7Cy+d9aEQ8kaakb65nkOR1Aw9mQVaQM1tOwJFuS2
	xpI1cBnPeA8cXFwRsjpcilykG3qSdYR9eEy0IR838F465MY+dJmQqQI5Za0EiS26Pk4=
X-Gm-Gg: AYBFou1evkyqUBWqB1VG+San6qkk8MUsmVvP2azofnpMuyi5MVrM/JPM/v5yPNvNxhh
	dn+3T/EL554Km8G8QJrkFOA/0ik1vUzXpImuXb0XSg33naa2HCqLgeHejEoX4Z4xBlNSsLkgP3w
	MGCt4796dPRKc2i0eAUILocnCSD6U2AsqAybiHLSUGYDA2fpeh5sJIiNPqvfNbwt8bjJT4DlMLX
	YnOV/bXRxgE2erpKSXb+bMJFG/nAUbuvEt8hnniuNDIKPNR2tXzbNUwxowzhxAHRxSUr21Z2Tsi
	vp4qEPPZHV9NJiVuidHY+yihBYLrCZhUVnz4FzD9t9vxvvicxCFQLaDTDTCx8IaqVBB+pEY4T8N
	GsHltDOPWRv1d74zpp+mdFudztX5U0BIvkevvOXR6d2esojbWWd3iFuWEDiwA9WX350qrVdjhBo
	QXwZs6KLJlyOZYWo0KlF0jr3+Uu0VQE/O79Xt9GqB6113wZZKycjM+G0RwlHziamshotXXi2nKp
	+QTBWx2qVnGObEX0PRDHZyARvS4mGZNMt5kbUSfeCjlcAtJoFJOmTbUsE6pLo19NIXNFAEsh+or
	tHdVffkS3JaAfyoB85deYRs=
X-Received: by 2002:a05:7300:cf8c:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3796628f4c8mr3171439eec.16.1794608565735;
        Fri, 13 Nov 2026 14:22:45 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10160338eec.3.2026.11.13.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:22:45 -0800 (PST)
Date: Fri, 13 Nov 2026 14:22:41 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: make xdp config checks effective vs
 netif_xdp_propagate()
Message-ID: <aveNqpUudFjo0jA9@devvm16445.scu0.facebook.com>
References: <20261112235027.4072149-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>

On 11/12, Jakub Kicinski wrote:
> Bonding (and netvsc) try to auto-propagate XDP programs down
> to their lower devices. These programs were installed directly
> with .ndo_bpf and not recorded in struct net_device of the lowers.
> This makes all the config checks for features incompatible with XDP
> ineffective - HDS, memory providers etc. use dev_xdp_prog_count()
> and do not call down to the driver to ask it whether it has XDP
> installed.
> 
> Record the state appropriately. dev_xdp_prog_count() will now
> "see" the propagated programs.
> 
> The issue was discovered when reworking HW-GRO and XDP interactions.
> I was trying to make sure HW-GRO is reliably disabled with XDP,
> and discovered we have a way to bypass all checks with bonding.
> Not treating this as a fix since it's admin-only self-inflicted
> damage that nobody is reporting being bothered by in real life.
> 
> Jakub Kicinski (5):
>   net: don't safety-check device features for XDP uninstall
>   net: move dev_xdp_set_link() and dev_xdp_set_prog() up
>   net: record XDP programs propagated to lower devices
>   selftests/bpf: check XDP attach on a nested bond slave
>   selftests/bpf: check replacing and detaching XDP on a bond through a
>     link

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
