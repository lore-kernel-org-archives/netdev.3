Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C4399369;
	Thu, 23 Jul 2026 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840333; cv=none; b=e4ni9nF5etso8HWZkaaZXZ/M2Bq8TVsUdZAF1AynjrADyfwOTjnyrqV7AZQNN0rDZlczWeN8puNLkENcAPCq78n39osMM/p8y2Xqb46I7sygLVK6AkwiDf68eKQlBrsZKVdppEM4t504todbiIWSuNzE5mRiT0S+xz/rKoy7TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840333; c=relaxed/simple;
	bh=wvDUk1lntVYr2k079fTfdL3rttds/7oVXiYCl2Ry5nw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DayQwvs1WMf7l1UppcUT8c0stc9kh112vIvU04n15n7nADEYZTjbtCZ1i1Jq37JC3A7AWCe6ov6hhBLb55RVNzl5nUm/JyJ7k45f43vToBYQk6LAngQK4w4qxbSd+vEZJ0HDF1vzBMtSZ1Jg+gs3A1A6K5NXj6UY4WhoPXoTkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=tpTpqjGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pla3GE6D; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="tpTpqjGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pla3GE6D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB89E7A025A;
	Thu, 23 Jul 2026 16:58:47 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 16:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1784840327; x=1784926727; bh=6Qt3sL/fRa/gMtxjK+W5WzOPpLlHThlv
	kUihsmddOnE=; b=tpTpqjGg0pjXcLbkDHuTBAP6PztRrKj/ApCIoKUO9emvu8QB
	tTT10ObNbp3TyKiuMjbs2d0VavdO58jJM6l4g0WxcrBGxF3C493tGTLwoIyz+iJP
	jdOzpsLjii0ZCzhcprp3zqdlNF7wqxp0jnR8pOO7FaKXd1VCEMhyusL9t7pKPpK2
	QYnwa8Td1oyKbJCWJX+7G6GWClY4KN4RksS80vOH+ykw2LWpokoe9crSK4ZvsYgl
	bWYnU4rd4rDFplD4rtivgLglCiZ+KxJNqiUVjKBd1d3nCp4AkJYoHg29JMhuckTz
	5vuSOPnj6f85u4cMOyd2W02jkJylrcGQmkG3tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784840327; x=
	1784926727; bh=6Qt3sL/fRa/gMtxjK+W5WzOPpLlHThlvkUihsmddOnE=; b=p
	la3GE6D4yJzHZJ2w7ajUdfZIxWMkoN5RIN3EbMrEtW/sH5KQTzHPb2glhKZ3teJm
	K2RxdDjocE5DdQLE1OLULFUYAhGSeoLh7flSy3kpZnA9YjaVijUyXYlEF8QQ+noC
	bYqMn6N9bVGgRmfbL5ViTDvMy358/FCX68di44F5LmWRt1sh39pEHluu9rUp6GjB
	IgSuIIxX/c6mswANTQNt22oxGCUHtbMzvQFR4KkfE0HeDjGELdynlasdjToCb0fv
	5H5HMEHszpnIn4Mwofll4hBSdr7idKrAmj0ZBRsIPKIQ1BVYt5ZvveNZ1C57Mxph
	utY/ZxVmT5e18W1q2tTgw==
X-ME-Sender: <xms:h4Biaswb4fP8ihNUlVZl16gTGhzVnDEZM9RVzq36W8XZslSJAopARQ>
    <xme:h4BiarHxcHmX9CGujPyVp_kiK8I67ixb_JyNTTE9Y39Mnfub8Q3v30PIC-xu5-81z
    EyLrocwb_onTNEa-MC4zw2cfOKnEcwewjbdeOeP8A87PStyCHNw>
X-ME-Proxy-Cause: dmFkZTFqx1NQI5IuTFqR/aXk2jma+WJw6IxUwKfjdmMJ+XIuxao9KamY6hbebpXwI46PFc
    qQfyEE3BDvPONVsTft7rkOrl/73C6qI0fS599iL5uqur1o3NAP4G3OOqpGe3a5vjZFdXhP
    SCK0qL9/UJaCvAqMoTcDXyLUyCnle2fZd9oNkYzLYWFtKXvPUK8eTaIBl+AsbjjV/tDyJW
    WK9ecMEgmT56q1WFb5Xlit8krVNvGR1eNIgKYxK2gCX09ForOeCmFysOTcjZ0jm/mwCU4M
    zuufcjTQ6OAm2fDZkgKOKKlYkCz8uFKx+HWHdSkDrD/yuKVHedj04v53s5GNglBfnCfFtN
    +Y14PxNxgFyQ+QRD3161PdQdZIB38lg//1XEU7GjOGsMMF7r6ihRxukzu7Ycbyx8tcDGoz
    PGnI0eDX+uyxwYBzOsVIEltONjbRQXbIZGDz2QFiVBdkJkrDbpfCfKzhClVDZLAIdAHzXf
    YEV6A4F0n9QNqrtOQkhjLQbxsvheHHZ8ZkwJdVb/F844gZpvjsCrAELkV6BW4Jlxfynes/
    LW1oVCfhBb4Y8hMyJNDwlb5dsIcnRVzbsUyOb/j7vwjjhAS5NCJkwPPR8qOVuKOrkujkDQ
    peewKLCj1kw+2B0zBH6yBmfVSiGonCFtsoX/ghvB1NpDzNRB9qREvjZNP41Q
X-ME-Proxy: <xmx:h4BiapktLe9suqpwUQfPB1-5bLQ4F9l2fXsPKYvC9Z7Nv8wj9BipcQ>
    <xmx:h4Biahgs6jFxvkDSMPb3DPY_cwECej6Fbcut-1BRbuBp8-DDz8_m2g>
    <xmx:h4Biajg5YJTalsee12McINk6c4IZdAM699ghdMQdvnHf-taXFGFoOA>
    <xmx:h4Biajugxo2qEHQTo7l3nzKM7OHYQFapca69Ol1kaTVUAyfZ-IJSsg>
    <xmx:h4BiajtYFv4Hb-U3qCECaTTYxEo2GM9cFbzBLZEcP2AcWQlBbejsIyrA>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1411B2CC0083; Thu, 23 Jul 2026 16:58:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaLgTCfSr8ho
Date: Thu, 23 Jul 2026 16:58:16 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "John Ericson" <John.Ericson@obsidian.systems>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Cong Wang" <cwang@multikernel.io>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "network dev" <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <acb8cc56-6473-4910-9367-8c3c0d75be78@app.fastmail.com>
In-Reply-To: <20260723091248.6acaa173@kernel.org>
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
 <20260723091248.6acaa173@kernel.org>
Subject: Re: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets in the
 wrong state
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2026, at 12:12 PM, Jakub Kicinski wrote:
> On Sat, 18 Jul 2026 14:29:01 -0400 John Ericson wrote:
> > Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> > reaped sk->sk_peer_pid") inserted a prepare_peercred() call between err
> > = -EINVAL and the socket-state check in unix_listen(). Since
> > prepare_peercred() leaves err at 0 on success, listen() on an AF_UNIX
> > socket that is not in TCP_CLOSE or TCP_LISTEN state (e.g. one that is
> > already connected) now silently returns success without doing anything,
> > instead of failing with EINVAL as it did before.
> 
> As the bug proves this
> 
> err = x
> if (cond)
> goto bla;
> 
> is a fragile pattern. People do this to avoid the extra braces AFAIU
> but it's not worth it. Can you move the error setting before the jumps
> please?
> 
> if (cond) {
> err = x;
> goto bla;
> }
> -- 
> pw-bot: cr
> 

Ahahaha. I had the exact same thought!

The original revision of this [1] indeed had the error handling reworked
like that, but Kuniyuki Iwashima asked me to submit the simple 1-line
patch to "net" first, and only submit the cleanup to "net-next" later,
so that is what I was doing.

Is that OK with you, too, I hope?

John

[1]: https://lore.kernel.org/all/20260702202018.2280336-1-John.Ericson@Obsidian.Systems/
