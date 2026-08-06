Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEF40EB90
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005586; cv=pass; b=H6mrLMjn2a65P57DVRprrx/Yb8IIZVLUCyoKbztJEL0qPNpoFwMJraUdqe7CuhWKvDOvDqTxwxyadPpsxCYhkLMMhtrAIxNku6yBxkoLomjhnkpZZAUdEkQn5H+Rg14oixB++4uNaWzI3kOYK3befgTZEdEHy4I2gGUT0pi0GPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005586; c=relaxed/simple;
	bh=ZrlGBly2w9I91qr/1SJ3Zhk9ZEMsaEF2kMgaWaH8wKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOLhNHB+bsdwkjl4TUHjUcxAlHpwut/sa97hxfi0EiAsEZ+vU2tgW4oN3TXzGMu0kW57Hm7BnmL9+sfvLlr0vV6adpgKAQcOnQUU8nlmMgUYSlK4TJf5J4vTPQMT1Lc8tdTk/kzS1PI0aHBsFgYPs8IyhnxBAtZFMK0P/N4VwG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5kmKmQK; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5kmKmQK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8143daf89c7so18722907b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 01:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786005576; cv=none;
        d=google.com; s=arc-20260327;
        b=IFY/2II7IyaNWgXg7I0CTYhLG1dGBTxAeqxsU/l50MZsav1OsLNDtfae1R3L8O1TML
         DPxnCBK0xKIwpStq0V+KZMFpQo1IoYggnLLiAMOFEv0C4iKvC5bdTuWtfeka3TxHkEh9
         A6wj/9ZnulUEe1twbwfQJKWVYkkP2rqFgMkNoMjPin4IEuDZdjvBgDHwewk2ce1v/OiI
         5VsR7nzJNDN2sIWaVsSod1B2MuAYbJC2iTCDZFM10emgodYMIkoHq0bTmzNjiXgLNBw8
         9AMPvT5aOQkgVy5GkGlt8pBeUU//cEnQpy+gZwjSkkX9qxySDTuGtHoHVroZntM5RPQJ
         tzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLrRkorpj6YpQVJGbZEsM9fJtefgnIiicVEdkRzCUD0=;
        fh=m9w6pAcg2tGGlxNvu37fLvDmcVDly8DgExNJ2ojwoiI=;
        b=X2oB0msJFarCfUXWnR/rwd/OaofPuL2UtdqokftQOm/oY2D5owjhoCtEIrBdxvwhEp
         cmiZMO58jg0mSawCIdC95QC+0xhyvyjkXjx9lBmHCd/mr0UehtOVO4WBWKw9+mb9nWpE
         sgyYl+Fk/7ao+0tadFAyt3Y6EEKH7C3IRKSrAvcA0miK8FWqureMgCp0xF7Jw6w3geob
         G3pCN598ZXOcDbxKy967bF4eYX5u4tFRKO6+uPyg+HPqDt3PNdSVir31ymCNDjMrfmOC
         3kGj2k3LgX4Trsx2i1bsYsTmM9oPGXIxGgcVxBDvnmiZQ6UWfqa9gi4l2oVuSaMfxXCC
         ockQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786005576; x=1786610376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLrRkorpj6YpQVJGbZEsM9fJtefgnIiicVEdkRzCUD0=;
        b=X5kmKmQKWcjQL+p9ZY8xndslWBs8YVVJqn7/2efoY2ZDNjowWLgKKFE8ucz4QvpzR3
         hZdjfmdz0adlWakJEBScTLu2p2azxybZo6x8NsHOGS4BmXliuZGgB+oBUDQzkS9hJynl
         lOFryuH2BJRaNCZVaHl1CT35ZYclLWD6DtBGtWiHLtcEiPrWZ5FLhqCLOH37jiv30WO3
         wJpBvksJOTE6GwLMOXRrsfnJrPIazHqeCE2WtNBIaaNwErr7F1yoiDPYYRKNrElXMoSy
         Pw1hMwpWNzI4v2wwxAn1k8xildyzv3BvD+ZLEr9iIK6mFyfiDDqxWKnGc0APnpEDWlTa
         fVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786005576; x=1786610376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLrRkorpj6YpQVJGbZEsM9fJtefgnIiicVEdkRzCUD0=;
        b=XMI1Hjd45loJ7jnwtKpnasj8CRUjjqXBNuJ6gqrgS6W5aph40sTX9+chGx5MnzjP5s
         zqNLayJMqZxF7cFWf6wzT4WTKQD6y+uiOiZz8J9NVp2PvHK9LvxPOaKzSbONWCZSbKtI
         Jy6WZ0BPzRZ4RZrtduAf8W9OIM7klMerDbFxinGS/5IIwFH817BtZyzsa/eXcoH0/0Hx
         /0fD094P4UtMbQxwf14M28mbXDkfMrv7DNkdZy8S4pFj2vgJgJg1cxbkRvY3Kvi06aSz
         k1hRZofj7FuV6Oj8/eeK5HEAupuvYs+YD1hIb7SeCkgj9WnjfKG4yBFIUNTZ3+viz/Pa
         0YRw==
X-Forwarded-Encrypted: i=1; AHgh+RqG/iAdKlYraCiuSFRlyBmC4sii7r+SF/JmQqu1JRoqAlyna4aku625nMZwcgJ34JXzQZXjgCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytusAf4g+zNdf2ID57KAFp/M9jmQQKdhRvjJGIBJMTiyAkU1hI
	5yCyOVSI2YCUaebspX/f6XZ23pHZ0fRCEP99c3ct7XX6t9t8LNm0tyhoWTbHZA6Oi2YnkyRme/P
	lpvFEZvvdRckaIRjeNv5w1rlnBzYFGcE=
X-Gm-Gg: AR+sD13lUexHFeEqBDIujAm/SJv8dORjtGdgc+ZEc9liDOYua4jTDkM4gSauH6r5wjc
	LSrkwlY9moTXYqcNiscOsys+a/iwSTxOkcIvTHDXk9lxWzEGEdQUd8aJgIssSOKIHaRKtOes184
	k+yvKUXW/nL6jmk6vxZDi1vAp9BvfyeFxKj+b/ySiWxVdrACzzDSIs4BAT2p9LrxNfwDHBsFqsx
	/eBsYuiQ4opTrrAE3yAmpt+CfbtqE/EhW+fg0obdL49nTGZXMRLFieI7CjCo6PTJ4nf1Bb1niqr
	2JZNJFTYxvSXCTeecPuM68VEDhy/ExdfyitLMdY7vw7cP9XGoY1mDsXvlcN0NCDZucJfIrlfjps
	9P3WPZ3C4WmmWkWnBSI34AwjasE9tl/waQyjieLEBnh34MgaF+i1dF9pHflcyrRhPPWBYSGNbc1
	wO/OZPXFKk
X-Received: by 2002:a05:690c:45ca:b0:81e:d009:1956 with SMTP id
 00721157ae682-8201bcda7a6mr77377327b3.12.1786005575806; Thu, 06 Aug 2026
 01:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com>
In-Reply-To: <20260806073119.387-1-strst.gs@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 6 Aug 2026 10:39:24 +0200
X-Gm-Features: AUfX_mxhUREWMUFlWt3w9vuwEf7noJ47AUIHZbVbXd4YTWhoTaqT4PF0Fb6DwLQ
Message-ID: <CAOiHx==_5toBvQgvMckNiJoJi5k+i8yMehFZNpbyt_Bm5bemsg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 6, 2026 at 9:31=E2=80=AFAM Semih Baskan <strst.gs@gmail.com> wr=
ote:
>
> Since v5.15, a standalone port on a b53 switch cannot receive its own
> tagged traffic: the switch VID lookup is always active, an 8021q
> upper's VID never reaches the VLAN table, and every tagged frame
> resolves to an empty member set and is discarded. The common victim is
> a VLAN-tagged PPPoE WAN, where the PADI goes out and the tagged PADO
> never reaches the CPU.
>
> My first attempt disabled the VLAN table while not filtering:
>
>   https://lore.kernel.org/all/20260805072641.402-1-strst.gs@gmail.com/
>
> Jonas pointed out that this moves the ARL to shared VLAN learning and
> desynchronizes the hardware table from the bridge fdb, and I withdrew
> it. I then measured the alternatives on an RT-N18U (BCM53011 rev 5),
> with the outbound direction of the same link as a positive control on
> every run:
>
>   - With the table enabled, no ingress VID check setting delivers the
>     frame: VC4_NO_ING_VID_CHK, VC4_ING_VID_VIO_FWD and
>     VC4_ING_VID_VIO_TO_IMP all give 0, and clearing VC0_DROP_VID_MISS
>     changes nothing. The frame does not die at ingress admission, it
>     dies when forwarding resolves the VID against an empty member set.

Note that this is working on switches other than bcm5301x (at least on
bcm63268 and bcm53115), so this seems to be a bcm5301x specific issue.
Unfortunately I do not have a device with such a switch. Though it
only works for standalone ports, it does not allow forwarding between
ports.

Though this isn't the first time a bcm5310x issue showed up with
packets not properly trapped to CPU. Rafal, Florian, did you ever
figure out the issue?

It feels like there is something missing with the CPU port
configuration. Which port are you using as CPU port?

I see several device trees in-tree using port 5, but according to the
register definitions in OpenMDK, the only valid port for both BRCM_HDR
and GLOBAL_CONFIG's FRM_MGMT_PORT is imp0 / port 8 [1].

So I now wonder if using port 5 as CPU port only appears to work (i.e.
enabling the header does), but anything that is supposed to trap to
CPU tries to forward to 8, which is disabled. Or does not forward at
all, because the FRM_MGMT_PORT is configured to an invalid value.

In addition to that, I see that b53_brcm_hdr_setup() does not clear
GC_FRM_MGMT_PORT_M, so if it defaults/was programmed to anything
before, it may become a wrong value.

If you are using port 5 as CPU port, can you try switching to port 8 / gmac=
2?

>   - With the table disabled, a static fdb entry with VID 100 is lost
>     from the hardware ARL no matter how the driver drives the ARL
>     registers: keeping ARLTBL_IVL_SVL_SELECT at IVL does not preserve
>     it, and neither does additionally keeping the VID learning bits in
>     VLAN_CTRL0 set.

ARLTBL_IVL_SVL_SELECT is only implemented on bcm5302x / bcm58xx /
bcm53134 (and maybe some other newer switches), so no wonder it
doesn't do anything for you (it also has some additional dependencies
which aren't implemented in b53, so this is essentially dead code).

[1] https://github.com/Broadcom/OpenMDK/blob/v2.11.0/cdk/PKG/chip/bcm53010/=
bcm53010_a0_defs.h

Best regards,
Jonas
