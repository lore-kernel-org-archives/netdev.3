Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAB33A9F8;
	Thu,  6 Aug 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026424; cv=none; b=MG2mtu6jn9vSErMZtBlnEKUMotK3+Tyh2BfvQYIauxpIZDAn8UcgYFtyGSmhBspH5RBCXN2bR9MbtDBr1+ZKDET+eoqzutxTdh9rmMOl+33kD8T2yji4wNc/Agiis5DAMDHfo0c4FaalosUyG4G4ZujsHga4UcEV1cyLhunA72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026424; c=relaxed/simple;
	bh=hgwWo/uJgRT1XUhvY6XIcR5kBx1TYBVMNOCcXoFK9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0wC6J4H8V+yFKoOCDiI1DE6x6lHcteu8A57T4E2u6mvj7NYCUmpVbKdFKXhCoRPVAYLFq8KtPpE57Yj9sngdviqACjtd4u04hqtpZBxesapUFIvbw7lNo1OyQhqgUSbvw6ba0mWPWPELKd3FdTxQWmYGUM4l6f7V11KCHrfiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDClYws7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDClYws7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3221F000E9;
	Thu,  6 Aug 2026 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026423;
	bh=a5wUVcXFY5h9hBHfdyxMeDZNbJW788gS/+dFZeYu9C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LDClYws7xWRO9jUOsxcvXU2d8DwKKJX6b9B2zOkZJG7yfq8fV7xOOCMgSaFoqPyaq
	 QNDpjUZBc+h1VwwgE5YCzunXlNi3SOEmb3Htb27SN24CPxk9QkTwwWc1x8BU1vj8X4
	 V0bopBstWfOTZkk8zrvBzPOXnUdBIjvICvNI0Bh7dZWqPDMi01Z6jd4FTWI6vXUdf1
	 wrhG8txiV99VWffefpfV1JVPysN6iNhdA/uVokFI3nt7dlBJdkMZ4EShl6Okr/ijJn
	 1L2f3keCJmAwgS2ZU7dRysetQxc6aDuL9bOEu0v7rnaV7c8HODyJlDcjU3eRBV4ZOI
	 x0WOWDJU9WUGg==
Date: Thu, 6 Aug 2026 07:27:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Patron <priv.luk@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
Message-ID: <20260806072702.71b2e604@kernel.org>
In-Reply-To: <CAJmEJMzzuY=hJxo-0yPSfnOymcdd=O9zxmOxdeO_hCB3sbSrLA@mail.gmail.com>
References: <20260804201919.1148015-1-priv.luk@gmail.com>
	<20260806132630.GC51943@horms.kernel.org>
	<CAJmEJMzzuY=hJxo-0yPSfnOymcdd=O9zxmOxdeO_hCB3sbSrLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2026 15:38:22 +0200 =C5=81ukasz Patron wrote:
> After merging v6.6.142 into a downstream AOSP device, it's stuck on
> boot animation and following log spam can be observed in dmesg:
>=20
> E qrtr    : ctrl_cmd_new_lookup(): QRTR client node exceeds max lookup li=
mit!
> E qrtr    : qrtr_ns_worker(): failed while handling packet from 1:16600
>=20
> No idea why it needs more than 64 client lookups, but it appears to
> work fine with 128 as it did when there were no limits.

Ack, I'll fold the explanation into the commit msg. pls don't repost.
