Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3038E8A2
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787723212; cv=pass; b=GoXAjaNhMKjfMX3KKSbzg+uBGSimui98Lttsay43I0W6s5kmeya5GLqPq4LeUQ68U6+SyPNNegfmBvbJDEejbQ4j/R9LHCmhCclgcWH+QRFVVTXABiuYb1uzkfGAWeLYWGv3oEiEXmDP2tRSKMyhjKw/a4cHnlrPmJdNquJXOps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787723212; c=relaxed/simple;
	bh=gVDwwTtRgbJ4+42D4J1okOA+Jd1XbcIpvYk56oql2DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRPscsDJNYdkU9c+BK4GhIgUPqIkLnVQrLcDepPmzFRDaUhlD0jxF+MvL3+mWCaYUvzgl8A3UicU+8+9cqwSIMD7p2VAZzLnjbkfpA51t77lOLujhoJPmHXlUC02h+ucbB6ozxEDYvbRaWdcJsHJxzTinXKa58gEUovCj9QND0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdN+XIVa; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdN+XIVa"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c149c5722so5014371cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787723208; cv=none;
        d=google.com; s=arc-20260327;
        b=HoUW+jhDL7a417rp3VyAN+HwQ9t1LqmmZuXXlzBxGIucFrHxGJPUFMDO0ClhWzaBSy
         b81pW+C22wtTlDCE1VvejVbYzStNobDfB3of2GY6QXwoWzBZvnNW2IpvDvzwmzdXlel2
         hWmOrFB67ZypBPrfn2H7dsMY8Mpto2CCffvSayOARiuqpOZXcpFbkt9gMiRiQG+3gPAR
         xh2zwcgUb7jaAGc3LD2giMmTofrNW+jNn6NbTINVGV0zHG85S98KFa/70QLA6U+SbKZi
         6gIJGpDv4nXycl5QehNJR3OwTAe873aTx0ux8j7auJJLy9PWUDxHND1TW0p8lQhuKaYK
         nyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+w/7DX5Sk47ZNBoYNrOcrswD7NmgBSVM0wjHxxX9+Vc=;
        fh=SI+0LsDee28MK2FmsDxB86Rl+fNrlbIVZS6tsbLOwfA=;
        b=QAGCy4K26CLru5aQVJ7QaQABvYH9lPNB+2qYxAm/HQGojP/5PPGN9Z2Cf9IlSOqP/F
         Ul+caXw+F02yJuKQCJi87+u4vMKW1OJOnf5GnDmudJgCsDcKBSpK/Rip5sZ19AkIQdsj
         iN4FCnbLQdElquJJSRZz1CAzC7W0sZvsREAWLs8Bk8s6d6NzFYhLapyLFkUDcnPF3iDQ
         RxBaNuzFcf1TYthRUGvXv+9Xx0QWrRNKoVvalHQQRtK/UWIR96lMZvPboXs8vIOeyw5M
         9VPjnygzcwwfYlEY8vlv/uNpBK4OR1lHwiTNIwqjWTDs35I8QTkpwResRqc9IFKS/op4
         2qog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787723208; x=1788328008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+w/7DX5Sk47ZNBoYNrOcrswD7NmgBSVM0wjHxxX9+Vc=;
        b=PdN+XIVatNFCY5VzgNjGPe6o6mjgJNJsnOyDBbfvEVJa+8pIhG8NpQsEq2Zskr58ig
         FzMK2h5liz01O00D4KO7LBvkQbz4TSm4YJ8UildyzdhQe2rrBeU9+f8assWgJ59X2s98
         aGVra6EpVtGOJ4771i8mB740vtz71d4sDI69HtBnXaJl0n62JGyvyFKG/CTkeyPW4Q9c
         25nVoEr3cKrjsS6gcFwxxpJx2q8Z5vkdKWrxwexaXRWKbxNectalhsgEEsVQUA6qjCHA
         uNTc2f1xU6k4qKg5lhvR2uBQnkcoEv8paPWoHOJhpDxPuYM0MIbpPuSuzLXShyoQq6sq
         BDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787723208; x=1788328008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+w/7DX5Sk47ZNBoYNrOcrswD7NmgBSVM0wjHxxX9+Vc=;
        b=JdsT09J8fZZ8EqtoZLMl+f7kCE9LrZnhpirPtgy0LublzKx2xckvkbhTIS+M4h5H9B
         zWnQTbc+OSNysPTNzjou1IhPWwNLw1omJnSnA7KMwGr+htucKzGy+HH6bpBRuelVgeSM
         rznbPm1TH8bJmu9SycqxCbnt2kPoyySxNtxHqINH6DQSM/bR2hekLPR3kSWwyJ2ahGkf
         /V3fs//jhhfRIqMmjrzitLLwj4uMWPXK19eqWuveCssAFiWRTzl29XZTMFP0lncDEOt9
         jOJ2y76SN+s8F3ejT54agrF/okr0n2LRQZC3SJ4oYLmxB7m/0t37RCRhvuQXp2t8JtLA
         jzEA==
X-Forwarded-Encrypted: i=1; AHgh+RrxmVT+kTteOI00GNgP+yliXKQkiEPmB8hgyA0EOkEf/NP6R1JbxmjOoUP7aM5k1GXBQ9oXREM=@vger.kernel.org
X-Gm-Message-State: AFuF++mHzrlNOpoNdtMccO+hHCwcAAX+7rkDCLjZpfP9tpZtpPuBFH5s
	dVxNvbTN/hK8h+Qgh7tVXjawviQiSdAWFU8SpX6U8EcY8ov4DRhl+2+HFqEWEBA+ELT8CCxWpUM
	6FD+imtY88o0oJbwLt0HYS8Ir6MUfYBLhmDYYOUVs
X-Gm-Gg: AR+sD1197mQmASKtZlROxfepBiUSuXN+GxGREk6hepaoy0HLzApXLQPas+qxlGH6Il7
	2l7K+2+pKT7vb+os1eRw9rNl3TqmPlwgK/EVzr7caXCrbzuwUAAa5YeVrjjB9egCyTHfxKskkCv
	Aq7n02qZBAmQAFSchnIi5ZACq1fULWzQJICap+DkrVLEJT9G7EjGCo5bGX8prguJMbRYAQD76X0
	PjZMm5cL9TsAzmiJeXWwJw3roPoz0XuNFLTF3Aa3rZbrVntWv3XLrAkt9e0Z+bZ6pW6ulFdfBlX
	g65h1oiIjM/Zdk9QpcpXiQG7v/p+/LCoEVg3Z0HONWKVCp07UZ1NJOleNpL6PwUDjwWoMqec/zJ
	/IzIHms04jOw6Avcq9O2GvsCWyeOcLZcuLEeIMb6D8AQkU89NpjX95FGN2gY=
X-Received: by 2002:a05:622a:82:b0:517:5f04:f23f with SMTP id
 d75a77b69052e-52e41a9525bmr44042741cf.4.1787723207231; Tue, 25 Aug 2026
 22:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825150655.1450271-1-jjy600901@snu.ac.kr> <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
 <8ea9c9ce-e1ed-475b-90d3-abf1bd86c3d7@linux.dev>
In-Reply-To: <8ea9c9ce-e1ed-475b-90d3-abf1bd86c3d7@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 07:46:35 +0200
X-Gm-Features: AcwNN1VDDKOK1wcPhSXuGTickrCc4V9hR7kwQN1fCfGssnUdsVJgY-tQ-1G_kME
Message-ID: <CANn89iLr7+c_Hgxgj-odS10LW7CR_aTQr6ozFezKtYC6=vXG+A@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 726ksm@gmail.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:38=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> Hi,
>
> On 2026/8/25 23:27, Eric Dumazet wrote:
> > On Tue, Aug 25, 2026 at 5:07=E2=80=AFPM Jaeyoung Chung <jjy600901@snu.a=
c.kr> wrote:
> >> Hello,
> >>
> >> We found a "KASAN: slab-use-after-free Read in slip_receive_buf" on Li=
nux v7.2.
> >> The issue was found by our own race fuzzer. We have not analyzed the r=
oot cause,
> >> so we do not have a proposed fix to offer.
> >>
> >> To reproduce the race reliably, we applied the delay patch below to th=
e
> >> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. T=
he
> >> crash log we observed, the delay patch and the reproducer are all incl=
uded
> >> below.
> >>
> >> The following kernel config options are required to reproduce the issu=
e:
> >>      CONFIG_SLIP=3Dy
> >>      CONFIG_LEGACY_TIOCSTI=3Dy
> >>      CONFIG_UNIX98_PTYS=3Dy
> >>      CONFIG_TTY=3Dy
> >>      CONFIG_KASAN=3Dy
> >>
> >> We hope this report is useful. Please let us know if any further
> >> information would help.
> >>
> >> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> >> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> > This rings a bell; I had a local syzbot report for this issue a while b=
ack.
> >
> > I think we should remove slip_hangup().
> ppp_async.c and ppp_synctty.c have the same anti-pattern. Should we
> remove theirs as well?

Probably, akthough ppp_async and ppp_synctty historically suffered
from this exact race, they added their own workaround: a global disc_data_l=
ock,
refcount_t refcnt, and wait_for_completion(&ap->dead) on every callback.

Oh well.
