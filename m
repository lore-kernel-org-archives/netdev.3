Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57C45FFC8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587952; cv=none; b=af/6Xy+9XZfVQajSRE6tqKTemZZsJL6LM5bs5KAPtL/tjy7GehQhtWgUMc8LMEDNawvDper8VCAeVfcpHBm/GXAS58K3w38BPnri7zJEk7r83C9gcZfBYTBCbifHErZeWP1PzEfBNOlr8JA9wDEpHiW3ZrGxEroRleIMNeZ5FO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587952; c=relaxed/simple;
	bh=zYg/f6PiMWHyhfP3EMjkG4qA98Ryk0MNjoX+bMB0eBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEs5b0vlCLsKI0XBjgKHUBv9jm9v8HWXShBt39paswXo01zIoNRaYbdgQh6oOCy+WLze+wM4LBdbr7WEedGmu+7R/xttHAK7toQD/7UUBWoEbFceErfaJ4K9yeFkvdpnM66BBBwFrg6SF+TyBlYImlf/Xbgu9MicsN0tP4pLEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=p0wpI8yK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuW34iY8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="p0wpI8yK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuW34iY8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A673EC00E3;
	Mon, 28 Sep 2026 05:32:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790587948; x=1790674348; bh=7h/HLu2+wsYLHJQn9fZNG/I1kfMujPI3
	51k00oQemuM=; b=p0wpI8yKpUwTbCeIObjcNyjWiD2rF3/bfJwwQ+VMoo+PsZOi
	w6iyightYhfycrKlRawvSu+RnAvSwbrF/sSX1EYeBFDCAj/aY1V3wn7XBP9W5Vi9
	gy2i4a8t14rE+YwjsCXfZWElIgFg2WxXs8paDS9tU2rPJtvjFWCD4W1VEzei3piY
	fRiMHNRA3s65vKXZHMmJuSsUNnJrcHndMZnMN4uYl7jnNXpz8wzzSW4jeWjVRCcv
	Gs3s5YiFQJNH4jWLwIBhteObw5WpYyn5+kDgPGpS7msW2DqvMLMG5YrSi3uaQNHz
	h/Qjw4efKLA00iycRJWBCrOHB9q5sVuCdUaEmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790587948; x=
	1790674348; bh=7h/HLu2+wsYLHJQn9fZNG/I1kfMujPI351k00oQemuM=; b=N
	uW34iY8JcnsbA5GhM3UGQOWflTOILz+zIw+KOBKKrCqTdI5q04YV5l+gJsXte+KQ
	S6DEiiZblW/EcPzZ2VXMw5KYg5lcMSXcVcziF4+R7imqQV/Oa0Vv1lI6avzrooQ4
	QMyvCZ4OF3lMe9LCszaCy9wqsVJJX97yqY7NNpYICNQBtGPDRMgTeac+49jzMvZl
	8gq43V0DWkOHIXmFpu9B7E/xF6wQE0JqtWmHyc5dH/iIPy7zOmIMOsTY4M6zprLO
	z8cfqfqSOkt2i6hWHrm5QxFPcOH4/l35a2lQxgKaWuhcoM/pR4atz619UlSplKZs
	ZPZPUDQUHLbFgxIe26FZg==
X-ME-Sender: <xms:KzS6ank1BH9_ZBezJUP1Bfi5l0cRFj-hyvclGMAFIgP8g35FAW8I4g>
    <xme:KzS6aiRyM8gBNkrR6N9LfsdtDUWTW7L7z5n_eQQvmc6tB-x4qtQCru4TH6PlR_6Sb
    9T03eJeOqpIqHYKZg4VwG902QU3Ov-7NMuXUsarysB_eK8rIynp5kda>
X-ME-Received: <xmr:KzS6arD5IRxacVjXhN9a--5wCXnYx6FAY1aeKIGCZNfvxVDhueFBkld7sNHL>
X-ME-Proxy-Cause: dmFkZTGlJrgcx+4KqT3pi+ybLJey6rXCaqXGo23DlUnZUq1lUUY0pdYuyP4f0gg2XmBUFG
    iIO/WfzUmP5kQeoePC8Wv004MfoUdS6qeNkCFWJwqIx1wy1kH5Gp58uEaC6BQcrHaCBNiN
    HL1fD2QrWRzZUraQy4ZG7PVr5STDDZoThL19tU9Rez6g9L8id9mqIOt4hie1Q1CnH0qMqY
    TwOVnoNvk4DMPYwlCF/DUXSf+VBnWWjMHDt/B9FHVhC6z6XMpMwg/Y8xTOwZsCtRBHRf2e
    wUuRrAouXj+u4Yvbvr1/tYfOBvZ80EVY5CzVanHWX4tA9QBmobee+fopmw6HzifX/GE+Sb
    FKqHrxslGUnyYiOEdYYaiB74l6++jedVcWi1RrICa8d5PxP6+b5HDYfPM/bLhZ+7doJp6B
    0p2JJTUlOy+bXm0K9nKnffucLwbzWCCnzVGYDsk12Dtg/nvOhjtvwmRvgL9HUiT7X6MJJt
    iNe0S9TGsuDQEeMEvwpYA3+ng1qU0BfpzZcJ74C1T4SChyHhQaIWTXmGNqP4aWdTvVpA4O
    9B1r4oAK2zDMuJ/9EKJf62InZ7+BaeXY0PDR9Ezn46hqvnvp62+ANQon5/X/KaJGo/79uH
    3M6KQRABaKfb85tBBG3OS2El2CX9LLJhYiaH2U3JHP5g29PPTs6JjcHw7xHA
X-ME-Proxy: <xmx:KzS6apTz1TcgCqn33guJyNZg8dyakdm957GHRkk3TA2KrCqZX5jQ1Q>
    <xmx:KzS6apopwU2xd0u-eGV8XZCVx9Uhs34RppMh0Qe2Q5qr7hZNOZhpJA>
    <xmx:KzS6aryTKJdLVDNONQjZ1TLPr2kRrnHDUSBHZqYGTNMz9yKdfeP6Lw>
    <xmx:KzS6auLYJHi7TlvZ3rtSzcjaYKdkwmQGVkZO77DrkuM9v1_c2VXMYg>
    <xmx:LDS6amSxswG-yeVSswsj30u8ho5vW9ow-YzUnqEQOjH0mEDwIWdh8B4d>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:32:27 -0400 (EDT)
Date: Mon, 28 Sep 2026 11:32:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <aro0KZRO6zkfhiwU@krikkit>
References: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
 <641ccc52-2677-4a52-aa11-e3b3c3c50920@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <641ccc52-2677-4a52-aa11-e3b3c3c50920@linux.dev>

2026-09-28, 17:23:57 +0800, Jiayuan Chen wrote:
> 
> On 9/25/26 9:51 PM, Sabrina Dubroca wrote:
> > The comment above strp_done() claims that if strp is stopped,
> > strp_recv will no longer be called. That's only true if the caller has
> > a mechanism (eg locking) to guarantee that strp_recv() calls that
> > started before strp_stop() have completed by the time we call
> > strp_done().
> > 
> > This adds a lock_sock/release_sock pair to guarantee that any
> > in-flight strp_recv() (which runs under either bh_lock_sock or
> > lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> > has completed.
> > 
> > Only espintcp can be affected by this race condition, but this patch
> > makes sure no future user of strp can have the bug.
> > 
> > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> > Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> > This could crash on strp->sk ("general mode" of strp), but this mode
> > has been here for 9 years and has never been used. I'll send a
> > net-next patch to get rid of it.
> > 
> >   net/strparser/strparser.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> > index a23f4b4dfc67..401e67533005 100644
> > --- a/net/strparser/strparser.c
> > +++ b/net/strparser/strparser.c
> > @@ -511,6 +511,10 @@ void strp_done(struct strparser *strp)
> >   {
> >   	WARN_ON(!strp->stopped);
> > +	lock_sock(strp->sk);
> > +	/* sync with pending strp_recv */
> > +	release_sock(strp->sk);
> > +
> 
> 
> Using sk directly inside strparser breaks the abstraction and that's why cb
> exists.
> 
> We can totally use it instead
>     strp->cb.lock(strp);
>     strp->cb.unlock(strp);

That's what I'm saying above the diffstat. This cb abstraction hasn't
been used in the 9 years it's existed, we should get rid of those
useless indirections (I'll have the patch out on netdev this week).

-- 
Sabrina
