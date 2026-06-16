Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590738B135
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575324; cv=none; b=ab7HTujjCVp0hvuCZjWEB85hxruoKAH+fo7GDW1zXUD37lkhNeX5aDRq+14SqQQ4x2duOPv4btD1kmz7sMSm3ivNXM6GzDafu8MnjZQ8+W0E7Lrr+EgZBHg66nygKI/QBJMgccEQ/m0apC7E4Y3HvjGilE/QX/e7Gpsw+Wwm0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575324; c=relaxed/simple;
	bh=GuqXIH4/Mp464G7SngNzHsMa6/UILMPguBBa2NVHWZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjhjuTImta1n7o433ZtZeUntSZeSqrcukzeWoKB7hBz/moA7FTipMBUBFsGeRKfYFsPIXGaQ+MpEzyKTuLEkrnP8KdF0Tq3UPD+kJIPD67w8BmMM4Z2PP7ZTWXmsOhDObVEHYaA1FckxK1IMc1QPF9rFzBHTpBzLm0Qe9nphXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wAbfpxlE; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wAbfpxlE"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-306f36df4feso2757012eec.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781575322; x=1782180122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij2ukDXcMwBNLXQ6jucFsqZ3k4ldmE3wNeTpnN4p5Zc=;
        b=wAbfpxlEkKRwaRTaQS7Tr/pvDnqmdunDSPePGIEMriQJhK2PCPK/f3S8iN6OqzNwiZ
         AHCMPBOL+xuvLn2nQgZcqFB8L+i0Cow6TZ2ZQ2N10OUBVO9CAmhPjB0m56TBwdOA4XCB
         qpnEyyp0jz+LZojQcrrLKYeHdup2kqV8fP6cGExbbWnrrQV4kgMbYYwSKToLTtixl0a5
         q7tAWgcF5h1BubQngtjn0JBvtOvb0cR9WuSJuTZ8rVfeDs4WM3Wya+ozkzSI8rhvJkZ8
         lYwiqHwwZZCA3zCkE05FNCYD+8J/ANjJzrpw8lv64OsICvEC8djdOr9zoPlqv83oJIB7
         TaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781575322; x=1782180122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ij2ukDXcMwBNLXQ6jucFsqZ3k4ldmE3wNeTpnN4p5Zc=;
        b=jP9oPVdxKwe55yuR15W5iKLkrOI2xgBBrC4yqVgEYcUU70Iqym1wLmw9egktCxiMVe
         xvwJ73rwgqKAqdmIxG+Ciily9QciDYobryWrXYeDI5F1OdB/EpBNi3wZFNygSb+vPfyh
         0qIBtWAP5wF3ObW4y0ZZhg+NFyuSRhOsZSvh/i+sLliyZqcOP0AhqzObjdwvw6iZemGW
         d1xpx5faCQR/wpMN3GfkzyHnyfrfdWb0ybKmfqHI41Y3e8zp2m2afOhdUqkMW37a0sfV
         56uXoF5MC+584S6dqiT2oYPZU/1EWyVVec5QnE122l6FywlE27jSJ1kV9Ctvn6suF4Wm
         xihw==
X-Forwarded-Encrypted: i=1; AFNElJ/R+kCFkJHVsyFrCj00VF1aW7VgWz9IR0FDXBT5T1ydtrczaMoMzWhyyb/pFoDswPcGc4irtJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpirIvUmqrpeJEOaiKLETkBMGZPkuE5zi5VC3Xln+QOeaMz4hc
	YdhwFygM+wUMmBnL8B2+9LgY965sx6l+Y1OYiMgOMmXGNoBhlhVl/9ocxY+qh6HKtyc=
X-Gm-Gg: Acq92OE3Gyo+MKaxMHr5z8XubD2b1MCk7jxTJ1m5k/L90nBKzYCC0BflOKLzGgamXVl
	gGlIpCPllq28If6EEnafjUaKlW8fhB1odnHXi3RyqdIDBEOanw9+B7q4B1OGUu/BamqbMgFh8CH
	PTD25PgnSGcbOQXGOMuOcaMeHq2hBQgxQCRatiqRaK2wzPKX4/jfyzdC/Wer+cFq0VtkhpWiW2U
	Ijtvj8s38t31+p7lj3jcdSbnnl1AHh2ucsh6nXNPlftVzd7yRLSCFJkGhJSsBeh4Z1i9git8LTt
	d/MzMt0MRTA5G1Qx6y5MhkKC5Ceu84GTYt0Z0ue2jzfPe+WN5Su5nvG/gADR6qRVRXrftOlEsAM
	jYQ8w5gkS5Bfz7t9C3UJCi/HWDu7TgnS/Lmq7CGF99amib5joZJ3NTnMh+AqBmDFBkmM2Spxh9S
	Wo+XZxvuRgLtsGlMddpOVClUHvRsEZMhjSJN2Copj3Ydd8qiHO9Yaz0COJ/d4OVUsQ
X-Received: by 2002:a05:7300:691d:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-30ba33dbf37mr1207167eec.12.1781575321794;
        Mon, 15 Jun 2026 19:02:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5cea89sm18324839eec.8.2026.06.15.19.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:02:01 -0700 (PDT)
Date: Mon, 15 Jun 2026 19:01:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <20260615190158.55cbf94d@phoenix.local>
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 15:29:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> This tiny series moves appletalk out of tree, to:
> 
>   https://github.com/linux-netdev/mod-orphan
> 
> Core maintainainers are unable to keep up with the rate of security
> bug reports and fixes. Nobody seems to care about appletalk enough
> to review the patches.
> 
> As Eric pointed out Mac OS dropped AppleTalk over a decade ago.


Acked-by: Stephen Hemminger <stephen@networkplumber.org>
