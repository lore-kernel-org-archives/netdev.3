Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462E32D0F5
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512671; cv=none; b=Oj/htKGjyGGkoOrktQ0VKQephYAp9H0Ey8eeXeQscATxARWNP25K82NpS0Hq1GefGa26QYX38G5LJoFPs8qzfr2r5poEYeZRGcKhmssIpqaiyiI6VtWujAx8AN/87vt15AwZV7b3hgEYKNLbysnsXK0/N7MxSyMq/3c2gKQBauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512671; c=relaxed/simple;
	bh=LwjV3921yNSN779JY1q2oTSuM0bPfmgeY4kreZL0jeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYPjVuqcDArPw3swNMHI4v/mIbgKD4uSVTDmHKTQ5lbwO1e1WuqFJ+pruQIDpFxuFdRUzJQg7fr5xP/Dt3tlM8JLOnaXf6PSwmr55RDh968XMsV2aioRIv4UHl2tTh8u/qGjSv6YpekP/4GdX0ky4JXb2abLW5vY650oOJJydp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiO2r2IF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiO2r2IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC131F000FF;
	Tue, 15 Sep 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789512670;
	bh=LwjV3921yNSN779JY1q2oTSuM0bPfmgeY4kreZL0jeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PiO2r2IFUgH9SZ7Q1yUz1oL4ef5bUKMfNqo109mkqqboOqzLdyMt593DDltvfuMgX
	 VRz+zgh3eVAIawiBIDg0C4n+U7QzjPaOxX75SoYhmTs2t4bHKQruF4kVAnR8lHCDW0
	 0diHT43oJRsIZkvFqd1DHLiNlrQ5UGsPpbDJu+aVn/gb6ur150ELHP2ZidfbuaYuCL
	 DmZe2loPq9+7OZAkLHCVpJEtAF64E+9kRNAaGXDUUEIL7eA3Fe+wBE2ryDCYqAUfxd
	 q7kv3rYGuLucLKMtjXNLlrwrul8a5VagWrG48jOczuwKL4Iz+nAY/leExgIkTGWRCv
	 ve/+h6ZxmmJow==
Date: Tue, 15 Sep 2026 15:51:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, Johannes Berg <johannes@sipsolutions.net>,
 Michael Grzeschik <mgr@kernel.org>, Denis Benato
 <benato.denis96@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jijie Shao
 <shaojijie@huawei.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH] net: fealnx: remove never-true 486 CPU check
Message-ID: <20260915155109.068c222d@kernel.org>
In-Reply-To: <CADkSEUg2mgF6mB12uRi5605Mb0MTN=R5GF5FyrOcuyNVTc5H9w@mail.gmail.com>
References: <20260915024638.198865-1-enelsonmoore@gmail.com>
	<CADkSEUg2mgF6mB12uRi5605Mb0MTN=R5GF5FyrOcuyNVTc5H9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2026 20:36:45 -0700 Ethan Nelson-Moore wrote:
> On Mon, Sep 14, 2026 at 7:46=E2=80=AFPM Ethan Nelson-Moore
> <enelsonmoore@gmail.com> wrote:
> > The fealnx driver contains a check for boot_cpu_data.x86 <=3D 4.
> > This field encodes the x86 generation (3 =3D 386, 4 =3D 486, etc).
> > Therefore, since 486 support was removed from the kernel in commit
> > 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
> > condition is always true. Remove the check. =20
>=20
> Oops, never true*. Should I send a v2, or will whoever merges this fix it?

Will fix
