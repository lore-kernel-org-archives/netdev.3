Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABA42BEB9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239402; cv=none; b=nVbO6vochWl3Bs5US2PGJZqMDr3XIT99xJ3onxrApyJL2zZCR0si7LWD070ny767RoVLbkUABcR8lkJzMUbs8GQDZXLDO+8kQ3+fAX6pMFCZLvUXpFT4ZAOqMbr1SN07EGLf50oRcUN8vRSgjleMP6g3+jcWe8Pd3Vx2AacKQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239402; c=relaxed/simple;
	bh=KKs5TgK/bdlPiZvZbPNSN/Eut1iksMlXVZG6VkZEE/c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LRJNmYKTwV8sXzQWF0BcjYGyrGxDpgmJVtxnHUi16yDnQa2i0E6wb4dEDFh3ShF+SVdUGKtGCk7nts9ptBMIiGfeRjzLgnpN0+yPyhS3zlfGsNjLz3w+Lqf+B793bkh/xa/MFmXxHcXFoR6MCWTU6/pcsUcYTcso4Wx6OWesbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9aKCqSi; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9aKCqSi"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6685001353fso3245815d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239400; x=1785844200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BQuuwn2iW62IMV+e3sEJt/en3p/kQMHMyeRZJNi261o=;
        b=O9aKCqSifOk41G2FMobPAUyHz6gVdkO0lluRpLbJhjbuDLpKBpsuJygeNkYBYwjEcz
         /jfhFOWtk50mThzkFwmwnp3NttyC2xLWEUa/FG2ghyhewlXboVEJEMQRvdOcP7kkQe3z
         SESQpa9Fb3AboDNxMyq50c556pgZaXsXX5TzhUsRvzTnZa70BWZwbIJGJ7zqu/3KPBsd
         nkNMHshYHLnRkk/L8HEvmR6JASgCCzd+NW5yYsy+fXWeVJO4+5jJ0TaYMSleGCDH3H5+
         IDizh5w2jgcDzcS6Lso2g87eNDYrxwLSQt8M3b7FrDLWk7fiqjQfNDBNtGxUZODOqudb
         L43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239400; x=1785844200;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQuuwn2iW62IMV+e3sEJt/en3p/kQMHMyeRZJNi261o=;
        b=bCOKnHVAmMwfF2IMB4M0iPRibfNE6i29g4Xe1TghQGPeabETJDBKwGm5JU+BnmVftz
         nPCmJYibsLVD2CNZP73t7zDd7RMB6klVMQrhIHD35rEuBt4FSZrZLXiZn5SC/L2W43XQ
         JsslQ463UUGPzVmg8nlsm5oUaxf0qvp02S6zyRZWME4lf+AyKe8yiR/lZlF7ZboLV27H
         gAhYkE77gkQjH4aHzU4Hlrc1oRvCEBJCk6/wcyf29I9g+d1xRLAUBCWo1/8otWmsNgPN
         G9o4ntiXpL6+AfqHoj7tqRmxyxVgFRuoUPT//AoIbRavV7uRooTTP7HFBZQZwqr4Lxmm
         On/g==
X-Gm-Message-State: AOJu0YzGdnZDf5HrZtJRQSEnJnaas1aN9MpbbcnuVYM9D1G5cMS3YlXx
	MUJ/r9/odUCfDQ+mX4qikuBn/Lh1mb0ib66fdyN17zqlL3dwcAfThvL4
X-Gm-Gg: AR+sD13xSutLKby3U3Z0+z5YTDjPmc+i/BDGKKRvpX8D9tRahSzHt0DFGxHYZLREWIp
	f9QkRiVdtFfUXr9tHdNJAahKMtURr8sR5keI/MkuCkOB35xtXpRTjYZkJpGxqJrkVFmoJRYUEaT
	giA/KWw5rPPVnYOsmLyIhuHL77BzHh1WnR5WBXAtNg/pg5M+xxJMNyvMw3mWBh8d4i4NEjYJXnr
	5vgOGuPQtx9mRQjc6dKlbCLCGqcRTzIjJGfEYibOw6GCoExQwUL7BvIxScQyV8wEBOIBvFfyjL0
	ZjHofxYtz5X60J2sQJTLOAw9/Q89HN7iobRfcenhErzuoTj5tyiysgg04mfxhvBqVgocSdZOZbt
	k0VaMWo38cvzVBdSjlpvrBsEJw0RUAiPNFPip69ABcz/4l3NzsXYnQn/2lpgGgW8DzLkqTUIDAh
	Q8BvJxm4gWoEeNLBAMGwB0fACr56DsiK90XwsLmK7dZnRSpmCMvw==
X-Received: by 2002:a05:690e:454e:10b0:666:515c:5222 with SMTP id 956f58d0204a3-669056b89c4mr458055d50.29.1785239400551;
        Tue, 28 Jul 2026 04:50:00 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6fab2d0sm4847571d50.14.2026.07.28.04.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:50:00 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:49:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 mohsin.bashr@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Joshua A Hay <joshua.a.hay@intel.com>
Message-ID: <willemdebruijn.kernel.28d1bc6099571@gmail.com>
In-Reply-To: <20260727165403.268e6e4f@kernel.org>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
 <20260726202902.760552-4-willemdebruijn.kernel@gmail.com>
 <20260727165403.268e6e4f@kernel.org>
Subject: Re: [PATCH net-next v3 3/7] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 26 Jul 2026 16:28:47 -0400 Willem de Bruijn wrote:
> > If skb->tstamp is in the future, program this future delivery txtime
> > in the transmit descriptor.
> > 
> > TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> > the FQ offload_horizon is configured.
> 
> Hm, you're not even acting on the activation of the feature via ethtool.
> What am I missing...

Activation is only picked up on qdisc add/change.

In those lines you pointed out as less than elegant.
