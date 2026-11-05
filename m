Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866825;
	b=ppab8hkfKSAImNB48+RrYmmZgVzs4yid/KJ9E3Gff68ALm4Ob6uqYzoPPj4KMilHsubN
	 7PdMAVsys5etG06co7uxo6D+wq03aeHjGV+092WnJrzijEPXBIKFNGe8AX0tjcv8/Fnff
	 v14ZQ0SkjFq6JUzXNGIiMclpFENYoUMl5dMzLrVOFAtpndKy4TE7LkT6WlwmGOujrdMoq
	 Mz86g8bshBSKBWRgtb2DL1l9nSOWM+sQWk2V0tbHhPnLWqpDTAGNFnu+jbzgP48NwqIic
	 0wSjJCakEaGSGnBhzRsRnTQrTSx0QOlNm11BfrGTvMJAiPgX5EBmG/6rBHuson2AY0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866825;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=KZvlU9LD4QulorsKUQrCCoAuGNlSNMbhJ3UkqNEeJx4x2K+cQ0eQJmqKg4zoEqCicPDe
	 iG95xpzdzHvqiIOGIaw/74AI40HE4kICYU8gKBq+2kXk6i+y4Rj1hK6a7ZU2j3Wsi4dSN
	 U9NTBexUcSq4AudpaiHTnSBekrRYXJ73euEqwedshMGSt0r+5cEi+PD+ot96UYaCeruqx
	 pKQydPiD7wAjs4l+BL14x9cvJQl+a59j3Un9SjLdQQjAUEzex496q4sloptUsShDOnxY2
	 bvl22aaMDHvUvhw+91DAiAl4fkmtY87MxcCq6AFyFTaZMd+cgO10Oea59zxQXl8e4Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F81606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 08:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=Vg22TDiBJDnhHbZ7Pl+180HoaGvnB6m6FJ/VAyyBrGllE5U9k98zt7uvvlaS9OHHnC+fHJ
	81Y19u7SE9PSwNqNOshnxrw5OSv7DPCenc1H3pRKFQX6Bze60zQIj6RMV+PrbJAI+QGZ2I
	B5si15YiNPV2taO1ODQFHgNyEz6Dtr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Y08mQowGP8OLwiqrctXIEQ-1; Thu, 05 Nov 2026 03:20:22 -0500
X-MC-Unique: Y08mQowGP8OLwiqrctXIEQ-1
X-Mimecast-MFC-AGG-ID: Y08mQowGP8OLwiqrctXIEQ_1793866821
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso16848195e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866821; x=1794471621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=ERqhG0ANIDuOTgPfookFk2oMxGQOH4n7cdFFXkfT3zus0ZW3ZegBiBZDWA8JU52AMC
         LbWP4UAqvKvvDB9FSWz98JXI2uaIojfUamIG0nkq+ctWfbf7pD6WDG54tTTPv/TYR3xC
         cfIjZYSsgspQuVAzv5F23bQHC+o+PUE73xLOuBKhMlrDwUNpMuMFetGTaGGRWYpmDJJr
         qlSCCIqBy+kc63NOVVJYzqGC6Jm2g0mjftQrZ/lk8JGffS8Hd7dRWYG9cXFXgFjBkHuR
         tIgTLqfniAgAfw6qeUtfJS3Q8hv+xYrY8e7H1Ky0y/RDDVgpX2tLKprcibvix2o0jBOE
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866821; x=1794471621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=Xz4Ybdffc31OP3cDglubFwlavrGeB1DLcN+XyGU/o/BeilvoONDfx5xK5MkG4EnTlf
         KBxUcw7Mu2tLl47aYobEkudAr4zE05gsMKZIuiVGYfrBJDJzmvp3D9uMzuny53rNZRRF
         XZflrQ11r4mHMx1J0bxFCSCBqI2xIPLutC+UEGHa32FftNJbnIXJArl46z+bmtuyG3nd
         rCJatQJaN3t7mjuapu1U6Mse8FjTPvT/x73jvv1hioswKjLXohJwnYfUyvWqTrxtpUbn
         QxhslVCKkNKonHqSrgEvz8sanw+fcWyJzWt+oQ8XVMqiopmdSSgBRJ3GgiEXBZISaaIZ
         +N6g==
X-Gm-Message-State: APuU4Z9NDbq4kqibKwNWlNdS+2XtQzQNk1Yvc8wyn4gE14ZI384iPhwr
	H27rLQSYerci6USAFv89nHSDz6kTBBufCuZrRULohxREcatxRui7TCGiltalOXAUafnkPaNvfid
	Gf09K+ZUIXYZASm/zTEvjYRDCcSMBA2xsq26TW0LcNwpuRaVbSapGQd4niw==
X-Gm-Gg: AYBFou21k4a8ypKpMssjJQYFuoVVh2pSiyRJpnDUILMJIcTzFzViXoS/llySbi9oqJV
	eC4jZ++FWBOPIdP9gAvmOD4MZzScUvQNBbUme6yioZXzCZqU6AAPrBPL9z4ukeHxBzwi1Bo2XMh
	jVSiKxqFxjnaml1/3vsA67cUrrIulFzskaMyPd7c5KSrtzaC5Z6qmgOxbxQqM2QC/Ys/Q35p7bM
	jjurJ98OZx2TGe0srFpSUYKZfMm7UpYkTPqT7yuoBo/9eVoRUJSxXaro1pEmTQU7X1JZm6ikESL
	VH7V0KJPZJvNIm+nARjJ0kJIh0l5ndExebHWhwxU71gOK7bDjMN8h8k40R1I1plvPCmXQxCX1kH
	7EvcVuElDXJ4sJ6vlOQ5u2mTOhvkPkgL4pPVSg4PK4qbnqYziuk+8qFx32u8YwV3kLovsaj3C9t
	NCyVQ+TyA6rN/HUREnyzoKNPGe5jn/2MK2JXYN/IaTEI0=
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421751175e9.12.1793866821344;
        Thu, 05 Nov 2026 00:20:21 -0800 (PST)
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421750595e9.12.1793866820846;
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm8729801f8f.24.2026.11.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Message-ID: <ca189d78-e981-4e05-877d-8b4e4857c4af@redhat.com>
Date: Thu, 5 Nov 2026 09:20:19 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
References: <20261103204305.3211144-14-mkl@pengutronix.de>
 <179382521036.488856.13184139645230625670@kernel.org>
 <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 00:08, Marc Kleine-Budde wrote:
> On 04.11.2026 20:46:50, netdev-bot+sashiko@kernel.org wrote:
>> The commit message does say that the attribute is no longer reported.
>> Could it also say that this applies to all CAN drivers, and that it
>> replaces the per-driver support for down interfaces?
> 
> If we need to re-spin this series/PR we'll update the commit message.
No need to re-spin: your replies make sense to me, and my understanding
is that some follow-ups (on next) is the best course of action.

/P

