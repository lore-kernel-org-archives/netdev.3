Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5A3E9F9E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644258; cv=pass; b=V3ONQOpuMrGQmu3JkBPgQsfh2K2v/B4PWrgaODUcdXnqIR9lxA1pxYbyAHqYk7TM123ckgm17Qog5XoBwqTtD7P9upDjTkvfhjhDIFxyP9SYEQk82wvLF7xo8daSHNcdAiIaP+pKkj04oSjJlENvuGRcyWnje3V7qls55/FkyD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644258; c=relaxed/simple;
	bh=jOV5xkXWixShmGZ4KByXLEK1raOaOSri7iKmC2Hzfy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBOJIUWD0WIoUxESlvCRqm1fWK8j8ATPQ/GXaMIIGLkxHf/EObzV0I9yqL6vINdIrcZLlf+5sNQAQYUK8PWe7I7kt2yBFCh+WlYjfztEHDy2hB/dO0Ipt7wvPISeRwLupbm/pm8mWpXD6EC/7PWGbAimSQelJSadF1tttap8cbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=n47LG+2I; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="n47LG+2I"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso611525b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789644256; cv=none;
        d=google.com; s=arc-20260327;
        b=YjiMO9AvaqY2AbTu1E7NIC8/K5VK21txHabpOW8H3jZ3GrPzWOJs8+BaZJ29G15fwQ
         jUNhZCpRXjf7yi5bBQX/O47wtfJBvZSutGAhX8k+SAahLSvu02+sbzkyK/bxHLfiyF0B
         TeJTWa0i+RkaP1OwDzUpaHvS8P7J3Ueg+JWqvzTHbc4WnuKl7QOzIxckeC5/Rk27EiKx
         R8MTN+EQbywERenGoYis7su9yeRtx5dy6ctV1KQO4Zf74iVpJVYmDYba3yS+k9gLBvih
         jUYMYn/7pSFzuhaC8Mc0tyqHJ8niplEwJ6j/7wfYX1iQ9/Q+zOA9Ef/Z4GeEg/FkdxzG
         QMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/5GuyYmurDA/V1rcZQlZGT+C/hvfrRvjcxLhT2PJiC8=;
        fh=/zN73WG5IhYHPVPNHCwOL0hywHeiEwTx/khvRoIEHnk=;
        b=fToMPqG+BZIgpW5O1xG4xflFPTjF0dINZN94ikZ5RzSM5vz52EbZ7UNkFYFe9XHQG8
         wapcrAFl7zp8EiAgBAvYvYabV6pito7T7I5VjM0fovD0uQLI/Oz8SM6xIs57V367Dxvi
         FPNHlsAkk532Yb6Wn7txp/Gy6q6FLYnn68ReMOlGeCmIf5VUD8/NQ9jKgCLJy4NrZVcF
         a7/ZrpsRkkthL67iXkpbiX5I3htQJCMPAJXS06nKpPvBEau8huohA+HfiYY45roCtiOO
         XQGxQZxsH/W0CSjXIrIr3hZrNoWlwW3uVfM3qhOJD2j0eLBVTVXozfaGNn0stVCy5db0
         cZKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789644256; x=1790249056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/5GuyYmurDA/V1rcZQlZGT+C/hvfrRvjcxLhT2PJiC8=;
        b=n47LG+2IjZ9tKhF2xW9t87CYqFA33W8tstB6xqhSbo5x7R6IYT5AEAnTKror6e3QoP
         lW09c1aJB8Jk5KKIO2srJT3XmI8iynImiMqjf26PbyIonTlKI/Okq8x0bPv5QBzjcAaD
         BxhyIBp9B06B5MFaJT3M7hFCIIGAskiKRwIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644256; x=1790249056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5GuyYmurDA/V1rcZQlZGT+C/hvfrRvjcxLhT2PJiC8=;
        b=K5Xe7UDOQ6+ou8rse8wcgwVPobiLk0YNcp2XGSLbReaCPs0GED9QYOJ0ALeVGrowKG
         t64Pc4aIWrph9SZUVKzuyU+p+5XRj0cwii8LkJXW2vzHcZ/SeY5V+ZEkufOgLjnHclD2
         lFVf9bV4Kqz427RzuSWeJhGBH6K4/748vi23no8u9s2ZpmW1unyHFXUjgEEvC6vt46fw
         PLizTv+OxgiuUGG4uVwoDVi71x8f9IOlhQee7tPEuNlP0qGJMTR4hln1ANMDE20IOLo1
         yoxMNL4WdWGV5pN6k+hGlHo17r2wuYWG4iS7Ln/BrNw8wYxA4eN/xPfyREPuTePyPrlk
         ojCw==
X-Forwarded-Encrypted: i=1; AKwUvBwJNqC/mKB6NVd6KlnAzCJxnD/d7EIGHGK9IEsbqeHAMqSZ9RUkAKrBE+lZqzITFVbmeEIj9vE=@vger.kernel.org
X-Gm-Message-State: AFuF++llHk9eGOecF6gmA+LE6PJ8H6nUmw5aK+ycLV9mvipziHDP2CLA
	6k/JCf9YKVQOp9YMPxi2J0iqazFgyq9TlgG+nFMXJk9Si/qZ211i6h0SGI6rn9BMB88CIx5pwBa
	dMTzDD5Z0KkY7bDOoSCpRMLYFfqoizSFL0mv4M6Us
X-Gm-Gg: AYBFou2hgnRO1Niu9pbJ6q1NDf9AyAmWbxWyHzF/lbn3Cp4Q7Kulf/VU0UDnRjo2gJC
	jL9VJkk4szcj48JU09+KY+pW968M7Pe30Awra0VBB70GqavRBiMTmeiuhDcDaaAxX+8tpCRuF2C
	QjalB3INwVRN7mfPO9dqs6OOAw+wcDtdU9lAYIwtmCOCtTjpdGBtRM5cTXzctSJFZ9USSYB2+2v
	+ufViHr7jg8OcqEkTglwVlT1ZTUvH+RYglJlf5BrlFa7UiVOIhxt1dF+1J42TxN3V3GoIoAYSDJ
	XSsbn0HSUyFZ2GTz/+JhJksAtBOO6vWpQSOE4lgoEDR4qngvmZGNEQOxjZY67Ikx6eyr24lWJhw
	/tdfZXp31nvDy6GPm10DJdQLWueiX9ZPqJgoFhKYqSfJc
X-Received: by 2002:a05:6a00:140e:b0:845:cad1:d691 with SMTP id
 d2e1a72fcca58-87340f8b157mr4518381b3a.5.1789644256073; Thu, 17 Sep 2026
 04:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911133146.3440982-1-victor@mojatatu.com> <20260914191108.55a1a4f1@kernel.org>
 <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
 <20260915085304.775a829a@kernel.org> <CAM0EoMmiw_kVnK4RjTT_dkquw0YLSB5VgO_7EoV2WT_pQXbCYw@mail.gmail.com>
 <20260916170425.1c7a7cbe@kernel.org>
In-Reply-To: <20260916170425.1c7a7cbe@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 17 Sep 2026 07:24:05 -0400
X-Gm-Features: AcwNN1U0-vZIN_n2YJY2Z_wRcHVhBYRR8u5CPoBC8AlvvmsI5deaoctwLClJBWQ
Message-ID: <CAM0EoMn1SkkC0goKD3-OreQtEwYbfr3zYJdmfrDf8HTdHWrNjg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: Jakub Kicinski <kuba@kernel.org>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org, Yuan Tan <yuantan098@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 8:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Sep 2026 06:34:57 -0400 Jamal Hadi Salim wrote:
> > > IMO any attack from containers / user ns is hardening. If it leads
> > > to a crash we take it via net _because it's a crash_ not because
> > > user ns can trigger it.
> > >
> >
> > Ok - will review the pending ones with this in mind.
> >
> > FWIW, here are the rules we have been using:
> >
> > It is net if: Regression (worked before, broke) or always-triggerable
> > crash/UAF/leak/lockup
> > This specific bug could potentially cause a soft lockup but it wasnt
> > consistently...
> >
> > It goes to net-next if:
> > a) Never worked (adds a cap, validation, accounting, or enforcement
> > that never existed, e.g. memcg-class)
> > b) Doc/comment
> > c) tests - although the exception we currently make is if we create a
> > tdc test for a net patch then it goes to net just dont cc stable on
> > it.
> >
> > > > Since we have a few similar "grey" issues in our pending queue - so
> > > > where's the line for net/net-next?
> >  [...]
> >
> > Given the flood, here are the priority rules we are using:
> > 1) submit net before net-next
> > 2) All bugs must be reproducible by our (semi-automated) system
> > (hybris). I dont even look at issues unless they are reproducible
> > (hence my nagging "do you have a PoC?" ;->)
> > 3) Assign a priority to each bug and submit the highest priority ones
> > first. The priorities are assigned as follows:
> > - base (reproduced, ACCURATE) +1
> > - Crash (oops/panic/NULL-deref/OOM/corruption) +2
> > - UAF +2
> > - Lockup (soft lockup/livelock/infinite loop) +1
> > - leak +1
> > - simple-trigger (plain tc/tdc, no special PoC) +1
> > - privilege required: (root) +1 / (unshare -Urn) +2
>
> nice system :)
> no distinction between control path-trigger an packet trigger?
>

At the moment we dont make a distinction - the existing point system
would still work, I think. Do you see it differently?

cheers,
jamal
