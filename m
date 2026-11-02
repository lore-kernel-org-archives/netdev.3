Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662685;
	b=5XP2fyWvt/CGZ2g45pU1SkKBfP4UgmR7czV0EMWab/9hn16puVGdQ9zoVi3L7qKCui2Y
	 G8A88LZMnXyqB1z3sImO1YLWecJ8IKALPfjB1dsynpoYp2Ct519GzdIoWADYLzo1q8w6F
	 4/EpVaEEer9wyIMsvkMimwZjLngnpejyyjF821jer0lM59kerc6zFR8qrZqRXEn8BJm/o
	 kiz2koh+1xscWE8wgJLbOK+NFJoJiDbx+vA+AYQsrbR4pI/i/idpzQPzbL9B81fXmNx7B
	 Fbf42Jo9/6IgkMDvWJ1QzICbp41sO53H24WwVlTi2xYnVYf53jcqybuIUDjvrPhHxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=ajTKbCVfUpvl1PRge5ZE4DWrvmI1TQg3QGvcmd035B4=;
	b=RuCpHImfaYsqwdgM9m+kppaozS2TDQcbCy3BkB8imvVHeBBqG1oxvO1x+OV2dJDK9fVH
	 P5a8NnR35/UIZethvyO0CD9y+iRgeUTnJ24DKIlVtH6m6UCIeD065Rq3oFIUJi95xlmY0
	 VXaQZikgGK9z65YSFU9IPuTgoqMXnpaK2cE1BLR1erLuR0dsR0BvIR6UjGzy8HLK8/5a4
	 BMQTSk4glSf5vVcaGyoIp/WW/Y5NFFB44qV8zBHGNqaCZsLLEfFBHYUQcs7ocybN8w1RQ
	 4SqL1+9NTtSRfGR03iyYaiggwH51Jmz/BqeCM1v+UkTCNLXsiYqQpbYwp+50c0Aa9jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZcRAdFi;
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32453606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32453606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZcRAdFi
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1afb6473195so704783c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793662684; x=1794267484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajTKbCVfUpvl1PRge5ZE4DWrvmI1TQg3QGvcmd035B4=;
        b=eZcRAdFir/tOfKhPPQaXb6mUvOPizNEbwDyFtkl3vKeIKU9Co8R0LPR3N7E8YyU+0G
         2EdC+Hi7HYUfRQP/PCKsIm9h8tS8eEbpeWjCtKW5O49DuznCRmny/sHaglVMRcQjk1XW
         wZt8hlBXazvlT3+G+BQ3Bmz9IyCxfZiYOF/RVxubvZmHO0sNkpaX5eNVfAoQpCQUlI5l
         2QeIfN1za7Fyo1Y5LFedwCSm+BskmtaBZmZEv/AWmFxszO3hxsuhm+PC8SWdRra5+cJc
         WZBdVfPBmr8WSta2fMLe085t0LYYVIzsbbeoSfFqPtbxZ27fS5V/opLjzid1gkFKzQ8Y
         foCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662684; x=1794267484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ajTKbCVfUpvl1PRge5ZE4DWrvmI1TQg3QGvcmd035B4=;
        b=SfiJtVJ5F9NMGe+nLh/0RnQpikoFOMxqkQyq/j5O5eb6I/LLTPuEW7k7WAqNNk1dsr
         IGoB86jk6/hNwJb9lUmGBjlP5poiEc4DKS3M2HpnuPXnnH0psCN5L3CMOE+w6inYbi2g
         BgRR/AJqIQbqp7398ZU2+mquy/93kgOlUBQ4iVIeJ0kdDRhKPjFnu++ddLyvu74RhqSx
         Z2FqWuqFSGK0e7ahj88VZaxh0ynZ+ogqzdEm9ceU3FZ1xd7sT2gL4sUXkUvXRH6h8srO
         4p3WizsWNG/ypPIu1w3kPg/gmuwHOMhtB+FL3NtQaYU56hVZaXNne6nWGMCMyZNG9H0Z
         zXGA==
X-Gm-Message-State: AFq9FYKizNvGGplRDpOGt3jGXLIvHOJ89ywGOdhvAA5bJTrmjhdy9UDl
	lNWrUpWeJHRlZFknuHuNpWMAhD/cHsx4bJbCzJVFlu+gmXf/DY5F04ap
X-Gm-Gg: AYBFou36ZboVhUDuJ9ZjDSiGMkfK8vskFPAxSN7JN3cR5KfhW7K1Be0A9NDmllEwNXP
	zJEL/0vRf5d6zynfzRAiNhFKfsHSNtUDCgjEb2708qJXieNXHyu6i/1zseJ10BmL8Kdksuyizhm
	YgV/YnpZgPZHolZRutmHPLdk33g8Mv+jnS2AsQ656NauR+twUgKYFfvgZh7i53AwzL48BVeVDN3
	ZLMF/Shd+22AxvKsb1Cxcs3UEF/Ba12bAUw8Iq88apzCxb6dcX9/F7fuRMqKyyeWokNsfW1TYwb
	dxhJqcUZATovtGKDZBebgye79XfgkrKRsp2EU0t5IFIYojLx9loVBmVM9Ta1Ea4ssDaQbPN56ZW
	ZzP+aAp9LxZ2uGU1t4eGi5laTLohSccLHVNXmGlZLW3/X91HqwFH3ys76IIMPHHKvMmpW74JTOF
	4pDN5c+FIKyy590JgqmLKq1X5rurdmvlveyFdoQqHGvmRN4+2kg+oO+wdXUtRnMuGjzyd19MNkq
	kGY3+Nu5PKrfIfU7Uc/uVqiQSd4/pyAJA1W3KVQdtz4IU7ogLQKdtVUAfFIe9F+IkbT08lJ5llQ
	TkO17ETeA6NnN6SH9oSxrw==
X-Received: by 2002:a05:7022:68a4:b0:147:8a40:cdf3 with SMTP id a92af1059eb24-1ac5d1d155amr22814754c88.24.1793662684121;
        Mon, 02 Nov 2026 15:38:04 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm36897502c88.18.2026.11.02.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:38:03 -0800 (PST)
Date: Mon, 2 Nov 2026 15:23:26 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me, 
	bobbyeshleman@meta.com, asml.silence@gmail.com, daniel@iogearbox.net, 
	razor@blackwall.org, leitao@debian.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: devmem: charge the frag length to TX
 skb truesize
Message-ID: <aukaiHZJcYsRCpr0@devvm16445.scu0.facebook.com>
References: <20261102191438.1059771-1-sdf@fomichev.me>
 <20261102191438.1059771-3-sdf@fomichev.me>
 <CAHS8izPefhGytGNeDWZzgZOi=gLeigZ63nFnkq1ERXXGwrNkeg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPefhGytGNeDWZzgZOi=gLeigZ63nFnkq1ERXXGwrNkeg@mail.gmail.com>

On 11/02, Mina Almasry wrote:
> On Mon, Nov 2, 2026 at 11:14 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > truesize isn't well defined for devmem TX frags: they point into a
> > dmabuf which stays mapped for the lifetime of the binding, and freeing
> > the skb releases no memory. The charge only feeds sk_sndbuf and TSQ,
> > which limit queued bytes.
> >
> > Charge the frag length instead of PAGE_SIZE:
> > - TCP uncharges in bytes (tcp_trim_head(), tcp_fragment(),
> >   tso_fragment()), so the charge must not be smaller than the frag.
> >   PAGE_SIZE only guarantees that while net_iovs are PAGE_SIZE.
> > - Frags shorter than a page now count their length, not a page.
> >
> 
> I don't know about this patch. The justification reads a bit like.
> "net-iov charging is weird and broken anyway, so we can do whatever we
> want. Charge size instead of PAGE_SIZE for no reason."
> 
> I agree that charging for net-iov is extremely weird. Neither of
> today's net-iov types actually allocates any memory. Of course when I
> was developing the original infra, I took every shortcut I could and
> just charged net-iov as regular memory, but that doesn't mean we can
> do whatever we want.
> 
> I think either:
> 
> 1. say net-iovs are not really occupied memory, so do a global cleanup
> that charges 0 for all net-iovs (optionally making it conditional on
> the net-iov type, so in the future someone can easily add a net-iov
> that actually can be charged)", or
> 2. change the net-iov size to be actually size instead of PAGE_SIZE,
> and keep the current 'we charge net-iovs even though they're not
> really memory', and then this patch makes sense.

SG, let me try to explain it better in the commit msg. I don't think
we can charge 0 because the uncharge path is non-zero. It currently
works ok because skb frag uncharges the small error that can accumulate.
