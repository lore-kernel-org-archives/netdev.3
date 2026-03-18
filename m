Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BC2E413;
	Wed, 18 Mar 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872868; cv=none; b=cCskFUuPK11xAP4S1tAAxCCmwIL+wBi316Lyt4nFoaWQYaHlP1AEIcKjeQzXji5H4KN/pAiIdodSWiD/aQsM4LxYSWT3eJNHp2jpIIklq6ensQwXBQg4Ptf1y6P18Zm1YFkaQr0jtWZZTV1JTOEied1ockZCmBZZ6zzch4RkMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872868; c=relaxed/simple;
	bh=KxrdvkBEqPTxkENFRBvHJYQ0DN7AdThMqkjUn0/oz/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7GeoaBEnHvjuBqLPR3qAVd7d8aXw4L4lk7svGXCvApHuwys1iqRM5g35sGc/uLIajDZy+sUWlyPrSYOq9X5sJ0DdMkiom8ZlswgVa+MF0hrFy1kcOVWDoi5aYSi8EF0a+fvHfsbXjo88EosKWCVADEYPWMXSz8xBUA+3X5ip5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvUaj8HJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvUaj8HJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC9CC19421;
	Wed, 18 Mar 2026 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872867;
	bh=KxrdvkBEqPTxkENFRBvHJYQ0DN7AdThMqkjUn0/oz/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvUaj8HJSghzpVfTfAlaumWOQxxwGJPCxElo/pXaTlK/0mmvKSbDWXXInM6PMyYLx
	 b5Pbr1C6I1xVPviudFsca/cTegXoBWy0xS6OV432/bHVxjGeuJ8uYCHQBqSojB4Ff1
	 DqtOXnvYHK1mVqmiLIxLIrvgPFt0sTfVFHArgyTurv2qs/zFW5c/1QwUVq7lxlCD8L
	 pkGae9b64ROefB7rKu/2rPVQfVX3tmNvwTp6L4bZte5KDlQE1R/SSxMiOkCg/esQA9
	 hMwXY9Ezw/xK2yUmrFdv2cTXQt+USP453ZO5GaGOLgC9r+kx+dVfbUopPSkCP3m3sV
	 0QE4A0a+bE3Qg==
Date: Wed, 18 Mar 2026 15:27:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alok Tiwari
 <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
Message-ID: <20260318152744.4f6d8c83@kernel.org>
In-Reply-To: <b17134a2-c95e-4019-800e-ab6ec6982ea3@linbit.com>
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
	<20260316113736.1085a124@kernel.org>
	<085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
	<20260317151745.4562eefc@kernel.org>
	<b17134a2-c95e-4019-800e-ab6ec6982ea3@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2026 15:54:04 +0100 Christoph B=C3=B6hmwalder wrote:
> > I still feel a little bit in the dark as to what you're doing but the
> > normal path for Netlink is to add new attributes and commands in a
> > backward-compat manner. In case of DRBD given how "special" the
> > existing code is we could probably start a new family using modern
> > constructs. =20
>=20
> The new family indeed sounds like a way out. So we would register two
> families: the old "drbd" for the compat case, and a new "drbd2" with the
> new command set. Would that be more in line with the "standard approach"?

If we really can't keep backward compatibility then new family sounds
like the next best thing.
