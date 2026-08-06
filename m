Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA52690EC
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023516; cv=pass; b=sYpoeJoV92jskuTme1OFiZbzL38+UfnesZkZhiiQtZEaQ6Qr624HElQIbq9Kln75y70vTPjzC8bwWr/fSEj7DYuBfG8VCGnGfM/8A0yNFe7UjtsZ8cI7qRvJlXUzNeG54aJSZK7AP54VqKHMcvyjdlVfE1pMx2IDgWudfkKFWoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023516; c=relaxed/simple;
	bh=PHzEhrU8WI4T82TlrKa6NQf/0AGs2opcAg9+onUf+Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYkHjXP3GR+/kC6LaQLtRx9VH6oWiJgeWrvR2IRDUtTK793ngI7fIKqsHpls1Y8jwAR54PCss9YM8dCUb8JtfjbmwObZy8KFYHn/GWYjIC8OfdtatvGnmv4jcndaZpohfmwOqwMpNX2z6KSUr9wjg7c6mAtxwdyc4w3ctHQoZJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU8t+8I3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU8t+8I3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so26971225ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786023514; cv=none;
        d=google.com; s=arc-20260327;
        b=nwL2w7v9T67nkPDxrQkVUhR2UPsju/imkiYYymwxC/E1YIMs8j3t6rys3rFMP3y/yg
         /uCNyplf8LnvBQZNsc5MgOKOxsyMjbAMHZyBCahjSwpbPLfZUqzPJ09StW5mmuJg9ooS
         ztnywXs4KiPzcHUOBAoJf2XziuDYhoUsKSpEOubrDExrL5DHS8sJ0t0BFzdWY9S5E02o
         507cSnmjf0jwfNI0htuYvod14xutUcUfqSMLaYnZalZfNBg+cj560v2PwkM9QV8o77WV
         VjIuMjLZF1kCCUw2YGBCMyQvTz4KEbKxlEFzHJgX9fvY5uW+HD4a+HBDoyYmHjZOzlQZ
         JNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMkBzLdP9OyMfsmAjdRRIfPjOi/S3wZ2VstuxfJXLpk=;
        fh=HriQ7hAdnK9b1Q7bc6/yIsjUC8QLBz3+9hLXAIJ8j3c=;
        b=F4c7VChy2+0kj7CiW32tSf2Iq709vzpdohHqWDxgG+SRrLWCIlOXEIbDiinQk5jaHu
         IqjpNocuiXddHxxQfxsVH4Dn73QgKH2QEZaLub6N6PKwkfvZ7yS3P7W8wNxMiZncgTyA
         NeS4G4h2ClfOPNvuA7SPj/h8WZNjV2MUwiy35iPvQzIDnyz7RGFHTNNuZmmFRSW1u2zE
         zzEO/Tr7rzYAZaEi8mvZkzVrZH4drAjny/jJZc0p0vbF3W2nXFgPuQPc6sqUSmS/Azth
         jVl7kwcPXc/VGy64k1Z11tCVnDbuIH3RI7On9lm71Kn8HqZ7tSYbZk8Lc0PS31rPZfD4
         CNcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023514; x=1786628314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gMkBzLdP9OyMfsmAjdRRIfPjOi/S3wZ2VstuxfJXLpk=;
        b=GU8t+8I3517Dr2niX81FVhStMdet3jw8eniUEmpcO9NcHU57kSug7nycN3aCr9eeC6
         w4+liK4w/1xUB5aWA+S8Q2HKBqlmvSUMHBfAMMiFQIPtTNqkfpggN6XhdCLXqt2TZKUv
         +/DkLMPi1Hci8MxiSmICtyWbhdrd603Ezm2AMkGm+nrbzGdtCG8mmdR1eDF7DpEoKgvK
         /+eDzI3SHPypf5qvFm1BkmIuzgXl0mH0ERqjw77MFIU6VGNWYjGgsbnSRYYxt66LD+0+
         almZ9mH38mAy4k1EZneJuE7gjW7Sibau1E7+/y3GoEdje3B82jJK2s4/gU2+ulZh0n7O
         TpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023514; x=1786628314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMkBzLdP9OyMfsmAjdRRIfPjOi/S3wZ2VstuxfJXLpk=;
        b=WDeFrLUzSsIAE9tdDy+LkoJqwYdyPoyNKqgQBnrhIuWc5IUD3xjv1uBJ0RItXfmSwK
         w4RL9BtvhH0Nv0m3t8vbUTpoXvdoQnOBrgKSGGJE0sCijEZjiBRPNAJDzEhzq/7mlQQF
         9FpQiyVMdVKno+tCWTmzqSWDnkJ+p3GGwcxVt9e6asPSSYoj70bQWghHsedhJa22YatR
         I1WXDOMCYEf6I1fvsaXAcV0JFQz1KSxuLa1X6lzzo/xlQoNi8KChVE7zQP3Uff58dfQB
         O0xuoWx6Yksg8aCCz9RM/X+RwD78Swv7G7WBktUI+ixjvRywDeOXCm3lH1Iu7X8hpLA8
         p39g==
X-Forwarded-Encrypted: i=1; AHgh+Rri9tBRzWB2ZL2/Z9sZSYCDiKhH8nI2B4kmyinHhespUkQk4pyhu/i9H0Q6RLCJQASu8Q2llpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eKkyqT9LRSVBfZK7yBHr/Zbf16hDrB8rIhkWb1d7FGdsG9Cl
	cp6jSkYstEUo9461qEtgeO8s9R6I+63BdcRq5bkH1yRbOAPyCjrWfN8QBP6Fxja8CgbVnS0NLDO
	mRk7mrXt2dQLqBcnQwwg/2j/MuB7JJvvAajMS
X-Gm-Gg: AR+sD103rOgodSvWC5pqJIzWhzf8aIn6BqTOFkWB1UT7vLYySECl3Xkte28o2+FkJ1P
	2/ipxxGNIU/6hLJjGXr12RN+k79LbvPy33iIWFMHECzb9jz4MbTOVtM0jXHaFt02X3CVlY+OS4M
	S81cxDIUJRFTLutBwdHvs09b0saxhOOzAp/+XUGLbJ17DqqspvCv/l7ry+6zm4jRVHIB1REz8sA
	xIJzoh4to7oPCDJPOMpNsqW1kvio4qedB9447dwoh/cGxMffZdtgxM/WsJhtED4iK/1yec6PMKH
	76wSHIA++XlWXtNq1LinIR5RtJXcKlbFF+QuaSg0+13W
X-Received: by 2002:a17:902:ea09:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2d0ca75d2a2mr179131175ad.13.1786023514258; Thu, 06 Aug 2026
 06:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804201919.1148015-1-priv.luk@gmail.com> <20260806132630.GC51943@horms.kernel.org>
In-Reply-To: <20260806132630.GC51943@horms.kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Patron?= <priv.luk@gmail.com>
Date: Thu, 6 Aug 2026 15:38:22 +0200
X-Gm-Features: AUfX_myw4BIaz218nEF8B4Sdyd9jW1zCIlY8OcpZMDJzRslIWnD7PkKnRfm20MM
Message-ID: <CAJmEJMzzuY=hJxo-0yPSfnOymcdd=O9zxmOxdeO_hCB3sbSrLA@mail.gmail.com>
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
To: Simon Horman <horms@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

After merging v6.6.142 into a downstream AOSP device, it's stuck on
boot animation and following log spam can be observed in dmesg:

E qrtr    : ctrl_cmd_new_lookup(): QRTR client node exceeds max lookup limi=
t!
E qrtr    : qrtr_ns_worker(): failed while handling packet from 1:16600

No idea why it needs more than 64 client lookups, but it appears to
work fine with 128 as it did when there were no limits.

Also, I don't really have a good way to investigate what it needs all
these lookups for as most of the userspace is closed source. Perhaps
someone working at Qualcomm could have some ideas.

On Thu, Aug 6, 2026 at 3:26=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Aug 04, 2026 at 10:18:30PM +0200, =C5=81ukasz Patron wrote:
> > Current limit of 64 is not enough for Sony Xperia 10 VII (SM6475).
> >
> > Fixes: 5640227d9a21 ("net: qrtr: ns: Limit the maximum number of lookup=
s")
> > Signed-off-by: =C5=81ukasz Patron <priv.luk@gmail.com>
>
> Hi =C5=81ukasz,
>
> I think that this needs some more explanation.
>
> E.g.:
> Why is it insufficient on the cited device?
> What is the user experience with the current and new limits?
> Why is this considered a bug rather than enabling a device that
> didn't work before?
>
> --
> pw-bot: changes-requested
