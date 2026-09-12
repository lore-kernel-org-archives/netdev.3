Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322A2773E4;
	Sat, 12 Sep 2026 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173411; cv=none; b=ZezhdCcJeVXsjFCVkK9zJwR2l5B7STNhsmyJiftLSPPRuTjZmVt8y9DRjuBuGwgic3dqOpEHRtewtG6PeB/BnoMTckSJsk8NKqp+AwAxA+ZcqtyBr+oWN4NXqo9uexpeeB6AREJOpbt3Vs4b3YZRodoAFzOtsOGRyn0AUDkEkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173411; c=relaxed/simple;
	bh=+1JliZP+aQkEHQBcYUeNWSV/MThj1jAPFrIYjz24va8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkdkKVELNshWa03i02zIme6y/NMCMXsbd/e+GEn3sBY54DIj0MENl4FffdzqkMGgQTT5y0I8e8OZiWe5Qb6vkZsINCKuE1tvxaACIphlsZqUiYoI3/K3piMCoCK8lpmT/wT6LUCDk/0KPt2tZK0Ph1ZDPtopYQyyrNb52vgDqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNRRNKhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNRRNKhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA61F000FF;
	Sat, 12 Sep 2026 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789173409;
	bh=+1JliZP+aQkEHQBcYUeNWSV/MThj1jAPFrIYjz24va8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CNRRNKhCzaB9PDy/CZ30hCnecQT5fn+E5V3gDU/IWfu5qw/n9YjsECDM83YPvaRiu
	 jzblnpMj7JuPI3LwVA4XBCp/muC+lg9Y2jaiEiigYpQ52F3pdN3oa1T4iGU8l8Iyvu
	 3hKfFgUKGOsv1DxN1CNgRJB/atal92uya2XDa5OBXTbaOOI8+Dm8AqKuvIqGXhQXzd
	 8nyQIQJI00y7R8kWNzvGOsLv99CSki7JeaCMd+68hKH19+8L4XXNeZrltJ1Ly4Vqkp
	 tcIldeaGxdisgX/jkPeLGot4qRyh6zs65KUy5g1y4E3jtpMITo6fn0bqi0R574CbKT
	 iTxVmd2w72/pA==
Date: Fri, 11 Sep 2026 17:36:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 04/10] netlink: specs: rt-link: fix
 netkit-policy names
Message-ID: <20260911173649.49474ab5@kernel.org>
In-Reply-To: <20260911152629.490a47c7@kernel.org>
References: <20260911214148.1184806-1-ast@fiberby.net>
	<20260911214148.1184806-5-ast@fiberby.net>
	<20260911152629.490a47c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 15:26:29 -0700 Jakub Kicinski wrote:
> On Fri, 11 Sep 2026 21:41:30 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> > Correct the names of these `enum netkit_action` constants:
> >=20
> > - NETKIT_PASS is 0, so "pass", not "forward".
> > - NETKIT_DROP is 2, so "drop", not "blackhole".
> >=20
> > Note, the other enum members are not used in netlink, and
> > are not allowed by netkit_check_policy(). =20
>=20
> Looks right tho may be intentional, so the other option would be to add
> #define aliases for the spec names.

Ah, looks like some of the selftests use "forward" by name
You'll have to fix those
--=20
pw-bot: cr
