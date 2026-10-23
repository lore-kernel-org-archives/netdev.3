Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769256;
	b=Tbt1jDoY7X6mQGbBMLDMj5VBfG+qZRE5agpSYqWkCKGZSIF4RtIvONrXggr8CYDxFvIW
	 TpAPTDXfpR2GsE1ZDUpZubnDx0cEyyiVE6MKSVVWuNNANpm5IpO7cIXlLX024YOcIUOjn
	 1IYzEQfkoGZmZenluGJWjpiZC7qeUUol6yhku721zxdbsrFdMlC5Ahp9VKzHqta6ziVOR
	 12FS7Npn+EK/MLEYGXFrTJotfzy3l89yLYqPqleaLAjxkLJMzxdj1OXgAVf0YMtkc1xs8
	 BWIhxdOkZCF2mpYZp7DZL68G3+ROCss22shxx5h1RpxLRAKhz5Rc3zka939c7OECa0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769256;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NTuOzIACSQffEqMs+V167GzN1sC4z8a1DCfw0E3F1G4=;
	b=oE695LV2L09+E1fYjtK8lgCMPVFEIOw2gLnaQu9LMpKO0bqal8fbsaKtMih/ANhH++uD
	 VC1V3IXt5mR1itOldpCSGhI2Zn0orpbFQGQ7uDIGOAaLlEsDn86O0lw1SCLvtXS7aEGtw
	 oOtqyH+v+0Z9YQDpkobPt1pxjM1OX2Sg2qpDONqw63OnHD3+MLcmgBQ3Z5CX4RH4d374H
	 4EQvyq8A0iFUbI1kDBegb4P/7zjp4QkwLYB1aqfhl/gw4KCwaFV479u6GJv4jIbt4HjYX
	 Nlk16k2GKKUNA4RI7kxS1Po65zoRsIUQsEtRuZRp+8Hk9LwM+HouQ/pvwmZVwurSkrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F10bZnce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A3606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F10bZnce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A858F1F01825;
	Fri, 23 Oct 2026 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792769255;
	bh=NTuOzIACSQffEqMs+V167GzN1sC4z8a1DCfw0E3F1G4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F10bZncexROB0xaMiYkj8gJDhNwJg9sRmEMrjnUp+4Xyw48r1CUU6qxC2AcgeAcva
	 LBUCyD2Jx+oP1lQ/BeOCjDxcxlDGp6Chtt/8+0xCZT0xJwL2MHRewz8oo0MVelvhv6
	 fNv6SrqAsvwnT2glcRb4GM1rEbWpeanP6CQGJC1wEkWJw7vKLnqxv6p2h/Kw7IEEEW
	 Ppe5k/Bf+87Y2dPMwcOXfeNBj81vnUolUIqsYov0DBJvyDMdvwTB3D3T3qD6tpqsNB
	 JTb0iMHCTZhfI2wrUu2OSisuD+8cCdiN2zumSfz/3ez63kh8XcEeHBYycUTuOeSZP6
	 RSv/qaevADnUA==
Date: Fri, 23 Oct 2026 08:27:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, network
 dev <netdev@vger.kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: nipa H/W testing suddenly failing on CX7
Message-ID: <20261023082735.7103e573@kernel.org>
In-Reply-To: <06502f83-f22a-4522-9a30-60b2478a8c2c@redhat.com>
References: <06502f83-f22a-4522-9a30-60b2478a8c2c@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 16:01:48 +0200 Paolo Abeni wrote:
> Hi,
> 
> Mat noted that H/W self-tests suddenly started failing on the
> mentioned NIC:
> 
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&br-cnt=20&br-pfx=net-next-hw&ld-remote=netdev-CX7
> 
> Judging from the test output, GRO stopped aggregating and the
> driver exposes a single queue?!?
> 
> I could not spot anything obviously wrong in the relevant
> batch:
> 
> https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-10-22--00-00.html
> 
> Could you please have a look?

FWIW I think it's the garbage check added to page pool, which Paolo
already identified. Please ignore.

Side note, I don't think we should be expecting vendors to pay
attention to netdev CI. We can set up a group of community developers
who would be willing / able to jump on such issues if maintainers
are overloaded. Vendor help is obviously welcome if voluntary
but I feel like I implied/promised in the past that the CI will not 
be a burden to vendors, and this email goes against that.
