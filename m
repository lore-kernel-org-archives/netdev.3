Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4F47F2E3
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935608; cv=pass; b=oC9y+XkiqYYwKle2HHcPJmtOw0uUBDFtjYA54JfW7Anx738Gn02mOLRjA/MzeuUuaNbufTCy/G0QQYgtQnrbg+HQzSj6ep9q5vwwoMkvLQPB9ey+Wjp4OD+EO7uE2UXghHk/aBWwFmOS2N80hRmgcyLcnfcbSFufxzBN84QsCXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935608; c=relaxed/simple;
	bh=hEO0vwKwrqlXZ4TAvYBOxFpw+P9Ek/EqQqPC11dV1ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7NoXyDmfv8ToD4xT0juWd6om1T7sH55KyvUOITnnXtIRo94qyT4jjQT/06bZpgzImivD1+H6q0zN2PKYVDStkyJTK7ng44PwwhkBEHa7agfJAz6r3q059tGR1DaypyNQZvlcobTWDSrgTtJkjZztzjDfrsoKbC+QdpPau9xoSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV/PN54K; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/PN54K"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a779b23f05so21259181fa.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935605; cv=none;
        d=google.com; s=arc-20260327;
        b=QXImSyg9PUOF6+dadZuPapA/iRPdFPDIlphNJEi1acFNrJeoyAjmzuj5MNLqVAF34l
         xoO2MJbawR0uCKyF5CcnNdIPMgw+b74PcRsyA+5aegrb4dtVSvYGuo/Fo4Xon6mbToEf
         FmYiyTTSkcHyEtv/0/samopgx27DtKq0oup/CnD7F7H6IX+fIXDtpAr0dcYBD7CsJs4B
         M89mHehElSQf/6qzklfe6q3cjhZDoislqC9kpLksyvixHCkhe0lCKw28P6EA8hDuP0F3
         i3y0PYdMmyTL2+5nliDm6aHDPNyM8ajy6eByjyFgPtM72WkOPbfE6/ZL7WnAYDOnLM7c
         8nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56xOfDITZcNEcJrgSxRUY3B7nxPxHMei30QaJ72H4oQ=;
        fh=QvhyS/xvXmOpURrM84bqZNzF5vg188LSxfNUKr2oyBk=;
        b=iztnG7qx6vIqFFDyCj1IvSIlUrch/7lLxAykEMFHQu7M35uA91v9iOslVLAapiMehz
         d3InK66xw8nWwekNeWjj15Tv1brbxHQNjCtD10Q1EoE/hUwd0AHZRkHt5ySJQ/XoCi8L
         lSvW5UVts8HgIj2LPzdpgVrOf3TjLJYsgnNcQxzGYsEfQBAnq9KSTqdXuVGeJ5Jp8I+I
         vac+34f9gG7i8IScbBRnOeLI+eeSxCp0P6pggfbyNG8UPGbU+WQHD+6leoeOE8117Yc2
         qmLP2NkgUgszSHdGpxRpc/QkULoSa8gkfqyLE1ftLgX9u7GKrSrITVvqKnFJ9UMVLsmw
         WMtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935605; x=1791540405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56xOfDITZcNEcJrgSxRUY3B7nxPxHMei30QaJ72H4oQ=;
        b=kV/PN54Kt/CFgtZWInPcN0fNRdr+/B5yZCGiB43z6g9Dpi+TG6/aCQCtph85JBw2d0
         BUoehj10Rpq6MXZ23tvdT6SucBtASmv7dx1IptvNnvXaVx6MZuaUVYul7L3xjKbuiSEv
         WSJFu30GVBculKOIHI1lSX8BUd+H34ET0bjxiaV1vl7hMv5ZbrDIL3yWl8iW3nINyeRW
         QLOP1ZRudK6pnft41ccPtQi7aAJQUUmP7Uwbvmlz+sP9gVEmOr3ANNdrC+ikZvwcMnWL
         +SMDj5BNxLo8cH/Ca1oMCXAxorlE91Epnl+Mkz3BUpd67npHl2kCrQH7N0bbNeiQ5wZT
         zwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935605; x=1791540405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56xOfDITZcNEcJrgSxRUY3B7nxPxHMei30QaJ72H4oQ=;
        b=s58eeBitpVP/F4VRfDSaij/UKQuYyWqSrI+pnrpq4MCBg9SnV0+vi9ylSMv+/5RVE3
         myHwZTdm8BGbKCIB+Bxfchrf1BgfiT/ZBA3yuWaZ4HfTkmwCSCcgdIwOxl+0XBB7hJZ6
         FRc3IU0jS1s5Tzu5kiQlJeiv+pysqdAqykCafSucVao8ajippRkB09o0Mfg4auUnnjx+
         Df03XW7ob862nNZeOKdEMXn8MUmiJqwsACCVArCzej4nsynYqYUxq0oDNoZGX2ZiVGHr
         m9iOW85EPLtE4HoMu8yud8n6IAzQm1V0eUaB/4DgIKBr7OJvv5cGbb+P/G8znCvWK3Tz
         Py3A==
X-Forwarded-Encrypted: i=1; AKwUvByJ5Jifp/j3TGvoCh+Bei/JpLu/5H1A+ae1yTFN6jEEb79HlCCcB6GAaaNsS3WNzGwr3wwf84s=@vger.kernel.org
X-Gm-Message-State: AFq9FYImBN8SqtGC7uDDxX/rzkZBBR/GUxP/g9miPdZhaqIPrxpD/aCf
	E50CFX0GfwNekZZqFogVb6o724rDCP34nEE4yAsEphjRRuO0u9bOE1cMOLu0xfB1jW7Gg0sQg0r
	4XFUrH82VDOrB2GuXmv0WoXc6GitMpF0=
X-Gm-Gg: AYBFou1WIA4lnfWlZbgfQnS5rBwEQYFCeJyFSVm5yiDcsDHwc2sE5kzeFQheVLbUkLP
	3THVqznJA6XemaWvn5hVzEnRyRQDh3FTV1EJyjk61XucM1aX6TwRebPm8kuenjYXoy+AO0C8O27
	dN4s2Az3KMv+j9GQ64Qy9DqRlm2pfdEtRumNxTmF2TgHGPyd/3+lCA9EzpStsCJjQaPpaB5phhp
	T/Ru+WnTct3/vzuyEFdQTmL1grgdqRTrtwqzdh/NZPwJlskF3cb3Bm03sGnnm0NQJXCQolXTskg
	j2gXNh778IH3vmlLGyFeYTuSZnCE3k8fJD02a+UqzOGfXGkwPdDcGxQBlPgl/Tcgdrk5/bRe6h0
	+cBQHTuSFBrn03ef2xnn3/Q==
X-Received: by 2002:a05:651c:31ce:b0:3a6:4e4d:9d1d with SMTP id
 38308e7fff4ca-3a87ec366b4mr5542271fa.0.1790935604459; Fri, 02 Oct 2026
 03:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-3-sigefriedhyy@gmail.com> <179089747937.434549.16341143363097629528@kernel.org>
In-Reply-To: <179089747937.434549.16341143363097629528@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 2 Oct 2026 19:06:34 +0900
X-Gm-Features: AclHuK8Nz_2jnmVTxCDn7TReanMq4quK1jlp8YMQzgl3WrXJWrYulmhcHHN9ymU
Message-ID: <CA+7S2vKBrjAMW5h_Dkpuy+TYum7m2=8GL1etaDx369ZSMRhHRA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/6] net: change netdev_hw_addr_list count
 through helpers
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Low] In the commit "net: change netdev_hw_addr_list count through
>   helpers", a new comment on struct netdev_hw_addr_list::_count in=E2=80=
=A6

Agreed, but they are nit, will fold them into v10 if another version is nee=
ded.
