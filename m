Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464B33B970
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072833; cv=none; b=Yw+A96GE+z9IHmQDxElcX84JGeDjTJQjVKRFlZxcaArnrSaaZJ99MjcYf/ihOCflLxx/xrS5W9l94mukRu8yewZP40BIt5CB14USmzDphy+kNYACZxBaYuHk4wybtRcE3V67PO/hUcQQJHcRzqNNLz8Dh/gd7BEsRC/H11gvfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072833; c=relaxed/simple;
	bh=0if5Vpt3XXvAloNmcCld7KE3eHxf1WWJcdyQ1Palp6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbWPZuI0iI3/83l3vTfKTwf5+l8+IcRHiK7S4VYPqxE3Ir/H7ZZUXDZcMDJk802hSSk8xaD+5LFYJUZgxhCQUj6nG06SxZ1NZyMVAicLc6oTGXSlVJpyKdRHmC6QVy8itFxSENBgnCmmGCFxUv9blkEp6Mhvp3o5P7+BGS8iirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX0vt7nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX0vt7nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D4D1F000FF
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789072832;
	bh=0if5Vpt3XXvAloNmcCld7KE3eHxf1WWJcdyQ1Palp6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HX0vt7ncrDsVDpY/0CoBvdL7E8vChA5IrUgs+gje+s47eZTuukxgEFIF/Xs419x0B
	 T4fYSNDKt8k+l1gE/qLLifjeqs+HYujVQzmFnRiCRwDesTpJx6o5KJNR2mNkWYPmF7
	 M6UvmFJgc59orDCLfLtTY7SzN5XDiR2K2dMTYL+yatDtPxudv54DE1a1CBHXz89W5n
	 B5BwGR46OoGTI4/nUmZGgcMAqZz04ZKrqRfUv+ay8SMVB8n3RoiDF3o909WbsPFDMv
	 2jgNLdXrUgzhaUEIADqTs9DyjqwBry0VWzXhvT/awnU1fxnaoHderz5AD5UqYJR129
	 yEJFVgzNfyjZA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so269682e87.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzCjejYFt7WztA+6+NBREStaqzeMjAzO35mIKecjEPeFWrVvG5LtutlrQ53lwtYtrgW13XCrYo=@vger.kernel.org
X-Gm-Message-State: AFuF++nzLkEyCGTunqg4kBPziqBBqGE1+VzG5qFjzz8t6WB8/5uWEGU0
	0AHnzlsItcgjMPe9CH3/Lkmw/tgCSh0vb52ut3Q/RED7LUXbmJwCXycG9gvEJpzCEGB0Z8X9t3D
	XdZelOmxKYF7ElW1wVfJLveG9zQ90I4c=
X-Received: by 2002:a05:6512:33d6:b0:5b0:113d:8ae5 with SMTP id
 2adb3069b0e04-5b8a02fa142mr416592e87.10.1789072831014; Thu, 10 Sep 2026
 13:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-ks8995-to-ksz8-v11-4-0e04411a559d@kernel.org> <178907052301.219967.24777314580254394@kernel.org>
In-Reply-To: <178907052301.219967.24777314580254394@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 10 Sep 2026 22:40:18 +0200
X-Gmail-Original-Message-ID: <CAD++jLmPio2ysuMK0mEW_VNr6=9fzJuucm7MRds6jXmct0NROA@mail.gmail.com>
X-Gm-Features: AcwNN1UavGKtdEVxh3ww2RwCsawuJzvB_CG854UT_B95GXaSk1BHOy9CGRQQqro
Message-ID: <CAD++jLmPio2ysuMK0mEW_VNr6=9fzJuucm7MRds6jXmct0NROA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 4/4] net: dsa: ks8995: Delete surplus driver
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi netdev-Sashiko,

On Thu, Sep 10, 2026 at 10:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:

> After this deletion, "micrel,ks8995", "micrel,ksz8795" and "micrel,ksz886=
4"
> are documented only in
> Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which was
> written for the driver being removed:

No.

You don't understand how device tree bindings work.

Device tree bindings are not written "for a driver".

Device tree bindings are written to describe hardware for any
operating system or other consumer.

The Linux driver happens to use two bindings and you are repeatedly
confused by this.

Yours,
Linus Walleij
