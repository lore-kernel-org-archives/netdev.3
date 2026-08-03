Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABD436367
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786238; cv=pass; b=UPdNBH1Oh7bjUTQFB8O2xaL0FwqQ1JTY7YfVcZm3fVJNlSHvN6h7gVXA1DsB9yuzaSmZMaHpf1YVoe7hO0lYews9GuAWfZE0JF0kOMkWCmpNf/kc90fFBNw8dhFjf61KR2Qz0MbWmsAQMy/zuqMbWtPZxsDhlOMno3vkwQY+QsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786238; c=relaxed/simple;
	bh=fP7XfXAPHNP7pNiZJKYeFh1C7B3PixBZpsJ42VTDiD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIapRd77EPSRB6zfAMR9E0CBQUaLzaIy3P2GyOeSzVLVW+Io56vJpwYcysfk6u62ZQYr6i9q8B9HtVryVHRx+5gzUbxr6ZbYyojWiQ6/ASCeIrKwHx9iFAsoGY/JKXbDKDbGznb+llEi1QQnNbeBiu0zp3IqaNpoeJMAgYydJmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nz/AhVb6; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nz/AhVb6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so66571cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785786235; cv=none;
        d=google.com; s=arc-20260327;
        b=LXXUcS7KbrvOqhJAg9cDccoQugXZWk/mweDGI/xGFEpBnjvuO7qWcmfScH34kmhP7c
         1W/iA0vIQbr94qBLJ+NtZHdx0KfZSFoYNMxVBw1t9H3oMbxYpaBl2T+4AQAK2dW6t2UX
         ct4DMgl1MGV9MTSctbgvIRzvSes41VgbqeJ6qitw83ZZLCgRjilH7cnPxPncXDWRp1tj
         S6CeZTqNUvMenRk9HCXFcXKcGW6Vd/xSJSCuoSksQkM4xz6dTw3+EfvWp0le1XyUMVgh
         W6e26OI9IpNqLlQJwBdZ02rwuM05Y9Y0Yax/kAiO5vYUVELPYU73cb4IX6+8M0nXDgRU
         BVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fP7XfXAPHNP7pNiZJKYeFh1C7B3PixBZpsJ42VTDiD8=;
        fh=swA9SNzDjeAxi2s0ywBXnYtIiIv2qVSaeCyK42eSAGA=;
        b=Ob7w2kKkoST7r7WiGEMylPV7MhVWRIndw8hWPlILYjMBNYqiqXhaGI4IwQifB4Q2aM
         UYZsWcA51iRBIsbiMkTTHx7t0ZMup3cLUdnZZNl1A6qJHd7vO46B1IIVSpCoPccZ1e8b
         jDMwXs7b7i4Om4KqijtzB72yVeEfo+lPlxXAvWQGRG97Fm+lbP2eqJMRXq6HExQnynbW
         Ha8g+6/LL4J+Qfv50qjwtAkf/li35jUYrc9z9uEqZMToxsM+AbLmOhb3l95qDGzRbWeQ
         peEfLUzpjtpgPzNKgMlgNT4ExOoSBt0/sCzfAN2VGt4K3/uCDiSDOLQu/ejpryF/zmU+
         zYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785786235; x=1786391035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fP7XfXAPHNP7pNiZJKYeFh1C7B3PixBZpsJ42VTDiD8=;
        b=Nz/AhVb6EdGWqgRHtsCQK+MCi00N5pPTcOYl3gQz/3gyepDvyBLlLVm8KHqDtKXtWK
         MzyndIdraEZ15K8oK6Dyzlx/6ibYWysL3S/UpDzwToK1ggGgd+qh5Bp+tMVHL0+Xt8l6
         jzb6Yx9AXkMjEPjeGnJ60jiWzNfhx/UWAhwXImoS6MlIGof1sG18LW/Xc/HmDZ+8hTac
         WwpfVmqZX8U5KMVAGezi2VP1ZcJzCZrLFJbR3WAROH+qSPbSCFPwiDNBv7kPu55OMFNW
         ICfAQLlJN1PlhP/irnPweP/3cREXOlGbrFoBwZ4bv94jrouzVxSJ4/okRHnuFxhkif7f
         bcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786235; x=1786391035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fP7XfXAPHNP7pNiZJKYeFh1C7B3PixBZpsJ42VTDiD8=;
        b=NcywiUyEd3gDPWw1f3YfEXLGh2NFo3fKnZ2+JZBzUTz0KEZD88tO+YpImRNdszD1CW
         AzjmTWhCAExQ3yeidsbySTC4GEwAmzROh7HO+ynEwPUR8buEyppiSlsa/Ape9S/ECJeL
         Tkfw+4i58c6APRyGhNSNk2/CFW+1dWcqzxOj/YB7HEwjlvYPvB+ToBuybiTMdDj8FE9q
         ahYsQoRV+DOBO5yH26GF/mhYaY8sr1MZZqCWMarICqr0GlX2MnYLQFbGKFxiaV1yOS3E
         E9M9NBr7aXK8x4gqa78OuyBhY+bZPnTMnqrhrZ4V/RjCdhdCjd/9uLE+de3/iFU32rrH
         ZpZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcnQxKxek+9lAhKN/h+XeD+j+oGTiASsD+P5eZHelwT3PiGE7PEPfeTLhvirW75DiaD9UGIbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8GHkt6BgIfSbFXsqfKmLDVioSbIoPTBwEtxeMAyZvezLyn2i
	tNVvO7haz7XRRrDAf8GaHkRU8eBXUAVsvdehXgXSfLoak9iBNWoFt+nvXCY3CxF9RC7t2bzdG+E
	IakH7NwE1j2EonDo/HvZCCtxKVHyulmfnLd4yDH9k
X-Gm-Gg: AR+sD13DqM+hCm4lqjPK8l9ZmlUV8RNyOjx81D6izKa7juRsv2pQEo/5q2seKdHmlGC
	CJF/5vsZwbSP6x+x3AjLyghQ/RW03PUyWG7zXX0Um8wjEphQM39XAQ3wBYrSxOS750mH1FY66zp
	LtwKaHkJnOb+bbusqTgyw8/oCsuLr6RcV7QjKj8nZi1Bh6j3lMDVF7JzxnH7m2TudqQObd1CLPc
	SbUHHKwtq4WiDVIF6duKlfpjC4P/f6X596WUyeByBwLuchmMmJgavpuzFSXDWCu7Ub1TWQj+a1X
	Pgz5ZsRi8xRs7GlSYmZUGQVMnC3f2jqGBlYd1ti+qH8=
X-Received: by 2002:a05:622a:900c:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-52cd4de760amr2551621cf.6.1785786234518; Mon, 03 Aug 2026
 12:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <CAG48ez1w6oPobKZPzoRRN+Nf66PrVYRJwKQx=qwTLTR3n0EFRw@mail.gmail.com>
In-Reply-To: <CAG48ez1w6oPobKZPzoRRN+Nf66PrVYRJwKQx=qwTLTR3n0EFRw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 12:43:43 -0700
X-Gm-Features: AUfX_mwmOzbiGwES3hfijNvnxdpVgWNCN7Te1gwkygr35PC2cl0u--Vvs-L81zk
Message-ID: <CAJuCfpEaYgMx0HF8SDRPOfBJusdyAiJOM3S0TRjeFGwtmSHj8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:34=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Sun, Aug 2, 2026 at 11:55=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > The per-VMA locks have been around for several years. They've had some
> > bugs worked out of them and have seen quite wide use. However, they
> > are still only available when architectures explicitly enable them.
> > Remove the conditional compilation around the per-VMA locks, making
> > them available on all architectures and configs.
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> I've grepped around in arch-specific code in the architectures that
> weren't already opted in to look for stuff that takes the mmap lock in
> write mode and manually mutates VMAs, and couldn't find anything, so I
> think this is correct.

Thanks Jann!
