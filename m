Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABE3EF65A
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080798; cv=pass; b=P8NmAjSOMqCDsEs9YZ5647dYlqeiJPaH1cuQ4Sbcfn4dzeGwSfmNpZ4kFT7oZGQ2PdjqopC1TfFfoUIpI1V3aAOAmVOPJdzOPjbQgX+2Xi1e9+YCm7NSyvVUhQ39LHHT3nawVNx/hR5h36zJ8+z/6vJUsuIWTCRzYyqjokLWJAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080798; c=relaxed/simple;
	bh=m16fKxmhGhuJ7B3jLust56D9Y0CJQn0MnszLnnO7hjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keZPYukNTiswiH8oBUJJR2Hj4V5+SJGT/LcXYuvEhEl7rF9WxcRqxiZ7LP9JAkF367FrgO0D+O52bPOCK0vtm8MVgzu+Plp4oAdnQTqZGqwYZD9MyL5TSDOeumVEqc3ms3TRkXL0XwL6kVmuqX819SbVAlV51W59dmOgGtdgB6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYhBgUta; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYhBgUta"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-130b2295ed0so5382788c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778080794; cv=none;
        d=google.com; s=arc-20240605;
        b=N3Y5b+rUDggAMUhmCLBgq+qljSkJCG0ek3XqC8FMCkKnYgOa036w5BFoWbSOUrNXba
         Auy05fhEHoCVe5VYS7rvtgCyMl71rvt0K7yi66cENb6JSu/3ccnzvTEXbCVPceE7h7Od
         NOu80pmZyfF4R/OcIaL99FDrE5GrClGUtW07RAwvGYFuOKCrrcPsYpXuJmKaFehu1exI
         /o3KGda8SgBTQ83k1V2stJSP5J3QdxBRdpi3xYk/LSQiLAyEHRpibwKrDguDtkRb3Kxk
         2rLMF536uuXSNiiy8MYK2Tzti2vZqmJJNqTLY3eXUJouAcm20EcgEffGXCLAb+NeIzyc
         /p2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        fh=xtKgKhSJJ8y/W/WTYafv5o47e7kQ1sqAQLnim4AhCIA=;
        b=Cabk/Yneihn7z4Q2sWo4CwqjYC89VtQQz77vGjMuaMcnlTFNGJW9DP6Ji/bvJbYOMH
         ySln8RFxjyv/4HjmUkMt7wFqG4mx2P4J7/lRvZa4UC58O7iHPcsGkMMWRmsC2v5QzYVE
         ObzCA3NtQqmowUUTqlJBmajhAq0AFRS+sJ260jT4EzevuRYHDsUCxrtAVsdEeUD9ji5g
         1IcSrFskYPvKpyphQhlLBkqAbLB7vbnhkh6dl7RfACFjvTDkXBFaiuwz1zvqKfHkBTiJ
         xJ6k3NHlAnmbkyl3OlBdeluJn/4j1DmhxEevSudRMI03wzmEq6v9IcEyguYqutAQ8HSK
         AGKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778080794; x=1778685594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        b=DYhBgUtapbuhKALL/2Ur/l1TYokrH3fgOa0B5vNdjOgrGm61JISOg7vgDxd7CdvoOY
         AlOFP1K03mWPj1xJlIbj6sJoXcVeKvka53xHccbiBfjxKe9KiN4X+p2kSz5VxXeN7fxr
         XJizDK9FWetAV31OFDo6wO0GeCXg8l6brJ4olPPE0XAc+78i/71C6OkJrjWCPhS+OOv7
         ulh+/l96quRD4MdQ0GdbgI3hgppCZOk8KNnNhVw3Izg1YAtUq4KfV9XlUmV17/nomLNl
         5s1qPWq7HEWOdLTr/47TcfJjKo4nhzKU4zvyGLEBen4tRotV+kkJ8Adl9X0X7nnxmsiX
         X3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080794; x=1778685594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        b=DtkGYytMyvv8LK5RSySjQDQ92lMufwyZHy2zQ4Fu2wKWod7aAQrrrPnJyKruPLOD1z
         WBMFw7NHzEG6G+BjU9tvGcty/sGUn+8oNGsQ4hu6AQdsS9eCK8V9fr8rLGsZ+voOdR0Y
         mMUxRBLr2W8rXl6826cXH7/5ivKvWVY3AGnfj70JpI/tC3IwVbKTVu+LrLG0N6aR+s0a
         gbTIY+9Kdw0wwIYcmqWVQY209rMOFDulhmOhzV50B+U/Z1XLfVbGG0gv5JQ/4cZUoERg
         8xcpXJleEi4FCGpuW3j8Y45719nGEzHqvXjoTCRQLUxJKMZmJ7GSg/3C6HNcWhn/ShC2
         Cvpg==
X-Forwarded-Encrypted: i=1; AFNElJ8IrDZ9DyidmZDk3QBJGQJt0MWx/7wy7RzuYOarwRZunsTw1jBdppb+d7GyoQJdiNOoFaumAZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyio1dD3hGru7gtf01YXQ+g10cXDj0r/LufYE0i4vVAfZchZzsP
	sD/0aEZkBeCKzz0F6JwUh7qrDEs3ihX1ODl5Ydp+zplnK5w/lrxrQiwUgR/J0iwCaRkjz7pBqva
	+pkhjfmwk0CYAP2u/onOQxvGwFtqHI+jn/lK8Jqjq
X-Gm-Gg: AeBDievuVBOl2dKhlgI3+T5YnONoFOQoZ/smGLC2cdRF0YttgVD7mIumKSod7ktMdVT
	60F07voAfLy96AaUmbYYUhWVsMrkb+St7oZTSRWr3GKC1tM3hOIslxVN9n7Q5xbRRxdgOwqF1ft
	S/OqF5dzHHAujfOss6Z4nsQh7MJDz4uKaLOqSNHNey/Bh/oewq8NFgSmkrVk408BH+qcYIAzsny
	7aBjqJcoMHSqSZyOnDOXya6ORAA5FUsyTPT3D310Aa6eiz6PlHQD0xPKXLH2cKnEsyVhupPyryP
	RbQOUVSoSwaSEBqU3otK11vasNUCcvd8hduEIm62MgW8F9F4Af1VfxwgqR28ChfTnHwmDrSD9V3
	hhfwTC08g3M/oAuy3NsMoBF9wpGAJBurt/5kyahlPtBr3mHqc4yGSKomAhrAAK7GGmOikFZTghQ
	==
X-Received: by 2002:a05:7022:1b0e:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-131852e2bb5mr2101729c88.11.1778080793272; Wed, 06 May 2026
 08:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69fb46ae.a00a0220.387fc1.0002.GAE@google.com> <78183562-ff83-4b7a-9c7b-b3cb92676ee8@linux.dev>
In-Reply-To: <78183562-ff83-4b7a-9c7b-b3cb92676ee8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 May 2026 08:19:41 -0700
X-Gm-Features: AVHnY4JNtxJaB1nXkXSeADYgjNWogJRVGksEMWkM3mg3pHcGlY2h7MbXmMCHH2A
Message-ID: <CAAVpQUA4kYQ0KTxdJ=xtWp6u7uBUR2B8ZcvwHNV7FDDRu0OHvA@mail.gmail.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, jgg@ziepe.ca, 
	kuba@kernel.org, kuni1840@gmail.com, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 7:28=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
>
>
> =E5=9C=A8 2026/5/6 6:48, syzbot =E5=86=99=E9=81=93:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://=
git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e895ce580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D59da38148f3=
a3d24
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd8f76778263ab=
65c2b21
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for=
 Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13a613ba5=
80000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-74fe02ce.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c0a591d96864/vmli=
nux-74fe02ce.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9f94fb623cd1=
/bzImage-74fe02ce.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000000d: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
>
> Thanks a lot. IIRC, this problem is in process. The link is
> https://patchwork.kernel.org/project/linux-rdma/patch/20260424013759.7282=
88-1-kuniyu@google.com/
>
> Hi, Kuniyuki Iwashima
>
> I think you are fixing this problem. I hope that we can see your commit
> very soon.

Yes, I was sidetracked but will respin v3 this week.
