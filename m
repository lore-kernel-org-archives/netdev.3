Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9E36F8EF
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243129; cv=pass; b=KwPWZ9J872PsJc5add27idIT/Maf50SaD6wYCprsVkzt5tEM7enpWrhiHTccck3Tu0R0hCd7PoxAUIiDLrP9uReYa2dQVQj6/wg4isFYo/Vr3IvLpU3CT0htCfTiu2q5QtuAyOPcPNj05R+krwiu9+TIReRnEda39ZinTk/73bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243129; c=relaxed/simple;
	bh=EXyAdUgd493fYEt4VxMSQra2pPI2+KTA7xbnNXMBIEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5SaqqjnY6L6sB5ibyr9T9AFj8AfXeLMKLS4eQDBx71emHA3lVUDzIVfLUPhHs8+HbpaPJrjNMgCJpjcGA0ObLFZy5BPplfrEyJO0SxwIwl87Lt9pzPALNb9r+TcurlIrgf5RDeUCLWIHXq7wA936Abn+HDtYvapwOt/8CG5jwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHjZFydJ; arc=pass smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHjZFydJ"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-66077e90382so238479d50.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782243128; cv=none;
        d=google.com; s=arc-20240605;
        b=kfs87O792ox0L9/q91f8FQIvUsmj4YMS2wx7jzJl7PEAPzUrT523QiUaQYz5PclJHc
         +Eaw+BV8amRM2sWuhy5WHtziyIR+27wlSFPxXhyFpZllZ6ka3m3qIC6Co0X3uoX1i6dF
         9VBwJqJwoLd4opu95RvDYTArUV+av0lV6adi9Et3XRyPsZ+ftAzxinI3FrPqFuF0IsvE
         afvc1F0cPtG/GgCWFssorv3HHDMphYjlI2ybJGoGSRjOGdnmP0JTpIgyNb5jjfcf2lX1
         2zaNucRYRfEbogh6hg4XakMalNT5LGO0PihblD0RjtaoJ/yrQnePX49t8whIctTrxd+w
         d/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXyAdUgd493fYEt4VxMSQra2pPI2+KTA7xbnNXMBIEQ=;
        fh=CmvW526A0r4B7HVcIPsDa3hF0NKE0DEwvtcI1oN7yOo=;
        b=WjqRtE/VyyA75aNeehro/hxBwKGvVMat2QSHwaHEwfIW1aVOz4j8y9D8H8zbPKmdS2
         x2EsswoGAsiPGp5ZAgy29rSkCySwMGCmpPKMeLnBjp5wU3aljGcBF3wxiSoRuQ5rE6TS
         IAVDvmunWWCeOlvHgs9CqRPOm4O+70moGvwa7YWTRx6GJofmMQiF6Xx0s2qVCSYbqp0N
         L5N9Bre/lqMhk4Efkgj8rZayQJ+R8Nk3KyEjC52+e9Dv31XUSPnZ0wBHQqZDJ6n3lUO/
         Zp4DswFb1vffWMzjtLqXByp/yq89eDkT0fDeDsjkA0dl5wEJpoTEgFS05HXeZXhe0Oi/
         r4Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782243128; x=1782847928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXyAdUgd493fYEt4VxMSQra2pPI2+KTA7xbnNXMBIEQ=;
        b=oHjZFydJESJJXr0tvrwfVFFnJekRfzojYla2OHt+XULxac48B0zzBBgtKv9pFkaaxk
         NHbirOlA6NGAZ6LBXEH9jroU4AsFxWu7TZ9VfOAeyvAQPiXMdJ7Xh8/QnqIwZbSBC6DU
         1MJN4uze2V0nK66WuYLsoOEQGlRJS/3vq0DTm3yvhct5XdVK/EHFFBVKPanCrpVrcCj4
         c6HQ1j1XQzwuUeOaHG+QjEwjD1srVDAdWi49fqTsvai3zIJ4nGeQ/05DcyToNIEO87gJ
         /zym/VpqQRtSflAVEiQNRq6oKPZ5PnCKJEO4vMNOzOzyMu+s9o12uYbM90az723JaMqR
         w2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243128; x=1782847928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXyAdUgd493fYEt4VxMSQra2pPI2+KTA7xbnNXMBIEQ=;
        b=Nnu8sHNeUXid676m13CmYckZEySLjTWtUF3Y1WMStWIEN+6r/EMERZ6fJWVgb9Aur7
         7RCCt0GekaGJxsihPmOX8DC6fk8RBi2Fxk82CqmdJjN7U6f6SWLfov9GeNRveCMTKpTY
         CCokg0DMBFwW75rZEN9tD/rAzyzneBIY/dCU8VyZntwNmURqH22QIfmmJf8FLsAsp3ZV
         wWgMiXyqOw1MxhAlgU7rQntbXV8daMzd3A/mzmE69jnRaOYfBwnKM0LYrM7U/ZELF3MF
         d2k9iiWqas5VvmfEfiW+v8LFwYOKHj/WQpsPO4bO0EsAIoYr+tibyh2Z67eESBCvTvQc
         BpPg==
X-Forwarded-Encrypted: i=1; AHgh+RontYXtuRamRSr1vvxBIvBwyU5MKLGmeuW1m5hiSzXMUYI+k30mXt43jyzJQTSY+rvj/fWlLnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LNIIzNrnef6vSsmCbZvXXCw+a18sENf4/66+RBKsjfiS5dEx
	nEJvdKpCkD9LKfU/F4ca7sh92wA74VysDYSVbDXAvNJn7O66nyQzG+JpbA/QZt9a5CDDIs5MgQ/
	gfjkmWkx6YChw2umeAh6iKX5qa0+uS7I=
X-Gm-Gg: AfdE7cnZtL8RXgvrSU7TuvxX52ztAqGo9MZkGz73eY7iGvJUaD4L9IqMoid5JSvQ7fu
	TU620ha2K8dhbMsys9IJfgxPAW+t+67E9QFe4lsf4sBbQIaCpvPnWuYsJpMHELB5wBQbxWGpGss
	8z/T7uTBo1cXq3px1u7+e4ACKn5Crt50TJtjwcsBNebuEm9T8SHqE53EEvHSc28iBTaHExDw1Q0
	r/Hy7yL4EXMaDgkfvKrOn22IrSYSA3tlvI4/pU5P1VNMG1fwMHiYUNzE5Y1OmXvMarOw2+BU3G6
	U6AsiIYovBuanEHb2Bip4VA5JxavcVxhkl5PygRACyozyb+xgGgIRL87
X-Received: by 2002:a05:690e:bc5:b0:662:d8cc:6b2e with SMTP id
 956f58d0204a3-66312d6f14emr16234045d50.13.1782243127607; Tue, 23 Jun 2026
 12:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112133.752195-1-slatoncomputers@gmail.com>
In-Reply-To: <20260623112133.752195-1-slatoncomputers@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 23 Jun 2026 12:31:56 -0700
X-Gm-Features: AVVi8Cdh6m-d6oCCi2zMQ5MTTBk-BSVfDgrAZQdSmgmUOh4dg5UhtCaX2KmRvI4
Message-ID: <CADkSEUhkWRzW+-39JmkDSjUi8Qfwrr0qsVJFDxZhpNCBSenMyw@mail.gmail.com>
Subject: Re: s2io: driver still in use - please reconsider removal
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Michael,

On Tue, Jun 23, 2026 at 4:21=E2=80=AFAM Michael Pratte
<slatoncomputers@gmail.com> wrote:
> Commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
> driver") removed s2io in v7.0 as "highly unlikely to still be used."
> It is still in use here: an Exar Xframe-II (PCI 17d5:5832) in a
> Supermicro X5DA8.
>
> Bringing it up, I found that no TCP can be transmitted on these
> adapters since v4.2.
[...]
> Given it is evidently still in use, would
> you consider reverting the removal?

Given that the driver has not been working for almost 11 years and you
are seemingly the first person to notice, I would like to respectfully
disagree with this assertion.

Are you using the card for actual work, or are you just testing it out
of curiosity? What kernel version were you running before you upgraded
to a current kernel?

Ethan
