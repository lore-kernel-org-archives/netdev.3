Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792768361;
	b=LewE8LTEIW7jXagX1vh/vCDWTvcrnbf7FmLK8Xe/t32IzHp7M+JbnfakuotYfNXpQ7lv
	 OQLtmFgjCfylN+wivx374qUMSPwZx1UoZhvycyG+ZmFqF8t/9zzHHepXZLLiY3ONnnGQO
	 t15wcA1eICh81Plky4vUUDn4lc+FwEs9rE8ZBBORl9CAoJEQhRcgutT7fkVCzCIKiBufp
	 spHeuNUuGdbAbGPamFJGkXBgKypATLS2LCYmquuYaBW4oZjpxjDY4qXrytxnSmyqjLoqn
	 POMksuDR9v9t4Z/vTDr5voME9Q43JDlKgox667x3FZPOP5Ob2JCtoZ5rJRnzEhXMkCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
	b=t1+g1Vx+mhNM0uV4E91x1QfgkTac3aonXdicMStNm58Xd4NC7ETPkhk1sRs612/pakjH
	 u3UP7klTjJ87V9RQ/Rfw7et5QWr9aBXWLQ8yBCn0qBHiLXTH9RujDamQApBkqJ1OolXTF
	 mCnihvr8zf3b00mBfwCY4TitICKdmA5hzoEUqIxRNB1oajftdtGNajzHxtxzF/Qq7lhuc
	 IdTWRVVi1Iycgy1+IaQWS6lPgROcEDYbg2fXFZbdV0xJen9uDzi6dnANa+8tJ/LsOvgJ2
	 6XbHoX/SqIG+V4cuC8hFd+bfo3N+1f9dAseyzsj+yIU7mbebs+gvLnxf3cMxhFS0akw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FA1ALNrS;
	arc=fail smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1273606A324
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1273606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FA1ALNrS
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2db33db4de9so75005ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768360; cv=none;
        d=google.com; s=arc-20260327;
        b=HB0amtAtX9Mk8aS5/ltTUCZaSwGTJs64Z+0dEQgnmnclavTxTLy0L8S2PozOK7NhiK
         0qu74EFF+GQcbPE29/6KgbkgzsJbq6u6SJAik4On6dbdE5tkZBqGTzlmx761E6qosjZr
         OoVgDv/e7mNSOKtufn+pcqCuBVtQYZC6pu9JH6eBA5Ydrz9do2fY/gvy1MVkLER/BzM6
         AH0e4xaK53iiE/lp9VesmourZ26zXFjDeQdyvXQvrTDlruWXXe97WIvGgrBYJQJH1z3p
         W3dsVcTf6mY9Aomi4brdoHSiWJP2b3GU1zNbx8ttobezDjku7YKOaAAKB9+SIMfzwz+Q
         io3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        fh=E5ArQWmu6z+6epd8vznxGaclF0W4Ssbqx46qC2Rvb4I=;
        b=plL6QWBRMaOfi7VDtbEcNoGNAsg3K3LwtMQZXcE6WFdT8z4BbyHUQSYKp/z2XqdCPj
         llYJSWtNjxlQwdzh+dNShOId2hsrIpXvTExhbCcdKYj306Lb8CxsbWGWHw/oiLBDK39S
         t7md0mwb0nKk3QzN9ERnJHrMbocaWG1QeS++m0Nam28j9hwonexVfAEPSpAVIWLhhL/l
         sOAh9yPuSH1dKRW7iV8zT5OFu/ufEV4i7QozgeA53XWIoCQsXxCmvEPkQp91wfFc10Pb
         EKWddS+/GNwkwDKrs/TBRKV3EyOvt6VAkLQhz2BSgU1aA9K+5KZqB1LKrsfGIWTDUuhN
         IziA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792768360; x=1793373160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        b=FA1ALNrSzo+aczkKotmLBVK24drLA8Xv+LZIoCG/tghiGEPsOcpLrHsGB4NxDwOPNO
         v9btTMfj2TUT2ME7MHLyGcYZn00t5NhDWmYs8B/upCPVYfVMZCuS3SM4lAK64iUiPH9j
         ncWVdRv9xYCrFdeHYtkXgXq5HdENMASP6P1cLAahsijYt1MlEcBzXVnewQSVcXj75jXo
         oX+4LvaWMfy1ZHuV+IEdyo+NsjZb9bgThh3R64BMx42FVa43uBb3ClvG48WDeW+ENXjq
         NJIKXPNKSy/+t3bLequ3La0Aw0+wNUS4fubMk8xHGpDCHB5FH3o0bNKJfcZoFPPsP48j
         7FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768360; x=1793373160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        b=A1ycEVPLHLAF4tz+9KT+gTBdtU1fmvqE0qruYRU18p+MHBEvOgTxp8mzU0CT5P057S
         ec+srik0l2Sdv8secHTasKOhMY6aOmRLiJQZej4QLRCSgN6/P4m8qhnvoa5PgAixJCee
         JaOAvX7ksB00s+rzEUL8sLk3hmxCCr+swGmLbc/JwBh4V0AEfb/opBBsj38MtkcRF0rI
         5o0ZVxBHFK8I8pzjr//o6dP+RHUdLZrCBNqGozx0k9YoddHdogUrffREeRZfSiQAcAlp
         kMuzoM1D8A+MZ46wtvVj2PoSsOCJxYJ5zlvuwpN5gs+EPHwgzzWvauUzHxMO/EYaOQPc
         W7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG4yOoZlq8JfOn44YxyIVouOwvUw6wxFj2ni5VU8sm/PWrT4vACobfnYqY4wz8LtpahEMvObc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ0PnBIcra4y45knK4C3NgqrKhl3cTqXjKoTY7ILkGt928Msxz
	fVtAtfqBz3kEJack+8DbUQaY4wNQk1cCIe8ZviJX9aIkkJGadYPAgSlD2jFbBQr3AYOHfl9FhmE
	xfPwmsAgq4N+8wg1AIUPbh1k00H9/6GvCN1WE9kc+
X-Gm-Gg: AYBFou2OvKmQiFVeBOWKfSU7Jl/oN3LSyU9KcLzpxa+IJ+7b0eLsi2F+U/CTfAegIng
	rgupPtDODbquub0vZj6r6u+hGD/l0WLg1lIgpbqmajOi9ENsvuEdrEtJ1cPoZC4N1TBWSf50pne
	fd5gZCK54aiwyG6LTKe0W+4GVxyF0yFWShi8tQJQmx+AaTjNojNuGhO74xRVnIY7BYHCjhM/9Up
	kxTI4p5b98x/T9EB6n1jaP8XPg2H+Mv+3cbjGdugG7kFW2ManpjUcfHW4P3vnIyNW+/i91HMh2S
	nt5ANMY7cO4D4aFp0wK8ih7iOb2Eghx6r7xcFK9y0oqXGx6I70qcuYb98oSuddiNn07a8rxPxt3
	eFy2ABKOaIq0tx15eKvb96/DIypGAkowzxSk65A==
X-Received: by 2002:a17:902:e84f:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2ea7f4e1cbemr4092325ad.9.1792768358959; Fri, 23 Oct 2026
 08:12:38 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
In-Reply-To: <20261023145023.GH3977851@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 17:12:02 +0200
X-Gm-Features: AclHuK9W5A7aXTPFZUdD2jRhpUmEtp7k-vVQ254ZWcJE4ItfG1TCZYdvtBT8nSc
Message-ID: <CAMOZA0JfsviAkojjEewehxMq0r0AboS=L6AWafMj4_Azaeg-ww@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 4:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Oct 23, 2026 at 04:30:25PM +0200, Luigi Rizzo wrote:

Just addressing the last part:

> ...The CC stuff seems
> actively dangerous. Unconditionally always using CC shared memory for
> skbs is completely security wrong. What I have traffic flowing inside
> my VM between containers or something? Does this end up putting those
> skbs in shared memory even if they never hit a physical NIC?  Same
> with a TDISP capable NIC, does this unconditionally degrade its
> security?

the current series was RFC and "unconditional"  just to show the concept.

My next version (a trivial change, really) is fully opt-in on a
per-device and per direction basis.

The unencrypted (or pre-mapped) buffers will only be used for traffic
that hits a device that opted in, and only for the directions that were
opted in. So we can finely tune the configuration based on hw capabilities,
threat model and performance requirements.

cheers
luigi
