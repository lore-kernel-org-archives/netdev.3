Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696F2DB7BF
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585564; cv=pass; b=foGlwrWnaV8PmMeifMDrpVg8VK7HRaP20E9gYTJRNGgTZQ4JOXimB0bC8p3UGkxIBlSXcGSeDls187SEBUQ1RjOKvQ9ljte7yh/FSrDC9c9zWVa1+cOp1UED1JF8ZAWZR8p6Rme9mEfis53QptwCxPc35csf5Kp6RZjK0kBV1wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585564; c=relaxed/simple;
	bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIxfgqR37tOrVUdrDrs+ofs+iYdrMo+bc1QoOgWvvKmIF/9PvTcZQq3dTvo8ZSU/lj6vGeq2KblFSUubz096JExBFE6T+R2yVKhuH4konkYZ/ejLzDQmIhC1WTO18BahiHb7h6Ibel5Ov0qnKrXnEjF8etXK3baTE0LZY33jf44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FY4/UpLe; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FY4/UpLe"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso175245ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585563; cv=none;
        d=google.com; s=arc-20260327;
        b=X2eHOBtL1DDL4kEIvnnEBDp5KveH35+tC5RfJi8hc5gv+7HgOOYohBCEpowFkwGZXB
         NNBtGtLaaN0qkgUUo9oIZnFli/mUXkJWkTHicoFbPdEs+DfKvAg3N7X2J4YYzzZKo3g5
         TMxHb+8oSE0unL0yMS1Lsta7IS2y1juE0lWu5Wo/HdUQm1HO4hsGBKr+aEG1T1xqap6T
         8sdCKMo1QS+/elzQ3Xwg3BLi5aij4KLSGyBrAqClXU+g2zaEE4lPQH2WKSJwnXgDOFE3
         8F1AuwTxipEnA65ULIAzDxLY/i05TpXeU5pgcsovVodoi7exo8chrZ+x50dQLYGPjWzx
         m6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        fh=BFTEPSwohNBdsSqCI8in/CcVmVW1ZlOCpQwfVKrqBac=;
        b=jzlWYk8vFe2IkFm90FOcY4sjytD9ieeYiw/WEzYa2jewR10Q30vr1rjGFsBaK0clED
         gFgevtO8oCLHDeNzWQY+WaCNHHCdtOcxRLjV7o1kbk56C1eR9dltJhJRYyQUgnSeqM60
         B7IBZfLd4MFF+W2etHJCq/q0vPoPxonZWVZxweLUfDISUA5dxMdBH8/11j+bUUz73/Mf
         oBR8KRcyF/6jHQhQjVioLViPzlxyP9aIa6UkXOYL7xpk/bJusTFCMnYQiwWQ8zCHbNuR
         A01RGv6DkRwxplltgfPOdIL+UG0NoLzLrdvw7oQdTIu3FkGQJaFExLwDCCgLMRv03Zl1
         ECRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585563; x=1788190363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        b=FY4/UpLeE5asGr+ZYS1AB5j8fDq5k869mMaIXfEFucXrY5+h+b1atIJxebGpebFr6o
         62kwCwAcR2lQL+RHR9WzR3QyaoQdoSy+bV0Ox2zlAnGoYYH4wqb7RxKrUpXOHkCcijUb
         k96YJZOJmlL+0MzgyfJyXYl+OBXh0A+6X9gEfXIf92g7Ft0zp+wE+8OmSgP5jCiZwdTd
         nB2npEeTb51sLhNFkxCTnoB6rgxTyX4dRvMjJwhEd1RY1CMgstpPQDgjvF289Y0tqnmW
         ODX8MQONNZw5wifcDMuo4l4u8iljXKGhHwC2wJ7jBcHPxLkipgSr91TpajVcqOEOjsX8
         6d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585563; x=1788190363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        b=hcKRbydnlxfa7eD6tX3ZGC58CmSiT1i3gZ3cggHtKk+FhgZ5+46rSt2p7yPPubFy/T
         +8FDcunKlaeb177Any1oi/qn7sdblVQf/jGob6fY7pEeDu0C4PN6aGiAeeypo/8ejN9M
         pOncn13t3rgxl5E8WeGDixnilOdjl4zEq7Sv6JeldyWRvZUGiToUrkhi23vq21CJKKKM
         rqUACB5OwFfzvNM/f+UjFxjWMtGnclVjdaBNBidMARS8tNkQ+4faRpfMTT9prCfIv6cS
         28odJ+KUowd/fEHrBsfP8BQlyx0ovWhMEq7Tk2HKrxPxmhTKfqGm2QqfVZS2jj1ZiM+m
         XCmg==
X-Forwarded-Encrypted: i=1; AHgh+RqznbmzEj6Wu82B32Ymz20F/ZrxbD+Guc4L2C6ugUMqDNhivkQ/ZqXNbjTanr2iq4hRuu1JCeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lSR1bseXlEUWU/Wha6EhFMuEoIfeBaWPzo1Aki4eMjpAkKqAhB
	NGbVfQRHTwC3a5N+A1ugGatG0XZESQvGoY1eBvxHrOqaRhKxjK7xunph4SUyWAvET80NIn7XnJV
	LUs1+D03FmjHcizm6BZr5Vl7RVArE+FRc+b6koHGS
X-Gm-Gg: AR+sD133nRqxXPTp8olWkepevALA4Aj9wdOmkJRSwAoOzoUe7n+r0fsOqgyub2fM8s3
	YSZ7Y2DjwimVZrfa33tRp6Z7P0MCprt+m29ht+0nVPkJAWyCLV3v26ULSXtYImufbZlP00NN7uU
	Xw3DKYHxKQjNFTNQQSKghOzzmJt8Xw8lppruY5qPwDzNMLjauyZQC6bgn7F8M2EtdwYxMe1DLyE
	xz4c0Lac8CBroKmXrqfgVbBXVO//5Vciuhdpc7O29V+19fHDbgypD3pR6BxB30NTlAaPerjzHav
	joKWHS2x2m9+K805cHIK7y94vlAFwpbAfU/IS7ciLxJcHDlfTolnSReE7CNF5w==
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d673b9e9f2mr10182565ad.9.1787585561896; Mon, 24 Aug 2026
 08:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
 <ajEuUZMgS_NRmDcp@google.com> <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
In-Reply-To: <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 24 Aug 2026 17:32:05 +0200
X-Gm-Features: AcwNN1VGtdaRS1g0BYe1RjEgd2mMtkM251D-YEt_DU0VPfQjcinAUbJbvNKEsc0
Message-ID: <CAMOZA0LJ9qTs+d5Mg9CB1Pio-Kw1HDmuVSMiz=zUZdWFC7zqdg@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, Jakub Kicinski <kuba@kernel.org>, rizzo.unipi@gmail.com, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com, 
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:59=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
...
> An example of this is Jiri's system_cc_shared heap which is a dma-buf
> heap with decrypted memory for userspace.
>
> > I am still looking into this, I was planning to bring this up in the
> > upcoming LPC.
> > I will give this patch a try. However, I believe that we need a more
> > generalised concept for CoCo pre-decrypted allocators in the kernel.
> >
> There is a talk at LPC in the networking track about this [2]. This is
> exactly the type of discussion that I was hoping to have there.
>
> Besides the issues mentioned in this thread we've also found that a lot
> of overhead can come only from swiotlb allocations when running many queu=
es.
>
> I will add information about this series in my talk. Hopefully I will als=
o
> have time to add some numbers for comparison.
>
> Sorry for the late reply but I spotted this thread only now by
> accident.
>
> [1] https://lore.kernel.org/all/20260325192352.437608-3-jiri@resnulli.us/
> [2] https://lpc.events/event/20/contributions/2464

Thank you for the feedback and links.

Do you have some code describing [2] ?

I just sent a cleaned-up v2 of my previous series, if you want to try
it please use the latter.

cheers
luigi
