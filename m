Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1836F90D
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331998; cv=pass; b=Jm5GYtYxuX6fwbda/z670blaanNO74Hv+0z8FZnBK84hYv4pbO3d+L8U2l3+N9UlwD92q9Oq9hEnUrzWw5n7Of7IUOfpHBgtkomsdQv+43XHGz/CXRmqxaadRHk1fVRjXang44tNWHTqW766ehZD1fZiE+E9+hp0sTP3K4XA9uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331998; c=relaxed/simple;
	bh=4TIZu3fYY90ZyFJn3Oy6Mv/sZIRvgaA/zzQxxb1e/CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNjOzpFEVdW/oDtTFdtP7T4wMPMGh4Tf1PDkplHt1yjDqXINW/rD+b3n9S7PlwswZajPqjKFSXaSwLA5fQ12oe9BC7lyoSROzO5Pr/55H9aDl/gq5ttso2fPz/jZBGpEJnLmaEH7qg+dMvuep1zQ7UVlKjM3kzCSAaV9QJzMf3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpQuozJ/; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpQuozJ/"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so197013966b.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789331993; cv=none;
        d=google.com; s=arc-20260327;
        b=HPGeaPCY9J4b/Qq6TR95j40jZWvTx3pMZFaQGWNmwkd39hlsX7paW3iaxIJHSGtaqz
         Z7UUfjHQOYC0V4YL+TWPVsaCuTfPOr5pD8YDHmZtBIIovcYySwbGKTyr7bCXT9PtD/UK
         /7sdjH7bQhFYmuaUrnQzkqeyX4W8UtREWDp4EaC0hGMARK1Peo4LL+a5tGQ3W/mTFTTS
         loWO9zf7S7hMFoS6d3+zp6rssiqjjlmoPZe2fRqrLJNALZVUL9FfCN9GEsZkOyop5nkA
         LzzJJOu+XfQHr65KFxG0KOCENbLAGHbLn23tOEZt97w1z7R/hJVJX7mnDnia4/vRrbgL
         4oHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F/g6G1QJpmcbX7ChC+iW3/9ptzGNtvNJ2UeRpHiTF20=;
        fh=0dwsxclnsAmQna8Rz2tCWupXG2juywwzbaZsJZ/KOLA=;
        b=KwY04yNlXvIqg8w1Lekai88xub9Q85hNBSP3fsqvLvExaMNVD9hJtjjndEuG5r1thx
         9udHPerL6O7FDi9d7z7LbUCQXGf2eX7YgunPnR80WcIo6p9blWxZfo04UAtbhPOY34cK
         zkq9l0De3h+uel/y8xGKdyO014l1EHR/qv9lXMdDRpkdoEJEnWRvowP7fXE+V1Bo3cD2
         VEXinJP8w5SrQAbIeSvKREeDQuY+jMO3K2G34VLtpZ/apSMti72Pwm0Deur5JtAltj0m
         fYBCbKsnKtjah8SDWwyZQALCn70ue351MFG/iiD1U75xO6LneEDNNiSHJPo0fYp2aWk0
         8dXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331993; x=1789936793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F/g6G1QJpmcbX7ChC+iW3/9ptzGNtvNJ2UeRpHiTF20=;
        b=lpQuozJ/IY1ZRz/TRVgteNqFwyTUsnBTiKcO99OSeEcOymmhQRTlKc/9PQdT1Ggp8H
         6/YhT2b8SfOUQxCzBMMyPeSuVcUXTQMvKDFwTE1ZJMe1Z0NRXxH5FRUkq0PrlwmTugqf
         61R7HmUyWMTi1J0UGUVk5y5z+ajIaxR7OcyHWZJ2T3TVfdmISlGokB1+3ZyO4Wc1JoeH
         rGdU3erEdPsJNaMqmKrPFY05SwnM7ZnBM5BljiMiPa4lCwoFKm6EUFva1uci8AmfzX74
         L12hCj9fcA2YzmUqUFdM8Xsmn+k2XVm+FW6dgYfmuyKo4VanLKyTb4av5xjLz3mF+/8E
         1xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331993; x=1789936793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/g6G1QJpmcbX7ChC+iW3/9ptzGNtvNJ2UeRpHiTF20=;
        b=lJgcw9gzRfZnWAlcCUoPqzZ4F9pkcZXDTdQjrn68l0q6bSlp/4LSuPQP+x2o6K7Eo5
         2BatN8yM+nREVtyZ+hOlVl8Q6ne1qBgva3f4sBNdYZR6+ZupkiDnttOOqW+7cRbH3arZ
         YG7iZIC9qZE0biwaPrVQT5aIfC5duHmhfeUCicw/kY2km/RO6T/Xlxfm/A5RETJO/1ka
         S0Hh4ouHtZKtgahL7NA8sQw7bO1acg7Wf+jgv4kQoXe5IgE6LcYBqw+3GU6YtB2spDMp
         Jy9bNKFpLAk2EF8ZtB+1q4QDRYCIvvpto8P5SMQi1r12dSXF09WaGNCgqJWCcuYk6ZAB
         j6kQ==
X-Forwarded-Encrypted: i=1; AKwUvBzflcg5ltrqtGsUqimoidv5ZLgK7SezbdL4RaOCTWq3kgHY4ki+PWMrFP1CTbcZ+nyNqT+Bul4=@vger.kernel.org
X-Gm-Message-State: AFuF++ntaOqiWps/38cZ2h9VGBzZVdNGV8G9DyIj19t/fJXAAEeZ2ExG
	Bz9R5zkeOFqgDi7ctJYEWt/xRV7uOyUvY86wL4YXddx6NZ4IwD+oS75d90AuX6W2mRkMQ2ns281
	4XaWDQWvUVaWyfamTl4FNHqPpJ9Cc5Q==
X-Gm-Gg: AYBFou0cv4HlgjBjLdU8mpbMcx7+9eSHU8c8ZhFZQx57EFrutIM1JFNt7vO2UETomyu
	1bDqkId6bbKKmSOwnrskRPf3HJsNjoP6kevDhVMgaRsoHLvvI98y+6g9XkMUxO+MOea1AxXP1/s
	8Db9AVCsz9ty9jVNLz5EcPXPAJ1RnW01Begfe/E/b5BczLO69/fvLtuIcqQDGvf03NJNFWp6SAs
	k47BqfIivii6IzYLvdwOOvbEjrzK9bbuNn7xwLSG8G90WbH+47BbvXXgLDo3uuyv7aOlA/6T293
	pI+JLftEPQoT2oxfWc0nBu8qpPnI8BmbcirGCU21CslOxCC8D7AKb7SM2QyE9x0uGRz8domBupX
	fTipVIdcs+7WTYQZz1qWrk4dxue3uKVqbm/WU9Q6gyvpKAhztwWbj4+05hv5sHL1a5Q==
X-Received: by 2002:a17:907:724c:b0:c25:ee92:2d0d with SMTP id
 a640c23a62f3a-c29857007famr452694366b.9.1789331993064; Sun, 13 Sep 2026
 13:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911033219.34566-1-mhun512@gmail.com> <20260913144635.GK48209@horms.kernel.org>
In-Reply-To: <20260913144635.GK48209@horms.kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 13 Sep 2026 16:39:41 -0400
X-Gm-Features: AcwNN1WXSyG3AyW6584G8j1Wr81DpX6Hfo7mLJKq1SiWGULXOiUL7zcRCXjlNAQ
Message-ID: <CAGEsz8G2N=To8-jvMvBRW5cP1wvjJfPQ84kqh5ObvB1bTv1Y+g@mail.gmail.com>
Subject: Re: [PATCH net] net/qla3xxx: Use managed PCI device enablement
To: Simon Horman <horms@kernel.org>
Cc: GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I'll keep the existing manual resource
management and add pci_disable_device() to ql3xxx_remove() in v2.

2026=EB=85=84 9=EC=9B=94 13=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:46, =
Simon Horman <horms@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Sep 10, 2026 at 11:32:19PM -0400, Myeonghun Pak wrote:
> > ql3xxx_probe() enables the PCI device and balances that reference on
> > probe failure. However, ql3xxx_remove() releases the mappings and PCI
> > regions without disabling the device, leaving the enable reference
> > held after unbind.
> >
> > Use pcim_enable_device() so the PCI device is disabled automatically on
> > probe failure and driver detach. Remove the explicit disable from the
> > probe error path to avoid disabling the managed device twice.
> >
> > Keep the existing manual cleanup of register mappings, PCI regions and
> > the netdev. These resources are released before the managed PCI disable
> > action runs.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> I think that rather than introducing the use of managed resource APIs
> to this driver, which is not encouraged in Networking code [1],
> the preferred approach would be to add a pci_disable_device() call
> to ql3xxx_remove().
>
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-m=
anaged-and-cleanup-h-constructs
>
>    "Using device-managed and cleanup.h constructs
>
>    "Netdev remains skeptical about promises of all =E2=80=9Cauto-cleanup=
=E2=80=9D APIs,
>     including even devm_ helpers, historically. They are not the preferre=
d
>     style of implementation, merely an acceptable one.
>
> --
> pw-bot: changes-requested
