Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5B36165D;
	Fri, 10 Apr 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854659; cv=none; b=S50FL4JMpM05dxA5J+nE2asxhibQ1B7Eq8ofI4tUYFr7yF9Po+oYwBYYcewV599S45yg98DLK4mNR+1z68+vf8vTg65UeCJCMvtQeTQbzQj4ywxPQwSetaxCtoA6U2VFLDGLj6lnriYd6YbUFZMnHLuS8DAwdsxyYO+XcZ+i2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854659; c=relaxed/simple;
	bh=W2GbY85pAkNHR06qR5m8V1VNRajKNuRkVXDevMNWJl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjV6J7ohWPdnQ8W2XaGgmQj9QquwZJOstnJkI5iLQ91W3zVr/+WGjDIuAgVsl4sDyQL30oeOxayDhHJC9M0JV5v0IkxE54Ai7tRze9aGfBbzxdxu+fduvD6BOSPRLmnqUHuk+hj861TpwnJzV6zkj1omfOW32RNPQosZVWJpD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyFpmJzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyFpmJzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB3C19421;
	Fri, 10 Apr 2026 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854659;
	bh=W2GbY85pAkNHR06qR5m8V1VNRajKNuRkVXDevMNWJl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyFpmJzcdBgsFix+zYlWdLwaHklN9gHdTAeCxXZnBTtqL1KAcMAcAUsTr6I75jz9c
	 336hE0LQTDlARiPW2jxdaJuASHns9zd0NP5XAKzhIL8vxVzHwBbqObIQ8FN2DRIz8P
	 rfd/yp96QF3YctHOUMe+Wy2LoAZS1Gw/FvT8C24vDUtgzkvuXCrCmLVs8wBfrD6o4m
	 dTHiHnLSSHyJWn8wbm0lNNivHYJ5xdgF6Z2e7IUkBstCZ+nRvNxzYs2j6W73wmWG5J
	 iUuaSvYLE/RCQ8JzSXOmHVZPgw6G7uAEg4NS1VF6TVR/0U+pkRHG/F4Yy/qA1qw5EV
	 DnkbnQsPRJz9A==
Date: Fri, 10 Apr 2026 13:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Message-ID: <20260410135736.4bc7ed46@kernel.org>
In-Reply-To: <CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
	<20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
	<20260407180432.102073cf@kernel.org>
	<CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2026 01:06:06 +0530 Akhilesh Samineni wrote:
> On Wed, Apr 8, 2026 at 6:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote: =20
> > > PSP defines a 6-bit field in 4 octet units. Does this need bounds che=
cking? =20
> >
> > More fundamentally, were we to support this -- is it a device property
> > or an assoc property? =20
>=20
> It's a device property. All associations under the device will share
> the same crypt-offset.

I don't think there's anything in the spec that says the crypto
offset is device level.
At the very least every L4 proto may want to have a different offset.
We should probably hold off adding this until a real user appears.
