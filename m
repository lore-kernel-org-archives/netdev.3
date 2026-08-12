Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BE31E822;
	Wed, 12 Aug 2026 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495798; cv=none; b=El900kLS8qZO5w9GtnDDNgjJ8FKcCKKkxl3jlDL5r5+fcRaaj2f7BVddR71dokzs1flywHTRFIcvSgW+nYiyisxQkEtJ8Ntod75MwVgI6e4FJuSRjTX/MSKKfunWWifeOJfo0NqkujYn5NJMx41VWFWmhRlohzebEFkrhPX07Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495798; c=relaxed/simple;
	bh=2VcDBJDVs+vmgNp+dB6XAk464SBGR8TgevStOPexpJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHBa7J5Y7nnKDlgfywj4ZCPD5m9NbZvEXsBuLxKxLT23V+6StSCa7s0tDBa5aTZ36hanc/S0cEu8zRbBJhmpwKetkxodSk17/GtBQB+66phtT2jWjl8NzNrvfjWAD7b+xSfhHnbXMBMHyyJSW5fbAufK/wXBOflfCbmfSE8P9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7NryQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7NryQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C624D1F000E9;
	Wed, 12 Aug 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495797;
	bh=NlLZAfkHJWmL9wumUW0/LJMGJttCTHof7QERR7WPPxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CD7NryQgS+EV2BLz4O1aNCvHbS/LgvaORj7VS4uTFBlO7P8hynfS4aR1nsdUFGhXk
	 t8eapn+IgRbAobvA279hM2QaWr+QmU8gpHWW1inSXUzqcleuM7xKY1u29VmBuP40yH
	 hvlzJdem4bX9XEaxAH//BmgXrtiqOZeXYCv7tOXOztduhf//hJLR0uAfDwLUy9QyQr
	 pTjbLjNst8DTBzti3U6+3vTPDBIpugQbnVnMPlYLegDX2VZsiG58XBKYAf5YNmsjOP
	 74OUFZlNDiARXVma+cWRU5S/xxwfCeRGDIQh+0W3OylmHShvFeRNBdvs/0zVTy3HpY
	 8ryzKIIs3eMtw==
Date: Tue, 11 Aug 2026 17:49:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH] MAINTAINERS: update entry for socfpga dwmac and
 gmii/sgmii
Message-ID: <20260811174956.55ba4e44@kernel.org>
In-Reply-To: <20260810125415.1717893-1-dinguyen@kernel.org>
References: <20260810125415.1717893-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 07:54:15 -0500 Dinh Nguyen wrote:
> Mathew Gerlach is no longer at Altera, so remove his entry as a
> maintainer for the SoCFPGA DWMAC ethernet glue layer and the GMII/SGMII
> dt-bindings files.
> 
> Maxime Chevalier has volunteered to maintain the dt-bindgings YAML files
> as well.

While you respin - AI suggests spelling the name right in the commit
msg:

  A few small things in the changelog, and a process question.
The names in the changelog do not match the names in the diff. The
changelog says "Mathew Gerlach", but the removed lines say "Matthew
Gerlach <matthew.gerlach@altera.com>". The changelog says "Maxime
Chevalier", but the added lines say "Maxime Chevallier
<maxime.chevallier@bootlin.com>". Could the spellings be fixed so that
searching for either name finds this commit?
There is also a typo: "dt-bindgings" should be "dt-bindings".
On the process side, the patch moves both binding files under the
"ARM/SOCFPGA DWMAC GLUE LAYER" entry maintained by Maxime Chevallier and
rewrites the maintainers field of both YAML schemas to name him, but the
only tag is Signed-off-by from the submitter. Should an Acked-by from
Maxime Chevallier be recorded here to back up the "has volunteered"
