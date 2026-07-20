Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997930F54B
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561343; cv=none; b=JA4lcjZj//6bBocDQSSU4LOF5unaKLdt3XWTfTnCgSeiHlgWyiiQh5stNjKXELmuW+hkzBviSZFnBPc8GKOTBKewASBbUSzpHrHUOr23Cp/BzCjW08gBbYzu1l/geM27WkugcYgCEL/t4zZ7MOQYTZOAIF3m/omoNzlmMjJNjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561343; c=relaxed/simple;
	bh=U4t0Ha5aQQnsOVS92ULllJOo0551YVcY8yAgy7W+cCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Gnf2xQ3/tYhho0lLisu1xgci9bhrPtGq9/hr4XX0yQUbkZ06uhK82zztjU8GajL4NpxDVoKSm5UcmnlUZJX70yZXR5evFS5O+nmL7Sv4eOH2EvCDCJYDNF3E3OlM6qxfNpjpkBv3N1pyArXK3B//6Pd46afExnt0emV3d4H6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Dtr1Um0w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Dtr1Um0w"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso74790395ad.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784561339; x=1785166139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bgz7Y8qBkufWfij3p6tfrGVbR4yOWWu3669don02deQ=;
        b=Dtr1Um0w/oWIyzhdaNI0QsziU7fR3S+W4AqMHN35hRZoT5/0T7oSHHFxTEd/bQz/iQ
         3UWPLEWdM/shxQUmxZzIz+Ny+OpCbAmZpLNQHbsankXrTgzVBG3b2c6TIB0N4S9MWRA7
         lsbfHdePxTW2ILTVYAuXm8oFtyKJYlboUaPSgZK7vhqj7qCgflb4FUALC3+G203zjakp
         VZFAnBShnzqxeSFXKwhqg7+/ZPu13JjBqKXE33ZktYN9CmeXWIHDMgtDX/AHqWDq5+Nv
         VYtbj5ed/MDewOilvz8KZDxO+MlnwlCPKqcNL/30PM/CVdxrFfy1olo174YYPi4nq4Jp
         Rzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561339; x=1785166139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bgz7Y8qBkufWfij3p6tfrGVbR4yOWWu3669don02deQ=;
        b=UeGGVkX5Yt0nGLp9S2OfCsPEZpSdSIWdFAg0Pdiy7vbD7sxouz5XO5XvQoGRKqGx5J
         Z/97Nw+4rLatJmDLUa8WcwIZ+/sKpSpNtKq/98guz56MkVQMyVAmW4q5fZ3TiAZ8DL4R
         qNVdRtHL+lkg+LfEkToPCWYFb6pRWUAJAy4rrKgjs+/vafqkvXD05a2LjUPoMdLO/I7y
         21fk+gvrrtYztG/2IStEISO5gTlaLwvsZq5VE3SIzcdEoIsQ7EMiAZ0sqcNi6sPFd9xA
         ztDk27dC02HST39PiAUPuhSK2/MMCgVuN7XVm3q27P+BXWfe1z2ckHkUHtTIbo+/5+Ov
         9bHw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2a5sxSgY1DrCzQ34UefkDbNTeEZa/hSx3v5uKgcE+Br2DTVEhrRrPICQI4HXdY6a6FTcDDA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kpwMZkG75N9vKO4kIua8ZEgO8031faVI7jNnvJ8ZLOv0G1tr
	UP0qOki5TJ/FTD1nfQPE42d8RTQOuc04NT6wNjD5Tb/lO3F7RNqOyI0V8StoWtGB7II=
X-Gm-Gg: AR+sD12o/kbrL+5q1RUgmslkV0/6WA0IBqMyCgHBOm2MnqE/bdj1TomDd7xxEnUL26h
	qT1UBZDrArggZPTfHWVtUrxNYqnmvxDr1S4rTh1ugJjIZpYBrX9SiF5iROoo9ShPMVdWPXyVEif
	Vddz22wRE/Wm1Dv84Yr3chZFYA1F7dfKRNg4wmLEq4hZS+CfkG8pHRrYWjiW9kY/AZuFHa5SuaT
	hOVG73VYEowoClXqjKhNHQ2x5oCuf9QkCy05dggRwASZ78l/aRCgTLdv2vAXnuMZ8wFygtb35on
	LYQ44/qhQTfVwVr6E3yjjgR4S4fRsv8xco3mmIZZAJ9gmLQqRLTbcnfoQ7qD2omr7vHoS1sLMGG
	T4DX91Us9WW8ZTXdIITAK86/uHKeOaL9Xq9xwiHAW/wxsDyinTDBMhnkbnZ4=
X-Received: by 2002:a17:903:1b25:b0:2ca:3b31:ef4f with SMTP id d9443c01a7336-2cf34a0a6b5mr140652465ad.40.1784561339559;
        Mon, 20 Jul 2026 08:28:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm58695305ad.64.2026.07.20.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:28:58 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:28:58 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 11/14] net: enetc: move
 enetc_set_si_vlan_promisc() to enetc_pf_common.c
Message-ID: <al4+uiiXKgaNBa91@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-12-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-12-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:13AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
> PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
> mode for SI n. The only difference between the two hardware generations
> is the register address offset.
> 
> Since the register functionality is identical, the VLAN promiscuous mode
> setting code can be shared between ENETC v1 and v4 drivers.
> 
> Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
> and export it so that it can be shared between the two drivers. Add a
> revision check using is_enetc_rev1() to select the correct register
> offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
> the same logic.
> 
> Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
> and replace its call site with the new common enetc_set_si_vlan_promisc()
> to eliminate code duplication.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 17 ++------------
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
>  .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
>  .../freescale/enetc/enetc_pf_common.h         |  1 +
>  4 files changed, 25 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
