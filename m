Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA83CEB9E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582679; cv=pass; b=HGUF7dLrbZBpb1ZUBtzglDK8MoVqpk645IxZyQFet3WAvpLz3XbtSFYUfwaj1zmeD1y+6ToBwUklyi05cnq2l/gifmJo0lcpK0aXWueGUYBWfrJHd44LaOPN0+K1ZATnj+GeEqvvSv8vFuGpsYq3LGzmlu3mnPpwCiGNfyg870I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582679; c=relaxed/simple;
	bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJbbhJW7m6z4z1dL/X1CYRw93hUtUvOvGC4sYJCP9Pjoa+POOl72rCboBEjP11D8JyWT77jEpuYy5qhMHqB78PA+6YAp/GJ2vYhbf1IYIBaMN2/ULbj/hPn9gknvxULQZBs+o0+mbwJUbJKT33J4/izvqgcpNKjoPdcLMCknJZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8GG0cQr; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8GG0cQr"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb93aee5eso1411333d50.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789582666; cv=none;
        d=google.com; s=arc-20260327;
        b=iCAwop7rR66tZMmHmv4nV46ErqVRzGsgIOQI/tIxGxeCB5kKZGyE+FdFfL8C8q5oSo
         FZt5/moGvalA5xabkZvzpahnm0FKyHgLx9g7Zjr5cS9J3PfRfDHH1aIySGA2spIyI5JF
         fWYjjI1Edvw+vum/w+39ffV4y6GiY4Y6eQ7wTK5cIOfyG7rd/HXo4t+6Pe259Opmb88P
         R0lH6eoVzPD0KdxSygPDTMu/B/XSpPLqlEmFySpbqIsJck+Ct/I9xq7OJulPPloZXQsG
         IQn+V+s643tLnKy9mHsVyDfKBE3LIRusE5Rp6I9OhxIveNdnRABjtS1uJv383iMnO0/B
         /3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        fh=ybAblbqWd0eyoMHz8ju227a8HKQX7Mqea9Ez3YdJj9M=;
        b=JMceRHKosdNwldjcQ5LXDtKWuggQWVhsQ84f2TtJLicupVWea9WSOnvub5a5cZuV7l
         6xxzHAQVEmOiSao9+Fz4UlxG147QaZP5BPGCq+c0ge8dHe6AZQJKNMNZ3uNXsKxK1hLV
         zivk9Qfq8HYKyC6lfn8gQmW24Zd7Q/x6HDDVEF0GJ8TsS3MMGF6qZ12mvxvgyVofEacl
         esbHMe0A2omo4bRvsIV+p877o6UqZRDulVZoFU+8K7/gyNNgXvA3/2EO+GoRO/ldI9R6
         AH19agKokPqmqYb+gZ9A7lVUNZaXzFKgLwc5Fjb3d0PKW6M3f53GqNM3EBpEyNvxD/zp
         cjDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582666; x=1790187466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        b=D8GG0cQrXjfdKRm9wNQEsJEWU9oYGeRiTkHhjdpJAYiULFxjgSDjqcLxAojrxz/t3q
         SnQJNKAEML6dAS3xd0evlCPigWfQHo4PmIh9f7+IncDtt/ZD+O+oQBJdyA8iFB6S6C6+
         nOqlqS4Gt1tz7xNY0EkaKkmQTGyglcrcLm9+Da/Y/5e6E7dD8no7EPTtsWvAN6aDErkP
         XQTcwMl3Vn4Akx7nHZ4tv8x7kktx2+E8jDySytkt4cI9WcSxIXf6p9NYjSGsOcJD31j3
         VZKoMmAZfoRSu1lVTw8+7qe0VHdwBBXkgrtoPJMCOE0eZs/p+AnbRI9CNnU8vQha4dlP
         c+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582666; x=1790187466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        b=VdslQforIN3Myot68u1p4iOoqHl/Lh1eNt0vSQKXRxppPsDCXkdYZ+aV76mvahuTiz
         8YHbcCQG5mR5XbKBMxr4Z6LdTLBW4gcJUkLdv1i+5knwwBc/5AmTUOvPVnp6AlukQQSN
         6V8tRzS+hGzhnI7y0q9yc8qvhq8srksirY34H2DiOw51I4n9Uoivan//NkO6K0RgBQr2
         YvOYItIyjJJ7OEItBvu0rpvESt9uc6OZN7LT0Dn4HS09UZCWx5gNDdxhXzO8G4ZE1cJJ
         ljlR4o3t18w62VANE6l5leNm89/n3X048QaevQviFhYn+llm2MIwlMzVlQaE13ewjBGp
         WGcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOQ40Z6lPbBvxgwzoDlXLysNLkD0RotUTxk8VMyymYsu3b0r7WseB5pudbtemFalNJ1+qPH/U=@vger.kernel.org
X-Gm-Message-State: AFuF++mzwYfg6KB7342GaRsu7c5kp+xrRuiHnuMx9DgIXSJNRqeNVXg2
	t1eEUuQI2D8j7q7H/5e6juXdfbMph6p9GxonIaOkngjlaZ38Q+K6ueV13lYAzOfDsVFP/9OzRMK
	E4Vq52dYEaBpxsyvOv99NE7eDKtmZiOmfQ7Ee
X-Gm-Gg: AYBFou0o+RrvnbxmoCoXsStFwgL4zSXowREi8IzXq+vnLBP32xUaxguKi1r+oEsJ78g
	+HQcCVEoVNYZeSf2/Pw13I5CwI64xXeBqISsi0DzIK21Bn5OJ7q/Zg4qCTguJDwyaSynM+J3S/k
	kwZi4yX1f9jFkSMMR3IRd9WPxpb1DPgCTAKhywMr0ZKMVRFRi4/qQnhbc5jckfde4IeXc83F3Qz
	Mdi1qoezFG/wFKY8DUBgcwnu1cb8f7W0VP4owQJ0fJdUDwljeA8k1gOCVm2U0X/WhzjAwRR8hXP
	nuOjGLd7/qNJoOwf3k2KjNx1PSSt8DsCOjCrU62O4dF6vlfOuX7ZQ5TBR+jVFLXbQwHtrFMzwDp
	ZS0Vy6Npwlq+NvhiWLPZyo3CkwxlzlU9xTUG1QcRSNVyiX2Tq9zAh
X-Received: by 2002:a05:690e:138c:b0:66f:c1be:315d with SMTP id
 956f58d0204a3-67163291a67mr1457852d50.52.1789582666426; Wed, 16 Sep 2026
 11:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
In-Reply-To: <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:17:35 -0400
X-Gm-Features: AcwNN1W_n_JWDmPObAQFwyQQcqcRS0ohE6q1zHG-qJ_cbD4eagEDvwjzvohFxRo
Message-ID: <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:15=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:12:28PM -0400, Luiz Augusto von Dentz wrote:
>
> > I incorporate the merge back into my workflow:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D967788508ba263e22d856f971c9118dc1a73f6ff
>
> > Hopefully this should stop showing conflicting/duplicate IDs at your en=
d.
>
> Thanks!
>
> > Yep, you can add me as a contact person for both the bluetooth and
> > bluetooth-next trees.
>
> With your luiz.dentz@gmail.com address?

Yes.

--=20
Luiz Augusto von Dentz
