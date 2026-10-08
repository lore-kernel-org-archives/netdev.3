Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677D38911B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485142; cv=none; b=Yml9/cCg0C+OUV2x3QHP1WU60WoKrd+zAKrosMr1pIQ5lKvGMrV7kf+y/KF0EsW0NKchIeYJgA8LkoZLHHAMAc3VXiqYlTCx/QGycsv3n7xw3jdazUGSbsKESE4vKGYr2ApQ/L5EI2inJNqX1b9gjPR72jfoNGh0RYtHbeeLHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485142; c=relaxed/simple;
	bh=XAneKUnn/wVblKFfwgw1XFzZ3ZiwRt55grEaSA24xjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xtl4hEzpe8LDUduYX1M3CgfC888HZMjoAvEe+YaKp3CrCdPZJaJq7QMOGrH3UAdW0V4cH597h5QTX/k0j+STsFjz7jzKyRLkhgqQnzReltpZYUKYbluCYwLcSr3PEp8zWmul0gXKDa/Vy2e9m4ABdmZQFWZbVURfcqyUNC9MnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpdt0FY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpdt0FY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A712C1F000FF;
	Thu,  8 Oct 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485140;
	bh=3p8x7drHDhsAbniAZX0hWAknaPD8JhJnUvW0r0fw3SE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kpdt0FY6ZIkLD+BN5DfJPvbkknni2sIK1Ef4aWAIXmkNv0hKjIf0u6K+TGt4MAUMA
	 PrAnc2hBMbESj9SOs0q7yk4KoNzPCArrl5F3C0C7NcDmRG1ETOmezx6cgUGtghuEhK
	 BURSm/5HmfZl6/EHifQ8y5qnb9pPXpGXiU5UooNb0D/krEyJJ4eYjQHBfGdQa9is65
	 fZhKhgLo1cZMXD2dkuHH9DwPKdN8asN1fhVmWW56oSek7/5OmIfQuJrI6UaQSP+rh+
	 kpO5DekvU2CxTAcbad5agkhT/HjlHV34HM4skCliZBEtb9sW/zurLdcHjn7wfLDV92
	 KrvW/lDdHDtFw==
Date: Thu, 8 Oct 2026 11:45:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net 0/3] WireGuard fixes for 7.3-rc7
Message-ID: <20261008114539.0efdc79a@kernel.org>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
References: <20261008130124.724119-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Oct 2026 14:59:13 +0200 Jason A. Donenfeld wrote:
> 1) Remove an unused variable.
>=20
> 2) Stop zeroing out skb->tstamp_type when encapsulating packets, so that
>    fq behaves correctly, from Ramses de Norre.
>=20
> 3) Make sure handshake state isn't swapped out while locks are
>    released, reported by J=C3=A9r=C3=A9my Jean.

Ima sort these to trees, Linus's been onto us.
