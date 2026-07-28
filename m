Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84A372EFB
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273977; cv=none; b=HciS7KDSKlsLaHw3P39v3fJo+ymnHQh6LSEKre0TnOv6ZZEW8IAJdUBFDJjgDOWOIt6sPdWT5YVuXgQffh8XJ7TkxBucNR8as6uYjmnGBgjZKVEbI7EJX1NYN8BvO69sSzwdrX6POcSn1x4Yzt/Jb4NXLGf7PUDYht/FH5HOavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273977; c=relaxed/simple;
	bh=9MQbcBwMJfqT7bSInPANFHQ8hpyz7jn4FICTtjF/Ta8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIFRNScWFbCB0IkOm6s18ENNFtmu/JYPAioRLYT7Ke7tFajJLYt0cDs3tuh13ZNdZzLvCO7cjxpQCV+fpIDLV100jIpHiE/9ELN8ImnnkFtmXHa5VEzzreYtTO4xqifuvh43OIsH/oTqx1d5obpDKwSKDYj4N8mArCsFI5Rx+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c0Gv0EWW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEmKFlaB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c0Gv0EWW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEmKFlaB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E56F91D001C9;
	Tue, 28 Jul 2026 17:26:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jul 2026 17:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785273974; x=1785360374; bh=Mv9i4rVQEN
	qFn4QakLBJqoQVwhjeQvj4k6hx1tVzooI=; b=c0Gv0EWWIkBD897h0OT9iKaHdQ
	/bHcz0KFCWMR0gtdFfplEKpeVLQ7MoP3wuOYx5mFRSU5IUpkgyar9BfOBxNb05Ot
	IH9olkCUEhz7pmyoeYOw6UO7W2l4wUjiiaVS1Wtm4L1itHr8KU306c9jP/lhcXbg
	XlsmqbcX2i+J7VRROkz2CRbre9xrdXvU2cyQcSaKMo+Sv6orZYmqe3FKNEm1fLYl
	T5W3Rdq9+GO3gaFXPu81k9KLGy/nO5SBTVxu1urL+5SaOtTKzgbf4v4+FiuP6hvG
	mH71sb5nmKNHAhr1yjO8Mah1mZggs5+sAbI5f/Ap1HCzWyVg4wEQvQG2m4oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785273974; x=1785360374; bh=Mv9i4rVQENqFn4QakLBJqoQVwhjeQvj4k6h
	x1tVzooI=; b=XEmKFlaBf6em2pDjyBK2QF8ypCjoCsApsK8hV3PFN0M1yo+5lic
	popKZ6Gth12exXQNfNOQX4CmAMxUUQVCCc7+4DH/VwUVGU6uZAqCLt12Apem8hpN
	MmwXnov2/MN4gSFTZakNhZi3K+LD4ExfUZzZ1wd3vR76+eAwLFaucLxi69l/dVIO
	GYY1N0FgCehy3jEeY5BJlRHPcLn8dDVgt2BeHwECsCLjlPNx8fBGE7dP9YEaSvKe
	TrI5boUVeKsKkXnVbpHUMDltVrOuUMKh7kWwIZbhGf6Dj73B/cIv3ZZIiP6LZTuz
	CGqcPHZ1oSo+getuaUZSzoj/LHod5uQNJxw==
X-ME-Sender: <xms:dh5paiRqDo8NGydMdMI5G0e6MGVFZ8V99dy3M-b1N1SarNcl-3PVtQ>
    <xme:dh5pauxJ3lCGhpD8Q1gzjZ0beRYHvEJVhR3JiwyrUdFQxwhkCEg7xcp38uabt8cSd
    Igs7x5LPjj5v7uLLIxBHwQTvIQW8odn6CTPySpPyZ-YSRXKqROFx4vS>
X-ME-Received: <xmr:dh5pak2PiWBwx7nNLLnn97zU3u2TUSVhVa2Au6y1adYRqJhxkZ-t1TSUHbglBbkFKJJWx8bp5vsrN1osm4BqvFatAryr_MY>
X-ME-Proxy-Cause: dmFkZTFKpnPVnx2BQxThLVltg8I2T/iYmmUd7B3pMj3RiuOwP1DP678IYk1o2D4dr1ZbLZ
    mhEUGf3TkcrWoYbA7sQSFTDVefWbqkLTDb/COLHK4akk7UwbOI+mPzqkur7pNNwnirkA1S
    YrN6oNWuGihv9xxIKmmh6yD0GCabd3ifOV2vUZm4GmCxhAug776RSXZQAb3CGKNbbHcMbB
    Dt8Yfg2TK1qiL22jTKwhRVsUOkDrOSCWu/suwC+pJlkxl1HQA22vJvH0/sioa5r1GGHF7Z
    UFG4SaZ6995ROy86XS3QdgWkRs77dIKVW9U/Ydc4/PX9SkvAuOhNwZ0RhGWM6Yniqz/Bke
    qU5cdBtr1q/DUVuKuOPgrL8su9zwaAU9GgmxSrDqs4wAznFp8Rn0mgIMxo1sKOXvkG1nfX
    /fmqSgMCHo23VWMxS744zHVFkNkhPz6Ri93PYM89LL0OOl/Pg6MqU5W2X3mqHwVIJDO6+e
    Sc364773WDxm8Z36TVYzY08cwA1wNO1YVFfEAQqQixQVPvG0USElEA0wSNJYNFyjR5Kym9
    06E+N0tWCHiqfvaNrneR3V1PXeCz0vb5XgVXnG27BZyRTKpNFG4IXpM+RYJ357RyhIxtmK
    ykq2htYmh6ZnuAZg5Ur8jyc7BTgjpz25Bj/GhDzzQkm+P30rSXvgVyNYbARQ
X-ME-Proxy: <xmx:dh5pas4_bWs9qqpy6OfKg87mG9iSA5rfyHcewEsR7sFEC5wpbJt6Tg>
    <xmx:dh5panV0AAgQOtB6HgOBOiwu6B2qobIo6HnDiJVff8nS9fSTLW7AQQ>
    <xmx:dh5parABRfHcLqmP63QFnmZoZE_yLHxhimFHImL6R_E-LCoGHXsfpw>
    <xmx:dh5pam7rEHDR4f3ROooylxbQk8A-TX6gWWew_JRVnTM7OfBG3TEfNQ>
    <xmx:dh5parT9UejznkOsM3zQFRVo2Dp-AX4qnIJBHcn-cWAeTfUEv4OA4d-9>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:26:14 -0400 (EDT)
Date: Tue, 28 Jul 2026 16:26:13 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v3 5/6] selftests: net: add multithread server
 support to iou-zcrx
Message-ID: <amkdIB64aOXbSCzy@jlhe0197-mac>
References: <20260722203950.58550-1-juanlu@fastmail.com>
 <20260722203950.58550-6-juanlu@fastmail.com>
 <20260727183613.2775fc23@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727183613.2775fc23@kernel.org>

On Mon, Jul 27, 2026 at 06:36:13PM -0600, Jakub Kicinski wrote:
> On Wed, 22 Jul 2026 15:39:49 -0500 Juanlu Herrero wrote:
> > Run the iou-zcrx server as N worker threads, each owning one receive
> > queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
> > test can exercise multi-queue zero-copy receive.
> > 
> > The main thread owns the listening socket, accepts connections, and
> > dispatches each to the worker owning the queue it landed on by matching
> > SO_INCOMING_NAPI_ID against per-queue NAPI IDs.
> > 
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |   8 +-
> >  .../selftests/drivers/net/hw/iou-zcrx.c       | 297 ++++++++++++++----
> >  2 files changed, 237 insertions(+), 68 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 3cab3b4adbb2e..946938371c763 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -7,14 +7,11 @@ HAS_IOURING_ZCRX := $(shell \
> >  	     'int main() {return 0;}' | \
> >  	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
> >  
> > -ifeq ($(HAS_IOURING_ZCRX),y)
> > -COND_GEN_FILES += iou-zcrx
> > -else
> > +ifneq ($(HAS_IOURING_ZCRX),y)
> >  $(warning excluding iouring tests, liburing not installed or too old)
> >  endif
> 
> why not move this down together with the if condition?
> 
> >  TEST_GEN_FILES := \
> > -	$(COND_GEN_FILES) \
> >  # end of TEST_GEN_FILES
> 
> This is now empty, why keep it?
> 
> >  TEST_PROGS = \
> > @@ -72,6 +69,9 @@ YNL_GEN_FILES := \
> >  	ncdevmem \
> >  	toeplitz \
> >  # end of YNL_GEN_FILES
> > +ifeq ($(HAS_IOURING_ZCRX),y)
> > +YNL_GEN_FILES += iou-zcrx
> 
> Follow the 
> 
> BLA := \
> 	something \
> # end of BLA
> 
> formatting for the variables, please
> 
> > +endif
> >  TEST_GEN_FILES += $(YNL_GEN_FILES)
> >  TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> >  
> 
> > +	{
> > +		int conns_per_thread = cfg_num_threads > 1 ?
> > +				       CONNS_PER_THREAD : 1;
> > +		int total_conns = conns_per_thread * cfg_num_threads;
> > +		int accepted = 0;
> > +		int connfd;
> 
> Floating code blocks like this are considered poor coding style in the
> kernel.


Thanks for the review and makes sense. I will fix these things in v4.
