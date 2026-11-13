Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578081;
	b=TMK2aW38Cfs67nYB5wMcGA0+2xB8cFxRqoQ3J73YBn6cXzEwNcH59xQ4R2SViEjNL9Cd
	 +9mRrvDxwcnThqzf0BQG3oZY5mVFQxr+SCpmIBmeim0mv4g9g7SJDgJaDsjEltTGzCi0h
	 NvdUEsGG7UWZ+s0Lb6jrz66gvSqSxgEs6wTEOg0EIifxj6i4YstHGIPljS71xbxUYoJfy
	 8j070pPCL1C3zTpcIc4jlr6FX/evtjZPrW8sKsQJZwvIEHqc6BOQlNIsQ/ljGyqmwbOeo
	 l+qmZ+O1L0dXjWyocm7n8cLwyKmMSyuUOJkpRVunub/oLxObkfqUL0DL7/Ai7+oQXrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wLLpkF4cjBVNx1uNJleKZrvmo7zDl67dEZ7VEFv3KR0=;
	b=lgWz+CPa0JKi2+LWaS6tVi6I5XcaHLqHuIcaRurmAK5TFmtwd4lQlAC9TeiPW5vGQq8w
	 r0p6dCPdU5Y+YokEjPGBsxzp1bdVSKqndH8UCHr5N3O3FTVJih+qmZ5JRfDkCq1uZyLsO
	 awScByaf4f12VGsLVN/FfX58Mqwj7J8CyGPOPK8iUuFGVLgs8T7Z7A1QOOYMdqoS2eld2
	 B2ev1o6J0jJlrhnR8UVU4H1JuAxfScWxq006qQOaJoM+CzWcrRVPmzJL8y3RM0nozTfV7
	 E/wceiAtTxEocxqwjZAl9F6l9pUA9JuPDiMTj1JfGtr//Q2mTNhZae2Y00iZcln2mww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vN6x1Vg+;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC72606A898
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC72606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vN6x1Vg+
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso253153666b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794578080; x=1795182880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wLLpkF4cjBVNx1uNJleKZrvmo7zDl67dEZ7VEFv3KR0=;
        b=vN6x1Vg+cWbRws0oppzT0pYULxFVRSyz5ZMm4n03rHi+HYaL8SdKbfoy0Z0i3m8RCq
         fL5vB+QE42Rum2oxeFeTP+XbMe6HLgYIgmeAhrn4Z3EqYul4GOdlxsSjSIS0S+23lvuv
         6cxrMEmbjsquxKmSdeIwtwCqYALg6bsp/vbIY125m7azK+cjMN5l/neOD6Qh0EUYC0kt
         MTtMt7X+XCVdIUW0kQChWCrt28EYHyU05qQwO3/T1Wkqnqq0wexqcSwVc9epMwwixNiw
         MXd2lDNCYk9ZJ6WdPsLMRFcOiRrhQ4jq6Y6A+ZcYuU/qYSpI6y9aXkCTA32gglhZo/3W
         iVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578080; x=1795182880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLLpkF4cjBVNx1uNJleKZrvmo7zDl67dEZ7VEFv3KR0=;
        b=B0CT+nSVRDUbnDTc9ONeKkK+LRvI6EzDVj9rSnjMzB/CxGJ1RSXsHWlVWmngC7PYn9
         E17S8RSyd/tKZqKAuZJvozJM7XiGCZbKqCIY9zrKQGd94Ot0K9l917TYF4n3B3IAZFSL
         7wYSlw6PJVRwyMQ05m+tUR3WeuOXane6PhY+zSAXl3e1FzL0sVeMDtyqJN3a8ptRW4Vj
         x1zFw+TvNFeFhesgsbBlpRgewCJbG5ZfsOXohsuFDSadIUeGR4VIATz0AjpFy9tTWU6w
         gtS7daCTCAxd57k1ih44NHceNGMT7LaS4V+olAp+wlCQ5jWIbvC6+eUtWavRbxxsIzJP
         z/mA==
X-Forwarded-Encrypted: i=1; AL+hErH0OhFnQhka0VQ/45oMkLGDalExBszWBxrspQZRdTBhdITftQrb/6YeCPa21qkBmWYposh3a1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z92z5PrZdNOlB1ZRptzgFSgOaOX/yRgxP1U56652knE3wMNjcK3
	q9QTjLPlP7OHjzqEwZXzUlR/AiOD/av3LqQNvisU5EKq4kc6D9etetd5
X-Gm-Gg: AYBFou3553HOYJsPA1J9TiXn4NX6I/Y7kz6F1Fb+q/ZuzNmOJiDywuKNMXIarwGntQR
	lgV7gL9x12CPQVEB5vdG1r7sqfiDN6ZIbFkNaI4CGh/jAOs6dooyvcqbmdiB11C5d+yUEml53RM
	HnQAak9/lmEODia8SQxpBViQ+Nwn0Lcf2PBmAP87jYVnazGD9PFqBNmt4Yz+26ft4ZI5LjkxYQP
	lOHX+NPaFYmbZqAShcCz7314lF+tVsMrjDKq5OhpvVs/PJcmA1ljzhoKt388J9DVisSFt6B9Bo3
	Bfguqm3XUAu/ucCppTzqBWTV6Zj7VaUhsyEwjzOLxWOt3955jWd0ghGhDk4a/i/ycQ7magA5nGw
	QxUMXJXf83/WquNJ4rrUpXB2GDK1BAnegHEn9r2tiNDp5iLXueH0e8EIreZondrCg+R0blITrKu
	9vIo2smO0U31BAH+rFHpCVBr2dtSM/TkhcGdWdLcVjtV+unWyNEGabJKOA/D0ApvGTagnmslcDR
	zMoHZBr7NBwCOKQaCEjuXFgsW9Vcmq1UqXHj8VHHT6/pdhlGvmlgpxlSCwHOtbA7VuM7x3HgsVC
	J6eAN8L8eC6GYy/txEiNXuteR7qMMqGmmJU0EHmLMZ2SDg2peaUu16hWBsWjP0/CbshFgMPfMJd
	NgM0dPXV7rnFINFVy7Ndkgzr+djCZsEbXvk/6qQ6fdw==
X-Received: by 2002:a17:907:94c5:b0:c50:576f:b3a8 with SMTP id a640c23a62f3a-c50963d9089mr297085466b.48.1794578079717;
        Fri, 13 Nov 2026 05:54:39 -0800 (PST)
Received: from Ansuel-XPS. (host-212-171-11-167.pool212171.interbusiness.it. [212.171.11.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b236fdsm98205966b.19.2026.11.13.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:54:39 -0800 (PST)
Message-ID: <6af7169f.a90a51d8.32ae4c.1a7e@mx.google.com>
X-Google-Original-Message-ID: <avcWnNDG0MA7jaOW@Ansuel-XPS.>
Date: Fri, 13 Nov 2026 14:54:36 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: use const char * const for
 phylink_an_mode_str
References: <20261112131358.106442-1-ansuelsmth@gmail.com>
 <86b2767e-c2a6-4bc1-ab30-c69069edf253@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b2767e-c2a6-4bc1-ab30-c69069edf253@lunn.ch>

On Fri, Nov 13, 2026 at 02:53:05PM +0100, Andrew Lunn wrote:
> On Thu, Nov 12, 2026 at 02:13:56PM +0100, Christian Marangi wrote:
> > The local string array should use const char * const as reported by
> > checkpatch.pl. Use the correct type as to mute checkpatch warning.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 

I notice a more suited title would be to use net: phylink: ...

It's ok if I send v2 and fix the title (and keep your tag?)

-- 
	Ansuel
