Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166E4AE8B6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466006; cv=none; b=Mn3ODrYKPkGs6AsyxZNcQTCIbYK+4bZ9Xqb4SIgLgktHcSxVuTasXMhEPkqsjYpeSa0Axvb5mUph1J/ji22LvmPFOwbrZMMDtBaJts/c68CctlS2BWtU1fM5adtEMGZ1MwqqaUuC7FqkLgoR8QMaskES6lsjX9yGdA80jFfLk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466006; c=relaxed/simple;
	bh=i5DlOW+PyCMo5gC8B63qQaeCNTghqUUh8MRZ01bLvxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUT6KdYKnZO/70BytabD6gOMUrOtnx7tfhZ7RwP0PsfB2M0jm23E+U3BWH1My66xr4pIMdm1cPKI2Y8CDf8/Uf1/VMh3SIiYUG3iN/hvW0wYoTlQxEF8WdU3wWC4qeqrPa6oZpHjq//WXclnW5MAKDtAPxEKjguOT3X30AE1CjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eAQb4LTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAszhTCY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eAQb4LTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAszhTCY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 277B71400100
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:26:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 09:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791466001; x=
	1791552401; bh=BndLtfGqitJar+jheezYgK+fO26ay5IMvxPuookmzjY=; b=e
	AQb4LTBjBWyJLJ1ASo3BrIaqucY1JLYEmxGfMkabQhWZt9c2zxvfkCp3v2rV7Bcl
	jGgeLXePw6gf/7wM4FzXwvsuUOCIxEfqON10luxHixBUoto/vg7Ni7nLDGAF7ppm
	UYE+tPNV8xadpolEB7vn8U+Y5IviAv28DPV5ucXBwbv5x/KFEVW4kHSoAw1fOk6A
	hUdgvNYvVJkCPCevSJS/mtKGc/UAX6mxKYPlAuUHyQDLvopAVDyIfEf8Xb6j8wOM
	KUwA12T3ncg7W8T5sXvLCxpb7C4ebcJ2ljHpxTcTIdc1FZk5PDSJLqZiM1L72Jl+
	LhFoWAAqZ7+jqTjbd9cJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791466001; x=1791552401; bh=BndLtfGqitJar+jheezYgK+fO26ay5IMvxP
	uookmzjY=; b=gAszhTCY60PyBzqXQAQftmwM1AAo8CB/POzQam8baiZXmVdumgf
	c2inuTzdxp/GEYz1rCNzBJNhmlB1+9urJemdBEBCOHC9E1LyRjaI/2pv//nrOnbf
	hiYbeDIUmZBMoCYjFdIvEdAMdppyU+PAfDp8zlB/0rdC6RvFoO367q93s23tUaU4
	1Bn2mKADp99oI4ox5Beho1hbfP6ASi6Suc91LMgzBRN0QbyCHQkem2yTyG8aywV2
	1siUffb22PTMGHnrcjmvu/5xBn6eg/d/VjlFRkjnV2EgudCkxDD0Z0RkqqpXc6o8
	lkbViNhcqblu7N+xN2cpQB7e/CyVUxcatPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791466001; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:cgbTkNDoMqhG6SACltRk1y2VDK7YBa5h1CzmkyyFYjC5R4P
	ZhEY4TzbJDH8OZ9wuafLbXasCRb1Z+8oOvrIYBBegsyadBqNbUXysVHNs023VyiG
	1a9KmSdWWHwaeDDUlm9WDPTWZ+RcY7/2c9Fc5XxVgDmZItCST/ZxEuHFmImDlLNQ
	z6ScM6+VB9Ynd9lXdDw8oF7j4hsEynzzn1UqBy/pyzgIruEq0UfG1SYt+rdBDMsr
	UY8S1OvZhftXjnrjdgvp5WH0SgKBo61vEAJMdfwp0zk5xGqhf1km2ovk2xkxOphO
	jJq8XlkwPgcYqDYj4LU9Eq0JIJl87rpDb5+0GmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6KUpLjbVEw/t+FvVx97O0BprUWv6YlDLxUp09EmPaX4=:i5DlOW+PyCMo5gC8B63qQaeCNTghqUUh8MRZ01bLvxU=;
X-ME-Sender: <xms:EJrHahHwVUQ4Nom_yBqIrySjml4uTUSsO_LvgT08eGnK2DO6Dq9S_w>
    <xme:EJrHasUchjSO_JLbzhvr9eWfQGHG44fjfPaZVd55AN28-DHuoq0EamtvB_b-UW6lS
    nY0VQyRnStfyZdqqcNmJ2AlEZuDlbTzZteK2Z4qpItMrJGcehdHxgAoSw>
X-ME-Received: <xmr:EJrHagw02Go5T3JOOYhRfHE19NFNWakS6akcypVJl2iKsvFVojCq5vbFVqQ>
X-ME-Proxy-Cause: dmFkZTGdm66rMM8HSi4pjf3vW9gJ08guhHFQBuryFS3hYKOC4ZQfU40xZo9ohy8g3Y/Msz
    kJOZDBGrX7bXL5H+VYSLF2JXOvp58+UbNF5WwYnRHTlJm6ONCvkZxDk4Ya4h/SoqnbMyvs
    KLpNmQqcjJA7T7WepBkk1zjfDf6ZjnbDClFQL8KpKdkXIQ7TVVTxnWFo9uMWqWYLdkbe4u
    zTHQpUCvxeTeASpymN94YErZdNo3O8u8lG7HXNnoIdHAZnSwT0neyBGecdE1fF8j5XMFx0
    Ei+GQ2oa6jBbB0wLqU5M2aVelnYXElwbWff9QoEzPCkASOClvAmUqZpUuRyTGvdkWdOkaC
    WWXkbXUFEGTePQvDVh3+CZ/KjKepRNadaZ52IbkYQRd13uu76EMFXOByuqXCi5u4PpVG7G
    lomJ8opcbco6ltFdydcfex6xAE23OH8DMYfgQz6n2tuMNxV92ysLYsF10oKDDyepEZ/MD5
    saAE0IwKuwkOoMNJ25//qbOg/xj/rg+VNab6I0/dabPs82m3+YBEiBF4d+2jJ+izCuhM0U
    Z+ZaloZYdASzBJ6FLx0qjkXzVkm7ws2eZNjF+AnqiqltKEPqddLjlIcoAEEGzJSiWXn8Sj
    Snc5SmCXEaK+UtoOrN9D0NgOHVGRlwbWtFKRkHI6UZ6Cczgj6ArOzl6pvSew
X-ME-Proxy: <xmx:EJrHaiM6u0eaLB1CdYwlhENwItYtICs_DWitLBlpRNKHqRoGGt-WLg>
    <xmx:EJrHap6w_ZymwjQffeUchB3dobqvFSXHzsObV9uHSFzjJGqeLeLh9g>
    <xmx:EJrHarMS8jdWrD6ww_v2xUJfuEuX1EhHFuBkMgqUxgk82a49qxcmTg>
    <xmx:EJrHavl6d6F2vRA8otYdjiCG5hMlw7KDJP7kkJD4ecktKYxTcXs91A>
    <xmx:EZrHahyooZMIEJ5HsmkY2zG-HKL2OpwWGTUx3BfZA9bTX0mz8BUa8THd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 09:26:40 -0400 (EDT)
Date: Thu, 8 Oct 2026 15:26:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] macsec: ignore inactive receive secure channels
Message-ID: <aseaDtd5ys5Fom7e@krikkit>
References: <20261008082612.350120-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008082612.350120-1-tjdqudcks0424@naver.com>

Hello,

This probably doesn't need to be called a bugfix that goes to net
(2554c08e16aa ("macsec: check the resolved SCI for duplicates") went
to net-next).

2026-10-08, 17:26:12 +0900, Sung Byeongchan wrote:
> The receive path looks up an RXSC by SCI without checking its active flag.
> An active child RXSA can therefore authenticate and deliver frames after
> userspace has administratively disabled the RXSC.
> 
> Restrict the receive-only RCU lookup to active RXSCs. Keep the RTNL lookup
> used for configuration unchanged so userspace can reactivate or remove an
> inactive channel.

Function names please. I don't know why LLMs are so opposed to precise
references to the code.


This is a change of user-visible behavior. I don't think it matters
because this flag is probably unused (at least, it's unused by both
wpa_supplicant and MKAdaemon), but it's a change nonetheless and
deserves a mention in the commit message.

(it's one of those things that I implemented because it's in the spec,
but that I should have skipped in retrospect)


> All three baseline runs delivered a valid protected frame while an
> independent state dump reported the RXSC off. All three fixed runs rejected
> the frame. RXSC reactivation and RXSA off/on controls retained their
> expected behavior.

Out of curiosity: why 3 runs, what's different between them?


This would be worth a small selftest, since we don't have a lot of
traffic tests currently. Just something that does:

set up everything with active RXSCs
send a few packets, make sure they arrive
disable the RXSC
send a few packets, make sure they get dropped
re-enable the RXSC
send a few packets, make sure they arrive

(this would be a separate patch, see for example
https://lore.kernel.org/all/20261001-fix-macsec-duplicate-sci-v3-2-0f179fbe1f2d@gmail.com/)

-- 
Sabrina
