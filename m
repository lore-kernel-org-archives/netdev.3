Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321703;
	b=qQNFS76GXtNGKufTdKc8+fAJ8K0CzQGJW42YHzyX6MBsdNd9rYhLhru367mWDcfnJIQV
	 PH9SbKgiovY4VfrLVhWXfyHuhFtNz+/5jcV/yCw+XrkePOrFVnwoTpqerVtE1b7Z/CO2E
	 DBr8HDXgPEjw6DELJSXuvBKeR2H77ths7syZjcvQDc0TncI6o6pvMARQbc56UbsTFPGwb
	 f1f3liWMvvYVMG2C629b6Lcb21eLMU9XM46+GS7+tINyK97xqG+JcfQOYYqpx/vPw1mA9
	 auhglo88ITCSGauSeBn6vnPdWYZ2QkbYQGM8Dy7ZwShWHftqm60/rxFQjFoSejXnFqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321703;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CGXQ/QplWj/yhXVmhnC9fQJ5qIoJq7hhu3I5GssbV7c=;
	b=sPTe/ySfdpFbQAjzpi4YmhxDOZTvzyosKcj064YCDyKcd7COTaWFbmPBXaOJOnfDgI4/
	 eGJpQ9s7vMzUObu+KgbLsW6sHpNI82fCEvFAoldAZ/Q4z/V/kknVaiwa3x6WDWNeyaMDM
	 IkEwKvue5AIkLPccOXbHUkGkZtP3arn1Lu0PhW00DJfhbET5Ptn/jTI6bzE/zbEBU2kAT
	 O7t5T5LTUAQygtt27k8u+dvbrqZwXPvkM6LM+JiZTh9LIRpDt42pxoYt2hRK9wCxhtzAC
	 LQpDgF3oDj1XD+NsRZysBSA0EVk16sYa0vc87vVJ/2/FQ88UzuXKepwkTHQg5+Y3Unw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nIIKU0FE;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE4606A32A;
	Tue, 10 Nov 2026 14:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EE4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nIIKU0FE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CGXQ/QplWj/yhXVmhnC9fQJ5qIoJq7hhu3I5GssbV7c=; b=nIIKU0FEztGCPWPFumqqUu6HM3
	cvzHkesXd4tJ27xYTNVPqugoSz/YAkYLM3FDCRapAo4KSX6BOocMgzpqUc9ty2dakZw55Wuj3K0Yy
	ZKvJd+TbG8MkiOGxBGAn1ufnifarqmr6r5ICtNbeghhWpyHkOVE+2kJSmhYzmJrTbvOU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQn2U-00FVNS-SR; Tue, 10 Nov 2026 15:41:34 +0100
Date: Tue, 10 Nov 2026 15:41:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
Message-ID: <d6bfe1cc-f925-42c2-8628-1fc5978904ec@lunn.ch>
References: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
 <12b07a59-c087-4ba2-8d5e-40b2a6d6a72a@lunn.ch>
 <CAPTcHHRv959iu-4V6dAWwfH+gRy4nt0M0MGZYL3CCiuD+Gc0jQ@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTcHHRv959iu-4V6dAWwfH+gRy4nt0M0MGZYL3CCiuD+Gc0jQ@mail.gmail.com>

> > It looks like USXGMII and 10G-QXGMII might be mixed up? Is such a mix
> > up not fatal?
> >
> >         Andrew
> Is this comment mis-posted? No USXGMII and 10G-QXGMII related inforamtion
> in this patch, isn't it? Please help to confirm if I have any
> misunsterdaning here?

The provisioning ID is used to determine USXGMII vs 10G-QXGMII. If you
don't have the ID, they get mixed up.

      Andrew
