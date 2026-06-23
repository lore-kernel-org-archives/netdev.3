Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AB26E165
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236433; cv=none; b=VKVAPkG6UlPQVXP8SUdylKtg0l3kCnXApl5odQdshF6AQgRcufOGQ7TSNQA+kl1gGhMFjIJdp6RNQzsU9oNpmCVyR6GG3t7wiDwIxU0ncCggov/rquCGBompFqRfWnfN28Jooz1nXplr8gezvzh9XMJrj1RTxpgnytffbcljkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236433; c=relaxed/simple;
	bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0ABK5XxKx/tNU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FdtF8buLwWfVZnkNmoHQDmXHW0gJvwi78VgDCaWQHaGNbdnVniVuPpDYQvPhJiCT/w3jn4msT5ERXNUCPoeIBWV4QLdw/u8a9nEkjjd+bpfsTk+iUatNJ8RlzsvXuvAwqM2tQ81uBiDUyL4YuyMhTK6U+ZfpWSWVhP4g5idW2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=cxpjNDPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo9immC7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="cxpjNDPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mo9immC7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3462FEC01CC;
	Tue, 23 Jun 2026 13:40:30 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 23 Jun 2026 13:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782236430; x=1782322830; bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0A
	BK5XxKx/tNU=; b=cxpjNDPiGR7y4D7z5GyUhooyK1XE7X9FihQiH0eBNvrMfNCo
	NY2ZdL2i5SChmg7lJLTuLo5b+OIA/K3DMg6hdVpV+jJnOhE21AmsFtWsmk9QmsX/
	KLqKQEfNaBpR71oFDo6qa0HUKzWPadyEdX26nAdxyGADuTlbor3/OlkP2CtAJaNq
	InCk2UktRQoxfmYsu1ZUOQYttX+ZbgWOshizRfVqrICFwFL0k3i6JvcFxqJVGreB
	F1O7HzR2PtXgRSHPiokXLdU3evfYqWbr3QK33auTyUPz7dZsSt7NA+GvWAhtuTM0
	8Y92v5UHjILGMXYhoRAgU/XaiV2Qr1nSni9aQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782236430; x=
	1782322830; bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0ABK5XxKx/tNU=; b=M
	o9immC7ibPngc1MeENfdh4ErRqLCJzwVmPCCGn2ITuR3nv0MIqLFVUQa0wUO4FPk
	JP2SfS9fZVyvCr3/5e5Z3bNZ3gVPRfiAMrei2R6Ezz6NKMAH1MfANHd26kKXMSAk
	pgLpvMPEubIPkgIO+1Dco32+lIPg6XhHnESazX5+I5qGgerA4jr3FPFKl3gGXX+y
	nUAYPCD89CbD2H4Z6wkRUuCIST3aTyuL9+eJW4lkr2rHp9yv1oq8CFP7u93INyot
	8y2yuCsmM/r3pE6gwfENzbkV/Jyq0Y3+tKQNReCtIHCkcerFANK/7aLYtoTBQTL5
	VYIvEIFT8daSDSyhYaadg==
X-ME-Sender: <xms:DcU6anv2d3iYvEO9bLTz3udNb_z8FGU2AxgzQouuG-24qlKDzxdkfw>
    <xme:DcU6ajRIedGrEyoJcCDLSxDlkZsciqVYUJgoxSRFyixJiU_fUNusp_RzHtyT-H3c1
    UdUi6eQjbF3B-nPU-J1mAMxKr9HWUh_yO1itCzDjL5ikj6UWBz-7w>
X-ME-Proxy-Cause: dmFkZTEEcIQSwnJHrOxkKJjI4DpllrqcRH2YsHytmG/5AmuJDjKOOd6aj6xvQZqmHITs7G
    HEcV2hCv21vOYxWDWmhIYaiSaoO1aDU+GjF2lXT/nkhfuxYhY0FgFHplsXEXizLphbj6/A
    2VVrkLQC+2aJ6+3Ge4a1xTAwBkNwa5KfVbEJVDG+PcDqRjHJpe/kTCMJG+Tk5eHXq7Cnc7
    oiw4udpvcxzxuTfLzxGI8Ru9ZLumJuS8MW/MSN7sCcnQzCNvSaP9lySsrYeE3N/o6TM7Xb
    mobTIOny1gQAeS4UiYhrw7OsBSnRTZkeMCHJ8jscGpBGHQXIfN53WWmOBUe/zpe4PEYwTz
    yoxLpJmry+ew2myGTE5gRv+J+gCUQb6QbPSCjYA/4N2dEZDUdKwAa0r+5HpUmC3UNFsQKm
    UsvB2BrwOa4fRbnRNkATTMCFSdIePdHHEW/B3+2uLjmWbI+yT+6/e2otuFaXYBvuFBco+b
    w9WOjuLccCQi0W2iNUWLq05iPDFpnjRQTocm6IcrlYcqfWIkAiUx8ekpyv5QWZGKGeDwyT
    bBFyc1a5BN0kuZ0llykdSisStNqDy7q9fF4R9dZBDKmMDlWWjTipWF7998F6/7v6vBA7VS
    lWHV7mMBm1cmiwcP4AfbhgQUlfcs0pCJ+zJV4kXLqkymImFrUl6ObINT4eWQ
X-ME-Proxy: <xmx:DcU6arpWwBr_cadx3dOrXjekDj4g7UcbxSURC7ZToJkEcmw5RhhN9Q>
    <xmx:DcU6ataMElrAedx_RNXgb2kut5Pszt7LYzB0R4qbslJ580qhLEb00A>
    <xmx:DcU6arS2F9iyHfFhL2FCIbgRe18_e8aFmfweSz3AQjj-p1y3wEQN_g>
    <xmx:DcU6as4DwODo6pg0HSoYFJLalN6neAbBg0lvvIMBIFrH-RAAWx6MDg>
    <xmx:DsU6aszRMxzRRO_7R1gly7o6xKE56qwVs7Hb-whwjkbCCxRw9wM-yWEh>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D42922CC0083; Tue, 23 Jun 2026 13:40:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Tue, 23 Jun 2026 13:40:09 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "network dev" <netdev@vger.kernel.org>, "Li Chen" <me@linux.beauty>
Message-Id: <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
In-Reply-To: <aixU_RccxS_BKhgX@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Cong,

Sorry I have taken so long to respond. Rest assured, I still wish to put
in the work discussing this and (if there is agreement) implementing it.

On Fri, Jun 12, 2026, at 2:50 PM, Cong Wang wrote:
> "Nix needs it" is a much better justification than "BSD already has it".
> :) So please add this to your patch description/cover letter.

Well, to be clear, the motivation goes beyond Nix's immediate needs. I
think the Nix ecosystem would be interested in my object capability /
"zero trust" experiments that this (and other things) would enable, but
this is farther afield.

> Just curious: any reason not to use TCP loopback here?

Sending file descriptors over sockets is very important to me, so TCP is
ruled out.

> Any reason not to use abstract socket?

I wrote a bit about that but perhaps it got buried:

> > But I really don't like this because we have just replaced one
> > ambient authority contraption (the root filesystem) with another
> > (the abstract socket name space in the network namespace). The
> > problems with ambient authority remain all the same (and indeed, our
> > experience with Nix has been that network namespace unsharing when
> > you do want to do some outside world network access is much more
> > work than filesystem namespace unsharing).

To make that more concrete, connecting to an abstract socket by name has
similar TOCTOU issues. For example, it is possible that the original
server disconnected and something else "stole" the name in the meantime.
With file descriptors there is no name reuse issue --- the `O_PATH` open
file must point to the original socket.

I don't want the socket to have to live in the file system *or* the
abstract socket namespace. I want it to be truly anonymous, and only
referred to by file descriptors.

(Also note, the mechanisms described in my last email go further than
the original patch's, but also subsume them. If it would be helpful to
illustrate exactly what I mean, I would be happy to share a new patch
implementing them instead.)

> Indeed, it would be very hard to change since it is coded in UDS API since
> probably day 1.

Just to be clear, I don't consider things so hard to change, because the
bad UDS UAPI stuff is rather "cosmetic". "Anonymous listening sockets"
(let's call them) can be retrofitted fairly easily, just as abstract
sockets were retrofitted fairly easily.

Thanks,

John
