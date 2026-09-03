Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0739E194
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423042; cv=pass; b=qZplfSy2+FcYLoWKqpS51zGDK+RUhi/sU4iKHQouNe2GYor2+qQMOzVvJsfgEiCv+QoX7gHV7VDPtrJZHIT0benUAhkQjEjMzmR0sdobDQlC6GOoC1o62Pwje7fOinmpdwlX+uvFcOMwh7J3nKV31Tqp9hNH88hmciGPxxYpkMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423042; c=relaxed/simple;
	bh=Ri1nuWgBzlWKmVgcPTEh7t/O9jzz9QoV3TsIc1HvvfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8e2ObrSjBN1kgL5aoQYJ2pYx8DEXLj5LGGCsmpmKpQ6vWxBmZdgcOxEL++zkIxaa5sAQeJY3RVPwXGN8o1qmF0ETP9WYUhbuaM5g497m7CCbhYta7z2DwIdVsLn7ntT1RQL+QX6mHww5gZDhJhG8ENRTs96iOVzQBJC3OdTVvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcR2zzjI; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcR2zzjI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8200b55dc47so25793597b3.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423039; cv=none;
        d=google.com; s=arc-20260327;
        b=mTJFxusQ8USP15cfAgGksfdeHQVW0JUDKFznS3e7YN/unlt0sFyHQ/rVM+o8RcyrNw
         w5gr6LbA5Gs2vyu3FK3ba4PlEy8pXWy8R/oYfDP7mYvLnGd4rkav+v2eqaJ0iNVoAgKo
         SVfq4tefsIBeJaEJdHhrZM4f+97dAXH5VsIA2Nj+vCE8hept+OmKkIAdwhL1LhzLteTH
         d3wBdg1Az2HFL/tgQIpU520i0w+2IC20sC8Fy//JxNdebBniU/AoBfOq1vOo+1JsD5BC
         tlIJSSNUxWCFc6eeTCznEeXgZJMPsrjtUSfxOKaqSh1cSgOzn8f76ihNPKY1aD4GAiCE
         OhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        fh=gu7fLyfxE4VlcnlB0OTmZZ0d3DLguKbUdHtWUwJCDNs=;
        b=JayNdGMDNjIMj6RcJyqDyJbuUNkHVKTqd/lt4gvo5ZEUDs71vm5OuHM6T6kMoyHe56
         uHcx4fhwHjaDo9/U7VTie+kTTnup++W3w4kZ7HqSBAkZXCT1WqWGm1+kmviKinLNuWi1
         dax0eQnrmUNZisLB2ex88D7Gy75ZCejQ2yD5HupLZXwX/QgFh7nDiLyBJaxn+q+qoMy2
         ZbUD/fjkISsod/NtBtTmpJgql6xV2wRwlGX6hkcayLkQKozu1/2jcQdo9vlKhaJWs0yf
         u+3wF1BkiDB7SR92fEQz9D1a9YcDkDH5S2dGXwoOuRS90Z80kbFBRgji46GJRHoepuYP
         33xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788423039; x=1789027839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        b=LcR2zzjIv2x4YVoqkAVRomcXZRAjg0izLiKxxMQmdKCCxXVR97+sBfyqzUTzsEHdhl
         EMFj5aIqVCMkmQ4U6wjzE5MfqM0P/Y4Zd9xYT3PSJ6WQJ8+XcbjxFeRVs+gPW+1UXB4e
         lxqL0Q66O64xFvumAfjMy5cyc2gejLWcb78fTiM61vaDRNEpTs4ZzRKA4iNFnk3ehowz
         l4QINfv4VYbAuyWSq0MgxzbgboreG59nsl5ThQJ9njF+d93SGnbPV/l7URweDqtk6Yii
         TY677a+l/CsNMMMB2riOQiuz+bD2pU3NniEaZfnpXv5ZYuoYqC7Z05Moe4cjRHPeL0E3
         jgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423039; x=1789027839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        b=qiNbDeh73UyBURNGnneOEYgs5Q6bsMsHfXEE/xPYfEx9zpvN8TuPzT17m2BraPmJnp
         kyyVYvGNT0qtMMbVksDqZgxmM17WMada0gy5N18gm8xH5O3TcAh7Mr/0kHbKjO/TWjAO
         SYHFWs/mSespI22X3BcMHqyhSmFsb+L48LMKQQsPiWFbe3eB9MPF9bIlQoXCFv744Jb4
         eYzSs/rLk/UQVrfiCPh6G9Nswj9jJ4TeuJgr2gg/XWPTOvwW3SjiQ6hFiuwiq2ynX8le
         OzLl3HqXuOBL6LoYUHu8oYvfVe8abY0vcvA1uRaURnNYCAni+lKiQhYc/94ZgWzA6nTF
         6/0g==
X-Forwarded-Encrypted: i=1; AKwUvByUuEivUTO9NPIfjCqNcjdXqOkdtECeFVqW3NQnSTGsPRjiSBVqp1qjDuM7GupGTe0t1NDojo4=@vger.kernel.org
X-Gm-Message-State: AFuF++mCb0usYt0Uy0Ls+BMiJaZC4Uh7NJV/w7AxhRSmKKc93YhxBoT7
	/voYp85SMqwdLUDnOFGevOlDBFEAHaivLYE/PH+yFwLJ4LCCzpBkFyes3hmdZPOOOMmf4STvJIt
	qqQOvEIvYjYbeCGLzn28QQrHxEAXhaBI=
X-Gm-Gg: AYBFou0hYOtuyp728+j9DghslB/xXCvKy6fTO7dWdkk03AAHaI8Bve5MEOqWUJKr/uQ
	/YIBNARmNuunzLwbAIIvtZ0QlH5wRtaYLhRCt9fehGR8do1s8YG5dTTFS3mq6wqDHuRonIy7NmD
	h9FxD1XF1RKnpLrGh9BCM7tH9MQIBT42Swtohqo07mxTUtJ6mg0IeL0Y3E1Q4HULZ7zUMouFNhe
	4fDWe6x/TDR8E37iz3MjVX+LrlVG83f5El0NjIZzl0wuxT8B/8kiLNRpMcPFFfubxd2K4gFIUiF
	4ZzuEzi+ZjCug7DGwyaHTu1C/lBeiqXSr4xAkXSkWzRN
X-Received: by 2002:a05:690c:4ad7:b0:869:adba:625b with SMTP id
 00721157ae682-86c53393f40mr38386797b3.25.1788423039335; Thu, 03 Sep 2026
 01:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
 <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net> <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com>
 <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com>
 <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
 <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com> <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
In-Reply-To: <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
From: Bochao Cao <bochaolucky@gmail.com>
Date: Thu, 3 Sep 2026 16:10:01 +0800
X-Gm-Features: AcwNN1W8zo3HUntwWLr6xgG9tqUYq1Z6AYfTZ41NEPBEx_muIqXDrBLxpFt8tzc
Message-ID: <CAHKNYVXFB5aFBNU5-__TsVNNX2ket7TO1EB-HcX1FgJhbKeVCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT processes
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thanks Daniel, Alexis, and Emil.

  Moving the test to tools/testing/selftests/drivers/net/hw/ appears to
  require more than relocating the shell script. The xdp_features userspace
  tool, BPF program, skeleton build rules, and test environment would also
  need to be adapted to the net driver selftest framework.

  Would it be acceptable to take the process lifecycle fix as a v3 in its
  current location, followed by a separate migration series?

  I would also be happy to work on the migration. If you would prefer to
  see the migration before this fix is applied, I can prepare v3 as a
  small series, keeping the framework migration and the process lifecycle
  changes separate where practical.

  Thanks,
  Bochao

Emil Tsalapatis <emil@etsalapatis.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 15:44=E5=86=99=E9=81=93=EF=BC=9A


Emil Tsalapatis <emil@etsalapatis.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 15:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri Aug 28, 2026 at 5:32 AM EDT, Bochao Cao wrote:
> >  Resending as plain text because my previous reply was rejected by the
> > vger mailing lists. Sorry for the duplicate.
> >  Thanks Daniel and Alexis.
> >
> >   Dropping the procps dependency is not the primary motivation for
> >   this change. I agree that Debian can remove the dependency independen=
tly.
> >   The issue addressed by this patch is process isolation in the standal=
one
> >   test. The current readiness check may observe an unrelated
> >   concurrent xdp_features process, while cleanup may terminate every
> > xdp_features
> >   process on the host. In addition, a DUT which exits before listening
> > can leave the test waiting indefinitely.
> >
> >   Although this script is not currently run by the BPF CI, it remains
> > useful  for testing real hardware,
> >   so these process lifecycle issues can still  affect users running
> > the test manually.
> >
> >   Would it be acceptable to fix these issues in the script's current lo=
cation?
> >   If the preferred direction is to move it under
> > tools/testing/selftests/drivers/net/hw/,
> >   should the move be submitted first, with this fix rebased on top?
> >
> >   I can send a v3 that drops the Debian Closes tag and focuses
> >   the commit message solely on the process isolation, timeout,
> >   and cleanup fixes once the preferred location is clear.
> >
> >   Thanks,
> >   Bochao
>
> While I'd defer to Daniel and Alexis on this, imo we could merge the fix
> as-is and move the file as a followup since the change is a net gain on
> its own.
>
> Wherever we end up putting the file feel free to add:
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> >
> >
> > Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>  Thanks Daniel and Alexis.
> >>
> >>   Dropping the procps dependency is not the primary motivation for
> >>   this change. I agree that Debian can remove the dependency independe=
ntly.
> >>   The issue addressed by this patch is process isolation in the standa=
lone
> >>   test. The current readiness check may observe an unrelated
> >>   concurrent xdp_features process, while cleanup may terminate every x=
dp_features
> >>   process on the host. In addition, a DUT which exits before listening=
 can leave the test waiting indefinitely.
> >>
> >>   Although this script is not currently run by the BPF CI, it remains =
useful  for testing real hardware,
> >>   so these process lifecycle issues can still  affect users running th=
e test manually.
> >>
> >>   Would it be acceptable to fix these issues in the script's current l=
ocation?
> >>   If the preferred direction is to move it under tools/testing/selftes=
ts/drivers/net/hw/,
> >>   should the move be submitted first, with this fix rebased on top?
> >>
> >>   I can send a v3 that drops the Debian Closes tag and focuses
> >>   the commit message solely on the process isolation, timeout,
> >>   and cleanup fixes once the preferred location is clear.
> >>
> >>   Thanks,
> >>   Bochao
> >>
> >> Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=BA=8C 21:01=E5=86=99=E9=81=93=EF=BC=9A
> >> >
> >> >   Thanks Daniel and Alexis.
> >> >
> >> >   Dropping the procps dependency is not the primary motivation for
> >> >   this change. I agree that Debian can remove the dependency indepen=
dently.
> >> >   The issue addressed by this patch is process isolation in the stan=
dalone
> >> >   test. The current readiness check may observe an unrelated
> >> >   concurrent xdp_features process, while cleanup may terminate every=
 xdp_features
> >> >   process on the host. In addition, a DUT which exits before listeni=
ng can leave the test waiting indefinitely.
> >> >
> >> >   Although this script is not currently run by the BPF CI, it remain=
s useful  for testing real hardware,
> >> >   so these process lifecycle issues can still  affect users running =
the test manually.
> >> >
> >> >   Would it be acceptable to fix these issues in the script's current=
 location?
> >> >   If the preferred direction is to move it under tools/testing/selft=
ests/drivers/net/hw/,
> >> >   should the move be submitted first, with this fix rebased on top?
> >> >
> >> >   I can send a v3 that drops the Debian Closes tag and focuses
> >> >   the commit message solely on the process isolation, timeout,
> >> >   and cleanup fixes once the preferred location is clear.
> >> >
> >> >   Thanks,
> >> >   Bochao
> >> >
> >> > Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> =E4=BA=8E2026=E5=B9=
=B48=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 22:49=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> Hi Daniel, thanks for the notification
> >> >>
> >> >> On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
> >> >> > [ Trimming the excessive Cc list, and adding Alexis ]
> >> >> >
> >> >> > On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
> >> >> >> From: Bochao Cao <bochaolucky@gmail.com>
> >> >> >>
> >> >> >> test_xdp_features.sh waits for any xdp_features listener to appe=
ar and
> >> >> >> uses pidof during cleanup. A concurrent test can therefore make =
another
> >> >> >> test proceed before its own DUT is ready, and cleanup kills ever=
y
> >> >> >> xdp_features process on the host. The readiness loop also has no=
 timeout,
> >> >> >> so a DUT that exits before listening leaves the test hung indefi=
nitely.
> >> >> >>
> >> >> >> Track one active DUT at a time, wait for ss to report that exact=
 PID with
> >> >> >> a bounded retry loop, and reap it after each test. Consult the s=
hell job
> >> >> >> table before signaling the DUT so a stale PID cannot target an u=
nrelated
> >> >> >> process. On failure, terminate the shell job with SIGKILL and re=
ap it so
> >> >> >> blocked I/O cannot hang cleanup. Install an EXIT trap and signal=
 handlers
> >> >> >> so failure paths also remove network setup.
> >> >> >>
> >> >> >> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance te=
st tool")
> >> >> >> Closes: https://bugs.debian.org/1136522
> >> >> >> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
> >> >> >> ---
> >> >> >> Tests:
> >> >> >> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> >> - make -C tools/testing/selftests/bpf xdp_features
> >> >> >> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> >> - verified cleanup terminates a blocked DUT without affecting an=
 unrelated process
> >> >> >> ---
> >> >> >> Changes in v2:
> >> >> >> - Clarify that avoiding name-wide process matching, rather than =
dropping a dependency, is the motivation.
> >> >> >> - Track and reap one active DUT at a time instead of retaining h=
istorical PIDs.
> >> >> >> - Address PID reuse by signaling only the current Bash job durin=
g cleanup.
> >> >> >> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang =
wait indefinitely.
> >> >> >> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-=
lifecycle-gmail-v1-1-45984df8d295@gmail.com
> >> >> >> ---
> >> >> >>   tools/testing/selftests/bpf/test_xdp_features.sh | 82 ++++++++=
++++++++++------
> >> >> >>   1 file changed, 62 insertions(+), 20 deletions(-)
> >> >> >
> >> >> > Sorry for the late reply. With regards to https://bugs.debian.org=
/1136522, src:linux deb
> >> >> > does not have to depend on this at all, so the src:linux can just=
 get rid of procps in
> >> >> > any case if this is indeed the last dependency. I'm not seeing th=
e test being run in our
> >> >> > BPF CI. I've Cc'ed Alexis as he's in the process of migrating and=
/or removing tests from
> >> >> > tools/testing/selftests/bpf/ depending on how they fit into test_=
progs framework. I'll
> >> >> > let him comment if there is already work in progress. It feels li=
ke this script could be
> >> >> > reworked into tools/testing/selftests/drivers/net/hw/ tests and r=
emoved altogether from
> >> >> > the tools/testing/selftests/bpf/ dir.
> >> >>
> >> >> There has been an attempt to fully convert and get rid of
> >> >> test_xdp_features.sh, but discussions around the corresponding seri=
es
> >> >> highlighted the need for the script to remain available for testing=
 on
> >> >> real hardware.  Features covered by the test_xdp_features.sh that w=
ere
> >> >> not covered yet by test_progs have been added to test_progs (in
> >> >> xdp_cpumap_attach), see [1]. So there's currently no active effort =
on
> >> >> this one on my side.
> >> >>
> >> >> Alexis
> >> >>
> >> >> [1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51c=
ea913710c@bootlin.com/
> >> >>
> >> >> --
> >> >> Alexis Lothor=C3=A9, Bootlin
> >> >> Embedded Linux and Kernel engineering
> >> >> https://bootlin.com
> >> >>
>
