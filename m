Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326052D8DD0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760141; cv=pass; b=H5wzLyhmR8sXS+Kzz45ShCWt+MM6SHYHJYeI+Z4Nrp6MFyo65pv7c9as6JtxAEz0nhkrVyEQ0F0o5dgiKdRxN1+5p7O9agocIHlyJ+YWe/PQTUgM/bfk7VqWQ3x+PMTNoIEkrTHs1gkkcim56l/v+QjSW4ug2Y+POab9OrcDNYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760141; c=relaxed/simple;
	bh=HzvNuidgeL3juabceaGKuJfW0x/vamvj7Q7WND4DCxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXvL4QgSEjCnWNySUVxkl6LKN5A8HLsMofWhUC3ezWPpsvjt03q9DR9YUB52qv/bclR2Df9TVFoTNrYSw8EefYEpN0uzwLVlEOM3+UL49ZySK47IqgyA5Kny0E5kyDYs/TQ0dSdve5ytxa58rLMbdf+vjFeJXeH7J0SkX+wgGoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvmof/NP; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvmof/NP"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso1535577e87.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789760138; cv=none;
        d=google.com; s=arc-20260327;
        b=pXKpxt+mCC3isUpxvJL5CwNta9YUFVlAXOxZ3FY/pzkatbbbLeuyW0Z3x5OLV08P6m
         0MfzWY3PIfsQVTi/5cJ28lisoXGJXhNn9Ii5MrS8nB2RnSbnXHUSEaoJbFmKAONKIhbz
         8nkgjJxveI8aYHkEGfiLM9yc8V4ddhp4lLkUA67feuKLDgN33kI3xZq4g+sBOjTNfzZV
         I7T69NvnyVuqklaaLMk8qNERjfZbSmqsoYsIsyoAIS8eKCZL9/tCjaOW3Bum0ETNuejQ
         sMAckcctaUhB7zEhgJ3BnZA9EEnmkLYpXXxL1O/Y2GiSZYWL/cSdP0QVb4H95/D+XXVo
         WqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2nxFd75vNkOQ0e5yGedl+RZU+0EEEGzGt/S9Rcg/pPc=;
        fh=RdxLWFkNX9urMN/OM6QDowq8MFQPfmZRQaJZX9URpks=;
        b=D6JUOW4kCJRwdeHs6k1XOatMOzGOTR15/Akjj+DyNa3JxHTYtRyrQnyNi7Uwr4kcR5
         HK6iv/TywLCqrcumiZKSXeZyO3tBNJkjSzC8uBQJBWFdzI6PLfxVPJENl2EfGYNvzMP1
         SCUy5Y/dmQlaZggvrPh5f5jUHiVdRMyMAGOd2uqX+4cRi3OX4sPtRc70gjKzBL9Vy9fQ
         55ZLKaaqybkxose0ywQbqo4LkPkTydGE4Psi3O/KQKvNuIR+rtXe7Ccu2g5747Mabwka
         M8d39Ce6HywKp+12uF6xy++OllNsKbpAOfQnXFI1iBePvtEHeKRp3a4fC+NwpWaI5pz3
         pFGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789760138; x=1790364938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2nxFd75vNkOQ0e5yGedl+RZU+0EEEGzGt/S9Rcg/pPc=;
        b=Tvmof/NPM7ege0mtijP7zeeP8y6IVGoFRHpLtot42xLIcVn2xDEpBAqVRO6dT1MT2k
         ae2hEJWJb+Msg4YVLLRLNFb/nf7FOKyHXjccuqppLJz26RWmTebRTYiYYeskssHRQ74x
         XePvq+owocNPOX738LUVlSg7a/hBUWZ7kMnvAMOdLDsSYJpWSWTuCdzTzUK4MxihvrKg
         yMBeLwRKQGcHr/JFqluvGwKw7s8Ep1DZMRu8SC3oi4W5H8aokf8kNQHd/8LhcWa7ZXzD
         s5USyYBxF4pnV72GukZUeHGNTyXUcO+HCvfszYqFzghIXFa5YQGrrm6BuVVNY4TKV/vl
         IEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789760138; x=1790364938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nxFd75vNkOQ0e5yGedl+RZU+0EEEGzGt/S9Rcg/pPc=;
        b=C7RvU8CnzRdo1uGiWJiMggNMae9PuGnzBkeqdf3upIEVzz3tUsSyn17Y/E0buadEFW
         wDtfvTae+8x6t7iTeCuZmEqI88oHTthCm6bWsOSK7y5ocAia8XEXZ3AKdQ65Gwk9mUHd
         faL5vsUMYbVpp9Um3+gb0fwfK0XKksMPDn8ld5ySQIg+J6Gwjdx+2Abr+U2ivA+BcknN
         AFfTtFwtrJSY9cIDDPLI4d5InKLHtSdr/HTR9lpHQuTu4jQFYVahwP/kTt44FsjLRU1R
         iw4Wpy9UQsbzuuIiSW2qP0va4fpb6wDbIQQEdBfwqaebMSoyLsUDteH7YDrPl7sNuAIv
         NGOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXFbd8gpLzuCAyp0s5b+B/dJI780WaAd6ujTOQ1jtA2XfLWAn5jZdcCDiNt4gjPsG5f0mJeH4=@vger.kernel.org
X-Gm-Message-State: AFuF++k1YHTjDZ9r4TY8qSKN8PzhPgzFACYThMVhLhQlJURnhql/Zu8r
	g6y5RWFrgr+VyVGtPaoF2zwlgmjXJ+4/e6l+tdgQtASivKudtF0OPZxyEPrricagjPCk++b1/JI
	bg5TV/vRiq4Oe9Ea9y71s5fv0VYBOIFw=
X-Gm-Gg: AYBFou3PYljXiGYUJJeWjhFL9fhiJl/SOqE/wXQbQ/uxs6L0PBgJZjvJLdV6PSkSCkW
	/OU5oOYsJKJ+dEtAkrK22llaTc5LxcIjrw71Why/neXaAtTYSqRmWTYYTpop6In7EHICtd2txZk
	m4XaaMmsCrYHL3NSo0eymX9F4U51O5uJuPYcvaW3cc9TChq2ZlYj9/ZZ13Hbsiz8gVBgirBksNk
	HuEGQ96xGHxRXebA69n+JExNg41SoEe+yjgePKwGpINouDAXMILqzn+StzXKkWUfbdj3hOO7bsI
	RLSpb0uno472cpe0h3oNRxUb1nxs1Pz2q+vH4GUCMToTg8fwtNzQvzwt3Uz3aGyIjVURLcj9yaR
	Z5X7m6X0dkFvhn9OlHbPb3Lx/xy26/O1xMPr6gDMvFjKSbQ0=
X-Received: by 2002:a05:6512:a344:b0:5b8:c21e:28e8 with SMTP id
 2adb3069b0e04-5b8c21e2a24mr835758e87.19.1789760137898; Fri, 18 Sep 2026
 12:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-fix-macsec-net-v1-1-c82aa58ae741@gmail.com>
 <178951752525.22033.8547704610100726932@kernel.org> <20260917180909.566fb795@kernel.org>
In-Reply-To: <20260917180909.566fb795@kernel.org>
From: Haseeb Malik <haseebulhaq55@gmail.com>
Date: Fri, 18 Sep 2026 15:35:26 -0400
X-Gm-Features: AcwNN1WpSFcsIQWeLcBWVspSvI8wcqej2JfgX23uUmxVKrtS9ZZ_74s9WB4btHQ
Message-ID: <CAB4N2KPz-ARRDUdkos_S64Cyvm5cBfq-5NxP5wwL835wf+tO-Q@mail.gmail.com>
Subject: Re: [PATCH net] macsec: initialize SecY before registering the netdevice
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, sd@queasysnail.net, andrew+netdev@lunn.ch, 
	horms@kernel.org, hangbin.liu@linux.dev, felix.walter@cloudandheat.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed in v2 by moving MAC address inheritance and SCI initialization
before register_netdevice():

https://lore.kernel.org/netdev/20260918-fix-macsec-net-v2-1-784203ec4836@gm=
ail.com/

Thanks,
Haseeb


On Thu, Sep 17, 2026 at 9:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Sep 2026 00:12:05 +0000 netdev-bot+sashiko@kernel.org wrote:
> > - [Medium] Incomplete fix: the registration-time RTM_NEWLINK notificati=
on
> >   that this patch makes succeed now carries a bogus IFLA_MACSEC_SCI =3D=
 0.
>
> Looks legit
