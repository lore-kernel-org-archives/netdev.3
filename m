Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871054;
	b=lpVAqCVYoHpnGkrGRb8M4Sr5mjx5xnxd8+arrOgIv9/jIoJqMPHYwSmDEX5fTJYFbSTG
	 yNTndVacDq49pNfwfhEAlSwHgXK5ZwhpqD2XYJ2PYPwPuU3+f/Eke5yf8TeWOBiqzrEa/
	 rxpfoGN4MSj7f/RlvU/WNEqxfsLyryJxSjESkvweOgFkuAyMItc3YHlunAEJ5Gpzc4b+e
	 Cq5Uvn5f/6qbqrFM+420kQ1qhrY9kmv1hawW5pLnu5XG2gQw/+rapJdj/8wpxi/gDLhFo
	 rpf03fVlMoXD7E+aBRoRCLpk4plzuuRUBv62AbMJSrZeYtWv29MeeiK+m0iT2MksJBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871054;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:References:
	 Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID;
	bh=VNve5KGIAuthZT02sXjYzh8MoaJe6lgnAD7iB574BII=;
	b=Cda4hzpYuGfoOHpAwxhBTSyOMyrhMZYENa489tAvNd5FzP2EuKQG8tYazqtpm8nkqRLf
	 Z8vTjqrNoQywCd38Aiikvz2BgyNQDnspy/O6hE+s2QBoVFvQYYnEsnAn7njeKTYoYX34p
	 MpSjiy+G3tRD2OyAo5DwCvGg64UmRM4Ixq6bFR5CZTnRMLTsZf7jK/BYMf+kGaNnrNyRa
	 id334v/8AeKbtlVNO56PTCFOvSA2DSGpYC249Aco4fpmF3dstSNwIooAZFjZJiA6wfr4z
	 uMXSn+DHOyQYFZsvKYLvZMKbgx0hhkKWut2RkhKDMXsWHYpBeIhdIzdftvjISIvZgJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvosburgh.net;
	spf=pass smtp.mailfrom=jvosburgh.net;
	dkim=pass header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b=la0aPThj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=crcVhFPz;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C0606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b=la0aPThj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=crcVhFPz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A9031D00167
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:44:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 24 Oct 2026 15:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792871051; x=
	1792957451; bh=VNve5KGIAuthZT02sXjYzh8MoaJe6lgnAD7iB574BII=; b=l
	a0aPThjI6RWjjSTpUs2BOkMWHpzBAP5O4RTNVVN3HfZBa3tOaCAB2bkZemykpyMV
	17/fm5p3/V425S2p4KglGstOau2kWDP0p9B5nQqlDE/1tAb+DBz0HFZnxF9hbVmr
	EGj4XgE5gC35QcQn9lj2tCsTO+SFySQvOZ8HNedepHBTKY+w6Rcw2MYM1VuB/QZ+
	oZ6YABv+TBFVvpOzSzy1Nz9sX/zboC2peRAL4D/8OSkdcl14s2Zku0XgyXGaqG4U
	x5TnsvA8iZA1R/JCncTpvTv6svEvpO1PZpiOqcMp7YwGFTq3hTExaj54b9fpf6T3
	S+F5oOhVV0ToeSvUcouAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792871051; x=1792957451; bh=V
	Nve5KGIAuthZT02sXjYzh8MoaJe6lgnAD7iB574BII=; b=crcVhFPzwUL+7HCbv
	Wel6ZJS7T+fS8caD+mvMIqwxHi5okhpGY2lcoUPKNwbpStgnLAhmAgGMcjLOTGbi
	FF0pLeJ8muPVlzCdspJtrD71k7oljMuf+n8xJ3PPOZ2GurgCXd3uXpI/DV0nDOpj
	huuxHAIC2QXZ86yJeqLZiI96PY+jiiibfTTIkHjhvTq8re3DXqMVFX0uRBfEwu10
	UrUYWzfqkhoYqfnnmR8XvJxZMx5l+NxA9Y7ncRvvE7shxUa2IxuHFI0SKbd5xoWr
	y90dGOT4t1BNA1H5EYcMUVGHLB0yN0sOI+K8kY4Q+4AB2QBynZjYk9FamCYwM35s
	0DWZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvosburgh.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792871051; d=jvosburgh.net;
	mf=PGp2QGp2b3NidXJnaC5uZXQ+;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LJ2+tf6ym5qrbAIrSVFJcDsGbfdx5jhmTkzg9Mp5OPAuft7
	P5FW/qnQ68NxSODXO7wUo4DrU6LZzIDN/ChxAtQ46xYOSxkKb0nbkUaY/uXNDl1M
	zo1o5yRdEBaEXede2zJbSZ8MgST9x6vOcQ9rLyiRtB2MkGwyHlDi97raX6hyJTHi
	6jPo7YcKO7IY20XsNJ3Q/AYI7RgTf9LSYrQ6O05Bs5cOrBZLHNb2s6oyaVejEoDO
	MXp45+fn18xC3Pxgp+0TmZ5aY/7ZK0qYXSxnoZhWtQL/8MBOdnfXCAiihO83gMV2
	vkuFiEuTtzhokLIIGu4fZD1GcO81cjugmJxbu8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,comments,content-id,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZP27g8CW4T9EEksYMUlHF2RVNovZ7TvokDdnh9tEcVg=:Vy9/HrrWfWpBx9RZsr0Y/55UiivdM8omC6rb5Ctgu/8=;
X-ME-Sender: <xms:iwrdavQKFY4if1XJY6EZW4RaPaqcyHMvf16_x2txVCG_gZqRfSpdeg>
    <xme:iwrdatXIiI84dnx2gL3axwDWH_zKzd_WjISeYZ8BdGj1Wsaw9MWhIeYInIxAvJYyj
    QJyyKLtyCV2NjbG0RDXJ0Cnt571qmLCmVfw7Z9cdlkvSLCfG_Arz1TH>
X-ME-Received: <xmr:iwrdapQZr0_2D5xBtDO8C5TugiSCBjYXi9lpjyRDUrKyXRaEI-iWUXlvqv-FRyg0U93TsRtlud3kw-mJ10Mso_MheByJT_b96tFuPomJK3AuUyJZSw>
X-ME-Proxy-Cause: dmFkZTFsb0VTSBmiSgPCPgaC2z8w4eftQRB09/wLNtfNEq34NWhAlLx298hximPLMVSdct
    5Ze7xAdVKcd9qlF9S6hu3SAofzcP5OMxRlqFh750dk0zcEPCicczI8e27INAKDmYWdhLgL
    +hmwccrFBb1EMF4gPqUysjD/afgc4XwSoexvC33kbg7wvyTpkwBkRzkbKaFXdxc2r5qwOU
    2Reji6Y4ISVDjbqE12Sm2tQmN9Axrmls6mi7JeQMC+cAAzmgP7rY6gVBGZUFJjjtt34UK2
    C+iR9Aw4F95DmAbdjh6KFK+1S/n155HkCUzQSxkIOBQd0c4urR2jHNTtwMCAowN3LEXNZ0
    85ZThjhlHcVBTgTmV0RPXkr9IOOjPi/uT+sn19XTvQJWRQCx9gN7xFF0IYFy4+KGCKtmPh
    3GWbTSK9HOZ9W66rNw46hkTwRRWMfK48bQ0Xiu3YnGCGxy6CpTz7SmDFHF+Pa0ytw/jSo+
    a9DfDy1GIVzWkgPg0udOrUSB6n/njBkkSaDg0Wk1TRh4FpW8JMW6x8JXqVrEqOY4aoNYge
    a+dZ+jByw/S1MHP0cHyZOFHpbuVfdKVcTvpQ1/gz4jGt2Mxd4c+7B8p8y8NTynzmfJRCeP
    OecRLjeZyEIlEIY/BXMTz+KPEhTwNi3CXIv3hHepUT6eFREngV41TPfIzECQ
X-ME-Proxy: <xmx:iwrdal3dbVuZovVBZkFHBBxBm8G8oiBCt6LqKNDalv-vWWR3R4GO-g>
    <xmx:iwrdapemgrbCZjDYC3EhZ93Gw4rwWAM8ZuO0Ruuys9CMcfImHkBSjA>
    <xmx:iwrdatMPg3WD2T6ZUcJPDf16RzMg876J2OgoYVBNBfnPyLttI8RX_w>
    <xmx:iwrdatW3Se3J0QvhRcnk9U0RsDkpgeh3QhwnTin9es9iIvI8_Dh5Ug>
    <xmx:iwrdar2Fvi0PS0M-wRxVAtICgL7sK-A3PS1ZhqBGnXKzyDhxamiL5dM->
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 15:44:10 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id C58181C0437; Sat, 24 Oct 2026 12:44:09 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id C2F281C0379;
	Sat, 24 Oct 2026 14:44:09 -0500 (EST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paolo Abeni <pabeni@redhat.com>
cc: Hangbin Liu <hangbin.liu@linux.dev>, luyun <luyun_611@163.com>,
    andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, maheshb@google.com, razor@blackwall.org,
    netdev@vger.kernel.org
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is empty
In-reply-to: <0d32d785-d16a-456d-98e5-8e952d09ab76@redhat.com>
References: <20261008024031.16224-1-luyun_611@163.com> <asoItm3JVXSC5GQ4@fedora> <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com> <asyt2Gt4LzKWWnZS@fedora> <0d32d785-d16a-456d-98e5-8e952d09ab76@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Tue, 20 Oct 2026 09:06:15 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65060.1792871049.1@vermin>
Date: Sat, 24 Oct 2026 14:44:09 -0500
Message-ID: <65061.1792871049@vermin>

Paolo Abeni <pabeni@redhat.com> wrote:

>On 10/12/26 11:52, Hangbin Liu wrote:
>> On Mon, Oct 12, 2026 at 03:20:09PM +0800, luyun wrote:
>>> On cost: the fallback only runs when the array is empty, so the normal
>>> transmit path is untouched. Inside the window it is a lockless RCU list
>>> walk with no new state; the second pass and the broadcast branch are
>>> there to keep the array path's hash mapping and broadcast_neighbor
>>> semantics.
>>>
>>> I would also like Jay's feedback on the preferred direction. If a
>>> control-path solution is preferred, I am open to working on separating
>>> array preparation from port enablement, as long as it does not change
>>> LACP convergence behavior.
>> +1
>I guess we are not getting Jay's feedback anytime soon.

	Apologies for not responding sooner, I've been traveling and
missed this discussion when catching up.

>I think a control-plane solution is highly preferable, even if it's
>going to be a more significant work. I have just skimmed over the code
>and it feels like removing the rtnl lock requirement for
>bond_update_slave_arr() is doable - i.e. moving ->all_slaves and
>->usable_slaves under a new bond specific mutex).

	Reading the patch and subsequent discussion, I tend to agree
with this.  In addition to what's been stated previously, the fallback
method has the disadvantage that it adds a test and branch to the
transmit path that will be taken very rarely.

	As I recall, bond_update_slave_arr requires RTNL only to prevent
anything else from altering the set of interfaces in the bond while it
runs.  It doesn't need to actually made interface-level changes or send
notifications, so, I think that as long as the bond_enslave /
__bond_release_one paths synchronize with the bond_update_slave_arr, it
should be safe without RTNL.  Using RTNL for this was originally easy,
as the enslave / release paths always have RTNL held.

	Having a mechanism to provide a lighter weight "don't change the
bond's list of interfaces" knob might also permit removing or at least
narrowing the scope of some of the other RTNL-related weirdness in other
places.  

	All of the "rtnl_trylock run in a work queue" patterns are hacks
to avoid deadlocks, and if we can change any of those to be synchronous
and deterministic while removing a trylock that's a good thing in my
mind.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net
