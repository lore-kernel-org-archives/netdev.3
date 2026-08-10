Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8240926E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387146; cv=none; b=aXXI/SE3JE74ROePE1Ak4qvjwJj6JWvxL5zyUyfDw7FvlvQEmfjAiAmpn21EqWXBtFTfmzNvKpJSijUuO3LhQubk09uTwyCV1zqbwwzOFZlwhM7ms5qs2aIHF8qr7q3mvYAh+nEkRFzTA+auxPWHaU45Y2d6vG/qr1Kjg0pv8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387146; c=relaxed/simple;
	bh=Nral/dYqyGldLvxHTMvVBlD9CtS4+FMavflIEc6STkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF5mbAZVuFchWz0SIOFTN5MDd3Y2/Oa5o6h1p85vdQBGfJYASC+th8ufVrQUo76hR5/pjlFZf2c3hWgvrFh0MyewXErajBGJs29muBAHBNiNXV9tcZcip62vDfg+WHIcsAMTCXabM4VSoZrgUpnhY3vznjnEioFFihEmEgeutwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e9/J1mq6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e9/J1mq6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e6391b114so164551685a.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786387144; x=1786991944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iwk7uyjruTQ4c8X56rFTLAqTuNzGXiGTlH3ymNzFTvA=;
        b=e9/J1mq68qkTGim7BQPUCeAop7L8XzB09AkEQfRmmtOhzaXu1jndpVigy0RmsF5MD3
         byl+iejJnCSavvrIJ1pCsZiPX4YeJrWUN8vev22bbhIKp9j7YuMR07YTFOhF45nY0A0H
         0KnLJmUt2c5NJtBwLIAbjVtnTWKikC8M9UQ8ThUpPgEVk8+JPB72Kn9ChjAc28cc9S/T
         FNJQy6TciIu72mXV2K5PygkXrtc8/iee9NnQSfhX/kqks/WEp4IisA4S3KxYBWh0+17W
         LmMUo96NaIvOlD1T49LgZYz10VKmiAgD1IE213azxfp+8kyuA80tC0bglVCN75yxRnMM
         eUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387144; x=1786991944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwk7uyjruTQ4c8X56rFTLAqTuNzGXiGTlH3ymNzFTvA=;
        b=UHF6o7JzgLXpwzummkg5DckSfa53a3uH2YVLVsbr379pgo3aZaA5dPZd3dDqfJlh/E
         sJSkH4tiwVdcrSDlvzIko6De3CzQZ+qEu/S/eYTw8WrKFAluC8GQZ/+T+BaLup+7o74r
         w2w1H9pg7kQrb1uYIpetk1ewt6aY+WOROftw1kM13YmANQz/W4IiEyrsrSGuaQnOMFBa
         iw0hvswcWoRwjdevu8sa4/WL+wMwS70OZXlHuM87bXhXC++RLztTa1Qm/V/7gOv0RBpo
         gpk0DmyefGmTgDmyxuCvl+0qcExOfjT12VF2qHXdFPy4eX+wDix5oaIRzaAPSazSB6tY
         Y9xA==
X-Forwarded-Encrypted: i=1; AHgh+RqQlXepI3bTPRI4gr1uS3MrNAKWgoYWfuMG9OTJc3lo6kmXYWauSQCt1XomKOTOn/FrE0tRNhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjKWfFpIIglA9JR+zMamvNlbdcwKo/vrsDki/oEW3Kz5AdUrM
	igkec1igOcqiksU8VLjOIj2Vponnoq/FAh+dATP9T7/5eidsZ61+0fmX+cH7uQgCpzsSRHN+Isg
	oxbTK
X-Gm-Gg: AR+sD10qB8BxmOB9Gr7rumnQe1TGAE5BbSnDZggoBN0L7fNLxWeyFD5WISk0fQQ1NQX
	c2vxBMmh+xWII/iXbzmo5Y3ibjbq2SeY4hPJXeZ5pqlubhR80U2n47b7mLtEjoWfXkHtSgp2Hmm
	3kDBMCnvzk9MWWMFlpaKcceM46sFTN5kp6kuleXYKbv7zdp2J4vKmk9dmUHSSu5SJKzFyGe2aP2
	RbYf5HZFLXouFAau1DmYCPqzS1F70rA0DUJCB28X6M4BZTk4nHnuG8ud/7QtpxyOCEIWxhUfLvs
	7UMAFgFJZiblvHVOU2tN5spL//AoU0ce10YKaRBZIrDsOJPUrOI820Fl022U6ZwCZ9zhyMRjEll
	AiKD2U+H4+z48xeOVqaslo+sCx4kkrva5kTBYCYK0K7zAwQiDvyEqgXckNVvrwa+FNAr1b5doYv
	uTEVc1hxQ3TTYZ1XzdhH1hXQp3x524vmLfQW2hxWVv5oGg87E0bw==
X-Received: by 2002:a05:620a:4086:b0:92b:641f:ea5e with SMTP id af79cd13be357-93666268484mr3039046285a.0.1786387143968;
        Mon, 10 Aug 2026 11:39:03 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03f05bsm848242385a.2.2026.08.10.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:39:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtUtq-00000002Agf-2rzs;
	Mon, 10 Aug 2026 15:39:02 -0300
Date: Mon, 10 Aug 2026 15:39:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] RDMA/core: Reject unregistering netdevs in
 ib_get_eth_speed
Message-ID: <20260810183902.GD507588@ziepe.ca>
References: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
 <20260810113308.5db6937e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810113308.5db6937e@kernel.org>

On Mon, Aug 10, 2026 at 11:33:08AM -0700, Jakub Kicinski wrote:
> On Mon, 10 Aug 2026 15:31:20 +0200 Krystian Kaniewski wrote:
> > Subject: [PATCH net v3] RDMA/core: Reject unregistering netdevs in ib_get_eth_speed
> 
> nit: Please don't tag as [PATCH net], networking maintainers don't
> normally touch RDMA patches.

I also drop all patches tagged like this from the patchworks sight
unseen.

Jason
