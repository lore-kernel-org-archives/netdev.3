Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87552D9780;
	Sat, 22 Aug 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359284; cv=none; b=G35lQ9OA7BTCVIiHKr8Fw34vpIL20QIR45yjOyNnRE37tTfN20kZ9XXHDgdoYZvikTC1oxbidZz47vrVj9yLNBwTbvPKCM69pKtKpIRPByUtUh0SWEaNqXhPPeDg9ly4XMUuhzWwBBQP1nX0XyezcF7jmALbCJPqTTcIE5PWEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359284; c=relaxed/simple;
	bh=aObQf2oaYp5QKQcNw3tYERl0NwSXy/AaP2uuZhlQdS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOIW0v6KCUFr3SJGjkQaHwpxD17y0fjGWIBe/c9ebyrDNStO8PKD/CAUKqQliRVtrSg0q9ZaLq3yXzmshwTXsho+SedV2A02hUF07FYUIYoIKnBfFaH2B+H+uV7hlO0skjjjnKRP6sLBPPaA0Sl3rpBnH9rTT4i2sX99CFAMPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1fIJOUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1fIJOUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4C71F000E9;
	Sat, 22 Aug 2026 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359283;
	bh=aObQf2oaYp5QKQcNw3tYERl0NwSXy/AaP2uuZhlQdS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c1fIJOUC8htT+L7mTOSWTZ22TQjYb6mSU3FVTqQ2Gy6GYmZ+pdnEvRVRcGRFFSzHT
	 zsg9Ugdl2YCloKJ2xt4hY+6P7dL76Gl65xnNBCNjYJIrZ6SQYVAqqOViubL7bO0w0q
	 oCZsxc+386+GMUbE15FPq7+tQ9AqEKaV4f8NyKrsmirc2VQCAKrknBtOOLKShaMJEI
	 SjnU/hN4Z8L6/u/x7UqJEHD15XQoQHH9J67yCmEYMSQL0xE1ssJv8y6mBpEhq6u21I
	 1trDR/aOM1u7ECZ3TPq25A/Wsz/UkdBGCm1h4HtiEF8atnqGAZAe/MIvtHsDAU8oGM
	 kUnQ0nX3nimOg==
Date: Fri, 21 Aug 2026 17:41:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Shiji Yang <yangshiji66@outlook.com>, netdev@vger.kernel.org, Rex Lu
 <rex.lu@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF
 to 0x80
Message-ID: <20260821174121.326f3c49@kernel.org>
In-Reply-To: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
References: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 21:07:07 +0800 Shiji Yang wrote:
> Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
> Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
> patch was pulled from mtk-openwrt-feeds GPL open source project.

Lorenzo, could you TAL? (incl. Simon's suggestion of the Fixes tag)
