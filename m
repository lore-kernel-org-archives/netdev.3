Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8442E8CF
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381779; cv=pass; b=ip3T/e8A2a5ofKYzOSsIfv4hgyOwh6rTxw1j4viqNYKiFkrrtLSeIq+uCZvKEuCWhVpjE6PK9a5jVynZOmpNyub4eqBEw4DHJjginKIT/CrxtFmaBDlv4C0+Esp/E0iqkzu8c7GAgtOc/Z7nRL7PxthR1jlhMAqXGIfIRgQW+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381779; c=relaxed/simple;
	bh=s+j5d61c3OSpvPdkGdTdwVzk8U68zaEBU5tnTm+IZgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzpPoC1uHuSX0J+pXf7PUje3yQVK5hn23Evu7+A5xTKkRQrzUd86fNCMOWgxLKa8/ikIp7bLrfFB9itX+RRp/b4Jc9+fyd7qj7M9hz5DyP1ICCfC7TQFtPyLEUoskkQRQvIGUuxMdHWXkcu535L8r7xwknyV0iqTl+wxOFFODs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViL9b3Xf; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViL9b3Xf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15a5b265so6851cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786381773; cv=none;
        d=google.com; s=arc-20260327;
        b=IWzuxCC5u1XFp9wpJEOxNjEj9kwNx82VDLxWjDk/Bv4u/yGhIK1JrpMxhaFiUu6ntl
         yYiO2rmeDxebuVKrAblfxaw/qOONvh//z/KXXqNVZuVMl+1WlshoDc1Q4YX/zB+X1MQw
         9UhJf03NO2iZ7L+Jnpm99K9DnmOumq5sdAghfNzw13CSuM9svbWzOKmEMKDSr6xarv2R
         fxFnFFE+zXO3WF0iNR2DidtDTXkwRf9xDNsSntm0FbU+tul7cI2zEiK32E+zkELgUqNP
         +dx0QXNUL1P4qCEk062WQPUfvNFc3JvZorsZWHLrDgnNHF9cUecZGXryfPymR5eOjaus
         Yz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s+j5d61c3OSpvPdkGdTdwVzk8U68zaEBU5tnTm+IZgo=;
        fh=1nRns9m6p7aXVf5OLDi7C5nYgCtewnNxfeAb1yj4TuQ=;
        b=o22wyHU8zAryIriSdJuEFP/TYGYpgNWf+kMz6d94utThiR5wkIgtfCZqLbrMayymd7
         jXATWO/Jy9yX1MCiSRPjVabtjVpPAyOip2a6IBwYs9KuAk/OmlpEBjGJVs8rhRWsSfhE
         N4vQZuhSEcmMmJsREJlNxbDQrwQeyjlPC1q25hqq5FMG2aI92+rqYYKi1qXGld84LYP4
         GweGiXAYtZ3+esj5/eRoUl0hJbCIf7waOqK1VQkU2n0EIfq0IADrWCKrD/ZtIF0DzqDD
         066KSdNj4bLmhjIPsHMkNGFNQ2CrclhupABmRUk2At231WF+bI5BeQETFUa9qvusgzyD
         sn+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786381773; x=1786986573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s+j5d61c3OSpvPdkGdTdwVzk8U68zaEBU5tnTm+IZgo=;
        b=ViL9b3XfYcw4YD8wsCLWdJrRRXFp2CdoC3W/KqXrArk7t1s20DyAIWnVKwsgz2m3ZV
         Qnm0d5IU7+1Cad2zPyaaJHaraidzdwvL+QihLTCtOKUCO6M2co8RSyz0ITGJHJKbiNOK
         jqYTCZC+sXVAnGXGk1U0xmFfRtTBD+sTwNRTUdg9w6vOJFgHe98FEOYQjrniTjvIqc3E
         6vfFaMQZfKpcQoP5HXfY7b/qpquaAeC2ciEmSHLbF89WHL5ZkDBhdpV0yEp9upARQWYT
         XXrZB5LRrFNNvZevBsfmSjWBS1rA/A0k26/J89mV+nhiFmXvBD40Y9cD3eea8eMIhLfh
         5ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381773; x=1786986573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+j5d61c3OSpvPdkGdTdwVzk8U68zaEBU5tnTm+IZgo=;
        b=UrfvX5sUVHrDlaltArt40XNaU2Y9r5B4bGMHXD/XiL/WSowDO4xexG8eoTeh0XkLoJ
         gjnUwXf4KmNBagRBIfQ3IKVCmbKyg5cMGvMMxKla4GoZyb378AIKDDMppvTAc+IsqjWU
         Gwi0kelihIQN8lStoNmBxvKoS2LUEgy/1xUV2P2l+NBn1cnouaQAwqKgk+YbDJoS/Q2+
         5vX49V6ih0MxG+ZUQKiC30jk6WoHAWeDzHk8dMv/8snP0ul9c1KuW7qgm8HDecn88gk/
         IMZYPBraAl/LWnBNkXdOtwIAlN7LbgIj+sXJ8RBkGFFh9GXWf5l7iqgCkS2xHVXYcaGz
         N3sA==
X-Forwarded-Encrypted: i=1; AHgh+RrjLVacSJEUIMXiuTDTmVkD/O/tLV5O3/zmrORqstsBJbnmn3788N1ba0nyAP1WlsFTD7jIB6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQ8llKL2SIedtMLuYAmoIGhu5gjcqIzFV8ZRbbW5JZY4Ut9B/
	T0tyE+r6XFaQJeQ1rt1HV2IzSeIXT9bBv6i8DmvjAqp7aOdp4g4wV/RxpmyyiWsREHyexsDBKIq
	pqfyPnwJswWbTgTH6BxZ248t8nGsvoHKd+fXqG7AA
X-Gm-Gg: AR+sD11XEUlLTo2Td12fO3CT37doHoMzyX0/KlbgZTUdDzS6D1gZwmjLTooZG5d4wGV
	xVMwpe6Ubxiyv+qOdEkSph5H+Ju5srvkPdLGRS/F572+gY5/m1Xjs3RbEaFvhDne7uzG+U62ToI
	ai607YfZbbZ4aD10uvO34W0pngIcoOCFtidoFc8AObGiDIlIPoXtI1LgffXBLfGtwV3OMFHD+OQ
	jP5o6eFpHjbwpF3jqzSp2qbdjF3K7YFsHLC1Qv9Ga/Gq+T5FSpViFsY166pPAwLA8Fbe32yR4+J
	V1YpRjs4Mehs3F25pXBdhAtTF+t1WazzkT6trLxHNW8=
X-Received: by 2002:ac8:7e91:0:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-52d51123088mr435601cf.2.1786381772424; Mon, 10 Aug 2026
 10:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-6-surenb@google.com>
 <anbaJuYXEoldvtPn@casper.infradead.org> <CAJuCfpHh1E34LVTd=4y8m+2ugGABc3MSU2Z5N4pFY4ttH0a5Rw@mail.gmail.com>
 <13c444ae-9da6-4fbc-be98-f107fc3bd0bb@intel.com>
In-Reply-To: <13c444ae-9da6-4fbc-be98-f107fc3bd0bb@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 10:09:21 -0700
X-Gm-Features: AUfX_mwx6ocz62ooVQSWbPu7_NupWXDrDYExCS9WPkUtwBsAoq_oeAqr4fQySK8
Message-ID: <CAJuCfpFkyGrN7173CDhZZ01+qovRqW0K=SEz+wNJHZm9Ha2Dtw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] tcp: Remove mmap_lock fallback path
To: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 8/8/26 17:51, Suren Baghdasaryan wrote:
> > Ack. Will fix. It's obvious that I took over someone else's patch, isn'=
t it? =F0=9F=99=82
>
> BTW, Suren, thanks again for taking over the series!

My pleasure! Thanks for starting this cleanup!
