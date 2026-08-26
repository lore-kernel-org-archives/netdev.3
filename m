Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEB44BCB0
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759475; cv=pass; b=tNDXkKFdU7HignMXSV0ZDGlQs0W3ir4ZEOsO0EehOb2n09d1Sau+/4snYW6bUWhsw8T53Ru+plOuPU+EBZphJ/5mwPLLqV9FVbW/XnLIxYiG7rW6045ipHJvNs3Y1ZMGHmmhc4jc8QwTut44m/Tp0N4mRxoDkbF0HrjHuhtPpPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759475; c=relaxed/simple;
	bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWR1z3n2KBTx83xy/axb7UvD/Aqx0ltg2H9R4w1ryDR6ugmem0F7eMXZHc8K6Z779P+KPCnXszZ2Ek2ful2GUNv1WkeEkB8s5uulG+jGBCuipiWUgU/+064MKIbDtuHZaiN29UsqkXge1NGmGfAmAa7VTzf5A5qHhNFOtHxLZrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qswtbPl1; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qswtbPl1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so7998491cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759460; cv=none;
        d=google.com; s=arc-20260327;
        b=TySwkl/oXPlJb1ZW+DZLmm2LJ+jUQEAgc1Ap8TkYL0/SvYfVFNeAcMY57O1nqWPKoX
         iGzEgCldlnw/KI/OC6rOO6NnquV4zNa20TF27jGngbUaEuBSgPep+nrlAz55VDdLUJww
         FBO5+cb3KKksN85Q+jhmih3m7YqPNWt2l/5MCU2mD2wSK/37aJXMHn88VS3AkoZzL1VO
         WqCT64UaI8jjNqJGGaSgPhj76L8qWN1yv2YqxlAJ6agLa6bpiXu1AYnF7/xRC8rS4xkl
         uIC4YEgd8JSrt3LZyikBHVHo/s8X1Yai6qTWltfBuz9xrH9pxVBZxGq4vtrOfPvKB+rA
         PjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        fh=MOvxSdLiZAlvO836QWHy+HHvo+qh4a06Z3hxUk54CkY=;
        b=kU+5OTkVcm0t0j5+w5HPmGoJDPHEW5LZfNQe4c7Vsv7Pks/TijQbgKBqvx25i34gTc
         /gHF33VlipBUemuIkW2ZlddmUU3LtE3duJwYAKc26mpsZQSg0O19olx/NJDw+yLYROi8
         Ny82oTSAMbC9oJJFlegtXg+0r2qTuBu9sTPVu015/EnXBrNmgYU7eF81X2/33/moYW+T
         fqUbMb42LDB+jiefoY5hC8QcDM1Z8Y8z76HioJRb4O2g88pfMSQA0Q3tayKUQJz2WHa+
         h31DWnCoIW0jCCBoSonJsejSfWH3mjrwcB/GAz9x/2OzPgsEmhVbKOdnBMBS7n9ELArq
         Z2Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759460; x=1788364260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        b=qswtbPl1fgclFZNoy/X9lj7r0Cbue6TVtMWwHEqk1ocUJb0LkU4a4D4XlHWGwD+47o
         3pc7MCNUbN+NWQMWf/Gkfwa6bEZCXKaQQPXgA8r4lntTDdo1EzBGqalvXOPivCgdaGhb
         rEqYCaTDHco2WEMT+k03HeIrJeYSjsSgPLlpxlERjY7DdHLrqvpsrhhuHw51fOJuzZJF
         Rnk51ItKTWPU1xIA8Ty3uJB/BYkNM+nWHFbWaDOfsheCtcK2lVpxzEG6eP40o2fYqIws
         TZ3WCve+lo9G1i/Fm3l+puW84/gUsWMsOfpUB3Mh/dnqiNKBE5EcbUQ/bhzN2m7LOvC2
         B7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759460; x=1788364260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        b=FbR4bBA3OMXGTemJVpHLnM9BEOMLRcMMFxbtqHSXIAYE3758FN7mWS+cR4nRUe0T0s
         h0pgyZMVLfbjuW8cwtsB4VvZIFXp2Qm5H8Z+WTUOMYWtdhQxSbiIJ5QdmRoRSccH/us+
         rUoPmPFdHSj05i9LEMBysDzi7gxmkEieiacY+uVPzEvC9RHRsTyVdJ5lHRx871Z19lh+
         cezciVGKzPldKl7H5LF++jqgZfFdvhZX5fRnYR0Gwqg5/ADh1nOmtpTjENCKdfbVd1ug
         Zbhyo5FeqT/p77iqXkiGVYP9mpVG/qAbQSxG13UyKiT5WTrY09ai125OLi0HR2LhjfKx
         2bZg==
X-Gm-Message-State: AFuF++nnApZJzRnEeaqiqxuEiX1k9kxhFPIIK3lYSzEGrxAnckpckt02
	P3OrTVmo1ou9wG/bDqEl49Gf4u6/leQiIYBHNgsaZ1f1bR6KKEHQwt4xF1bL+qawf45GIxcEpif
	JkDVv3ouaZ/JFmvAjteEKjsj8IvhTBFtiUI+qFheQ
X-Gm-Gg: AR+sD12MiGPSwBnvmava7Ku288+9zFmfHZIUSPjxpBjrRTQqqO4+VZMmi8hfLUxLFoR
	eEAnpZ/eTYLyP8tOExanQHIQQnDtD6RF7FuVqWQTqGD4tFQuzj1tG4KD/+0z75YSUP6vncSQbFK
	p7mxvakRK28uZPp2tXhv08S5tpzcYeRqHJrO1juCzGLlx+Muu/iDgJUuWNinJfHdms5E8H5iPp7
	Cb65oxGnPLU3dLIhltqCjvZwAABWyyA6eUe5OEWD20X2pbPqYgmiZZjrz9kiFpXnSoQ0phUTH6Z
	L47HuntwL82/JfAycMqewxULHAIBmXs7iJseCU5EMuQunZ5HNlntvQKYXvZ8s8qHEucYG9fDmNs
	S53zsHFlgKbtjVnVgDKSFkVyP7bKq5y12EVspA4TmPt9kPWc9AQpPpZSdljc=
X-Received: by 2002:a05:622a:4289:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52e422b9d6emr89018121cf.16.1787759459102; Wed, 26 Aug 2026
 08:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826143735.1819315-1-idosch@nvidia.com> <20260826143735.1819315-3-idosch@nvidia.com>
In-Reply-To: <20260826143735.1819315-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:50:47 +0200
X-Gm-Features: AcwNN1XKVmsq9qlIneXAq_oVYgYQ9kV0wMAFA4-E2BElxjRMp04X_87507aK5qk
Message-ID: <CANn89iLumDBStvkh3f3V3ApBNw2PKKgpAioeYMi8xrcxsMme3g@mail.gmail.com>
Subject: Re: [PATCH net 2/4] ipv4: udp: Create exceptions when socket matching failed
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
> Currently, when ICMP Fragmentation Needed and Redirect Message packets
> are locally delivered and quote a UDP packet, a FIB nexthop exception
> (FNHE) is created only if the kernel can match the UDP packet to an
> existing socket.
>
> This behavior allows off-path attackers to conduct a side-channel attack
> on the FNHE cache in order to discover the ephemeral port used by a
> connected UDP socket.
>
> Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
> less predictible") tried to mitigate such attacks by making it harder
> for attackers to discover hash collisions in the FNHE cache and by
> randomizing the number of exceptions a hash bucket can hold,
> respectively. Unfortunately, both of the mitigations can be bypassed.
>
> Instead, mitigate such attacks by always creating a FNHE, even if socket
> matching failed. Do that by calling ipv4_update_pmtu() and
> ipv4_redirect(), the helpers used when the quoted packet did not
> originate from a socket. The resulting FNHE is indistinguishable from
> the one created when socket matching succeeded, both in terms of cache
> occupancy and in terms of its contents.
>
> Pass an oif of 0, in a similar fashion to icmp_err().
>
> Note that this does not allow attackers to create FNHEs that they could
> not create before, as both helpers can already be reached with little to
> no validation. For example, by sending an ICMP error that quotes an ICMP
> Echo Reply or one that quotes a UDP source port that matches a wildcard
> socket.
>
> Also create a FNHE when a socket does not wish to accept PMTU updates
> (e.g., by setting 'IP_PMTUDISC_OMIT'). Otherwise, the fact that a FNHE
> was not created can indicate to an off-path attacker that a socket
> exists. This applies to all ipv4_sk_update_pmtu() callers, so ping and
> raw sockets that decline PMTU updates will now create a FNHE as well.
> Such sockets are not affected by it, as ip_skb_dst_mtu() uses the MTU of
> the device for them.
>
> Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
