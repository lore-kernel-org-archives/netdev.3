Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5274EE87B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452809; cv=none; b=UEL0WVbQGRw5vKb5Eg7xOfQGJGncmSAGZdHH/wyDcgIQbTCt48H/dJC/I1chn98cxAyhrFuCt3d3/KYF5NWdW2t4Dg5gDkcThDUQ5ODDIq3BRYy32aK8Mcx96aaNRvXFnt91PfZTdps8uXuaIlk/Aa8GrlUs6bdIKI4BhOZGl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452809; c=relaxed/simple;
	bh=nOO/E6lZobnxas+CjEmlQQqFvaYHZtCUk+zEXJi39rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZy8LiYNHPsE7IN7Vg30ECjqo6KNxsOu/Gp+UgE5tLr9SYWIQPCpoPh+Dwallm3vJaLGgX08PSE/K1i3/Rmg/5d8j23UWkgYrQQLuUCC+cEvK31DpLIWxgDFqNsff8+3xm3gejdeCdhvbvYKajWmSU+QdTzBL6igjWAGAZz7XZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0RL6Tbd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0RL6Tbd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49987367394so52965e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452805; x=1789057605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Naf/s4dAV3WmHAfnOCKQz+YEIomyzUmgkSw+k6SbsTg=;
        b=e0RL6TbdWqMV7jJ0hskdOfI4JYNw43vDNCpkik9dmM6xYdgcQOudJoIDNDtein+si2
         ssVuSGXP7ivsIcJJUikSfShas1g81y2/QmXwit+hUi2WM0QTNBH3pZ/ipxyIAzLlLYt+
         awyEzJ6ldWKHfgpyCjYPskmXwnXU1XS5k2p67ZmkmO8hCOTRuYTiGir8x8+CfTbutHfS
         YV4gjCuWTkE9UXZtH6Iw3STi5JiHcn3evzE4y6wJ5CaO4PZCqkBKUzcJ30Bj12xcewc6
         36PCNZvIUcnVEcQdtnXbPPmIOEJPTgNmVQNWaNh3qvbzSp4JGTrWiXhhr/nvICYCGd5/
         kh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452805; x=1789057605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Naf/s4dAV3WmHAfnOCKQz+YEIomyzUmgkSw+k6SbsTg=;
        b=aFHRwnTBReg5/enQSkz8tKF+REEgG8mDbvUwRVT7M0WPIOEnOmz9GnGqTkagwA0gOa
         OzSzatbnk2wM38HlZp71d1HS2nlrsm27YNyStnTbBmXgCxl7fM2wwCFAsPt2gMWcZNso
         HvQLzavUvKnClCcvd3pgqrkgtGt91i3rvDXHE0FOzbTfjSkIr+VHg+SnB9xge3SpLqUs
         ihLDqjdhOYxdmP31PrmG0D4LyWn3/cIeH0KNcHMT6yk965QfCNDS3i6PRUHv0UBIg3if
         y0rmwZJr3LYZh3M0M5kqnCYPL0hm94RGlS6cqfYV/A28We740caqfN4vt872NfjleZNW
         SwxA==
X-Forwarded-Encrypted: i=1; AKwUvByz7Ct0B9C2YRovipjMCsBa5WSX/KX2gugU21RDbQkLTuHJzs1vVDH03efS5ZFiE9ZtahSiDTU=@vger.kernel.org
X-Gm-Message-State: AFuF++kwwtPuypEPEZd/KLvtNLBYBmP/+IEilHKOGkLGdfNbLNsJnbtR
	MCMXVVGmJM0qKEzUrHBom/+VLRlijOIR3kxPa9wfzqDj2A2nfTY9uQyOEaYCAUmCXI5S+A==
X-Gm-Gg: AYBFou0hrKs5SR80I6bb+FC7kxz6rkqbtrmYz52h51iuxUo1DSMJHTSf6m9TwDHzZVF
	bmFVpEVswIwkobBDJXRjlTz73IT8F8lH3OE1SNjc6ul2Wj9wf1Hvp9+Sv5EMr4XNWp1xyVhRllR
	9oTJXNddWQgUMJb8yiTvi1OvTySsH2aTR8j0Vkpy/NgpM4XISaTSdcwrm5l+wYwCpOekYq//WTJ
	srl7gXG6XTgdWaYuSzS6lvMYY53CMDBe8yoKqnMDtutoyAxDKnDH1iKZGR6no27042fLwX2rT51
	fVpEazBWQ0/lVjmTr6yPDSpuJyqCXd2H0tjKpduYYUCNUgug3/nycTQ+3CV+OLsrKtck7hU5FH2
	+tyOOs/i5IJOymQ//jctRcqp6sYRXLyHZwNMCq2W7VWDf7bXDV2kAaiqZWoR0eL4sWsupzlkBy4
	N9RmNmIgB+Mz2dAgpb7xejXef+CFfgsITyF7pLyOkBM0A=
X-Received: by 2002:a05:600c:3b03:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49ce58252e3mr115661705e9.2.1788452804766;
        Thu, 03 Sep 2026 09:26:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dadddsm101965955e9.9.2026.09.03.09.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:44 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:06 +0100
Subject: [PATCH net-next v4 7/7] docs: netconsole: document local_ip
 auto-selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-netcons_ipv6-v4-7-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

An unset local_ip is auto-populated from the egress interface at enable
time, but any value the user writes, including 0.0.0.0, is used as-is.
This deviates from the behavior prior to "netconsole: use the address
family instead of the ipv6 flag", which interpreted 0.0.0.0 as unset.

Document this so the distinction between "unset" and "set to 0.0.0.0" is
clear.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 Documentation/networking/netconsole.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 4ab5d7b05cf1..694bca4803d5 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -141,6 +141,11 @@ The interface exposes these parameters of a netconsole target to userspace:
 	transmit_errors	Number of packet send errors		(read-only)
 	=============== =================================       ============
 
+local_ip is optional: if it is left unset, netconsole derives a source
+address from the egress interface when the target is enabled. Writing any
+value to it, including 0.0.0.0, uses that value verbatim and disables the
+automatic selection.
+
 The "enabled" attribute is also used to control whether the parameters of
 a target can be updated or not -- you can modify the parameters of only
 disabled targets (i.e. if "enabled" is 0).

-- 
2.55.0

