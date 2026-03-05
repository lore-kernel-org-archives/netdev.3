Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8339F191
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714242; cv=none; b=dQegcm79BVsd3Ku7mpe5i7t8AMS1ri51zUZV3v7Hr/Jcyn3Oq43QpwhV2Y4Z+z2mLYeovpdkdlJkpWQstM2W3gjdiAcTPXiUrzV9Ij1YD+cmm2Ad96rJcHyMFSIO+v8JDYsOyg4PLOouwcrGqZHpZWvw5oPAg4G26XTTu8wNuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714242; c=relaxed/simple;
	bh=zK+446LDzPKbS1TYOd0boRw6wGRDmBJB8kXPGNrJ480=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUHJtHmYQZnF03hlrG6LheszWgwquljq4XQ5fUSZuTDsEW2mswX5HFlCDL2vPaezCa0TmuL6AmvQJ1o3q6v4BahDxp/v/u8D4GrhAqc1FngAb2ksmes+EeFWkJe9+tM8thpnVZb1vyDv56Bnq2d/JvtC7yLFXfRpk3AzSqxiNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE/oG3/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE/oG3/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4498C2BC9E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714241;
	bh=zK+446LDzPKbS1TYOd0boRw6wGRDmBJB8kXPGNrJ480=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XE/oG3/fMyPC3dW46N0Z6COw7jDlwhWm+GJanQi+adrIFfFNyHc39CfQrqnCefxtm
	 sYZn6hMSv0Ff2etR0wj4r3tHBGh/kH9vrVCixgku+Ze4dHMsTDjotaVDcPFc9EhlHH
	 ghzVdd2xT4n0eZaL0tlRgu2h4AMFRM/C4BxIniM/D7HNhLl+SVo6VahiZ/96Mk24AA
	 7Poe7m+rb5C6qRrsyhhPS+dxmeGuK9UYBpAfV4Sf729Xefg+LroM6hTAQ0G63HsUgl
	 9u3530Lj8ayd1Wa4hF8WCkgdDR+n5+Bu4iPmGONaAXZBMX1pa9zNknbxVqWDVtg1cS
	 EipGiNitPiCPg==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9ebd1369so7269554d50.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:37:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlHv4Rtb3oX6r9ULIjbIhsG8tIJPm635V1kLKaaeydQ9zEIhaH16AOOjUf3vSUtuWOuNfGJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoVnoEebKzT/u+PcdiHd8hgVdenChIRmT337IL17geddz/yCi
	ed7vCEi9LdTAh5o+1pDxwUMpiNVOFfqYTqpRr7wd/38+Bos8wrZZPpAQcRQNCut9GjHaOa8Mh6g
	I7lwU12Sa/lQ8LELComH6x2iTM/H+CE8=
X-Received: by 2002:a05:690e:d5a:b0:64c:a444:cdf8 with SMTP id
 956f58d0204a3-64cf9c03d27mr3817433d50.80.1772714241059; Thu, 05 Mar 2026
 04:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1777BBA64A3D0F97+20260304105215.536399-1-xujialu@vimux.org>
 <20260304110740.548318-1-xujialu@vimux.org> <207C7323BD49963E+20260304110740.548318-2-xujialu@vimux.org>
In-Reply-To: <207C7323BD49963E+20260304110740.548318-2-xujialu@vimux.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:37:09 +0100
X-Gmail-Original-Message-ID: <CAD++jLkBoxh__rGRPL9FxL=RwS+u0zc43g+fZ88A_3JTwWjE-g@mail.gmail.com>
X-Gm-Features: AaiRm51iErocZl0LI2WlTbYoLtXaDMz1NvGtoi9VStjEGGI_xqTJhO7UOAKsNgo
Message-ID: <CAD++jLkBoxh__rGRPL9FxL=RwS+u0zc43g+fZ88A_3JTwWjE-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] nfc: nfcmrvl: convert to gpio descriptors
To: Jialu Xu <xujialu@vimux.org>
Cc: brgl@kernel.org, kees@kernel.org, krzk@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:08=E2=80=AFPM Jialu Xu <xujialu@vimux.org> wrote:

> Use <linux/gpio/consumer.h> instead of <linux/of_gpio.h>.

Add some more explanation, mention that the rename is
already in gpiolib-of.c and add your Signed-off-by.

With those changes:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
