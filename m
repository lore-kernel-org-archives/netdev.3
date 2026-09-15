Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D24B1B24
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495673; cv=pass; b=tiFi/fMwGSp6G0xBs0qkB4GgE0Z9iEcYXfBebFiUuR6L0XkurYfcSmTokXoF936K61JZbGzywIfcqFzgseQsm7dYv62NGiu20cRHBPIoaas+f9GVTuJ6+fxkOmNGIhnUNXi7llhhEjA/Ny4DygsPIyH5gFkg+6L34C03h7g9PsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495673; c=relaxed/simple;
	bh=WHuFY5lyfwFlgKIprd8NFUWzO+uzl3QfjnLSqIeo4fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTfk20ww0gswfbWSvqTxixzkBdpxujFcv2KcTNdGCj437fuXekPZ4w5Is2IhFaCeZt0wZj1wNdj4pSMmSknSLqfCc98ySGK+neKzYnVA1JYiFYBvgDyo29rxcoFyXm4Y/AxHmHha4bUweg+t5ywSqjBVwWlrrd2xHncXcG27Cxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfXjxwcZ; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfXjxwcZ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20a32so58372d50.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789495671; cv=none;
        d=google.com; s=arc-20260327;
        b=KcbF5t9Upbva2g16+wMEVOTVOpMmtJKd2r3ABQHgcu+2Z3u1N2mraSIEO1qxJvlfu2
         1piZ73B+Pt4qYlKqgmDPUEjZWAMjs+0YZRBT+9NSdyryMtiuO8qH1LmZpjuCPMrR1c+C
         YkfvEB8fI39/N0GG2c27M+Lg9yr9a01n4kWWZHxgheEKBMJ6awXtHxyY5mLcVSph20my
         k5DxAW2THnKShu5ruRqfIXrOdi4xxzJsuBQnMwUTiUrkXADFC0kflDFb9H5QlerlUfwH
         HOKhB+wKh1ImqZRH29eGPwKMwiKiYDBAQqXJkf4Hx7vrVxxUia94BCCAnreAovDURnll
         YCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        fh=GsahHlzMr2ADYLbpIXKj/mjBEZAbQgtGbEHn5qwlviI=;
        b=cR7py5cM3vcGC9Lr1udCX4ybayYb/GFN9dihcbG+2PgEd+U/DwEKCXxlkd+MNutekv
         /1Haoc5MWRMjuPTHz+UflOtP3KursJfMIrtEIWsMlzP6nFbks+tm5OxCEeLCCg5hdc1z
         Fhl+zITxluZ+crlbYV57M5cB5D+JlO9wraL20rZC0AHvqugIHeRnGRAo02Aj9cpTop0V
         xB51xMZZpSJFaenul44AjMBfWxvMSTp6s1XwmRN3Ljh1xEWwpFdGJ2figMOb3rIdLca1
         F2SrnNmuT/JOBbB7v8hwEVDOR7kNtCN8oF/3o1YJB36Kka0qIrptH1Da+5TDmutNGQtc
         Mz6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789495671; x=1790100471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        b=RfXjxwcZRxCCYDSsBDE0zhZbrQ57mIU6ECgiZTiaXn28poqYKR29mQXhRX2NxMtfie
         Nv5LK4o8xTcSdFN6r84ZrgTDXvOw5LDmtV0rhYrs1FAuQRwDUXbx2rBGGVFKzlGc7HPI
         Kp7kmP8nd+Qg5GLYTK+IdhB2AI00E6xZr+daD/jNNc/IM55vg48VWVtTy7IA1ZhNF8c7
         QiVifVEr+TNfKRdu0MT0S9fItRS7f/C7zmDh9xo/iDhkv9hNBFNtGc6SLC3TunRGR9u/
         sYkVXFT320JEfq5cLtIRjkK1S4NSuWlRpYwmmImptno18aeAu5bQN+4mFhuYHBtpygdh
         S5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789495671; x=1790100471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        b=UpaWKDd+Mc33mEYLAm6wIOZfwBQcM+OHD1zVN+GeqMyFuX9B/5g5VWAXsd5KJ/oXtA
         DIRhjAvE/4vO5tf2u/Si4ZmKdOb2P+Zy6adbUTi+ukcM6fRZTbIlw+4YpvION5t38G0p
         4tN/RI1OCJLcRV4jPzu++1l6OlP/CjG1QDZfR7PHrdRi6x0jwRKiubQITs4eun4Ww3SW
         MEKc/wjGs+LJdjQvZ3D8h1fxepVVd8GWPfXO4/QweE7aL/Lr8/ZrKuEDiIddoVZmmKT+
         W/ryIMIwAChOWkG8CVgTNY3SRsk9qyVleMwaVwRLJfxXNrXFlExPoye4GNhpdaDTentx
         CjLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqkNAM+JaxpwtONfv52nYsUuD2QN25BbiAwQvtbehamrX8n+8Rk3ihSSPcbaFUHohE5n80Q0I=@vger.kernel.org
X-Gm-Message-State: AFuF++meeS8LvEbWDq7tuvRxqacKKu0DeruDj3zVfQHYiGMnPvwO1c1O
	YJSqgaT9XqgBQWitBvz+9YvzTzKFfFZe8uMFktT3b1a9e4Do4Muuzc5MlMpmeNs+z/chj7aiv6j
	P5j68ktCPU7RKZZVldjJqJKHg+T5CRYw=
X-Gm-Gg: AYBFou2yGndV7MYDHp16TG8AqbjAXHRw6hjMkq+YDd91EEVpiRZK5YN8x1Xi3qHCPyo
	HtkjZH9gKOdYKtMcb4g8h+8qiWr89keedn7dD8Hr98FovEmjTyn1WSH53y856kV5D5iFxCEDnzh
	MzYtVrbow43t+sPzRInB3ZeT1rp1Tt4EvC/Vs1u/3XMbKORbXxeZfSt4MY8bmKUvr1bYWNBId0z
	PsEwrmDz7dCqnZhw+lfgUpQXLR0hbk2r+KC14jo9hEFJ+0JsqhQuPQMNPwIhHX9hE8S4Uc2EU5s
	/gVbEEuAyJBLUw04UBejKONUaU6T/jeVf3O9Y70WzJi5X3oLo/xvC7cqk+OnlvH76QoaUBdtCpj
	8X7kUggTtNSLGakQ7xDaj2FvmyMiuRm2XJ4kwS0IMzFB5AFR7xA==
X-Received: by 2002:a53:ac95:0:b0:671:2999:3a26 with SMTP id
 956f58d0204a3-6714e060b8dmr2603442d50.60.1789495670704; Tue, 15 Sep 2026
 11:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
In-Reply-To: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 14:07:39 -0400
X-Gm-Features: AcwNN1XJaDhKcxN6rFKX5saItsoN-QDKLpK8Kc3XBBzF3GPkM-xZVPUCaj4dQaY
Message-ID: <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 1:46=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 08, 2026 at 01:57:08PM -0700, Jakub Kicinski wrote:
>
> > You're missing a bunch of your own sign-off tags.
>
> FWIW I do keep reporting signoff issues to them:
>
>    https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
>    https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
>    https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@sirena.=
org.uk

These have been fixed though:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D8d463624a249b6023e1bac6a5ebb0853a9c96d26
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dbe1cc4fae4cb7d506ad01fa7746db363c41dcb6e
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D9ec9d1ade8ae7a3bd3cc061534d767fe305bedb6

--=20
Luiz Augusto von Dentz
