Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6E40D58C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741552; cv=pass; b=MtqDRkK20chJTGQV302qSk990oageN1hDs9PDgO9HJZjhbdbv6+xIHgb1AY/m//Ikk8nUSUSN0aTmrp7KBNjRaFkJql5ut0vvjoMH/LFZmkDYoIRq47jD1RcE7/5Mmv+h8CSndHMjYjQVVuAtmJq7D8sqI7aEGeX/uRK0+LaCl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741552; c=relaxed/simple;
	bh=arrfX2Np93Wj5C+Nan3zAgsP7q05O2yY6+5myQaY2q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJR/Gli81vnPobOVNZpAK6cSqjjkrPEtpoVvyzcTK06EwXe6J2QpzotOBAfPuET3tMyUG4nwieDWF1d9RDymTDXunG1toEDHgbqB+UDCaYaSiam4E7o8z94Zkq68NZJI09O0aQWuQpPXpA5PI0R9HraSyhz09ja2pyns1MOFUA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov30GIFa; arc=pass smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov30GIFa"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-c12629c937eso146521366b.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741549; cv=none;
        d=google.com; s=arc-20260327;
        b=kW6/laWdUX4vRCSBOVVu1iGM4fWVIlyo77sLvtmaeNgfQUn6pWCi+YV08zZZ9oofhh
         5Rb2hRtvPRzI9yIr14zOiRymYQN/RfDcZ4Nvsyxe1rkN1gJNUEDDyLLQ+4rtinbRFFZY
         2Aq6Waet0XKa752To1BOIQc58JhGJHRt8oy/mowy1ibAZ63B8ywP0HYAv6tT5jFMsI6p
         6giiOE/yZrdupscPLPAmtFJgGWLGz5MPREmAUaSnHnMCWDfOqCDIvg7/CCN88VFRP7qa
         TT2IYeTcaThRWVFprVyRS50RO7va1db3N9SnBspNsHl7EVbkkmQEYPb67Hl/9XLcm5iy
         6F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hOLLk7+kiafiqGHCUbh1z+S/Kt/JfxbgLypAIzffCYE=;
        fh=5XSnyeAQ8bgQZ311iA/zFQCahxNUGlikR3au1dqYA2c=;
        b=cBvvHzVkXkPdM6NZR2wHwacbonVMCGkbN1WvQdXswRciISt4V8/fPD6Q2jRGS2v66J
         Ol6/oNX5dN1BPlMBI4QSYAtgLakSg7bQdOimCb6iVdwbM5jHRBPkfL/+Ic0j/Tb4xExl
         blyXfAJ3YyomWR8KxC9Cp+YgH1VpB5XtjhDmOlmcrC3TtEHCFE8XammkL3L7yEal92af
         dt3LfEgZZOJiSCRibG9MSMMIicBvwCzgad/TyxhkhHmd6RCWjdEwVehUfyJNQzZofXM+
         Mi/BPC2kSDlkHnCIFTiBsYJeMxAalgnNMcALJUlzix1tSkUAOjzCtYhHhuksOEOVoe2P
         vriA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741549; x=1783346349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOLLk7+kiafiqGHCUbh1z+S/Kt/JfxbgLypAIzffCYE=;
        b=Ov30GIFa6zBp6w3TZpefLhYNq6dadXsoSALmm6uDmNJ+paoKW6Hoo7aQ5S03xBNmqP
         Br6nR8RtfJdzkIuM8KybPIFfaXacbc+sHobK7g73YioRDag3cZZXgoj8cVJDSZbODO6K
         3ZyvnrrHkGuH1y7I5wQBv7RCRxo0oqBDMlyygctSO1RNV6XAgivlu/7jdNV0XMttpUFj
         nF4Lbuvh3PEYJAxZSn+e9rEd1+tuQgZ/svHDATPQluTWtQ3X9LNjQXp4e5rwLrJFkVb5
         AiEB08M8HFBNblfMzCZUkjmFYxKdRJ9mMu7LX62EybMi+jiBEtOJj2dV5nWCKIyhoT8A
         lN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741549; x=1783346349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOLLk7+kiafiqGHCUbh1z+S/Kt/JfxbgLypAIzffCYE=;
        b=XkqbSPtv1rkuJCJHnw/qR8fbDzc8rPYVwLT6OEQmBmTFSnKMLf63cY470GWg6OES3d
         wi/6SWwP46GvX4R0uqjykQU8hXlK3Gx9m9gbWhOWH/CsHs3vGmTKHWprpnn446GxVwW/
         iJ8CPsa57CiMmGM+OHWrMWNqEYfjT1nh/CcauV5f9O5MuDX+rlj5+nSHdQi6+WO1EfDb
         euEKb0+jvpFWAqBm3Mjhonjw4XZO6TuJzAWr0Y1k31Ftrsm/2hHTb+Ms2rwAlye0G3Za
         MU7xAZGlIK1e6Geiy+z41Rb7cmxjyY3H4wMIyu5j/vUH1pPTfp5LGxONcJPz1aTkEDw4
         Bc/w==
X-Forwarded-Encrypted: i=1; AHgh+RqgvMkjeGoeTJDRh/Tj6hTOfAp3SX1G62hgT0yGGkvWc8sWuTEtNRD3Tb7diTufvEH2/XHgkrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUdz1rS5f3uQR63FKMRVcQDUohCEbGNU/DmIfe2lagvJdC71Y
	Lxz2Epq47efQuO1xEFmnzL6rdUA4qovIryNpTEdmdJNZhYUBLevBpTSUZqvoAo101fHcceWFFQ5
	mkw2SRvCbdjNz1Vt/bLktEf9mEc9BazU=
X-Gm-Gg: AfdE7cm6ovOx1DFDKYFgc/h1b9bN80RTmaL6ysG0XVIZMj2hrjjNepAsrgBPxd3PoSE
	XqKd6s+UuRJDH1kA0islEcn+2yX3ieZ7tBxXjiN9TPXovdSDZVbzX5XC5YRsjMV+kAoM9ACEYNu
	WVx23jBFtPv/cOWgX7p5edU+cq3quXOChIwLfZfEBYDhO1TbTsDldQ7MrkaaFaT0KQi5d+DU40u
	/3d5a/8bJfAqanBca+KPFKygM3e/6GTu2+ZCKicD6Q5y7GCEAOF2AFwgosc73DXDMzDOfYkVR4r
	EKOR5mU=
X-Received: by 2002:a17:906:6206:b0:c10:f00e:d983 with SMTP id
 a640c23a62f3a-c1205dd401emr754481166b.13.1782741548475; Mon, 29 Jun 2026
 06:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782643946.git.roxy520tt@gmail.com> <02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com>
 <CANn89i+zu=9LAaSppJ_+YZQK8Mu5HVmoQa9uw17MDY+cXdpXkw@mail.gmail.com>
In-Reply-To: <CANn89i+zu=9LAaSppJ_+YZQK8Mu5HVmoQa9uw17MDY+cXdpXkw@mail.gmail.com>
From: tt roxy <roxy520tt@gmail.com>
Date: Mon, 29 Jun 2026 21:58:56 +0800
X-Gm-Features: AVVi8CfzdM1ZMAeKVYOeExhpkdJDNxDkFFHRK8DHQdDoO0QwJ4-H2h1bZeB9SKc
Message-ID: <CALMqdkS8WwDw3sx+7iRQPCXkdg7998UJW8Nj0TKabAz15ecwKw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
To: Eric Dumazet <edumazet@google.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, 
	bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, idosch@nvidia.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 7:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Jun 28, 2026 at 4:43=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Zhiling Zou <roxy520tt@gmail.com>
> >
>
> ...
>
> > -       max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
> > -               READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries)=
 + 1;
> > +       max_retries =3D READ_ONCE(icsk->icsk_syn_retries);
> > +       if (!max_retries) {
> > +               max_retries =3D READ_ONCE(net->ipv4.sysctl_tcp_synack_r=
etries);
> > +               max_retries++;
> > +       }
>
> Please do not change this part which looks good, let's avoid code churn.

Thanks for the review.

I kept the existing max_retries calculation unchanged in v2 and only added
the clamp there.
