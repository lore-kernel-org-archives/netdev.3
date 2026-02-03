Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7B163
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158555; cv=none; b=rwFKl8plE28gwA0Z1uX92wm5vo99OUdY0bpKwHaqamIc/he/HG8zWqAhRN8UxSQKTMDVAW1xJ+oOMfOReyCqMpycneN8ZFqG1oxFP6xYlTMgbGOmpcJeC8FMNDXJ0Tpfo4Xwo6bv9PFUikE8huCc3SkW78NzYHMQiIVYOx0Qpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158555; c=relaxed/simple;
	bh=wqlUnDGUA74SSmVYWHzL/Uebmeo2LqJW6biZSp7JqD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJESB1prxeZ1j+T0p0Indae6kGUwRoxMJsl/Gqw6jeBK+gOM5oxdm24BS4rS7wUUkf+ljDel4s4gOxZcVCI5zFmYPrj9oStiV55FCIBTcd/0U/T1idzfjsIONsOhbjJDc+mqhBlXqDu7EozRYfRW6/Psg2qFBDeuz39fY7OEGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNpv6cIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNpv6cIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33E2C116D0;
	Tue,  3 Feb 2026 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770158555;
	bh=wqlUnDGUA74SSmVYWHzL/Uebmeo2LqJW6biZSp7JqD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNpv6cIK7i1lmWiTAs0Oi7mQuprRVqXLnHPMM9nbafJbo/NenR0qX4KyN4Ps4QF6a
	 PszeWWhxqIy9Sk+A1aQgLYlEjh/etfQOnqEQ7OUOgXMdrWIEvzOIeupJctQSh0C0K5
	 tLbXRo+v3K4ZX2IZmvhGaeJzauNMoa6hAGLD9KiLdz1tPV0xl1hzYbuNcFhGAskp3e
	 OWMcy+0ut1mgpxRC8NZDl2R/ItSLAKZHrId9Yxvfy2fxV0hDuM66ELMAmGwsSd/nGg
	 Cjff8j0SXJf9IAeUktPBkK9pfsVH/+C2VOO7agyUINZgHtgVEqYXUWtKw1QLgWVh9T
	 M5SFVGEcUfDuQ==
Date: Tue, 3 Feb 2026 14:42:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
Message-ID: <20260203144233.053321b4@kernel.org>
In-Reply-To: <CAKaoeS29J7bONONKF8mjyuW3zkW1=hrNx6oFCyPOvv+s=i5pAA@mail.gmail.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
	<20260122174821.70553ffc@kernel.org>
	<CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
	<CAKaoeS3ZLtiXNLNoJXGyTRp_-4yywdmDdCbNtjA-Q_w6mT_oaQ@mail.gmail.com>
	<20260126161601.1c2f18ec@kernel.org>
	<CAKaoeS29J7bONONKF8mjyuW3zkW1=hrNx6oFCyPOvv+s=i5pAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2026 10:55:33 -0800 Rishikesh Jethwani wrote:
> On Mon, Jan 26, 2026 at 4:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > I ran the TLS selftests - all 898 tests pass:
> > > linux-kselftest/tools/testing/selftests/net# ./tls 2>&1 | tee tls_tes=
t.log
> > > # PASSED: 898 / 898 tests passed.
> > > # Totals: pass:898 fail:0 xfail:0 xpass:0 skip:0 error:0 =20
> >
> > I am asking you to implement selftests that will test the HW. =20
>=20
> v6 introduces a selftest to verify hardware offload functionality
> https://lore.kernel.org/netdev/20260203184835.3619101-1-rjethwani@puresto=
rage.com/

no need to ping people that a new version has been posted if you're
already CCing them on said new version
