Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BA353A7D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845154; cv=none; b=hh81OBu3AmIHGxcy9ZDGePTmp6cGPxrW4/IitYSPCpaFgL0CQTztoXgxbZi4gJO4GOP8Dl+w1hu+FfCYrg5vly5OkJ4z6Tb6gk/DvE7tKQdRzfAUYg4Ni2pDLRrP58jsq8+Xii7DyxotlxNHz3H4ubRYeBraYi/2CPOztY5g4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845154; c=relaxed/simple;
	bh=x8m6O+VGBf2mh+d9UTHXImpGsH4/EOQxuIFX8xSzjGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4p1pdeNzj3I/foDJJStLSRtFfVwRLVdcuO+ZIXkwaKp28GCPDz8oHPaY+4enPEGXGZfEZ0ExooMUo3ke/ho24DCTHNGWJMuLN06t4ny3kbmMEx9tR7baYXu65KqMjNIq9Z6eQjhQxYZL0LDXo3TnSa6g7O4u93qCMTdFLW9AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nz5k+qoD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz5k+qoD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9004f39d3so51227585ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845152; x=1789449952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAp8mTkH9nPCXUPKfddbuA6JymE/Gu0j627y3YqdlVI=;
        b=nz5k+qoDxmhy+uL4z07k6tY8ULwpn0SIVgQGuoqotUPz7lNawW65mqwBEEY5RTwky9
         x38XVYDHA6B/k6ElAZEGnyiVsRV9y5KTiQ1QqiNVUVVDpnZj1vrBQ+C5FVv5a9kwOS63
         Z4uXouxjPeOeYZq1+pIhFkjmhRPa2mRgju92tFU0uJs7LfC4kJQTR9k76w3SM0W0Bojm
         Ta2VcSKObXzeOXsf1SkondzhEWfiUr5Rm+EeJRYtY52eA8SiXJgck6uYWVTQumhrmAS4
         9V7nbWV3ZkTvYDLN3R5KsIcd31vpdZJSe7QowHbmj948xmuxQ6M7oFwREPtzor/bSQdy
         l6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845152; x=1789449952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAp8mTkH9nPCXUPKfddbuA6JymE/Gu0j627y3YqdlVI=;
        b=U0T45x5ZdzlOfGmDjlNghSG0wEQr0L3P+2Mv1kkK/U3ZdQHbaJshVbNWRj6rODsx15
         QH7FixWwqs3uAEd4rCQU/iYjMT6fhy2D1DIHrJPf6NQULXtD68O5qANen3Hj7uT5/ZHg
         d6xDDCD1eMYBv6MA8O5LnwSLdPkqleGEuB1recxRd6V4cGamgs0egk9leCC6U0VaAm6R
         MnCoSynV7aR0jhhhjTthmmEmnbnLgQHd54itYyh1jkk+xX9p9PEWmp/1JJpW9TK+e6l/
         K/lu0M+Y5pipXUYv+pe9bZoctZOvFJuuUhDey7Akncwdq07pDdDJOxthvp3J6Selpueb
         qArg==
X-Forwarded-Encrypted: i=1; AKwUvBz/sPrOb38DDXj+ToCU8AVvC7UCdB4P4bosyRYlcbfuuAtCfhTJ/CUH4zkJGiYFVKnRvt8O2qg=@vger.kernel.org
X-Gm-Message-State: AFuF++nqGYfCEz8kEHy8LA4ewMXaBs+07ZuCJqMZI+ys2C/38/WdycNc
	cJDTEHW0beiFLnIj/dKoTAG8iIzoVSDpYZIcFp0VjOwjGyli3U8edYiK
X-Gm-Gg: AYBFou14giRRm2LBU1OLh9m0KNJ4vVQudW9oABrUvmP8aVARVqYbrvCIcJKtUvNsliO
	/FcmpC4//Sf0CVatJ8RhA9x9FD0P5azX0kL89H0kMk8K+dLUzWhffUKCUPCjstGeLLnCsvrrjhT
	EeUGR2JCtQ5q+eoCEt88U+erKwv73PBAhgJjRdmkcSCd8h5bHLInGm8AV/mUuosTXL5+2YCxjlv
	euy5EC175A2x/YGLTylWWupqH0sUGB/xqwYO/dT3GaaFOdh3QlfsYHrKagnv4tsD0RjiOhVFeJ2
	62neSryKOOF5duwaiimJzQ8dAP+fwdfHvtNsnNb44OynFdCtgzP0JlEWG4ZWfWdE4BdOUn5PG0D
	jkm//Wwj+vvkyu6XY/F2L3p1e3rRZtY4qMiDln5IbqB0OriP/Lt/RWSIG5lsLAqn/v0DGgPteem
	56J3Xdh1WCjcDglU54kT6BeS6x99pDytEicGnqIA6RHNaj9mOXipVVGbsBBxxHkfEh7pGx/E+1o
	WsJtrXbNk43RR4/ImDRRfrJ
X-Received: by 2002:a17:90b:1b44:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39b2613249fmr36702489a91.8.1788845152391;
        Mon, 07 Sep 2026 22:25:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm30022861c88.14.2026.09.07.22.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:25:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/6] net: usb: fix repeated words in log messages
Date: Tue,  8 Sep 2026 10:55:44 +0530
Message-ID: <20260908052544.27165-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7c8cb3f3-8eab-494b-9f97-b30693a361eb@lunn.ch>
References: <7c8cb3f3-8eab-494b-9f97-b30693a361eb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 02:49:32PM +0200, Andrew Lunn wrote:
> The same thing twice. Same capitalisation. Is one could actually be
> correct. Please see if you can find the data sheet for this device and
> see if it gives any clues.

I could not get hold of the ASIX data sheet itself, so this is from the
register definitions in the driver rather than from the vendor document.

The register is named in asix.h:

  /* AX88772 & AX88178 Medium Mode Register */

and it is written by AX_CMD_WRITE_MEDIUM_MODE (0x1b).  So the register
is the "Medium Mode" register, and neither word is a stray duplicate of
the other: the message is naming the register and then repeating "mode"
for it.

The sibling read function words it the way I would expect:

  netdev_err(dev->net, "Error reading Medium Status register: %02x\n", ret);

which names the register and stops there.

The other thing that pushed me towards it being redundant is what the
value actually is:

  int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm)
  ...
  netdev_err(dev->net, "Failed to write Medium Mode mode to 0x%04x: %02x\n",
             mode, ret);

The 0x%04x is 'mode', the value being written, not an address.  So the
sentence is "failed to write the Medium Mode to <value>", and the second
"mode" has nothing left to refer to.

The same string is in u-boot's copy of the driver, but that was copied
from Linux, so it is not independent confirmation.

If you would rather not take my reading of it without the data sheet, I
am happy to just drop this one.  Otherwise I will resend it as-is in a
later batch of the split series; it is not in the batch I am sending
now.

Thanks,
Hemanth
