Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBE530DEC
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575909; cv=pass; b=Z995hwx7y2ApTyssOS6AckTUKocF+jT21dnMwwxTqYOYt40+HEIDC2xRKB1D5Sb4WUcOLOQsk32wi5eektehjzyd9ntAGqYVVISZ9bK5mffTk6i1dPclmJNfeH8D5NpfpU2sEbCysDxqe7kNKfEwn++QdOnPeEh83uHlu2Pk3/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575909; c=relaxed/simple;
	bh=Tfy5DSiHTM2ZgjvWMzhVCdG5j/zkio3GvqabXlNj/F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrRXTuEZAGK+jr57GkakrzPnnXQM6UsxkdNX/k+Ixaki9lQP+e6RZMl9CCz/kkCPUOdU9dvmoR7QWd63CiZgKHeIHMOTo4DNFvE5XeIz3vWX3u/fJl+6qy7jFwSjuWEIU6cKQdElIpNEzM8th41eDK4E2tlxw6dPBMcxr3I+Z28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZekhNhp; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZekhNhp"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so598298a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575899; cv=none;
        d=google.com; s=arc-20260327;
        b=F2tilzwLCi0fA3trPurChlLjLFHME8UBIv0FWrgTkKPr59TAoGQFXp9/fSUYiZWXBp
         x3FWjQN6OQ9NfXKgl0wnKDIPBC684sCRHqtLFFn4bXp4Amk4AwmCwn9lpQF+lw3O3UO6
         bhq2tajZRRslxm+W7iZCGelpnSt5txm+DB1OmGcb2dwYJrkLkRxfPBAHZcQU17sv8R/P
         5K42KcE93r+zVMrSIwq/IRTQ7DJ2h05CvHbNdMsVm3G31uQdmMixZp2KKwHuqXkeWfm5
         8kGSJoRCasYJie9UR/MOOoU1ON9jr7WGGj8w1Njt3u8I7/xnd8EFKXVlTIDHM5/Qc9hi
         X6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        fh=KLu2iPOPdBuEwc4Bu9qFp9UiJ6ttmbdGROtriDYNqOw=;
        b=rUpFlXtvbVimyzI+ciahxJWL+ukwFx/k4msejOPeo9fdEWsW3O3NU/CmTSQB33YIFA
         6hI0LdFkXJXqwQFWZU73rkn3t//gZEBAx3/H49P+i/eHxQASYiPnCfxUbSIPNUqm3Znv
         0wNy3Y8G+z9cJoLMlWCaqgMUQRPFDSw8nsjtWXqrfnHTPd2gUZ6neO3LnXolZBeHLkAT
         OKHqCZUhwxg/mgLMMDaJib/unfRZ3dRsi86svX1bHU3JjzEAodUH2zS7CJ+qcf032qcu
         6lm3belZLRf3D5CjVSsl/V8jM4lR2v2DNU0WqZZAhe/Cgu4G1I5VyW1P6NKsplnrChu6
         ERsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575899; x=1790180699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        b=bZekhNhpcg/1WhRHKG+Te+9vs6pKpnPaeYDWYjxmHME2wRqUKJwf+jbgpyIQk0f+6V
         O13fJ64qVUx0EbIwbu58oC0t+S3pdV9MTIHi1uM7QDpLJvzHlet/u3tlnO9/FgAuHkFh
         WQBPJoP8/NXvDcjpTh7jSeinHytvfkuVsSilIQSGdhzC2KUbYqJliGCs21YfYXqSqETO
         rk4Z7qavbTXqB03s39SBI4JfjdMg19KoHEWsWzptpKFTAEnE0Gt5Uy1Na+pOvclqT9gz
         q66MNxfH6dcaNjRIEoaniNrjEW7bksizf8f9c6V1JGBGPZLtsddsnaFpbNi/nmwiAOf1
         wJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575899; x=1790180699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        b=dEOjjs5EMDZJ+JkmkVuLn5Sx/aIfH3UJtULGk3eYzCCp5TT4amXGiUy/4e7ezGwsvl
         FV+IlJzMRaWGD8KPOiZHbtrmdeFd3z2OciwWE6m54IXy9fjecux+w4bM9QUfelejrGb5
         wyTmq8R8/Yi4bip0ikxWJJoDEQpTR7qTsVk9ePJyTk+DP9p0jeMfQ2mUnLmtTP3kyYd8
         yhhGf44m8poiI5lUbpMz6sYA7yU9noQKbI3Rxd6A+tBB4PB3WAeLivhlhfQh9S1EUo3A
         LgGVyo1XsEdgJ8hImzm0p2KJr6pGlmEUZvOuWjJ4yRQyQvyzQ6gI28uGrXKYDaTNT4j0
         VKQw==
X-Forwarded-Encrypted: i=1; AKwUvBy//OkgH3ecnNJJuTKMNZZVqW3YcyaBKEZLrsA3XnVLbmx5tzWOLFNgd6vbYtIynBWQSJBZYdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++knVwLepPdGwrfi5nKXvSPjpNN4L4ghNPc2I+FuB5aV/DoDzWCl
	6Q9HBwvwlLriDHBHY5q69eBP0RTKWGwFCOGjeAu3DQbCJMaWhT4yufLNG7ekDhm48b4xXAKo2Ss
	+JaIWm9IxOjmGY5YJAZ23MorZgBXl5eQ=
X-Gm-Gg: AYBFou0pQEa/JJmdejufNdoFBks4w9sQdlp+nfFvwqCag1TB5o6YVDpQWzitSsAn0UB
	u/quNTnBrxQ9p3Oe8u9E5UyIwYJ7TZKgw2G16o4II77Agk2gsjB4Q8SeTsPAGHOqcbvgOl2mSvG
	ShY6MaO8FpNDjHa/sj8IflaTzjBUycppxdHAC50e3qfeOmnnY+l3r+Mwt0dVv8IYN2/u2Uw3sVI
	SOGF6FQzazMqRvB42xwxuYhBILhJm1sU7nR60bbWTHEmwNn0M1Xx7MvsuVyDPndvriqVo3ePNPj
	FyNp4YKGDM/OTw5y5Rw6bVNOhJNMFVmAOZXFIpaiq45ww853xn9F9f5v0OIekR+zEv3TnxE1ULf
	N729q72tsKK/fPX2NBb1EVarRJzDzS+OQiz+XvDuqtXAwpxQm26yg6KAEctS+QDqCUeJ5FBAnHi
	notEzIiDGvwigZcc9Fmjul9RfdbeQt7ZA=
X-Received: by 2002:a05:6a20:9c9b:b0:3d3:adbf:7781 with SMTP id
 adf61e73a8af0-3dd5f73f2fdmr9852912637.22.1789575898997; Wed, 16 Sep 2026
 09:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916112554.413933-1-madhav.khoslaa@gmail.com> <fe92569462dc4decf36f4dcb3b45372fc0d42fb6842eda0d3396fa18ee32aa55@mail.kernel.org>
In-Reply-To: <fe92569462dc4decf36f4dcb3b45372fc0d42fb6842eda0d3396fa18ee32aa55@mail.kernel.org>
From: Madhav Khosla <madhav.khoslaa@gmail.com>
Date: Wed, 16 Sep 2026 16:24:46 +0000
X-Gm-Features: AcwNN1U8QHUiHDV5g4tLvSfFw01ei7S3h8NzFnBoBxITmcE6o6f_L5XxCkZd1mI
Message-ID: <CAHFb0oABUaKNWVcNZwrxPv0MJU=3Jt1X+iv3fJX9RgO97uu4iQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] selftests/bpf: Fix csum_partial() dropping
 trailing byte on odd length
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexis.lothore@bootlin.com, eddyz87@gmail.com, ihor.solodrai@linux.dev, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but would it be clearer to paste the full failure
> output or mark the elision? The summary line says six subtests failed
> (1/6 FAILED) while only the ipv6 one is shown, and test_progs.c runs
> three ASSERT_EQ calls per subtest ('test first port', 'test second port',
> 'test third port'), so 'test first port' would have failed too. And
> '1/0 PASSED' reports one passing test, which cannot come from a run whose
> only named test failed.

Not a bug. That log is the test failing on the TEST_PACKET_LEN=3D99 case
against the old (pre-fix) csum_partial(), not my patch. My change is
what makes the test catch it; it passes with the fix applied.

Madhav

On Wed, Sep 16, 2026 at 12:13=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/test=
ing/selftests/bpf/network_helpers.h
> > index 75133119c04a3..878c9fc5c37ca 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -129,12 +129,23 @@ static __u16 csum_fold(__u32 csum)
> >
> >  static __wsum csum_partial(const void *buf, int len, __wsum sum)
> >  {
> > -     __u16 *p =3D (__u16 *)buf;
> > +     const __u8 *p =3D buf;
> >       int num_u16 =3D len >> 1;
> >       int i;
> >
> >       for (i =3D 0; i < num_u16; i++)
> > -             sum +=3D p[i];
> > +             sum +=3D ((const __u16 *)p)[i];
> > +
> > +     /*
> > +      * RFC 1071: an odd-length buffer's trailing byte is paired with
> > +      * a zero pad byte to form the final 16-bit word.
> > +      */
> > +     if (len & 1) {
> > +             __u16 tail =3D 0;
> > +
> > +             __builtin_memcpy(&tail, p + len - 1, 1);
> > +             sum +=3D tail;
> > +     }
> >
> >       return sum;
> >  }
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_clas=
sification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classi=
fication.c
> > index 80b153d3ddecf..421dfa6c4ea36 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificat=
ion.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificat=
ion.c
> > @@ -27,7 +27,7 @@
> >  #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
> >  #define MAX_SOURCE_PORTS 3
> >  #define TEST_PACKETS_COUNT 10
> > -#define TEST_PACKET_LEN 100
> > +#define TEST_PACKET_LEN 99
> >  #define TEST_PACKET_PATTERN 'a'
> >  #define TEST_IPV4 "192.168.0.1/32"
> >  #define TEST_IPV6 "100::a/128"
>
> The commit message body includes:
>
> >     v1 -> v2:
> >     - comment style: opening /* on its own line, per BPF selftests styl=
e
> >     - Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
> >       ("selftests/bpf: move ip checksum helper to network helpers") mov=
ed
> >       the helper, but sizeof(iphdr) is always a multiple of 32 bit word=
s /
> >       4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
> >       was never reachable through build_ip_csum(). csum_partial() first
> >       gets called with a length that isn't guaranteed even in
> >       bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
> >     - TEST_PACKET_LEN 100 -> 99 so an existing test catches this instea=
d
> >       of the bug staying unexercised
>
> This isn't a bug, but could the 'v1 -> v2:' block move below the '---'
> line so it stays out of the committed changelog? Documentation/process/
> submitting-patches.rst asks for inter-version changelogs to go below the
> '---' separator so they are dropped when the patch is applied. The
> content itself is useful review material, especially the reasoning for
> retargeting the Fixes tag.
>
> The commit message also includes this test failure excerpt:
>
> >     Without the fix and with TEST_PACKET_LEN=3D99, flow_dissector_class=
ification
> >     fails under vmtest.sh:
> >
> >         test_flow_dissector_classification:FAIL:test third port unexpec=
ted
> >         test third port: actual 0 !=3D expected 10
> >         #137/6   flow_dissector_classification/ipv6:FAIL
> >         #137     flow_dissector_classification:FAIL
> >         Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED
>
> This isn't a bug, but would it be clearer to paste the full failure
> output or mark the elision? The summary line says six subtests failed
> (1/6 FAILED) while only the ipv6 one is shown, and test_progs.c runs
> three ASSERT_EQ calls per subtest ('test first port', 'test second port',
> 'test third port'), so 'test first port' would have failed too. And
> '1/0 PASSED' reports one passing test, which cannot come from a run whose
> only named test failed.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/350910=
50280
