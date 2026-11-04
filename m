Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752225;
	b=BmP4150cK9q9ZjT8RD6NcS+5Ldn3Q2JeeBGfa8bZ+CtLntDrHMsb5reGbHfYZy3Bx6RF
	 PlXy4DIOxym2RqtNRzA89MKlJHJLaKEWG8Gp16pHpbquaIvaBFm0ACE33A0waWZaj+oau
	 AC+SkuQM8ApsXw7nlsbVRMdarPNfmysrbXG5VcVPZJdgr1zaYmrmC57PSDmBwgVLgks1A
	 Dup5YnR8/gy9cdOf8Ma1V+QYWgGc5ndNFW+rbwz4HVIcHHiWPetDfZF1eBoJqbXQRBjuG
	 /mGUVrJ59Fvng9CXm2bNKSSN/ikNVu+A1j78NY2IK1L7eQAkCKcSdXAXv29vKwvq/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
	b=O96H6OXOU4IYXlZYjtevkWPsJ7v+4az9HS9m9DXrzivi/13EjzhCBySBfuhqoL3kmlsE
	 mp7tBfE3j4JTo3DlpMOcEY9m5GIsQaH92uD9ZKv5F7fAOhb2XSpCATJOSOLuvdcTHL2WI
	 IMjzhFvVWkrYqkp3bUkURMeXHHWkXRzIY34MAd7KJZhYZhlmLDJNSFZQ5jrJjaI5Urno1
	 vD9OEwyW2+IbcSkB31iVRR/06fsjLbp0mw7FWdSeZ9mSBQZl2Ev7Ro7N21/mer5BWa/a5
	 S2PLwhhLWrZhK3pyqXazTQFaGHclYEcvssbpo+K0bh79RodusHWt3ufJ8kWR7FGD1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKJMjQZ2;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C7606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 589C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKJMjQZ2
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so136899a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752225; x=1794357025; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=zKJMjQZ281aKiS/bWO849qnX+J63/ObIv6qtGf4h23nwKtLqvuZeAZkSYeqkDanS5i
         6GXi2Kg5gPdFQJxv9PQ5+AhikjGWTkkXSRlWqAhtKAmAJdIgrhWqPXgWl36D/ZErOKss
         mb+y8vF1hOTiGLsahM2m5wTT8ZhdUiszk0F2loGelEb0OuAMnp9eQS1ee2niyvStMQ5z
         BYDpWyZi4/eWqfMH5awg8c3sd0CL17nqkwxHixqLQ357paesHt1C1HFUewnjY1BDhyxZ
         wSo6f65RtSL36fmHWlZzIZM2lJEsuWlUH1+TIyu+d39JWMrZcSLH9fvTnFLOlrYqlQIz
         5bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752225; x=1794357025;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=CgAfvX0Wrdiir63gZ1OMR+vscm7CXc+c5851rmPgIVcnYbz6JPkVxoDPGV8ieYW9UM
         ZFtzJuACej/rg0+sTzEDg+xJHVUFDtmFP42pwcMoXdcISnjnD4h4bt6sL1PU6Oll4pmt
         JpggqGwg6cJHyNyN/CVQTzWXSS1858+f3yzn+MJF/RAk4fetwPzlZ1teZEt278KP22e3
         fhJ9bs+f39G4B8a0c5j5Ob0c9d5K/J4vLauiW7EBYaUH2bGhEk2W3lYOzD1pUHRvtu27
         UTe3NwbiM/5cIxHzjFLSVrDQEhd3J8PXYHEq67SdPmbo+IRkc3DkElb4s44EpDDvlpIX
         c6Mg==
X-Forwarded-Encrypted: i=1; AKwUvBy+BmjsU0/eCvrKn2vcGF2rsPWSjNp66jj9gJPWHMCUn3DHBhn5BP/sF9vGAVqdhNbbXtXXH5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Tl+J9/brnG25LHWp5KgPbEpbAG3wHPWyXiKNjCXBsBAr0x83
	htMcTaG+bH1quncxrs3hIRJ4vVx26UG4vaT3K09nCLLWa9SMO19z/suY
X-Gm-Gg: AYBFou1GpkpdPnL7/OjEHB04+x7ohr4D3PrYqbj08s7fknrwtNu/XA0ihizppncezz4
	uGQdIgmeYMcX50YMSRGwn2YH2gzfZ81T8PUoQuNIjzhCd1hyUxCxjzJGQF1Vp2ZsvpfPFenVhGd
	wf2+DY/c/vuBqbkNWJcSnpqU+CZY48llFD3D3tfGbOXm9fpFsZ+eutivIwQdSjSaJhtjWrxmU3A
	rBULSzsjh6ayKJBT71IKm85hLooQDFYHd3KsFuaJMtwK1RoPPqVOkwo2JDZc98nMXCXC9zXzEmd
	qgxXfw+hYys7IaVAAVlY6EZSefHNn6jqr+ZeifADonw+3av3N03PSo268vowrpYQxGE8IxiNNig
	w5P16pBc/Usru+FC82SLzkB/yUUjPsx+WOH79wMRkZGtfwJDofffZRe4NdBwsoNJm/9IV7kgVmP
	3fJVc3rtxkSVoa6ypMxTHiJ9BKHzhiQbvukC1HEOR07lxc63xmciSbCbHI80HUaYw0C0BIaKILy
	t/RRbpoHQxCz/Y1mwK91zbsJ+K6URWNzxdOAjEXd4c1vtWnH2E7/IksZhWUfIixMPaWgoGDW1b9
	8iji2Mdb455VhnARZqun78V/EpAvWptuu4vyWaZnKUfm1w4TTl8p2GqAViilaBnBN6m9yeG60i2
	/SnVNbTp0h9yuAIypGD+4GsvZ4WOWB31gFg==
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr12306124a91.49.1793752224515;
        Tue, 03 Nov 2026 16:30:24 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm636905a91.0.2026.11.03.16.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:30:23 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:30:22 +0000
Message-Id: <DMM03F7F8IDM.VMOKC4RWW2LV@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <179374188416.488855.8465787275984951547@kernel.org>
References: <20261102072112.4160195-15-alexei.starovoitov@gmail.com> <179374188416.488855.8465787275984951547@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>>  			if (!cork)
>>  				*copied -= free;
>>  		}
>
> Should the cork case also subtract the freed bytes from *copied and keep
> the error?

No. That's deliberate, and the commit log says that it stays. See
commit fec51d40ea65 ("bpf: sockmap, zero sg_size on error when buffer is
released"). A cork has data of earlier sendmsg() calls. An error for
that data doesn't go to the current caller.

>> +		if (cork && msg->sg.size && !psock->cork) {
>
> Is this case meant to stay out of scope, or should *copied at least be
> reduced by the freed tail?

Out of scope. It's already explained in the commit log.
A smaller *copied alone is wrong. ret is 0 and tcp_bpf_sendmsg()
continues with the next bytes of the user buffer. Then the return value
doesn't tell which bytes are lost.

> This isn't a bug introduced by this patch, but putting the tail back here
> adds a new way into a race that already exists in the SK_PASS branch. Can
> a restored cork be freed while tcp_bpf_push() is still using it?

yeah. It's an old bug, not from this patch.
Each SK_PASS on a cork has this window, with or without a redirect
before it.

> Would it fix this to detach psock->cork in the SK_PASS branch before any
> push that can drop the lock, and attach it again under the lock afterwards,
> as the SK_REDIRECT branch does?

For this case, yes. Jiayuan proposed to serialize the senders in the
reply to patch 13. That covers this case and the new cork above.

> Non-cork messages already have the same accounting problem. Should
> sk_msg_apply_bytes() be charged with the bytes actually sent rather than
> tosend?

No. The verdict has to end before release_sock(). See
commit cd9733f5d75c ("tcp_bpf: Fix one concurrency problem in the
tcp_bpf_send_verdict function"). A refund after lock_sock() can land on
the verdict of another sender.
The prog runs again on the rest. Without this patch the kernel frees it.

> Could a test be added that checks how many bytes the peer receives?

Right. test_sockmap doesn't catch it. It can be a follow up.
