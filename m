Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816676;
	b=HTXDNFuBF1cnKN8y2k0qHvPj9+Z718XxMx/aCTsD85EGntbXQN5U66Zu/KHXll4iyc9i
	 MOUCTJi0M1vQg7c1fB+QdwTZ1c4QnJeZVUxPsHWZOpEVch3Ki1otjRAeyX02wb82jd1eW
	 j2aXrah8T1fnqUceMPiT31B+4axUhccGbgwVTPD4q6kUSUueLmJ/Nag+kQ4T2/bS6pHCO
	 ZvlydxgMFavhKXsWDgmHf+B51q2moPs1ZrHFvkFUmJRsTZDjuejdcrW2DHbjujIS6IGvo
	 sgcbEzNYWmrRexD2PZj2pZBI0//bETp9b3mmu5aT3HJGdxNc+0D6G2uEHuF1ESIOOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ycnUco1cGdhF6ejE960/8oZSSlOXbGBirBTEJmck5lo=;
	b=CfpuXvBLfqyi/iOKWTbg7As843S8SU+Y4z+RgfuRL56CYb2MgE6HTPUCzYqe6mdiJ0ov
	 PGQ12CzWIDOtuTncVPaiBvi/sNEM5u36NIvNja5X8RmFWMo9UfUl5GG0NKNjnUqULv3UW
	 zyJ445OUMs8VzjgMB5PhAtYzv0YMIPf36FSkTPKNXSM3+XAEVOrGNgX2VxtyKSbPXN10p
	 ezj9KfW1a0i1L/aBbFlcZ7AxGfcvxwKWU9WcMLOal2nbgi74x5XlNQbHC1JksvnmL4VmD
	 ydI1CkQyH9aiWxMjmBnqnYncmatwxD6vVtKElrGdXyvhAO+8X4Y0jh3vaJk2wAeLsHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAvZ42ZR;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597A606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2597A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAvZ42ZR
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso8298715e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816674; x=1794421474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ycnUco1cGdhF6ejE960/8oZSSlOXbGBirBTEJmck5lo=;
        b=AAvZ42ZRapL/FMAksX95saKS9FgTgjlJvKBwZ1pJogyOqinmoTMN7ygQWtw8MUwzsU
         XP8xEhzv6dcsY5IS9bcTb8HrB/AeFsobHyQrfXWcCIS4z02LJbwGIn5wYlKr/YFgEwo+
         8lPuPRQPW71kpzpKYD22xYdDXlCsYqwnVXYsp4yfkREhxJlW7v3oN4LwVZxei0oVCYad
         /dmnHdlouVpUeAy2t6NWWlB7GK8isX640LnwDxoi2y33o/w976xnjycGy5XxqUundg/6
         owEuLMgr9F+UltJOp1XfjC9dwjRET/axmp29yWGoxzk0ja3CIPdcJBxP5gZ9LUaP/DKL
         uJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816674; x=1794421474;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycnUco1cGdhF6ejE960/8oZSSlOXbGBirBTEJmck5lo=;
        b=rFy5ABWKS+LTbhnnVTPvmWm4T2DzzL33w8B7p5DuSUqUhApo0jpZxV/f46VOHvcJvx
         rhUmlrtgAzOmMBZqfi46/PFgmWyDfv4YNYsq3RpRF8rieVopwmYg4uaTatVMLumpcr0K
         1Gfv4EtfZi107j/w87+H5sPnyPUfbKN/TbKfEM0rETsKaiqa9KzSULZ0nekJ+kRM+U8d
         ZPtJtbchmJE3achtk1bz8f5u/APWbne0mNlivJK7xgdPxeQUX0O5AzClqt+OqgmNRZ9/
         WbKyl6yEImqeRzAKpHXGjlBoN00N5BLeR6vO+De59gLS/6EpDA0zmXT/Fnb+F3bf1nmd
         MPQw==
X-Forwarded-Encrypted: i=1; AKwUvBzxrvan/uorYQjQ/zdYmYwTW5KwX+N+Fnvc0mMhKaNPVscy21pXhZiHc4qQ3EbPq8ORreG3G5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s3MCdqGiOxNlBylujoY8p4UpYNathebXIMbI5jPC7b4OIzW3L
	TKDJ3Bb7RgqrFWPl3RJ7MMYHQj4IMEAAWsby+crkWYu/cdP1y2y8pxpY
X-Gm-Gg: AYBFou3xJrYWghFpaX6JG3XZdOLqOPu7vHFp0eYa3uUW8N24m3Tj/SDAwjzDfdhWFow
	XUR0Rd9yX5smRkEFI5Z02t2SfeaSN1Y0cbskqnvzldjYH4XFOiSDzIlBo5FzkbfMWibbwmurCeT
	mQXnz7r6mXCOpeqiBi9J+BiICrvYikTSK/qa3gat6azbuAAvFlHJoPeQJrFZUjo+Bc2NbFEujzh
	UbOI0gKGR40VHqIo0eNj0rjQFIKl5J+UfDeLAf33g183UyI+SOFz3zw9A5d3TopvKlNXFeUpjBT
	nC74I8kemxrTHDhh28YqRwyM9lBmIYS0eiQjVRHnPNvL3eqbYkWtj3DXzpTO5JqSVwBMNCHoZGh
	utoP7ZTR4cBnas/iD0uhDUOUjuG/WFTO0yRFdfodtCOF8LLkDQPGzc+zgLGMU5jWY6t9QucEB1B
	+aL5M0xKB7zB+D2Gw4F3yW1WHmSsTrSK0kh+vl8qj+5f5qWrNK32C31NmW/a/dMqLUsT1KE92fP
	SXFBd2K4H/fSACP3/mUPtth9LfaxrZdLrBUx+l/bDPyTJIe7hPeBkSdHSsSTkoApUJ+NvaSVxHW
	/NznZa0ijTbfPO46USBkA23MfDBe8leeiOiRH9feZnzukONxqN0Lh6UerPev0RRINKdbVN5ZI5T
	I1hWuiZi7lqmWczOs
X-Received: by 2002:a05:600c:8b64:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4ac16fa21dcmr409378675e9.6.1793816674252;
        Wed, 04 Nov 2026 10:24:34 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f0237aesm3010995e9.9.2026.11.04.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:24:33 -0800 (PST)
Message-ID: <6aeb7861.6171b307.11ae12.6b94@mx.google.com>
X-Google-Original-Message-ID: <aut4XNrQlPIZ9q4y@Ansuel-XPS.>
Date: Wed, 4 Nov 2026 19:24:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 5/6] net: phy: mediatek: add calibration
 logic for AN7581
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-6-ansuelsmth@gmail.com>
 <2b744929-609b-4529-8b6b-30feb3ebbbde@lunn.ch>
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
In-Reply-To: <2b744929-609b-4529-8b6b-30feb3ebbbde@lunn.ch>

On Wed, Nov 04, 2026 at 04:47:09AM +0100, Andrew Lunn wrote:
> > +static int airoha_cal_cycle(struct phy_device *phydev, int devad,
> > +			    u32 regnum, u16 mask, u16 cal_val)
> > +{
> > +	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
> > +	struct phy_device *phydev_p0;
> > +	int ret;
> > +
> > +	phydev_p0 = shared->phydev_p0;
> > +
> > +	phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> > +
> > +	ret = mtk_cal_cycle_wait(phydev_p0);
> > +	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
> 
> What is the locking scheme here?
> 
> When using PHY packages, the typical usage is:
> 
> 	phy_lock_mdio_bus(phydev);
> 
> and then use
> 
> 	val = __phy_package_read(phydev, X, Y);
> 
> All the read/write helpers are __ indicating they assume the bus is
> locked.
> 
> Here you are doing something similar, accessing another PHY in the
> same package, but without locking. Is that safe?
> 

Hi Andrew, thanks a lot for the review tag.

It's safe in the measure that the worst is that link goes down during the
calibration... I will rework the function to assign the base address to the
default address for port 0 (it's hardcoded by the SoC) and use the lock and
read/write helper instead.

The main problem of using __phy_package_read is that I have to duplicate
the mtk_cal_cycle_wait function in the airoha-ge-soc.c as it would use
different helper... is it ok?

-- 
	Ansuel
