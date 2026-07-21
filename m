Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE6433BC8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620190; cv=none; b=q33rVjpy0XwxCOvGLpizCbnrW+HwdwsITAUXsud0I7OOjCBb1fOFTzNWPralGRbITfvINDkVWuc86t5yphI6qjTfqO1XBPpP1/ltq2kqNPSXketNEKdDgt2/2vGzrXSpPEqxhYBchQGid7VAeJFOTCLR6kZP/aJjuRYwFm8FCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620190; c=relaxed/simple;
	bh=YUdc1ajS9G7+JyBN4Vd0qdQ7XA8eh/Dl4R2Vtt/aRyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWwB8wGJM17ycu/ulIqXuYxOiBKhYsvjsiR4oyUR/9swzbMhDHWHhCy98oe8QPujKe+jIdpSoTIF2PRJzW2VjQJabCpat3Ybey70md7OeTqlRjqHA7BkCzlwFP/Q8ltBYmrpRdP+0BHPK+hcW6vDm+OapX+qz/4rI2giq8T112c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCIxwdak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCIxwdak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A591F00ACF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620189;
	bh=YUdc1ajS9G7+JyBN4Vd0qdQ7XA8eh/Dl4R2Vtt/aRyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fCIxwdakKOHlbIEvrOkZaMzRZ+jNwc3O70PBDHYMq6ssKGwaPrBT3QGuXYAjaR6cq
	 95qNW/QFvDgx6QCD/H9UstQsPwKmvruxK9GMzuk0sldFva3Kb2TD2oM6y8H2Zzy3yj
	 ItD1kOHL/PbiXiSt7z4NfRWT/jU0k0Dbti8JVVL/YONR6r+9hxS1htZ3PQZWaPdaV5
	 rtqpUBPybZucQqN4XbYP+kyH6vd5xw7L7D5w7XwyvhOQrrEWJqC8jEz3kG8+vi4qGw
	 oZHXUBq/g6Ze1oi3HwN/gUcrhrSzfSPhYTcU9/jSt0hCjcb8Tdz4c+WFwl9qP3/+NR
	 2itJC+U4AfXIQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so8436566e87.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr7d+tLhgYu3u4veat0ZWtAT4mKAhlAm3b3COetyT3qhOCqbAijrSDoMhlIlyyOZ5t+dq7r7vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLM+MxJhvtBpyidgS+P6P4Xbd8gYD0Qsfb1iGcYAq+f0PQuk1N
	xMDkOEX5a3S9uvrQSlMwEyuFgQEgHgDuL/r+Cc+qCLdOkWQ7Pq27hRhOfBdTzx57ZwjcqPeJFEW
	ipsbEU2+/V7ShZ1/pHUwSL1srlqI2K/4=
X-Received: by 2002:a05:6512:33d0:b0:5ae:d80f:c77c with SMTP id
 2adb3069b0e04-5b28f998d30mr4171034e87.30.1784620188475; Tue, 21 Jul 2026
 00:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721052859.171341-1-manikandan.m@microchip.com> <20260721052859.171341-7-manikandan.m@microchip.com>
In-Reply-To: <20260721052859.171341-7-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 21 Jul 2026 09:49:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLnvCaUaEm0m9w3CWcuahgt1VwpYC=JLTLp=O6J-y8wgZA@mail.gmail.com>
X-Gm-Features: AUfX_myUpn3DxB2dpHt182zW3JGQBje1oWK611TyiUzfnfgPlR68CEulMNYYBjE
Message-ID: <CAD++jLnvCaUaEm0m9w3CWcuahgt1VwpYC=JLTLp=O6J-y8wgZA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] ARM: dts: microchip: sama5d27_wlsom1: read MAC
 address from QSPI SFDP
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:30=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Describe the QSPI flash SFDP as an NVMEM provider with the
> microchip,sst26vf-sfdp-eui layout, which exposes the factory-programmed
> EUI-48 as a "mac-address" cell, and point macb0 at it through
> nvmem-cells. This yields a stable MAC address on boards where U-Boot does
> not program one, instead of falling back to a random address.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
