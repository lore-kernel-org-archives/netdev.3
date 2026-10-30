Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793383547;
	b=iYFzl/cDErIyUAzbSLLBcdI84+8RITkMJAhg7nDnYEXUjgWwHirPkvc0V6JY26zO0j6H
	 p6ijvvxVIjwdAH1osH+HH7KQSQEfggIuV5PX/HWpnFp5WAKT0Sdtyctp4HudsLHRyAcAU
	 4vyaAQmN3MpsHdBgIgdGan5wWLHFPGDgAsVkEnt98wVNhQnm1CHGMWjs8hE04x3pOEsMU
	 OLGPJ9BIAB0tUxFHN7GMYIngz7KeJY9h4tJnMu5e68H7Y1mF3RUypvG4yQfSPIyHlaILP
	 4q7LIwMYe08iexphKIdEWfkmleMh77INW7FJYRnxUHCoL+SIf8RKNJq8M9G2ZukssIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6nFFsAgTb2JrA6ZMIp0GSgZNxXMgbryc9P3LqO1yWB8=;
	b=oXm7zOqIybTDIhtwI23h+CHQN4DDYYxr5HVnH7QazHKhf5XlYsTYAZMLzuTmUkDTgUGg
	 cfZDCWeT4la/tIDb4TpEioc8N/DySy/L1E4Tvp0LZ4AScZ/EuYhL0KLlpSYBobJ4OAjsF
	 zhIDgMFtXDAAOvKE+tYmHyqEMpoxRVfMh/tFarrUBtms0fW0zBmPefinNCXG3lTQKLXo1
	 p/xehtfIBUOTtYMMuEK0JqBc2DE1W2qawgJ9cczq3ivgdAxzBZHzEx74whu8gHiHD8Cgl
	 x629uyQahY/mS5XIPFqlLMJTSXsi8nPfE8sSUtkrbBNJVR3/oowXiD2KFrdq8S5dKtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdkWd5e2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFBA606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFBA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdkWd5e2
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5946c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793383546; cv=none;
        d=google.com; s=arc-20260327;
        b=VCrZ6yKC9pycPwbxaIlE6bz7Ju6QssCzbWUud2Gwx1mpILdfU6lfam6IvEGTDLUZzW
         v4HywbIPXiXEggVDH1UYKyItD7NA7IxDt+aBDZkWUnnC1E8TQ777xDOrycaeKIzXAt/f
         gqU2yjmYD1ygVOT5j2ZCdBjsJ51jMuhhTskt0DApMvGnGzYzws7GKzZ/+8pHBqPI3QQp
         vSMDYfvGU3B9U7ONGWAMdsG4M1sW9oPAm52D87rDeXTKER/0waG+U8XtAhg0A8MK0OIg
         u16inQalwutB6vjD71YP6ixWh99tTFer10J3cW1SzL8Rrx2hPHYyx7zJykxOFFwBrutK
         lXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6nFFsAgTb2JrA6ZMIp0GSgZNxXMgbryc9P3LqO1yWB8=;
        fh=2k/0fsGEVi5QbcYxSk4jWGeW8rV9S2xYyBg8zQjoHFQ=;
        b=HOSTDnIvStBFrK9cvptOKtUK0kyOK5k1HsYluPedVsu/1XxdxiCF7YWMfkzupRs5UY
         gqkBQct0SV2JnNEk/xMKxukywTBkdXqfLqH2dL2ZFZR7JCG4bGd7abOJoJ09GQGqzsCx
         zye909mJfpctChj/6uF+oCG2+4opoNzQZWsl0SnglXNYLVTvz235iG8ekg8Fbl9Ye2v3
         MLrBnZgXCYzWOPww6oWq1hz9ofr8avAaCDgbG/fYSGgrVhV4DNfX6EMlSEqornK8v/lS
         2YmO+QJeQcU43GeXgLO76gmExV/9f52xu14eniUrJtxmYO9hMdYjtWiWzqh2/oHNjD2a
         1xew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383546; x=1793988346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nFFsAgTb2JrA6ZMIp0GSgZNxXMgbryc9P3LqO1yWB8=;
        b=WdkWd5e21k4WbvCxibQM8BdPrKKyHBCPM7scAPNXDbOUjzUDC4N7icSNDiB60gZlYj
         nO4n4UTUZOsxm8/PmbZvcvpU2iI7GnBP87xkBeyB7yW9UdDbHnAvaJWtONWDP/Bo5y1H
         y8Nc4QvmkLENOvyJ2uRlfm5vybB22Mw1eoSx2GhPAU1ShUFFD1ENMfjaoPk0IzlpT1Gk
         BsI5P2c9SeYcpFd2cdI2AkJA6dQRGcMKRjjA95h7Dk2/VRs02NwzNfxNi3Yrya++OQ3U
         UY3txWeCam2WGmCPBUpElJRyLCMQnEI86kpTg2v3q03cMYnsoOob/4CJvlaCr8LFw7PK
         xWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383546; x=1793988346;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6nFFsAgTb2JrA6ZMIp0GSgZNxXMgbryc9P3LqO1yWB8=;
        b=taqEqryTAirQrNUHUHpYEKgTifj89StRpi/eTsCHCAVGLOOi0NriFJPLEbPJa4TYh+
         Kkile1jg8XeucaoGrn22pAFmsA1NmJhnJEW12wxY6YUINNzEJictw73/f/jHeQo8V2ih
         EICvPNqMHE6WRqRzTw7cwAQe9V37UHl7AcbNbrlXJxM7EQtl2U5b8/W0nDyx9wToMX6S
         wc4CeUUIgtDUjaSjyINVO7RiM8Nt4M96v329yQGqsOhb96zWr2AyCaONfjJogVjTW8/e
         Vxq5mLbaTdDvzXMNK/eY2JA8zqUKCiMCSAqGcBNV3FyOLuPdo/3iG7gOjQSxtfITFPf+
         itiQ==
X-Gm-Message-State: AFq9FYI5lUkSAPihAA9vRnzhhAOby9IgEjAdnLv3Tb8+CmKwiv3hnl8g
	NIfMA6Y9M3sxhfiBkIfKZRWkWBeJ2wTAMXY34ntB4pEp1LUw1Q1TLcHRA4d1otEZDpisQtOYqUf
	OZHEvJ6RB8PBP4vmaz1sik0X0KinvY6k=
X-Gm-Gg: AYBFou1uykN7FqB3lti6De80pY5f078cYT7wT2oSAAFWyfR/wd4f3rtVNoYHbJCElB+
	FttJvFoSh1mbLORRlwuDJml4ZnbP2uT/bBEeQIMolnUtowtsJCksP9i2amSGcb7ij5RzlHhr0lV
	Mjl8gam0tn9I9YBTGqKVe8M6/kC7O7Gx1nJN6nY/v2wCDlMAnwb95qydk5MMfDuB5j8/A0u6IcR
	y/lFapjdD3qcKADba95Wzw2scVRNnrGwPRRw2w2n3hTvPUj4Kx3Ra8LLSDGA6pQ/J0K/rXtXWYY
	0gsPRH3/ro5ZPHfbMmd7fUuMSf2Xg3SjVCII7Ln20QMu2WD3zcbXtZfsIDzwOvAd2bGcsFdNXU2
	kTYlGnu2y+3Jv5K3j9gky/I6hroAt6ytVjjHIYDat8aqCNh+MHJ96l+if0A==
X-Received: by 2002:a05:7022:3c04:b0:1a9:c52f:655c with SMTP id
 a92af1059eb24-1ac5c555f7cmr3718375c88.36.1793383546411; Fri, 30 Oct 2026
 11:05:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com> <179335745203.3134.6448413016247418659@kernel.org>
In-Reply-To: <179335745203.3134.6448413016247418659@kernel.org>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Fri, 30 Oct 2026 20:05:35 +0200
X-Gm-Features: AclHuK_oPUhcpJrKbW1D8_iO1QvO2I3T2TBooqrdX-PjaBCacASo09NEvMHhvII
Message-ID: <CAF+_u5Cyzga3ic76Eiyb9eFZDyjdJGix9GQjwr9jYRJ6W+fiZw@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, hangbin.liu@linux.dev, razor@blackwall.org, 
	fmancera@suse.de, jv@jvosburgh.net, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 12:50, <netdev-bot+sashiko@kernel.org> wrote:

> Does slave->link == BOND_LINK_FAIL always mean the slave is still in use?

No, but both routes described here start with the 802.3ad notifier
setting FAIL on a slave that is DOWN or BACK, because it checks
last_link_up rather than the current link state. I'll change the
notifier to set FAIL only for a slave that is currently UP, so FAIL
again means the slave was in use, and send it as patch 1 of v3.

> Can an in-use slave reach this fallback with slave->link == BOND_LINK_UP?

Yes, this is also pre-existing, but it is the same problem this patch
is fixing: a slave that may be in use being set to DOWN silently. I
will add that to v3 also, and in v3 the full down path will be taken
for a slave that is FAIL or UP if speed/duplex check fails, and only
DOWN/BACK will be reverted silently. Checking curr_active_slave alone
would miss non-active slaves in alb mode. In a normal miimon flow UP
is never proposed for a slave that is already UP, so this only affects
the racy cases.

pw-bot: cr
