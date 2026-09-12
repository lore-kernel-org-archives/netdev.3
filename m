Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD333939A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176845; cv=pass; b=fIhrfUiTLFwr7by9EuJCJW490e8Gx4U6/N5l5ubD06kfswihtijsqy2yH2/GsvW7lxunVBhYZlo++lec2n9Gjxfk1uRVt+2+zIgP8X1lxXm8gqH0i6alW1BTmnNqsklGhbrToBANrQwMWcv+CwfjfutyIqrr+KRvl3/wJiVC+b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176845; c=relaxed/simple;
	bh=IGOSxZy52FtrcK0G/EPYqVmio1WKO2seotaY7iqwZao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw71N+CM7ouTrKMR4LWWtGnsI6JyZz/NOwsZ42Ohp6a1kgxQSlgQVCUhaQbdw2C5G4dGW9VxPgwQeUewPfj5yyEJRbMsKHCAn/1tg61o+xoPN2iCJ+YPgJ2OjmH9MZUmYX1I94GhsbMJMmJV44CrhmdhHhH5xTI/6kY+5h1+Ii0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHYyMx9Y; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHYyMx9Y"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso1277961fa.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789176842; cv=none;
        d=google.com; s=arc-20260327;
        b=QMr3FoeKo/VMY4yIuI7kfdc1U++VBSm7IW6VZqFl+UwzlTLyWhj244tQjCLNBN3xbS
         93KrRrvAGwKo9GpyNvxt26PrseNk101VS2+bEquyktBneBmOMa6HJ4xND9P7my8wue/r
         XM+1Y/2XxRPUE84VWQw1A5k8n/wYjSfRJlUqKn6+vnUe8ycgvc96fVl1dnyku1VR7PnZ
         yhZtR1ByTa+w9txUVwU4k+E8ad6ZC/AujtXfO+XEqgA04cRDfj/mmgZG2EBk56JrCq2a
         HctxczV/Mm1TgmXk/9bMIV3ZaNgeo+CTuHGm+BIV1ZXTsbk1K7YTGy/QUgsWqYhtVZ6j
         m9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HoTJlBemOW4I0RfwGhPeZYrkBgu1h2TKr9000ZstYMI=;
        fh=bH71WZ+rG7Nvx+lGT8Bx3OHZGfOjhK5sy8Hwy4u5Zgs=;
        b=P1XOk4MnYl04ipGjK4LpxpAgIxTouUmj4c/7LZrsuouZqw1Km851C0PoeKeIrFDfX5
         AUs4QhVr8ZqcZxBYqoLoQ8QI4LNbVrfqW/Z5o5jUV6UhDzLUArvZgDa2Z6hyiWOzMvUv
         M34b7vYFJdWNmPxvpb/AlDnpU985mzIT7SuawqhI9fPIWHrEJcwpdBpm7BxOS1xu347b
         b/B6mtpAdZhm6tcqLqlHc++VFU2dRtnPfuz4jS63CkW0oqImidnUpW7L51tBETKIN6DB
         aaPMywXXO6mEDlC3pf+BPzpHSd77/6YkkLcV8FpWrsV2/PFKOR5eT9+XXpfANnaRUeUA
         N0gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176842; x=1789781642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HoTJlBemOW4I0RfwGhPeZYrkBgu1h2TKr9000ZstYMI=;
        b=aHYyMx9Y7dTKBSp0hmBT5xBOGgyJF01I2r0YQ8K/fpKy2eI/AD96POYpnrOtr76OKu
         3orGvxbkFnlGJYmqs8h4OBInlh0mMbGotUh69pEQ1b/S69hq4qxUJInVCvNqhLGp6Lg3
         KuK9rQ8UXIq7StA4bjQ+yAUp4DvQYbmIcGBnIrl27q3DZI6TT4geN7IITOSZm5bd01eT
         ksALSO8LLMyXiu+wNSjp6kqgmH6JRA1kCvht5rcgaq30zh7RSY7rZOlSw5/nOHj6DeU+
         29k2Mw65/rVbLV+emEQpfBgMctSBXCBMfRnDFjZSbSVBax8hSi0XTlJiKwfsuNHEYLl4
         S6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176842; x=1789781642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoTJlBemOW4I0RfwGhPeZYrkBgu1h2TKr9000ZstYMI=;
        b=IBrCphx06dwZEGjIGfITHfLZcO4nZVOVoPm/cgQy3XToBHnQlrwDYOPl8DnnVW+pRc
         iPz9xCUvF/BN+yQVEFaK8Hsc2kg+4cWA4/iq5GCfmrl17LanFcnW9v4xu1OdA3CtWAg5
         42U5TpwIKVK5CLFtOMG91/s1DGPkaxcq9WHnATyCoOJpYJGrza3ca1oD+bgTRNtXfbS+
         SS/iFOQfn2WOFZH8+CtmkZzAzI2uPUq6sbfJi/97pFYxgvQKCmjE1AfCRvzUUmHNW+Mr
         jvO/umiv2NuCqDCX7wd5GJk5tMKobY7CRB/s2RfWtTAic6hKFoEyxQnlvERZsJkDPzIr
         8z2g==
X-Forwarded-Encrypted: i=1; AKwUvBwDQJfW+7J6rSLvAVEXAinI2i7xsOQ+1iTjR7m6fcjViV1H4ROViTTjzDS9sYeNnb9WNUEYlU4=@vger.kernel.org
X-Gm-Message-State: AFuF++nlIugYVwaUo4Zr8D+pVWc6JNc/Rk0Nv0bOLsWi218O4VMmBGiX
	mZ/hIOf6OGbrHJTp0mpIwT/IVr9JyCRoSDOTReVuQWBdierU7wTqI54/tL8Z4gSl9gj339TyOGX
	nq32OUcBd7AhSsXJuMIJ8h1aPR766ghGCjD+xa4w=
X-Gm-Gg: AYBFou09daRC2Xdp35hQMCpDS+QQDpo8Px7jM1jOkaSkApI1JV5D2VgAU1PkO18goi2
	ZL1R0JZwjGzy4B1NekwsVoDGQ6amJAwWL2TY7bOgpEPecuNOuX863/lwpmzGw8aTxfnbNQhBbga
	USbzh+NS3jGNO5cKvA33YLUUDCit1+6tWJTYWTa04MJbKjANLrLHAX+NgYxFjCBUBoN7Ci/BhnU
	Xd9h2rdX3JHrIX09N3nmITF8oKHP0GVdzbs6IF/olU3SSwxE19oKXm/krBpTI4fTEI4DWgRlZnQ
	Gp/qu8vq/CR6WAVxJwQphMXOaVyszNPD5+hrCOw4JQoUfAPPsYGcxmiXUsbaqESs7XxPk7JRw3y
	KDmWL+NpDQy6RFhi1oTz3ss9+9o+XOGFqLKfwJKeq+emU
X-Received: by 2002:a2e:b8c8:0:b0:3a3:749e:319b with SMTP id
 38308e7fff4ca-3a5b37efbc5mr1133491fa.15.1789176841298; Fri, 11 Sep 2026
 18:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911105103.7771-1-sigefriedhyy@gmail.com> <20260911085056.10dbc3e0@kernel.org>
In-Reply-To: <20260911085056.10dbc3e0@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 12 Sep 2026 10:33:49 +0900
X-Gm-Features: AcwNN1Xwmy2KElPk9P2Qv9ivD-eVQUT7KVSPXOdAv2xLdRuqCz4GQnL9yyMnlGw
Message-ID: <CA+7S2vLOR7aRY42-4j1v7C27pPSaUt3h00FjrGKVOUC_2oVFTw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] rtnetlink: dump link-layer multicast addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 11 Sep 2026 19:50:59 +0900 Yuyang Huang wrote:
> > Subject: [PATCH net-next v4 0/4] rtnetlink: dump link-layer multicast a=
ddresses
>
> The new test seems to be failing:
>
> # 0.14 [+0.05] # Check| At /srv/vmksft/testing/wt-1/tools/testing/selftes=
ts/net/./rtnetlink.py, line 171, in dump_mcaddr_l2_check:
> # 0.15 [+0.01] # Check|     ksft_eq({(addr['ifa-index'], addr['target-net=
nsid'])
> # 0.15 [+0.00] # Check failed {(9, 5), (8, 5), (11, 5)} !=3D {(11, 5)} ta=
rget-netnsid did not dump the peer netns
> # 0.17 [+0.01] not ok 3 rtnetlink.dump_mcaddr_l2_check
>
> Please wait a couple of days with the repost.

It looks like the test is flaky, I think I got a fix working locally,
will wait a couple of days and then repost again.
