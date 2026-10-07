Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B804189DD
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791414852; cv=none; b=OXMxKzMW8NJ0pLoDRmToQj4pGOjZmQlcZJf0qwyUc2WdVo+v/LHI3G1VU8KBG3j25TWJuLC5fTczCedDZAjmibrb1F5r28iyGXGFfq+NZ90eRVqzoIdIP44+Q9qdJ6S1QLbG9FNJmmSF6EdrIRZRR/Ej5q8bvVfA4+Iuvt9dB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791414852; c=relaxed/simple;
	bh=GWK1/hPiqJ9JVmSM2O9wvZMuEFkzJcNqHbTrXfCjbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtyW4V4UwFdyPZU6cxrUKmRN6ek0p+soUXnazKmYJwQGocbYDI5irgMF3e0ZUDEAgXUEBOk+AxDGA1pmE/8To6Z7G9A6acfLQrgPrJnxfbKzgYKR0Sp0DesOyB48F1+WBtXGsXRPwRyqFJgCO47eP35BVY+uBTe/SGHuskC8XD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Xc8CiWcz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Xc8CiWcz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1589403a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791414850; x=1792019650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWBMI7VK8tYYnaeyXBuzp13VimQ/VNPvrb7PAoXYqUY=;
        b=Xc8CiWczE4kz2NHYWkrd4MD+V6nlTDWCjKrmklUgIjOYHrXHMjnlo6mMpjHbWd4Lrn
         EEnBRjEU5/0mYhVaO8sZBxBeLIYXRu9EjrnDoM81vjWm81FKL+eIs+EMxrgjevHf/I2T
         iZ0n9BEiHiG8yrbNQ5XUpPIJoG8NKK/p6zUClmKEqgvtA5uAHhvrwTps8HgaUqFT49DS
         nuuKNB1SaoN+AHP9vkoNithQ9319NDS5cn/omwew3Bnjd0odYHafhtSqG3qD6zsmGrUV
         oIbATNRGstCHAqKdOdALO8JfRR6VwZOpMwT28oQv2+ZCw9YktmK1f1W9zp3GH+eDrBww
         jtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791414850; x=1792019650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWBMI7VK8tYYnaeyXBuzp13VimQ/VNPvrb7PAoXYqUY=;
        b=AqL/SqmNzYSUMOkBVs3fobRGM3TVHbbqu3BowJed3bznyQMMCP7W6ev5ZLh5lDXxL/
         f+O/GjVuW7L8jVnNvujdA3RHAggauYDQFsr4C1rsE29WaDesAU/8WQr89ytz1zLqubAT
         6vD36UGycEDi5gJLzlYOUPU8OB9JREmwd/LzFPTCbBdBDjKrIjUB+2Uft71+MEPVLCh5
         SLgYgl3dVFdJatYkimyKZCMUCL6EOzY3kf+kcc3emtYBQpART2g1djCL70yEUfSA9Gib
         ESVwzGYNkeZxqsjLTp6enyypmpjZ3p17nDNG0LgqAtxoS/mMN+Xr3/WakXInJC85wWdO
         gRYg==
X-Forwarded-Encrypted: i=1; AKwUvBzKgzBfHQREstfiRIHHleftRg0NvT5K4+11+XPSCkLpeM6VuPMFEUcYv+IFm0S9NbxaHW4+pfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO3P01xRNNQnqwrZxME24cupt2JnwpZHbY7BoFX5165Lp0Hm5q
	RKUvZxRdIlC+lNuTQN06xqaLfCTP7bWra58b1uLRrmp78+qL83gGB9M7M3dkUa2ii1A=
X-Gm-Gg: AYBFou1LN7HEwkE9T8UQAIaRDmro66mlRRfX30S8FwlVFI90ElyquBYNnEVvAqROnYx
	X9zXcLoCUoiWEwqBM+XYTD7e9WiIYOFrDToZtrc56tNgzKQafZdcICGHtVWm3U1qRfUsNa0TaAC
	8STygcMwf5aUNE3l1u5JYW+vAHtoL8k7j4PQ9szRTejghwFKgVJEh6cNwpTfYQwkZC9Agkh0Suk
	Hd5n3mLKx9W84g3UPzuFR0y6VhiRn//O9eTMz8SIB2cBLWvLG2pfPFDnWUKf+BBpelB4kN0ByMe
	WHWqKIO5QQjWykQnfLjCRFT0dcc3rCZ14GSOFDDAVAEsYqKefFe/ll+qotn0xLplu2+25zCYGYa
	80FOSH/yqKa6YNx4Np0Gre00FXAe3i5UReWDsGKFiTVwabcFbqk+eTvDH54g43Yvaheoy7pVoKZ
	eyOsB43OAX5DkXUdABGjq2u3juTW55rBwXraiC97zRRNjCPJT7lqbcwaI94o149PHME2AZ1p9SC
	I+eej8NDzE=
X-Received: by 2002:a17:90b:3902:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3a8a1af09bamr2823154a91.36.1791414849905;
        Wed, 07 Oct 2026 16:14:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9d94ef876sm1461469a91.0.2026.10.07.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 16:14:09 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:14:08 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>,
	Eric Dumazet <edumazet@google.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bernhard Schmidt <berni@debian.org>
Subject: Re: [PATCH v3 net] bnxt_en: fix DMA mapping length for padded small
 packets
Message-ID: <asbSQH/P6izz9HcM@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>,
	Eric Dumazet <edumazet@google.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bernhard Schmidt <berni@debian.org>
References: <20261007051747.455273-1-edumazet@kernel.org>
 <CACKFLi=iNjxDPyzgGwj6YG-dc+OfoAo8TxFkAVE3QRV524z6Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=iNjxDPyzgGwj6YG-dc+OfoAo8TxFkAVE3QRV524z6Ow@mail.gmail.com>

On Wed, Oct 07, 2026 at 03:58:31PM -0700, Michael Chan wrote:
> On Tue, Oct 6, 2026 at 10:17 PM Eric Dumazet <edumazet@kernel.org> wrote:
> 
> > Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in
> > bnxt_start_xmit(), before skb_shinfo(skb)->nr_frags is sampled,
> > because padding might linearize the skb.
> > This ensures skb->len and skb_headlen(skb) reflect the padded size so
> > that dma_map_single() maps the full buffer and the descriptor length is
> > consistent. This also removes the temporary 'pad' variable and masking logic.
> >
> > The padding is done after the SW USO branch, otherwise
> > bnxt_sw_udp_gso_xmit() would account the padding as UDP payload
> > and send it in extra segments.
> >
> > Note that SW USO segments are still not padded: with IPv4, a segment
> > carrying less than 10 bytes of UDP payload (small gso_size, or a short
> > last segment) is sent as a frame shorter than BNXT_MIN_PKT_SIZE.
> > This is a separate issue, left for a followup patch.
> >
> > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Fleischmann <sfle@kth.se>
> > Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
> > Assisted-by: LLM
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> v3 looks perfect to me for non SW USO packets.  Thanks.

FWIW: Once Eric's patch is in, I'll try to come up with a SW USO fix.
Thanks Eric for facing off with sashiko.
