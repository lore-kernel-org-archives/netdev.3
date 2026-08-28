Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C8227EA7
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909602; cv=pass; b=mXzPqeHhN/BPvzNV/ww7HiwhzZKb0zBJxn1X9+5nXnHWaO2ydTtV149NE29I0xp1/RCUwrBFaQuL2lgl8pqzFLi6Ey5R3Y9SQnx7ElDvNUcQAetlYz56fpQ5bGjAotCF7v/ThBxPz/ap48blRa1EEZqyo9DSZ6s48tdMfkDXcDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909602; c=relaxed/simple;
	bh=U80lg0O+GKLW7T+8XqZuXYkvnHWV1/kc8n8D7UOROWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7EFp98bLuOb31xTyPYP68uiRSeM/JeNzPhGNcO0JTeo4lZ0ZmOzCuUUQb4bpG5Qj24UherMDUUbncFTTb1P14tF3PRJEX1Pfq80ZHYRlOH0SXlkb/NwWVmzH9MoVr33cQWrT1z1l8Fqo46clygJVyZSqYSJwaZqeyv+FzCDCvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNe8JZl4; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNe8JZl4"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836ce5d6e85so9256957b3.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787909596; cv=none;
        d=google.com; s=arc-20260327;
        b=mFBfW7R4eIeuwydRDzbH2l97F7jMFnCYvrEsSiTS/dwW6wyGMIqmhxh1Q5tnTIZUVj
         klQrmccCurXkvqP88UCTit2hQGzX2ZOjQn7rjQqszS2ODfyNvyAf7zjNbLI/nGRfwqSY
         nQmHdNAIly7Fx9tVqwJPHdi/ONBq3ywkQKLpsxPwLnxpQ6GIekw8tEk9KmjRq0pG2OOq
         i1LmaU7NeHkcwgvbgj4f8jFnj/eMfQhaNgV9MO76iFyVGfwcNAJiprO240eyXS4jIzGx
         dpsSd6ptfypiRpSQnbnAf6f089SG2l+JIQlBV3Gmmga0yRqbHMaCQT8Rki9JCSzXFwia
         Q9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyKgfgA2jHgvHBfi6CU+LzxVcYLnQWijvxyS1/jFemY=;
        fh=fMgF1nH6+BZbBoxtQEtL+CbenADN+7Ur3LUK/Bt1ub8=;
        b=Iz8svmU1NNWrV+dh30/vBLz3pOq0FH9qQjVL+cpwAt2O6z4UgWR0hwtgV82hvypBqG
         T5ZttJ1wv9GMx/ozGZiGc8QE+CBU/LOdJX1GJIQe7ovfoWM1JtIdnmfwymRdSbdhJ9PH
         Ga+ZoGISegBSWjZPi3qk8jSEezlNdsTPNUbrXrCkevj+CL5wN6LabsRhE9L2qGlLZxWV
         zfYRyzhffGCZL7cau3voYIqPJgnioJviTsViiomYNe19y9S/NWXBc7+6QWdxDMVsIM7A
         ShvRmT9GSn0K/quLQfl/OT6mqYuEe/wtxRrDW5Z/LiltM5YFYgS5b+raMVMAe9arzqmr
         Pksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787909596; x=1788514396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VyKgfgA2jHgvHBfi6CU+LzxVcYLnQWijvxyS1/jFemY=;
        b=QNe8JZl4vgKDTuJWNKn22/Hpirurd+JootYRCU+9j9DI5OC8qC/pYftEKbaluadheI
         V57PHkNO68QJbarV+vmeriaZfi5PZb2JJmbjcLQA557h7mcMvXVL1grWKSADSI9NTmnm
         jP+FvwKUfLXq/eHHXa818ot6yGxsjVfcvhlQGCshLZHBZxybmcIGA+3BPLwpcMUA1Rr1
         WiL6V9QZC0640kWXHbs8Iv/2luIAnZvAhy+vyPsn3dTtdVn7sc8+orEWWyHj88WiRWtk
         doazttorfMJ2v/fjNZrklOtdupzNd5E2CtUZPmtZ0hUg8A7aGanvzBBGsqur8RWfuWrV
         i+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787909596; x=1788514396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyKgfgA2jHgvHBfi6CU+LzxVcYLnQWijvxyS1/jFemY=;
        b=LSwWy75QWP9W/Cfj+FVH0j1V2JUwRYkcvO77n9tBNzuKPBwzMnIy27DrTlNlTYVDs/
         WFqeq3Ls5JULif0sFbCd1YZn5SFAjlzq9rglkLNzJzNUPwXxTsSrp+9wP56S9+JmxeVx
         McbZdM2LD0SPu/wK6IzfHycjkYwNJxz9eKADhQrrOH54H+wQO20jBTlWDKVouOwe+HmO
         qbxikg9QFMQFeiAFJTwq3akuOcElcc4/NT6NNnRT4AeKq0Kazla3604utrXFRj9b4now
         naUgbP6r1FxYWE5UbDOxKpnIL11yP9P9KjhWJGcFjf9lY86HcVNe61LMtJrPcP/Y0L6w
         vnqA==
X-Forwarded-Encrypted: i=1; AHgh+RrCccxlh4ipryBajPgJdSvijuS8vOdfIMdI2JQZjyqCE3V9k1msoCcc5dt1WEKSTIxArq/1RFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n1P3He0Y5JUV5Six9Oaomn0LzkeLnvORfVgGVjrNLUbyiwVAdc
	QV80Z0ebuTx1Gj5L+EwJQDYPSDCMiz0rK9ujlA3Ea75Y4UMzETYhU+KnaxunmdXigZ/16MtPTTD
	nCXCZNQMsRuGcwcfJAkwTpzxMa3qd41w=
X-Gm-Gg: AR+sD11/3VKfdhCc7FEKGTj6HR+7Py17kt9gA5ji/MzQabARzT+a4pTuDCe4k7Iy4D1
	vHK/gR6o+t2vkBof/M0iRKJmEcmJiM5cjlhtjbgVWsS2fxTR6Ar1QcFaErHvg7fVWrTPd1ItDX/
	4T1c4PSzhbnMb1oS2G9soP0rAgIaEvOaiNSrr1QvmKfkvGb33ysap7NNTiISEqnnAPiT4Lozri1
	N8uRBk0F0G8R+ieaKRmzZnv/mV6V8An+BkpGYdpEXjwS2onWys/h8CGZFFNhB925alI8T3wK8xX
	wYZwUbdNkCtVXhKmtDiH2FmCesH97tSxmzCVLvVemoor
X-Received: by 2002:a05:690c:e3cd:b0:80b:9f4e:a73 with SMTP id
 00721157ae682-85d684bf30amr28089127b3.13.1787909595588; Fri, 28 Aug 2026
 02:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
 <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net> <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com>
 <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com> <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
In-Reply-To: <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
From: Bochao Cao <bochaolucky@gmail.com>
Date: Fri, 28 Aug 2026 17:32:38 +0800
X-Gm-Features: AcwNN1VW9XpqQ20Ki6rCBhf_uOiVcBbpYWAjy12V6TApwKjNoVUxIva86Xc9n18
Message-ID: <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT processes
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Resending as plain text because my previous reply was rejected by the
vger mailing lists. Sorry for the duplicate.
 Thanks Daniel and Alexis.

  Dropping the procps dependency is not the primary motivation for
  this change. I agree that Debian can remove the dependency independently.
  The issue addressed by this patch is process isolation in the standalone
  test. The current readiness check may observe an unrelated
  concurrent xdp_features process, while cleanup may terminate every
xdp_features
  process on the host. In addition, a DUT which exits before listening
can leave the test waiting indefinitely.

  Although this script is not currently run by the BPF CI, it remains
useful  for testing real hardware,
  so these process lifecycle issues can still  affect users running
the test manually.

  Would it be acceptable to fix these issues in the script's current locati=
on?
  If the preferred direction is to move it under
tools/testing/selftests/drivers/net/hw/,
  should the move be submitted first, with this fix rebased on top?

  I can send a v3 that drops the Debian Closes tag and focuses
  the commit message solely on the process isolation, timeout,
  and cleanup fixes once the preferred location is clear.

  Thanks,
  Bochao


Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
>
>  Thanks Daniel and Alexis.
>
>   Dropping the procps dependency is not the primary motivation for
>   this change. I agree that Debian can remove the dependency independentl=
y.
>   The issue addressed by this patch is process isolation in the standalon=
e
>   test. The current readiness check may observe an unrelated
>   concurrent xdp_features process, while cleanup may terminate every xdp_=
features
>   process on the host. In addition, a DUT which exits before listening ca=
n leave the test waiting indefinitely.
>
>   Although this script is not currently run by the BPF CI, it remains use=
ful  for testing real hardware,
>   so these process lifecycle issues can still  affect users running the t=
est manually.
>
>   Would it be acceptable to fix these issues in the script's current loca=
tion?
>   If the preferred direction is to move it under tools/testing/selftests/=
drivers/net/hw/,
>   should the move be submitted first, with this fix rebased on top?
>
>   I can send a v3 that drops the Debian Closes tag and focuses
>   the commit message solely on the process isolation, timeout,
>   and cleanup fixes once the preferred location is clear.
>
>   Thanks,
>   Bochao
>
> Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C 21:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> >   Thanks Daniel and Alexis.
> >
> >   Dropping the procps dependency is not the primary motivation for
> >   this change. I agree that Debian can remove the dependency independen=
tly.
> >   The issue addressed by this patch is process isolation in the standal=
one
> >   test. The current readiness check may observe an unrelated
> >   concurrent xdp_features process, while cleanup may terminate every xd=
p_features
> >   process on the host. In addition, a DUT which exits before listening =
can leave the test waiting indefinitely.
> >
> >   Although this script is not currently run by the BPF CI, it remains u=
seful  for testing real hardware,
> >   so these process lifecycle issues can still  affect users running the=
 test manually.
> >
> >   Would it be acceptable to fix these issues in the script's current lo=
cation?
> >   If the preferred direction is to move it under tools/testing/selftest=
s/drivers/net/hw/,
> >   should the move be submitted first, with this fix rebased on top?
> >
> >   I can send a v3 that drops the Debian Closes tag and focuses
> >   the commit message solely on the process isolation, timeout,
> >   and cleanup fixes once the preferred location is clear.
> >
> >   Thanks,
> >   Bochao
> >
> > Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> =E4=BA=8E2026=E5=B9=B4=
8=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 22:49=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi Daniel, thanks for the notification
> >>
> >> On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
> >> > [ Trimming the excessive Cc list, and adding Alexis ]
> >> >
> >> > On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
> >> >> From: Bochao Cao <bochaolucky@gmail.com>
> >> >>
> >> >> test_xdp_features.sh waits for any xdp_features listener to appear =
and
> >> >> uses pidof during cleanup. A concurrent test can therefore make ano=
ther
> >> >> test proceed before its own DUT is ready, and cleanup kills every
> >> >> xdp_features process on the host. The readiness loop also has no ti=
meout,
> >> >> so a DUT that exits before listening leaves the test hung indefinit=
ely.
> >> >>
> >> >> Track one active DUT at a time, wait for ss to report that exact PI=
D with
> >> >> a bounded retry loop, and reap it after each test. Consult the shel=
l job
> >> >> table before signaling the DUT so a stale PID cannot target an unre=
lated
> >> >> process. On failure, terminate the shell job with SIGKILL and reap =
it so
> >> >> blocked I/O cannot hang cleanup. Install an EXIT trap and signal ha=
ndlers
> >> >> so failure paths also remove network setup.
> >> >>
> >> >> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test =
tool")
> >> >> Closes: https://bugs.debian.org/1136522
> >> >> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
> >> >> ---
> >> >> Tests:
> >> >> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> - make -C tools/testing/selftests/bpf xdp_features
> >> >> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> - verified cleanup terminates a blocked DUT without affecting an un=
related process
> >> >> ---
> >> >> Changes in v2:
> >> >> - Clarify that avoiding name-wide process matching, rather than dro=
pping a dependency, is the motivation.
> >> >> - Track and reap one active DUT at a time instead of retaining hist=
orical PIDs.
> >> >> - Address PID reuse by signaling only the current Bash job during c=
leanup.
> >> >> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang wai=
t indefinitely.
> >> >> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-lif=
ecycle-gmail-v1-1-45984df8d295@gmail.com
> >> >> ---
> >> >>   tools/testing/selftests/bpf/test_xdp_features.sh | 82 +++++++++++=
+++++++------
> >> >>   1 file changed, 62 insertions(+), 20 deletions(-)
> >> >
> >> > Sorry for the late reply. With regards to https://bugs.debian.org/11=
36522, src:linux deb
> >> > does not have to depend on this at all, so the src:linux can just ge=
t rid of procps in
> >> > any case if this is indeed the last dependency. I'm not seeing the t=
est being run in our
> >> > BPF CI. I've Cc'ed Alexis as he's in the process of migrating and/or=
 removing tests from
> >> > tools/testing/selftests/bpf/ depending on how they fit into test_pro=
gs framework. I'll
> >> > let him comment if there is already work in progress. It feels like =
this script could be
> >> > reworked into tools/testing/selftests/drivers/net/hw/ tests and remo=
ved altogether from
> >> > the tools/testing/selftests/bpf/ dir.
> >>
> >> There has been an attempt to fully convert and get rid of
> >> test_xdp_features.sh, but discussions around the corresponding series
> >> highlighted the need for the script to remain available for testing on
> >> real hardware.  Features covered by the test_xdp_features.sh that were
> >> not covered yet by test_progs have been added to test_progs (in
> >> xdp_cpumap_attach), see [1]. So there's currently no active effort on
> >> this one on my side.
> >>
> >> Alexis
> >>
> >> [1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51cea9=
13710c@bootlin.com/
> >>
> >> --
> >> Alexis Lothor=C3=A9, Bootlin
> >> Embedded Linux and Kernel engineering
> >> https://bootlin.com
> >>
