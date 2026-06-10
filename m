Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53893346B4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061023; cv=pass; b=T57vMNp/Sh/3n22r54sX6ARkadA1hGuped2o14vrOPcUoZssjfV+GsZrzGJ7AXpfyJDIwErwikHQucT5ve+05OJqfTr1P8HrA1yfMBDDhe3pJjFS3P0l8qSTS1WOc8h0pRunl4fiF+r3FWEhY30y4soDaK3aIEZ1dpCnD8mp1u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061023; c=relaxed/simple;
	bh=EKPnmXGBjDma1T5FRzXRZUBcKhNeQ5P9T9gFuZsrRHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j67eRYZWJ/EnhUsXfab5+gRZjxsxQmbbFzQ0VcbS4kOPpHIffuI5dOE0YQTx9NFA1oPkI4k9j3oruL/QbCzQTPuAYx5m3A/QVBeGlCOuw9byqrsf2vQC9ZK4QqqQ67TaPjLxoUG250jRScOn7BZtfa5dCARoGGYo3yDx0EnxYBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKnuLn+B; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKnuLn+B"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177ad0cc67so50235191cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 20:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781061021; cv=none;
        d=google.com; s=arc-20240605;
        b=dQNKZb8aAB2BGRQoiKYS5FWhUFlXZXZ/ooQU/+dIuRIU+2Av6Sipwl34z17/rRdpmA
         n1i9sEhjbCf9+xAw1evdiS79EEz3AaC/6UD4mjHJCYN7nNu+GndCkvCM/kRYh+vjZrFH
         T7SFfasr/NA6Ov/jqkCU13N/jcdaxBz1EWJ4lzEBtFkJSGuLj+30IJ1Mv/BbNhu436EH
         PkjhGhaSZ6qwz0vS2wTvNvIkUyAmpL0Se+CVstdkXiSACSJnaY2ZNZWdQsnapZHgRBFz
         N6M635Ef/ymFWkErs75wJOB+7+2SEvdwX75ubYMm4WsPgtfwn5MUwND6xy4Myp44wX+0
         kdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        fh=Qe/zkZxTaYGaurv9ek2V1RR73phTqpRGKcg5gvHllU8=;
        b=gCNSNgb5nWI5DxNWRstbHIkp7S8+hLu5ZTeph4+ji5jIpSZgW1NtivDmBDt9bsJaJv
         W7YSegZ9DpPlmrij/xvDBiZGeaWoRMKpl/xuHn4JQLsNl4BRoHEHXSs8YzhxvbZ+I4FQ
         jpI9YrJ6kdwzDk/y0J4VT6XncTWEm+fVALLtluoTb9ozmxMIKCpLZjfv1qzv/pTsxSoN
         r+e4u3OacEvbnGKuNIUfBZiJMM28CBlVO5NuCsKNE1EgtszQz/pOJHl2u5a4IyLKZGEG
         AZtEmZiz/6L59eMlgC+Z/moXxcWe/nA4PntuIM8albDR3UZ1M0DrIWAgOv2T0I9nu+ao
         MKiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781061021; x=1781665821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        b=AKnuLn+ByL/iT56f4JalotUqZ7spT5IU/hEBo0VkDpXL7Ts+lic7YMwh+qs+0+ChVJ
         a4DeLubHUtN5H/fq0WZZ0DPJBefoUDe05Wjr7j52jjbJfJKcQ+IoN7FvEUxK6IqTYfCN
         z7xSgHKX61lEmXO0QKpVjcpUrAdhCtKlhWSVwXslf0NHchPzaxU9kICpWjI/maZe0ZkZ
         910i/e1VhgvWURgUbhFKyFyn9GlaURxTGi04xveu27EFs7vrddIz6F/7ksnANc+/jrn8
         Uk8MN8UAggQ4MqiF23YnZ5UQ4d0c6/39+98TxOUtIca8bXRaBQn4rAmDTiEhA6m2TasW
         detw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061021; x=1781665821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        b=nu52og0AGkWOa3Ib76FvXQtpYOA/XbBdvcKNI4GrCRu85w5qWWNHEiwqwuC2QsVDoJ
         tzOtDug3nEgTs5XDBF5q5n2GhfTTO0ZwhXMYNFVi/sKQl7zhYwDwvyqED4htSrocKv7l
         3p5ASVFltUBcWTvjTDrwFM61EZtc6EqxqlBcB3iGxSm7yN/64/HgR8gFxKHPY76ffjgu
         f0ZntUFBaP41QS1DjU0MqudXdB5sGwlNXpVirkpMyNqs5+/PfYzZL9CUKLQxBMYvrFh3
         Rv8XF/VUeQ9lsJzbx0Znw6Xc6brrqgvUxwh/h3940VUVhw3S3sB0vOnNmsHHYbzFN/Xu
         FIgA==
X-Forwarded-Encrypted: i=1; AFNElJ9LAMy8Aq1Rk2oLHmLlNgFz1Aafjsmc7U0EJkScDm20FtVDx037e7WcNJDZ6IxKdQAmxScbyYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QbK0WFDBdTjtvN0cBVDKtRgNuNDdeiscgqK0P6ggxQaMPADW
	UV2BWv8WPhsAVSzhRofXxveHw2ihtQ/AZrFAaVn3NPrqwJVGrMrMH37Wo3mnaRo8r3OVBEHoUJ7
	H8RcaaECN31b3yfuHV9w0PdS2uUeKgfB9YHS71kiV
X-Gm-Gg: Acq92OF4U6Wez3ObFgEqJ3BT/YuvwAHr8huW47YHVo6OxZJc8nRgG2BVG4FVxUe9kTr
	UqiIHkq2en3ALkMB7ZbjH4+S6AfNicM97LYWnsy+qxsWUCOzp+NBIlOGK3RwVtRfem/CtUpK3Ry
	scSh2lIqeNNn49cpmDBKovoSh+xe4Hf7s8yy2ZsbqB2Pkqv2v4whuluc1Gdjm7hiPR8t41u0uOd
	5z2ztrxMmfGna6ftZ+ktEiObi6upEGy+ceR7n2MkGWaYG5hzJcRJwTUH4KGpjB+F4UQSE4OeGJa
	nyH3k2nye2excXVTpN4oWgdOLjMuXxLQ5OeVTepvDwMTc4bR50e6WSFEOsaJA/x1/HP7Y5fzcFS
	bxa+kWbQIpprXQENd1a0lo387TedblA==
X-Received: by 2002:a05:622a:98e:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-51795a090a8mr323096991cf.5.1781061020340; Tue, 09 Jun 2026
 20:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608135051.637439-1-edumazet@google.com> <20260609185723.6c5352ac@kernel.org>
In-Reply-To: <20260609185723.6c5352ac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 20:10:08 -0700
X-Gm-Features: AVVi8Cd1Cj4whMx6ePDcZ1OWZKeR1VaIrEqEOXs3ozMkTky_Z0CqVlEG2uYNf4w
Message-ID: <CANn89i+82c7MPykFB9W4Ef=gwPQszE3JofGRvx_N1bmzW5-CTA@mail.gmail.com>
Subject: Re: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_info()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  8 Jun 2026 13:50:51 +0000 Eric Dumazet wrote:
> > Subject: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_in=
fo()
>
> This one does not apply
> --
> pw-bot: cr

Wrong prefix, this should have been net-next., sorry for the confusion.

V3 is coming,
