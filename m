Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDE52FE4F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071992; cv=pass; b=WPp0LJhTIPvG9ZAgAbdp0AdkmtCFZYK72uJQJglIkJF24QarJCCrZPuxNvUachIWLW0TSQuKBENAZujOaHINAS+edzLoQn6aYfWfvfIYxibLQfs4XkVS6hPV5j6F9kotB8vr1/QE1gnswOGbcA9G5ccDHisFwHRsilf8eHx8PRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071992; c=relaxed/simple;
	bh=UWyw6GenqzB0Wv/KjUzt8dv4Hf93e69h31+KA7jwNuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBb37jbVhl7jOmHhjZFE8Onhzm9Pspa3QWtX0a5jVf28/86YhK2RxtRWpu1CF2t9PeK4KBD/uh2sYz0iHlQU2rrBmRf7nBuWpk+/hXz5xBksrhXjnlyNez/unu0CiWs0Mp/l1ilIGabfBjsDJC7drfxL/gv/zo/XeMglNUrGuL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIsGQHnE; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIsGQHnE"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c9e33d3f52so465047e0c.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790071989; cv=none;
        d=google.com; s=arc-20260327;
        b=R3uocQqKl/wr9HCvzlA+w2Nt8R1jtE8bCJHvwB1WjwzBFSYfAJg6hf5e9ll1G96P7q
         e91seMWNjQ18O2d9xCMYWBX0Kmg+vvw7pYlFDrjTsa0YGF4D4fB3FfazQEjIIz171jJQ
         SARFXzvWT2rP7m3F/SgqVt8+tTnhgCYacO0CfYswJIbw1eFH+a3H3waENy2LDCsRjYgy
         8m9aJux/Dxs0xuQONzPtoWF9KzuOwcVEWvs+Hf/Qo0SXi8s2ZoIRX8fYK+RQgC4BN+qX
         iyEhleocEfDuZLAaobsp0tnkEsGB/qA7GgN3+nnECiMcU5OA//KT7OJ5KVhxNIqoi3tn
         /vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWyw6GenqzB0Wv/KjUzt8dv4Hf93e69h31+KA7jwNuM=;
        fh=5guRD4/3Bvg/l7Lp28YngnRkVWZFohUU5S0p2hw/IZ4=;
        b=HwLBbdHzK3hQPz7S3gBHCqSxgCw5BXkrKzu8s02xC7pDmtxc5shb8Z+HTW+iFzX53C
         BKRSIUySx11wBum5bDzJN+9VgPSM2kPd02Ko/AbtE3tlh2ugKRnzYx62aYZFplrBCmWD
         Zc8C+KShhddmBnQUWGNqeuJjXN6yc/C4tO0N/1w+WwKGChNXUFA8ivcI14JhbxlhNAyK
         nrLgGQATT/0zD68SCVeEqraoTkaUbO+6hCEJfBs62nu5C6diNC6KbmptT5B0RM4/NIkO
         UjmgApBM2iXFIVOWGhU1VZ/5fXDWBTq+ceNMSdPLVMkoCVVJn+lVKsku16sz4lGGEQUp
         O1jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790071989; x=1790676789; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWyw6GenqzB0Wv/KjUzt8dv4Hf93e69h31+KA7jwNuM=;
        b=XIsGQHnE1pPlKZKqZgo4ilQtUMe4Cj3c5voawIYa1Z8Bh3WzEN1H8/7GoChObEaZVW
         G4RZsHUbNEH+/yAoJ7SB1VFNsbEl7hplQzwO7i9tjnKmCTWCkXOsYksFfyyQCD/H4koF
         w8utch5ZpXHMzcSx7/UDCPTrouFxQenf5hPqXLJKYjNyhbG3NQv06eHCSM9klgCX2oY+
         21WnEIAk9gzxld6HlD24HeKtJaShfpUtWoIrT1JiOWZE/mIulzWtk9Kxc/sg2/ThOs6k
         J2H/HmSbyhu8QUlqqZrhwM/opShTb785AFnOI0kiOp1Ko+gc4+J/nvtin+4EgKnZ2Ayb
         fdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790071989; x=1790676789;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWyw6GenqzB0Wv/KjUzt8dv4Hf93e69h31+KA7jwNuM=;
        b=CGi/xAgtSwiWEq+jtAVi6wlxgR4xHOnEUl0qgXxQzXx4jnD5bKxMnGgBGLhYcML9+P
         pE4Iai5u2LDpPkUTV0x3a3CinwpXdNThP0fdzzgA5+5ob7WhlWZpLlC4amXAlwxIsAZr
         fB02Gx1vK+8k6z4+loUD2hkg9GPgRIN1sCKGZ/s+y3yYwAHk49kTTEgjsZy32aYTh1Nt
         NydXde3JdXdi3Y0r8QkWdfR16271/HpbwWzUg0yAWNplscOnshsnUpgxegc74aGQZaKy
         u5kCo9ZWwjURSwTT4l8GvaHGJTnmifDIAxuZnvYfXtutRqihTxLAH1P94z1Q6YXi94P8
         itpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfuSqTxD2HbssDlnTRVbLBAFqmKDvM+4TD2fpjQne45MMqDqP9sxpQKXGkIIudnSW+75mTsR0=@vger.kernel.org
X-Gm-Message-State: AFuF++nX6whTWOVWi2gLtUx4husNz3gb3yG7uo5rtkgNB3CyRRc8uunW
	eb0t2HAt9FE5gDoLZhweGpmY2ryO+pKsQctcg5abaKD/uavYVtuwed2cu6fK9T+EG//Bx+6v1vw
	R3+TusPqDZYBhh1YZOWCys6KrvQq/b0M=
X-Gm-Gg: AYBFou3S12cxG39wGWq0TPSwZ9YAB/bUNAG/Kp9E444NWlgmTvsJAN/m9MTsn00DD6l
	LAT+11L3GJUnRo5wgVKq6mJwAb2HpSlNaPt+jstGduahy8WIchXPaFfnrBXAkO18PCM12TsBVa0
	zr6VODb4j5oq3Qd4BUzlaBO/I58KrgW+cfjY8vfaasBSKhY0iklOgUgscnZ3ZTVPXliFRaTMS8U
	ltVQPTY33olSN4Juf+IuKCP36d9+fHd+E071mfio84ggVBwG6Xw8qbXIbPEHuxKQiiGIxgjvdVr
	mh7KcUDmufBP/yDESpGMtUxvewjjgOUWpVZeiIFM5VTUB5J1+0Dl7A==
X-Received: by 2002:a05:6122:2b8a:b0:5c9:9f03:cb07 with SMTP id
 71dfb90a1353d-5c9e343983fmr1483343e0c.2.1790071988975; Tue, 22 Sep 2026
 03:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916235200.20712-1-ansuelsmth@gmail.com> <20260921135933.7e8857ba@kernel.org>
In-Reply-To: <20260921135933.7e8857ba@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 22 Sep 2026 12:12:56 +0200
X-Gm-Features: AcwNN1XO-IQtQQeBFy8m7z0RqgCFyAn_vcQf_nLSSDZxar5hmkBbTIMafTrhl4Q
Message-ID: <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for fwnode PCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 21 set 2026 alle ore 22:59 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Thu, 17 Sep 2026 01:51:26 +0200 Christian Marangi wrote:
> > This series introduce a most awaited feature that is correctly
> > provide PCS with fwnode without having to use specific export symbol
> > and additional handling of PCS in phylink.
> >
> > At times there were 2 different implementation (this and the one
> > from Sean) but Sean agreed that this can be picked and used in favor
> > of his implementation as long as his case with race condition is
> > correctly handled.
>
> Looks like the review for one of the patches failed so it won't be
> emailed out:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916235200.20712-2-ansuelsmth@gmail.com
>
> Are all of the issues invalid?

Only one is relevant, but expected.

The remark on the fwnode patch are invalid. The driver is expected
to return those error as probe defer is not supported.
(a notifier and late attach/detach is used to align to phylink logic)

For the specific Airoha PCS driver it's really speculation from the AI
but HW doesn't work as described by AI.

The only real comment that is valid is about the alternative way
to give supported interface with the .get_capabilites OP.

This is currently not supported as there isn't any user and it will
be implemented as soon as there will be one. It's really to limit
the patch delta of this change and to progress further.

Maybe FIXME might be suitable?

>
> Once the AI review is cleared, some human will have to review this
> and vouch for you as a maintainer. Better still be your co-maintainer.

I think some revision ago there was Andrew that reviewed some code.
Anyway thank a lot for checking this once in a while, I feel it's a pretty
important change but I understand it's complex to handle as it does
introduce a whole new subsystem.
