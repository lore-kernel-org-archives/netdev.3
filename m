Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332368;
	b=sE7RPepPu0OFgO9B7EKIcd0ZwRrzu0gGFF96ylIphuzEnf32lOFevQbhWFjcCS0ezQTm
	 wZvPa5E0CsPko4rlZpQscorjyUYOWyF9nIb872flPw1PCoZjUgVhbG+u+tvd6kpZxy87k
	 ScJgoLZED2XFxK6SfuRXDi9/ECEG3KeILQpgnQViCE7P4sGUMfN+ZB1HtrI2ze0Z/ukcL
	 u2GFkIXEFyz4x0Hyt8sNdoRX8i+wFO4q1nzumynf7l/U/IFGNKq9ux521F1BAFl7KfQmk
	 ZgufSDMg5sEJB3U8Tp2n+IIjSFHZdwjHgYgLsCw7IbP81IpiV3mihhqAQOvOPq/L50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2nzMZHKj3hE5fscinAAUlVlDiG5XpzZxcETT0RVQ/Lw=;
	b=Bfavs2GaLHdhJa68YbFyvqB3tbI3w/HIxvyIzUtUUvWrFnrf8xs1rAxgCY7JJVePqn2c
	 nq/xMX1htZgtE9e+fkT9PWbMtTc45Z9JHFKmL6LDNaQboTjKd9ekarHa8rrFVJFa6rOWS
	 W44sFLX/AI9u59ejQFGDXI+SYTY1zyBvOQugBzaEPcCOG8my5hpHuwTGxI+CqI+6dNDXw
	 9xx5ifc4vp4j/8iCNErQTz1wy9E+/Sqilh8tJaTL8aduIfrI1v+fzE+crU3Oo+MneYZkD
	 KpSMH357F2H6Ngd+nyYDCUeXy0syNp/4LjFJxzf2wITY+SNMO/f3jJF/r103rqZF96Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jkpr6sIz;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096B606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7096B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jkpr6sIz
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1336846a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794332367; x=1794937167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nzMZHKj3hE5fscinAAUlVlDiG5XpzZxcETT0RVQ/Lw=;
        b=jkpr6sIz1EGGbjXotdPensVeUlAmmDlAkCQ6QiTWJt3NAgl0ri4jpyPmP1OGOBXmS5
         SeN5R85WCkoFcOwPUkrLiwwhH9SitsWu+QQxGrcodtP4GWO6neQusNsel7Gw5yKd9Fit
         Pl7fX1kRauVJh6MlnjL4qsvi1+/JxyQjYZxClaSireoRlDOzEuD2HhgWZF/YR7+F8g5E
         KGoOozXEuQh+4yGzRpwi/yZDcK5ja75bmkPdpKNvQMfUpxBcEu6FwdPnBVkfXx5BD471
         bnz9iBRN0awKMWMiJrZWYdqJmO14MspBZvALUcZYn182LCVGVrij/JSVwqEhh7SafI0b
         +5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332367; x=1794937167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2nzMZHKj3hE5fscinAAUlVlDiG5XpzZxcETT0RVQ/Lw=;
        b=WbD+EUWdp9O6l8L7IVSiXEeEOXCKZyathZJj1fl8mOzZLQCHkDBnUmj9IHe6MffP39
         AOBC1j2b8APuxV9Yt6gvPWL2U/3c8/T2hDiXNc1Ppu7uj/8rYXDTvW4pe7NLzv1T6BL5
         Fe+YQld7qkMNmHXNoyuKpj7/9XDo78Vt0/hMQAL/quszFeeSkLHoKJ9snFXHLA+qCVEu
         CuMxQ6Qt0zttumO9sG0PGYn+vGftzQuXknl7UBmBx3l7gUh0ZHo/dkT4Q0U5rgE4BZDx
         eK3mPPbFLO2aG28U7lMr2INeWODv2Q63sXbhW+Mw89O2rEpwTgnto6q2nE3hJuvqcbAL
         WyWg==
X-Gm-Message-State: APuU4Z9UudFI0C1DcACwd10t0hH72FWsX74AXKSv3ZwV+2YDJ2mcJX9v
	Zy182bhqeq/7PsfOguF3qWtnvBkTNyne4VIDYEQWgEKAV+gL0pu914OvbU/VpDA26pU=
X-Gm-Gg: AYBFou3EL2iaymjRN25oqz3KTNLY4RutpFgzcA2aaHZMGbIT5lZdTRRRsTxg69ivi7F
	LmNvxcI5W/y7NiiMO0X+gmLjM1yii5pl+AtnVlMKORKLHwig7XfUHkXw8tlqsVhZuOUtsJjuOFh
	+1zfNc77knBewM7003WQ/t5Ex5/3RgoyaucQcJuYAV4ZktPrABIs6mgXPPhjFzoUoTJnXAhjZg+
	spoJiEnoi7GWdICb2Y+QGYbfZDZpu+CEFyThaULnF39DzU6OWAxp4Ez+ohw1ICZt96LTl6b9jgn
	up5PaVNbQMKUVzF507PA6oiu54Op9pLXiaEeo24qhP8XlNQNn1//Qt/0zQMgDYOTGTGElds47xu
	/eLxio5wT7uk0jAgrLN7iTeu5YFtp/rvFT5FfU3pVSnAvCsidZV6lJ1Nf1gJg2RD8a6TLUrL/rd
	jNhrP3nWNwF/OvRTwqSA3RRM+CB0V3xZFsxTWigqnMZMjYvy9hUGHCrl7bWJjgbmY4snGM6j1px
	EA9l3mQpKZQUBIegIuMzi3cq991f/mKAGg3Dj51tjQ8XEEg9+Fp/7EeAOxYsN5g1rrbZ3epPG7H
	JhafC2L/hYV8mxiQeZFo4IZ5bEBbIsnmv4FbKCKrpg==
X-Received: by 2002:a17:90b:4d8d:b0:3ac:af8b:6f3 with SMTP id 98e67ed59e1d1-3b166d1e021mr3103752a91.52.1794332366522;
        Tue, 10 Nov 2026 09:39:26 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dfb9827sm580993a91.1.2026.11.10.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:39:25 -0800 (PST)
Date: Tue, 10 Nov 2026 09:39:25 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <avNWzavrxJSasfp5@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org
References: <20261106191423.4194081-1-joe@dama.to>
 <avIpEpoCYvLHYl3j@devvm20253.cco0.facebook.com>
 <CACKFLinPK+wR=TMA3zNJDKQR_=HfMFUHPxKS+yhvv9SegZw7Ow@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinPK+wR=TMA3zNJDKQR_=HfMFUHPxKS+yhvv9SegZw7Ow@mail.gmail.com>

On Mon, Nov 09, 2026 at 04:13:57PM -0800, Michael Chan wrote:
> On Mon, Nov 9, 2026 at 12:12 PM Joe Damato <joe@dama.to> wrote:
> 
> >   - Notifying bnxt_re when DMA is stopped.
> 
> I think this is probably the one item that should be added to the
> patchset.  When DMA is disabled, RoCE will not work at all so adding
> this will make the series more complete.  It may be as simple as
> calling bnxt_ulp_stop(), but I haven't looked into it in detail.

Hm. bnxt_stop_dma runs with rtnl and the netdev instance lock held and
bnxt_ulp_stop -> bnxt_re_suspend takes both. So, I don't think calling
bnxt_ulp_stop is going to work.

Maybe I need to make a new patch where bnxt_stop_dma queues a work item that
calls bnxt_ulp_stop without locks being held? Not sure.

Also: would you be OK with bnxt_re treating BNXT_STATE_DMA_STOPPED as
detached? I'm probably getting this wrong but I think with DMA off
bnxt_re_suspend only takes the detach path when FW_FATAL_COND is set.

LMK if I am missing something here. Just trying to limit the number of
revisions it takes to get something reasonable :)

> We have tested your patches by purposely unmapping the TX buffer early
> to simulate the IOMMU fault.  When the number of rings is small, the
> fall back logic to check the HWRM_RING_FREE response during message
> timeout works most of the time.  With a large number of rings, some of
> the HWRM_RING_FREE messages do not come back at all and DMA will then
> be disabled.  The FW team is still looking into this to understand it
> better.  Thanks.

Thanks for testing.
