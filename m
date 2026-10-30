Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368374;
	b=a83zgmMxoFjRbHKXV1f/yPjIMKv9fvR3WD+zDmozj0e59ZPxLhN/vsGC9K4h4DYEXph8
	 unpeZHweKZ+8a0huD8ZF/ZKA6FVSZXoutmQZSY+K3jDSAst25FPFGgz4FAolaDl+SXFPA
	 RiWEzwILxKJl1Eruo7j4MNRxRt5+mA6ifdjUwS8/x9Iov63Ns+kYhljbIOWvNV/2Okbm2
	 ivsmK3jSzGtexwNpUV89mC67K6fYlFxj+ZqtJB4n26lFWp36XIwY+wisUIujgsumZ0yPS
	 MhogGEErsee3+yTO2sxNpZZNtSLRup85D7QnfYtixwSEZ+wkhXtidhKqhlK8AU117iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZjCkrPgZkmpcI6klO5ZNTUrNouiYanWFs0XqwffC5jg=;
	b=GSVfjfd949QLkQ3t6y9myEMmPPeJ8CbdEXbypUMARj51ViigEJZsEvknt1EnnW338s6E
	 UEbHP2TvVK2XbR2bAkKX+64Z1iJttSwpsTwDlCk5DddjHQRJwStg3PzIN48r/JZ9Z2y8Q
	 JOcwxh3NkTb1xOq/p8xTxysUIuLKxY2k43ye7kDF9+OMscoLccGhJ3Jaw0jP/FK+iOo8a
	 83DD1RI/xQUj6R6OG2rltjpw9OTiYycxZQOEP3qq0MXpsQ6y885Vzk625R9CmdpVSdlk5
	 a43cqCf4x//m4PWwO8ePjjZPkLMrHSyV0IaeJNwj8zbHGU9ndW0cAHBG7KsdCk3CTig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPsIqfqY;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A6606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPsIqfqY
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2e7c8213b09so2571855ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368374; x=1793973174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZjCkrPgZkmpcI6klO5ZNTUrNouiYanWFs0XqwffC5jg=;
        b=vPsIqfqYMcWRJ4rbWkXml6kSp2q11qbyeDun1W7E6bhUpVVVssc9gIr9xqylNJ/yds
         FWrMGwOPW20Hnb2keBi9D4LHy1y8Ka8Hd/JAhescfVeSzRRioEzAz7VmN18KBsf/A5Du
         Y2xcki/wmNFKv5/lOd0J8L1JVUIaunqBtRq33IHQz9jRrNzXTRMw/8ctl9TVQMmb7mzI
         qvaSgwhIV4C8ZPbYRzlx32VqBhzOwiTVlpIaqSNcR0zPAcYs4jqTaeZcYde5ndYsmG6s
         syInukzz4SRS/yZUlrIo6TwgU/DyiEBgeM6sJFb4ZSHCx4eGUAmreqR8XGA0sHvYf8E8
         YT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368374; x=1793973174;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjCkrPgZkmpcI6klO5ZNTUrNouiYanWFs0XqwffC5jg=;
        b=LmZd086Ges92DrHgbsZDhuv4JXGQNRbMCVP3dEa6/qH+8vce0U2ldze5xUN8aazRMn
         bvvNFoDmoSO6nfxRNz1Mw4+5FhhmxnpOhuvPrh7M+fM7dgGaSvX6Ah93HkRuY8moZHco
         N+/Z0ABjN7l5EfDZ3EIkZ5GL6puT8g+rf8DxKkWs8DtEXazBgGIz2yJiuBIJjZlFHgPY
         AHpK/4Nw3ftVXDoiurLXA4CRNdPR06t6Hp2JBos6+KsiVpBLxK+H64Ckk9EKG660TSVE
         42y5avWxoEzyzduS+0pBfsMStTBPilJ/ae9Ii1ph1y+oRG/79q3pu64daI3JQUxFTYrF
         fOug==
X-Forwarded-Encrypted: i=1; AKwUvBwQQLlT2Wyd/WTSSl2Cidqk5mI9YiMYlwj5uCkJ0UL32CsCraGQRUZlaxSzJAHtKAbPXZ2m8Dw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo7mTdT8vR9gbh7D2D9WK7hyqfNt1UD1N/Ze/gJXvgWQ3BVQQ6
	gqHwP2dNBlAr5q/3GcfurWfx/ZYH3ZViuYgcv5YGYEetLffyuHpj2yG8
X-Gm-Gg: AYBFou2nb6FtZOV6ocdQn99msX9eM2rIZSso/gi8NNwoBiXXDKjdGbjSGbDJfMc+stB
	loM1LxL5Tu5/8MBczbEo4Ll4+iwIRL3+hPvhfCbYfDxw4g14J66Yot4fvzacO7cS3kb74LLMPBp
	1+vBik8TX2n/JOmvJrdMhX+vKNHzzCCXpemWZQP5E4IJ5K2WrK8Cm+oidPs7WU48RCtXcsAIPUX
	qSrfhZr1WJT6/3fxjP2laKSuN8012zf8yMi7Hai9a3hY3OJ/vtrKTnNa6yGWgWK3TBr7ATC3b3K
	jWeVAOngaueDRt+dFEUVeHUT+N9nYWOCRtEfR1NeBqibYMwYvJL4VZZonLSkd9534N12kcZywD4
	kVPe0Xa7fQbNaPWs/tkgk3/xvnO7jN/NO38i8ppujFSnI1twD8pZg0cdVyJrd4Igl7/2MH700KV
	pXmChbDurmrCQr4Aa8BF3OYTJl7ri73j+6ihOe9kttWfrFIwGGb8npvgeKLjz6yE83+nnvdMDiS
	nVsE3zy6vDzG0QJZbJxQCmxA5Fu7OlkSY8dDnKAfl0NpS6x2XUH2Dh1pXi18MwOtxIY/SnLdlQ2
	D0eZ4qGH3NW2OK+QPJMbQrk///3n22AWwLwGNpo=
X-Received: by 2002:a17:902:ffcf:b0:2e9:a782:bb82 with SMTP id d9443c01a7336-2eb364e93afmr22499015ad.54.1793368373608;
        Fri, 30 Oct 2026 06:52:53 -0700 (PDT)
Received: from ehlo.thunderbird.net ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb38e9633fsm7600865ad.0.2026.10.30.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:52:53 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:52:48 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_v2=5D_net=3A_pcs=3A_xpcs=3A_ma?=
 =?US-ASCII?Q?ke_supported=5Finterfaces_authoritative?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20fb8d2d-a20e-472b-8f32-3fe2fec9a425@lunn.ch>
References: <20261029102728.3189359-2-coiaprant@gmail.com> <20fb8d2d-a20e-472b-8f32-3fe2fec9a425@lunn.ch>
Message-ID: <A049E9C1-CE52-4B04-8BD4-44962D008F6D@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 29, 2026 9:20:56 PM GMT+08:00, Andrew Lunn <andrew@lunn=2Ech> wr=
ote:
>On Thu, Oct 29, 2026 at 06:27:29PM +0800, Coia Prant wrote:
>> pcs=2Esupported_interfaces is the mask of interfaces a given xpcs
>> instance actually supports=2E The compat table describes what the
>> Synopsys IP can do in general, but a specific integration may support
>> a different subset: the RK3568 XPCS supports 1000BASE-X, SGMII and
>> QSGMII in hardware, but does not implement the C73 10G or 2500BASE-X
>> modes that the Synopsys compat table advertises=2E
>>=20
>> The Rockchip glue currently advertises only SGMII, since that is what
>> the RK3568 MAC side supports today=2E 1000BASE-X and QSGMII can be adde=
d
>> later when the MAC side gains support=2E
>>=20
>> Without narrowing the mask, stmmac_phylink_setup() merges the PCS
>> supported_interfaces into the MAC mask with phy_interface_or(), so the
>> XPCS would contribute 1000BASE-X, 2500BASE-X, USXGMII and the 10G/25G
>> modes to the combined set=2E The MAC side forces the phy modes and
>> phylink start passes the mode explicitly, so this does not currently
>> make phylink switch to an unsupported mode, but the combined mask still
>> advertises interfaces the SoC cannot use=2E
>
>I don't know this code too well, but something does not feel right
>here=2E It might be due to the way stmmac does PCS with phylink, which
>is often considered broken=2E
>
>What i would expect to happen is that each piece of hardware indicates
>what it can do, and then phylink finds the common modes=2E
>
>So maybe stmmac_phylink_setup() is wrong when it ORs them together?
>
>Maybe look at other MAC drivers using pcs and phylink=2E
>
>      Andrew

Hi Andrew,

Thanks for the review=2E The comment is too terse, let me clarify the
scope of this patch=2E

The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII in hardware, but
the Rockchip glue advertises only SGMII for now because that is what
the RK3568 MAC side supports today=2E 1000BASE-X and QSGMII can be added
later when the MAC side gains support=2E

On the stmmac side: I agree the phy_interface_or() in
stmmac_phylink_setup() is not the usual intersect model, and it is one
of the reasons stmmac's PCS glue is often considered fragile=2E But the
DWMAC binding requires phy-mode globally (snps,dwmac=2Eyaml), so the
dwmac-rk glue gets a fixed mode from DT and phylink start passes that
mode explicitly=2E The OR-merged mask therefore does not currently make
phylink switch to a mode the SoC cannot use=2E

I've only been touching this area for the last few months, so I'm
guessing it may have been intentional=2E You might want to ask Russell
King, who designed the original logic, for the rationale=2E

This patch only touches the PCS side=2E It makes supported_interfaces
authoritative on the PCS instance, so xpcs_find_compat() does not
configure an interface the glue has marked as unsupported=2E Reworking
stmmac's OR-merge into a proper intersect model is a separate, larger
topic, and I'd rather not mix it into this fix=2E

Coia
