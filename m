Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C72609FD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142375; cv=none; b=mdsGio/GLURcowIQMHHjaNWxHoj/3dSmAHkxxRObeSEsFmiUJTTvagQFyJeS4+fHsU5gLNgiMjKw4btWIqesmA9nmp5qIL2397L+FuKayxGqwXYFCQp2rcxmu/+xrgp5FigkYv8x0Bm5w7Rhqnze/wRos0tMLw+jGbVdHhVZfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142375; c=relaxed/simple;
	bh=kRyivWgA43w7tmjOxnbZ/lgEvwpHO2HTUENIiHU8fAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzBqWN7liFmP7qSK/seMf6gqAQqZ6jMkZfCGE4t+0LSTi3n10bVg/4kDN2ZxBYBmcuo2UftLnKJ7oXtgAD1h7VLaWalQTN04gA0GtWm6B90GWo9bCXicEVX1gHK/lD5FtriPsVJxTCqFLFSyYhPTuPJ3GqFoYXaEvtrjpYTVQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlsaBDkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlsaBDkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA2B1F000E9;
	Fri,  7 Aug 2026 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142374;
	bh=kRyivWgA43w7tmjOxnbZ/lgEvwpHO2HTUENIiHU8fAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hlsaBDkKXlh+0zQQ/NWUMbfhPlhHJ/gLmUfeHkHMIHnmf2a8OyK7IUeVKD1/55PIn
	 qBlFaIH19IAuXEiPvB0IIxsDT6QYdybqvOsOb5xEmWIU7XZp3WJqxnKO1BS66Yv2f9
	 ssXFjKukSusHkvvIT029xdr9Y7rm8E/RhbVK+22RPR449jHp73DDcsP7l6wNU16AzV
	 ckpsgXiRkssl1fC9Gi17RYxl5EysLTLKNWcuAe/FGq4jnyqYC4kDnZA69YXk1rFdA7
	 sIPJZFbH77kAgm9y905wOr+TThZmdiUnxp2IWBZ+zVV0AeyWSH1/bnodgsuRj3k5YX
	 DUHoil5F1M13Q==
Date: Fri, 7 Aug 2026 15:39:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, joshua.a.hay@intel.com,
 przemyslaw.kitszel@intel.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v4 0/6] hardware pacing offload
Message-ID: <20260807153933.7b8b01d4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
	<willemdebruijn.kernel.c36ea46d8e97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 21:18:37 -0400 Willem de Bruijn wrote:
> This was intended to have a wider audience list. Will address in v5.

LGTM FWIW
