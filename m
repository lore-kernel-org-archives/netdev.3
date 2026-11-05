Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917340;
	b=ji1KlZdbmv0Uay3rUlgnr9dhmch3YKE61mEqyXgJMGe2xaZz9t9nmjSlmGPM/p2ckf1q
	 TFmmylbZsLVlTld4Zp8ZuAz02N3UPtGVc7+sjA96/3/jfnuzH6mSt6wp0WhE74BFK8ObC
	 BVKzPEEAq4ZcvHVUduOyJDM7q88Fqqz0saC9sISY7+4uqxTTI36WfD4oXNorDLk1aUffy
	 BWOBQs1vFnXNRpgsALXMynLLTLrciu2Bz4py5gCM8rGLDG8DePEcNPGoj0GMkiX9gG26l
	 +nAdUTumze+mr2AwSpdS5LLtIhJSPHHpCo09PoL3QOmJQCIeablAtQqJihx55rQ0EkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I2UCmZDII7TZlJUdlHoHQguMZYmeF/P0Y0rUuVe9MTQ=;
	b=4im/Y4XkpMvLAZdk+kl4JbW/bGg9+SYe43P4mjxMeDXY0790x7mVRlbkAxJ9nHKo0nGQ
	 wTvj6iBs9wW/o9OrgaEg+D385lO4/sk5QNOLD9tqXp1mVtA8SxYIjFJrd15lOegj7Ypdm
	 fbXZ7+iF/xahSQ61L3kCOA9VX0SqQi5nAiYxSQxKm4uceV7fwEe9T2BVR/6SGyhHz/Ou4
	 L/0ISbw1duou7ft9MvfiR1nZCQQeuscEiG6Vz1dStCYgPaxKJNc8AuoOAKduInuC0zUNM
	 6ptP6k5hiDa1c7iUfcLCQJqyg6Kb2S7KlEwhSnmCRNPO35y4qriDfwsf3lprlrKzT+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFJnWLTN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86833606A31B;
	Thu,  5 Nov 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFJnWLTN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC321F0089F;
	Thu,  5 Nov 2026 22:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917340;
	bh=I2UCmZDII7TZlJUdlHoHQguMZYmeF/P0Y0rUuVe9MTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CFJnWLTN8Hdn81KBHt5b4aPAyQJVP6ghpvhL11RGgs3whi/pcGSEbFet1RPf+MX2l
	 9Flkk9NhvfG1ANLCfKLUEhOTvadYLb02HyEENq4ctLzpXHH2gRpobNwln8qERA6Mbu
	 /0CTAx/YFazA3PRiFkzenEKw1ngCxA+Gv1PplWZ89aJZhMJZmBXo0DZRNhVMIbOCTR
	 +cSvVmJhMiOeu48/gIasQDWh9XOSzJYvwOpyweQjclKwkWIiTvD6O0+gnlXnjVk975
	 Cxf8ebCn8Pphkhz5tVbGinl2tlD2tQayRUsttKM9/V3BXf63WwcvdnvAb7Z2K6Dybx
	 DmL1hBF8QnXTw==
Date: Thu, 5 Nov 2026 14:22:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ethernet: mtk_eth_soc: add 9K jumbo
 frame
Message-ID: <20261105142209.06d93e77@kernel.org>
In-Reply-To: <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
References: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
	<patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 00:48:45 +0200 Sandeep Haemoon wrote:
> +static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val);

Avoid the forward declarations, please.

When you repost make sure that patch 2 is in reply to the cover letter,
not chained off patch 1.
-- 
pw-bot: cr
