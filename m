Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8D3803E8;
	Tue, 16 Jun 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646394; cv=none; b=b7o59JwsETBCxg6iHf89jrRDKgO3oG2yk80UxlyulfEWP4wq1KtEzhc9HmJJViubBB+XdJ1JUo48jRT+7ZVsiYIdFvkteXRKqST5YjZXq5hQ6ul8ObGZnBIEDh1yU0ZVfOIjIxsn19cj9yeNhEYPcDLGIVnnFrTC5n3tquSrotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646394; c=relaxed/simple;
	bh=Mx4duDCcxWRLdRAnWV/0UrymJjl0JremKBtlB0vFdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZD8TUlJ0nzW/is5ZpPVA4g+X3SFggL/fKSXgdV84yYRLsA3dVEGzDfs7AQ7JDAbKNmVX08bB6AAbIwmdD2pr9nP837JAoWRkc+VSTNhZO8CXc4wcBLB3GuclCK9ZEjsLRwMN4XbH2mdIjJBE1tBQlKmChZxWJVsZRmSYy9c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YdgFNupG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D540oxz2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YdgFNupG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D540oxz2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E1EC14000A4;
	Tue, 16 Jun 2026 17:46:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 16 Jun 2026 17:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781646391; x=
	1781732791; bh=rPpnVY0Dq2zNZyPD/Botdb0mBHG06+9u0FVrtrvzCGI=; b=Y
	dgFNupG4Yr/ZWOU33jgZLzY+9x46nwECxb/jAkqkdGVxR+9Mzgkm31qgpjpCVQxI
	supHzoaqJFgFkIBZ3K8tmwGb9yqMU0noOQr4z+y+BgFDxjy+FRHeV5U1DA8wh5lZ
	igSOvzWlLzUY97l7QC8QESib7/1kHPObmMqNM66qYsaHKSsdwiD47XnjnR9AuwaO
	kLS8yK5R9L+iwurrn7nBkOjwh1HObFqbJOQTQvTb7pY/7DT+qNSX4HAM+mspo5gr
	H/61GfjrvGpdsfUq/NZjiyuXxBdz9J7A3umc9yM+Mh75I1ClRXv5BIBnw/muKAdr
	Gi6bWNqE8zbqh5JzBtCOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781646391; x=1781732791; bh=rPpnVY0Dq2zNZyPD/Botdb0mBHG06+9u0FV
	rtrvzCGI=; b=D540oxz23aoPeNEIW8z84bO3hexPhY5qqENm46NJhDyHmzWsbuE
	P0c9IfWwif2B2Cs6rdvAeAJq95OcsXur5Ux07m5/akyz/pNUhHlHLb0R/cos3WX5
	vbnVVQ2hUQjrkfHz/5yllihp4sZAsXA0xgAX9HfEcVIpfMtxqIic3OiaGP6gheiv
	dfKDO+mEA9/R0arLCpDlFqfV6znzJykckAevMMb7x7F49ch9oVvygnlj2lsuGJuT
	IB6ggLcHzAuN0ru1vCbxkqsoSVnJDJt+gkKS0dOCgMqUB3Wwd1ExCiRK8kt4M6V6
	1ZZjsJeq9HCQhjOS6SiRiY/Pqt9fO/uCiTg==
X-ME-Sender: <xms:NsQxaiP5QFIbmxEUig0Rp2kTKbKsgTYZVkm_Y7Ig4lfujQ5JYntNlQ>
    <xme:NsQxam_9xUTuxrgNB0_NIkxUi9QlnAz2lywnpdKFItKCsEf-CN-yWAOxeQ-zOphKD
    8tMG6Kk71fM2jxpc7IsxRXvEjhDLMIQm3bYEzouyt1ybQ4SNrtRtw>
X-ME-Received: <xmr:NsQxakELE6L7d8iiMOSEE57QipBELVG-1oV_f7vnclOZU-mZ2f6_JNRIFGCsJ4Hpk8Eyksv9KkHA3oYRLFGwkT0>
X-ME-Proxy-Cause: dmFkZTFCTrl9oiWuZssOIg9Q1nalmHPLNn/U9qOFai40bRwYAnEnZAelooU3DK19wS8WGb
    uvYJifBGy8gYZZJpbNCPm8xPn+ebTDnOkFVvkY0oummAMkTWvFkNOT6txljP6VOzUNOUBQ
    VCb34whIzu1Gm0yWlOnvx25WSP2e0riclTA2zJOQxrEWEPTPEnQNdFTJ9FoIGcJXW1eqdQ
    sws2VcNu6D30Qmph7ZMpqnLHOWmh2VEnbmICHcio8LjkJsvji/Zzu86VjZMXgN/StCDv9n
    yNYsWNBFFclBiJ4L0W3Fy6tRhI/ZVD83XmGVaHUnD4T9hEDhBRQ/VAzmU23mqU8FfLwkGc
    vtrjUnQPz5B3FJ7Djne/kBAmghuR6mqMrcbHXH8S8B0TlEyl0PT6JXrAWnfAuwtAbzQsTl
    1hX4zvR/dIjmSKTd6sx6r9KrJMC0JjcE+m8YzTYkxsZFvICXVI0gF06MA/XNRyvDec1z7g
    nDpaQZd0nXos/bt7B8yT8d6q/mqVAg4nVqfNRW7FORe21g8UjgKMHeDmyx2HGATG1hWDTa
    xneskEckCEJhTCZLmqWbuHogdN7I9ZlEEvB+3hN9JMtA8a8MicNjbmHlxhlfbrNYDCNgYa
    DHvk5J5M0v8vhwswXrrHFkqiOTCUm0BU4p/Wfcr/owevJIBT0P+iwn/oFGMg
X-ME-Proxy: <xmx:NsQxalhBlp7N41i7XIMgVS-G9RldA5uw-aY81Yr5tcj20FV8j1jSRg>
    <xmx:NsQxapukSZvYoU_FyKoHQyPzvOXdIeJfTjum0s4Ad1vMq__rv6-itQ>
    <xmx:NsQxagvemtOkVw1GxvkjMQCRUruaIDnGAQ7TpT_zIe7hC-qnEFoMnw>
    <xmx:NsQxamGw4G9FbDADfDF-t3msy_hS71Cn0PRwFbfwZcEo4cZ3Pso4bQ>
    <xmx:N8Qxao-Tscu1cAXoYtUNtjCX0bRq9xZsJMQP0YQla28qvGco15HczpXQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 17:46:30 -0400 (EDT)
Date: Tue, 16 Jun 2026 23:46:28 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <ajHENGWdBcbQUpWS@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
 <ajFpejsl1ukTbG96@krikkit>
 <20260616082816.4dd0f035@kernel.org>
 <ajG5hg9oJvyxPplG@krikkit>
 <20260616142359.43300727@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616142359.43300727@kernel.org>

2026-06-16, 14:23:59 -0700, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 23:00:54 +0200 Sabrina Dubroca wrote:
> > 2026-06-16, 08:28:16 -0700, Jakub Kicinski wrote:
> > > On Tue, 16 Jun 2026 17:19:22 +0200 Sabrina Dubroca wrote:  
> > > > I suspect err==0, and sock_error() consumed sk_err in between (the
> > > > alternative would be err > 0).
> > > > 
> > > > Something like this?  
> > > 
> > > Makes sense, but what's eating sk_err?  
> > 
> > The 2 remaining sock_error() in tls_rx_rec_wait()? [1]
> 
> How did that elude my grep..

:)

> > > Don't we depend on it being set
> > > to avoid further state transitions once we hit a crypto error?  
> > 
> > I kind of thought so too.
> 
> In which case the question is whether we should try to remove 
> the sock_error() instead? (stating the obvious I guess)

That would make sense, but we can't prevent sock_error() being called
from some helper.

The only relevant one for ktls at the moment seems to be
sk_stream_error(), and I think via sk_stream_wait_memory() we can hit
that EPIPE.


tls_sw_sendmsg_locked has
...
end:
	ret = sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;


int sk_stream_error(struct sock *sk, int flags, int err)
{
	if (err == -EPIPE)
		err = sock_error(sk) ? : -EPIPE;
...

-- 
Sabrina
