Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681010;
	b=x9leU38U3wHKMOrlt6/0BmBnHn832ESoXIc3RHtMd3Ej2lE6OATBf3y/ykIYRFD088Eh
	 RfKt1SAjNPcPv/SM1P90wcOwHWhDlvt1JDOpqtlZ4vfPge2YAHvT4oq5XqHtDP4UrXa3C
	 dGVvE7c7lt/LCWmA4FQHpgVK0vTJLh9TS+7QJPmIG4CIqqQvlCwHpz2ZdtgWxEpl7cv9I
	 RMxGIOxsSepBwK0lx8UAD993ZGWxJVM8CXMMeVjaZS+AxFUKlzzb8kiJWnEXDp8IGeRim
	 U/FZcd85YDe2mPzSUO0IHmALyoSfh+sIV+PKoPCIPhE8vHd8S67jFq4PkmRSIBtNkgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MX6+H6HoEBe+UOfH0T16WLp5b6MKq0eSYY5BMOhvft0=;
	b=CIgyLusVFs4dsCq+CA98kd3QRzU/EKcJV3mb3ToeLJl6uFGm4YwkGo9Z4vlLOHQykcib
	 AQTWvSAf4aatqSBffQtrVXYVts4qKEW97YarQOvZjRvO7wZH6vl8P6aj5tH8S9FQXcKN6
	 XjYcLJYnd5pXlMmJ/6EILpDnsghm8LibQJHN9ioTVkQZe/aClM0NJGiWdnMZFKSGmohc8
	 jGge6Gy0PUu3FV+KQfMNLc/6if0cRewuARgI6s+SnINUA/0S+X76alXOrUyOCK4pFJ8WC
	 iAwVg0WwINYnGXwukqKdTtmO9jdRNkf0bE8YguQ5EIzF81IdUKso4JEvUMBKguIF4UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b="V27M/H8Q";
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Tbq8bCmS;
	arc=none smtp.remote-ip=202.12.124.140
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEE606A327
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AEEE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=V27M/H8Q;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Tbq8bCmS
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id D43AB130011C
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:56:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 22 Oct 2026 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792681006; x=1792688206; bh=MX6+H6HoEB
	e+UOfH0T16WLp5b6MKq0eSYY5BMOhvft0=; b=V27M/H8QDgfwwcB+hTDnncS3wJ
	c0EdDb3jFouSxn8drrWGg5u8dnGEIGdbtlNJCv5zoY9GjO9xG+79i6ZsSyJxiko4
	r3uTbTXOYPS1lL/kb4ya5k0njyImSQ5TW5RCiETafXU7syIwhK9xwRyXpUypXDjw
	l4tDyfkTWDImbPAK0awbplhRSzrjDrAG2sW6CLx2EXW4uSRsR7RAlb9pgtxD8osw
	1doukEUyYVvezb7/1YW22YfYM4Uyt8i173TGBGkRNHUMqQrcmYXI9l6smkwI07qt
	hGBA1Le4HV76oBiW3m8DxDzLpu0YfRVzRHrpopfP6Udg+v2HQ8KH2JS1iwmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792681006; x=1792688206; bh=MX6+H6HoEBe+UOfH0T16WLp5b6MKq0eSYY5
	BMOhvft0=; b=Tbq8bCmSp4kICVjHRdd3rRxIkKa/NHWTj/bPxFPPJAKTtgu0Sy6
	F+Ogn5/fD82I8ckxZbj+3y71PAFG8NzkVXZnDE4ee1nOtXpkhF9IiX8zJh9CO0j/
	euOzBA+H4eE5nc+B0YT/JK6soMeGkZAb5DfIBmPyVqFlFCL1lmf3hfZjUsVLsDPL
	Op60xdU0g44mPryeUIYg88xiV37C8RSWZvYAq/NbuIEVI4kaB8wo3eOBJaidxZMN
	Rws8mqF6ZA7U/2C/x60it85P5e6smrWTl0x/659bZjkGUCeGD3E/a1yzr+EwzZI/
	fv7bA05rcLVCToYhIB4h4QpTSo9JmLsR7xA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792681006; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PsKViGWdQlCwNipc1CK9Ccaw3wVaD1FI7nFQCrREoI4XmjD
	WIj9iG9juXT1qEgdj41+rPdoR677Ud+jcAZCsz0eafOwlZUKw6UWMLGgPiR4l+Aa
	4gZGHZN8vnY4zYtLy2z5+AKS0Jtsidh7Jv9a8k2zW+OpvLEZ98h+ZeveuNNLIY41
	awZGueT6UPmly+yM7pHgERmNEfTwI6TOyOMAyEL6/AGpNwLGKnYpFLIV6KStD1u0
	cPtFUShqaOus+O4xA6GkbRbp+9bnztotUZuw4l34O0FqNQ5tv6jQ9zEP/90xpOKC
	lwb25DdsGVGMkAYiBT+x/SlKFwzsFz9t8ZRb61A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:z2nn6qJapQB31p0KFDZyLR2mbNAVStuvCpCyDPrlsFs=:joggunysFwrxvOMY3aUgSttH3u2PCn9OlWS8Ris1zVc=;
X-ME-Sender: <xms:LiTaahMxdrvNHymxO0NsUZ0_P0y3kW8ym_qYrwnmD1f48rfl4MRtIQ>
    <xme:LiTaaka-WtTzOSYyyIvSbkTLE5TpDL9s2bBZeKOQCeuZEwysqkfz2KLAcdOyV-7yt
    BoKOAM4ZhM5YwS75rNSg0D4saWQ-jtB0c1C9L6rfpf3A60VIDE>
X-ME-Received: <xmr:LiTaalsr3OI3Q7gsMKu7dqW-NIMQ8JX51Ad3-nqgt1YXq14Lw20EUOFu07XvCgXxi-f6298f6e_6EowlL1I>
X-ME-Proxy-Cause: dmFkZTFfugBAqt0t1mXLA0jOd6hl0fNDx7CNpx9XZshTBhYyWscZbPZxzFsfEI9iqR/41e
    5rEztA0HY05G54pzmQLtsl7yapPhUZdFZudXxPsKxsVvaQP1hUhvuydkZGgDWqqyGdNarM
    0U2RKOGnZHludhI2nZHnwSYS8A3ofUoKiTTjxqmkizSTk1wMLzYwBFjeblqXzIj2KXQ7Nh
    3ZvtqLIiTaP7cXg/FWntkgxuNE/b9EB+0Qk4Ts78MdsT8PeDHYJXUYiVx+3DtVjak91h5r
    FrRrutJBeW41MrPWDaTxghRmaGUQLePqvsndf51/HwS/AGdReZB3ogLoC4fkm5YuVvFikB
    YUN2/omvW7PkfCt1aMLRw6u1VoCVLoZPv0aPfF3E/cUHHWCDLGSnplcMtFkvBu9dNojcvx
    SpWPk6kAsZI+7uz7TEntkpkiwKebWJV8aToplf0kHLnMRaZ/dF3Uh4n96XlC0v5qnuJBcp
    XQShx3bnrqxylRnlc3qET1rtmtINcND8L/3kfQmEOU+wQhGgbLiffhpgMG3DQ5lS23hU2i
    MuiJek7ETaYVIlAi9u/V1AyeD0RHm7c09ub599nl2rfhJ0CXCufqUuI9H5FvU7NUeV/DJD
    5dqHXVzwQIICdJyIExoctKEpFZ/lzl/RhSuLnvXumgvIjSiO9I7fjoMwXaYg
X-ME-Proxy: <xmx:LiTaarqOzl7iOq1Ou4jvcCIFDhW4tymBhfoKpTbX3AVAWQ-sxjFN6g>
    <xmx:LiTaatRZXckbt50COecGlleq62U23TO_UGyGf-bwjPIQ8Titfpc6Cw>
    <xmx:LiTaaoa-rFh1f3-VpM9Kc2avq8A1gSYq_Wkmo97LscQVCidVhsC33w>
    <xmx:LiTaam5oAzNZyuMpKL0_MtJVg0LGz6u9pc6BLI-P1L0Hyzi9AguvxA>
    <xmx:LiTaak3eBp0wugpYfZCZVXHZa7vKwRmDnKVwFrnu1PTxhaKXtaKAq0Co>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 10:56:45 -0400 (EDT)
Date: Thu, 22 Oct 2026 16:56:37 +0200
From: Greg KH <greg@kroah.com>
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] net/sched: act_ife can emit uninitialized bytes for zero
 metadata
Message-ID: <2026102244-cadillac-sworn-cee4@gregkh>
References: <20261022144739.61342-1-shawnq1@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022144739.61342-1-shawnq1@163.com>

On Thu, Oct 22, 2026 at 02:47:39PM +0000, shaos wrote:
> Hello,
> 
> An attacker with only namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW installs a matchall IFE encode action carrying a zero-valued skb mark in a fresh user/network namespace. The presence callback reserves an 8-byte TLV, but the encoder emits no value bytes. The resulting frame contains six bytes from a freed kmalloc object previously populated by a different UID.

You sent these all to public mailing lists, and you seem to have
forgotten to include a patch for them?  Please do so.

thanks,

greg k-h
