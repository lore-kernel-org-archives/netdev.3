Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD02931F2
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728612; cv=none; b=pKGnsi+KaFsgxYiCFG1JDGV6I1PgpWeVvwK29I+0J92M/exp+JiXsrmUeMQ3mgArhQwePOEdSq1qzLFLsgyC1MwONdrNojJDTxUD0KLstyPkKT2NTIT2jskubFeBzp8hRiH6c3c+mijBwltU/+nHcCeCrDQRdrz6OB2u4WJ3wvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728612; c=relaxed/simple;
	bh=HlQy9lG4oAWvBTINQPKtqjXM14hS5iTctc/NgAcI/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrtFlHateboXtd0uvSjmHANjKgZApD52N14RgXt8jWJRtgBgb7t70DhE01UtgmaQFk6etAUXhW5fMWRhJ/mAhsDGBuG1LuZRZ/ahnGApj7ZCkNS2EJzGaTf+sX8udBAUbbIa03JHKJSGJnY91f+9Z5rvCaOBsAcM50WXMJlA2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533861a59b8so14912451cf.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728610; x=1792333410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66qeQFvPa1OLNzA9zOG/eSFE0YAdZbwXEI8cdDv4Aes=;
        b=hFnoXK/sWrJsVqcjaSjgKaJ40IEDQu4zyx5479bvgHEYATOyS3NGJTIScwJ1K84yS6
         rLB7/hUN34QGccDUmzRLvlgZxUbTCRApwhYleFxH7FqdbxY5UD+Jc3eAR902gzs8lL+t
         0mSAmUboEVOj+Vd7mjRX4nirtBJnnYIP/pGdVS09Bc5hQT2ynuMufDvYsLSiZa9NJUJ5
         inmTuhoT4b7Z3nQ0VlfqWPVQchrPCOi9MDooDwocczmrwywKdLUvj+GTr2s0cA3UPdKI
         DIEqZy/9OBPwaKAIxwDZRx+tganw4ZIsPYmhZEBt1NBqrOCMnuRzszyE+WmdB1WvZ+kG
         Y1ww==
X-Forwarded-Encrypted: i=1; AKwUvBzZT/VaK6rov3gClrHoZm2Vry+yzSk9DZQf9W1OoEOWRLIRnM9kIvaGEnfokaXqgK0eX/qNysU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8vFF4dgB+ui4BoKun4YJ1vPbdH7bkGEGQv3KPVy6m5fhmSM1A
	d1EzNySXU+3yBOWn5Vk9uf3FCpBZJ6SDU/u2G2Xj+7LuEvnu54wpjBIw2MeZ+m0BibM=
X-Gm-Gg: AYBFou24mznEgYmm6UcUh9av2+PiqzMQlNhctx3r89loYleLafjfX1spPV31T76jItL
	D+ed8NGpjObeqc/sLP4xHdINUccl8+r8N9EzC3S/927DLSyefB4ywzObwTQV2TcoRiWY/AnapBo
	xdKKiVauQaPfEru0aZ6eH2bkSEa/a7pHANj1bX7HqN4lNwwZhthrnCq9ntxWPBQCA9eh1Xov/zE
	GaQwNjj652daYyRw2ENPG8T6flYRlFbF2KFZg33SMEXq6ydCzN8VFbk4u8rI2fgbpvpK7l0hPXD
	N2I38wUvd72LC7jrBeI4Yv9iO8A8cGGe36uoCLx4FJ6Xs/QXK0qJedPp7NUyr2Ku3MPnkM1ya87
	ZIXsrENQlq6GeB3yt7r5KP6qh7m1t/3WWXebW9ipvSEcJxwsfyXnW7MbXQX1RgBhlVZMvZsDPuw
	rReecgp40IzhkSuDAi4ydBKP9jOXYLbdslkNWB08ZAdkJN1GxSMk8SmxrOdhsC3D+b+N9sJ6pg9
	9fBp3n1dClwT6FCxKD1AzN6zoA8XAw1806CCD6iRLifqq0aqU0Qh8pHK9qpkoJl1fU7kT/SnpuY
	jg==
X-Received: by 2002:a05:622a:513:b0:535:33a:c75d with SMTP id d75a77b69052e-5359fb2eaaamr126787871cf.32.1791728610023;
        Sun, 11 Oct 2026 07:23:30 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7a34b5sm59642731cf.22.2026.10.11.07.23.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 07:23:29 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so14912341cf.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw0jCGzm5XGeWQ2Imdrihb2t5tcutZEXPsMN31VUZtNUd5rL+iAgL4xqRmexr+OAVMhizYkLhY=@vger.kernel.org
X-Received: by 2002:a05:690c:a78a:b0:87e:2404:45fc with SMTP id
 00721157ae682-8b07ee0119bmr12804267b3.53.1791728189975; Sun, 11 Oct 2026
 07:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-2-tanure@linux.com>
 <CAFBinCAejxmeeHyDy+vMSg6dBm+9prhEo9qZ7FAsiWNB1W-HXw@mail.gmail.com>
In-Reply-To: <CAFBinCAejxmeeHyDy+vMSg6dBm+9prhEo9qZ7FAsiWNB1W-HXw@mail.gmail.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Sun, 11 Oct 2026 15:16:18 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3JLn6oTt8qTPM-muKsY9JbTEMwqRvbamZ3vqg_Yymsmg@mail.gmail.com>
X-Gm-Features: AclHuK_1GqFe_9xMchzTuN-zUjY9-HZS8dq9HbxopbZkfG1FPjpin79NLsfNCvI
Message-ID: <CAJX_Q+3JLn6oTt8qTPM-muKsY9JbTEMwqRvbamZ3vqg_Yymsmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: net: amlogic,meson-dwmac: list the
 compatible combinations
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 11:04=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Lucas and Conor,
>
> On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> =
wrote:
> [...]
> > +          - enum:
> > +              - amlogic,meson8b-dwmac
> > +              - amlogic,meson-gxbb-dwmac
> > +              - amlogic,meson-axg-dwmac
> > +              - amlogic,meson-g12a-dwmac
> > +          - const: snps,dwmac-3.70a
> > +          - const: snps,dwmac
> > +      - items:
> > +          - enum:
> > +              - amlogic,meson6-dwmac
> > +              - amlogic,meson8m2-dwmac
> Meson8m2 dwmac reports: User ID: 0x10, Synopsys ID: 0x37
> In case it helps I can submit a patch to change the Meson8m2 .dtsi to
> use "amlogic,meson8m2-dwmac", "snps,dwmac-3.70a", "snps,dwmac" - then
> we could move it here too.
> That leaves only Meson6 with a single fallback compatible. I don't
> have any Meson6 boards, so it'll have to stay that way.
Hi,

Fine by me. But I think it is best to wait for this series to be merged.
Lucas

>
>
> Best regards,
> Martin
