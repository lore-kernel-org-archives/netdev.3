Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97454231A3B
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777344; cv=pass; b=hT17/AQb9WEf7M3EhXYU73c2CwqeDHAmZvSqVeourCJMV/IpysONzMsvphPoZJYEuohnODmCBaAFyOMrP5wpMUxr8h7L383ULF9jesn92mutywI/w8rXk7dTXujTPzrdvGj2f9cGofTSxPvoyqTuGFTeOk0Y2Z8WhRGL9AJuHss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777344; c=relaxed/simple;
	bh=D8wtMsoIg+Dp3XnmklabhldJVDQN33qVcW05TkIASqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2JOZ2xuZ9F9qm0aBFibo54eIlKt+vaUVSKDy3VY4GeGt3zpkImfvYduXs8Eg5XOqga8+Ua8fpN4gPIxxnkm9Hj+kNJfwXr/s1zeYzVETSYCyFYTv4ynNnXfcLrXoyN0axYvSQifGsjDCYjwTTNm9I7XLwrWGmU/9wr550HI6hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=HFtXYNrj; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="HFtXYNrj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8454160043aso1837961b3a.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 06:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783777341; cv=none;
        d=google.com; s=arc-20260327;
        b=BfN4SbuKVpzJOIFVejS6tGHxExeD5OPcmRw4zQlrk7y8G+XlpWaEXXDVvmQcdA7X3C
         xBY9u3bNG28/d7Mkn7kM/IH4uXd/FqlcBBaC9t7ljiKdxOXjbReAKP+lOqdg82WdGODD
         ApKRAo+/qDvzKonMsYjW45w2oQtfm6Gu3VcpuqQBp0dYof2lQV3BLDGAIEWmaOZNqxBT
         K9EQlvwXvyOQ+t5QmlNhcngwesqpmc2u0kkERf3FYLlAY0PG5qnZEUMQ5n6tTOy30EEL
         +Jy5rtb7knhwzYP7UVig3IznZ3r5ywx9ARJFNw3RmBqG0+G6A2tWwhiFiLODIMoKmXrx
         kNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LWfZi4peGV1QTAPmyJSmgBVDR8o+afiQrclwaHx7TKI=;
        fh=RCNFP3+BSC7cw/E99sLWI5cckNHQk2kCTDxDEBemeK0=;
        b=mbJJSSsIB0hXw0SyUfDJv3zM6yDgUYtQZFmshw0NfQAVQjxOvEWU/2G0q9y4pDiekL
         HQIWixb6G1zb+v2Hp/DLVyHKK+21KQDSmPMRFjQRnQi+7wsBS/R8gtM/tx6UuN5aGIY2
         n/41Taj0+dcgJz7UzYXmO+x6xynAVbx8Mpz8k9sKKHSse5xRhqlatUydHFz/hRahlLtB
         Y5SO9ilmNyW9WW/jkVDIIG1/CXccCFavbAREEtseCuDeD/MLGUoyw8yapbTgnezLdJiH
         7k9lebx2zm1nWRNmvZSF9c2+RlAg5xQvt2MH7mrC3qSFkiEcSXcd3vr6gowZdpBdsj5X
         OVhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783777341; x=1784382141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWfZi4peGV1QTAPmyJSmgBVDR8o+afiQrclwaHx7TKI=;
        b=HFtXYNrjFJbX1lwEdH3YI1w3hyFU4Gys7/wlErI+m2ipKHdl+o9erptETML/5+1C22
         xX83Pdkxm0al5NURasxBhOtIWxz0SnBA+0EqaZ/69VUBJL1syqtsKEzeqjjEQD2/m/96
         etw+QN8LeFWJMia9ueCP732HSAfaUYf2rAtoU6VVLM0rPbqw/YV0eF7XdUVKSeDcJdow
         ArXJ+BSLmuC6pU2bbcKMGFrViTyCh+kHUjpRN6p7LUYjegx3CMdggb24fqMhPHwXJcSC
         v3lfNrmjywpc4bihsGKIKnYgLPRd21Ie/lwKWSB8tgDp9xKKqJBkg0bHHfGSPUQxJ7OH
         /c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777341; x=1784382141;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LWfZi4peGV1QTAPmyJSmgBVDR8o+afiQrclwaHx7TKI=;
        b=f9uB1coAo0OxnsjLni0gxVtzwur5oBLYV5KhnPXVK1xGKvEH/HqMLEmq3TzHifIbIR
         2ZUn5Wk3UBGEgf3J5XFGfshvm13ZKBoUcWTQN31ueGryIf/voFemAuxwJVa8slRwKMVn
         7TJiVjti8jRxpuNqmT3Xx7WQ7FEw145EtyYsafv26LpxweVZbzm6YSWQQ/pJ/WXJHeR8
         F95D6MjQQWDKnp0zPfo16P2wOh+8841g/wTwZR9Q9oQv25tNfS7gQ/By4rwvrEOuMRnT
         KATkBEcKQg/gkZ3dzWN83U6c9A8p8UYFmvwJyT8Oktur3rhVGiKTzWh1BmnN6k+YiyLP
         Q9pg==
X-Forwarded-Encrypted: i=1; AHgh+RrjeBPS4lypZYrY+TtAgOu7qw8XX943ySDLg7kbjTOvf0LnsshigjXks1HrfXur7Xdu/5EBKN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOf0Kj34GC+TJyqcIvd4UX9eodRexboHm41QoyxbtNXa8x0vfy
	qUKmjmekKo1uGhQ9qvK+/0SzhNvzR2nN+rUxAVkG9sJNc5zC2yLr1/Y6rP68Iufm17DXgZn7GXn
	JG7+sIJHOO+a9b1DOP2+yZ9zzwA3Rpbi3SSfIok83Psc=
X-Gm-Gg: AfdE7cl+IbG6CgMCDICKGVPe92IlW0UIrLQJA+kvfrroiVbwL9wlV/P2n8+qcsBF+vc
	aEZYeXcNKAxNFtqCJ3/A8hFIJz0kKz2SVbitK3ukEkvaosR25/qy0TZUDZ5jbzxsmp1Hg2OAmtN
	2HeN8AxNi8Jrz8z3tS/cy9k5bvzEctuw748xxqoiaxhj8Rx1DycySeyowesTjWFB5q95Gz0vupm
	kgN1HkBvXvGqp6jzN1g7W3+uevsiLbqBz9fThkhcvQl7F4249FE+JPz9/FbZuAgnhd68CGinE9M
	jOU6S6/eFLNN2axE6MEt/sFFD2bhui1X96hr1zqDjaTy9/bfWGttS4A4hOBw
X-Received: by 2002:a05:6a00:1a8c:b0:848:75a1:a0fe with SMTP id
 d2e1a72fcca58-8488964a85fmr2402916b3a.18.1783777340938; Sat, 11 Jul 2026
 06:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705115607.60844-1-doruk@0sec.ai> <20260710134850.1615092-1-horms@kernel.org>
In-Reply-To: <20260710134850.1615092-1-horms@kernel.org>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sat, 11 Jul 2026 15:42:10 +0200
X-Gm-Features: AVVi8CdLqlNEskOPt8zOhB7HA2eUmFLDg9kfoZTO41kedGPfeu27wPJbVjh2bA0
Message-ID: <CAPdMp1omRz=vFN=CQsiXDbf+5W3SF-F8BGm3HuNeLpp1uS4UUw@mail.gmail.com>
Subject: Re: [PATCH net] nfc: llcp: bound the remaining LLCP TLV parsers to
 their buffers
To: horms@kernel.org
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Would it make sense to either guard skb->len >= LLCP_HEADER_SIZE
> before the two call sites, or take the same skb_tail_pointer() based
> approach used in nfc_llcp_connect_sn()?

Thanks for the review Simon! I went with the first option in a separate patch,
since I believe the missing minimum-length check affects every PDU type the
dispatcher hands off, not just CONNECT/CC:

[PATCH net] nfc: llcp: guard against short PDUs in nfc_llcp_rx_skb()

It adds "if (skb->len < LLCP_HEADER_SIZE) return;" at the top of
nfc_llcp_rx_skb(), so no handler can see a sub-header PDU and the
"skb->len - LLCP_HEADER_SIZE" subtraction can no longer wrap. With that
in place the connection-TLV parser's bound is safe. Happy to respin
either patch if you'd prefer both changes squashed into one.

Best,
Doruk

On Fri, Jul 10, 2026 03:49 PM, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> nfc: llcp: bound the remaining LLCP TLV parsers to their buffers
>
> The commit adds pointer-based bounds to nfc_llcp_parse_gb_tlv(),
> nfc_llcp_parse_connection_tlv() and nfc_llcp_connect_sn(), replacing
> the previous u8 offset walk which could wrap and produce an unbounded
> TLV loop. It cites the size_t underflow of "skb->len - LLCP_HEADER_SIZE"
> as one of the failure modes it wants to close.
>
> > diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> > index 291f26facbf3..1a0a2f4aca70 100644
> > --- a/net/nfc/llcp_commands.c
> > +++ b/net/nfc/llcp_commands.c
>
> [ ... ]
>
> > @@ -243,17 +246,21 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
> >                                 const u8 *tlv_array, u16 tlv_array_len)
> >  {
> >       const u8 *tlv = tlv_array;
> > -     u8 type, length, offset = 0;
> > +     const u8 *tlv_end = tlv_array + tlv_array_len;
> > +     u8 type, length;
> >
> >       pr_debug("TLV array length %d\n", tlv_array_len);
> >
> >       if (sock == NULL)
> >               return -ENOTCONN;
> >
> > -     while (offset < tlv_array_len) {
> > +     while (tlv + 2 < tlv_end) {
> >               type = tlv[0];
> >               length = tlv[1];
> >
> > +             if (tlv + 2 + length > tlv_end)
> > +                     break;
> > +
>
> [High]
> Is the size_t underflow the commit message mentions actually addressed
> for nfc_llcp_parse_connection_tlv()?
>
> The two callers, nfc_llcp_recv_connect() and nfc_llcp_recv_cc() in
> net/nfc/llcp_core.c, still compute the length at the call site as
> skb->len - LLCP_HEADER_SIZE and hand it to the parser:
>
>     nfc_llcp_parse_connection_tlv(new_sock, &skb->data[LLCP_HEADER_SIZE],
>                                   skb->len - LLCP_HEADER_SIZE);
>
> and
>
>     nfc_llcp_parse_connection_tlv(llcp_sock, &skb->data[LLCP_HEADER_SIZE],
>                                   skb->len - LLCP_HEADER_SIZE);
>
> If skb->len is 0 or 1, that subtraction (size_t at the call site,
> truncated to the u16 tlv_array_len parameter) becomes 0xFFFE or 0xFFFF.
>
> Inside the parser, that value now feeds:
>
>     const u8 *tlv_end = tlv_array + tlv_array_len;
>
>     while (tlv + 2 < tlv_end) {
>             ...
>             if (tlv + 2 + length > tlv_end)
>                     break;
>
> so tlv_end points roughly 64 KiB past &skb->data[LLCP_HEADER_SIZE] and
> neither the loop condition nor the per-TLV check catches the walk
> leaving the skb.
>
> The commit message calls this out as one of the motivations:
>
>     "Dropping the u8 offset also removes the wrap, and for very short
>     connect frames this avoids the size_t underflow of
>     'skb->len - LLCP_HEADER_SIZE'."
>
> That mitigation is applied inside nfc_llcp_connect_sn() by using
> skb_tail_pointer(skb) directly, but the equivalent change is not made
> for the connection TLV path. nfc_llcp_rx_skb() has no minimum-length
> guard, so a received CONNECT or CC PDU with skb->len < LLCP_HEADER_SIZE
> still reaches these callers.
>
> Would it make sense to either guard skb->len >= LLCP_HEADER_SIZE
> before the two call sites, or take the same skb_tail_pointer() based
> approach used in nfc_llcp_connect_sn() so the parser derives its bound
> from the skb rather than from an untrusted subtraction?
>
> > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> > index dc65c719f35f..5e1881199238 100644
> > --- a/net/nfc/llcp_core.c
> > +++ b/net/nfc/llcp_core.c
> > @@ -849,13 +849,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
> >  static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
> >  {
> >       u8 type, length;
> > -     const u8 *tlv = &skb->data[2];
> > -     size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
> > +     const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
> > +     const u8 *tlv_end = skb_tail_pointer(skb);
> >
> > -     while (offset < tlv_array_len) {
> > +     while (tlv + 2 < tlv_end) {
