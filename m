Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B502EC086
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502045; cv=none; b=tExC7u6dVkpWg9yBQvf4Wog1PQWlNKV0UtUi8OOmz3opW7RcJD2Llse0Vv0IxVgerKHiktJ/QI2bCbSSzMLd503N3XHYhcxN2C3H8FLbK/W73Nxix4m1Z19jTp1N4ab+5idxiqTE9lxSLswac+b9LnVuL35hLuSNIl2akdl2e2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502045; c=relaxed/simple;
	bh=fJT2mctPN1ZzPF3J8EVRJFiOYHiF9+itk9KDbhZaLt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utnmbtVvGUn9/uIMvf6Q54poQU20jCjWx595EU0pw+Q4a+vMUUM6mnqyTUW6u4IdpwwDL11KWpbpY0p3eQY+iCgDF1bi7/4U86XiRWqvoI+M1toK/Eq49KvkYYQaKefzVVE/xd6IXge/zZySKf/JKHTfxj3Lw5L02bCF4rdo8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG5cAtMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG5cAtMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78AB1F000E9;
	Sat, 23 May 2026 02:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502044;
	bh=7iDHBvlMULb3DYNJPbCTUBiDOeAnTyhc1wHdai30hFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MG5cAtMFKQ0p7amTqHYXe04p+t+f7WZIpzZFUmICfasVJF9lNFfVPwGJwliVbRclW
	 DP4jzXT60/phVG7UAHUMBrlDvMzG1ddxSEGKTSpRLNfr7twFeNHr12PbTtox9iWn7F
	 53EsN1AB6QONYDuClOUOYEcMswGCcmTsKfOauCuh+mibmWkYJTN9VY4QdYC13t24uy
	 67w2D69oIW57kf0IAGoKN69VYI1aJ5ak/iOvdCMYGbk9e+Q2iS9xkT0G6yjaIVxwsG
	 AFyOeakJMn/OLOT2FRxihmBAuXUx0X99hTm/ey0/CeVv79HfRXuukbw3U2tq1PuYne
	 s/KlcCL3kjb6Q==
Date: Fri, 22 May 2026 19:07:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com
Subject: Re: [PATCH net v6 4/4] selftests: bonding: add test for lacp_strict
 mode
Message-ID: <20260522190723.609b8dc5@kernel.org>
In-Reply-To: <20260520112539.798275-5-louis.scalbert@6wind.com>
References: <20260520112539.798275-1-louis.scalbert@6wind.com>
	<20260520112539.798275-5-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 13:25:39 +0200 Louis Scalbert wrote:
>  	bond_ipsec_offload.sh \
> +	bond_lacp_strict.sh \
>  	bond_lacp_prio.sh \
>  	bond_macvlan_ipvlan.sh \

Please maintain the sort order.
