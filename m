Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792919631;
	b=irj5kd3SEwmxSzN1NkTPmBauKFd0f2YeDRahBJbKW6Wdl8UHGhvPbXJt4n7I9nWwkPDD
	 TWIM8sMkmXX+e9V+vXYW6QejDvhiDzqxT4fnZQghNmw+BXBJqv/9WVTMbc1V1S8CPPsFf
	 hc3oxzvL8el+8pzdaJvsYUsBTjFGf57BOfH7vmRwOyddoR0TrB7AfoOEa7GBSLO+6u5s9
	 n3J7lkzLxzTzM4RvfpPYEL9LhjEb2DKzYsLAt4rG6q7QAvmlaPKv4uYAQxL1QGMEPO7Ka
	 UJ1Qb7WK0p2oTV5zXUzVec9QNGhFXXO+z2DDVtQN6DEFFFGc4p5QngXWme7vRlc2XyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792919631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oBabjhiD1rQ4tbEXY7drQjt+LTH2wSsXeFN2ti8cL7g=;
	b=rUqv0kP8sCMh0Dgutj3BY7ErvIuKNL71cdPQifzx+XW0DLYx2Nyfsqoz1PQntbPBvCdK
	 gZLtTwdSIzSO7R2ARU9o2DKjff8pqNjRBjz0cw5qg27xv89djXbzK/mmc83iF8odU3Ur3
	 15uTjARmJfCyrMLND9yqoQ3bSsDAdLLgEF4KesdBQbW+g4/QuEr4shlrjqpzYv9MQ+OAX
	 24d8vbCEPW+8nAnSCCfzZMzJarIZIUcyp2ldFsrOuIxksfRykjLQIBxDT46UrxefqZRqo
	 5jGfUn+g2/yPJ9QlyZQEA6/0Wx8dwFDdKeYQPDaq/lWLW102Y+yx8LQmksfIDYnBHQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Pa9whJpt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DED606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03DED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Pa9whJpt
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1465992b3a.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792919630; cv=none;
        d=google.com; s=arc-20260327;
        b=L0xp72ewM6vVsNXHW9ywWKyJpmhFOiUqRkb6cbuBRfO7Nohd/ud6HkI93A5ZIjlsTF
         IbaXKEaanw1XS+ML+M9BzQQAzsxVRVXgowoPrl0z8ctw32U1qSRFEU0f5nC3PAtoNBP5
         yFx6CI9LZ9E4tM9v6wiyq1l3qvPNFTB41oRh2oDfjYX4WKuihsoO1Cz0Zzf0AhBD1WeY
         RXfX7wEiIkitSeTtVHyjxVaQVrkUHBRBPLM5Lj+4Cm/pv5aGZSry77XeDEmegoAEQK4l
         CyVr4H9rGkc3FGprRRXywNVmUzNOwjHGjD6ipwSQCRxA2GyAU7DH443l2A8BsRZuPif8
         RXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBabjhiD1rQ4tbEXY7drQjt+LTH2wSsXeFN2ti8cL7g=;
        fh=9x4+p6l2Zi3DyDRYU89PRrngvv0NwclEWaN5GG+1xyQ=;
        b=TG7ci+E8jU9KdqkB2oGpFUHJ3VLchKL/oRJljoVmXPXNRRIY8MDCz6dpTgGG7Ht8w8
         V8Opko2ZA1UrSjQV7B0CGFLI36U02tcSSgjYK+L0vwCcI2S1siMCfEfhmkrKq9D4+fft
         d8F5LGfKjFsc65Iz+my4U4ufzoedk3JiuyDTsewwkN1TqPSb6VxO29H4REkdZaVcp9Kb
         9vOkL3UfxT6P28bOlshdlKWe5T3xmIHnJ/lhWgIp4U8nxxvbgom5DDXK5M8WUreyGz7A
         YyQ5J2deoNM1q30W/9s/bVBmGHYUlyV5ja03EhskzObXyQIi6GB3lA+NvP/RfCGW/yrg
         OORQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792919630; x=1793524430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBabjhiD1rQ4tbEXY7drQjt+LTH2wSsXeFN2ti8cL7g=;
        b=Pa9whJpt2+pX2IKfUr0v3K+DhB34016JeiiJ14fdqzNSpDp/m4md5iSan+Cv+NaX6d
         XYmbV6K+4LBRy2L4k+yS/9vpSnXBbt2ehXQPqGu6uL/Pbjnqf/OIslPWttavKidZJLha
         ekZX7eQWbR9g8oX7anwaPJfoCMxm74s28d9Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792919630; x=1793524430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBabjhiD1rQ4tbEXY7drQjt+LTH2wSsXeFN2ti8cL7g=;
        b=mLv36hoCl2IjeEAsxJNmMnssTi+tLjWvcK5YotxRo6NNustyncVpNbv8KMwvxhKO6/
         9PNa2cOnXQH1pzmmf5ghWIjQL45qNRUI8pcEcxdjYCVfg8CvuHJNy3AJ2J24mQyyHOIi
         8jlQJPmqcsCqqwNbWV4IK25LzXCDT3evPEMLDwVxlDmpn/DZXMtchkRmmHgjHE1f+ahl
         c6qYNMwK0jtZEoP6980xrMHQAYf3ckYJ9sSGF+l+xgunX3jpFECWTORJOqakafe8CFZM
         dKjQLmgQjSlmmq+8kxT3xD+S/HNpNrc/9W/EkT0s4EhIn0/8oQ0WOKEu3hOn0+TibBsA
         7UJg==
X-Forwarded-Encrypted: i=1; AKwUvBwqc5t/vZq3jo9ArXQ2YkTW12agAqtYBXzjouteMCdkV0vQ02rgwnfXXG3lB+GLR4UQ6QIZlnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhZ5K+WF17N4VTjO15HdTFgU7824m3W5yZ92hAwMY6Nl75swbE
	FA/a7hyj9ZWSme7URbSPimb3fl3Cy6BTKfq0FzYU6gaDyJbRbTLoNAUAEL7raWIl/1IDmwm/rU/
	o3Pwy0whPuno0zSe/sUph4kV48Ree3pCTOIs44B2O
X-Gm-Gg: AYBFou162w7T8Ed5lRWy/fFUBUB6j/fa8Emq+vDut4GwwnoCoyqU7TzQ/igkYbxnOXc
	8av4rIH4mnWr7HoG0eebUssX3rsaVonujMF2hjxXsLSENtLNaexDr1yYZ0JU4LeU6cdWsj5ZMio
	p/YYWrsHbK1BlZU9EwM7mYU1EzWpFBEcXEOoAQvzM5BiSjA12C1GogDp6dFMEfr94qm9TWKHZym
	yJm+vS0kZzRp4w4/50WKN2ixdS+flujDBI8d7OT10yidRAIP5lLpMrAaK+FI3tv1C6ZcEHSXSDq
	hopBtw+XxAwVsm5cct082RA3NHwE5F1zl6koDogPUPV1YMKb142SChzlzk7n4ZPcuDPTawlNvW2
	iNNqDF1yIw+ms3BI0UhZY6uUA2Ij+ZMKsh0teuZmgTJTPxigGLbW/z6KO/0g7ihWyhyz9hQ0ki+
	NhapZQN6BQY3QBeq4=
X-Received: by 2002:a05:6a00:a115:b0:876:194e:b8fe with SMTP id
 d2e1a72fcca58-8a366f660c1mr3180660b3a.26.1792919630278; Sun, 25 Oct 2026
 02:13:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
 <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
 <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com>
 <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com>
 <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com> <CAM0EoMmxpVv4YRoQQ3jN+79OKjaT=ep3+6jff8CHoOBLJUej3w@mail.gmail.com>
In-Reply-To: <CAM0EoMmxpVv4YRoQQ3jN+79OKjaT=ep3+6jff8CHoOBLJUej3w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 05:13:39 -0400
X-Gm-Features: AclHuK80D8qgJg44CQznpEWEuYQO3yP2tYU2BMNxj7xLNY98_DjMCZ-FphGgVQk
Message-ID: <CAM0EoMkOj8zfwB8WuTEOxEzAoGONg=2ZODehVMBzbA5c+EebZA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: David Lee <david.lee@trailofbits.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sven@narfation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 5:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Oct 22, 2026 at 5:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Oct 21, 2026 at 10:56=E2=80=AFAM David Lee <david.lee@trailofbi=
ts.com> wrote:
> > >
> > > Hi Jamal,
> > >
> > > Following up on this thread. Please let me know if you had a chance t=
o review the attached reproducer or if you need any additional information.
> > >
> >
> > Please resend to the list - I lost track.
> > And if you follow up after like 2 months(!) you will really have to
> > retest with the new kernel and likely look at the list to see if there
> > are other fixes that cover this issue.
> >
>
> Before i try to reproduce (then proper review) please resend
> addressing the issues raised by the sashikos. They are legit.


IOW, send a v2 with the following addressed; I may have missed some
things Sven pointed out:

1. Sign-off chain: the patch is From: you but only Kyle signs off.
Read Documentation/process/submitting-patches.rst, add your own
Signed-off-by: as well (and a From: Kyle Zeng / Co-developed-by: chain
if he authored the fix). As sent, the DCO chain is broken and the DCO
check will flag it.

2. No blank lines in the trailer block, and replace the prose "Bug
found and triaged by OpenAI Security Research and validated by Trail
of Bits." with machine-parsable trailers (e.g. Reported-by: for the
finder and a Link: to the report). The "Assisted-by:" trailer is not
one of the standard tags - please drop it or convert it to a standard
one.

3. Add "Cc: stable@vger.kernel.org" - the Fixes commit is from the
original QFQ Plus merge, and this UAF is reachable with CAP_NET_ADMIN
in a user+net namespace, so the stable trees will want it.

4. Use the [PATCH net] subject prefix in v2 (this is a fix for the
current tree).

The patch looks sane, as I said earlier, but there are just too many
incoming and too many fixes over the last 2 months - so i just trigger
our automated system to ensure it is reproducible first before I look
at anything (and i would like to maintain that discipline/workflow).


cheers,
jamal
