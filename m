Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8A3203B6
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542021; cv=pass; b=m6eZ/gPfSZV45oSHaVOnCNXunU4qco/+JN8oaHVA305MxKuxySV8ucuMe82l2ImxUReV7TiyCnYn49m+u7ZIiWnk6dYLWF+ivDZnQaVhMvi53ON6gsQYr270RREa5Ve07GmbgT6ABy/ZVPA4AgrobEep5pLYcuSRZAB16xqjasY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542021; c=relaxed/simple;
	bh=6dAeHMq8oclF4+7uiqzX/a7sOiYc5+TA4dKD3IdnxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVqjBVnYS6So+xm3qvWsCRwwbaZqzTMY7bocQ06JXWiNPw2axdChzsJd/395uKhP6goTSTcTTY+XwL0LzGJHytW5mfWbIqvJ3fdGEGLKdkCyRH7McRKsoiii6vX4hx7k/eYD920hLC7SOMpI75tEhiaf1PtQBD87ucvJjzhv/5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ZVfGuQ; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ZVfGuQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso2989608b3a.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 20:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787542020; cv=none;
        d=google.com; s=arc-20260327;
        b=leJ1/5PF/aR5pQzyXFZEvmboYzlhN7baIoMwpNQ7YMODUvDvUxt6MBNtf+jsAPXSdl
         eeub+B0kXW7JT4FXsInVeAmbXYP1nYeWxMnDIeiRNaLhVL/XTGzQU15ytCq2/Ayj11U7
         HKs3zG5RVMjNur7eIKMn5PKgyUeGMYpXiqi8fol5KGUiDOVyc7SLaiPXx6Njd0OKmp0R
         djWKRCLD4Iq+8cJB3CdoTOH7wwwlH8AmLEQDaIgN/Rpue2FROmTGgO3EeUJ3cqntuZNi
         TKIWSU8aT6GV/WyZ+kQhieVmpffkggdSostvQxE1dx1Jb8Wb4W0SZQUeRb7DrFlKLR6x
         6i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vn5Grfq8EKmTmGxngrxWU6AOn5Yz/bW9/raAibSSbKY=;
        fh=XWTZoUL5OyPHlFqVeP3hUAXnt1zohRBOgPITE/zE6MU=;
        b=sjSA0S7PhL6nXQVlvT+0JC2bmk9lSJShsYtRZ1x+1HfrtfO8dqgi7a54Gg6EgkaNHl
         xouW6EfR9ONR5zowF2SuomNCFdV+z9EHbKhMzmmP2X4iHq/t7tQ3i3UNi6iT73Z6MvIe
         MQiJdfqcbUpBIiH6I9f7uPW15trt11kipR1hXvAsdsD3TweLJw6tNar84TWpB4IZbzRd
         6VD5h8AV1DAuOwTU7Tui+pJeMFa6PPcxHH/S0rSHBt7xHdEcUvRannuL/YeficP4U8NM
         l7Zv/ZqctdAbGYTG/2xxYlQ3hNhjvuSSA+B76BnN+3I4Jzy+OJyFtYj4+7eKtbrE1EwB
         gHzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542020; x=1788146820; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vn5Grfq8EKmTmGxngrxWU6AOn5Yz/bW9/raAibSSbKY=;
        b=F5ZVfGuQ+JY0QNrKN10fVk0OuExwVEhl4IrnSsYItViPg1dHeZQuJcRdmYOVoCwWFR
         fMU9MkysW8QhZ45q29djvtHjQreW2WRuIu1cO+VNcTZk40LQL3IMuj4ClvYsGq87OTAx
         Od3g2MYlFOpCYIkp1KTnSTOQ+lwSirrqaNaNXSjoFTTlfdTNec9jemTo12ldpdqE3rlo
         J+gqUtaYrAvSTc2jbDRJRb9c8v0iwNfrbRw5fE4zXBws0KdRH+JdHwkC+icG5VP/6MmO
         h/JC3A3tqWMiGDHh1QlfdTBB9uYLriOtnqEpMR2KC0D2dLCFEIxK6ieprcFck70emWjr
         NVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542020; x=1788146820;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vn5Grfq8EKmTmGxngrxWU6AOn5Yz/bW9/raAibSSbKY=;
        b=tNK2B0GP32vN3jaB4IN9eMqtYqvEXa39hlpp6j0HjNClGheAqBOJI6ULSbM3E1+zXe
         WOtD1Gw3aZRiRwFp9rEU6scf1MOUKC90vRjNxZLSX/6jd8kK4KTcPn1yFPiDVO2TLp31
         uAebwuK+uaVowlwYLolCRELtPYDjHLJSGycRcTxZe58UXc3MUQo8uEky/AL+DJuYaqj9
         2WFwwxrXTUitBlL3jYnBbXIIBzgnetje2mvyABtaEQuPXX4/fIUHvcuKJ8Riyuc0jIVE
         aU+FKihTPaThXN+LpLpWuWTV851r22keSx+GJgNQ7jUEL2ot8LvlIfcpn/rrO4OFtO/4
         u3QQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyqIDI91W0+z/Hs+5vMEKf6l2e53LSEUNrC27IlUpL9GGNFwBmpCRBW4gDZUrHD8pVMOZhGI4=@vger.kernel.org
X-Gm-Message-State: AFuF++l33GIid0rHuqOYnfrbBVjaA5A7XBBzzKw0HYFWk9udERTtZFBk
	45H8T/dv9CMQuL3pmZCnIqm6+ObvrP3E90CyWMAzdeGoyoL/ZTNgEqpgp0xJafVgdmNNMBNGJyv
	nQ3B/GU6G92uhRnoxWg4ProK0uABUmACOa40+
X-Gm-Gg: AR+sD11+MbmBpNJ3y9FWtZlVPTKsXdsoeuBCvC1OJvTEUPB+PIarOt38KUGI3rTlXPD
	WJXDBXs1+xd/MPUpy+4m3d0/Jobai+zuTeVDzCpRIyPNTEnWT0HObV4nz/QhZ+RXiXrWgBZ6HhC
	PFG9cXCkoANbeMIqoWSoa88z9R0uWyQ1nYiieOKN1cA66CqVnZL3933PTnZFIK4Vn0PhXnk9k1S
	d7M6IGEoWPCKasFrV0pyhSMy1hdbusTqdB/4b9GUWWGsDGAMj2wqhphjln1UA1cj1kg8zHjrqUs
	pwHm9kymKxEfGQJ6cqTbrNbrTs4+gqMQZmSlUBc5GrpZnj/mj3PBpztqBw3KHB7BBdiosyyM/6j
	WlLhb6unLFoSjPkxFvGT8MTcmPE+Y/ehIQOACa6o3OhWdCL7t+zG4RqH96ZvUb2wVgMo=
X-Received: by 2002:a05:6a00:3690:b0:84f:d7e4:3404 with SMTP id
 d2e1a72fcca58-8520be6fd22mr25781730b3a.11.1787542019751; Sun, 23 Aug 2026
 20:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821123249.41527-1-phucduc.bui@gmail.com> <20260821123249.41527-4-phucduc.bui@gmail.com>
 <e225c560-eae8-4487-be66-f624e5e215ee@amd.com> <CAABR9nHwTFFGVS3Y0MXsBx2ubtexaZ6hqcZYQ5au1UjxEjb+qQ@mail.gmail.com>
In-Reply-To: <CAABR9nHwTFFGVS3Y0MXsBx2ubtexaZ6hqcZYQ5au1UjxEjb+qQ@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 24 Aug 2026 10:26:48 +0700
X-Gm-Features: AcwNN1VJLv--eX-5_gqjLRJ9ip4awutmgtchqsVq-gwKiv10BUXsapFpjJ8kMAI
Message-ID: <CAABR9nFqr38hmWtKnFyNNAPUoKoWQA=33tS9crNLyO+tUMVFtQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] net: xilinx: axienet: Fix IRQ error handling
To: "Gupta, Suraj" <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,  Radhey, Gupta.

> >
> > ENOMEM is a slightly misleading errno for "IRQ not found" on the OF path
> > -EINVAL/-ENXIO would be more accurate. Since we are here, better to
> > correct that also.
> >
>
> Thanks for pointing this out. I agree that -ENOMEM is misleading here.
> I'll address this separately.
>

I initially planned to make a separate series for fixing the returned
error codes,
but I think it is better to include those changes in this series.

I would also like to withdraw this series from net and resend it to
net-next after August 31.
Since there have been no reported issues and these were found through
code review,
I think net-next is more appropriate.

Best regards,
Phuc
