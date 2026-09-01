Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180A3A6EF1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267089; cv=pass; b=t9gESR/4otyGAcXlwt/NCJMAWGZbVmifxmf4NW/IL5fQ/U6USdDycKJlTQRQys75PJP7HrndBbWodw31t1lGnyqIfiZWyXjk16S4he6eKHUbLG9qxjakBW7ixFYZjP1V3EFtSTYe22UKN4U7GhKwQSPkksgJNispIm0HQ8u2e3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267089; c=relaxed/simple;
	bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGanGBZWHhC31HAN2kJlSyi1zDneqPo5Rk+ZZfrhcm0zGsgsa0qjlAyJWg6+8cjr3WojAHB8S+fdQgQrGbpT+/7VbESkg5tzbRBV6uLfifnsUIs32J8y2AXZD90YxUIVpCVT3WsLr1yjaWRUWiiw7DHg5QZIrT/qZ/vbP2Vn1rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqvevHhR; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqvevHhR"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe41618110so808387a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267087; cv=none;
        d=google.com; s=arc-20260327;
        b=IdchRUjaiFvjPCbpLaqYyVDazuwU902kSH1UOrAASUjA1OwwV2weq7ATwaokXCKC0M
         G3D/cTIYoHDJJR75eSaMenEbn+u26SUn0+jNv9XF/ahuW2O48rNoWIj06Q8zYfGDT8sX
         cr3BHPMjWjVUzQ4V1CJeSjEiB9ShkYqDl45D5QZFE3zKWL3RUUM9x/xCYfuHgUYIQUNC
         mcwF7K687k+oLnDx9M63VU+p03/fu0Y3W0w5Xu0LJ6E4GMaoAOACzUGGOv4LR0sTJnAq
         FYIArdKf+97CVi2AIneI+HUsqZPy2p1okb2UvkGJnpIFrNsRvQI/BZON6WDoJEoLFInv
         XLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        fh=sW3gn7jHI7Hk6jbBWBRjqLH17mMI/nX36A7inUVq5o0=;
        b=ZZwqvWfImDQ8E+RV2x/cY76nhjERl8P8UeQUSD2dlAHpiUGKLYZH0dvMlSboLw88wf
         1yYOCWHwJ/eJwCplQUwtjkuX3GX02Psdkn6ZOkYtHpIWGHUvoWMp4pUUGBZRQ/boV3sL
         8vGB359O74hgjW/KXbSG4WSBDDohhIVVkFuKVSr2FmPT/GgGqeb0N+q++ZPlm1yzrQYi
         j3PBdpu4AWH1M6R8gllicI2c42GKJyhTCsFwl4Ynf5Q/eq6aqA3kqKO6UruSu1f8hOze
         vKSsrnnC/mmo0nquw941Bxy38WP8JYCM1EKYKTPPY/j/PCuvTF0xmfPU43LskaCJq0rS
         ukkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267087; x=1788871887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        b=ZqvevHhRPih9Z/ZZWEWxEtQfTSSZ7lqDEGJuyOktUWysYTJ8cOpKRtCD95Zjjz00qf
         qrqPHyl/GJinRA0ldpjnQByQLC2ijRNclc5kBV9jtHiuy+WmWZchYHq1cySBjfOgM8PF
         dRh5viOXmf8PfX7KSCPHXkXbzyIYMc72m8JCoYV2jRJ7mqO6q+QlWul0m/cL6CfFGuFF
         2ipWJV6GnuWfMNtw9Ed9RGadsnhqDytJmAuNzVb/4hACi1mvnL1tKXt3VB4nPRmBylFy
         LBtvUGox4vq2UctToFVhbGjDtfnxFBWE+vinWOQhA2qSW2YJaNIMd/jI5Ch0qU8JGKqB
         cKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267087; x=1788871887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        b=EOrbuFqo+nfV+YzPyF+JnegGA7xe3GPrk+52HCsfyS/UkJQ5tOIA9O1xrVf9ITdhXK
         fWkWwSfvsYwsZK3UaJ4bnQOy+S7IkATPtt4Cv5eVbXNWN5GXWhz7JOpYIse1ko2WRPkQ
         Vc4arToCY3612gXHjw0eyf2baf0xe/s7dKZXW+0BaYd2o9mP8XDrNXbG0T/BIT0hoLIQ
         rdKOPmtVrSyAASFY1n4o30VXkzQTepj1U5FZBsFzzNvxLTrSdhzQRtc3rFlrEW93siGR
         YHRo7ZsQ/3USzcZTQv6BctSHWbzdaMuVDVOZwJeWMj0vXo6T2cuyH2BVnbYI3sI9zKQq
         eb2g==
X-Forwarded-Encrypted: i=1; AKwUvBxBWf7gIs/scm8ygsCtsyUvspBtUgC8tqUTIQVsg1xc7j1NsWpWNrhdxdFILkES9AlLLcRBh14=@vger.kernel.org
X-Gm-Message-State: AFuF++lGp30US+FcakG15u8YJtnQtAbrazRmprV7K/e14DQ/SCoZlkCJ
	2t8z6eOWUUacZP/0UiRkqbUuhhOaOUwuuwIF+zSxeKIksxVRoxTM9j779pJmD0t2umBTrrSCZio
	0DD7cKsgnSfF59jKJGCy8l1dkVu2TQXI=
X-Gm-Gg: AYBFou34mhgdMOGDg9QXpfqyIVQ1g39HP6xXdn543uVgmrkgCNSoo36vTBmOZ+WsHH+
	wWKULKBuRTK6J7Miy1DZ4AG2ibcwow3AdPefu/PDGR2NoDrLsV5EPbXjymMOgnf0hVIhgcCdehf
	yx6qOEX7/o5wCTCXVVMV6X7RubZAhXsNNxgkhN+ifWuqKe7itl+VAAVmORNqSKvdBaotVr2WJMQ
	9gOxhqiUT5w0Dk3fDauakLOQSkfLBsP0/lNXygXNVclut2NVo0P6WKP5/pB/iafv2FZgREovB+j
	LvF2Dh1zOP9IEV7keKtd5nVRgvrTPTAjjr5mf177uIWX7G5tnrBBMh0a4/swEr9uhSvuNqVfxdE
	9QwzAqGn7nLT+Y7vHeCst/WmlyjLbbgHOaYAQUiqmLjRzp0EAEyoP2jEzD1Oi
X-Received: by 2002:a17:90b:17c3:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-398bada8463mr19308227a91.6.1788267087455; Tue, 01 Sep 2026
 05:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net> <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
In-Reply-To: <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:51:12 +0200
X-Gm-Features: AcwNN1Wezo3mACTAKMu_Q5y0Y2CqgBBUBpNqp2vbnQUgiNLHKhzdgS-L_bRKqgw
Message-ID: <CANiq72mXDgdFXy6w1qy=fewJwrjV6ognGrTgNkn_O6zVpzbgYw@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Chunfeng Song <springbreeze@stu.pku.edu.cn>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com, kuba@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, hkallweit1@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Probably a FAQ, but what is the policy about toolchain versions for
> stable kernels?

As far as I understand it, we are supposed to avoid changes unless
they are truly needed.

So there can be exceptions, but I doubt we can easily change a minimum
version without breaking a lot of users (e.g. distributions or users
using those distributions that have a particular version provided).

But Cc'ing stable just in case.

Cheers,
Miguel
