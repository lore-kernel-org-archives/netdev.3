Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA75964F0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888938; cv=none; b=oTE2oCrNxohBwohxfXhV8J2h5MD6uPd5wsfq1/448IP05YGisCtGKSx7lBvd8HNQXBlKXgfr/wax23c3adHRiahf8BBbMWb3amvqu0UMRpFHQt3+riMFTLe6NNc/xptGmyNLsezt0EmHvIs7GaQCkWkUnD2gtr4jhfSiDyMKSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888938; c=relaxed/simple;
	bh=buZqYnZ9Xem+wOGGXptbZZKHnuc7ZXd7itw3xuM3H/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/nepaFXfcveI1qR2rDm4qfdr5KlvHbb9MI5Gotg0gvQfVtgcxJxF02bce/vUQPGwnqmNqpiJVNlwS4iB+HKP/Po2+LD6sOrob5Xe+AYD0fhQdx3htfTih8MKldTbx34y+aBB0AtB/ZSwfiQszd0CVd5vBs5oIxdn+TL7nTlBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdF7OfKI; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdF7OfKI"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so2884071a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888935; x=1789493735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opthFveDYW+m659FHpQi60qmOkBvetR7zDkcxQfvwQY=;
        b=JdF7OfKIZ+D81fJ7USeVhsyyNKeXgEfBXbVs5vLv+FdosBISU97ncBbVgh3EAUS0Dt
         IRq0/NEgmOrqRQ0LebhJDggxr8mnoK3CAP7dvx5ouZoxhSg6n04ei7GPbgu/sx0XWsKb
         Ig9vOT+f7HrfXAb/lT3JGqir8piruK/jErpjHh6og/9mWHG19lmnJPEf6uMABWiHaVUX
         gP16W0fC0jo81t1HxThYbALn0AK5k7fQxWo3/zeRTubTqrB6E8yDVVrwO2ehjjXfaMm8
         gXCu+CqN89VM/IzckncX3u8Sh/CTCMasvRqQKEedtzoEOL9C7l9bF3UTHY+xsXvX0o3e
         Dpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888935; x=1789493735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opthFveDYW+m659FHpQi60qmOkBvetR7zDkcxQfvwQY=;
        b=Wdbl86uCM67oOW+argd9o4MJUWxawZaO+auB5TpvBemzePapqEX+iJvzlifXLS6YPK
         3C2/iCF7bk3oJEW/6ftNFV+sh6DF1nes/7CuLD+Yfg6em1qdLXJ9vSSv2fTxSVASyFAI
         3J78U9ouyw2ivqsW0TkazJSpyWMTvzBzjS3W8Y/DbQHo+eKqWgNZBBqo3VICX3sCYpiQ
         spzK9nS17+lzV30VIPIwM9emoCnFZf9Jz5oqECsBurtbEUTgz102NmmL4v4y5qCV7YOd
         72q9gt71GVMlf2Gm2n6e0nYDzuPZWnMtuJ+XXHnyzRN4lt+SnIl0QWiKJlNmZGP/tuHP
         A98w==
X-Gm-Message-State: AFuF++mno+CLJny9mDmY4V2hso7+jJdhVwQhAFNd54p2gnFDNRdaKYo8
	yFMR4IVzigiN83uktTuVkuih6RqnLtQzx4Myc5SGBOYutAedoe1Xy6xl
X-Gm-Gg: AYBFou32YSvMZPBQ1rs2ISgz6PUBDLeNfC3qrRmjqJZBvRHHt6ZQ/npyWDupFixn6qY
	twaJ7oZdEC4gqTzNZUXLpXeGHiBoNnOdJER5qbOuSQz6wvtlqiOxo7lI+277AHx5wfbZYhaS4KB
	1yZzQAj0RxwXxgYfA2lMUdBWCmQ8nz/JAtv4fS4pygnoWPloCT7HdGxORPUHumAWdgkCl6qcijI
	tYZhOcRekGFsU63EV/cYrdhkNNAtIiR4gx94sTWIEjcMyGMEKjksnRw9pHWInhBHWCaSVZMgp+U
	eyZs0Gqxk1GB9+85Iil/Ef53zipKEBVQYqiEUjptyMvLamZZ/5SFI4ou/aYGwYNxvVR5kzd2DqN
	k5O0Asqokh6Jhjr+zwiV0kxnrr4dt6e+OBCMSXorWaNCZafKUtrxUkzF96iyCfp+k30+zOyF2Al
	MjaKoVBhitSVhFGeoxS5omMQaD6IxKhy+qC1vt/U4ekYqwo5TleyDM4Q==
X-Received: by 2002:a17:90b:4a49:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39b26100cd2mr43210772a91.2.1788888934826;
        Tue, 08 Sep 2026 10:35:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae5837d8sm64297a91.0.2026.09.08.10.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:35:34 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:35:29 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Message-ID: <aqBHPDi0Cgv6_1S7@devvm7509.cco0.facebook.com>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <aqAvrZhltKTjlKe7@devvm7509.cco0.facebook.com>
 <58bb5bc7-3ce2-4a9c-a824-5ff37291137f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58bb5bc7-3ce2-4a9c-a824-5ff37291137f@kernel.org>

On 09/08, Matthieu Baerts wrote:
> Hi Stanislav,
> 
> On 08/09/2026 17:56, Stanislav Fomichev wrote:
> > On 09/03, Matthieu Baerts wrote:
> >> Hello,
> >>
> >> TL;DR: containers are now available with all dependencies to easily
> >> execute all static, unit, and functional tests in an environment closed
> >> to the Netdev CI one:
> >>
> >> - https://github.com/orgs/linux-netdev/packages
> > 
> > Are these public/published? I don't see any packages when I go
> > to that page in the browser.
> 
> Oops, I just noticed the small label saying they were private by
> default... That should be fixed now.

Perfect, I do see them now, thanks! Will try to run the scripts, will
let you know if I hit something else..
