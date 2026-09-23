Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2437F32F;
	Wed, 23 Sep 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130291; cv=none; b=AV+fKu99B7fxfRaqPJvvEaM2qkTlr+CBlWEHv98nNK0SX9VKd05y+9ExrZPpDzSmYawsmbA9F72lz/V0emlsiCM5UI/hIpwkFnVq4QNzPWplk89Tn1iJz6Osx+O6+04Bfj/dLVsaPQmrkT3D0/XUIgvbeE3MdLdzJ1G2P7EuAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130291; c=relaxed/simple;
	bh=QqfIliR7hcNHTD4siqv8l3X8OhxSilT1gvZa7qyJc7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ul4uSsiIQ9tNoS616c4xDjYm8r2TsS8kU3NUXFSDuabJgkqsrioWmBUCYItZOr9j1cahRcZ+Yl6YWXZZK1PdSk00tBDdkPPeyUWAGFn50Ms7uXTDqVPeFESUU2YkedB2YcJXUJtPlVD4Ky6afBYimIBcsaMAk3MZcn1DWZprI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1VH6KZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1VH6KZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06401F000FF;
	Wed, 23 Sep 2026 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790130290;
	bh=eKK7cLX2tCod48o8HN+nrBMshyoyneBxydRfhPU+VUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S1VH6KZgzj+BfWsFvrsKHP/NHEfJPw7zaa2Lu3jbqKgkT+Hb5Yo8NWf/mBen9uump
	 AwWxlozzIuyDkOd1IPMAtQ/7uZ1Yq3EVz7eJ+CDXyCGVEL+cHmM4JBEFdvooCwrvOH
	 Cc7cDKHvySBEZ3z7qctXXxYURvMSuZAzci2UREjZo/7OKZpaIyYyYTXLTvkCcG9lUE
	 rYGCYIqnegmSTep/tKDXH93ZrzpwcomL39lEjoTMOZaCfEtuYPzxeRy7b1f4btKf2P
	 XEIIGFLwH/7KWjbr29FMeVeU9RpRmTImCY1Qy+wAriWHzXtU1U7DJfknoFo137WdKH
	 qiJ1O/clPCVEg==
Date: Tue, 22 Sep 2026 19:24:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tao <gongtao0607@gmail.com>
Cc: netdev@vger.kernel.org, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?QXLEsW7DpyA=?=
 =?UTF-8?B?w5xOQUw=?= <arinc.unal@arinc9.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 2/2] net: dsa: mt7530: trap frames to conduit in MFC
 on EN7581 and AN7583
Message-ID: <20260922192449.568e2b71@kernel.org>
In-Reply-To: <20260919065214.31604-3-gongtao0607@gmail.com>
References: <20260919065214.31604-1-gongtao0607@gmail.com>
	<20260919065214.31604-3-gongtao0607@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 06:52:12 +0000 Tao wrote:
> On MT7531 and MT7988 switches, trapped frames forwarding is directed to
> CPU ports specified in the MT7531_CFC (0x04) CPU_PMAP bitmap. When support
> for EN7581 was introduced, it was assumed to follow the MT7531 model.

This patch does not apply, please make sure you rebase on net/main
and repost
-- 
pw-bot: cr
