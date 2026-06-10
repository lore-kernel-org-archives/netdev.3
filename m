Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34E2FD1CA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108469; cv=pass; b=IBJiy/+DpA4TJTCiDHZanVfzoDpgSax+u6Qh4ftCHihsLVLrYo0YSvBKLbAS7rWNsv9HeFp0zQL8Iq2jqf3MB887hJ9oE/k9sX9T+/vxBf85mCYUmFp5GW1t2rMKVnhr023ii/4cZcGS20rwjZ3mVWPO2XhOGn7gLdAs9f/pNaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108469; c=relaxed/simple;
	bh=WTk5/mDZtQNo5DPquJ4PcXCJffLWXG7+tDuwF629DBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApQi0K7dcrJ/bUvmDAL6N84DUlrxT1iJNC4pYP/BF17V8bJYa1X0SkqCPWv/vAN3biKBxFIktnxW8m2l+lmzcPqkQ3AdjW148DYr1gjcYeT1QwluK8ZAT2x6TeowVzI2J5n/+yZpUISpiRsH80DzFEITr1N7pzNC9s0pmWF/bpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXw6PZ8L; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXw6PZ8L"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so78349226d6.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781108467; cv=none;
        d=google.com; s=arc-20240605;
        b=c+s9CgCWzKJdBmmQsJE+Y0uc/TPP/F7TISSRLpwBFEHX9XNDnD0nIKztEgcb2qeAcI
         p2Sy1iONuCtXt16Hc2WL2zMwmUyw5zaAYwcNmQfXusM8oqlyrjEfkZJqUKhHyANKV0bg
         OWGbAeKTCs20pwgVjF0sQyMp1PdU3CN8C9nnKEpkw9WFuooQtQ4ig9n2kCn/S9fD/hIn
         t42XY9D74z4yakWnl/KpfP8+o4rX4W5K813MFpufNrpydka4FKCXMNu9N1NCu6sWZgq8
         5bwT1CMd30cqmqXb1TNQdO48GmNzeTB47v6kIdZPlMsP9NkLewvXhV8EwybW0fXAiOly
         k8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5S96bBa+ikDq+1P/boZXClsS2QEMX5j4Nx30bMY02YQ=;
        fh=+O9C76uBFeYivO2YhKBENwKsmImwWcG0+Cioa2hDa00=;
        b=asINOHfQm1FJuaG8wCxEhFj2lntvBdut/MoTVNPLv6w+lLkKTpBreLe3dh3c0hpmnO
         Mil7k/k5SDh4m+vuMd1spgasffJRh2tYk06uJlv3A0v39RnOF4FvZxSgalkAZAp9dzP5
         d5aopnHr9Y7soW2sLYQH6AsUqEDHNdWKS0LWIVL6xkM50skuAsTp1zq15F9vY2/uhZlG
         xBCodXy4jh16/mN6ys7fJsl3z9wYuLfGOT59hGvUipGdcdJKFDdx8Xr+NInEjul1GanJ
         qROA2FzIDeGlW7KF6A3kgMVdG88ksJAd32V8+939IY/1A3pJCm44FDkDEroV4+ppC/uV
         kPwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108467; x=1781713267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S96bBa+ikDq+1P/boZXClsS2QEMX5j4Nx30bMY02YQ=;
        b=PXw6PZ8L5zchBFHTNYOB26aRVr3CFM4SQ9pVjmCYVf3zrWMtqf2k3Eav/0GOu3OJfs
         +HEL9A5IMPGhc2oco/thrLIMQdnxAILH9dutkoEAgD706VJ3sQWyq1Bpt72V2oFbRwX/
         9P0dWIKhPpzaN6em2fhxiQNqY8alwsESkQTI6bBex5yp+fekBciSZZ+K+iAWqkGInRVl
         DmZJHKi9JY5YXHlSs7e430D3bwIZvUOsYtVUZeJMgYZ0xShCdFCg9DRUjH0+jxYsfOoS
         rfUIoai9s/O6s5gvDm2t4+AHKtLQBXOGRD4TiyriRtt+VfAAAL7S4WDA3pDw+ucwD0IK
         gy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108467; x=1781713267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5S96bBa+ikDq+1P/boZXClsS2QEMX5j4Nx30bMY02YQ=;
        b=stB8sZslOmBzcCS2zMQK+9a1E7EV57T1Adz63F5d/0rn1BopCCVgF/3yISsJQwPoIc
         zfMTRfUy5ccqPL/DuVpsWP4tNBCJKo0xwWXc4Ny03OcIqTapOjgDUon9L4kgY8fUMNmJ
         x2tT7sUuGTrUKf+yxypm/5dC48DGY0pJy6rnsqQ0xQnmsi6+JdTUoUykC+5sOjosJ0Mb
         b8C66Zp2Eb05tquXBQKbNAk3/ZrEPvh5fSFxxXm4n+0BWxu5fXPXZdRdchDfxT4QeQgL
         thEwpJbWTtmFYA6mKLVHLSV49umFSdoSYrqHNcZ3Z4y66lDfll/EiVQPpuThKSCDPVNT
         XjlA==
X-Forwarded-Encrypted: i=1; AFNElJ/eqCy8TdjuKwE5VF0N97Vb2LGzScYC7AiR+nLjcGwEI5X9kjqZZAH7ooESxUeuoQdQVbJdpsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVg9wonjwJ1ClZbTBgFGWKJB3v3xwWRz/O9Vz8MTKuRCg/LuQW
	9rOk6irzhKe8d44KZXzuVdT0JLYEvNSIdFtN0ch3hcl1F8+qQsIeH4NSqAxKTJ2TNfrB/g/RNKS
	IUGjJsjdeV+80j4zTaSiSd4dZob3VCdwdcCGC4M2G
X-Gm-Gg: Acq92OGcFUxUmR8RDVvcKQDLgFLEzn3kVK6cm4Qy2CbStnL9qVgTY/7atBdrdr7Uu1Y
	MtsbFbZG4GC9bD/WhzYeeamypiw9xgesT/3dHxG7Z3LhenEgKLBkwmDWTOXDU/dlKRYHfZMBwQf
	cDZ60K0Y0lhiO5xNd6kjzd/jpoqzorquAlWsptVpWoRAxOJM0UWkOX8NFpLTF/RwqTcIZ47jiyu
	SaE90bPM339chhV/vDYXBUtvophtGxwMZOTtUA5VdsvFJyXIDioK4DfYVr+RDSZcAUjGtCKYCkK
	U6H2HbQNpszp5CGO8uEjxRNJf8OCRshuYyYfH7Y447ecxTHG/+vmyNOSihW4f/YKwaZVsBamq37
	APYzglX/w/ykND48AClljIAT8CkWlog==
X-Received: by 2002:ac8:7fca:0:b0:517:8127:d2c2 with SMTP id
 d75a77b69052e-51795a66bfemr376002961cf.25.1781108466526; Wed, 10 Jun 2026
 09:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609093154.2733956-1-edumazet@google.com> <20260610090540.507cd300@kernel.org>
In-Reply-To: <20260610090540.507cd300@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 09:20:55 -0700
X-Gm-Features: AVVi8Cf_RYosqNWM-QNpcFhSxEH53MkinwpkYGdmcbTy1Z15yqf0ndb1iH3Ff1w
Message-ID: <CANn89iLWoTXKbQrMFc2zDLytQMczKCr2FNZseFZoJ05_Lm=4=g@mail.gmail.com>
Subject: Re: [PATCH net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  9 Jun 2026 09:31:53 +0000 Eric Dumazet wrote:
> > -     if (time_before(jiffies, t->err_time + IP6TUNNEL_ERR_TIMEO))
> > -             t->err_count++;
> > +     if (time_before(jiffies, READ_ONCE(t->err_time) + IP6TUNNEL_ERR_T=
IMEO))
> > +             WRITE_ONCE(t->err_count, t->err_count + 1);
>
> Sashiko complains about the bare t->err_count read. Is there a reason
> you added the temp variable in xmit but not on the error side?
>
> Maybe an extra sentence in the commit message on why the approximate
> correctness is okay here would also be good?

Sashiko is right; we can have concurrent writers, so I will send a V2.
Thanks.
