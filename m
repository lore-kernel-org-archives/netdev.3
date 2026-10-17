Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5E3DB63D;
	Sat, 17 Oct 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262865; cv=none; b=M/S7qSnX1NLgX3B9uMNVJ3bqzwrqubAAwkTH+y9s2iL/8GILT7JGTI6EQ7IpUAVo4Ae0n91TvOnzVlZCXPm5zlt/WNH3YxrvZHMCWz3MT8xZs5mnDFLHHdHg74U4SUlfVEU2gvRd73iDWejX7hpkEbYanZRGURB96BJ9yEAHn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262865; c=relaxed/simple;
	bh=d70tjNajH7W5JdK4oZqTt5T71m6okE8yeOJdubvZaXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urdnxN4gHfFp25WNNQVrTt2EzPGLVTusS01S+0KZjdwD+TgfbNPx8Cb95jTFRxSfCg1PthCC5t4C8TZN80SVrFhWfQkenobPiN7c4j++RSkFLxkE19HnwS+8c0dYsd1UqdOM/djNTNXoQT0GXBJWfA8KHJF4wi2f2MXrMug/lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=hTCK7UBI; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="hTCK7UBI"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id 16D5A240B56;
	Sat, 17 Oct 2026 20:37:32 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id D41E9240114;
	Sat, 17 Oct 2026 20:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792262249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZOw3LVxrwWnJzNeCV109Is8TVZT5XuQejH8TuHMcyk=;
	b=hTCK7UBIpicVxtLdBBjUpewHOKqeVMujDrXyQ+N6huBg5QZz0jhOMi86o9mVHxATA+NpNT
	zowSXvDrIkB42eBPCiso7qqtf5zlLjn/2EMRFlhWmbddnzLDmWSQx8d0UZ0273KyG03dLo
	aKQS7lFS16mhCraYLMlOeaKQb+LtVY1lTCHAnBoEe7rP/yoOZqtzhc4MF5t7CrT90WJ8Ue
	fjqvwT9GVB4uY6UnfeSkbFXLaDs72nRsYg+7AuD60PZobjJFveduuncUhxFkgSGaHvDgTA
	0csS+acMDJDaR8dfMjYHXEyIULpCCktlqFmM04SAho65hjCG3kDgQpEyaYoaXw==
Received: from [192.168.154.193] (p4fd55e66.dip0.t-ipconnect.de [79.213.94.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 75C2124010F;
	Sat, 17 Oct 2026 20:37:27 +0200 (CEST)
Message-ID: <c40f4d8f-223c-441b-901e-5bea5bcb612e@tk154.de>
Date: Sat, 17 Oct 2026 20:37:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: ethernet: qualcomm: ppe: Add IPQ5332
 support
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
References: <20261016152449.934312-1-mail@tk154.de>
 <20261016152449.934312-4-mail@tk154.de> <sashiko-outbox-175580@kernel.org>
Content-Language: en-US, de-DE
From: Til Kaiser <mail@tk154.de>
In-Reply-To: <sashiko-outbox-175580@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 2c9a6a
X-Rspamd-UID: addb0e

On 10/17/26 5:25 PM, sashiko-bot@kernel.org wrote:
> 
> [Severity: High]
> Does ppe_config_qm() calculate the multicast queue register address correctly
> when queue_id is >= 256?
> 
> In ppe_config_qm(), the code calculates the address like this:
> 
> 			} else {
> 				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
> 				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
> 
> Since queue_id ranges from 256 to 299 for multicast queues, and is not offset
> by 256 (PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES) before multiplication, does this
> result in an out-of-bounds address calculation?
> 

This is the pre-existing issue you identified in v1, affecting IPQ9574 as well.
I submitted the fix separately to net:
https://lore.kernel.org/all/20261016150140.929729-2-mail@tk154.de/

I could also mention this in the commit message or add the link to the net series
in the cover letter.
