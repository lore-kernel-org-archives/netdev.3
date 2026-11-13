Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614269;
	b=ZNrWksB55VtH3xq7vcp8ixK1cYeTiQHqk/eN3qRXrWLXW99qCf9D4rtVK7psfG0ou/FL
	 k+ZeThTjd1UU2lIRbSy/DVkzhoLwB+Ut/c/99zHcVUS5mxdQbPmMXBiwJSfWPlk40Rb4f
	 f3s3A8mOd8iudiHKlN7ibEtqpgSUw8omncM7IqfquNbnsyqAXGGsg/QqRN8NbCz/D7BWo
	 RGlvC6O8XdeZ52ObD1xXPaIJgfOhH0qZC7hLV0lxnTDsZoMpnWK6mNSs3HrmDcfiKlcO0
	 aopzQxprPwI9eDGwHjmIiOMG47nyjeziZaex65d6e2auSz/8WbQH6es0DHbLOfGDl2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8+NtZFjS95/B6+YyhboKxw3u3O9LiJhhPeE5lA5NESw=;
	b=q8OYeIQeGCypYBraJj2deiVqc/ITHaxDyhhMYUZb2qzKQJvllwkpZUddRWKp1rmCq5ll
	 9mnn1HvdcERk1REXcqMJ8gIobrJ6DlL68L7Up6Bl0fo3QvDFlUc0JA4xhbZdH0K+FKYBx
	 ggQelfy9VgFJ2RiAW5/jCPFCMaplzhmaF9rEsfwXynXtFweKkTItvWS21ikzj4AFHvhlF
	 UfMZdL477vZqxCujH/MUZQ4jbCkQeojpKa6v6q7It81vzFMoj12ss6uIip5lG6XCqPPyb
	 GmZC99da9EpvBPmGn99ridgFCdDf0Yov+BSIpSmz4lK9CzA9uG8MzVHf9dgfgf+bURg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hBGmygPD;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AA606A881
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8AA606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hBGmygPD
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso339511966b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614267; x=1795219067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8+NtZFjS95/B6+YyhboKxw3u3O9LiJhhPeE5lA5NESw=;
        b=hBGmygPDV1jEVNi7ehHZf9hn2Y8oSa7UtMsjyhADVtKE9Iqh5pWhHd2aC4DUxniZ5f
         27Ulp3r4zZ/F1m4/sRxY03nO2XffKGC/J5jZ7xEgNoBh7aEoCOAuGYd05LMBjsD+bx1e
         s6IKemiL6a8UuWC18SAypIdYnhexr1iOwoho3TI6QLQM/qSCvEyOfLAlJfVUTmGO/vZB
         /W7iHN+lLEeuU51R5VJvEOiVBMHPYqrgYIOInkPUDEUTnx3rMH1vgQ/boYi3gMWkpHX8
         l0w5eDaG0cfAN8f6ANOgOTB2J9Wa9ipElL9K6yeP6KGz56JKKvMS6v4J3EAgcqZWY+Dq
         4g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614267; x=1795219067;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+NtZFjS95/B6+YyhboKxw3u3O9LiJhhPeE5lA5NESw=;
        b=IZeSG7pRiqg76ejsJ7DbiPiVEMFZq/MYmx41XbJFaJIdi9/8A1uE6i5+Zs6iEnjYP6
         bVUG2hCp3bFKpPwpH5YmMqCMm475GzDMENRN1OsJyNZ36AN1Iyp+aAVf+xGHnEB+lkmb
         NbVFcqg+wUnhVt8TO4trC3L+y+mvOJDxWE1K9yNo6y8A644w15jrPSH+ddgSPWai06d6
         +vKjD+Ldmxc6Y2IyvwUULvdO9L6YPYcMFuJyHG/+ep7OegXq1c2ADCRvSUXK0eO4kf5K
         Cuh9/vcmwyjasVgWTTyvBjvZ8E6P2yfNeQZ1Pdtsxxu3+Qn8HBYTSS+HzpOXVo/qi28R
         0eDg==
X-Gm-Message-State: APuU4Z9tjHoMjSJ0Uq4N4YUyybdr+Z5o5YZfB3KuvWid/3tV0+n5J/FV
	4NY8tLh0LVHBKifXfkMT2EvG163ZZCX0F4PUkHlSOv+YxN/s6n2WyFxm
X-Gm-Gg: AYBFou2ZclKr4Gntn5wZy/aRhmxKySa/owoaQZmP60UBQoWWTXQteYaACHYDGo2qsp6
	fTfDxITE/5QssfNa/ctKPbiipxidGHIJuMJ1WdxLV8mSNV49X1yK1addp5aNyPWRHbmE1WaIedC
	hj6o7sj1wXVqwE9g6OD4E0FDm0DlSHHr0Gy/uR7wI2s9wWA4D/rzQ8v78dJRwFB7O1XSThlLYs8
	qOmFDwEEiWyfOq4CW7QMH2Ds6zFnAVph8BW12FTkqBNfOX4W0TanEiyPje4WE20CXEpcWlOYvxz
	Q2ZOxfJNZXpHjmYqvVyDVhvu0LJvfBVWbb7FfY4QYOQzRbMdFfCmq702f9QFvkwj+l77VTOIzUi
	8Mt6G2tsPRZHZkvOOsQ+M7F3f62x9RSsL2j01ZsqMOIec7bGSF1mhJ4zTX3vMVtw+kYU1Vho6Vr
	oXzT8IHbnYQs8UBUTu439HNHkRqDGmM6O04BcX9fFDq+Az6wpG8Oxwe1UJT/H+m7oUlMeBRUCVh
	BmBxgTYdCRaaIagddpx3z1cC1QFnreSox/H2VLv2sD6Jqw3Umr9ZVQ+urf6Oi9oyb8cNJTAamhC
	74vYJ75HdY/rcPxK2mkGU1HRiSwZyAF6hhTWhDBh
X-Received: by 2002:a17:907:84b:b0:c35:3880:773b with SMTP id a640c23a62f3a-c50963f11f7mr367103566b.45.1794614267472;
        Fri, 13 Nov 2026 15:57:47 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7d1b7sm154978166b.74.2026.11.13.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:57:47 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/6] net: bcm4908_enet: release the TX ring on stop
Date: Sat, 14 Nov 2026 00:57:45 +0100
Message-ID: <20261113235745.516931-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <179460252891.2199510.811569497068459485@kernel.org>
References: <179460252891.2199510.811569497068459485@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 20:42:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] Double free and double DMA unmap of TX skbs, introduced by the
>   new bcm4908_enet_tx_ring_clean().

Right. It happens when an open() between two stop() calls fails to fill
the RX ring: bcm4908_enet_open() ignores that error, the TX ring is not
reset, and the second stop() frees the same skbs again. In v3,
bcm4908_enet_tx_ring_clean() leaves the ring empty. I'll fix the
ignored error in open() separately.

> - [Medium] bcm4908_enet_stop() now frees in-flight TX buffers even when
>   the TX DMA channel was never confirmed stopped.

Also right, and with HZ=250 the 2 ms deadline can expire after one
poll. In v3 the wait uses read_poll_timeout(), and when the channel
does not stop, stop() leaves the skbs alone, as before this patch.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is High
>   severity and it stops the patch's new cleanup from ever running in…

That's the missing TX interrupt; I've answered it under patch 1.

pw-bot: cr
