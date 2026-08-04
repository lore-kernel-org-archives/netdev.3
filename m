Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A2463B72
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851859; cv=pass; b=cJA0N1qwjjSAbEJfo5Xsw8z0UmEV7kPJN11dYyPtN1vEyEk4PHcd81WK9gx490z5INV9vOyFCVYeXPz+BSAsfC8TV9cB7kocvSDYTwSUSCdr0UBkXUAtDIJAVSWUq3NEGbBHZcdbg76USz5IAsAU+9aWPnLPGzFGD4xLCIX3MVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851859; c=relaxed/simple;
	bh=bbfGwGDiOTik9OqdWY952RI2Az73rmUNw+iO+t3QLpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojQ74WELzFNxfslBohuvgP7+FNGeajOSNYtO7MVDc0rNEjkFrgrlA+qwTu2P1hlcd/vzfPOkYNCOn2gvG5tCZPSWXM94tnV2crcQm7HSzEwC/wfCURBGiD6We+kJm8/6i2jxG4CpylTSf4kiUiTkCfbcjg7R99HmqgDOoEkECiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmHofTy8; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmHofTy8"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efec2c28f8so31473086d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 06:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851857; cv=none;
        d=google.com; s=arc-20260327;
        b=EK/gTIAWI8+s1DWdSbcdjICd1D6h6ZZCRkXdWbKcI/cFjJEIM8vswZHmaG6ubQ219T
         6PK3Ln0RfPQaGz8+D15nPO8471lRIzT0wSca5lu4meJS/OFZHqLXhTRQlJQQ7tRxygFI
         fhYFMyWFqtknuTpbmrGCZ5gGMOWMSPabeL9J+o6LI3aZbjKO7xUas+4GHmHnE8+WGL2w
         KCGwlkgdx6GKF/J4yDR2owM2eV9Ms4jzC7uK/9UPZyHkMXkyGh/OKVI4RNHJCIDvv2nV
         y9d2oY2IoxsPUgBcWZF1aNGePJczvxEuZhAC2Zx0u7MccU94hN4CnOSCliFt/fNbYe+z
         WGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbfGwGDiOTik9OqdWY952RI2Az73rmUNw+iO+t3QLpE=;
        fh=jgLaJnQ39eDrgW1BMqtRytfrHtJTUAifhonZoZnF85E=;
        b=amE+Y50Xh31xkKCf8bHinqQ/t00c4j/5O0LYu7LTA/4UYsRlq5QwcwjS36e9r3vjA/
         gip7v5KuoRpYY+M6jS+hhGVuaoz1MIapKSX3w8qGgVbOoX5NUerUuTuzy4qihjSE9m8n
         kVFU17FYr2tVs1/UO+Q8i43uteihFkW2oeHlP7DlDqHxZ1zGUM0Y9BrrSW/hTrKKlhZ9
         7S9aFtZhv2kfYNRdzf888jJ1L5+xQKxm5VhJXImGI2ij3ukHHA1EqXGV9XjU2q2UsXzZ
         N+bjh7MFg3RyNmNXHrWLu1IAB6pXBnj/4lHb9t+wu+14Ek6qJuMTarlQ4uW49fI5Br9l
         I+HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785851857; x=1786456657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbfGwGDiOTik9OqdWY952RI2Az73rmUNw+iO+t3QLpE=;
        b=wmHofTy8RMPtPaFbGxxJDhdzYgh/Irq63SuvMjZpUsr4h/oJ1o/j4HmXZw8/8IXWiL
         mxzot6Qf8Fh6hDFuFkng3UXmmtUDrH5JNf6U2yHtv9SJvjJl9JwUdEmc6/u8oEy04hbR
         eA0Lr0XsdcBEKhg2/SAQgWfnMa1L8SyFfFiwnsVp+E3+Uyjl34pF078t8F8ksHBXKtiH
         ieX/F3ESEuN0+eqZQK8SwyskWs5TfQNOdd/G1qe3LSXRCUK6ClIaqoLuKnrzXAp7OenR
         YvTZ3ZWeLDf2G33GmsZQI9fH3BSs1ulVjK3tU7l9n25vKb886UFMrMgX0gChOXckJexA
         v8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851857; x=1786456657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbfGwGDiOTik9OqdWY952RI2Az73rmUNw+iO+t3QLpE=;
        b=KgW6/FaGSKKo/5bdgsAcEGS0ks1OGYlunrtJzibdnbrrNnWNTQOJCXxRBGm/6B8w2N
         0Bj+fM8ZGW/rHWPdck/X7QYdPDour9h4rQkWyxYgvM2a+Pb5jdConBRmOsG1io1N8T4A
         YjHeHEI/KIGGJbg92IBSlhJVWAzC2yd4yjJHfOmeLL9cK3WQ4TkFOv/s/Rrl4eEhPhay
         YV0D+cV8SKE8VBMeT3Vtd0Gb7JTQINzv3FuRY7C8G4fhdDCV5VNEitN1/jUkqdtNfWO6
         s4E1PPBP6gP0wiqL5zbDvqZJiZ9whi407ZzhIKqYIl+VPNygv3Wkh+DlJgc+d7wy6ozC
         fLYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQZY9185/JT9GHvFzh8msY3SHdHuvNNyeNQDZbsjWtRniu5fQ9bhMaLYKxGnur3mdX3GU9SQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUNiIWGM4Kzo0anqkBzbLhEgoSNMUg+2asVqE+ww19JbPe2ke
	dWhI1cg+Pz3eFcK8sVgMXNeX818S6gM1xsKIlAMTCw+Zr4Hh5efAjboKxzZoOhvuslY/ushVZ5X
	dK4OYoGDsgP7BR6nje1P3oLu3g1CK19W91LEAObUn
X-Gm-Gg: AR+sD13bFkiM15IcUdkaCZLgsfU7XmrtRJKNyZJ/k+rw/U21NgCpbPtqyKZNyHkXJet
	lVJNwNLNEwycYst86sRGW9G60YIjhXxf3fPWGql9v7h+GZAsq/FyFb2Sv6vhVFYdj7Uc/6tJV4u
	qEz/CD/5Qj84xsIg4dXGPeutVE8aULzV5pOXgDOO/ktTlujG9fqFwdllxmn3okb3uqe+kWAqYrr
	qImPTIqDWPWZSckLAWXFR/9ozWXCdc/dl80RcIDI5e78mpI8xYGlfANDHmKGvGuZxnl5AIn0bcw
	QVYSRBxi5uLA4juA8DECCMSlKOOqpKKWun0/IpM+c9laNsvvtuwisahx5LXeFhVa22oi/YR05Uq
	DCDVnxFbglH2DuXPnswxvTh1SEjC1cB062MoLnTxm0wOHj/GxH3rdwr8=
X-Received: by 2002:a05:622a:22a4:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-52b5674cd39mr273710301cf.27.1785851856160; Tue, 04 Aug 2026
 06:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724035419.1473174-1-edumazet@google.com> <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
 <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com>
 <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com> <CANn89iLO_STTESJwU-shGJGZ7BbrFaePb64ePfr=J7bffV4WXA@mail.gmail.com>
 <b00519e7-9c43-4867-baeb-f7ed1303424a@h-partners.com> <CANn89iJWJD_KXpeDOne2ujeznOADV8O=rU5+jdqQF6YMEkNkJg@mail.gmail.com>
 <e857b453-3fda-4457-9c93-9eae376157d5@h-partners.com> <1c4aed7c-b323-4793-93a6-a43a679d8f12@h-partners.com>
In-Reply-To: <1c4aed7c-b323-4793-93a6-a43a679d8f12@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Aug 2026 15:57:24 +0200
X-Gm-Features: AUfX_mwkFFbPjSUt1Z5AWS5nWZqmRy3c8IZQtijD5Qx4kGoZ8QOZm9aZ8udURgk
Message-ID: <CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:37=E2=80=AFAM xietangxin <xietangxin@h-partners.co=
m> wrote:
>
>

> Hi Eric,
>
> Gentle ping on this thread.
>
> Just wanted to check if you have time to post the v3 patch,
> or if there's anything else needed on my end?

I have been on PTO, I will send a series soon. Thanks.
