Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952D3D7A18
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669870; cv=pass; b=PbqacP2J/6ESK55FP8UCBCncPClAi7AcZLgE5TxEORHUd0T78Xn42DRFhiRKcVdrecEcK2xTTywZP2odZ1cohu4TgFE44Lh2waYZeJn69mwDBDY2ta5pSp/McTx1hZYbYE4S7F8XqDtvbW4C3w/vmdlF0NkqBA+XdLhE+Klcpko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669870; c=relaxed/simple;
	bh=138OEEzPVhW7R6poFclN2lrh07EbWFqx3lenQ5fTUck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYaGkLrR272uVqR1A0dIDIIm1hKNuJYHv36w1M1G0rimV93gTpJI3BGGNfahiNk3yFZLI/OLR4hIMTDrqbeFQv3hAq+IoeQN4B8zcRRX7bb3kUsoiPP1JH8r6pKt3ZLYqCMdfOnlId06ZaMMCr6xeiCxQyZ/Mq/QBaEv6Bdt2EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pP1HzVky; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP1HzVky"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1fso199051266b.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789669866; cv=none;
        d=google.com; s=arc-20260327;
        b=mZbTde/Kg/+GWq+ZQTCu0niVL6r8HQjqDLOXjFDoafai9/9JANyyxa0Q7dYV/xcGZB
         hHo4fZFtLFMFfifqsno+nQtWk52DrDZiTFckoba6tOR06le30ff8gZx9dVKwAoELDxmS
         7rYlqsIfs8UhYw2aKgsJBB2GFn9SpcmZ4Gr5trNaAhMP1WVx70+U5+ST153+nkOL5yqS
         yJhRVV/vOsD4pCqdLKBSgxODBkh7Gey/J3NwRxOvJUo6g1fyzjV/C+NyJFry8+H+BRWB
         7R84pMSxaOpdmj4YOYufFQ5xTqueV1VdOz4Z/dKrXowtsTZ4peT/Ysx9sPHB9PBi4SGN
         LIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8RPolM8OKTa75H3M3WcXwbohWQYOO0ChjLhp3KZb1ss=;
        fh=9qs7J2ij9l1jwcrECCkxzrXUjTRTgACkgSN7OSp4xq4=;
        b=IFwj+0h6FFBNHyfrzZg59ZPX5pwsAOLXDEg9qMTvyOCcCa6B/p1Oh+OfTB8pyNCP/c
         og4R8xK3X9CEZMNzm8x2vMTC9GC6Ny2dRsMub7KVPWoA/ojBSO0PiPjkpgM5586tE61b
         GX6bgF1BvUggXFL2n7AXbi+JQ1wMCoucL6J94f8iCg0pHJdvL8yKmfuRoE8/QoDUZdtX
         s4wpAvXUNiDCs2VtJmQp+eFBXWiC0xZVSXHWQaV3ajjYFmH4EgCWl6N6FgezFsNbvgsG
         5Ctjh082qfLo5KjfzIoGbUiNcjPhvbz8FaJuZRi56tgEVFlqv8GSAWxF3w8uWW9+zcYL
         HsFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789669866; x=1790274666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8RPolM8OKTa75H3M3WcXwbohWQYOO0ChjLhp3KZb1ss=;
        b=pP1HzVkyRxlQOnPuchG3cd3D/zWIrCa844olT4ZWSYL1w4NVL/oh0GOpPIXTn2NByF
         7zwj7chJyK99OJsWmaA/M3M7bKXlDrE99budWY9RwxI/F11chrS0RKGweouHIT4SFb1J
         H0PxOLsNfkUfIrPXJB/pqfP4hEbAHdB/5lr+Qaef3ICed96RW0xj0FZn8oEhCTPvWZ6v
         o7LOQtiHuaI9cuy6VkeTyLm+glzmyI9Y7xZ80QxlzpGsyvXhrd2ZjyxEWTq72Tdr8i0i
         sGabUHu/2vZbuAhUspflSjAlQYhrmeLnXawQmO1OGNKiT84KFEm/lSwIYZOYUiLHVvoR
         P4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669866; x=1790274666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RPolM8OKTa75H3M3WcXwbohWQYOO0ChjLhp3KZb1ss=;
        b=rj6KaJJKns2FZ2MnJ7Ewj4goAwVcVJgPVhdqq7NNHodo5SV+9olVoc37yWmO4Kt5se
         FZ3RO7cuG21NF52pYym8a4/eX0pieZh+ds3O0GLolnM2CqCvLmi0ZXPG9T1JNrg8vdgt
         2wwvze7mbuNvulQ6BNuHCJlPTeHGxT6v5gnAvkwZjeTbcqkFg0Ozfbho3V8maAkIZdtc
         v5f7bYZ0atpfA9GStIz5LNmEekOLGCAJ2VfjyKw2ZzjQb0arKccJqBV39SJ8wmJTRr/k
         2OW01NBo2jyEIYp0e7xn+C5V/mZkMiNTGxQpw1MJwzx1IT7dLpgwweYgJyTwkH9CMOPh
         6XnA==
X-Gm-Message-State: AFuF++n5DO/AvNllnGlryZVdlbUECoyEBiD20eDEA8su4RE0PiPjm3p3
	pgR88ESOvRDD/jgXC9yjSKPlTlDN90gY55l2ENtN2Pd+pXSiBgYceuvwDPpCCAXImB/30T7eW/r
	fpgvaUUVLjbV/lPGfsvbVDMeBolkpIjk=
X-Gm-Gg: AYBFou0GjMkrQVyYU7NSmzbFHYS1jHLSFf6klmnwuHWFaJz7r174HAk5vncSdzC3qbV
	JGdYUpvjMBa1PpSLUOhuSj4T9WRs/aFAV36m0gKT0rpn5g742tYK2rYRhA/XmwVyjb0NdnHcgoR
	gPUvRctWoMbJacSQEVDSBXBW+2k0n4/wM27PDs0ykmNozaHDeUzvGvI9Tict/VnAiiifJ/thnks
	OZp53GLDKA3tqRHCCJU4w9t5HBWa4fxc2MqSyg+lNvFytE8hKJavaqLS32lHV+q27AZ2kYmvmQC
	8icWeCW4Srd4HF5Mqa8mo1AjYVLHL3SULwl6Lrph1Wzktmme28bKON1SrElMKZTCc7ze7lzUGtQ
	sw2TEkC7Hdl2NSc8msW2yhAZhS2sjBiKYEvf0GZJrsRvih0YxhNgQVFJuYsWtHMheA9HFK3b8PT
	OV950wdMgh05dudkKl00yyMjCuonAYVAyY/Oy7dyizTKPu04/9SY13S8rWknX2HVVbTA==
X-Received: by 2002:a17:907:970d:b0:c29:f0ec:1c15 with SMTP id
 a640c23a62f3a-c2a156a3620mr7949566b.6.1789669866497; Thu, 17 Sep 2026
 11:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916223228.271815-1-rosenp@gmail.com> <1ce3192c-d052-4936-9567-8a1d9b13f54a@lunn.ch>
In-Reply-To: <1ce3192c-d052-4936-9567-8a1d9b13f54a@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 17 Sep 2026 11:30:55 -0700
X-Gm-Features: AcwNN1XeGBT2LML3tEiiSJsMDp-S3xnIEwQ82RWKi_fw7MBqF0hA3sGeCNcQuM4
Message-ID: <CAKxU2N-=0UiY6COZ7pAa-q-iBLT5nq-AosedqaUYC79jvtdA-g@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: fec_mpc52xx: remove dead resource size check
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:56=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 16, 2026 at 03:32:28PM -0700, Rosen Penev wrote:
> > The check bails out if the FEC register resource is smaller than
> > sizeof(struct mpc52xx_fec), but every in-tree device tree describes
> > the FEC node as a 0x400 byte region, which is exactly the size of the
> > struct, so the condition can never be true.
>
> We generally don't fully trust DT blobs.
>
> Does this test do any actual harm in its current state?
> Why remove it?
Previous discussion:

https://lore.kernel.org/netdev/20260518044047.1002235-1-rosenp@gmail.com/
>
>         Andrew
