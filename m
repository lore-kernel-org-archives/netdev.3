Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE036F90A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263854; cv=none; b=iv3NYRGX6CmFSGiSLRMXW5/Crg8uMW8px0TcFfIXnbG/IqGoIQuBb+CcChdcjNX/eqxE8OQ87R5KgompavHapOc20c+b7kZtZMKSQurbsDz7bLlO+EPy9O3zBX4ixBTqxcHEU9sEe6l7rF8mpxrB77cxNanfGZj1vXcTPTIAi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263854; c=relaxed/simple;
	bh=fYX0YsAcdzC3xGEnENhr8nj3ott/n5K1kE753y4IEY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUHFJn+zn7F3R01N7Y5pQF2W2qEjMoR3A9MLjck81u/0EbvNTes7Ef+rbfOxHACeC4Q1aGK8fK+7fzgklOPWG6HKrUkOvWTNNbhH/RgDT6uI2OT91hvNmwuUuJ63+E54eRuZxzIFskKP/mDlXAYavo2LPg5PsozI78fk8IWhork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ZZobjISj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ZZobjISj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5cad1a6baso44463315ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788263852; x=1788868652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhTA2r8ETchpWXwEm0IQgD6dzKUlsK2Lh7nqwYCs0is=;
        b=ZZobjISjfj2FXJOdLSNPxxP+qsEfbeuJs9jBORYUd8TArWG0YcQQX/iCoDufCvU8Ey
         9vtA68YxO9j1Ijil2ZPAaKYq6ra1+UEHEk+pvPr9Aw28xFdl1x3AK7ATw8aAXXlUUeDP
         aEcXKAkMR32QohYN5//ShcumNTOsC3+hK5qEFSqmaeYnxPi7aqcNxdELRIaCSXFEZphr
         pX7Pa6Q15rKIRGrRi7hZKqo66j6K11EfCnJfnDqUB/mLlxMjbxSw2Xgu9oWge12flbNQ
         /enWngI+0t0NM37dHKVK88ypRD8aV1v3pcwAih9XGvbCdkBcIR1JZ0ABt8PR9cPvS+gl
         08DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263852; x=1788868652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vhTA2r8ETchpWXwEm0IQgD6dzKUlsK2Lh7nqwYCs0is=;
        b=IP00F+GLpjJadcrw7UE5frrsNP4p8SG2AlTj/twBYuNDoc09ThQW3Hdxm77Yjv6W76
         dB+F6UCgQne5zB1PYhTsO/1hlXdHrFEVEWG+BkrBgjwlrGmQ+SPaLk/xMrU/bW8YZSnM
         c3+Oum6AuG4LztdS8dQL7v92+eppce52prCU0S1hSvA5Df7ficW7U3YI5FJElYHVV1mo
         bJJaEg1bPA8BwuEGsG1zKbXFkIIDDxR027Y3q3wokQpJK4PNqBzqZN6LG2Tq0DLCVs3Q
         hU8uNFW3oiiBVHs9SMT31UD/ss9802BBKuPvpHGqVO6KxKWi+8fcfen7Ig0tBKQ/lzVK
         Xg2A==
X-Gm-Message-State: AFuF++lfJ0qqyjyaIntBYSKJwUVhHdVFwBVMEbLt3ANVxrZXTo4YKivq
	HoQ5nG4fGMwQCVwhzP5xFmqIPRtbcvjc/6qnTQUBtB+VEFa5pzyDQbo064Zzun7aM8s=
X-Gm-Gg: AR+sD12wzLxPf7rVczeVEpsjnhkaaVfl9/lW5inPH82WlH4w+Hd4qiboBSREwIdTcjU
	orheaomL1YFGpEn6gqBLHRoE/mP+BEH+t1oyKzbpTJp2/cN6ws53rNwAcF2wQZ5IPNM30a6gAe4
	Zu8HV0PmW2tHpFUKNygswpgnsVe8mEx9OSc0xDr9cMMEO9+w0OJcyUyXEn6EzxWRjuLk35vswo2
	h04+Dfsw3NLmP3LUR9Hq9zeIAEOWDols6Gb0m0jdwcKLIexN2gD2n/qRkt6zw9APEep4TBazDSv
	Lqbz/cJTArh3l+Fn8hRD9X8tAlWJ6R0lpQwQqrUntDyn712RI9cRk34y5OOAvzfnaUOusloNgWS
	OWCOUj0jzwxfo6EvVZAr5sLOfsXq2LJEyFTnuHWcdUa/EQjmv75N/6a12Y6Oa9NLQga06KUJEBC
	4K6IA1uIrMEKv/7DoSBxt19vPaeZF88R30Oc0dZJUThA==
X-Received: by 2002:a17:903:350c:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2d94a90e6e6mr107425595ad.17.1788263851931;
        Tue, 01 Sep 2026 04:57:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d911a9651csm34613995ad.21.2026.09.01.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:57:31 -0700 (PDT)
Date: Tue, 1 Sep 2026 04:57:30 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>

On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
> On 8/28/26 9:08 PM, Joe Damato wrote:

[...]

> > ---
> > v4:
> >   - Moved bp->max_tpa_roundup_size init out of the early return path and
> >     documented that TPA is unsupported there, as suggested by Michael.
> 
> Clashiko quite convincingly elaborates that the above is not enough:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
> 
> Could you please have a look?

I looked. There are 4 separate things Clashiko reports, so in order from top
to bottom:

1.) "This isn't a bug introduced by this patch, but the line right below the last
context line here still uses the raw firmware ID as a table index: ..."

This seems impossible. If FW emits an ID > 1024 that's a firmware bug and if
we wanted to guard against that possiblity that would be a separate patch and
a different Fixes.

2.) "This isn't a bug introduced by this patch, but the loop count here changes
from bp->max_tpa to bp->max_tpa_roundup_size,  ...."

I mentioned previously in my v3 that this is real, but is pre-existing and is
a different Fixes unrelated to this change.

3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
device whose firmware reports max_aggs_supported == 0, does
bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."

Michael commented in the v3 that this is a false positive, hence why I changed
the code from what it was in the v3 to this.

4.) "This isn't a bug introduced by this patch, but the loop bound grows here
(for example 64 instead of 48 when max_tpa is not a power of two), so there
are more mandatory allocations that can fail, and the failure is not
propagated by two callers...."

I mentioned previously in the v3 that this is real, but this is pre-existing
and unrelated to this change. Fixing this would be a separate patch with a
different Fixes.

Michael: please feel free to confirm (or let me know if I'm wrong here), but I
think this patch can be merged.
