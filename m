Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF53F7A9A;
	Thu, 24 Sep 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281667; cv=none; b=DobADZ04ZA5JPlhIj9+CPSJKkhDIFrca3W4L8OTiZQD2eUWdyGYaNObRmHufaqM5JpRo7AZ3eDxm9AOn9su//CLDMLKCljCKvUBq1bAjVXwfvQsWYlRIhukC41vg4o2mTPJAfM/Lch0H8L8RmwH01mRana6kdgxNcLGluAkhpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281667; c=relaxed/simple;
	bh=lOgs1Vk36hI1sK+kfplpm6xwQ+Bq89P6PGwa3r+up3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXyVqsHjvSc+u1sSqi2+z+ccYAVfW1PSM/+YzYczliklHmZYbOmIZKfK8IosrlpbSyga3mUdwCeXRcxx14WXKm/r72nDR/6H/8WdXpeu2Vg7oqpve2os5RYq/a77IkCKK3edTGHUSuRnt68FZdgdJ6VE/6Na8Z9Zne/pL/oouII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3/NWC0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3/NWC0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F249E1F000FF;
	Thu, 24 Sep 2026 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790281664;
	bh=lOgs1Vk36hI1sK+kfplpm6xwQ+Bq89P6PGwa3r+up3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n3/NWC0oJpAPnXaeQpIxiEur660tJRMKLNqftEwy4R2Ak8sqx+Hy6SB+ZTIsA/Ryv
	 guTZCnxYy6CVCzFbyqMyGnLtBr6BtX9T6M1oYIf/EDlW5szMPd3ToXcZEGmU+4XAtD
	 dktekRpQ4E5XfVCM8bRBTMwmWWz39eoRHdLGFCZfHcNLsUD0yYBSmsCN4chm4TMIrn
	 vPwiDcGvQCA7+Sp1NN5nviJe9zvhIhhJ0jdlOBDnsZpf3NCARy7hICcViAr+apAQd3
	 uHa6vBaN3SoUX62utIl5tKaeQUe5eJc2IhNvnPlRNdJtSzEZqXDHBKijDZ0FXBEnYV
	 LlsEngwVGXcYw==
Date: Thu, 24 Sep 2026 13:27:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v7.3-rc5
Message-ID: <20260924132743.50090cf5@kernel.org>
In-Reply-To: <CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com>
References: <20260924183257.2700506-1-kuba@kernel.org>
	<CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2026 12:04:05 -0700 Linus Torvalds wrote:
> I'm looking at those ovpn fixes, for example, and they fix old stuff
> and they aren't marked for stable. The ones I looked at seemed to go
> back to ovpn being basically merged initially.
>=20
> So they clearly aren't regression fixes. Why are they in an -rc at all th=
en?
>=20
> Are they actually important enough that they shouldn't just go into linux=
-next?
>=20
> Your merge message notes don't even mention them, which to me says
> "not important".
>=20
> "Not a regression, not critical" should mean "next release, not rc materi=
al".
>=20
> Maybe it *is* important, but then it should be mentioned.

Yes, ovpn stuff was definitely pushing it :/ More of a decision
on whether I want to ship this to you today for rc5 or risk making=20
rc6 larger.

> I've pulled this, but I really am trying to start pushing back on
> pointless "fixes" after the merge window.
>=20
> For post-merge-window patches, it is NOT ENOUGH to just be "a fix".
>=20
> It needs to be a regression, or it needs to be critical. It needs to
> be something that would merit the change being marked for stable.
>=20
> Regressions are serious business. They break existing setups. They
> make it painful for people to upgrade. They are critical, in other
> words.
>=20
> But stuff that has been broken since the first release of the code?
>=20
> Sure, it *can* be a very important security fix. Or - more likely -
> it's just a codepath that doesn't matter, never did, and was found by
> some random LLM and that's the only reason it now shows up.

Not gonna argue, we'll continue to adjust the filters.

At the same time I'm very impressed by the overall code quality these
days. Regressions are very rare for us. Even mindless slop that people
send is an order of magnitude better than code we used to merge 2 years
ago. But more importantly with multiple frontier models reviewing each
merged patch the math on the risk of regressions changes quite a bit.

AFAIU the rc releases where about stabilizing the code merged during
the merge window. If the see no bug fixes for that code because LLMs
and CIs have beating all the bugs out of it before the merge window..
what are the rc releases about? =F0=9F=A4=94=EF=B8=8F
