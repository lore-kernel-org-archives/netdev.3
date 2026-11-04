Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752175;
	b=40FvmFwm/3eSXEBCJsQm8yAihKT4ler19LkjycJC8KZXeGqHeTW5D8E5LllVx6d/Aon6
	 yLphIGFvTKhZqS1nHjQWx5frDZPfHQAeu611DXJOr7Ss+yzWJCcNzHM5R75kL1gMTKQCX
	 ixgwWeGPHb63uARU59lqSTQ3elOjdezTuPcVqaO2XSejuvkVVq/4IF20iWXK2YdBp+Jj6
	 RlGrhUL5CwiDF9Mhl335PC1ySlTlxJ9RjIkvJlwEOsaJOy6apznAOCuuBQMRtCb4ICQBu
	 hm/Vz1W3gaACWhZOuxS0sZI3KzeJi2v55dQaRqgDlv26GEX6D6gEjA2zcCICxNxB9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
	b=aTPZIWHE9c+G/KlHH0BqxIfofIsLKGn5qN3YFQ6/Uei/O/ZKPEsOn+mjd0JLzgv665si
	 G8Tx7yCo93IZD5sUcfvAVTXjTdttSIQt1LMsDDH+siZj0lpQ9G5wFxYHuu1DLJsjBwum+
	 nAMH+N7fvkwQOTBoUIfSnMUgcOPspkI7pqdjZfyv3cwB79uFmcUObMAWobgWjP/XSDg3i
	 jS623HVFKTpdp2KDpPZYqkyA//A2+DAiGIMduwpgVMLa/skHpP5HQ3HNaXF8kD4NFZPwV
	 1sFXtibQPmNe1AWIhiA4Vv3M/qTqkB/O03Jp6Jqcy55eehfZyxlLHSp3l+EX7G6cE7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nfqyj3ib;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FB606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 525FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nfqyj3ib
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso111153b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752175; x=1794356975; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=Nfqyj3ib/rCzof5QIGoG/Lqq9chSKO/bVoOr8RIHzuC/3AET4vx2vpR30emtjAd+vf
         YGXUIDIdr2sdIMnE0Ch+jMQMWPcaRlv6ROgC4/6W2OXClOfOijo4vezZ1GGrN3atAfTN
         tk4bTILohXkHLL9HoS6c7OZ1nj4qMbgXlVlKc7SHjRh+UVBeLs1Jzkw86INEsQH962Ub
         i8XCw5R8km/duPnPnDd6NZRB7icYJ/PqYnfVKiR5PF8OrFUg/SVdiNtmPNAjBgXs/52i
         gQoZbnQOSXtI2ABFQHCh/CCzKJQeQrg8To85JZJrSkijjSKf84krBmPjbrv3cmz6ty1U
         255g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752175; x=1794356975;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=W75sW/WCrnFk9ks4zXT1PIOFjFTsCfoOqj5WyKDaVAQsFhIfaNVEiLLTPcTGc8Rax8
         nGsZM2TvGvxWisvV9ux1JReOv9QrlLyIGfH9FYk4V80ddJFRQITisq5BO3OU3yrrfv2d
         5M+LdE2eHqE+eclS/q1d1NWBq1ZphU0dp5pzUu8Okj7AC+IrBlyNjIjslNfnkP/I81Ea
         Juph5g0AIbTva1Hxw48ptvXUf61eSA4vD1KUsTAIEZNLGF80NTIP4ZcCb4SB5rU6r/EE
         kGHrsW0Tn7ZFCjxnwK+U8o5lKgjNGLEVFcDTpzSq76WRmKoJzpO3PVCCLZBS7gtsUw5E
         CJqw==
X-Forwarded-Encrypted: i=1; AKwUvBwnhMcu1SxAKi/39PGHoX7jYTY7Tyu1wBdZ/LZryt3erXtN6XHfij9rQTyMIsoUh68LDJjg9EI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AQ2stZIDc0almD1oRDv4DPnWx7NXISmYuxj+lUC2gZyu+qoXM
	wjm1HwFuc2lNr689qFLae9C7rbGStbPoq712nT+1EYuiqNqVJelpu1SB
X-Gm-Gg: AYBFou3jQBCWPhrYts1UFZSMeCQa7C7PtaikrBTUWsKGqhSxA052dR8+UqKrNLjB1eg
	uvb7Ii4dlBueJoa0qdLh2IyTDxCAz03Igvbtmejs3c/HC0qvp+fyDDb5OV+FJShNbplUpKfzhqC
	4cZOKzjxZF0+UK2YkOGxm3kRyf5GTW6rOP8wkleldasip3zmPgGfRPPXf//4xDPSi5Ye4RTbbOP
	d9dgu1arnjoEGc/bDBd8nNnDdZ6f/NAXRLIVPtth2OmbgWJAgxWqQpPFsTKyFnbilHIqZopRFQ4
	B6P0h186SqN5yqZq8s0hZSfUG8ISpjLthHNJbjT7+aSJZdXC4x1u+rouWkVaMgTtCZn2c6ZnKkb
	Vw5MzBMeVHCuBgbG31mfOWFSYqdDmpIN+pfijOt9O8jpcaneJHXyIdl/TI3J7Nqe7qGEWskOcWZ
	l4eftMNgyuq0NQ1DPEOB4SsnZHhMLHqC9HxeUcUGlc7/iqYE2j/ytEJJCR1W+mUzRKbCJnUAddd
	mYXX+o7H+9ZBnNlWu1ADnvboYvdToOOSp+PQ1QgdBkTEjNEMF8pVIA3IqcJ636CyD6Br7hz0c/8
	1s7OOlmPh9NRZL/Gy1F64VZVMkreitGbOFGOvc6qVmvRHtJIk6cv5Gjs0rgeuHIcO0H81Spzd98
	tQ+xpFF64kFAT9ndgAnOtxXXIfdTHbLSNqQ==
X-Received: by 2002:a05:6a00:4c15:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a9bd4e6f67mr10982582b3a.45.1793752174633;
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7cbe56sm180227b3a.10.2026.11.03.16.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:33 +0000
Message-Id: <DMM02SF04UK0.3RQNDSDPR2SGW@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188061.488855.10389706003415159913@kernel.org>
References: <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <179374188061.488855.10389706003415159913@kernel.org>
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
> This isn't a bug introduced by this patch, but the comment mentions
> unaccepted children as redirect targets. Can tcp_bpf_push_locked() hold
> the lock of such a child while the listener tears it down?

yeah. It's an old bug, not from this patch, and not only in sockmap.
inet_csk_listen_stop() takes only the BH lock of the child.
tcp_abort() calls lock_sock() on such a child too. See
commit dbd62ad55a4c ("tcp: avoid double destroy in tcp_abort() of an
unaccepted child").

> After that, the retry check here returns -EPIPE. So the window exists only
> at this commit, or in a backport that takes this patch without the next
> one.
>
> Could the series be reordered so that fix lands first?

No need. The window is there without this patch too.
This patch doesn't add it, and patch 8 closes it.
Both patches have Fixes: 4f738adba30a.

> This is a pre-existing issue, but it is related to the sleep above. Is a
> redirect sender that sleeps in sk_stream_wait_memory() on the target woken
> at all when the target's owner closes it?

It isn't. It's an old bug, not from this patch.
The sleep is interruptible. A signal or SO_SNDTIMEO of the target ends it.
