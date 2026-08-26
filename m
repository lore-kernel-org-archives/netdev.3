Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E844C678
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759489; cv=pass; b=HP2sCC45eg8MVoShb7LmyKrM1Y/8xXIzs1H5wgB2CbIQt4+Dct25ANxpRwvCQpSVHpXOZtlG7aVe/INCHQ0GmmAqUllMJDOtnrhaCNiltSzYPxtLMdGVXztimKGSd4sQCZshgZ9/mEsiV3BeGH1+vfkTuy/69wVcGD7lv9+6iiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759489; c=relaxed/simple;
	bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leEJNeW1ts4sRKO5i4PcBZoxfnUO4dsXezoi2EQjsbmRuoYmrirhQYVCAQ3t/Q8knuGjzZtgL0e9QQzI/uZmY5LF1ugHN4AzEHsIVqGuZ3czaLoDYvOb8vkBA5ZNfy/l6UbMWbSEF3C9GEtNG2+kQ/BUDevpHvQGzqxU+VHQWt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYHDUfNF; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYHDUfNF"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52de50e77ffso10566041cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759483; cv=none;
        d=google.com; s=arc-20260327;
        b=RKl6H1ffYBw3lnzq5wv9BTwMhYs4SlOfJfPLIY+lRhV47HKdNNdYWFEx2+BAkFYb9/
         tvs82QIxgS+pbwCcSXmFP9qB+Cr3cfIQWnJy3vqx7VKTnI7dOeobaZgZS0fJbUgnt/Ga
         CdedJDlUsqzewfBUFGouBtX+We4y5icCMnEUDX0wa22oFujHREDjn8/vcASllC1wYcO/
         rexVQsadzyw7my9/ZzyBmbaSoGdX4fHGbMCwVJuyA+TVDcxkBqZTMazvj42RKwp6u0Fy
         5WyIjgT3lHYp6lMFbLnyyRd84n6/P+v8psi8YD9HYMDIdJc5WZagbjBh8/JglIFOZya1
         eDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        fh=MOvxSdLiZAlvO836QWHy+HHvo+qh4a06Z3hxUk54CkY=;
        b=CRaDjHv7ZpyE0DiZ+IDNGSTVyzFyNpENTSbbY0VscLWgVW0/AygtAmf9m/6lV3CSYR
         QbH8mW+dXy9+bSyTFMCkD9dY8ZjaSQ0REplVlYd39izKc/Ad4RFZxJ2CEVSm+Zg1T4k1
         uhfLRF2qQLeanV24kAuPx8YNLrMjYS/RHP99/lsg83G9GgTKB8jSTYouF2HqG242//nI
         ZMGLwKOsqft/oKFK8oYHW6L1O3vDfgbnW6tKnMEwB4eOKINZaRw3M4wF4s2xupt9Cibn
         DIrHBPtjaFjqUoer3es4CMuN/R+3FCZASTw5gXO6uJ0+/E9FozxtIoFT5yNn+43Ep/1Q
         tbVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759483; x=1788364283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        b=AYHDUfNFegDEmMNzE9qpyZLQfKBTi1s7pL2KWjAzzYywXTEwSMrXtkJrW+QC8uYCWE
         OLXm+b/HpIaYwDcFt/nu0NJegTqWCBCRb1NJGTYo25nQjwRrXQUplD80ExdEXjDythQa
         BD4TUB53FBbb9SIyjbSFD4PgEHbm383fWEP4u60woL8HVd3oFXnJIFgDeOF6cSq0B3V2
         VHQaNf4prW6nVy0xWVZOsniEDa0qqCRmRU90RNnFYV0yd3CzFeQmIK1atp+j/ccmbtE7
         2q3RD4cTuOoY76Pk7qc72IaRFs4ONOhnp2PAD6xJ//+ZqnVLgP9DXxkcn93ai7AFFpDF
         7TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759483; x=1788364283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        b=s7yHexm1RkrxK9VZj/ldKV0ibaSZuNFOjmJgH5ZaQ/IKjxylXR/EkK2H5a34oTQRho
         qVQvRuogXHFUyY9n99XOhHJ8k7IwBfEYarnj0yHrUuKbUPf+CikB+u4/A8ufFK12Dy0y
         +Ciq23ioSjjIXAB7XY5ze2nlidqO6zHvMhVdfx/gftD9m4pnkM2no7NAONdrBou+Tbk8
         p/C3cdY5JcEuOMd7E51NTgbg5E4MYYDxvcA8yWKtbu9tuJuNwPQjqLVqZf0lKhKD+PpP
         C8GY1qq1myLxjb00xAFubzq4se8VmXNU9U2uiuyyZWPEzDwJwqtRBtyuh7fGaBQ3CA+L
         ve3g==
X-Gm-Message-State: AFuF++ncnZaeezBzsnNXkgeey8OPhQtafWGgpOyDniiF97QycEkXclMa
	tyy3MF4StGXLGaV0yvJFcO/0PwmXkRc29DO0iZn434Mgs5fldc+K0H2yCKxFfNIsJHVCvT/JTda
	s6ZqGp0E4nXoEobnZ2m1Y3i1IZmcpAGmmtzPu1Sl7
X-Gm-Gg: AR+sD10d1qh+iEQEYvubuAGUJGi8lxYoABQ1WRvMLRo3Y3gZj79EhQyIc8Hppb9Mjwx
	8TgzIMQD4MKOD4egbf5JgVR+r7SZghp0Z1c3J70opGC+M0YuhiMPbL5gliIQ98+GZKEZyrfbnqQ
	0yrJDXfz8l/zp+9zq/upfdfWz33WuNR8z8nj5UQ7f9umw+U/KxwP0FoIhijeCzAwbZ8r977G9oz
	953VjdoAxSTfBlljT/6j+vKuAhi1rBTYqI2c4O11uXizlat3GIGMMSUe3GLkQcMnrBOScMlI9cL
	WmdaMAibHTmm0If6VpFBMEJrRGtsfyD6tJrOsreDOGVmv93yx2HRl1ZhvzxzIyH0PGB8cobjC0r
	x4CDyq1bsgFGGtddeX6TK7XwwhHZHS555HiwEi0vQle/qqKiAB+VikcTAFhg=
X-Received: by 2002:a05:622a:e109:20b0:517:875a:d634 with SMTP id
 d75a77b69052e-52e422daf0amr54023891cf.2.1787759482234; Wed, 26 Aug 2026
 08:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826143735.1819315-1-idosch@nvidia.com> <20260826143735.1819315-4-idosch@nvidia.com>
In-Reply-To: <20260826143735.1819315-4-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:51:10 +0200
X-Gm-Features: AcwNN1WtL_35bV2gm4CNNp-SeVW9846oHPeCQvxx9DnsMwAuCL8obm53SfRbHRw
Message-ID: <CANn89iKDuub6PozapwA9hkjYKjYQOOccVxKzkj2N=MnUaq_H9g@mail.gmail.com>
Subject: Re: [PATCH net 3/4] ipv6: udp: Create exceptions when socket matching failed
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com, 
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
> locally delivered and quote a UDP packet, an exception is created in the
> IPv6 exception cache only if the kernel can match the UDP packet to an
> existing socket.
>
> This behavior allows off-path attackers to conduct a side-channel attack
> on the exception cache in order to discover the ephemeral port used by a
> connected UDP socket.
>
> Commit 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()") and
> commit a00df2caffed ("ipv6: make exception cache less predictible") tried
> to mitigate such attacks by making it harder for attackers to discover
> hash collisions in the exception cache and by randomizing the number of
> exceptions a hash bucket can hold, respectively. Unfortunately, both of
> the mitigations can be bypassed.
>
> Instead, mitigate such attacks by always creating an exception, even if
> socket matching failed. Do that by calling ip6_update_pmtu() and
> ip6_redirect(), the helpers used when the quoted packet did not
> originate from a socket. The resulting exception is indistinguishable
> from the one created when socket matching succeeded, both in terms of
> cache occupancy and in terms of its contents.
>
> Pass the ifindex of the ingress device and the default uid, in a similar
> fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
> nexthop in ip6_redirect_nh_match() and no exception would be created in
> response to a Redirect Message.
>
> Note that this does not allow attackers to create exceptions that they
> could not create before, as both helpers can already be reached with
> little to no validation. For example, by sending an ICMPv6 error that
> quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
> matches a wildcard socket.
>
> Also create an exception when a socket does not wish to accept PMTU
> updates (e.g., by setting 'IPV6_PMTUDISC_OMIT'). Otherwise, the fact
> that an exception was not created can indicate to an off-path attacker
> that a socket exists. Unlike IPv4, the check is performed in udpv6_err()
> and not in ip6_sk_update_pmtu(), as its only other caller, rawv6_err(),
> does not consult ip6_sk_accept_pmtu() and therefore already creates an
> exception unconditionally.
>
> Fixes: 2b760fcf5cfb ("ipv6: hook up exception table to store dst cache")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
