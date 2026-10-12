Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0B2BD09
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797509; cv=none; b=ZbHF2KM8DjpRtbBqhBDqV0NIHf/wkM9ZiV2cgwWbm3iU6DlMANs0NKzy8xsfOnDgvG3gt6YKVTN3cczIfXFKfDaoHSe41hM7uQqA6UKRvTEYvdhcx5g0F5l41ZQzWgSNJpJvzQnpo6lSAdzpVEOzH/QqRwK+flLH3Q/5OavDhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797509; c=relaxed/simple;
	bh=7d+W8JcOuTnss765s5W03emeZFctX4CPjHCVsfnVPQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMamJDiAVceCeC5PT6T3AOCWzSB/Wm5MAHIEXoQ+Lxrji5GQJsG5YlfTJR9CcuFkEnH1qiEUjHOgs/Y6RRTgfTaZIV1qxVx94nB/NjNFaBZp18MVzVZNiQgczq0/xu7qD6gVcgnQ03fpHo9JKWybRVsNpMygYXaZ+LHZiVRb6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngriNN4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngriNN4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4352F1F0089D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791797507;
	bh=7d+W8JcOuTnss765s5W03emeZFctX4CPjHCVsfnVPQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ngriNN4RLU9FX8a655ahE78vNrb14uR8AGryXOpdmh6hOuaMcNan6THx6zRWpyMoS
	 Cv5MITcTF8xf/CWhluQxKCeASMqT1HrWpgr9l6C5Cr82xLFCpdbiPSuCrdRsG8y6hB
	 il4/FDm7+JwFDE/dy1UE/Zli9A7OJ8v/KyNLpTOOelIfteMiMtanK4pJBE8Z3ivvev
	 hU/qsnsjZWFovXZTOAdRCK9CVYpGYpBdnuLRaPWD8xJwzQaFG+JvvPKa2XGE6E5bBj
	 7zsGIln5UlMIrQtCBz9X1R4BhPUC4+e8ZeBS/vW773n2boBXDdUOE8RAwcBgZYW/v6
	 jcoTtRVe+be9g==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso12258701fa.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:31:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcV9vNI80uBDTiNXF79hd4a6ULBv2DMX8+vjcQVrXa+OGOhSj5TDsw8Br9Gfi2te5jbFxnOLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHCKrCYEENxhlZgxXuRt/j+6EarfuA+FNjSXcm7HD2OWuTyl3x
	L81j49ZIsttjc/VrqhVMs1zI9YIbKRRuoNVrgY5q7GamJUthG9ZT2KYQdwymGn81Ra9N1GwZaw7
	KVKn3s5P24CZubBT1A2LJBm4zJVn3NDo=
X-Received: by 2002:a2e:a9a3:0:b0:3a6:5993:c976 with SMTP id
 38308e7fff4ca-3a9c514fd30mr20214681fa.6.1791797505811; Mon, 12 Oct 2026
 02:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com> <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
In-Reply-To: <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 12 Oct 2026 11:31:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLmzfFW4d9onNw4iD7SDc7hY-Px3YwFqFgo1LmLv7qscXQ@mail.gmail.com>
X-Gm-Features: AclHuK9yvP7hkoo691nQns0lXY5nu7PEOfpJpeZtM3PjduiUHsbehs1kfnqV10U
Message-ID: <CAD++jLmzfFW4d9onNw4iD7SDc7hY-Px3YwFqFgo1LmLv7qscXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/9] dt-bindings: net: dsa: realtek: add RTL8367S-V
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:09=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
> with the changes that follow in this series. It is identified by its
> chip ID register, so it does not need a compatible string of its own.
> List it under realtek,rtl8365mb.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
