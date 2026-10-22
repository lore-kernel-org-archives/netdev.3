Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716222;
	b=jmP6ctM2f4rrgF+sTq0RPWD860o4RgpSWJwfno5uLoca/8cmYxiSDohG1YO/b7GIi1br
	 kTLRAZm/ZHpwry+1vnDx2/yjjNgsjIBXEiYrI//rboVFaVHe6BhPjq+EkK/hFEvfW3k++
	 xrZYFtPTTNHV/mk5UruEUez36XMU4qwhgpfbEF1Fu1cRe7jq8/rMmvw+nSGciCwJfIEtb
	 behuLAVAwXHqyJ/jsQcDt9cRfDdiztGY3bEWEFxLYr7EmwJM2ARtmo1ncSOy/e/yMPHvn
	 kNz479xiSG9DaL+ZZsWMwE2z5okd09PMWeYppz6YYtlttyVUtlGqWQdfXCys4l8SVQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CA393/dbh3Z3YHwEnkYHgdANjZe1N8bA84W85qprnlw=;
	b=2hnBDLjfTHHIrEl3z3KZnXgVCex4jZe/6A34S0CpPkOI2fcm32cJG6Lb6E+4F/ZwoM6f
	 E/2DpOYaJv1w9CnlEpKMHhbybRKHROzNntIW4Iflk0T3VLvQ8cJI+e9mbsEc88ghnn+18
	 YlKOkVLxtPcEnrVATqXqaBfMCN/QaoMNUaC7jAbBGJvSWcGkk+Td8lOsZ4wnFjx4e3ba+
	 uPndDIhhk4F946x6YPuJGC1C2Yxr9dj9xMlQwDMzqjxTV3Uf3FoDabsYbm85MJOWWXWew
	 hkMH9FkLpNuXe3eYPgPzrN/2VMJfdsWxBAlfuRXBNKPvsuoNVY0yCD+xnFuoBmIGtAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DpE2m9xq;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C7606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8C7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DpE2m9xq
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9179bfa9e9cso6262386d6.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792716221; x=1793321021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CA393/dbh3Z3YHwEnkYHgdANjZe1N8bA84W85qprnlw=;
        b=DpE2m9xqjmiNDuLP+R3+lizgVTk6R6E01LT8WMS5b9NCgux5uu+n5dJehEkRVhsfd4
         elCtA1UbVr9SH25pS7+06ZuG7IsuKsIdaarY3S8Y76zoJMrh0/3VImwCO9BsIztB4HGT
         PKegYPhGyWgmJSzA7rAy5TEcEbOSQVa0Td/fdXpMD+C6djkz2+Rg7orP78Ub3zWxtKLr
         ceXKFsiJPNDmHo67NpU4PT5frgvmZK1Jao3q6EOnS+tdTDkz+n5Axor9gSr60CDW4UGs
         /asEjqy5rL8JOCaR+m/SB/mjs9aMbCtCKD8i7bp/F1TgBIvPZIl13Pyy1U/QuSYv4Q8W
         sxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716221; x=1793321021;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CA393/dbh3Z3YHwEnkYHgdANjZe1N8bA84W85qprnlw=;
        b=RJiFPAytYBaWTpmwrYmgsVMA3CxNgcXCXzy88shBd8BQK2DZop64f4SNqs5f+zONzj
         vuIHdVll32hXgdQsEM/T9uM+gU8Vj4vEnr3tOiifKaAu5zpX/N/S3DNHcZgOSk/gNG52
         WL5jVLnDunSTEhLp1hfhCCqVoPTnVc6DV9NyTTW+OLkTRo3bZhDDWxxjXS7HiwP9mPyM
         rbfJ/Gsz0HuInKh1Bh/KAQkGooYwZnRRV6qkq8JESBVjA/lL2fhVMTFMEv2X1jifTx+X
         PwuYK9Osc96PLLdqd3GaD7UhF5FfMov1Hbg43XvC6DiVXBhe9wVskJEMncDGD/ZOnNb8
         mTIw==
X-Forwarded-Encrypted: i=1; AKwUvBxAfgKpoMbxlg6i1J4fxfE9ALQBp6E+JUG0Cl4AdbTY3/iJFDVD+xLO7lSiZYlnFqFz2IX0YOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdY78VJTzdNHgvhlIr0STfJNOQrQpOx7t24poIyLEsn4CPr73V
	f81kKEYjKcmqBcLwxy+6wzHQm8M5JrNuk9XKms9ZihdJIUdFGy0SLThxr61IfHzpcac=
X-Gm-Gg: AYBFou2k8xVi1BtZgwxwPl86cuj22d9l0yyZJDAnsoRo9dhOwUZBbI+rTFDydPrFfvT
	Z0oMNJhdIka1rrajRdXSuFT4ajAwWI/ArNRCEqavK81zyfC4LG+ivN4cQWDH22o4vYfmtFKd9K6
	nWndUn2nyzE5mljzUL4GVsYFTV9sFR3Wfm6b1vkH793raMoxqmwONLqOc+SErq67cC7zxc+oWst
	13L4ewbrwIq2yZdJYKKOdu2bnHdlWbG+f2FsBGSiuUNKypU6jnEpQvp2SU9So6NmG5lNJa3su9C
	nGBxd++bDbIzZLP+bgkgnVY0bdbT/QapAbTNlvDdousZeJVBxvNvhSQybh+0MLDnpEp+0aUfy8E
	VMcIjyFYaswbMGjslb1aIfJSCXmARulZBc3yZ1doLENH+foy/F10bMd7PZiS/hCx4evVyMY5UvP
	+vXs6111NMzcp47LiRTenlMBiNua2xpR22xk2dVum6LLYooKIboXWJuXuve5jYY8pBhTMQOPejL
	1nMCD6wIBkRlJctRem9wzJxUU71JhRcBchlHPnJyOew1V0vlL4xdcxMohVdWnKG8pQtYxWeqNOO
	DnaSUdjRoaLdM/bFHA==
X-Received: by 2002:a05:6214:d65:b0:91c:1fdc:467d with SMTP id 6a1803df08f44-91c3a9d3548mr7612716d6.29.1792716220553;
        Thu, 22 Oct 2026 17:43:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c3971484dsm6287796d6.30.2026.10.22.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:43:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH net-next v2 01/15] net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
Date: Thu, 22 Oct 2026 20:07:28 +0000
Message-ID: <179269964884897.2.9376562849077840876@toxicpanda.com>
In-Reply-To: <717ace2e-18b2-4df5-848d-5757c01ee5de@redhat.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
 <717ace2e-18b2-4df5-848d-5757c01ee5de@redhat.com>
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
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2026 at 10:21:26AM +0200, Paolo Abeni wrote:
> Recently Eric did some work to remove return arguments from the fast-path,
> as with some config it gives measurable overhead. See commit
> a02a765bd5c2ae7705144829b2911c96c29db6ba.
>
> S/W csum should not be the fastest path, but AFAICS the UDP output path
> could use it when building the aggregate segments.

I checked this on x86_64 defconfig (CONFIG_STACKPROTECTOR_STRONG=y,
gcc 13.3), looking at which functions call __stack_chk_fail before and
after patches 1-6.

The callers on the output path don't change.  __ip_append_data() and
__ip6_append_data() pass &skb->csum and skb_segment() passes
&SKB_GSO_CB(nskb)->csum, so no local has its address taken.  The two
append functions already have a stack protector today, and
skb_segment() doesn't have one before or after.

You're right about the helpers themselves though.
skb_copy_and_csum_bits() and skb_checksum_full() both gain a stack
protector, because of the &csum2 local in the frag_list recursion.
Moving that loop into a noinline function gets rid of it, and only an
skb with a frag_list pays for it:

                                 before  v2   frag_list loop split out
  skb_copy_and_csum_bits           no    yes  no
  skb_checksum / _full             no    yes  no
  __ip_append_data                 yes   yes  yes
  __ip6_append_data                yes   yes  yes
  skb_segment                      no    no   no

  skb_copy_and_csum_bits          774    905  666 bytes

I'll do that in v3.

These gain one and keep it, since they do pass a local:
__skb_checksum_complete(), __skb_checksum_complete_head(),
pskb_trim_rcsum_slow(), skb_copy_and_csum_dev(), icmp_glue_bits(),
icmpv6_getfrag() and xdr_skb_read_bits().  Each of them goes on to
checksum or copy the payload in software.  I haven't measured cycles.

bloat-o-meter for patches 1-6 with the split is +1177 bytes in total,
most of it the new error paths.

> I'm wondering using a 64 bit return value and encoding there both the csum
> and the error coudl make sense.

I'd like to keep the int return and the pointer.  It's __must_check, so
the compiler catches a caller that ignores the failure, and a packed
value needs every caller to know how to unpack it.  0 or ~0 as the error
doesn't work either, it changes the checksum on the wire for data that
sums to zero:

https://lore.kernel.org/all/179199883858343.2.17884063473154560573@toxicpanda.com/

> Also currently net-next is closed for the merge window, and a bunch of
> changes in this series looks more like cleanup than fixes. Cleanup will have
> to wait for the end of the merge window, fixes can land at any time.

There's no rush on any of it, so I'll resend the whole series when
net-next reopens.

Thanks,
Josef
