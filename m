Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C484078FE
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339663; cv=pass; b=EJAVFcvIKaiFld9bPHi9LLTZ/JRYC8nMnGkes/UQhgbTmXyzie5/ycvipG4h1Qydf775nh1tT8jLam1XvBO5rfmzMA3i1tUYQdA28BlZNpvwZtojDd8araSe8lBd0bAQeFEvlWTP+TfY776vOz0gmTWsPLW3UrnTWbCs1/cndOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339663; c=relaxed/simple;
	bh=uHZkeES0Qh015wvVfxByAkk2zg9ICYWljnWgfM+l2Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRA/bQs42yX6xh+O/pkCXmws9CSYIqATAZaH2g8UOMIgb6/22ioGRMe21a2Ef7sfEKeVBF+DfVWIu4wt2GxisPI0N/zXB4N3pUe2lytXNEQpzi8pPHrJpTR3vD+YVthHJbBjW8Qi762mKh7DyR4uN/LMM34TCKFqvRY+R0QgZng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3c2cPV+; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3c2cPV+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93905b1dc65so72889685a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788339661; cv=none;
        d=google.com; s=arc-20260327;
        b=c9R5fTZX4n7MKWW1+ahPMTOY2WZbZcvC0afw76RsW5bQyPhBjgt0xEqly87IxGKj0z
         /PhmXtrLxpJHIFWELaZFuRr+JcPed8vsI62GcyNwUS64QSyMxL3Xfy3N4YVQ/kPaAR2H
         bqt83GBHuXeA6Qw+aOxulFaA+iO9DEiho7ygTTmELl7voWeq6f74teiPKjS5EIQHQKQ+
         vjIQSLwzpUAWNiRUv8QUjY+SelYRYTE56bNPssxUf+GHi05AqJolz8NhFqB0okLGvxce
         d3/hc9GsOzGr4OxLxRSeattOoDhJ6McRxuS7euuQCmDZc5ZuEh2sj5H8pltx36ckhSm7
         isIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7pmAWuhF+rEO5j4BwBFEugZqHuHAY2sA8oL4ax0CzQ=;
        fh=BegRmQNkvq0OdHc+wJW+nzYDTfPw9c0MLZOhIeiDQN4=;
        b=mUBHL07fUDL+EPci0h8VyfC5QfgZEPbFJYen2853hNpoJU7HEou2lbv7yFdouSx18e
         qhIlQYjkOsKPLWK1aLJmkL0kBx7QVjILfxCmXks7dEq7PSqvCRmnhrm1zUBR/JbDPzMv
         Ah8w/8JNQqIgK2Ubn6vMFhwECgIMuZ+oxGHw7Hstxj+I/xrTGCrl7ktobRGqJIQULxqb
         HYFaeMR6JatVoOIqUvzDlfh6Mh597t9bO1UQIuKESptzIfHZzEVhnqQgieWoX9wzyOXy
         wIseEjmF2iKcyl/CTGRhYZkOMqJ8uMgU0UJ/CGcJcpfOMXhCwpdTdqyI6wpdSX5Ji79d
         OsdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788339661; x=1788944461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k7pmAWuhF+rEO5j4BwBFEugZqHuHAY2sA8oL4ax0CzQ=;
        b=i3c2cPV+8+zfLxheJtEVpO8xWJVaJVYvvKQzn6UqGkm2XccwjYNOhsuUA0zUQjLt+i
         nIEFEaoh8jEE+68+gVKHQD0VLYQzojLsXRkTDDTZP1+gRqkyDCClhvGbVE72ty16GN2z
         oeCO/TT0XLNy6B3PUttkO8/h2u8r5E9hu4I6KhGqAqt90xwnmz+Jybhe3GcXrdUVi84L
         r72p0FF8M59KG54jQrh46V37Kb9IdgKllKPftCdVVc1K72An6rCi6MfUd//wvrWqEb8F
         BKcFRpYOFI/3vfem4t7oI28lupPqnTt4ZMuXCz36EvEnNuwB6+xwbUvLZ/G13Td6Obnt
         ad/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339661; x=1788944461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7pmAWuhF+rEO5j4BwBFEugZqHuHAY2sA8oL4ax0CzQ=;
        b=HCh7sfrdHf1qZ5DQuwf/a1YaX43HAFgc+deMuwbKVaf22U4NEmPpXgXyo2THseGKN3
         n4PAb+LSlchH9ST4wL2MGBcaMsOcbu/IHLZFcb9D93ePj1JtU3jzFlS2EBdcHpem+Ejn
         XNmi03k25Kn2mg5rz7FBhF9EA4okxIyKbb2K+OqccAGWw3CdECKq+pSuvZe7zT3/ORGn
         /yk4UWvC8yvGJJUad7OVTqboic9C3UDiCvuczeRK2xUCqC0MrkQDmpbtT43/OMHXTXAE
         jr/m8qSjHBgma00p4/1xDJMg7lyxRxFAi4jJBjwQ0yFBZPmiK9hBTTFBaUWMMWyQjpZA
         WG+w==
X-Forwarded-Encrypted: i=1; AHgh+RqKD5gXQPSmxsXC5ARo2udkhjv//qcPr4bRKoYIos2ySp0ZknhLw042D4aGSH/V4a5Q1PCZD+c=@vger.kernel.org
X-Gm-Message-State: AFuF++khJbuEmpdfZzPRGiX0vwTRIl2CfUqz6L4cVd7ly/diHycjU74V
	lQQIuCr+oJcIONG1WJZdbnkC7SsTrCqAWxnCPgqbuam/ekDh3DSSt8HhaKFEpUciOVfiTxrRAPK
	Q2qleSqbu1amwJMhZUs32WU1fSC0YOP+DA42b0GL9
X-Gm-Gg: AR+sD11he9D6es6z8rsf59YcZBaX11SsuQCWKO0AwAFd3TreYs0s9sR7VBpGzCcAFo2
	AN1ZMwpraa/yZGuxyMgCe/3rI9b0lrUgaUGSe6JqQw81JQWEBSWqrIdNuQrL+MdQo4p+QChDWF5
	665iwBezsNL5ESk5eWNtLr/9URb2M4ut+aofTp+RC2Pvyo1/ggu29SanY+UqngRFV7YBuVP6F0I
	nyanKptGxzsmIIifGwUPsyMpl23pgsopjSu2NfroFEe/HvlM2W100x8Hcml1f32d9PnbgO3ihCa
	OKcnrg9mjflrMBL8PJ6nMHMK9T5NJXqexzgAITK40o7s4/emv/VfXnXZLqCn7trR1b3gb+XbxkN
	p7L8jPcoQD2gL45Saf/5d3ieUEOPozx4tlt59QywnL3tjyYFl+mok2cF39g==
X-Received: by 2002:a05:620a:29c9:b0:936:883d:89c6 with SMTP id
 af79cd13be357-93960f53c0emr385584285a.28.1788339660414; Wed, 02 Sep 2026
 02:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com>
In-Reply-To: <20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 11:00:48 +0200
X-Gm-Features: AcwNN1U-GKSWJrM4lQsUKKOSfPFZUxKc5tSDWT0xE280LLCX3qc_9KifJy9YK7I
Message-ID: <CANn89iKUqjbrRkr68+S9nKAu49C3K01e3XSNwkY1NCgmuPMPag@mail.gmail.com>
Subject: Re: [PATCH net-next] seg6: reallocate the skb head on L2
 encapsulation only when needed
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:34=E2=80=AFAM Yuya Kusakabe <yuya.kusakabe@gmail.=
com> wrote:
>
> The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
> on every packet, where the IPv6 encapsulation modes reallocate only when
> they have to. This site only has to fit skb->mac_len before its
> skb_push(); the outer header that follows is already covered by
> __seg6_do_srh_encap()'s own skb_cow_head(). On a forwarding path neither
> reallocation is necessary: ixgbe leaves 206 bytes of headroom, against
>
>   14 (skb->mac_len) + 40 (ipv6hdr) + 24 (SRH with one segment)
>   + 16 (LL_RESERVED_SPACE, via dst_dev_overhead()) =3D 94
>
> for the whole encapsulation.
>
> The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
> distributions enable: every new head is zeroed in full, and that memset
> alone accounts for 16% of the datapath profile.
>
> Use skb_cow_head() instead, matching the IPv6 encapsulation modes.
>
> Throughput at 0.5% packet loss, 64-byte frames forwarded through one
> 2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
> binary-searched over 10 runs of 10 s:
>
>   Before: 660.7 kpps
>   After:  991.3 kpps
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  net/ipv6/seg6_iptunnel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..a6556efd8e0b 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -446,8 +446,9 @@ static int seg6_do_srh(struct sk_buff *skb, struct ds=
t_entry *cache_dst)
>                 if (!skb_mac_header_was_set(skb))
>                         return -EINVAL;
>
> -               if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < =
0)
> -                       return -ENOMEM;
> +               err =3D skb_cow_head(skb, skb->mac_len);
> +               if (unlikely(err))
> +                       return err;
>
>                 skb_mac_header_rebuild(skb);
>                 skb_push(skb, skb->mac_len);
>

This is a nice improvement for forwarded traffic, but locally
generated TCP traffic
is still hitting two expensive reallocations (second one in
__seg6_do_srh_encap())

Can we combine needed headrooms so that only a single re-alloc occurs?

 headroom =3D skb->mac_len + sizeof(struct ipv6hdr) +
  ipv6_optlen(tinfo->srh) +
 dst_dev_overhead(cache_dst, skb);

err =3D skb_cow_head(skb, headroom);
if (unlikely(err))
        return err;
