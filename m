Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23B29CE9;
	Thu,  4 Jun 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537250; cv=none; b=WAIGQr6YopnqeXjli0p1I/KiQuVh5mmN0AQ71cYRBqjET9NJbH8S1MCSnIvlJW5QaLy7dRN+mXJbixdsGruQzNWbKdz1i5AFz1bnsDj/QfILaaMycW2orS1dQEI2YuVPHoF0jlNZ99eZ2nRQSqTI0ZUag8Re3D8DBjpx+Bbq7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537250; c=relaxed/simple;
	bh=jqPXjZW9D/ltoCb8V0aZjBOPOe94jbO7wXfoi/W3VY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqlkiZ4GYxsEwtZgu1N9hFW6XBG4lWL02AZMDUgT/jF4ocaHOgsDTecR9iXxubAp5bFOM1ZW+4UR5i8hXEJ7vqu8Cw8SYgM1DWawbUG7c6pry2Nh/EkDLzwTsjhlysz1JWYkyGkrU5sy35BdDQ3cCRghSzBGakRKjbFX067s6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0LrDu1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0LrDu1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40C1F00893;
	Thu,  4 Jun 2026 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537248;
	bh=jqPXjZW9D/ltoCb8V0aZjBOPOe94jbO7wXfoi/W3VY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D0LrDu1C69gbx93idOn7vXEzS3xcpgPk/WB2viO+LzZOAa9BKgVc8iWqqg2pnQdnl
	 QOIHV2M0vbVq9TTGPRckg/N5rKvW09c7gREDiD22R1FCcEGp76knrQCinNdAqcjJVa
	 q6x28hb1cCYluYrGVJgJ17Dgm67U7h029UTVExchd2ZHVg4duizjFwvjJwFGFTrdX6
	 qM25qCpSafFrg7cI72S+ZIQCg2DbsDDBsHPIoIQyJz8f1KnAV5hmbyMNNglg1RPaH2
	 XSxecTAaSlpmOSp1UiLDNOBbvMa185qR9FNK6Whu+d4eKUlrp6MHAx9YpoKvBPeDLN
	 DShY2owXbNreA==
Date: Wed, 3 Jun 2026 18:40:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, Michal Schmidt
 <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen
 <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/4] dpll: zl3073x: add per-DPLL
 serialization lock
Message-ID: <20260603184046.4c834317@kernel.org>
In-Reply-To: <20260531194423.383366-4-ivecera@redhat.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
	<20260531194423.383366-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 21:44:22 +0200 Ivan Vecera wrote:
> Add a per-DPLL mutex that serializes all operations on a given DPLL
> channel across DPLL netlink callbacks, the periodic kthread worker,

Sounds like there are already two entities accessing the state?
If so why is this not a fix?

> and (in subsequent patches) PTP clock callbacks.
