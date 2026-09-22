Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318F306776;
	Tue, 22 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088872; cv=pass; b=t7wCv55CXSNmfILOLNm2DK77kFfNtl+vfSNFtIbhXjt94oGB4zdLpf2ZyRfmJl2Nk0nvDEvoU8qEONvUaxRuMdJO1XxTAsV9o8jfZRA8/Av8RI7WocRx9aEuOkNErDjklZo0AHhbb32DhgamvkQYkze8iVs4vWuuRB6OsQNQHdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088872; c=relaxed/simple;
	bh=vt+mWNUJ/FcDxrT5/Z434rZnwRK1qBXsWU4+bkU32Iw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=txnGq7tJtxIJBDP7kuCWt/4gvROnJgY4Ewhd2U6sIlGimlrtgUZcwiGZ/SV5PDls18+yz3LahM9pLYh9upaCxY6hFE/E5Dry2pUDbLl+j/TlriFE/ifpJfjx1wcgxtxtNL2cZ1e/OkRdlpVCCdtZS96JCVmXa8zl/qBI0jFuApw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hQpCmRBR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hQpCmRBR"
Received: from fauth-c1-smtp.messagingengine.com (fauth-c1-smtp.messagingengine.com [204.75.18.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hq35q39fczyQq;
	Tue, 22 Sep 2026 17:54:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1790088864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0GiNNz7mvXA6xuheXPBRxDg0LpQpCzQPfazm+MFnlQ=;
	b=hQpCmRBRPkO1lnjRQbCSLsOAIeVHDbpzroswlW0jjY9Pwu/2we1ykG7q8xbKGSVnAfdsBD
	GfltrlWKkzkPfuXkvuUdtVI8sfKUWct9fPlly+cXoE4UZoJeEr06SiLziXrw+wx4bjEwYb
	OHNlEzi1pE5Uj2+EmISmCmHe8YQKKE8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1790088864;
	b=OzIp9i+y6MKmaCKay58FEkapWMtaKXCAh+p5pZYaxAXFhVfwBtHLpa6FQchxsOUnQWk1dc
	4kZ6ewtyFi1sE3piBjPoC2yX2YoAJMqZfs+ETG1NvCITaxy2m9GoMqQXqK7eW8PANaF8IK
	a6vTItxAVTACgkDIq/T69QzkES3wY8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1790088864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0GiNNz7mvXA6xuheXPBRxDg0LpQpCzQPfazm+MFnlQ=;
	b=bKkwHvlOPzrWTnxsmzfxfjGrv+kdeoWQO7DFfIFPEh9tEr1jTkp6Ybh4k3Oji8jSM5nLkb
	m+E5foQE7LPHFfUT3+02Y9GiABNA9ZsICriyPTtoJKIhq5tWzEY37p0OquxZnlHwFl2Lzu
	H2J/jarebpztIGyz3fTtiB3tFdf0jP0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9A38A1980047;
	Tue, 22 Sep 2026 10:54:22 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Tue, 22 Sep 2026 10:54:22 -0400
X-ME-Sender: <xms:nJayahOoafvGRBHnapWIyTJk6EhrmhVJY0GvCoTm60wkzaZGn_c4Iw>
    <xme:nJayaux1EEDSx5z2uUL6LKtq4wLmKBLayvDqdFnN2fvuYW7VX5N1W3mRdMLdoiZ40
    OIEyOIr8gKynWfvbkndsLOzu5snXRJ_tVMVWXru4eGmJOA5ANdBzRz8>
X-ME-Proxy-Cause: dmFkZTFHpedGAVLKiQnrNYraarc+m8y6pLFP5Ws5yDrx6JiPDe99pKJ36EE4458D8owMzI
    CVyo4xyRD/1B3H7QMoDwJozOc+q/Qd0uLw0fzgf+wNbXR7DBV6y68OpQi/yydjLyfs3u2j
    9ub+qnoI5s1SO7rmds48axDjne3beJ7ZSCdGoucQ9oqMX9AhRyd/5Wk1qRDJAg6SYH6B78
    ynBy9qOdx+4dqAHjn76/cFsXf0dY9JupyHdpSRkc2JRH65rRxREBrIRGKsa0HaQZ+1ya2m
    j8Ryquurp9LnkGsEOIW9eTjSLyAN2uq5fOFQxiRf//ZisjfE8+ttENVOKUvTh8JumdRSLj
    p+V2YKSBbxHflVNgbuG3pGSsvZ1uhHJkUn8Vxqq+zjf82EI7Cjz8tLP0s5ZvPlJUHwSGCh
    pfN9xT0fgl+poHmSbIdOAtNVsuUpuFyxhLaM2/BfsltmkEo/IUZVYBkaHk0+y9F9UBlpEg
    qV4CTCisVOl6Ujz6Lzo+kwyBYVLuCDgMWyLRw05vlu3cRzm6QYkkIRuqkU9LFGpkAz+2Hc
    Qye07P78PbHmTjNdIeyyX/peVk1yqCmoAl3ZWNsVld/58+wdy3AHFb2YAba32HcCuB71xH
    MHNmIHKRQpdAJmfJTPH/Ni9E8t4LZeQCIkDzRBIMyePRFtGu60aNXJg6zGYw
X-ME-Proxy: <xmx:npayapTb__p_DydNxb3WN6NoMrFnM88L_Fnpa3c2v7WL4lxTvMZUcQ>
    <xmx:npayahJgGtZlTJtQfoOd0qA9wiKp3saf9VLhoRc9mB5Mx4fVdgd_hQ>
    <xmx:npayaq3MjoMpyT20e6fEpDiQmW5LN-38-EYKJuRpisdiWp6JT7lkUw>
    <xmx:npayakIqiMXo49KaBxMDixyAp9w5j9_CtFWIg4-oXLOh9XwbihIPXQ>
    <xmx:npayaqlrk6tNoyC_B_CpQ4aBKPvFqbLV33GpgSXznrmb2MXaV7Y0l7ic>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1BF8BF80089; Tue, 22 Sep 2026 10:54:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtmlxWozq_rN
Date: Tue, 22 Sep 2026 17:53:59 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jeff Johnson" <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, "Bjorn Andersson" <andersson@kernel.org>,
 "Chris Lew" <christopher.lew@oss.qualcomm.com>,
 "Deepak Kumar Singh" <deepak.singh@oss.qualcomm.com>,
 "Raj Kumar Bhagat" <raj.bhagat@oss.qualcomm.com>,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>
Message-Id: <ce12d73a-ca7d-4e89-9c88-53029d58260a@app.fastmail.com>
In-Reply-To: 
 <g63vg7ho5al6f2hfxbgssrisnjl5ui6isxlrv3265ocatvdmay@anmhz3vcxcbo>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-4-27dd80d841a0@oss.qualcomm.com>
 <e7e8a499-9e89-4efa-a99f-18ce7dc37ab5@app.fastmail.com>
 <g63vg7ho5al6f2hfxbgssrisnjl5ui6isxlrv3265ocatvdmay@anmhz3vcxcbo>
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Connect to the QMI server belonging to the
 device owned by this driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 22, 2026, at 16:30, Manivannan Sadhasivam wrote:
> On Tue, Sep 22, 2026 at 02:43:05PM +0300, Juha-Matti Tilli wrote:
> > So, I believe the patch works.
> 
> Thanks a lot for testing. I asked our WLAN team member to test this series on
> multi-ath12k setup and found one issue with QRTR_TYPE_RESUME_TX. After fixing
> it, multi-ath12k setup works fine.
> 
> I'll submit v3 with that fix. Please give it a shot on this setup, one final
> time :) Appreciate your help here.

Is this issue perhaps related to this (2x ath12k):

ath12k_pci 0001:01:00.0: dp_tx: failed to find the peer with peer_id 2

I managed to switch to 6.18.53 kernel and now the regulatory DB issue
is gone, but I'm getting this repeatedly to dmesg.

Yet, despite this issue, I see the network and data flows (with v2).

Also the other card gives:

ath12k_pci 0000:01:00.0: failed to pull fw stats: -71
ath12k_pci 0000:01:00.0: time out while waiting for get fw stats

...but it's lacking antennas so could be related to that.

BR, Juha-Matti
