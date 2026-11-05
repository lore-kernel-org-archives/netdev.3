Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837222;
	b=cneIKutjDMRS04qdqFRCsjQhK1jM2SxzOCi5+F2ahWxr2RC+P9eDFnD+0ylwh9VjMCeu
	 C7xibXyJNd9gPsMkZi8XpM0iwde9RoduoPDY3x6McV9/HkREiwEJakwcYq51zpCbuyEXB
	 x3K1A6h1hCR6uk9jqIxDJTkKQgieZfjdPjlBnR4VEH9efp06K/XIatnMxkPtG7urv+6mx
	 qTsd+8K0SCobgxdnOCNPrvmqSYXd4iwqqzZ7JePfkSGkIoDM2Ou8KtlZAb0lvcmSQEnI+
	 0ivU0SpsU6V1kglgTL7/sBFXJj294uaezNLjwuYXAHonxK1i1pGSbOzszZUGkc1Yb+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d1p/rD6sTNhuzYzSDYOdeVCwAUdWvLdNAWonA3aBGkk=;
	b=xeU+CDhqOtdTt2Kvju1jO7nMC/7yidJRwXAHj3zWQToYLq8vbEkVHwkrPPLcjN5bOho7
	 +GQ2KNTPZa7OUZfoBYlNPOd3Ytapj1GZXn3CnUBtx6DxADBhtWGjDEej0/zbriAY0YoNL
	 bJxMenwF5cg/LYEAodazpa6jona4AzEZgiSup4mQBbXSenFE5Tk+Mca+S3EiG1tw0yAqM
	 44bjN52qR4tYCTJBel5+aIH5CExwLhcVKWeQbFeA9f91Eh4m2ka1wDtUHvhfCB85vZsCU
	 Ndwm4kfQFdu/ScqvSyi3RlD4SL+XzD1jKRXxt2rKe7E/A4Nimy+zP02pNgKCI9Egd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBSvJJA7;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA6606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 00:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BA6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBSvJJA7
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so8038255e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837220; x=1794442020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1p/rD6sTNhuzYzSDYOdeVCwAUdWvLdNAWonA3aBGkk=;
        b=HBSvJJA7LE1rpkWl3EQlaKPvM+vmsGVv4Eo/eNaB2C5Xa3ZmFurERa2waV1z3Rbofm
         BR54o4qXWgVU/Uqgpqru+uLVcm3iOhXeNvXXl6miESzC69Hprt7lgxQrIA6l3IJXtdmr
         2shcTnrsIEJJ6eqk9cUzOnWCC4Iuc6JTudDOVnyC2F3RMHNmYirpvZ7A/KlY+DZEXSjP
         GANFegY6laUwc9iKd+9K51CNwHJI2ZqjiWRy4T0ThK6yfkyr6hUtL/EX1EETTGs0n3BB
         Rjc1jA3RNJzRMFvsx4+2X0PepDc02WblQAmfKJBhea+ceuJAjXsNnJJlvNmCHAcKGJHh
         WYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837220; x=1794442020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1p/rD6sTNhuzYzSDYOdeVCwAUdWvLdNAWonA3aBGkk=;
        b=IBtpNutqj30JjZMngLUv/a6+ah8YuBNLp5LfywTspvK75bm90JCzAymlRq0zLr5LF/
         LWZ+t5kDDy6KBa+dhm6zQB4AfoVq/C5T2bIYFrox7GX5oX48cE3asV+9RgFDGqECiRM4
         OiER0PmhxtZ89GUXEmt2OLBvcxq/UCKCYbHVSsNRTe3vvUTng0Pc+hSsArRDa3dycRdK
         Y4DzKFYepafPLNeDQ/BVrrTaDPBHc9fvBIvfsq9iKNTymitecdWteqqtsg0EjGa5r4qN
         2urRZNoAaQ4aDGuw9cvtLnmYuSMUfj3hXgc9DgP7raxjv4AItEr9JVqk0eniYtFL36Qf
         W/lQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrWXoeJAvz4zUc0iSQ737FQpW6gyq0eAYsMXSH9x3le01g7XO0doHFpgoprpUjPuAj8eMcecY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kE/x1LSlcsScj5RlPYjAKxTpj0wxvpcoZMOppqy0/aptC1mnp
	FBRf5QDQtcmNymT+iYL0m5YvwFHsadDGI2tz8gvfiD+nL/CoW7+C1AC7
X-Gm-Gg: AYBFou0Ec64H5inpu36gNXOqVG91ic1lxGG2evAto7HXRMh3Y3STbl7OWjEWXtrlI/K
	DOsvtlkmyqSM8RC7odLDJxRx784hzoejok18O2Sa87QsfZZ/3v8vmdJX9IJieZOKPt9pdySjgdx
	6WZRF6VZ2SsaIL3Ov6iLbWBnGaJYIkKw/vvPtIDE18gK7gbC5OZdvq8+fHDVpo/0ATH/5ur4IiU
	W8i+sj8GR3sYEps2nWq+qgrdWwsiy9mySWheVCxD1qGSSaMIw1qWYusdE8hRgEExYhPeYWfpMVH
	xNznKdBVNJOuVuQ02rJap9BRJTv2DPKJInNRJAeVkY76d3ct0LAhF86DxikuGi4hYmw96nvk6td
	yNKYgShmhOSNjUMmYSBkLJmDxcjRIf49opt6ykFHq7T9Sj4a635N8bZ1MyH6pTkep+GiPTvALzu
	C7jgPUrgnA8d1Mn7Lx9zOHjzB9j0mJ/5tAtyton32OWoKobtnlBd88rW+VDqLytgmRjnBsCFoFG
	Ch4X5+Wg3OZ6efWOMcsWJSNnZ8/Vg/+qajTFo34DsCVqtjb1vVin1P4dPbsSnormXj/M0NehYvi
	uRNlY+LyR/CZD/HuGk7N8EpM8pkdRG8/nPKn5QHbLGFr8m6+i5haEqRxps0JgXSpv7PadjqxxmY
	BtNLdmOmUgrE1gIRrrfA=
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4ac17470f97mr398502555e9.10.1793837220243;
        Wed, 04 Nov 2026 16:07:00 -0800 (PST)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725061e1sm21403745e9.7.2026.11.04.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:06:59 -0800 (PST)
From: Stefano Munari <stefanomunari.sm@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	stefanomunari.sm@gmail.com
Subject: Re: [PATCH net] net: usb: lan78xx: resume phylink on non-reset USB resume
Date: Thu,  5 Nov 2026 01:06:39 +0100
Message-ID: <20261105000639.7070-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179375001506.488856.4516083483989818643@kernel.org>
References: <179375001506.488856.4516083483989818643@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 03 Nov 2026 23:53:35 +0000, Sashiko wrote:
> - [Medium] RTNL self-deadlock.

An open interface holds an autopm reference, so this requires a runtime
resume with a *stale* EVENT_DEV_OPEN, i.e., a failed lan78xx_open().
This error path is fixed separately, moved to net-next per Andrew's review
since the failure is considered theoretical:

https://lore.kernel.org/netdev/20261102211119.8738-1-stefanomunari.sm@gmail.com
https://lore.kernel.org/netdev/1449a6a1-670c-4d1d-bb98-51f92e32d848@lunn.ch

On system resume lan78xx_resume() is not called with RTNL held, so
taking rtnl_lock() is safe there.

> - [Medium] Self-hang caused by re-entering runtime PM from inside the
>   USB resume callback.

Same precondition as above. The hang needs lan78xx_resume() to run
inside a runtime resume, with the interface still RPM_SUSPENDED. An
open interface holds an autopm reference, so its runtime PM status stays
RPM_ACTIVE across system sleep. On system resume the nested
usb_autopm_get_interface() from the MDIO accessors therefore only bumps
the usage count and returns immediately.

> - [Medium] On a normal (non-reset) resume, phylink is now restarted
>   after the MAC datapaths are already enabled.

Pre-existing on the reset_resume path, can be a follow-up.

> - [High] This problem wasn't introduced by this patch, but
>   lan78xx_suspend() inverts the lock order.

Pre-existing, can be a follow-up. An actual deadlock needs a
non-freezable RTNL holder opening or closing this interface during
system suspend: very unlikely in practice. In the commit message,
"mirroring lan78xx_suspend()" refers only to the dev_open condition.

Stefano
