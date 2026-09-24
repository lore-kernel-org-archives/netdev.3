Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549E4C150A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285198; cv=none; b=aPLaaZes6au8JPrLJBKC7h8V0aUFWAWfhFFRjJgE5+4kop+PVmN1FyM9c4PKatXvXhUwCk1+DP301DXs9P5SYBJNgmPCBqOtsTkiiJajAXJ3h30XYuADqXTs1lK5y0mK27YJlxQrlMQBZqnqStsBnj83G85sLFWBZmqR+L72wA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285198; c=relaxed/simple;
	bh=EBIyTvT/RiFCeBd6RBr3SBgwznC0sMq6W15H95Y1pnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCvqRi+sdsOzqrCFQ+Ur+2NouyHgyhfmuHt+102Uvp/FIEZJrh9cWqfhxDCJpye5dzz00alUl4E2Va0StuPM6MH8bfnmXXWRD36Z4WtcLUfbTf+nJYlJbg/pOwy/STRY17CYgOMFinbQXsCBnFe/bIWMr6OHQFFYJIGfDIQxhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IACNgUPR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IACNgUPR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b55da9so27246f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790285189; x=1790889989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1QGMODZqbbQ8GRF8jTWE3PN7/2ZBuLQYZ3QAea8zzo=;
        b=IACNgUPRIRohPFF7DeTLJt2thlkeWVKRLA+DxL/7+Yuo36W6pdHRJxyAJCDf106hx0
         U2BC7di0Eaho2k9lSAhA1oEzaHSlgguqqHY/Ljrgou15n5wa1UEoWGhO2tlUkDBFjzV8
         BO0CuEloKyuDhe0I+yARwHUuMdIzWg+jq1Zp8u5AkfRYNMemzscooJlx3UoLhs8O2+bw
         EqggZRDauPCYn3OFuuGAQHyE77JuNBBtwkHMqJLy3/mUnBItC4jr5R6w2S7G8Czj+HK6
         CFogRfR+FtxCKy1I1L2jOgVaB/Fht+22nezx+32lYXZnbn2bOgPUvarRs4HEU9TXASJz
         nHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285189; x=1790889989;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1QGMODZqbbQ8GRF8jTWE3PN7/2ZBuLQYZ3QAea8zzo=;
        b=1oDwRta4NzKuQE0yZPBmnw40GDOePB/J7DGFY6hdEyFN9Ub4mk+vnd5ta5B9ejbdrT
         cTcGySgDRZLOI+Bd5uh3qrCmWsEaHISSXrhf1zSrFrTm+5MstxWPSJssGgruJGYazUZ2
         8KgjobWlcvjzVYSGyC7nwDzdB33RJCONnBTV4z1orpLOXwsIjnwKI6LV6qT+gSDYylWH
         WQDVMdyAzGca+zMMrXh2ZlQOqgWVXdo5BzGhrqxZ2vV0xAu1f7I+OurElGHbq9PAd5Wt
         ZB451x4O/MA+U9xksA8H6iOMaKwYuEPPsaGXkkkWScBYCCV3KPJmYVWalt9N/UVFFB+7
         dpTA==
X-Gm-Message-State: AFuF++kkoRebwVi72C4QIoXPxT21TNqZybHk3B+SM9O+noZFg+3g9R4Y
	74UYtTT4dHajMUJ20Az4fBJMuPRF8FXxhbupQMZrA9GMFYrCClbcMn/v
X-Gm-Gg: AYBFou3UFnScfwKUqRiANre0Kf/4ouPC02+eoTsDzHtQqLV7RLfHXV+lxvCcBf+AVam
	/9MjNeJaRA5jNsTHuPkhO0vFmba6oNm2fYwLGlhwyLZb3QDqHp4s11e9bIYROv9bwnDZzK73D8q
	cqdoCa5sQggXDW2e4Y9ywuEkPYXKIib1TfZRRQyWLSsqFhl2qY6tJDfNPz0a4A1t8dygfQhWDFo
	CKlIdZi7g/l9yXncIyISBA5dqRPuBY4qJcyZfxEvBUBz+/fXVv8ZeUfdz0sUls9kDgzz6q8lxV5
	PFKqx0P1VwfdhOi5XlepboA7hmfVW2G6m28rXFewHSfYin59vDbUypnhbu0ytNxti9XFEudGoIs
	xWBg1ajIVCZk/1QpHMws9yzdfMXdrV3+zKDblKUjQDo6v9j5bkp54ETOhvyQy+rMN8Ugjvnh+sJ
	Z/gZqa1SPH7xMSpoqwowjyiRkfYSpde3PtXn2aaUncl3W/Hwo3wgnPrd5BNfACBoRev9ACqWW6p
	JoQmmcYWUp/9sA1F6pG1Y59XhpuR2vOi/DTlGXE6tI5/I+vByu7jubgvdzaIOgNQpKO2dIGcVia
	ksIjc9yhTW6PZ2f7HcTMR3Ekv0weW4nb+vDmw4gU9fQdR0w/deEucNZ/hFxVZZ3kwR3pgr88e2v
	yxWT8TAFU4rZz2QxSFjrR
X-Received: by 2002:a05:6000:2083:b0:487:a7a:72cd with SMTP id ffacd0b85a97d-488716f4ab8mr6194383f8f.5.1790285188563;
        Thu, 24 Sep 2026 14:26:28 -0700 (PDT)
Received: from ?IPV6:2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd? (dynamic-2a02-3100-610f-ecfc-4dfb-2ac9-70ba-48bd.310.pool.telefonica.de. [2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a354c47sm1861179f8f.15.2026.09.24.14.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:26:28 -0700 (PDT)
Message-ID: <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
Date: Thu, 24 Sep 2026 23:26:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260923104346.ur63K3h2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2026 12:43, Sebastian Andrzej Siewior wrote:
> Wouldn't it be simpler to not allow such packets? 

For master TX, yes: removing GSO features lets the core segment before
ndo_start_xmit(), as patch 3 already does.

The interlink RX path is different. With GRO/GRO_HW disabled, it can
still receive skbs that were already GSO at the sender. I reproduced
this with ordinary TCP traffic over veth in a VM. Rejecting these skbs
would drop valid traffic.

I'll retain segmentation for valid interlink GSO in the ordered
consumer described in my patch 2 reply, before per-frame sequence
allocation and HSR tag/PRP RCT construction. Each aggregate would finish
before the next input, without holding an HSR lock across segmentation
or transmission.

-- 
Xin
