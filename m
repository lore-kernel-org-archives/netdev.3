Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348840;
	b=Ty4BT37LnFrWgMUt0+/WCiqPTdmEuxhc7FLr6dwVoMNBN2+L4WQYg9d+jQ3M88aF1X0e
	 K2vBMIHJUZYutQigc81QZwfLa7FQNA+pfxD2Ml/3tLiiC9JRsAZxtFhDx2gwqbP+WhZ+C
	 gyeg4TfeEwXuJ6C9qhqgThvkcE7aQ3XtdP0FFeSPZGNGaW211C3VynNmVl0y/iAVHSuHZ
	 HEcJQP0kKFtCpMB5ibQVS3zOq9pOA6yFu5FQhiOKU/ndN0wmkh09lusLu/M6yo0O5sJ89
	 yhF0uZUNJ4tR9cdvpPyQbfjJeKInH8irJKNT9VzCToO8PX/kJSEmQa0U69UDCZ8D/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=o1TWetvXqmnZqe66iKDTc99BGiIMVM+8egrEZgCwU64=;
	b=lMkyQKWDMn1vOVeadAmRzVISkNGSDJYkiHuhtQuWDVk/7k29r6uzxQM9Fu11BQ1dqCOm
	 RJVgUt2G4r/VwsLC1Iav7WHWvLTC0Mz41uWDeYmTiaIdubQy6FDrCgQoWWPg5u6pDwYNq
	 RWwsEFBV2faWr9PoMICmouWmakmE5E8pvqv7q1Sajgz3BXCX8f5X0yR0rTjCEx9FrUQ3b
	 HRwBiy2Xd6RU5hkrPq8Ok6T3/S8Oke6PC6oHrecaD6uhZ86zik32ppPLHvZ1iyvTkSFqU
	 oZgqVQzw+7PMKY92WZglrJOqFAcUlG142pfbyanud1LpJKDazVxt4AlJZeoqm21ogAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sb7YHck2;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2B60A2627
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E2B60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sb7YHck2
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1422183a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794348839; x=1794953639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1TWetvXqmnZqe66iKDTc99BGiIMVM+8egrEZgCwU64=;
        b=sb7YHck2HEI3rzp3xBJIcgU9+z5nvBQcaCX6qGriHWzx0RqLUOjGs/eEmNmXX5cDKy
         x1T/wdm8ATuTZC/ZMeK8MnCZZOAM5RcwTSfY4hREYVJAng9ZqJHz+oPaXoQtHGR/CYxl
         Py6bwVna1z/c45jgSCqs0gdKbU9Ofg8+hC/K9QRNrkvCAzi+QaSMZ8D6u3YKqykLVgc1
         iwriTemklGSLka8QVNp757TUmhoSQXXJOjiS0fZqEwntRr+n3SoAVlbbheOsq7mKs8yx
         KfXN4SC0p2moI48sbO7j7nJepvZUixgW6XqkZjrxwHaXb996CgowhAKVJaSbJVQy3kgX
         ygmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348839; x=1794953639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o1TWetvXqmnZqe66iKDTc99BGiIMVM+8egrEZgCwU64=;
        b=xnggN6FIgkS5lV8wgzuDJ87QqK1r+cH3wScaqTrWCYv7s9CyG1qgZCtwK/TKveJz7z
         w1Qq650gYURSrjJtbdV/vPZXFkpAvou05JBEPbAkQ2MV73J9UjxMd7pOtjkhxsaCnUIh
         d2xm7gNSoSrFrfce/AmrVlI2IsQgIbyEmjUcyQ1WodbYnpf8hHTg3s1kAR9J3YzipeAP
         aLkaRqDNy2WWfOlsrsVAFD2kDCXAVEP2ZNdFbn8mbTemjheeUQqmIMDbnb4RQENk7CMN
         QTTFwI6NGAP82a1vvQ105Zb5xoCtj0CuhU7jeiOyuXSggIvNYoohwigglY2BLfxqd2sM
         0/yw==
X-Gm-Message-State: APuU4Z9jnPXiiATCw4C7/DEsE3Caz/qRZ8wPPgJDiGaaW1TScte4Jfjo
	lgaqIYwhPq9lpFkGgnWdJhIlTfSFScjtjDecqRtj1Y+UQUIaoDlFj+qNseQ3YUUfb+Q=
X-Gm-Gg: AYBFou3TvwtZVEOOpHLPv8ot55KSWBljSWyjANW6DAfxl0+md4z2jybFMMV56bWFO2g
	zqS3HWAFig1S9jsm5GuH/AkUbkeIX8YjnXBWd3+dA38aH2KUXK7lVh3LEJUaxyGdY0j7H2o9MDL
	WAaT5L/OmIYKib3JDNw4nId9JSmU4XRAqpLoYOZPUjgO+sOkjFdLHmyne9ewrzdZ3NTAbOj/fSy
	KFOtUmGfzhKkqRlWR2wWRyT89lti5DXeM/5I6G3sqc5rTFn8VX4uVFZq3/kKeutV8re5T7AemPf
	sq4VmCIhpjp24Z40oYld1rYuNQo5RCGiqN8nO71dqj6yHenqq/cYIZmfqmZyYdTXR3bSAlK7FzF
	v+WID4TJw4ilK7pUX6Ba6Huu2Eg/Ujkr+DICOtCTDffn5oyeAWKQ80YRvzNkvJgrM0T94yoUCRI
	F2oWQHAHLhcymfwr4e1/x/sXrOH7y5WtegIgUMhfkNL7YUSvGVMHlGH7Hh2Bcw0rIzP2hEvO39E
	PAnlaYfc8kTn15C0BgHrdwNiuNj4OWnogoYpvGXCDzyjTv+c7AdgcDkxOA3h8oV/orVKJ2Iwx2p
	Bqy2Opij5JNPMCbQ1sBDPPQvCkfm6f5eZjZKYwHxkxw=
X-Received: by 2002:a17:90b:2d85:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b182f570cdmr210701a91.31.1794348838994;
        Tue, 10 Nov 2026 14:13:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db4faacsm1519211a91.7.2026.11.10.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:13:58 -0800 (PST)
Date: Tue, 10 Nov 2026 14:13:57 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <avOXJf5yl8ajf8Qr@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20261106191423.4194081-1-joe@dama.to>
 <avIpEpoCYvLHYl3j@devvm20253.cco0.facebook.com>
 <CACKFLinPK+wR=TMA3zNJDKQR_=HfMFUHPxKS+yhvv9SegZw7Ow@mail.gmail.com>
 <avNWzavrxJSasfp5@devvm20253.cco0.facebook.com>
 <CACKFLikU8ax8-VN+EiAhrn_w+2=yex2TNHPxEYqni6g0BKHKKQ@mail.gmail.com>
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
In-Reply-To: <CACKFLikU8ax8-VN+EiAhrn_w+2=yex2TNHPxEYqni6g0BKHKKQ@mail.gmail.com>

On Tue, Nov 10, 2026 at 10:14:50AM -0800, Michael Chan wrote:
> On Tue, Nov 10, 2026 at 9:39 AM Joe Damato <joe@dama.to> wrote:
> >
> > On Mon, Nov 09, 2026 at 04:13:57PM -0800, Michael Chan wrote:
> > > On Mon, Nov 9, 2026 at 12:12 PM Joe Damato <joe@dama.to> wrote:
> > >
> > > >   - Notifying bnxt_re when DMA is stopped.
> > >
> > > I think this is probably the one item that should be added to the
> > > patchset.  When DMA is disabled, RoCE will not work at all so adding
> > > this will make the series more complete.  It may be as simple as
> > > calling bnxt_ulp_stop(), but I haven't looked into it in detail.
> >
> > Hm. bnxt_stop_dma runs with rtnl and the netdev instance lock held and
> > bnxt_ulp_stop -> bnxt_re_suspend takes both. So, I don't think calling
> > bnxt_ulp_stop is going to work.
> >
> > Maybe I need to make a new patch where bnxt_stop_dma queues a work item that
> > calls bnxt_ulp_stop without locks being held? Not sure.
> >
> > Also: would you be OK with bnxt_re treating BNXT_STATE_DMA_STOPPED as
> > detached? I'm probably getting this wrong but I think with DMA off
> > bnxt_re_suspend only takes the detach path when FW_FATAL_COND is set.
> >
> 
> I'm copying our RoCE developers Selvin and Kalesh.  I think that if
> you call bnxt_re_suspend() before you disable DMA, nothing special
> needs to be done because the chip is still functioning.  It will go
> through the normal removal process.

I'm probably missing something but I think that the ring frees can only fail
in __bnxt_close_nic, where rtnl and the netdev instance lock are held. DMA has
to be stopped before bnxt_free_mem. bnxt_re_suspend() takes both locks, so it
can't be called.

I think there's two options:

1. Stop DMA as now, but queue a work item to run bnxt_ulp_stop without the
locks. bnxt_re_suspend would need to treat BNXT_STATE_DMA_STOPPED like
FW_FATAL_COND and take the detach path.

or 

2. Call bnxt_ulp_stop() in bnxt_reset() before taking the locks, the way
bnxt_fw_reset() does, and bnxt_ulp_start() after a successful reopen. That
covers the TX timeout reset, which is where all the ring free failves I've
seen come from and it doesn't need any bnxt_re change, but it restarts RoCE on
every TX timeout and it wouldn't cover a case where the user triggers
close/open.

Not sure if I am getting that right; maybe Selvin or Kalesh can comment.

If that is accurate, do you have a preference on how to handle this?
